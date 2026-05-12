# ============================================================
# Invoke-InstalarMicrosoftStore  ->  Install Microsoft Store
#
# Installs the Microsoft Store on systems where it is absent
# (Windows 10/11 IoT Enterprise LTSC, corporate images, etc.)
# Uses a 3-method cascade:
#   1. Detect (already installed -> done)
#   2. wsreset -i  (official method, W11 22000+ non-LTSC only)
#   3. Appx bundle from Microsoft CDN (VCLibs + UI.Xaml + Store)
#      -> checks USB offline cache first, then local cache, then download
#
# i18n: Option A (en default + full es secondary).
# Atlas PC Support
# ============================================================

function Invoke-InstalarMicrosoftStore {
    [CmdletBinding()]
    param()

    $ErrorActionPreference = 'Continue'

    # --- Language detection (env var -> config.json -> system culture -> en) ---
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
            Title           = 'INSTALL MICROSOFT STORE'
            Separator       = '============================================================'
            CheckingStore   = '[1/3] Checking current Store status...'
            AlreadyInstalled= '  [OK] Microsoft Store is already installed ({0}). No action needed.'
            NotFound        = '  [!] Microsoft Store not found on this system.'
            SkipWsreset     = '[2/3] Skipping wsreset -i (LTSC/IoT build detected -- not reliable).'
            TryWsreset      = '[2/3] Trying wsreset -i (official Microsoft method)...'
            WsresetWait     = '  [i] Waiting up to 90 s for Store to appear...'
            WsresetOk       = '  [OK] Microsoft Store installed via wsreset.'
            WsresetFail     = '  [!] wsreset did not install the Store. Trying bundle method.'
            BundleHeader    = '[3/3] Downloading Store bundle from Microsoft CDN...'
            BundleOffline   = '[3/3] Installing Store bundle from USB offline cache...'
            BundleLocal     = '[3/3] Installing Store bundle from local cache...'
            Downloading     = '  [>] {0} (~{1} MB)...'
            DownloadOk      = ' [OK]'
            DownloadFail    = ' [FAIL]: {0}'
            Installing      = '  Installing packages...'
            InstallOk       = '  [OK] Microsoft Store installed successfully.'
            InstallFail     = '  [X] Installation failed: {0}'
            ManualSteps     = '  Manual alternative:'
            ManualStep1     = '    Settings > Apps > Optional features > Add a feature > Search "Microsoft Store"'
            ManualStep2     = '    Or run: wsreset -i   (on supported Windows 11 builds)'
            ManualStep3     = '    Or use PrepararUSB to pre-download the bundle to a USB drive, then re-run this tool with the USB connected.'
            NeedAdmin       = '[!] Administrator privileges are required. Relaunch as admin.'
            EnterExit       = 'Press Enter to exit...'
            DepsInstalling  = '  Installing dependency: {0}'
            DepsOk          = '  [OK] Dependency installed: {0}'
            DepsFail        = '  [!] Dependency failed ({0}): {1}'
        }
        es = @{
            Title           = 'INSTALAR MICROSOFT STORE'
            Separator       = '============================================================'
            CheckingStore   = '[1/3] Verificando estado de la Store...'
            AlreadyInstalled= '  [OK] Microsoft Store ya esta instalada ({0}). No se requiere accion.'
            NotFound        = '  [!] Microsoft Store no encontrada en este sistema.'
            SkipWsreset     = '[2/3] Omitiendo wsreset -i (build LTSC/IoT detectado -- no es confiable).'
            TryWsreset      = '[2/3] Intentando wsreset -i (metodo oficial de Microsoft)...'
            WsresetWait     = '  [i] Esperando hasta 90 s para que aparezca la Store...'
            WsresetOk       = '  [OK] Microsoft Store instalada via wsreset.'
            WsresetFail     = '  [!] wsreset no instalo la Store. Intentando metodo bundle.'
            BundleHeader    = '[3/3] Descargando bundle de la Store desde CDN de Microsoft...'
            BundleOffline   = '[3/3] Instalando bundle de la Store desde cache USB...'
            BundleLocal     = '[3/3] Instalando bundle de la Store desde cache local...'
            Downloading     = '  [>] {0} (~{1} MB)...'
            DownloadOk      = ' [OK]'
            DownloadFail    = ' [FAIL]: {0}'
            Installing      = '  Instalando paquetes...'
            InstallOk       = '  [OK] Microsoft Store instalada correctamente.'
            InstallFail     = '  [X] Error de instalacion: {0}'
            ManualSteps     = '  Alternativa manual:'
            ManualStep1     = '    Configuracion > Aplicaciones > Caracteristicas opcionales > Agregar > "Microsoft Store"'
            ManualStep2     = '    O ejecuta: wsreset -i   (en builds compatibles de Windows 11)'
            ManualStep3     = '    O usa PrepararUSB para descargar el bundle a un USB, luego vuelve a ejecutar esta herramienta con el USB conectado.'
            NeedAdmin       = '[!] Se requieren privilegios de administrador. Relanza como admin.'
            EnterExit       = 'Presiona Enter para salir...'
            DepsInstalling  = '  Instalando dependencia: {0}'
            DepsOk          = '  [OK] Dependencia instalada: {0}'
            DepsFail        = '  [!] Dependencia fallo ({0}): {1}'
        }
    }

    $lang = _Atlas-DetectLang
    if (-not $T.ContainsKey($lang)) { $lang = 'en' }
    $L = $T[$lang]

    # --- Console setup ---
    try { $Host.UI.RawUI.WindowTitle = $L.Title } catch {}
    try { $Host.UI.RawUI.BackgroundColor = 'Black'; $Host.UI.RawUI.ForegroundColor = 'Gray' } catch {}
    try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(80, 35) } catch {}
    Clear-Host

    # --- Admin check ---
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        Write-Host $L.NeedAdmin -ForegroundColor Red
        Read-Host $L.EnterExit
        return
    }

    # --- OS / build detection ---
    $osInfo   = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
    $build    = [int]$osInfo.BuildNumber
    $caption  = $osInfo.Caption
    $isW11    = $build -ge 22000
    $isLTSC   = $caption -match 'LTSC|IoT'

    # --- Header ---
    Write-Host ''
    Write-Host $L.Separator -ForegroundColor DarkGray
    Write-Host "   $($L.Title)" -ForegroundColor Yellow
    Write-Host "   $caption (Build $build)" -ForegroundColor Gray
    Write-Host $L.Separator -ForegroundColor DarkGray
    Write-Host ''

    # --- Step 1: Detect ---
    Write-Host $L.CheckingStore -ForegroundColor Cyan
    $storeApp = Get-AppxPackage -Name 'Microsoft.WindowsStore' -ErrorAction SilentlyContinue
    if ($storeApp) {
        Write-Host ($L.AlreadyInstalled -f $storeApp.Version) -ForegroundColor Green
        Write-Host ''
        Read-Host $L.EnterExit
        return
    }
    Write-Host $L.NotFound -ForegroundColor Yellow
    Write-Host ''

    # --- Step 2: wsreset -i ---
    $installedViaWsreset = $false
    if ($isW11 -and -not $isLTSC) {
        Write-Host $L.TryWsreset -ForegroundColor Cyan
        Write-Host $L.WsresetWait -ForegroundColor Gray
        try {
            Start-Process 'wsreset.exe' -ArgumentList '-i' -WindowStyle Hidden -ErrorAction Stop
            $deadline = (Get-Date).AddSeconds(90)
            while ((Get-Date) -lt $deadline) {
                Start-Sleep -Seconds 5
                $check = Get-AppxPackage -Name 'Microsoft.WindowsStore' -ErrorAction SilentlyContinue
                if ($check) {
                    Write-Host $L.WsresetOk -ForegroundColor Green
                    $installedViaWsreset = $true
                    break
                }
            }
        } catch {}
        if (-not $installedViaWsreset) {
            Write-Host $L.WsresetFail -ForegroundColor Yellow
        }
        Write-Host ''
    } else {
        Write-Host $L.SkipWsreset -ForegroundColor Gray
        Write-Host ''
    }

    if ($installedViaWsreset) {
        Read-Host $L.EnterExit
        return
    }

    # --- Step 3: Bundle install ---
    # Package definitions: Name, URL, approx size in MB, destination filename
    $packages = @(
        @{
            Name    = 'VCLibs.x64.14.00.Desktop.appx'
            Url     = 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
            SizeMB  = 6
        },
        @{
            Name    = 'Microsoft.UI.Xaml.2.8.x64.appx'
            Url     = 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx'
            SizeMB  = 17
        },
        @{
            Name    = 'Microsoft.WindowsStore.appxbundle'
            Url     = 'https://storeedgefd.dsx.mp.microsoft.com/v9.0/packageManifests/9WZDNCRFJBMP'
            SizeMB  = 28
        }
    )

    # Determine cache source in priority order:
    # 1. USB offline: $env:ATLAS_OFFLINE_ROOT\deps\MicrosoftStore\
    # 2. Local cache: $env:LOCALAPPDATA\AtlasPC\bin\MicrosoftStore\
    # 3. Download -> save to local cache
    $usbStoreDir   = if ($env:ATLAS_OFFLINE_ROOT) { Join-Path $env:ATLAS_OFFLINE_ROOT 'deps\MicrosoftStore' } else { $null }
    $localStoreDir = Join-Path $env:LOCALAPPDATA 'AtlasPC\bin\MicrosoftStore'

    # Choose header label based on source availability
    $usbHasAll = $usbStoreDir -and (Test-Path $usbStoreDir) -and (
        $packages | ForEach-Object { Test-Path (Join-Path $usbStoreDir $_.Name) } | Where-Object { -not $_ } | Measure-Object
    ).Count -eq 0
    $localHasAll = (Test-Path $localStoreDir) -and (
        $packages | ForEach-Object { Test-Path (Join-Path $localStoreDir $_.Name) } | Where-Object { -not $_ } | Measure-Object
    ).Count -eq 0

    if ($usbHasAll) {
        Write-Host $L.BundleOffline -ForegroundColor Cyan
    } elseif ($localHasAll) {
        Write-Host $L.BundleLocal -ForegroundColor Cyan
    } else {
        Write-Host $L.BundleHeader -ForegroundColor Cyan
    }

    if (-not (Test-Path $localStoreDir)) {
        New-Item -ItemType Directory -Path $localStoreDir -Force | Out-Null
    }

    # Resolve each package file path (USB -> local cache -> download)
    $resolvedPaths = @()
    $downloadFailed = $false
    $ProgressPreference = 'SilentlyContinue'

    foreach ($pkg in $packages) {
        $usbFile   = if ($usbStoreDir) { Join-Path $usbStoreDir   $pkg.Name } else { $null }
        $localFile = Join-Path $localStoreDir $pkg.Name

        if ($usbFile -and (Test-Path -LiteralPath $usbFile)) {
            $resolvedPaths += $usbFile
            continue
        }
        if (Test-Path -LiteralPath $localFile) {
            $resolvedPaths += $localFile
            continue
        }
        # Download
        Write-Host ($L.Downloading -f $pkg.Name, $pkg.SizeMB) -ForegroundColor Gray -NoNewline
        try {
            Invoke-WebRequest -Uri $pkg.Url -OutFile $localFile -UseBasicParsing -TimeoutSec 120 -ErrorAction Stop
            Write-Host $L.DownloadOk -ForegroundColor Green
            $resolvedPaths += $localFile
        } catch {
            Write-Host ($L.DownloadFail -f $_.Exception.Message) -ForegroundColor Red
            $downloadFailed = $true
            break
        }
    }

    if ($downloadFailed) {
        Write-Host ''
        Write-Host $L.ManualSteps -ForegroundColor Yellow
        Write-Host $L.ManualStep1 -ForegroundColor Gray
        Write-Host $L.ManualStep2 -ForegroundColor Gray
        Write-Host $L.ManualStep3 -ForegroundColor Gray
        Write-Host ''
        Read-Host $L.EnterExit
        return
    }

    # Install packages in order
    Write-Host $L.Installing -ForegroundColor Cyan
    $installFailed = $false
    foreach ($pkgIdx in 0..($resolvedPaths.Count - 1)) {
        $pkgPath = $resolvedPaths[$pkgIdx]
        $pkgName = $packages[$pkgIdx].Name
        Write-Host ($L.DepsInstalling -f $pkgName) -ForegroundColor Gray
        try {
            Add-AppxPackage -Path $pkgPath -ForceApplicationShutdown -ErrorAction Stop
            Write-Host ($L.DepsOk -f $pkgName) -ForegroundColor Green
        } catch {
            # VCLibs and UI.Xaml often report "already installed" as an error -- ignore those
            if ($_.Exception.Message -match 'already installed|0x80073CFB|0x80073D0A') {
                Write-Host ($L.DepsOk -f "$pkgName (already present)") -ForegroundColor DarkGray
            } else {
                Write-Host ($L.DepsFail -f $pkgName, $_.Exception.Message) -ForegroundColor Red
                $installFailed = $true
                break
            }
        }
    }

    Write-Host ''
    if (-not $installFailed) {
        $storeCheck = Get-AppxPackage -Name 'Microsoft.WindowsStore' -ErrorAction SilentlyContinue
        if ($storeCheck) {
            Write-Host $L.InstallOk -ForegroundColor Green
        } else {
            Write-Host ($L.InstallFail -f 'Store package not found after install.') -ForegroundColor Red
            Write-Host $L.ManualSteps -ForegroundColor Yellow
            Write-Host $L.ManualStep1 -ForegroundColor Gray
            Write-Host $L.ManualStep2 -ForegroundColor Gray
            Write-Host $L.ManualStep3 -ForegroundColor Gray
        }
    } else {
        Write-Host $L.ManualSteps -ForegroundColor Yellow
        Write-Host $L.ManualStep1 -ForegroundColor Gray
        Write-Host $L.ManualStep2 -ForegroundColor Gray
        Write-Host $L.ManualStep3 -ForegroundColor Gray
    }
    Write-Host ''
    Read-Host $L.EnterExit
}
