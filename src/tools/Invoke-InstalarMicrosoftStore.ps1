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
}
