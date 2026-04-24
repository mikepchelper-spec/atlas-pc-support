# ============================================================
# Invoke-InstalarPaquetes
# Instala software en lote usando winget + perfiles JSON reutilizables.
# Atlas PC Support
# ============================================================

function Invoke-InstalarPaquetes {
    [CmdletBinding()]
    param()

    $ErrorActionPreference = 'Continue'
    $Host.UI.RawUI.WindowTitle = 'ATLAS PC SUPPORT - Instalar Paquetes'
    try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(110, 42) } catch {}

    # --- Configuracion ---
    $PROFILE_DIR = Join-Path $env:LOCALAPPDATA 'AtlasPC\winget-profiles'
    if (-not (Test-Path $PROFILE_DIR)) {
        New-Item -ItemType Directory -Path $PROFILE_DIR -Force | Out-Null
    }

    # Catalogo de paquetes comunes, agrupados por categoria.
    # ID = PackageIdentifier de winget. Source = winget|msstore.
    $CATALOG = [ordered]@{
        'Navegadores' = @(
            @{ Id='Google.Chrome';                 Name='Google Chrome' },
            @{ Id='Mozilla.Firefox';               Name='Mozilla Firefox' },
            @{ Id='Brave.Brave';                   Name='Brave Browser' },
            @{ Id='Opera.Opera';                   Name='Opera' }
        )
        'Multimedia' = @(
            @{ Id='VideoLAN.VLC';                  Name='VLC Media Player' },
            @{ Id='Spotify.Spotify';               Name='Spotify' },
            @{ Id='OBSProject.OBSStudio';          Name='OBS Studio' },
            @{ Id='Audacity.Audacity';             Name='Audacity' }
        )
        'Oficina' = @(
            @{ Id='Microsoft.Office';              Name='Microsoft 365 (requiere licencia)' },
            @{ Id='TheDocumentFoundation.LibreOffice'; Name='LibreOffice' },
            @{ Id='Adobe.Acrobat.Reader.64-bit';   Name='Adobe Acrobat Reader' },
            @{ Id='Notion.Notion';                 Name='Notion' },
            @{ Id='Obsidian.Obsidian';             Name='Obsidian' }
        )
        'Comunicacion' = @(
            @{ Id='Zoom.Zoom';                     Name='Zoom' },
            @{ Id='Microsoft.Teams';               Name='Microsoft Teams' },
            @{ Id='Discord.Discord';               Name='Discord' },
            @{ Id='OpenWhisperSystems.Signal';     Name='Signal' },
            @{ Id='Telegram.TelegramDesktop';      Name='Telegram Desktop' },
            @{ Id='WhatsApp.WhatsApp';             Name='WhatsApp Desktop' }
        )
        'Utilidades' = @(
            @{ Id='7zip.7zip';                     Name='7-Zip' },
            @{ Id='Microsoft.PowerToys';           Name='PowerToys' },
            @{ Id='voidtools.Everything';          Name='Everything (search)' },
            @{ Id='Greenshot.Greenshot';           Name='Greenshot (screenshots)' },
            @{ Id='ShareX.ShareX';                 Name='ShareX' },
            @{ Id='WinDirStat.WinDirStat';         Name='WinDirStat' },
            @{ Id='Rufus.Rufus';                   Name='Rufus (USB boot)' },
            @{ Id='CPUID.CPU-Z';                   Name='CPU-Z' },
            @{ Id='TechPowerUp.GPU-Z';             Name='GPU-Z' },
            @{ Id='CrystalDewWorld.CrystalDiskInfo'; Name='CrystalDiskInfo' }
        )
        'Desarrollo' = @(
            @{ Id='Microsoft.VisualStudioCode';    Name='Visual Studio Code' },
            @{ Id='Git.Git';                       Name='Git' },
            @{ Id='GitHub.GitHubDesktop';          Name='GitHub Desktop' },
            @{ Id='OpenJS.NodeJS.LTS';             Name='Node.js LTS' },
            @{ Id='Python.Python.3.12';            Name='Python 3.12' },
            @{ Id='Microsoft.PowerShell';          Name='PowerShell 7' },
            @{ Id='Microsoft.WindowsTerminal';     Name='Windows Terminal' }
        )
        'Seguridad' = @(
            @{ Id='Malwarebytes.Malwarebytes';     Name='Malwarebytes' },
            @{ Id='Bitwarden.Bitwarden';           Name='Bitwarden' },
            @{ Id='KeePassXCTeam.KeePassXC';       Name='KeePassXC' }
        )
        'Gaming' = @(
            @{ Id='Valve.Steam';                   Name='Steam' },
            @{ Id='EpicGames.EpicGamesLauncher';   Name='Epic Games Launcher' },
            @{ Id='Discord.Discord';               Name='Discord (duplicado)' }
        )
    }

    function Write-Header {
        Clear-Host
        Write-Host ''
        Write-Host '  ================================================================' -ForegroundColor Cyan
        Write-Host '   ATLAS PC SUPPORT - INSTALAR PAQUETES (winget)' -ForegroundColor Yellow
        Write-Host '  ================================================================' -ForegroundColor Cyan
        Write-Host ''
    }

    function Test-WingetAvailable {
        $cmd = Get-Command winget.exe -ErrorAction SilentlyContinue
        return ($null -ne $cmd)
    }

    function Show-Catalog {
        # Regular hashtable. IMPORTANTE: NO usar [ordered]@{} aqui — en PS 7 el
        # indexador [int] sobre un ordered dict busca POSICION, no clave, y
        # $map[$idx] = ... falla con "index out of range" al crecer.
        $map = @{}
        $idx = 1
        foreach ($cat in $CATALOG.Keys) {
            Write-Host ''
            Write-Host "  --- $cat ---" -ForegroundColor Yellow
            foreach ($pkg in $CATALOG[$cat]) {
                Write-Host ('  [{0,3}] {1,-45} ({2})' -f $idx, $pkg.Name, $pkg.Id) -ForegroundColor Gray
                $map[$idx] = @{ Id=$pkg.Id; Name=$pkg.Name; Category=$cat }
                $idx++
            }
        }
        return $map
    }

    function Parse-Selection {
        param([string]$Input, $Map)
        $Input = $Input.Trim()
        if ($Input -match '^(?i)all$') {
            return @($Map.Values)
        }
        if ($Input -match '^(?i)(none|q|quit|)$') {
            return @()
        }
        $selected = @()
        $tokens = $Input -split '[,\s]+' | Where-Object { $_ -ne '' }
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
        # Dedupe por Id
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

    function Install-Packages {
        param([array]$Packages, [switch]$Silent)

        if (-not $Packages -or $Packages.Count -eq 0) {
            Write-Host '  [!] No hay paquetes seleccionados.' -ForegroundColor Yellow
            return
        }

        Write-Host ''
        Write-Host ('  A instalar {0} paquete(s):' -f $Packages.Count) -ForegroundColor Cyan
        foreach ($p in $Packages) {
            Write-Host ('    - {0,-45} ({1})' -f $p.Name, $p.Id) -ForegroundColor Gray
        }
        Write-Host ''
        $confirm = Read-Host '  Continuar? [S/n]'
        if ($confirm -match '^[Nn]') { Write-Host '  Cancelado.' -ForegroundColor DarkGray; return }

        $ok = 0; $fail = 0; $already = 0
        foreach ($p in $Packages) {
            Write-Host ''
            Write-Host ('  [>] {0}' -f $p.Name) -ForegroundColor Cyan
            $args = @('install', '--id', $p.Id, '--exact', '--silent',
                      '--accept-package-agreements', '--accept-source-agreements',
                      '--disable-interactivity')
            try {
                $output = & winget.exe @args 2>&1
                $exit = $LASTEXITCODE
                switch ($exit) {
                    0 { Write-Host ('      [OK] Instalado.') -ForegroundColor Green; $ok++ }
                    -1978335189 { Write-Host ('      [=] Ya instalado.') -ForegroundColor DarkGray; $already++ }  # APPINSTALLER_CLI_ERROR_UPDATE_NOT_APPLICABLE
                    -1978335212 { Write-Host ('      [=] Ya instalado.') -ForegroundColor DarkGray; $already++ }  # paquete no encontrado para update / ya presente
                    default {
                        Write-Host ('      [X] Fallo (exit={0}).' -f $exit) -ForegroundColor Red
                        $fail++
                        if ($output) {
                            $output | Select-Object -Last 3 | ForEach-Object {
                                Write-Host ('          ' + $_) -ForegroundColor DarkGray
                            }
                        }
                    }
                }
            } catch {
                Write-Host ('      [X] Excepcion: ' + $_.Exception.Message) -ForegroundColor Red
                $fail++
            }
        }

        Write-Host ''
        Write-Host '  ================================================================' -ForegroundColor Cyan
        Write-Host ('  Resumen: {0} OK / {1} ya instalados / {2} fallidos' -f $ok, $already, $fail) -ForegroundColor White
        Write-Host '  ================================================================' -ForegroundColor Cyan
    }

    function Save-Profile {
        param([array]$Packages)
        if (-not $Packages -or $Packages.Count -eq 0) {
            Write-Host '  [!] No hay paquetes para guardar.' -ForegroundColor Yellow
            return
        }
        Write-Host ''
        $name = Read-Host '  Nombre del perfil (ej: "juan-taller")'
        $name = $name.Trim()
        if (-not $name) { Write-Host '  Cancelado.' -ForegroundColor DarkGray; return }
        $safe = ($name -replace '[^\w\-\.]', '_')
        $file = Join-Path $PROFILE_DIR ("$safe.json")

        $obj = [ordered]@{
            schema   = 'atlas-winget-profile-v1'
            name     = $name
            created  = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
            packages = @($Packages | ForEach-Object {
                [ordered]@{ id=$_.Id; name=$_.Name; category=$_.Category }
            })
        }
        try {
            ConvertTo-Json -InputObject $obj -Depth 5 | Set-Content -Path $file -Encoding UTF8
            Write-Host ('  [OK] Perfil guardado: {0}' -f $file) -ForegroundColor Green
        } catch {
            Write-Host ('  [X] Error guardando: {0}' -f $_.Exception.Message) -ForegroundColor Red
        }
    }

    function Load-Profile {
        $files = @(Get-ChildItem -Path $PROFILE_DIR -Filter '*.json' -ErrorAction SilentlyContinue | Sort-Object Name)
        if (-not $files -or $files.Count -eq 0) {
            Write-Host ''
            Write-Host '  [!] No hay perfiles guardados en:' -ForegroundColor Yellow
            Write-Host ('       ' + $PROFILE_DIR) -ForegroundColor DarkGray
            return @()
        }
        Write-Host ''
        Write-Host '  Perfiles disponibles:' -ForegroundColor Yellow
        for ($i = 0; $i -lt $files.Count; $i++) {
            Write-Host ('    [{0}] {1}' -f ($i+1), $files[$i].Name) -ForegroundColor Cyan
        }
        Write-Host ''
        $sel = Read-Host '  Numero de perfil (o ENTER para cancelar)'
        if (-not $sel) { return @() }
        $n = 0
        if (-not [int]::TryParse($sel, [ref]$n) -or $n -lt 1 -or $n -gt $files.Count) {
            Write-Host '  [X] Seleccion invalida.' -ForegroundColor Red
            return @()
        }
        $file = $files[$n-1]
        try {
            $raw = Get-Content -Raw -Path $file.FullName
            $obj = $raw | ConvertFrom-Json
            $packages = @($obj.packages | ForEach-Object {
                @{ Id=$_.id; Name=$_.name; Category=$_.category }
            })
            Write-Host ('  [OK] Cargado "{0}" con {1} paquete(s).' -f $obj.name, $packages.Count) -ForegroundColor Green
            return $packages
        } catch {
            Write-Host ('  [X] Error leyendo perfil: {0}' -f $_.Exception.Message) -ForegroundColor Red
            return @()
        }
    }

    # --- Verificacion inicial ---
    Write-Header
    if (-not (Test-WingetAvailable)) {
        Write-Host '  [X] winget no esta disponible en este sistema.' -ForegroundColor Red
        Write-Host '      Windows 10 antiguo: instalar "App Installer" desde Microsoft Store.' -ForegroundColor DarkGray
        Write-Host '      Windows 11: deberia venir preinstalado; ejecuta Windows Update.' -ForegroundColor DarkGray
        Write-Host ''
        Read-Host '  ENTER para salir'
        return
    }

    $wingetVer = try { (& winget.exe --version 2>$null).Trim() } catch { 'desconocida' }
    Write-Host "  winget version: $wingetVer" -ForegroundColor DarkGray
    Write-Host ''

    # --- Menu principal ---
    $currentSelection = @()
    while ($true) {
        Write-Header
        Write-Host '  MENU:' -ForegroundColor Yellow
        Write-Host '    [1] Seleccionar paquetes del catalogo' -ForegroundColor White
        Write-Host '    [2] Cargar perfil guardado' -ForegroundColor White
        Write-Host '    [3] Ver seleccion actual' -ForegroundColor White
        Write-Host '    [4] Guardar seleccion como perfil' -ForegroundColor White
        Write-Host '    [5] Instalar seleccion actual' -ForegroundColor White
        Write-Host '    [6] Anadir ID personalizado (winget)' -ForegroundColor White
        Write-Host '    [Q] Salir' -ForegroundColor White
        Write-Host ''
        Write-Host ('  Seleccion actual: {0} paquete(s)' -f $currentSelection.Count) -ForegroundColor DarkGray
        Write-Host ''
        $opt = Read-Host '  Opcion'

        switch -Regex ($opt.Trim()) {
            '^1$' {
                Write-Header
                Write-Host '  Selecciona paquetes por numero. Ejemplos:' -ForegroundColor DarkGray
                Write-Host '    "1,3,5"   (individuales)' -ForegroundColor DarkGray
                Write-Host '    "1-10"    (rango)' -ForegroundColor DarkGray
                Write-Host '    "all"     (todos)' -ForegroundColor DarkGray
                Write-Host ''
                $map = Show-Catalog
                Write-Host ''
                $inp = Read-Host '  Paquetes'
                $sel = Parse-Selection -Input $inp -Map $map
                if ($sel.Count -gt 0) {
                    # Merge con seleccion actual (evitando duplicados por Id)
                    $seen = @{}
                    foreach ($c in $currentSelection) { $seen[$c.Id] = $c }
                    foreach ($s in $sel) { $seen[$s.Id] = $s }
                    $currentSelection = @($seen.Values)
                    Write-Host ('  [OK] {0} paquete(s) en seleccion.' -f $currentSelection.Count) -ForegroundColor Green
                } else {
                    Write-Host '  [!] Nada seleccionado.' -ForegroundColor Yellow
                }
                Read-Host '  ENTER para continuar'
            }
            '^2$' {
                $loaded = Load-Profile
                if ($loaded.Count -gt 0) {
                    $currentSelection = $loaded
                }
                Read-Host '  ENTER para continuar'
            }
            '^3$' {
                Write-Header
                if ($currentSelection.Count -eq 0) {
                    Write-Host '  (sin seleccion)' -ForegroundColor DarkGray
                } else {
                    Write-Host ('  Seleccion actual ({0}):' -f $currentSelection.Count) -ForegroundColor Yellow
                    foreach ($p in ($currentSelection | Sort-Object { $_.Category }, { $_.Name })) {
                        Write-Host ('    [{0,-14}] {1,-45} ({2})' -f $p.Category, $p.Name, $p.Id) -ForegroundColor Gray
                    }
                }
                Write-Host ''
                Read-Host '  ENTER para continuar'
            }
            '^4$' {
                Save-Profile -Packages $currentSelection
                Read-Host '  ENTER para continuar'
            }
            '^5$' {
                Install-Packages -Packages $currentSelection
                Read-Host '  ENTER para continuar'
            }
            '^6$' {
                Write-Host ''
                Write-Host '  Introduce el ID winget exacto (ej: "Notepad++.Notepad++").' -ForegroundColor DarkGray
                Write-Host '  Para buscar: "winget search <nombre>" en una consola aparte.' -ForegroundColor DarkGray
                $id = Read-Host '  ID'
                $id = $id.Trim()
                if ($id) {
                    $currentSelection += @{ Id=$id; Name=$id; Category='Custom' }
                    Write-Host ('  [OK] Anadido: {0}' -f $id) -ForegroundColor Green
                }
                Read-Host '  ENTER para continuar'
            }
            '^[Qq]$' { return }
            default {
                Write-Host '  [!] Opcion no valida.' -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
        }
    }
}
