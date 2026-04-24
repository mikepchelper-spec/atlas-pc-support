# ============================================================
# Invoke-PrepararUSB
# Prepara una USB con Atlas PC Support para uso offline.
# Atlas PC Support — v1.0
# ============================================================

function Invoke-PrepararUSB {
    [CmdletBinding()]
    param()

    $ErrorActionPreference = 'Continue'
    $Host.UI.RawUI.BackgroundColor = 'Black'
    $Host.UI.RawUI.ForegroundColor = 'Gray'
    $Host.UI.RawUI.WindowTitle = 'ATLAS PC SUPPORT - Preparar USB Offline'
    try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(100, 40) } catch {}
    Clear-Host

    function Write-Centered {
        param([string]$Text, [string]$Color = 'White')
        $w = try { $Host.UI.RawUI.WindowSize.Width } catch { 80 }
        $pad = [Math]::Max(0, [Math]::Floor(($w - $Text.Length) / 2))
        Write-Host ((' ' * $pad) + $Text) -ForegroundColor $Color
    }

    function Format-Size { param([double]$Bytes)
        if ($Bytes -ge 1GB) { return ('{0:N2} GB' -f ($Bytes / 1GB)) }
        if ($Bytes -ge 1MB) { return ('{0:N1} MB' -f ($Bytes / 1MB)) }
        if ($Bytes -ge 1KB) { return ('{0:N0} KB' -f ($Bytes / 1KB)) }
        return ("$Bytes B")
    }

    # URLs canónicas
    $LAUNCHER_URL_PRIMARY   = 'https://tools.atlaspcsupport.com/'
    $LAUNCHER_URL_FALLBACK  = 'https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1'
    $FASTCOPY_URL           = 'https://fastcopy.jp/archive/FastCopy5.11.2_installer.exe'
    $USB_ROOT_NAME          = 'ATLAS_PC_SUPPORT'
    $MAX_LAUNCHER_AGE_DAYS  = 7

    function Show-Header {
        Clear-Host
        Write-Host ''
        Write-Centered '============================================================' 'Cyan'
        Write-Centered '   ATLAS PC SUPPORT - PREPARAR USB OFFLINE' 'Yellow'
        Write-Centered '============================================================' 'Cyan'
        Write-Host ''
        Write-Centered 'Copia el panel a una USB para usarlo sin internet.' 'Gray'
        Write-Host ''
    }

    function Select-USB {
        $usbs = @(Get-Volume -ErrorAction SilentlyContinue | Where-Object {
            $_.DriveType -eq 'Removable' -and $_.DriveLetter -and $_.Size -gt 0
        })

        if (-not $usbs -or $usbs.Count -eq 0) {
            Write-Host ''
            Write-Centered '[!] No se detecto ninguna USB conectada.' 'Red'
            Write-Host ''
            Write-Centered 'Conecta una USB y presiona ENTER para reintentar, o [Q] para salir.' 'DarkGray'
            $r = Read-Host '  '
            if ($r -match '^[Qq]$') { return $null }
            return (Select-USB)
        }

        Write-Host ''
        Write-Centered '--- USB DETECTADAS ---' 'Yellow'
        Write-Host ''

        $map = @{}
        $i = 1
        foreach ($u in $usbs) {
            $label   = if ($u.FileSystemLabel) { $u.FileSystemLabel } else { 'SinNombre' }
            $sizeTxt = Format-Size $u.Size
            $freeTxt = Format-Size $u.SizeRemaining
            $line    = ('[{0}] {1}:\ - {2} ({3} total / {4} libres)' -f $i, $u.DriveLetter, $label, $sizeTxt, $freeTxt)
            Write-Centered $line 'Cyan'
            $map[$i] = $u
            $i++
        }

        Write-Host ''
        Write-Centered '[Q] Salir' 'DarkGray'
        Write-Host ''
        $sel = Read-Host '  Numero de USB'
        if ($sel -match '^[Qq]$') { return $null }
        if ($sel -as [int] -and $map.ContainsKey([int]$sel)) {
            return $map[[int]$sel]
        }
        Write-Centered '[!] Seleccion no valida.' 'Red'
        Start-Sleep 1
        return (Select-USB)
    }

    function Download-Launcher {
        param([string]$TargetFile)

        Write-Host ''
        Write-Centered '--- Descargando launcher ---' 'Yellow'

        $urls = @($LAUNCHER_URL_PRIMARY, $LAUNCHER_URL_FALLBACK)
        foreach ($u in $urls) {
            Write-Centered "Intentando: $u" 'DarkGray'
            try {
                $ProgressPreference = 'SilentlyContinue'
                Invoke-WebRequest -Uri $u -OutFile $TargetFile -UseBasicParsing -TimeoutSec 60 -ErrorAction Stop
                $sz = (Get-Item $TargetFile).Length
                if ($sz -gt 100KB) {
                    Write-Centered "[OK] Descargado ($(Format-Size $sz))" 'Green'
                    return $true
                }
            } catch {
                Write-Centered "[!] Fallo: $($_.Exception.Message)" 'Yellow'
            }
        }
        Write-Centered '[X] No se pudo descargar el launcher.' 'Red'
        return $false
    }

    function Download-FastCopy {
        param([string]$AppsDir)

        Write-Host ''
        Write-Centered '--- Descargando FastCopy (opcional) ---' 'Yellow'

        if (-not (Test-Path $AppsDir)) {
            New-Item -ItemType Directory -Path $AppsDir -Force | Out-Null
        }
        $installer = Join-Path $AppsDir 'FastCopy_installer.exe'
        try {
            $ProgressPreference = 'SilentlyContinue'
            Invoke-WebRequest -Uri $FASTCOPY_URL -OutFile $installer -UseBasicParsing -TimeoutSec 120 -ErrorAction Stop
            $sz = (Get-Item $installer).Length
            if ($sz -gt 200KB) {
                Write-Centered "[OK] Installer FastCopy descargado ($(Format-Size $sz))" 'Green'
                # Intentar extraer en la propia USB para que quede portable.
                Write-Centered 'Extrayendo a la USB con /EXTRACT64 ...' 'DarkGray'
                $p = Start-Process -FilePath $installer -ArgumentList @(
                    '/EXTRACT64', '/NOSUBDIR', '/AGREE_LICENSE', ("/DIR=`"$AppsDir`"")
                ) -Wait -PassThru -ErrorAction SilentlyContinue
                if ($p.ExitCode -eq 0 -and (Test-Path (Join-Path $AppsDir 'FastCopy.exe'))) {
                    Write-Centered '[OK] FastCopy extraido en la USB.' 'Green'
                    Remove-Item $installer -ErrorAction SilentlyContinue
                } else {
                    Write-Centered '[!] No se pudo extraer; queda el installer para instalacion manual.' 'Yellow'
                }
                return $true
            }
        } catch {
            Write-Centered "[!] Fallo descarga FastCopy: $($_.Exception.Message)" 'Yellow'
        }
        return $false
    }

    function Write-RunBat {
        param([string]$Path)
        $lines = @(
            '@echo off',
            'setlocal',
            'chcp 65001 > nul 2>&1',
            'title ATLAS PC SUPPORT - Offline Launcher',
            'cd /d "%~dp0"',
            '',
            'echo.',
            'echo ============================================================',
            'echo    ATLAS PC SUPPORT - Offline Launcher',
            'echo ============================================================',
            'echo.',
            '',
            'REM Comprobar si tenemos launcher local reciente. Si falta o esta',
            'REM viejo, intentamos descargar via bootstrap.ps1',
            'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bootstrap.ps1"',
            'if errorlevel 1 (',
            '    echo.',
            '    echo [!] No se pudo preparar el launcher. Revisa tu conexion o reintenta.',
            '    pause',
            '    exit /b 1',
            ')',
            '',
            'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0launcher.ps1"',
            'endlocal'
        )
        [System.IO.File]::WriteAllLines($Path, $lines, [System.Text.ASCIIEncoding]::new())
    }

    function Write-Bootstrap {
        param([string]$Path, [int]$MaxAgeDays)
        $utf8 = [System.Text.UTF8Encoding]::new($true)   # con BOM, para PS 5.1
        $content = @"
# ============================================================
# Atlas PC Support - Bootstrap (USB offline)
# Comprueba si launcher.ps1 existe y esta fresco (< $MaxAgeDays dias).
# Si no, intenta descargarlo. Si tampoco hay internet, usa el que hay.
# ============================================================

`$ErrorActionPreference = 'Continue'
`$here = Split-Path -Parent `$MyInvocation.MyCommand.Path
`$launcher = Join-Path `$here 'launcher.ps1'
`$maxAge = [TimeSpan]::FromDays($MaxAgeDays)

`$needsDownload = `$false
if (-not (Test-Path `$launcher)) {
    `$needsDownload = `$true
    Write-Host '  [i] No hay launcher local. Descargando...' -ForegroundColor Yellow
} else {
    try {
        `$age = (Get-Date) - (Get-Item `$launcher).LastWriteTime
        if (`$age -gt `$maxAge) {
            `$needsDownload = `$true
            Write-Host "  [i] Launcher tiene `$([int]`$age.TotalDays) dias. Actualizando..." -ForegroundColor Yellow
        } else {
            Write-Host "  [OK] Launcher local esta fresco (`$([int]`$age.TotalDays) dias)." -ForegroundColor Green
        }
    } catch {
        `$needsDownload = `$true
    }
}

if (`$needsDownload) {
    `$urls = @(
        'https://tools.atlaspcsupport.com/',
        'https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1'
    )
    `$ok = `$false
    foreach (`$u in `$urls) {
        try {
            `$ProgressPreference = 'SilentlyContinue'
            Invoke-WebRequest -Uri `$u -OutFile `$launcher -UseBasicParsing -TimeoutSec 60 -ErrorAction Stop
            if ((Get-Item `$launcher).Length -gt 100KB) {
                Write-Host "  [OK] Launcher descargado desde `$u" -ForegroundColor Green
                `$ok = `$true; break
            }
        } catch {
            Write-Host "  [!] Fallo: `$(`$_.Exception.Message)" -ForegroundColor Yellow
        }
    }
    if (-not `$ok) {
        if (Test-Path `$launcher) {
            Write-Host '  [!] Sin internet; usando launcher local existente.' -ForegroundColor Yellow
            exit 0
        }
        Write-Host '  [X] Sin internet y sin launcher local. No se puede continuar.' -ForegroundColor Red
        exit 1
    }
}

exit 0
"@
        [System.IO.File]::WriteAllText($Path, $content, $utf8)
    }

    function Write-Readme {
        param([string]$Path, [string]$DriveLetter)
        $readme = @"
ATLAS PC SUPPORT - USB OFFLINE
===============================

Esta USB contiene el panel Atlas PC Support listo para usar.

USO BASICO
----------
1. Conecta la USB al PC objetivo.
2. Abre la carpeta "$USB_ROOT_NAME".
3. Doble click en "run.bat".
4. Si tienes internet y el launcher local esta viejo (mas de $MAX_LAUNCHER_AGE_DAYS dias),
   bootstrap.ps1 lo actualiza automaticamente antes de lanzar el panel.
5. Si no tienes internet, se usa la copia local tal cual.

ESTRUCTURA
----------
$DriveLetter\$USB_ROOT_NAME\
    run.bat            Doble click aqui.
    bootstrap.ps1      Actualiza launcher si hace falta.
    launcher.ps1       Panel compilado (se auto-actualiza).
    apps\FastCopy\     Copia portable de FastCopy (si se descargo).
    README.txt         Este archivo.

ACTUALIZAR EL PANEL DESDE OTRO PC
---------------------------------
Lanza de nuevo la tool "Preparar USB Offline" en cualquier PC con internet
y seleccciona esta misma USB. Se sobrescribira launcher.ps1 con la version
mas reciente.

REQUISITOS EN EL PC OBJETIVO
----------------------------
- Windows 10 / 11.
- PowerShell 5.1 (ya viene con Windows).
- Permisos de administrador (las tools lo piden cuando toca).

SIN INTERNET
------------
Si el PC no tiene internet, el launcher local seguira funcionando. Solo
no podra descargar versiones actualizadas de launcher, FastCopy, etc.

Generado por Atlas PC Support - Preparar USB Offline
"@
        [System.IO.File]::WriteAllText($Path, $readme, [System.Text.UTF8Encoding]::new($true))
    }

    # ====================== MAIN ======================

    Show-Header

    $usb = Select-USB
    if (-not $usb) {
        Write-Host ''
        Write-Centered 'Cancelado.' 'DarkGray'
        return
    }

    $drive     = "$($usb.DriveLetter):"
    $targetDir = Join-Path $drive $USB_ROOT_NAME

    Write-Host ''
    Write-Centered "USB seleccionada: $drive ($(Format-Size $usb.Size))" 'Cyan'
    Write-Centered "Carpeta destino : $targetDir" 'Cyan'
    Write-Host ''

    if (Test-Path $targetDir) {
        Write-Centered "[!] La carpeta $targetDir ya existe." 'Yellow'
        Write-Centered '[A] Actualizar (sobrescribir launcher y scripts)' 'White'
        Write-Centered '[C] Cancelar' 'White'
        $o = Read-Host '  '
        if ($o -notmatch '^[Aa]$') {
            Write-Centered 'Cancelado.' 'DarkGray'
            return
        }
    } else {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    $appsDir = Join-Path $targetDir 'apps'
    if (-not (Test-Path $appsDir)) {
        New-Item -ItemType Directory -Path $appsDir -Force | Out-Null
    }

    # 1) Descargar launcher.ps1
    $launcherDest = Join-Path $targetDir 'launcher.ps1'
    $ok = Download-Launcher -TargetFile $launcherDest
    if (-not $ok) {
        Write-Host ''
        Write-Centered '[X] No se pudo descargar el launcher. Cancelando.' 'Red'
        Read-Host '  ENTER para salir'
        return
    }

    # 2) Escribir bootstrap.ps1 (UTF-8 con BOM)
    $bootstrapDest = Join-Path $targetDir 'bootstrap.ps1'
    Write-Bootstrap -Path $bootstrapDest -MaxAgeDays $MAX_LAUNCHER_AGE_DAYS
    Write-Centered "[OK] bootstrap.ps1 escrito." 'Green'

    # 3) Escribir run.bat
    $runBatDest = Join-Path $targetDir 'run.bat'
    Write-RunBat -Path $runBatDest
    Write-Centered "[OK] run.bat escrito." 'Green'

    # 4) README
    $readmeDest = Join-Path $targetDir 'README.txt'
    Write-Readme -Path $readmeDest -DriveLetter $drive
    Write-Centered "[OK] README.txt escrito." 'Green'

    # 5) FastCopy opcional
    Write-Host ''
    Write-Centered '¿Descargar FastCopy portable en la USB? [S/N] (recomendado)' 'Yellow'
    $dfc = Read-Host '  '
    if ($dfc -match '^[SsYy]$') {
        $fcDir = Join-Path $appsDir 'FastCopy'
        Download-FastCopy -AppsDir $fcDir | Out-Null
    }

    Write-Host ''
    Write-Centered '============================================================' 'Cyan'
    Write-Centered '   USB PREPARADA CORRECTAMENTE' 'Green'
    Write-Centered '============================================================' 'Cyan'
    Write-Host ''
    Write-Centered "Ruta: $targetDir" 'White'
    Write-Centered "Uso : Conecta la USB en el PC objetivo, doble click en run.bat" 'Gray'
    Write-Host ''

    # Abrir la carpeta
    try { Start-Process explorer.exe $targetDir } catch {}
}
