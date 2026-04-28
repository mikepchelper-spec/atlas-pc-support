# ============================================================
# Invoke-PrepararUSB  ->  Build Offline USB
#
# i18n: Option A (en default + full es secondary). Function name
# kept as Invoke-PrepararUSB for tools.json compatibility.
#
# Atlas PC Support
# ============================================================

function Invoke-PrepararUSB {
    [CmdletBinding()]
    param()

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
            WinTitle    = 'ATLAS PC SUPPORT - Build Offline USB'
            HeaderL1    = '   ATLAS PC SUPPORT - BUILD OFFLINE USB'
            HeaderSub   = 'Copy the panel to a USB to use it without internet.'
            NoUSB       = '[!] No USB detected.'
            ConnectUSB  = 'Connect a USB and press ENTER to retry, or [Q] to quit.'
            DetectedHdr = '--- DETECTED USB DRIVES ---'
            UnnamedLbl  = 'Unnamed'
            DriveLine   = '[{0}] {1}:\ - {2} ({3} total / {4} free)'
            QuitOpt     = '[Q] Quit'
            USBNumber   = '  USB number'
            BadSel      = '[!] Invalid selection.'
            DLLauncher  = '--- Downloading launcher ---'
            Trying      = 'Trying: {0}'
            DLOk        = '[OK] Downloaded ({0})'
            DLFail      = '[!] Failed: {0}'
            DLNoLnch    = '[X] Could not download launcher.'
            DLFastCopy  = '--- Downloading FastCopy (optional) ---'
            FCInstOk    = '[OK] FastCopy installer downloaded ({0})'
            FCExtract   = 'Extracting to USB with /EXTRACT64 ...'
            FCExtractOk = '[OK] FastCopy extracted to USB.'
            FCExtractF  = '[!] Could not extract; installer left for manual install.'
            FCDLFail    = '[!] FastCopy download failed: {0}'
            DLPS7Hdr    = '--- Downloading PowerShell 7 MSI (~120 MB, optional) ---'
            DLPS7Note   = 'Lets the client install PS7 without internet from this USB.'
            PS7Exists   = '[OK] Already exists: {0}'
            PS7Ok       = '[OK] PS7 MSI downloaded ({0})'
            PS7Partial  = '[!] Download seems incomplete ({0})'
            PS7Fail     = '[!] PS7 download failed: {0}'
            USBSelected = 'USB selected: {0} ({1})'
            TargetDir   = 'Target folder: {0}'
            ExistsHdr   = '[!] Folder {0} already exists.'
            UpdOpt      = '[A] Update (overwrite launcher and scripts)'
            CancelOpt   = '[C] Cancel'
            Cancelled   = 'Cancelled.'
            BootOk      = '[OK] bootstrap.ps1 written.'
            RunOk       = '[OK] run.bat written.'
            ReadmeOk    = '[OK] README.txt written.'
            AskFC       = 'Download portable FastCopy on the USB? [Y/N] (recommended)'
            AskPS7      = 'Download PowerShell 7 MSI on the USB? [Y/N] (~120 MB)'
            AskPS7Note  = 'Lets the client install PS7 without internet via the "Install/Update PowerShell 7" tool.'
            DLLnchFatal = '[X] Could not download launcher. Aborting.'
            EnterExit   = '  ENTER to exit'
            DoneSep     = '============================================================'
            DoneTitle   = '   USB PREPARED SUCCESSFULLY'
            DonePath    = 'Path: {0}'
            DoneUsage   = 'Usage: connect USB to target PC, double-click run.bat'
            BootTitle   = '# Atlas PC Support - Bootstrap (USB offline)'
            BootDesc1   = '# Checks if launcher.ps1 exists and is fresh (< {0} days).'
            BootDesc2   = '# If not, tries to download it. If no internet, uses the local copy.'
            BootNoLocal = '  [i] No local launcher. Downloading...'
            BootStale   = '  [i] Launcher is {0} days old. Updating...'
            BootFresh   = '  [OK] Local launcher is fresh ({0} days).'
            BootDLOk    = '  [OK] Launcher downloaded from {0}'
            BootDLFail  = '  [!] Failed: {0}'
            BootNoNet   = '  [!] No internet; using local launcher.'
            BootNoBoth  = '  [X] No internet and no local launcher. Cannot continue.'
            RunFail     = 'echo [!] Could not prepare launcher. Check connection or retry.'
        }
        es = @{
            WinTitle    = 'ATLAS PC SUPPORT - Preparar USB Offline'
            HeaderL1    = '   ATLAS PC SUPPORT - PREPARAR USB OFFLINE'
            HeaderSub   = 'Copia el panel a una USB para usarlo sin internet.'
            NoUSB       = '[!] No se detecto ninguna USB conectada.'
            ConnectUSB  = 'Conecta una USB y presiona ENTER para reintentar, o [Q] para salir.'
            DetectedHdr = '--- USB DETECTADAS ---'
            UnnamedLbl  = 'SinNombre'
            DriveLine   = '[{0}] {1}:\ - {2} ({3} total / {4} libres)'
            QuitOpt     = '[Q] Salir'
            USBNumber   = '  Numero de USB'
            BadSel      = '[!] Seleccion no valida.'
            DLLauncher  = '--- Descargando launcher ---'
            Trying      = 'Intentando: {0}'
            DLOk        = '[OK] Descargado ({0})'
            DLFail      = '[!] Fallo: {0}'
            DLNoLnch    = '[X] No se pudo descargar el launcher.'
            DLFastCopy  = '--- Descargando FastCopy (opcional) ---'
            FCInstOk    = '[OK] Installer FastCopy descargado ({0})'
            FCExtract   = 'Extrayendo a la USB con /EXTRACT64 ...'
            FCExtractOk = '[OK] FastCopy extraido en la USB.'
            FCExtractF  = '[!] No se pudo extraer; queda el installer para instalacion manual.'
            FCDLFail    = '[!] Fallo descarga FastCopy: {0}'
            DLPS7Hdr    = '--- Descargando PowerShell 7 MSI (~120 MB, opcional) ---'
            DLPS7Note   = 'Permite que el cliente instale PS7 sin internet desde esta USB.'
            PS7Exists   = '[OK] Ya existe: {0}'
            PS7Ok       = '[OK] PS7 MSI descargado ({0})'
            PS7Partial  = '[!] Descarga parece incompleta ({0})'
            PS7Fail     = '[!] Fallo descarga PS7: {0}'
            USBSelected = 'USB seleccionada: {0} ({1})'
            TargetDir   = 'Carpeta destino : {0}'
            ExistsHdr   = '[!] La carpeta {0} ya existe.'
            UpdOpt      = '[A] Actualizar (sobrescribir launcher y scripts)'
            CancelOpt   = '[C] Cancelar'
            Cancelled   = 'Cancelado.'
            BootOk      = '[OK] bootstrap.ps1 escrito.'
            RunOk       = '[OK] run.bat escrito.'
            ReadmeOk    = '[OK] README.txt escrito.'
            AskFC       = 'Descargar FastCopy portable en la USB? [S/N] (recomendado)'
            AskPS7      = 'Descargar PowerShell 7 MSI en la USB? [S/N] (~120 MB)'
            AskPS7Note  = 'Permite al cliente instalar PS7 sin internet con la tool "Actualizar PowerShell".'
            DLLnchFatal = '[X] No se pudo descargar el launcher. Cancelando.'
            EnterExit   = '  ENTER para salir'
            DoneSep     = '============================================================'
            DoneTitle   = '   USB PREPARADA CORRECTAMENTE'
            DonePath    = 'Ruta: {0}'
            DoneUsage   = 'Uso : Conecta la USB en el PC objetivo, doble click en run.bat'
            BootTitle   = '# Atlas PC Support - Bootstrap (USB offline)'
            BootDesc1   = '# Comprueba si launcher.ps1 existe y esta fresco (< {0} dias).'
            BootDesc2   = '# Si no, intenta descargarlo. Si tampoco hay internet, usa el local.'
            BootNoLocal = '  [i] No hay launcher local. Descargando...'
            BootStale   = '  [i] Launcher tiene {0} dias. Actualizando...'
            BootFresh   = '  [OK] Launcher local esta fresco ({0} dias).'
            BootDLOk    = '  [OK] Launcher descargado desde {0}'
            BootDLFail  = '  [!] Fallo: {0}'
            BootNoNet   = '  [!] Sin internet; usando launcher local existente.'
            BootNoBoth  = '  [X] Sin internet y sin launcher local. No se puede continuar.'
            RunFail     = 'echo [!] No se pudo preparar el launcher. Revisa tu conexion o reintenta.'
        }
    }
    $lang = _Atlas-DetectLang
    if (-not $T.ContainsKey($lang)) { $lang = 'en' }
    $L = $T[$lang]

    # README content per language (keeps existing UX; one heredoc per lang)
    $READMES = @{
        en = @"
ATLAS PC SUPPORT - OFFLINE USB
==============================

This USB contains the Atlas PC Support panel ready to use.

BASIC USAGE
-----------
1. Plug the USB into the target PC.
2. Open the "{ROOT}" folder.
3. Double-click "run.bat".
4. If you have internet and the local launcher is older than {DAYS} days,
   bootstrap.ps1 updates it automatically before launching the panel.
5. If you have no internet, the local copy is used as-is.

LAYOUT
------
{LETTER}\{ROOT}\
    run.bat            Double-click here.
    bootstrap.ps1      Updates launcher if needed.
    run-launcher.ps1   Wrapper (captures errors + writes atlas-offline.log).
    launcher.ps1       Compiled panel (auto-updates).
    atlas-offline.log  Transcript of the latest run (errors + stack trace).
    apps\FastCopy\     Portable FastCopy copy (if downloaded).
    README.txt         This file.

TROUBLESHOOTING
---------------
If run.bat closes without showing a clear error, open
atlas-offline.log next to run.bat. It captures everything the
panel printed, including any fatal initialization errors.

UPDATE THE PANEL FROM ANOTHER PC
--------------------------------
Run the "Build Offline USB" tool again on any PC with internet, and
select the same USB. launcher.ps1 will be overwritten with the latest.

REQUIREMENTS ON TARGET PC
-------------------------
- Windows 10 / 11.
- PowerShell 5.1 (ships with Windows).
- Admin privileges (tools ask when needed).

NO INTERNET
-----------
If the PC has no internet, the local launcher will still work. It
just cannot pull updated launcher/FastCopy/etc.

Generated by Atlas PC Support - Build Offline USB
"@
        es = @"
ATLAS PC SUPPORT - USB OFFLINE
===============================

Esta USB contiene el panel Atlas PC Support listo para usar.

USO BASICO
----------
1. Conecta la USB al PC objetivo.
2. Abre la carpeta "{ROOT}".
3. Doble click en "run.bat".
4. Si tienes internet y el launcher local esta viejo (mas de {DAYS} dias),
   bootstrap.ps1 lo actualiza automaticamente antes de lanzar el panel.
5. Si no tienes internet, se usa la copia local tal cual.

ESTRUCTURA
----------
{LETTER}\{ROOT}\
    run.bat            Doble click aqui.
    bootstrap.ps1      Actualiza launcher si hace falta.
    run-launcher.ps1   Wrapper (captura errores + escribe atlas-offline.log).
    launcher.ps1       Panel compilado (se auto-actualiza).
    atlas-offline.log  Transcript de la ultima ejecucion (errores + stack).
    apps\FastCopy\     Copia portable de FastCopy (si se descargo).
    README.txt         Este archivo.

SOLUCION DE PROBLEMAS
---------------------
Si run.bat se cierra sin mostrar un error claro, abre
atlas-offline.log al lado de run.bat. Captura todo lo que
imprimio el panel, incluyendo errores fatales de inicio.

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
    }

    $ErrorActionPreference = 'Continue'
    $Host.UI.RawUI.BackgroundColor = 'Black'
    $Host.UI.RawUI.ForegroundColor = 'Gray'
    $Host.UI.RawUI.WindowTitle = $L.WinTitle
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

    # Canonical URLs
    $LAUNCHER_URL_PRIMARY   = 'https://tools.atlaspcsupport.com/'
    $LAUNCHER_URL_FALLBACK  = 'https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1'
    $FASTCOPY_URL           = 'https://fastcopy.jp/archive/FastCopy5.11.2_installer.exe'
    $PS7_VERSION            = '7.5.0'
    $PS7_URL                = "https://github.com/PowerShell/PowerShell/releases/download/v$PS7_VERSION/PowerShell-$PS7_VERSION-win-x64.msi"
    $USB_ROOT_NAME          = 'ATLAS_PC_SUPPORT'
    $MAX_LAUNCHER_AGE_DAYS  = 7

    function Show-Header {
        Clear-Host
        Write-Host ''
        Write-Centered '============================================================' 'Cyan'
        Write-Centered $L.HeaderL1 'Yellow'
        Write-Centered '============================================================' 'Cyan'
        Write-Host ''
        Write-Centered $L.HeaderSub 'Gray'
        Write-Host ''
    }

    function Select-USB {
        $usbs = @(Get-Volume -ErrorAction SilentlyContinue | Where-Object {
            $_.DriveType -eq 'Removable' -and $_.DriveLetter -and $_.Size -gt 0
        })

        if (-not $usbs -or $usbs.Count -eq 0) {
            Write-Host ''
            Write-Centered $L.NoUSB 'Red'
            Write-Host ''
            Write-Centered $L.ConnectUSB 'DarkGray'
            $r = Read-Host '  '
            if ($r -match '^[Qq]$') { return $null }
            return (Select-USB)
        }

        Write-Host ''
        Write-Centered $L.DetectedHdr 'Yellow'
        Write-Host ''

        $map = @{}
        $i = 1
        foreach ($u in $usbs) {
            $label   = if ($u.FileSystemLabel) { $u.FileSystemLabel } else { $L.UnnamedLbl }
            $sizeTxt = Format-Size $u.Size
            $freeTxt = Format-Size $u.SizeRemaining
            $line    = ($L.DriveLine -f $i, $u.DriveLetter, $label, $sizeTxt, $freeTxt)
            Write-Centered $line 'Cyan'
            $map[$i] = $u
            $i++
        }

        Write-Host ''
        Write-Centered $L.QuitOpt 'DarkGray'
        Write-Host ''
        $sel = Read-Host $L.USBNumber
        if ($sel -match '^[Qq]$') { return $null }
        if ($sel -as [int] -and $map.ContainsKey([int]$sel)) {
            return $map[[int]$sel]
        }
        Write-Centered $L.BadSel 'Red'
        Start-Sleep 1
        return (Select-USB)
    }

    function Download-Launcher {
        param([string]$TargetFile)

        Write-Host ''
        Write-Centered $L.DLLauncher 'Yellow'

        # Cache-bust both URLs. tools.atlaspcsupport.com goes through a
        # Cloudflare Worker that has aggressively cached older builds in
        # the past — appending a random ?v= guarantees a fresh fetch from
        # origin (or at least bypasses edge cache for this request).
        $bust = [Guid]::NewGuid().ToString('N')
        $urls = @(
            ("$LAUNCHER_URL_PRIMARY"  + (& { if ($LAUNCHER_URL_PRIMARY  -match '\?') { '&' } else { '?' } }) + 'v=' + $bust),
            ("$LAUNCHER_URL_FALLBACK" + (& { if ($LAUNCHER_URL_FALLBACK -match '\?') { '&' } else { '?' } }) + 'v=' + $bust)
        )
        $headers = @{ 'Cache-Control' = 'no-cache'; 'Pragma' = 'no-cache' }
        foreach ($u in $urls) {
            Write-Centered ($L.Trying -f $u) 'DarkGray'
            try {
                $ProgressPreference = 'SilentlyContinue'
                Invoke-WebRequest -Uri $u -OutFile $TargetFile -UseBasicParsing -TimeoutSec 60 -Headers $headers -ErrorAction Stop
                $sz = (Get-Item $TargetFile).Length
                if ($sz -gt 100KB) {
                    Write-Centered ($L.DLOk -f (Format-Size $sz)) 'Green'
                    return $true
                }
            } catch {
                Write-Centered ($L.DLFail -f $_.Exception.Message) 'Yellow'
            }
        }
        Write-Centered $L.DLNoLnch 'Red'
        return $false
    }

    function Download-FastCopy {
        param([string]$AppsDir)

        Write-Host ''
        Write-Centered $L.DLFastCopy 'Yellow'

        if (-not (Test-Path $AppsDir)) {
            New-Item -ItemType Directory -Path $AppsDir -Force | Out-Null
        }
        $installer = Join-Path $AppsDir 'FastCopy_installer.exe'
        try {
            $ProgressPreference = 'SilentlyContinue'
            Invoke-WebRequest -Uri $FASTCOPY_URL -OutFile $installer -UseBasicParsing -TimeoutSec 120 -ErrorAction Stop
            $sz = (Get-Item $installer).Length
            if ($sz -gt 200KB) {
                Write-Centered ($L.FCInstOk -f (Format-Size $sz)) 'Green'
                Write-Centered $L.FCExtract 'DarkGray'
                $p = Start-Process -FilePath $installer -ArgumentList @(
                    '/EXTRACT64', '/NOSUBDIR', '/AGREE_LICENSE', ("/DIR=`"$AppsDir`"")
                ) -Wait -PassThru -ErrorAction SilentlyContinue
                if ($p.ExitCode -eq 0 -and (Test-Path (Join-Path $AppsDir 'FastCopy.exe'))) {
                    Write-Centered $L.FCExtractOk 'Green'
                    Remove-Item $installer -ErrorAction SilentlyContinue
                } else {
                    Write-Centered $L.FCExtractF 'Yellow'
                }
                return $true
            }
        } catch {
            Write-Centered ($L.FCDLFail -f $_.Exception.Message) 'Yellow'
        }
        return $false
    }

    function Download-PS7 {
        param([string]$DepsDir)

        Write-Host ''
        Write-Centered $L.DLPS7Hdr 'Yellow'
        Write-Centered $L.DLPS7Note 'DarkGray'

        if (-not (Test-Path $DepsDir)) {
            New-Item -ItemType Directory -Path $DepsDir -Force | Out-Null
        }
        $msiFile = Join-Path $DepsDir "PowerShell-$PS7_VERSION-win-x64.msi"
        if ((Test-Path $msiFile) -and ((Get-Item $msiFile).Length -gt 50MB)) {
            Write-Centered ($L.PS7Exists -f $msiFile) 'Green'
            return $true
        }
        try {
            $ProgressPreference = 'SilentlyContinue'
            Invoke-WebRequest -Uri $PS7_URL -OutFile $msiFile -UseBasicParsing -TimeoutSec 300 -ErrorAction Stop
            $sz = (Get-Item $msiFile).Length
            if ($sz -gt 50MB) {
                Write-Centered ($L.PS7Ok -f (Format-Size $sz)) 'Green'
                return $true
            } else {
                Write-Centered ($L.PS7Partial -f (Format-Size $sz)) 'Yellow'
                Remove-Item $msiFile -ErrorAction SilentlyContinue
            }
        } catch {
            Write-Centered ($L.PS7Fail -f $_.Exception.Message) 'Yellow'
        }
        return $false
    }

    function Write-RunBat {
        param([string]$Path, [string]$FailMsg)
        # run.bat delegates the heavy lifting to run-launcher.ps1 (which
        # handles Start-Transcript + exception trap + pause-on-error). That
        # way when launcher.ps1 throws before reaching the WPF ShowDialog,
        # the user still sees the exception and a log file is left on the
        # USB next to run.bat for post-mortem.
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
            'echo Log file: %~dp0atlas-offline.log',
            'echo.',
            '',
            'echo [1/2] Checking / updating launcher ...',
            'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bootstrap.ps1"',
            'if errorlevel 1 (',
            '    echo.',
            ('    ' + $FailMsg),
            '    pause',
            '    exit /b 1',
            ')',
            '',
            'echo.',
            'echo [2/2] Launching panel ...',
            'echo.',
            'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0run-launcher.ps1"',
            'set "RC=%errorlevel%"',
            'if not "%RC%"=="0" (',
            '    echo.',
            '    echo ============================================================',
            '    echo [!] launcher.ps1 exited with error code %RC%.',
            '    echo [!] See the error above and the log: %~dp0atlas-offline.log',
            '    echo ============================================================',
            '    pause',
            '    exit /b %RC%',
            ')',
            '',
            'endlocal'
        )
        [System.IO.File]::WriteAllLines($Path, $lines, [System.Text.ASCIIEncoding]::new())
    }

    function Write-RunLauncherWrapper {
        param([string]$Path)
        $utf8 = [System.Text.UTF8Encoding]::new($true)
        $content = @'
# ============================================================
# Atlas PC Support - Run launcher wrapper (USB offline)
# Captures transcript + traps exceptions so the user actually
# sees errors when launcher.ps1 fails before ShowDialog.
# ============================================================

$here        = Split-Path -Parent $MyInvocation.MyCommand.Path
$launcher    = Join-Path $here 'launcher.ps1'
$transcript  = Join-Path $here 'atlas-offline.log'

if (-not (Test-Path -LiteralPath $launcher)) {
    Write-Host ''
    Write-Host ('[X] launcher.ps1 not found at: ' + $launcher) -ForegroundColor Red
    Write-Host 'Press ENTER to exit.' -ForegroundColor Yellow
    [void](Read-Host)
    exit 2
}

try { Stop-Transcript | Out-Null } catch {}
try {
    Start-Transcript -Path $transcript -Append -ErrorAction SilentlyContinue | Out-Null
} catch {}

$ok = $false
try {
    & $launcher
    $ok = $true
} catch {
    Write-Host ''
    Write-Host '============================================================' -ForegroundColor Red
    Write-Host '  [X] Fatal error while loading the Atlas panel:' -ForegroundColor Red
    Write-Host '============================================================' -ForegroundColor Red
    Write-Host ''
    Write-Host ('  ' + $_.Exception.Message) -ForegroundColor Yellow
    if ($_.InvocationInfo -and $_.InvocationInfo.PositionMessage) {
        Write-Host ''
        Write-Host ('  at: ' + $_.InvocationInfo.PositionMessage) -ForegroundColor DarkGray
    }
    if ($_.ScriptStackTrace) {
        Write-Host ''
        Write-Host '  Stack trace:' -ForegroundColor DarkGray
        Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
    }
    Write-Host ''
    Write-Host ('  Full log: ' + $transcript) -ForegroundColor Gray
    Write-Host ''
    Write-Host '  Press ENTER to exit.' -ForegroundColor Yellow
    [void](Read-Host)
} finally {
    try { Stop-Transcript | Out-Null } catch {}
}

if (-not $ok) { exit 1 }
exit 0
'@
        [System.IO.File]::WriteAllText($Path, $content, $utf8)
    }

    function Write-Bootstrap {
        param([string]$Path, [int]$MaxAgeDays)
        $utf8 = [System.Text.UTF8Encoding]::new($true)
        $msgNoLocal = $L.BootNoLocal
        $msgStale   = $L.BootStale
        $msgFresh   = $L.BootFresh
        $msgDLOk    = $L.BootDLOk
        $msgDLFail  = $L.BootDLFail
        $msgNoNet   = $L.BootNoNet
        $msgNoBoth  = $L.BootNoBoth
        $title      = $L.BootTitle
        $desc1      = ($L.BootDesc1 -f $MaxAgeDays)
        $desc2      = $L.BootDesc2
        $content = @"
# ============================================================
$title
$desc1
$desc2
# ============================================================

`$ErrorActionPreference = 'Continue'
`$here = Split-Path -Parent `$MyInvocation.MyCommand.Path
`$launcher = Join-Path `$here 'launcher.ps1'
`$maxAge = [TimeSpan]::FromDays($MaxAgeDays)

`$needsDownload = `$false
if (-not (Test-Path `$launcher)) {
    `$needsDownload = `$true
    Write-Host '$msgNoLocal' -ForegroundColor Yellow
} else {
    try {
        `$age = (Get-Date) - (Get-Item `$launcher).LastWriteTime
        if (`$age -gt `$maxAge) {
            `$needsDownload = `$true
            Write-Host ("$msgStale" -f [int]`$age.TotalDays) -ForegroundColor Yellow
        } else {
            Write-Host ("$msgFresh" -f [int]`$age.TotalDays) -ForegroundColor Green
        }
    } catch {
        `$needsDownload = `$true
    }
}

if (`$needsDownload) {
    # Cache-bust to defeat any stale Cloudflare/CDN edge cache.
    `$bust = [Guid]::NewGuid().ToString('N')
    `$urls = @(
        ('https://tools.atlaspcsupport.com/?v=' + `$bust),
        ('https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1?v=' + `$bust)
    )
    `$noCacheHdr = @{ 'Cache-Control' = 'no-cache'; 'Pragma' = 'no-cache' }
    `$ok = `$false
    foreach (`$u in `$urls) {
        try {
            `$ProgressPreference = 'SilentlyContinue'
            Invoke-WebRequest -Uri `$u -OutFile `$launcher -UseBasicParsing -TimeoutSec 60 -Headers `$noCacheHdr -ErrorAction Stop
            if ((Get-Item `$launcher).Length -gt 100KB) {
                Write-Host ("$msgDLOk" -f `$u) -ForegroundColor Green
                `$ok = `$true; break
            }
        } catch {
            Write-Host ("$msgDLFail" -f `$_.Exception.Message) -ForegroundColor Yellow
        }
    }
    if (-not `$ok) {
        if (Test-Path `$launcher) {
            Write-Host '$msgNoNet' -ForegroundColor Yellow
            # Fall through to BOM repair below.
        } else {
            Write-Host '$msgNoBoth' -ForegroundColor Red
            exit 1
        }
    }
}

# --- BOM repair ---
# Windows PowerShell 5.1 reads BOM-less .ps1 as CP1252, which mojibakes
# accents and emojis embedded in the launcher (e.g. "Diagnóstico" ->
# "DiagnÃ³stico") and makes the whole script fail to parse. GitHub raw
# serves the committed bytes verbatim, and earlier build.ps1 versions
# omitted the BOM on pwsh 7+, so USBs in the field may have a BOM-less
# copy. Self-heal by prepending the BOM if it's missing.
try {
    if (Test-Path `$launcher) {
        `$stream = [System.IO.File]::OpenRead(`$launcher)
        `$head = New-Object byte[] 3
        `$read = `$stream.Read(`$head, 0, 3)
        `$stream.Close()
        `$hasBom = (`$read -ge 3 -and `$head[0] -eq 0xEF -and `$head[1] -eq 0xBB -and `$head[2] -eq 0xBF)
        if (-not `$hasBom) {
            `$bytes = [System.IO.File]::ReadAllBytes(`$launcher)
            `$bom = [byte[]](0xEF, 0xBB, 0xBF)
            `$new = New-Object byte[] (`$bom.Length + `$bytes.Length)
            [Array]::Copy(`$bom, 0, `$new, 0, `$bom.Length)
            [Array]::Copy(`$bytes, 0, `$new, `$bom.Length, `$bytes.Length)
            [System.IO.File]::WriteAllBytes(`$launcher, `$new)
            Write-Host '  [OK] Added UTF-8 BOM to launcher.ps1 (PS 5.1 compatibility).' -ForegroundColor DarkGray
        }
    }
} catch {
    Write-Host ('  [!] BOM repair skipped: ' + `$_.Exception.Message) -ForegroundColor DarkGray
}

exit 0
"@
        [System.IO.File]::WriteAllText($Path, $content, $utf8)
    }

    function Write-Readme {
        param([string]$Path, [string]$DriveLetter)
        $body = $READMES[$lang]
        if (-not $body) { $body = $READMES['en'] }
        $body = $body.Replace('{ROOT}', $USB_ROOT_NAME).Replace('{DAYS}', $MAX_LAUNCHER_AGE_DAYS).Replace('{LETTER}', $DriveLetter)
        [System.IO.File]::WriteAllText($Path, $body, [System.Text.UTF8Encoding]::new($true))
    }

    # ====================== MAIN ======================

    Show-Header

    $usb = Select-USB
    if (-not $usb) {
        Write-Host ''
        Write-Centered $L.Cancelled 'DarkGray'
        return
    }

    $drive     = "$($usb.DriveLetter):"
    $targetDir = Join-Path $drive $USB_ROOT_NAME

    Write-Host ''
    Write-Centered ($L.USBSelected -f $drive, (Format-Size $usb.Size)) 'Cyan'
    Write-Centered ($L.TargetDir -f $targetDir) 'Cyan'
    Write-Host ''

    if (Test-Path $targetDir) {
        Write-Centered ($L.ExistsHdr -f $targetDir) 'Yellow'
        Write-Centered $L.UpdOpt 'White'
        Write-Centered $L.CancelOpt 'White'
        $o = Read-Host '  '
        if ($o -notmatch '^[Aa]$') {
            Write-Centered $L.Cancelled 'DarkGray'
            return
        }
    } else {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    $appsDir = Join-Path $targetDir 'apps'
    if (-not (Test-Path $appsDir)) {
        New-Item -ItemType Directory -Path $appsDir -Force | Out-Null
    }

    $launcherDest = Join-Path $targetDir 'launcher.ps1'
    $ok = Download-Launcher -TargetFile $launcherDest
    if (-not $ok) {
        Write-Host ''
        Write-Centered $L.DLLnchFatal 'Red'
        Read-Host $L.EnterExit
        return
    }

    $bootstrapDest = Join-Path $targetDir 'bootstrap.ps1'
    Write-Bootstrap -Path $bootstrapDest -MaxAgeDays $MAX_LAUNCHER_AGE_DAYS
    Write-Centered $L.BootOk 'Green'

    $runBatDest = Join-Path $targetDir 'run.bat'
    Write-RunBat -Path $runBatDest -FailMsg $L.RunFail
    Write-Centered $L.RunOk 'Green'

    $wrapperDest = Join-Path $targetDir 'run-launcher.ps1'
    Write-RunLauncherWrapper -Path $wrapperDest

    $readmeDest = Join-Path $targetDir 'README.txt'
    Write-Readme -Path $readmeDest -DriveLetter $drive
    Write-Centered $L.ReadmeOk 'Green'

    Write-Host ''
    Write-Centered $L.AskFC 'Yellow'
    $dfc = Read-Host '  '
    if ($dfc -match '^[SsYy]$') {
        $fcDir = Join-Path $appsDir 'FastCopy'
        Download-FastCopy -AppsDir $fcDir | Out-Null
    }

    Write-Host ''
    Write-Centered $L.AskPS7 'Yellow'
    Write-Centered $L.AskPS7Note 'DarkGray'
    $dps = Read-Host '  '
    if ($dps -match '^[SsYy]$') {
        $depsDir = Join-Path $targetDir 'deps'
        Download-PS7 -DepsDir $depsDir | Out-Null
    }

    Write-Host ''
    Write-Centered $L.DoneSep 'Cyan'
    Write-Centered $L.DoneTitle 'Green'
    Write-Centered $L.DoneSep 'Cyan'
    Write-Host ''
    Write-Centered ($L.DonePath -f $targetDir) 'White'
    Write-Centered $L.DoneUsage 'Gray'
    Write-Host ''

    try { Start-Process explorer.exe $targetDir } catch {}
}
