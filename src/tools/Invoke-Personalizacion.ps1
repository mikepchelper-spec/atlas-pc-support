# ============================================================
# Invoke-Personalizacion
# Migrado de: MOD.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-Personalizacion {
    [CmdletBinding()]
    param()
<#
    .SYNOPSIS
    ATLAS PC SUPPORT - CORE LOGIC
    .DESCRIPTION
    Implementación técnica de personalización vía Registro y API Win32.
#>

# ==========================================
# CONFIGURACION INICIAL Y API
# ==========================================
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - PERSONALIZACION AVANZADA"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

# Definición C# para llamar a SystemParametersInfo (EL TRUCO para el Wallpaper)
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
# FUNCIONES DE INTERFAZ (UI)
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
    Write-Centered "==========================================" "Yellow"
    Write-Centered "          ATLAS PC SUPPORT                " "Yellow"
    Write-Centered "==========================================" "Yellow"
    Write-Host "`n"
}

# ==========================================
# FUNCIONES LOGICAS (EL CEREBRO)
# ==========================================

# 1. Fondo de Pantalla (API SystemParametersInfo)
function Set-AtlasWallpaper {
    param([string]$PathImagen)
    if (Test-Path $PathImagen) {
        try {
            [Wallpaper]::SystemParametersInfo(0x0014, 0, $PathImagen, 0x01 -bor 0x02)
            Write-Centered "Fondo aplicado correctamente (API Win32)." "Green"
        } catch {
            Write-Centered "Error al llamar a la API." "Red"
        }
    } else {
        Write-Centered "Error: No se encuentra la imagen en: $PathImagen" "Red"
    }
}

# 2. Tema Oscuro (Registro)
function Set-DarkTheme {
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        Set-ItemProperty -Path $RegPath -Name "AppsUseLightTheme" -Value 0 -Force
        Set-ItemProperty -Path $RegPath -Name "SystemUsesLightTheme" -Value 0 -Force
        Write-Centered "Tema Oscuro aplicado." "Green"
    } catch { Write-Centered "Error al aplicar tema." "Red" }
}

# 4. Color de Acento (Registro DWM)
function Set-AccentColor {
    # Establece un color Cian/Turquesa estilo Atlas (Formato ABGR Decimal o Hex)
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\DWM"
        # 0xffd700 es dorado en formato DWORD (ejemplo)
        Set-ItemProperty -Path $RegPath -Name "AccentColor" -Value 0xffd700 -Force 
        Set-ItemProperty -Path $RegPath -Name "ColorPrevalence" -Value 1 -Force
        Write-Centered "Color de acento modificado." "Green"
    } catch { Write-Centered "Error en DWM." "Red" }
}

# 5. Barra de Tareas (Registro Explorer)
function Optimize-Taskbar {
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        # TaskbarAl: 0 = Izquierda, 1 = Centro (Windows 11)
        Set-ItemProperty -Path $RegPath -Name "TaskbarAl" -Value 0 -Force
        # Ocultar iconos de busqueda para limpiar
        Set-ItemProperty -Path $RegPath -Name "SearchboxTaskbarMode" -Value 0 -Force
        Write-Centered "Configuracion de barra de tareas aplicada." "Green"
        Write-Centered "Reiniciando Explorer..." "Yellow"
        Stop-Process -Name "explorer" -Force
    } catch { Write-Centered "Error en Taskbar." "Red" }
}

# 5b. Ocultar barra/icono de busqueda
function Hide-SearchBar {
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
        if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
        # SearchboxTaskbarMode: 0=Oculto, 1=Icono, 2=Cuadro, 3=Icono+etiqueta
        $Adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Set-ItemProperty -Path $Adv -Name "SearchboxTaskbarMode" -Value 0 -Force
        Write-Centered "Barra de busqueda ocultada." "Green"
        Write-Centered "Reiniciando Explorer..." "Yellow"
        Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    } catch { Write-Centered ("Error: " + $_.Exception.Message) "Red" }
}

# 5c. Quitar widgets Win11
function Hide-Widgets {
    try {
        $Adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        # TaskbarDa: 0=Ocultar widget de tiempo/noticias, 1=Mostrar
        Set-ItemProperty -Path $Adv -Name "TaskbarDa" -Value 0 -Force
        # TaskbarMn: 0=Ocultar icono Chat (Teams Consumer), 1=Mostrar
        Set-ItemProperty -Path $Adv -Name "TaskbarMn" -Value 0 -Force
        # Deshabilitar feed news & interests (Win10/11 precursor)
        $Feed = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds"
        if (-not (Test-Path $Feed)) { New-Item -Path $Feed -Force | Out-Null }
        Set-ItemProperty -Path $Feed -Name "ShellFeedsTaskbarViewMode" -Value 2 -Force
        Write-Centered "Widgets y Chat de Teams ocultados." "Green"
        Write-Centered "Reiniciando Explorer..." "Yellow"
        Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    } catch { Write-Centered ("Error: " + $_.Exception.Message) "Red" }
}

# 5d. Taskbar izquierda SOLO (sin tocar search)
function Align-TaskbarLeft {
    try {
        $Adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Set-ItemProperty -Path $Adv -Name "TaskbarAl" -Value 0 -Force
        Write-Centered "Taskbar alineada a la izquierda." "Green"
        Write-Centered "Reiniciando Explorer..." "Yellow"
        Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    } catch { Write-Centered ("Error: " + $_.Exception.Message) "Red" }
}

# 5e. Personalizacion RAPIDA Win11 (todo en uno)
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
        Write-Centered "Modo Minimalista Win11 aplicado:" "Green"
        Write-Centered "  - Taskbar izquierda" "Green"
        Write-Centered "  - Busqueda oculta" "Green"
        Write-Centered "  - Widgets ocultos" "Green"
        Write-Centered "  - Chat de Teams oculto" "Green"
        Write-Centered "Reiniciando Explorer..." "Yellow"
        Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    } catch { Write-Centered ("Error: " + $_.Exception.Message) "Red" }
}

# 6. Marca de Agua (Registro Seguro)
function Toggle-Watermark {
    try {
        $RegPath = "HKCU:\Control Panel\Desktop"
        # PaintDesktopVersion: 1 = Mostrar versión, 0 = Ocultar
        Set-ItemProperty -Path $RegPath -Name "PaintDesktopVersion" -Value 0 -Force
        Write-Centered "Marca de agua deshabilitada (Requiere reinicio)." "Green"
    } catch { Write-Centered "Error en registro." "Red" }
}

# ==========================================
# BUCLE PRINCIPAL
# ==========================================
$ejecutar = $true
# La tool se ejecuta inline (no desde un .ps1 fisico), asi que
# $MyInvocation.MyCommand.Definition devuelve el cuerpo de la funcion.
# Buscar wallpaper.jpg en %LOCALAPPDATA%\AtlasPC (ubicacion documentada).
$ScriptPath = if ($env:LOCALAPPDATA) { Join-Path $env:LOCALAPPDATA 'AtlasPC' } else { $env:TEMP }
if (-not (Test-Path $ScriptPath)) { New-Item -ItemType Directory -Path $ScriptPath -Force | Out-Null }

while ($ejecutar) {
    Show-Header
    Write-Centered "MENU AVANZADO DE PERSONALIZACION" "Cyan"
    Write-Host "`n"

    $M = " " * ([int](($Host.UI.RawUI.WindowSize.Width / 2) - 20))
    
    Write-Host "$M [1] Cambiar Fondo (Wallpaper.jpg local)"
    Write-Host "$M [2] Forzar Tema Oscuro (Apps & Sistema)"
    Write-Host "$M [3] Aplicar Color Acento ATLAS (Dorado)"
    Write-Host "$M [4] Alinear Taskbar izquierda + ocultar busqueda (original)"
    Write-Host "$M [5] Ocultar Marca de Agua (PaintDesktop)"
    Write-Host "$M [6] Deshabilitar sugerencias Menu Inicio"
    Write-Host "$M --- WIN11 MINIMAL ---" -ForegroundColor Cyan
    Write-Host "$M [7] Solo: Alinear Taskbar a la izquierda"
    Write-Host "$M [8] Solo: Ocultar barra de Busqueda"
    Write-Host "$M [9] Solo: Quitar Widgets + icono Chat Teams"
    Write-Host "$M [A] MODO MINIMAL (taskbar+search+widgets+chat en uno)" -ForegroundColor Green
    Write-Host "`n"
    Write-Host "$M [0] Volver / Salir" -ForegroundColor Gray
    Write-Host "`n"
    Write-Centered "Seleccione opcion:" "Gray"

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
             Write-Centered "Sugerencias de inicio deshabilitadas." "Green"
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
