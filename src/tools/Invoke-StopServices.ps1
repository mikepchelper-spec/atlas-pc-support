# ============================================================
# Invoke-StopServices
# Optimizacion de servicios con UNDO + analisis de seguridad.
# Atlas PC Support - v2.0
# ============================================================

function Invoke-StopServices {
    [CmdletBinding()]
    param()

    try { $Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - STOP SERVICES" } catch {}
    Clear-Host

    # Directorio de backup
    $backupDir = Join-Path $env:LOCALAPPDATA 'AtlasPC'
    if (-not (Test-Path $backupDir)) {
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
    }
    $backupFile = Join-Path $backupDir 'services-backup.json'

    # ============================================================
    # LISTA DE SERVICIOS
    # Tier SAFE     : seguros en 99% de equipos (Xbox, telemetria, fax).
    # Tier MODERATE : dependen del uso (SensorService en laptops, WbioSrvc si
    #                 usas Windows Hello, etc). Se piden confirmaciones extra.
    # Cada entrada incluye 'Requires' con IDs de situaciones en las que el
    # servicio SI hace falta, para imprimir advertencias.
    # ============================================================

    $serviciosAOptimizar = @(
        # --- TIER SAFE ---
        @{ Name='DiagTrack';           Tier='SAFE'; Desc='Telemetria (Connected User Experiences)'; Note='No afecta funcionalidad.' },
        @{ Name='dmwappushservice';    Tier='SAFE'; Desc='WAP Push Message Routing';                 Note='Solo afecta SMS push en empresa.' },
        @{ Name='WerSvc';              Tier='SAFE'; Desc='Reporte de errores de Windows';           Note='Solo deja de mandar crashes a MS.' },
        @{ Name='wisvc';               Tier='SAFE'; Desc='Windows Insider';                         Note='Solo si no eres Insider.' },
        @{ Name='PcaSvc';              Tier='SAFE'; Desc='Asistente de compatibilidad programas';   Note='Solo deja de sugerir "ejecutar en modo compat".' },
        @{ Name='XblAuthManager';      Tier='SAFE'; Desc='Xbox Live Auth';                           Note='Si NO juegas a juegos Microsoft Store.' },
        @{ Name='XblGameSave';         Tier='SAFE'; Desc='Xbox Live Game Save';                      Note='Si NO juegas a juegos Microsoft Store.' },
        @{ Name='XboxNetApiSvc';       Tier='SAFE'; Desc='Xbox Live Networking';                     Note='Si NO juegas a juegos Microsoft Store.' },
        @{ Name='XboxGipSvc';          Tier='SAFE'; Desc='Xbox Game Input Protocol';                 Note='Si NO usas mando Xbox por USB/Bluetooth.' },
        @{ Name='MapsBroker';          Tier='SAFE'; Desc='Mapas offline (Windows Maps)';             Note='Solo afecta app Mapas de MS.' },
        @{ Name='WalletService';       Tier='SAFE'; Desc='Cartera (Microsoft Wallet)';               Note='App discontinuada.' },
        @{ Name='RetailDemo';          Tier='SAFE'; Desc='Modo demo de tienda';                      Note='Solo para PCs de demostracion en tiendas.' },
        @{ Name='Fax';                 Tier='SAFE'; Desc='Fax';                                       Note='Quien usa fax hoy.' },
        @{ Name='RemoteRegistry';      Tier='SAFE'; Desc='Registro remoto (vector de ataque)';      Note='Deshabilitarlo MEJORA seguridad.' },

        # --- TIER MODERATE ---
        @{ Name='TabletInputService';  Tier='MODERATE'; Desc='Entrada tactil / lapiz';               Note='ROMPE: pantallas tactiles, tablets, Surface.' },
        @{ Name='SensorService';       Tier='MODERATE'; Desc='Servicio de sensores';                 Note='ROMPE: rotacion pantalla, auto-brillo (laptops).' },
        @{ Name='SensorDataService';   Tier='MODERATE'; Desc='Datos de sensores';                    Note='Lo mismo que SensorService.' },
        @{ Name='SensrSvc';            Tier='MODERATE'; Desc='Supervision de sensores';              Note='Lo mismo que SensorService.' },
        @{ Name='WbioSrvc';            Tier='MODERATE'; Desc='Biometria (huellas / Windows Hello)'; Note='ROMPE: huella y reconocimiento facial.' },
        @{ Name='Spooler';             Tier='MODERATE'; Desc='Print Spooler';                        Note='ROMPE: impresion. Si NO imprimes, tambien cierra CVE tipo PrintNightmare.' },
        @{ Name='WSearch';             Tier='MODERATE'; Desc='Indexador de Windows Search';          Note='ROMPE: busquedas rapidas Explorer y Outlook.' },
        @{ Name='Bthserv';             Tier='MODERATE'; Desc='Bluetooth Support';                    Note='ROMPE: Bluetooth (si no usas nada BT, se puede).' }
    )

    function Show-Header {
        Clear-Host
        Write-Host ''
        Write-Host '  =================================================' -ForegroundColor DarkGray
        Write-Host '   ATLAS PC SUPPORT - OPTIMIZACION DE SERVICIOS v2' -ForegroundColor Yellow
        Write-Host '  =================================================' -ForegroundColor DarkGray
        Write-Host ''
    }

    function Check-Admin {
        $p = [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
        return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }

    function List-Services {
        param([string]$TierFilter = '')
        $out = @()
        foreach ($s in $serviciosAOptimizar) {
            if ($TierFilter -and $s.Tier -ne $TierFilter) { continue }
            $svc = Get-Service -Name $s.Name -ErrorAction SilentlyContinue
            if (-not $svc) { continue }
            try {
                $svcCim = Get-CimInstance -ClassName Win32_Service -Filter "Name='$($s.Name)'" -ErrorAction SilentlyContinue
                $startMode = if ($svcCim) { $svcCim.StartMode } else { '?' }
            } catch { $startMode = '?' }
            $out += [pscustomobject]@{
                Name      = $s.Name
                Desc      = $s.Desc
                Note      = $s.Note
                Tier      = $s.Tier
                Status    = $svc.Status
                StartMode = $startMode
            }
        }
        return $out
    }

    function Apply-Stop {
        param($Targets)
        if (-not (Check-Admin)) {
            Write-Host ''
            Write-Host '  [X] ADMIN requerido. Relanza con privilegios.' -ForegroundColor Red
            return $false
        }

        # Backup estado previo
        $backup = @()
        foreach ($t in $Targets) {
            $svc = Get-Service -Name $t.Name -ErrorAction SilentlyContinue
            if (-not $svc) { continue }
            $cim = Get-CimInstance -ClassName Win32_Service -Filter "Name='$($t.Name)'" -ErrorAction SilentlyContinue
            # Capturar DelayedAutoStart (Win32_Service.StartMode devuelve 'Auto' tanto
            # para 'Automatic' como para 'Automatic (Delayed Start)', hay que leerlo
            # aparte desde registro/CIM para no perderlo al restaurar).
            $delayed = $false
            if ($cim -and $cim.StartMode -eq 'Auto') {
                try {
                    $regKey = "HKLM:\SYSTEM\CurrentControlSet\Services\$($t.Name)"
                    $delayed = [bool](Get-ItemProperty -Path $regKey -Name DelayedAutostart -ErrorAction Stop).DelayedAutostart
                } catch { $delayed = $false }
            }
            $backup += [pscustomobject]@{
                Name              = $t.Name
                Status            = $svc.Status.ToString()
                StartMode         = if ($cim) { $cim.StartMode } else { 'Unknown' }
                DelayedAutoStart  = $delayed
                Timestamp         = (Get-Date).ToString('s')
            }
        }
        # Append a historial de backups (no sobrescribir para permitir multiples undos)
        $history = @()
        if (Test-Path $backupFile) {
            try { $history = @(Get-Content $backupFile -Raw | ConvertFrom-Json) } catch { $history = @() }
        }
        $entry = [pscustomobject]@{
            Timestamp = (Get-Date).ToString('s')
            Services  = $backup
        }
        $history = @($history) + @($entry)
        # IMPORTANTE: usar -InputObject para evitar que el pipeline desenvuelva el array
        # y serialice cada elemento individualmente (generando JSON concatenado invalido).
        ConvertTo-Json -InputObject $history -Depth 5 | Out-File -FilePath $backupFile -Encoding UTF8
        Write-Host ''
        Write-Host ("  [i] Backup guardado: {0}" -f $backupFile) -ForegroundColor DarkGray
        Write-Host ''

        foreach ($t in $Targets) {
            try {
                Stop-Service -Name $t.Name -Force -ErrorAction Stop
                Set-Service  -Name $t.Name -StartupType Manual -ErrorAction Stop
                Write-Host ("  [OK]   {0,-22} detenido y marcado Manual" -f $t.Name) -ForegroundColor Green
            } catch {
                Write-Host ("  [ERR]  {0,-22} {1}" -f $t.Name, $_.Exception.Message) -ForegroundColor Red
            }
        }
        return $true
    }

    function Apply-Undo {
        if (-not (Check-Admin)) {
            Write-Host ''
            Write-Host '  [X] ADMIN requerido. Relanza con privilegios.' -ForegroundColor Red
            return
        }
        if (-not (Test-Path $backupFile)) {
            Write-Host ''
            Write-Host '  [!] No hay backup. No se ha optimizado nada desde este tool.' -ForegroundColor Yellow
            return
        }
        try {
            $history = @(Get-Content $backupFile -Raw | ConvertFrom-Json)
        } catch {
            Write-Host ''
            Write-Host '  [X] Backup corrupto.' -ForegroundColor Red
            return
        }
        if ($history.Count -eq 0) {
            Write-Host ''
            Write-Host '  [!] Backup vacio.' -ForegroundColor Yellow
            return
        }

        Write-Host ''
        Write-Host '  === PUNTOS DE RESTAURACION ===' -ForegroundColor Yellow
        Write-Host ''
        $i = 1
        foreach ($e in $history) {
            $n = @($e.Services).Count
            Write-Host ("  [{0}] {1} - {2} servicios afectados" -f $i, $e.Timestamp, $n) -ForegroundColor White
            $i++
        }
        Write-Host ''
        Write-Host '  [0] Cancelar' -ForegroundColor DarkGray
        Write-Host ''
        $sel = Read-Host '  Que backup restaurar?'
        if ($sel -match '^\d+$' -and [int]$sel -ge 1 -and [int]$sel -le $history.Count) {
            $entry = $history[[int]$sel - 1]
            foreach ($s in $entry.Services) {
                # StartupType de Set-Service. 'AutomaticDelayedStart' preserva delayed
                # para servicios como WSearch que arrancan con delay por defecto.
                $modeMap = @{ 'Auto' = 'Automatic'; 'Automatic' = 'Automatic'; 'Manual' = 'Manual'; 'Disabled' = 'Disabled'; 'Boot' = 'Boot'; 'System' = 'System' }
                $mode = if ($modeMap.ContainsKey($s.StartMode)) { $modeMap[$s.StartMode] } else { 'Manual' }
                if ($mode -eq 'Automatic' -and $s.DelayedAutoStart) { $mode = 'AutomaticDelayedStart' }
                try {
                    Set-Service -Name $s.Name -StartupType $mode -ErrorAction Stop
                    if ($s.Status -eq 'Running') {
                        Start-Service -Name $s.Name -ErrorAction SilentlyContinue
                    }
                    Write-Host ("  [OK]   {0,-22} modo={1,-22} estado_prev={2}" -f $s.Name, $mode, $s.Status) -ForegroundColor Green
                } catch {
                    Write-Host ("  [ERR]  {0,-22} {1}" -f $s.Name, $_.Exception.Message) -ForegroundColor Red
                }
            }
            Write-Host ''
            Write-Host '  Restauracion completa.' -ForegroundColor Cyan
        } else {
            Write-Host '  Cancelado.' -ForegroundColor DarkGray
        }
    }

    function Show-ServicesTable {
        param($List)
        Write-Host ('  {0,-22} {1,-6} {2,-10} {3,-10} {4}' -f 'Servicio', 'Tier', 'Estado', 'StartMode', 'Descripcion') -ForegroundColor Cyan
        Write-Host ('  ' + ('-' * 90)) -ForegroundColor DarkGray
        foreach ($r in $List) {
            $color = if ($r.Status -eq 'Running') { 'Green' } else { 'DarkGray' }
            $flag  = if ($r.Status -eq 'Running') { 'R' } else { '-' }
            Write-Host ("  {0,-22} {1,-6} {2,-10} {3,-10} {4}" -f $r.Name, $r.Tier, $r.Status, $r.StartMode, $r.Desc) -ForegroundColor $color
            Write-Host ("  {0,22}   note: {1}" -f '', $r.Note) -ForegroundColor DarkGray
        }
    }

    # ============================================================
    # MENU PRINCIPAL
    # ============================================================
    while ($true) {
        Show-Header
        Write-Host '  [1] Ver estado actual de los servicios candidatos' -ForegroundColor White
        Write-Host '  [2] Detener servicios SEGUROS (SAFE) - recomendado' -ForegroundColor Green
        Write-Host '  [3] Detener ADEMAS servicios MODERADOS (avanzado)' -ForegroundColor Yellow
        Write-Host '  [4] UNDO - Restaurar un backup previo' -ForegroundColor Cyan
        Write-Host '  [5] Ver advertencias de cada servicio' -ForegroundColor DarkCyan
        Write-Host '  [Q] Salir'
        Write-Host ''
        $sel = Read-Host '  Seleccion'

        switch -regex ($sel) {
            '^1$' {
                Show-Header
                $list = List-Services
                if ($list.Count -eq 0) {
                    Write-Host '  No se detecto ningun servicio de la lista en este Windows.' -ForegroundColor Yellow
                } else {
                    Show-ServicesTable $list
                }
                Write-Host ''
                Read-Host '  ENTER para volver' | Out-Null
            }
            '^2$' {
                Show-Header
                Write-Host '  Detendra SOLO servicios del tier SAFE (no rompen nada en un PC normal).' -ForegroundColor Green
                Write-Host ''
                $list = List-Services -TierFilter 'SAFE' | Where-Object { $_.Status -eq 'Running' }
                if ($list.Count -eq 0) {
                    Write-Host '  No hay servicios SAFE en ejecucion. Ya esta optimizado.' -ForegroundColor Cyan
                    Read-Host '  ENTER' | Out-Null
                    continue
                }
                Show-ServicesTable $list
                Write-Host ''
                $c = Read-Host '  Proceder? [S/N]'
                if ($c -match '^[SsYy]$') {
                    Apply-Stop -Targets $list | Out-Null
                }
                Write-Host ''
                Read-Host '  ENTER' | Out-Null
            }
            '^3$' {
                Show-Header
                Write-Host '  MODO AVANZADO: se detendran ADEMAS servicios MODERADOS.' -ForegroundColor Yellow
                Write-Host '  Revisa la nota de CADA servicio antes de decir SI.' -ForegroundColor Yellow
                Write-Host ''
                $list = List-Services | Where-Object { $_.Status -eq 'Running' }
                if ($list.Count -eq 0) {
                    Write-Host '  Ya esta todo detenido.' -ForegroundColor Cyan
                    Read-Host '  ENTER' | Out-Null
                    continue
                }
                Show-ServicesTable $list
                Write-Host ''
                $c = Read-Host '  Proceder con TODOS los detectados? [S/N]'
                if ($c -match '^[SsYy]$') {
                    Apply-Stop -Targets $list | Out-Null
                }
                Write-Host ''
                Read-Host '  ENTER' | Out-Null
            }
            '^4$' {
                Show-Header
                Apply-Undo
                Write-Host ''
                Read-Host '  ENTER' | Out-Null
            }
            '^5$' {
                Show-Header
                Write-Host '  --- ADVERTENCIAS POR SERVICIO ---' -ForegroundColor Yellow
                Write-Host ''
                foreach ($s in $serviciosAOptimizar) {
                    $col = if ($s.Tier -eq 'SAFE') { 'Green' } else { 'Yellow' }
                    Write-Host ("  [{0}] {1,-22} ({2})" -f $s.Tier, $s.Name, $s.Desc) -ForegroundColor $col
                    Write-Host ("        {0}" -f $s.Note) -ForegroundColor Gray
                    Write-Host ''
                }
                Read-Host '  ENTER' | Out-Null
            }
            '^[Qq]$' { return }
            default { Write-Host '  Opcion no valida.' -ForegroundColor Red; Start-Sleep 1 }
        }
    }
}
