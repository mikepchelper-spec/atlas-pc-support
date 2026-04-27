# ============================================================
# Invoke-Personalizacion  ->  Windows Tweaks
#
# i18n: Option A (en default + full es secondary). Function name
# kept as Invoke-Personalizacion for tools.json compatibility.
#
# Atlas PC Support
# ============================================================

function Invoke-Personalizacion {
    [CmdletBinding()]
    param()
<#
    .SYNOPSIS
    ATLAS PC SUPPORT - Windows Tweaks
    .DESCRIPTION
    Personalization tweaks via registry and Win32 API (wallpaper, dark
    theme, accent, taskbar, watermark, Win11 minimal mode).
#>

# --- Language detection ---
function _Atlas-DetectLang {
    if ($env:ATLAS_LANG) { return [string]$env:ATLAS_LANG }
    try {
        $cfg = Join-Path $env:LOCALAPPDATA 'AtlasPC\config.json'
        if (Test-Path -LiteralPath $cfg) {
            $obj = Get-Content -Raw -LiteralPath $cfg -Encoding UTF8 | ConvertFrom-Json
            if ($obj.language) { return [string]$obj.language }
        }
    } catch {}
    $sys = (Get-Culture).TwoLetterISOLanguageName
    if ($sys -eq 'es') { return 'es' }
    return 'en'
}

$T = @{
    en = @{
        WindowTitle    = 'ATLAS PC SUPPORT - WINDOWS TWEAKS'
        Brand          = '          ATLAS PC SUPPORT                '
        Sep            = '=========================================='
        MenuTitle      = 'WINDOWS TWEAKS MENU'
        Wallpaper1     = 'Wallpaper applied (Win32 API).'
        WallpaperErr   = 'Error calling Win32 API.'
        WallpaperMiss  = 'Error: image not found at: {0}'
        DarkApplied    = 'Dark theme applied.'
        DarkErr        = 'Error applying theme.'
        AccentApplied  = 'Accent color updated.'
        AccentErr      = 'DWM error.'
        TaskbarApplied = 'Taskbar settings applied.'
        RestartingExpl = 'Restarting Explorer...'
        TaskbarErr     = 'Taskbar error.'
        SearchHidden   = 'Search bar hidden.'
        WidgetsHidden  = 'Widgets and Teams chat hidden.'
        TaskbarLeft    = 'Taskbar aligned left.'
        Win11Header    = 'Win11 Minimal mode applied:'
        Win11Bullet1   = '  - Taskbar left'
        Win11Bullet2   = '  - Search hidden'
        Win11Bullet3   = '  - Widgets hidden'
        Win11Bullet4   = '  - Teams chat hidden'
        WatermarkOff   = 'Watermark disabled (reboot required).'
        RegistryErr    = 'Registry error.'
        StartSuggOff   = 'Start menu suggestions disabled.'
        Opt1           = '[1] Change Wallpaper (local Wallpaper.jpg)'
        Opt2           = '[2] Force Dark Theme (Apps & System)'
        Opt3           = '[3] Apply ATLAS Accent Color (Gold)'
        Opt4           = '[4] Align Taskbar left + hide search (legacy)'
        Opt5           = '[5] Hide Watermark (PaintDesktop)'
        Opt6           = '[6] Disable Start menu suggestions'
        OptHeaderWin11 = '--- WIN11 MINIMAL ---'
        Opt7           = '[7] Only: Align Taskbar left'
        Opt8           = '[8] Only: Hide Search bar'
        Opt9           = '[9] Only: Remove Widgets + Teams Chat icon'
        OptA           = '[A] MINIMAL MODE (taskbar+search+widgets+chat in one)'
        Opt0           = '[0] Back / Quit'
        SelectOpt      = 'Select option:'
        ErrorPrefix    = 'Error: '
    }
    es = @{
        WindowTitle    = 'ATLAS PC SUPPORT - PERSONALIZACION AVANZADA'
        Brand          = '          ATLAS PC SUPPORT                '
        Sep            = '=========================================='
        MenuTitle      = 'MENU AVANZADO DE PERSONALIZACION'
        Wallpaper1     = 'Fondo aplicado correctamente (API Win32).'
        WallpaperErr   = 'Error al llamar a la API.'
        WallpaperMiss  = 'Error: no se encuentra la imagen en: {0}'
        DarkApplied    = 'Tema Oscuro aplicado.'
        DarkErr        = 'Error al aplicar tema.'
        AccentApplied  = 'Color de acento modificado.'
        AccentErr      = 'Error en DWM.'
        TaskbarApplied = 'Configuracion de barra de tareas aplicada.'
        RestartingExpl = 'Reiniciando Explorer...'
        TaskbarErr     = 'Error en Taskbar.'
        SearchHidden   = 'Barra de busqueda ocultada.'
        WidgetsHidden  = 'Widgets y Chat de Teams ocultados.'
        TaskbarLeft    = 'Taskbar alineada a la izquierda.'
        Win11Header    = 'Modo Minimalista Win11 aplicado:'
        Win11Bullet1   = '  - Taskbar izquierda'
        Win11Bullet2   = '  - Busqueda oculta'
        Win11Bullet3   = '  - Widgets ocultos'
        Win11Bullet4   = '  - Chat de Teams oculto'
        WatermarkOff   = 'Marca de agua deshabilitada (requiere reinicio).'
        RegistryErr    = 'Error en registro.'
        StartSuggOff   = 'Sugerencias de inicio deshabilitadas.'
        Opt1           = '[1] Cambiar Fondo (Wallpaper.jpg local)'
        Opt2           = '[2] Forzar Tema Oscuro (Apps & Sistema)'
        Opt3           = '[3] Aplicar Color Acento ATLAS (Dorado)'
        Opt4           = '[4] Alinear Taskbar izquierda + ocultar busqueda (original)'
        Opt5           = '[5] Ocultar Marca de Agua (PaintDesktop)'
        Opt6           = '[6] Deshabilitar sugerencias Menu Inicio'
        OptHeaderWin11 = '--- WIN11 MINIMAL ---'
        Opt7           = '[7] Solo: Alinear Taskbar a la izquierda'
        Opt8           = '[8] Solo: Ocultar barra de Busqueda'
        Opt9           = '[9] Solo: Quitar Widgets + icono Chat Teams'
        OptA           = '[A] MODO MINIMAL (taskbar+search+widgets+chat en uno)'
        Opt0           = '[0] Volver / Salir'
        SelectOpt      = 'Seleccione opcion:'
        ErrorPrefix    = 'Error: '
    }
}
$lang = _Atlas-DetectLang
if (-not $T.ContainsKey($lang)) { $lang = 'en' }
$L = $T[$lang]

# ==========================================
# CONSOLE & WIN32 SETUP
# ==========================================
$Host.UI.RawUI.WindowTitle = $L.WindowTitle
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

# C# wrapper for SystemParametersInfo (wallpaper trick)
$code = @'
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    public const int SPI_SETDESKWALLPAPER = 0x0014;
    public const int SPIF_UPDATEINIFILE = 0x01;
    public const int SPIF_SENDWININICHANGE = 0x02;

    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
'@
Add-Type -TypeDefinition $code

# ==========================================
# UI HELPERS
# ==========================================
function Write-Centered {
    param([string]$Text, [ConsoleColor]$Color = "White")
    $WindowWidth = $Host.UI.RawUI.WindowSize.Width
    $Padding = [math]::Max(0, [int](($WindowWidth - $Text.Length) / 2))
    Write-Host (" " * $Padding) -NoNewline
    Write-Host $Text -ForegroundColor $Color
}

function Show-Header {
    Clear-Host
    Write-Host "`n"
    Write-Centered $L.Sep "Yellow"
    Write-Centered $L.Brand "Yellow"
    Write-Centered $L.Sep "Yellow"
    Write-Host "`n"
}

# ==========================================
# ACTION FUNCTIONS
# ==========================================

function Set-AtlasWallpaper {
    param([string]$PathImagen)
    if (Test-Path $PathImagen) {
        try {
            [Wallpaper]::SystemParametersInfo(0x0014, 0, $PathImagen, 0x01 -bor 0x02)
            Write-Centered $L.Wallpaper1 "Green"
        } catch {
            Write-Centered $L.WallpaperErr "Red"
        }
    } else {
        Write-Centered ($L.WallpaperMiss -f $PathImagen) "Red"
    }
}

function Set-DarkTheme {
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        Set-ItemProperty -Path $RegPath -Name "AppsUseLightTheme" -Value 0 -Force
        Set-ItemProperty -Path $RegPath -Name "SystemUsesLightTheme" -Value 0 -Force
        Write-Centered $L.DarkApplied "Green"
    } catch { Write-Centered $L.DarkErr "Red" }
}

function Set-AccentColor {
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\DWM"
        Set-ItemProperty -Path $RegPath -Name "AccentColor" -Value 0xffd700 -Force
        Set-ItemProperty -Path $RegPath -Name "ColorPrevalence" -Value 1 -Force
        Write-Centered $L.AccentApplied "Green"
    } catch { Write-Centered $L.AccentErr "Red" }
}

function Optimize-Taskbar {
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Set-ItemProperty -Path $RegPath -Name "TaskbarAl" -Value 0 -Force
        Set-ItemProperty -Path $RegPath -Name "SearchboxTaskbarMode" -Value 0 -Force
        Write-Centered $L.TaskbarApplied "Green"
        Write-Centered $L.RestartingExpl "Yellow"
        Stop-Process -Name "explorer" -Force
    } catch { Write-Centered $L.TaskbarErr "Red" }
}

function Hide-SearchBar {
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
        if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
        $Adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Set-ItemProperty -Path $Adv -Name "SearchboxTaskbarMode" -Value 0 -Force
        Write-Centered $L.SearchHidden "Green"
        Write-Centered $L.RestartingExpl "Yellow"
        Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    } catch { Write-Centered ($L.ErrorPrefix + $_.Exception.Message) "Red" }
}

function Hide-Widgets {
    try {
        $Adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Set-ItemProperty -Path $Adv -Name "TaskbarDa" -Value 0 -Force
        Set-ItemProperty -Path $Adv -Name "TaskbarMn" -Value 0 -Force
        $Feed = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds"
        if (-not (Test-Path $Feed)) { New-Item -Path $Feed -Force | Out-Null }
        Set-ItemProperty -Path $Feed -Name "ShellFeedsTaskbarViewMode" -Value 2 -Force
        Write-Centered $L.WidgetsHidden "Green"
        Write-Centered $L.RestartingExpl "Yellow"
        Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    } catch { Write-Centered ($L.ErrorPrefix + $_.Exception.Message) "Red" }
}

function Align-TaskbarLeft {
    try {
        $Adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Set-ItemProperty -Path $Adv -Name "TaskbarAl" -Value 0 -Force
        Write-Centered $L.TaskbarLeft "Green"
        Write-Centered $L.RestartingExpl "Yellow"
        Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    } catch { Write-Centered ($L.ErrorPrefix + $_.Exception.Message) "Red" }
}

function Apply-Win11Minimal {
    try {
        $Adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Set-ItemProperty -Path $Adv -Name "TaskbarAl" -Value 0 -Force
        Set-ItemProperty -Path $Adv -Name "SearchboxTaskbarMode" -Value 0 -Force
        Set-ItemProperty -Path $Adv -Name "TaskbarDa" -Value 0 -Force
        Set-ItemProperty -Path $Adv -Name "TaskbarMn" -Value 0 -Force
        $Feed = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds"
        if (-not (Test-Path $Feed)) { New-Item -Path $Feed -Force | Out-Null }
        Set-ItemProperty -Path $Feed -Name "ShellFeedsTaskbarViewMode" -Value 2 -Force
        Write-Centered $L.Win11Header "Green"
        Write-Centered $L.Win11Bullet1 "Green"
        Write-Centered $L.Win11Bullet2 "Green"
        Write-Centered $L.Win11Bullet3 "Green"
        Write-Centered $L.Win11Bullet4 "Green"
        Write-Centered $L.RestartingExpl "Yellow"
        Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    } catch { Write-Centered ($L.ErrorPrefix + $_.Exception.Message) "Red" }
}

function Toggle-Watermark {
    try {
        $RegPath = "HKCU:\Control Panel\Desktop"
        Set-ItemProperty -Path $RegPath -Name "PaintDesktopVersion" -Value 0 -Force
        Write-Centered $L.WatermarkOff "Green"
    } catch { Write-Centered $L.RegistryErr "Red" }
}

# ==========================================
# MAIN LOOP
# ==========================================
$ejecutar = $true
$ScriptPath = if ($env:LOCALAPPDATA) { Join-Path $env:LOCALAPPDATA 'AtlasPC' } else { $env:TEMP }
if (-not (Test-Path $ScriptPath)) { New-Item -ItemType Directory -Path $ScriptPath -Force | Out-Null }

while ($ejecutar) {
    Show-Header
    Write-Centered $L.MenuTitle "Cyan"
    Write-Host "`n"

    $M = " " * ([int](($Host.UI.RawUI.WindowSize.Width / 2) - 20))

    Write-Host "$M $($L.Opt1)"
    Write-Host "$M $($L.Opt2)"
    Write-Host "$M $($L.Opt3)"
    Write-Host "$M $($L.Opt4)"
    Write-Host "$M $($L.Opt5)"
    Write-Host "$M $($L.Opt6)"
    Write-Host "$M $($L.OptHeaderWin11)" -ForegroundColor Cyan
    Write-Host "$M $($L.Opt7)"
    Write-Host "$M $($L.Opt8)"
    Write-Host "$M $($L.Opt9)"
    Write-Host "$M $($L.OptA)" -ForegroundColor Green
    Write-Host "`n"
    Write-Host "$M $($L.Opt0)" -ForegroundColor Gray
    Write-Host "`n"
    Write-Centered $L.SelectOpt "Gray"

    $sel = Read-Host

    switch ($sel) {
        '1' {
            Set-AtlasWallpaper -PathImagen "$ScriptPath\wallpaper.jpg"
            Start-Sleep 2
        }
        '2' { Set-DarkTheme; Start-Sleep 1 }
        '3' { Set-AccentColor; Start-Sleep 1 }
        '4' { Optimize-Taskbar; Start-Sleep 2 }
        '5' { Toggle-Watermark; Start-Sleep 1 }
        '6' {
             Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0 -Force
             Write-Centered $L.StartSuggOff "Green"
             Start-Sleep 1
        }
        '7' { Align-TaskbarLeft; Start-Sleep 2 }
        '8' { Hide-SearchBar;   Start-Sleep 2 }
        '9' { Hide-Widgets;     Start-Sleep 2 }
        { $_ -in 'A','a' } { Apply-Win11Minimal; Start-Sleep 2 }
        '0' { $ejecutar = $false }
    }
}
}
