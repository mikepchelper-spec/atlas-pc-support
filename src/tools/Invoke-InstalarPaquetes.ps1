# ============================================================
# Invoke-InstalarPaquetes  ->  Bulk App Installer (winget)
#
# Pilot tool for the EN/ES i18n migration ("Option A" — strings
# centralized per tool). Default language is English; Spanish
# kept as full secondary translation (read from
# %LOCALAPPDATA%\AtlasPC\config.json -> language).
#
# Atlas PC Support
# ============================================================

function Invoke-InstalarPaquetes {
    [CmdletBinding()]
    param()

    $ErrorActionPreference = 'Continue'
    $Host.UI.RawUI.WindowTitle = 'ATLAS PC SUPPORT - Bulk App Installer'
    try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(115, 44) } catch {}

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

    # --- Localized strings ---
    $T = @{
        en = @{
            Title              = 'ATLAS PC SUPPORT - BULK APP INSTALLER (winget)'
            WingetVersion      = 'winget version: {0}'
            WingetUnavailable  = '[X] winget is not available on this system.'
            WingetHintWin10    = '    Old Windows 10: install "App Installer" from Microsoft Store.'
            WingetHintWin11    = '    Windows 11: should ship preinstalled; run Windows Update.'
            EnterToExit        = '  Press ENTER to exit'
            EnterToContinue    = '  Press ENTER to continue'
            Menu               = 'MENU:'
            Menu1              = '[1] Pick packages from catalog'
            Menu2              = '[2] Load saved profile'
            Menu3              = '[3] View current selection'
            Menu4              = '[4] Save selection as profile'
            Menu5              = '[5] Install current selection'
            Menu6              = '[6] Search winget'
            MenuQ              = '[Q] Quit'
            CurrentSelection   = 'Current selection: {0} package(s)'
            Option             = 'Option'
            InvalidOption      = '[!] Invalid option.'
            PickHint           = 'Pick packages by number. Examples:'
            PickEx1            = '"1,3,5"   (individual)'
            PickEx2            = '"1-10"    (range)'
            PickEx3            = '"all"     (all)'
            Packages           = 'Packages'
            AddedNToSelection  = '[OK] {0} package(s) in selection.'
            NothingPicked      = '[!] Nothing picked.'
            NoSelectionToView  = '(no selection)'
            CurrentlyN         = 'Current selection ({0}):'
            NoSelectionToInst  = '[!] No packages selected.'
            ConfirmInstall     = 'Continue? [Y/n]'
            Cancelled          = 'Cancelled.'
            ToInstallN         = 'Will install {0} package(s):'
            Installing         = '[>] {0}'
            InstalledOK        = '    [OK] Installed.'
            AlreadyInstalled   = '    [=] Already installed.'
            InstallFailed      = '    [X] Failed (exit={0}).'
            InstallException   = '    [X] Exception: {0}'
            Summary            = 'Summary: {0} OK / {1} already installed / {2} failed'
            ProfileName        = 'Profile name (e.g. "client-alice")'
            NothingToSave      = '[!] Nothing to save.'
            ProfileSaved       = '[OK] Profile saved: {0}'
            ProfileSaveError   = '[X] Save error: {0}'
            NoProfilesFound    = '[!] No profiles saved at:'
            ProfilesAvailable  = 'Available profiles:'
            ProfileNumber      = 'Profile number (or ENTER to cancel)'
            InvalidSelection   = '[X] Invalid selection.'
            ProfileLoaded      = '[OK] Loaded "{0}" with {1} package(s).'
            ProfileReadError   = '[X] Profile read error: {0}'
            SearchPrompt       = 'Type a search term and the tool will query winget.'
            SearchTerm         = 'Search term'
            Searching          = 'Searching winget for: {0}'
            NoResults          = '[!] No results.'
            RawOutputHint      = 'Raw output from winget (for diagnostics):'
            NoOutput           = '(no output)'
            SearchPickPrompt   = 'Pick number(s) to add (e.g. "1,3" — ENTER to cancel)'
            SearchAdded        = '[OK] {0} package(s) added from search.'
            CleanTempName      = 'Clean Temporary Files'
            CleanTempCategory  = 'Cleanup'
            CleaningTemp       = 'Cleaning temporary files...'
            CleanupSummary     = 'Total freed: {0:N1} MB'
            ActionDone         = '[OK] {0} done.'
            ActionFailed       = '[X] {0} failed: {1}'
            NoteRequiresLic    = 'requires license'
            CategoryBrowsers   = 'Browsers'
            CategoryMultimedia = 'Multimedia'
            CategoryOffice     = 'Office'
            CategoryCommunic   = 'Communication'
            CategoryUtilities  = 'Utilities'
            CategoryDevelop    = 'Development'
            CategorySecurity   = 'Security'
            CategoryNetwork    = 'Network'
            CategoryGaming     = 'Gaming'
            CategoryNotes      = 'Notes & Productivity'
        }
        es = @{
            Title              = 'ATLAS PC SUPPORT - INSTALADOR DE PAQUETES (winget)'
            WingetVersion      = 'Version de winget: {0}'
            WingetUnavailable  = '[X] winget no esta disponible en este sistema.'
            WingetHintWin10    = '    Windows 10 antiguo: instalar "App Installer" desde Microsoft Store.'
            WingetHintWin11    = '    Windows 11: deberia venir preinstalado; ejecuta Windows Update.'
            EnterToExit        = '  Presiona ENTER para salir'
            EnterToContinue    = '  ENTER para continuar'
            Menu               = 'MENU:'
            Menu1              = '[1] Seleccionar paquetes del catalogo'
            Menu2              = '[2] Cargar perfil guardado'
            Menu3              = '[3] Ver seleccion actual'
            Menu4              = '[4] Guardar seleccion como perfil'
            Menu5              = '[5] Instalar seleccion actual'
            Menu6              = '[6] Buscar en winget'
            MenuQ              = '[Q] Salir'
            CurrentSelection   = 'Seleccion actual: {0} paquete(s)'
            Option             = 'Opcion'
            InvalidOption      = '[!] Opcion no valida.'
            PickHint           = 'Selecciona paquetes por numero. Ejemplos:'
            PickEx1            = '"1,3,5"   (individuales)'
            PickEx2            = '"1-10"    (rango)'
            PickEx3            = '"all"     (todos)'
            Packages           = 'Paquetes'
            AddedNToSelection  = '[OK] {0} paquete(s) en seleccion.'
            NothingPicked      = '[!] Nada seleccionado.'
            NoSelectionToView  = '(sin seleccion)'
            CurrentlyN         = 'Seleccion actual ({0}):'
            NoSelectionToInst  = '[!] No hay paquetes seleccionados.'
            ConfirmInstall     = 'Continuar? [S/n]'
            Cancelled          = 'Cancelado.'
            ToInstallN         = 'A instalar {0} paquete(s):'
            Installing         = '[>] {0}'
            InstalledOK        = '    [OK] Instalado.'
            AlreadyInstalled   = '    [=] Ya instalado.'
            InstallFailed      = '    [X] Fallo (exit={0}).'
            InstallException   = '    [X] Excepcion: {0}'
            Summary            = 'Resumen: {0} OK / {1} ya instalados / {2} fallidos'
            ProfileName        = 'Nombre del perfil (ej. "cliente-alice")'
            NothingToSave      = '[!] No hay paquetes para guardar.'
            ProfileSaved       = '[OK] Perfil guardado: {0}'
            ProfileSaveError   = '[X] Error guardando: {0}'
            NoProfilesFound    = '[!] No hay perfiles guardados en:'
            ProfilesAvailable  = 'Perfiles disponibles:'
            ProfileNumber      = 'Numero de perfil (o ENTER para cancelar)'
            InvalidSelection   = '[X] Seleccion invalida.'
            ProfileLoaded      = '[OK] Cargado "{0}" con {1} paquete(s).'
            ProfileReadError   = '[X] Error leyendo perfil: {0}'
            SearchPrompt       = 'Escribe un termino y la tool lo busca en winget.'
            SearchTerm         = 'Termino de busqueda'
            Searching          = 'Buscando en winget: {0}'
            NoResults          = '[!] Sin resultados.'
            RawOutputHint      = 'Salida cruda de winget (para diagnostico):'
            NoOutput           = '(sin salida)'
            SearchPickPrompt   = 'Numero(s) a agregar (ej. "1,3" — ENTER para cancelar)'
            SearchAdded        = '[OK] {0} paquete(s) agregado(s) desde la busqueda.'
            CleanTempName      = 'Limpiar archivos temporales'
            CleanTempCategory  = 'Limpieza'
            CleaningTemp       = 'Limpiando archivos temporales...'
            CleanupSummary     = 'Total liberado: {0:N1} MB'
            ActionDone         = '[OK] {0} completado.'
            ActionFailed       = '[X] {0} fallo: {1}'
            NoteRequiresLic    = 'requiere licencia'
            CategoryBrowsers   = 'Navegadores'
            CategoryMultimedia = 'Multimedia'
            CategoryOffice     = 'Oficina'
            CategoryCommunic   = 'Comunicacion'
            CategoryUtilities  = 'Utilidades'
            CategoryDevelop    = 'Desarrollo'
            CategorySecurity   = 'Seguridad'
            CategoryNetwork    = 'Redes'
            CategoryGaming     = 'Gaming'
            CategoryNotes      = 'Notas y Productividad'
        }
    }

    $lang = _Atlas-DetectLang
    if (-not $T.ContainsKey($lang)) { $lang = 'en' }
    $L = $T[$lang]

    # --- Config ---
    $PROFILE_DIR = Join-Path $env:LOCALAPPDATA 'AtlasPC\winget-profiles'
    if (-not (Test-Path $PROFILE_DIR)) {
        New-Item -ItemType Directory -Path $PROFILE_DIR -Force | Out-Null
    }

    # --- Catalog ---
    # Keys are localized category labels; entries can be:
    #   winget package : @{ Id; Name; [NoteKey]; [Source='winget'|'msstore'] }
    #   action item    : @{ Id='__action:<name>'; Name; Type='action'; Handler=<scriptblock-name> }
    $CATALOG = [ordered]@{
        ($L.CategoryBrowsers) = @(
            @{ Id='Google.Chrome';                       Name='Google Chrome' },
            @{ Id='Mozilla.Firefox';                     Name='Mozilla Firefox' },
            @{ Id='Brave.Brave';                         Name='Brave Browser' },
            @{ Id='Opera.Opera';                         Name='Opera' }
        )
        ($L.CategoryMultimedia) = @(
            @{ Id='VideoLAN.VLC';                        Name='VLC Media Player' },
            @{ Id='Spotify.Spotify';                     Name='Spotify' },
            @{ Id='OBSProject.OBSStudio';                Name='OBS Studio' },
            @{ Id='Audacity.Audacity';                   Name='Audacity' },
            @{ Id='FreeDownloadManager.FreeDownloadManager'; Name='Free Download Manager' },
            @{ Id='qBittorrent.qBittorrent';             Name='qBittorrent' }
        )
        ($L.CategoryOffice) = @(
            @{ Id='Microsoft.Office';                    Name='Microsoft 365'; NoteKey='RequiresLicense' },
            @{ Id='TheDocumentFoundation.LibreOffice';   Name='LibreOffice' },
            @{ Id='ONLYOFFICE.DesktopEditors';           Name='ONLYOFFICE Desktop Editors' },
            @{ Id='Adobe.Acrobat.Reader.64-bit';         Name='Adobe Acrobat Reader' }
        )
        ($L.CategoryNotes) = @(
            @{ Id='Notion.Notion';                       Name='Notion' },
            @{ Id='Obsidian.Obsidian';                   Name='Obsidian' },
            @{ Id='SimnetLtd.SimpleStickyNotes';         Name='Simple Sticky Notes' },
            @{ Id='LanguageToolGmbH.LanguageToolForDesktop'; Name='LanguageTool for Desktop' }
        )
        ($L.CategoryCommunic) = @(
            @{ Id='Zoom.Zoom';                           Name='Zoom' },
            @{ Id='Microsoft.Teams';                     Name='Microsoft Teams' },
            @{ Id='Discord.Discord';                     Name='Discord' },
            @{ Id='OpenWhisperSystems.Signal';           Name='Signal' },
            @{ Id='Telegram.TelegramDesktop';            Name='Telegram Desktop' },
            @{ Id='WhatsApp.WhatsApp';                   Name='WhatsApp Desktop' },
            @{ Id='9NFHQRDFLG40';                        Name='JW Library'; Source='msstore' }
        )
        ($L.CategoryUtilities) = @(
            @{ Id='7zip.7zip';                           Name='7-Zip' },
            @{ Id='RARLab.WinRAR';                       Name='WinRAR' },
            @{ Id='Microsoft.PowerToys';                 Name='PowerToys' },
            @{ Id='voidtools.Everything';                Name='Everything (search)' },
            @{ Id='Greenshot.Greenshot';                 Name='Greenshot (screenshots)' },
            @{ Id='ShareX.ShareX';                       Name='ShareX' },
            @{ Id='WinDirStat.WinDirStat';               Name='WinDirStat' },
            @{ Id='Rufus.Rufus';                         Name='Rufus (USB boot)' },
            @{ Id='CPUID.CPU-Z';                         Name='CPU-Z' },
            @{ Id='TechPowerUp.GPU-Z';                   Name='GPU-Z' },
            @{ Id='CrystalDewWorld.CrystalDiskInfo';     Name='CrystalDiskInfo' },
            @{ Id='Seafile.Seafile-Client';              Name='Seafile Client' },
            @{ Id='w4po.ExplorerTabUtility';             Name='Explorer Tab Utility' }
        )
        ($L.CategoryDevelop) = @(
            @{ Id='Microsoft.VisualStudioCode';          Name='Visual Studio Code' },
            @{ Id='Git.Git';                             Name='Git' },
            @{ Id='GitHub.GitHubDesktop';                Name='GitHub Desktop' },
            @{ Id='OpenJS.NodeJS.LTS';                   Name='Node.js LTS' },
            @{ Id='Python.Python.3.12';                  Name='Python 3.12' },
            @{ Id='Microsoft.PowerShell';                Name='PowerShell 7' },
            @{ Id='Microsoft.WindowsTerminal';           Name='Windows Terminal' }
        )
        ($L.CategorySecurity) = @(
            @{ Id='Malwarebytes.Malwarebytes';           Name='Malwarebytes' },
            @{ Id='Bitdefender.Bitdefender';             Name='Bitdefender Antivirus Free' },
            @{ Id='Bitwarden.Bitwarden';                 Name='Bitwarden' },
            @{ Id='KeePassXCTeam.KeePassXC';             Name='KeePassXC' }
        )
        ($L.CategoryNetwork) = @(
            @{ Id='WireGuard.WireGuard';                 Name='WireGuard' }
        )
        ($L.CategoryGaming) = @(
            @{ Id='Valve.Steam';                         Name='Steam' },
            @{ Id='EpicGames.EpicGamesLauncher';         Name='Epic Games Launcher' }
        )
        ($L.CleanTempCategory) = @(
            @{ Id='__action:clean-temp'; Name=$L.CleanTempName; Type='action'; Handler='Clean-TempFiles' }
        )
    }

    # ============================================================
    # Helpers
    # ============================================================

    function Write-Header {
        Clear-Host
        Write-Host ''
        Write-Host '  ================================================================' -ForegroundColor Cyan
        Write-Host ('  ' + $L.Title) -ForegroundColor Yellow
        Write-Host '  ================================================================' -ForegroundColor Cyan
        Write-Host ''
    }

    function Test-WingetAvailable {
        $cmd = Get-Command winget.exe -ErrorAction SilentlyContinue
        return ($null -ne $cmd)
    }

    function Format-Pkg {
        param($Pkg)
        $name = $Pkg.Name
        if ($Pkg.NoteKey) {
            $note = switch ($Pkg.NoteKey) {
                'RequiresLicense' { $L.NoteRequiresLic }
                default { $Pkg.NoteKey }
            }
            $name = '{0} ({1})' -f $name, $note
        }
        return $name
    }

    function Show-Catalog {
        # Regular hashtable. NOT [ordered] — see comment in original code:
        # in PS 7 [int] index on ordered dict picks by POSITION not key.
        $map = @{}
        $idx = 1
        foreach ($cat in $CATALOG.Keys) {
            Write-Host ''
            Write-Host "  --- $cat ---" -ForegroundColor Yellow
            foreach ($pkg in $CATALOG[$cat]) {
                $display = Format-Pkg -Pkg $pkg
                Write-Host ('  [{0,3}] {1,-48} ({2})' -f $idx, $display, $pkg.Id) -ForegroundColor Gray
                $entry = @{ Id=$pkg.Id; Name=$display; Category=$cat }
                if ($pkg.Type)    { $entry.Type    = $pkg.Type }
                if ($pkg.Handler) { $entry.Handler = $pkg.Handler }
                if ($pkg.Source)  { $entry.Source  = $pkg.Source }
                $map[$idx] = $entry
                $idx++
            }
        }
        return $map
    }

    function Parse-Selection {
        param([string]$InputText, $Map)
        $InputText = $InputText.Trim()
        if ($InputText -match '^(?i)all$') { return @($Map.Values) }
        if ($InputText -match '^(?i)(none|q|quit|)$') { return @() }
        $selected = @()
        $tokens = $InputText -split '[,\s]+' | Where-Object { $_ -ne '' }
        foreach ($t in $tokens) {
            if ($t -match '^\d+-\d+$') {
                $parts = $t.Split('-')
                $from = [int]$parts[0]
                $to   = [int]$parts[1]
                for ($i = $from; $i -le $to; $i++) {
                    if ($Map.Contains($i)) { $selected += $Map[$i] }
                }
            } elseif ($t -match '^\d+$') {
                $n = [int]$t
                if ($Map.Contains($n)) { $selected += $Map[$n] }
            }
        }
        $seen = @{}
        $out = @()
        foreach ($s in $selected) {
            if (-not $seen.ContainsKey($s.Id)) {
                $seen[$s.Id] = $true
                $out += $s
            }
        }
        return $out
    }

    function Clean-TempFiles {
        Write-Host ''
        Write-Host ('  ' + $L.CleaningTemp) -ForegroundColor Cyan
        $totalFreed = 0L
        $targets = @(
            @{ Path = $env:TEMP;                                   Label = 'User TEMP' },
            @{ Path = (Join-Path $env:LOCALAPPDATA 'Temp');        Label = 'LocalAppData Temp' },
            @{ Path = 'C:\Windows\Temp';                           Label = 'Windows TEMP' },
            @{ Path = 'C:\Windows\Prefetch';                       Label = 'Prefetch' }
        )
        foreach ($t in $targets) {
            if (-not $t.Path) { continue }
            if (-not (Test-Path -LiteralPath $t.Path)) { continue }
            try {
                $sizeBefore = 0L
                Get-ChildItem -LiteralPath $t.Path -Recurse -Force -ErrorAction SilentlyContinue |
                    ForEach-Object { if ($_.PSIsContainer -eq $false) { $sizeBefore += $_.Length } }
                Get-ChildItem -LiteralPath $t.Path -Force -ErrorAction SilentlyContinue | ForEach-Object {
                    Remove-Item -LiteralPath $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
                }
                $sizeAfter = 0L
                Get-ChildItem -LiteralPath $t.Path -Recurse -Force -ErrorAction SilentlyContinue |
                    ForEach-Object { if ($_.PSIsContainer -eq $false) { $sizeAfter += $_.Length } }
                $freed = [math]::Max(0, $sizeBefore - $sizeAfter)
                $totalFreed += $freed
                Write-Host ('    [OK] {0,-22} {1,10:N1} MB' -f $t.Label, ($freed / 1MB)) -ForegroundColor Green
            } catch {
                Write-Host ('    [!]  {0,-22} {1}' -f $t.Label, $_.Exception.Message) -ForegroundColor Yellow
            }
        }
        Write-Host ''
        Write-Host ('  ' + ($L.CleanupSummary -f ($totalFreed / 1MB))) -ForegroundColor Cyan
    }

    function Invoke-PackageInstall {
        param($Pkg)
        # NOTE: do NOT name this $args — that's a PowerShell automatic
        # variable and PSScriptAnalyzer flags it; future PS versions may
        # make it read-only and break splatting silently.
        $wingetArgs = @('install', '--id', $Pkg.Id, '--exact', '--silent',
                        '--accept-package-agreements', '--accept-source-agreements',
                        '--disable-interactivity')
        # Pkg.Source may be 'winget', 'msstore', or empty/null (unknown
        # — e.g. results from the no-source-filter search fallback). When
        # empty we omit --source entirely so winget resolves it itself.
        if ($Pkg.Source -and [string]$Pkg.Source -ne '') {
            $wingetArgs += @('--source', [string]$Pkg.Source)
        }
        $output = & winget.exe @wingetArgs 2>&1
        return @{ Exit = $LASTEXITCODE; Output = $output }
    }

    function Install-Packages {
        param([array]$Packages)

        if (-not $Packages -or $Packages.Count -eq 0) {
            Write-Host ('  ' + $L.NoSelectionToInst) -ForegroundColor Yellow
            return
        }

        Write-Host ''
        Write-Host ('  ' + ($L.ToInstallN -f $Packages.Count)) -ForegroundColor Cyan
        foreach ($p in $Packages) {
            Write-Host ('    - {0,-48} ({1})' -f $p.Name, $p.Id) -ForegroundColor Gray
        }
        Write-Host ''
        $confirm = Read-Host ('  ' + $L.ConfirmInstall)
        if ($confirm -match '^[Nn]') { Write-Host ('  ' + $L.Cancelled) -ForegroundColor DarkGray; return }

        $ok = 0; $fail = 0; $already = 0
        foreach ($p in $Packages) {
            Write-Host ''
            Write-Host ('  ' + ($L.Installing -f $p.Name)) -ForegroundColor Cyan

            if ($p.Type -eq 'action') {
                # `continue` inside `switch` only exits the switch, not the
                # enclosing foreach — so use a flag instead of `continue`.
                $handlerFailed = $false
                try {
                    switch ($p.Handler) {
                        'Clean-TempFiles' { Clean-TempFiles }
                        default {
                            Write-Host ('    [X] Unknown action handler: {0}' -f $p.Handler) -ForegroundColor Red
                            $fail++
                            $handlerFailed = $true
                        }
                    }
                    if (-not $handlerFailed) {
                        Write-Host ('    ' + ($L.ActionDone -f $p.Name)) -ForegroundColor Green
                        $ok++
                    }
                } catch {
                    Write-Host ('    ' + ($L.ActionFailed -f $p.Name, $_.Exception.Message)) -ForegroundColor Red
                    $fail++
                }
                continue
            }

            try {
                $r = Invoke-PackageInstall -Pkg $p
                switch ($r.Exit) {
                    0 { Write-Host ('  ' + $L.InstalledOK) -ForegroundColor Green; $ok++ }
                    -1978335189 { Write-Host ('  ' + $L.AlreadyInstalled) -ForegroundColor DarkGray; $already++ }
                    -1978335212 { Write-Host ('  ' + $L.AlreadyInstalled) -ForegroundColor DarkGray; $already++ }
                    default {
                        Write-Host ('  ' + ($L.InstallFailed -f $r.Exit)) -ForegroundColor Red
                        $fail++
                        if ($r.Output) {
                            $r.Output | Select-Object -Last 3 | ForEach-Object {
                                Write-Host ('          ' + $_) -ForegroundColor DarkGray
                            }
                        }
                    }
                }
            } catch {
                Write-Host ('  ' + ($L.InstallException -f $_.Exception.Message)) -ForegroundColor Red
                $fail++
            }
        }

        Write-Host ''
        Write-Host '  ================================================================' -ForegroundColor Cyan
        Write-Host ('  ' + ($L.Summary -f $ok, $already, $fail)) -ForegroundColor White
        Write-Host '  ================================================================' -ForegroundColor Cyan
    }

    function Save-Profile {
        param([array]$Packages)
        if (-not $Packages -or $Packages.Count -eq 0) {
            Write-Host ('  ' + $L.NothingToSave) -ForegroundColor Yellow
            return
        }
        Write-Host ''
        $name = Read-Host ('  ' + $L.ProfileName)
        $name = $name.Trim()
        if (-not $name) { Write-Host ('  ' + $L.Cancelled) -ForegroundColor DarkGray; return }
        $safe = ($name -replace '[^\w\-\.]', '_')
        $file = Join-Path $PROFILE_DIR ("$safe.json")

        $obj = [ordered]@{
            schema   = 'atlas-winget-profile-v1'
            name     = $name
            created  = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
            packages = @($Packages | ForEach-Object {
                $p = [ordered]@{ id=$_.Id; name=$_.Name; category=$_.Category }
                if ($_.Type)    { $p.type    = $_.Type }
                if ($_.Handler) { $p.handler = $_.Handler }
                if ($_.Source)  { $p.source  = $_.Source }
                $p
            })
        }
        try {
            ConvertTo-Json -InputObject $obj -Depth 5 | Set-Content -Path $file -Encoding UTF8
            Write-Host ('  ' + ($L.ProfileSaved -f $file)) -ForegroundColor Green
        } catch {
            Write-Host ('  ' + ($L.ProfileSaveError -f $_.Exception.Message)) -ForegroundColor Red
        }
    }

    function Load-Profile {
        $files = @(Get-ChildItem -Path $PROFILE_DIR -Filter '*.json' -ErrorAction SilentlyContinue | Sort-Object Name)
        if (-not $files -or $files.Count -eq 0) {
            Write-Host ''
            Write-Host ('  ' + $L.NoProfilesFound) -ForegroundColor Yellow
            Write-Host ('       ' + $PROFILE_DIR) -ForegroundColor DarkGray
            return @()
        }
        Write-Host ''
        Write-Host ('  ' + $L.ProfilesAvailable) -ForegroundColor Yellow
        for ($i = 0; $i -lt $files.Count; $i++) {
            Write-Host ('    [{0}] {1}' -f ($i+1), $files[$i].Name) -ForegroundColor Cyan
        }
        Write-Host ''
        $sel = Read-Host ('  ' + $L.ProfileNumber)
        if (-not $sel) { return @() }
        $n = 0
        if (-not [int]::TryParse($sel, [ref]$n) -or $n -lt 1 -or $n -gt $files.Count) {
            Write-Host ('  ' + $L.InvalidSelection) -ForegroundColor Red
            return @()
        }
        $file = $files[$n-1]
        try {
            $raw = Get-Content -Raw -Path $file.FullName
            $obj = $raw | ConvertFrom-Json
            $packages = @($obj.packages | ForEach-Object {
                $entry = @{ Id=$_.id; Name=$_.name; Category=$_.category }
                if ($_.type)    { $entry.Type    = [string]$_.type }
                if ($_.handler) { $entry.Handler = [string]$_.handler }
                if ($_.source)  { $entry.Source  = [string]$_.source }
                $entry
            })
            Write-Host ('  ' + ($L.ProfileLoaded -f $obj.name, $packages.Count)) -ForegroundColor Green
            return $packages
        } catch {
            Write-Host ('  ' + ($L.ProfileReadError -f $_.Exception.Message)) -ForegroundColor Red
            return @()
        }
    }

    function _Parse-WingetSearchOutput {
        param([string[]]$Lines, [string]$SourceTag)

        $sepIdx = -1
        for ($i = 0; $i -lt $Lines.Count; $i++) {
            if ($Lines[$i] -match '^[\s\-─━]+$' -and $Lines[$i] -match '[\-─━]{3,}') {
                $sepIdx = $i; break
            }
        }
        if ($sepIdx -lt 1) { return @() }

        $headerLine = $Lines[$sepIdx - 1]
        $sepLine    = $Lines[$sepIdx]

        $cols = @()
        foreach ($m in [regex]::Matches($sepLine, '[\-─━]+')) {
            $cols += @{ Start = $m.Index; Length = $m.Length }
        }
        if ($cols.Count -lt 2) { return @() }

        $colNames = @()
        for ($c = 0; $c -lt $cols.Count; $c++) {
            $start = $cols[$c].Start
            $end   = if ($c -lt $cols.Count - 1) { $cols[$c+1].Start } else { $headerLine.Length }
            $end   = [Math]::Min($end, $headerLine.Length)
            $name  = if ($start -lt $headerLine.Length) { $headerLine.Substring($start, $end - $start).Trim() } else { '' }
            $colNames += $name
        }

        $results = @()
        for ($i = $sepIdx + 1; $i -lt $Lines.Count; $i++) {
            $line = $Lines[$i]
            if ([string]::IsNullOrWhiteSpace($line)) { continue }
            $row = @{}
            for ($c = 0; $c -lt $cols.Count; $c++) {
                $start = $cols[$c].Start
                if ($start -ge $line.Length) { continue }
                $end = if ($c -lt $cols.Count - 1) { $cols[$c+1].Start } else { $line.Length }
                $end = [Math]::Min($end, $line.Length)
                $val = $line.Substring($start, $end - $start).Trim()
                $row[$colNames[$c]] = $val
            }
            # Tolerant header match: winget localizes column names per UI culture.
            # Known variants: en (Name/Id/Version), es (Nombre/Id/Versión), pt
            # (Nome/Versão), fr (Nom/Version), de (Name/Version), it (Nome/Versione).
            $idVal = $null; $nameVal = $null; $verVal = $null
            foreach ($k in $row.Keys) {
                $kl = $k.ToLower()
                if (-not $idVal   -and  $kl -eq 'id') { $idVal = $row[$k] }
                if (-not $nameVal -and ($kl -eq 'name' -or $kl -eq 'nombre' -or $kl -eq 'nome' -or $kl -eq 'nom')) { $nameVal = $row[$k] }
                if (-not $verVal  -and  $kl -like 'vers*') { $verVal = $row[$k] }
            }
            if ($idVal) {
                $results += @{
                    Id      = $idVal
                    Name    = ($nameVal -as [string])
                    Version = ($verVal -as [string])
                    Source  = $SourceTag
                }
            }
        }
        return $results
    }

    function Search-Winget {
        Write-Host ''
        Write-Host ('  ' + $L.SearchPrompt) -ForegroundColor DarkGray
        $term = Read-Host ('  ' + $L.SearchTerm)
        $term = $term.Trim()
        if (-not $term) { return @() }

        Write-Host ''
        Write-Host ('  ' + ($L.Searching -f $term)) -ForegroundColor Cyan

        # Query each source separately so we can tag results with their
        # Source field — needed at install time (msstore vs winget).
        # Keep the raw outputs so we can show them in diagnostics if no
        # results are parsed (helps remote debugging across locales).
        # Clean helper: remove ANSI escapes, strip spinner-only frames,
        # collapse progress-bar junk. winget emits those to stderr and when
        # captured with 2>&1 each frame becomes a bogus line that confuses
        # the column-aware parser.
        $esc = [char]0x1B
        $cleanLines = {
            param([object[]]$Raw)
            $out = @()
            foreach ($ln in $Raw) {
                $s = [string]$ln
                # Strip ANSI escape sequences (ESC[...m, ESC[...K, ESC[?...).
                # Use [char]0x1B instead of `e — `e is PowerShell 6+ only and
                # this panel supports Windows PowerShell 5.1.
                $s = [regex]::Replace($s, $esc + '\[[\d;\?]*[A-Za-z]', '')
                # Drop CR-only redraws; keep the LAST NON-EMPTY segment
                # after any CR. The naive "-split then [-1]" eats lines whose
                # only CR is trailing (Windows line-terminator leftover from
                # `winget 2>&1` capture), because split gives ('content','')
                # and [-1] is the empty string → table rows silently vanish
                # and Search-Winget reports "No results" for real hits.
                if ($s.IndexOf([char]13) -ge 0) {
                    $segs = @($s -split "`r" | Where-Object { $_.Length -gt 0 })
                    if ($segs.Count -gt 0) { $s = $segs[-1] } else { $s = '' }
                }
                $stripped = $s.Trim()
                # Skip pure spinner / progress frames (single char -,\,|,/,or
                # just the Unicode spinner glyphs winget uses).
                if ($stripped -match '^[\-\\\|/]$') { continue }
                if ($stripped -match '^[█▒░■▓▄▀]+$') { continue }
                # Skip empty-after-strip lines only if they were originally
                # control-heavy (keep genuine blank separators between header
                # and rows).
                $out += $s
            }
            return ,$out
        }

        $allResults = @()
        $rawOutputs = [ordered]@{}
        foreach ($src in @('winget', 'msstore')) {
            try {
                $output = & winget.exe search $term --source $src `
                    --accept-source-agreements --disable-interactivity 2>&1
            } catch {
                $rawOutputs[$src] = @("<exception> $($_.Exception.Message)")
                continue
            }
            $lines = & $cleanLines @($output | ForEach-Object { [string]$_ })
            $rawOutputs[$src] = $lines
            $parsed = _Parse-WingetSearchOutput -Lines $lines -SourceTag $src
            if ($parsed.Count -gt 0) {
                $allResults += $parsed
            }
        }

        # Fallback: if no per-source query found anything, try without
        # --source so winget walks every configured source itself. The
        # results have unknown source (could be winget OR msstore), so
        # we tag them with an empty Source string — Invoke-PackageInstall
        # will then omit --source at install time, letting winget pick.
        if ($allResults.Count -eq 0) {
            try {
                $output = & winget.exe search $term `
                    --accept-source-agreements --disable-interactivity 2>&1
                $lines = & $cleanLines @($output | ForEach-Object { [string]$_ })
                $rawOutputs['(no --source filter)'] = $lines
                $parsed = _Parse-WingetSearchOutput -Lines $lines -SourceTag ''
                if ($parsed.Count -gt 0) { $allResults += $parsed }
            } catch {
                $rawOutputs['(no --source filter)'] = @("<exception> $($_.Exception.Message)")
            }
        }

        # Dedupe by Id, prefer the winget-source entry (more stable IDs).
        $seen = @{}
        $merged = @()
        foreach ($r in $allResults) {
            if (-not $r.Id) { continue }
            if ($seen.ContainsKey($r.Id)) {
                if ($seen[$r.Id].Source -eq 'msstore' -and $r.Source -eq 'winget') {
                    # replace msstore entry with winget
                    for ($i = 0; $i -lt $merged.Count; $i++) {
                        if ($merged[$i].Id -eq $r.Id) { $merged[$i] = $r; break }
                    }
                    $seen[$r.Id] = $r
                }
                continue
            }
            $seen[$r.Id] = $r
            $merged += $r
        }

        if ($merged.Count -eq 0) {
            Write-Host ('  ' + $L.NoResults) -ForegroundColor Yellow
            # Diagnostic: show first 8 raw lines from each source so the
            # user (or someone debugging remotely) can see what winget
            # actually returned. Only shown when no results parsed.
            Write-Host ''
            Write-Host ('  ' + $L.RawOutputHint) -ForegroundColor DarkGray
            foreach ($src in $rawOutputs.Keys) {
                Write-Host ('    --- ' + $src + ' ---') -ForegroundColor DarkGray
                $snippet = @($rawOutputs[$src] | Select-Object -First 8)
                if ($snippet.Count -eq 0) {
                    Write-Host ('    ' + $L.NoOutput) -ForegroundColor DarkGray
                } else {
                    foreach ($line in $snippet) {
                        Write-Host ('    ' + $line) -ForegroundColor DarkGray
                    }
                }
            }
            Write-Host ''
            return @()
        }

        $top = @($merged | Select-Object -First 20)
        Write-Host ''
        for ($i = 0; $i -lt $top.Count; $i++) {
            $r = $top[$i]
            $srcLabel = if ($r.Source) { '[{0}]' -f $r.Source } else { '' }
            Write-Host ('  [{0,3}] {1,-36} {2,-32} {3,-12} {4}' -f ($i+1), $r.Name, $r.Id, $r.Version, $srcLabel) -ForegroundColor Gray
        }
        Write-Host ''
        $pick = Read-Host ('  ' + $L.SearchPickPrompt)
        $pick = $pick.Trim()
        if (-not $pick) { return @() }

        $picked = @()
        $tokens = $pick -split '[,\s]+' | Where-Object { $_ -ne '' }
        foreach ($t in $tokens) {
            $indices = @()
            if ($t -match '^\d+-\d+$') {
                $parts = $t.Split('-')
                $from = [int]$parts[0]; $to = [int]$parts[1]
                for ($i = $from; $i -le $to; $i++) { $indices += $i }
            } elseif ($t -match '^\d+$') {
                $indices += [int]$t
            }
            foreach ($n in $indices) {
                if ($n -ge 1 -and $n -le $top.Count) {
                    $r = $top[$n-1]
                    $entry = @{ Id=$r.Id; Name=$r.Name; Category='Search' }
                    if ($r.Source) { $entry.Source = $r.Source }
                    $picked += $entry
                }
            }
        }
        if ($picked.Count -gt 0) {
            Write-Host ('  ' + ($L.SearchAdded -f $picked.Count)) -ForegroundColor Green
        }
        return $picked
    }

    # ============================================================
    # Initial check
    # ============================================================
    Write-Header
    if (-not (Test-WingetAvailable)) {
        Write-Host ('  ' + $L.WingetUnavailable) -ForegroundColor Red
        Write-Host ('  ' + $L.WingetHintWin10) -ForegroundColor DarkGray
        Write-Host ('  ' + $L.WingetHintWin11) -ForegroundColor DarkGray
        Write-Host ''
        Read-Host $L.EnterToExit
        return
    }

    $wingetVer = try { (& winget.exe --version 2>$null).Trim() } catch { 'unknown' }
    Write-Host ('  ' + ($L.WingetVersion -f $wingetVer)) -ForegroundColor DarkGray
    Write-Host ''

    # ============================================================
    # Main loop
    # ============================================================
    $currentSelection = @()
    while ($true) {
        Write-Header
        Write-Host ('  ' + $L.Menu)              -ForegroundColor Yellow
        Write-Host ('    ' + $L.Menu1)           -ForegroundColor White
        Write-Host ('    ' + $L.Menu2)           -ForegroundColor White
        Write-Host ('    ' + $L.Menu3)           -ForegroundColor White
        Write-Host ('    ' + $L.Menu4)           -ForegroundColor White
        Write-Host ('    ' + $L.Menu5)           -ForegroundColor White
        Write-Host ('    ' + $L.Menu6)           -ForegroundColor White
        Write-Host ('    ' + $L.MenuQ)           -ForegroundColor White
        Write-Host ''
        Write-Host ('  ' + ($L.CurrentSelection -f $currentSelection.Count)) -ForegroundColor DarkGray
        Write-Host ''
        $opt = Read-Host ('  ' + $L.Option)

        switch -Regex ($opt.Trim()) {
            '^1$' {
                Write-Header
                Write-Host ('  ' + $L.PickHint) -ForegroundColor DarkGray
                Write-Host ('    ' + $L.PickEx1) -ForegroundColor DarkGray
                Write-Host ('    ' + $L.PickEx2) -ForegroundColor DarkGray
                Write-Host ('    ' + $L.PickEx3) -ForegroundColor DarkGray
                Write-Host ''
                $map = Show-Catalog
                Write-Host ''
                $inp = Read-Host ('  ' + $L.Packages)
                $sel = Parse-Selection -InputText $inp -Map $map
                if ($sel.Count -gt 0) {
                    $seen = @{}
                    foreach ($c in $currentSelection) { $seen[$c.Id] = $c }
                    foreach ($s in $sel) { $seen[$s.Id] = $s }
                    $currentSelection = @($seen.Values)
                    Write-Host ('  ' + ($L.AddedNToSelection -f $currentSelection.Count)) -ForegroundColor Green
                } else {
                    Write-Host ('  ' + $L.NothingPicked) -ForegroundColor Yellow
                }
                Read-Host $L.EnterToContinue
            }
            '^2$' {
                $loaded = Load-Profile
                if ($loaded.Count -gt 0) { $currentSelection = $loaded }
                Read-Host $L.EnterToContinue
            }
            '^3$' {
                Write-Header
                if ($currentSelection.Count -eq 0) {
                    Write-Host ('  ' + $L.NoSelectionToView) -ForegroundColor DarkGray
                } else {
                    Write-Host ('  ' + ($L.CurrentlyN -f $currentSelection.Count)) -ForegroundColor Yellow
                    foreach ($p in ($currentSelection | Sort-Object { $_.Category }, { $_.Name })) {
                        Write-Host ('    [{0,-18}] {1,-48} ({2})' -f $p.Category, $p.Name, $p.Id) -ForegroundColor Gray
                    }
                }
                Write-Host ''
                Read-Host $L.EnterToContinue
            }
            '^4$' {
                Save-Profile -Packages $currentSelection
                Read-Host $L.EnterToContinue
            }
            '^5$' {
                Install-Packages -Packages $currentSelection
                Read-Host $L.EnterToContinue
            }
            '^6$' {
                $picked = Search-Winget
                if ($picked.Count -gt 0) {
                    $seen = @{}
                    foreach ($c in $currentSelection) { $seen[$c.Id] = $c }
                    foreach ($s in $picked)          { $seen[$s.Id] = $s }
                    $currentSelection = @($seen.Values)
                }
                Read-Host $L.EnterToContinue
            }
            '^[Qq]$' { return }
            default {
                Write-Host ('  ' + $L.InvalidOption) -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
        }
    }
}
