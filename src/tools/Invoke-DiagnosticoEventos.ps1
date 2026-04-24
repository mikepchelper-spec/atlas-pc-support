function Invoke-DiagnosticoEventos {
    <#
    .SYNOPSIS
      Diagnostico Eventos: lee Windows Event Viewer e interpreta errores
      con explicacion humana + accion sugerida.

    .DESCRIPTION
      - Filtra eventos por tipo (reinicios, hardware, crashes, drivers, seguridad).
      - Traduce los EventIDs mas comunes a romance + severidad + recomendacion.
      - Exporta reporte HTML para compartir con cliente o guardar.
      - Corre aislada (ToolRunner), no depende de libs del launcher.
    #>

    $ErrorActionPreference = 'Stop'

    # ----- Base de conocimiento de EventIDs comunes -----
    # Key: "LogName|ProviderName|EventID"  (cualquiera de los dos primeros puede ser '*')
    # Usamos scope 'script' para que las funciones anidadas siempre vean el hashtable
    # sin depender de dynamic scoping (rompia con ToolRunner en ciertos entornos).
    $script:AtlasEventsKB = @{
        '*|*|41' = @{
            Level = 'CRITICAL'
            Title = 'Kernel-Power: apagado inesperado'
            Cause = 'El sistema se apago sin flushear. Causas tipicas: corte de corriente, PSU defectuosa, sobrecalentamiento, BSOD silencioso, boton de reset fisico.'
            Action = 'Revisa temperaturas CPU/GPU (tool Parts Upgrade). Si hay BSOD: analiza C:\Windows\Minidump\*.dmp con WinDbg o BlueScreenView. Si repite: test de PSU con multimetro.'
        }
        '*|*|6008' = @{
            Level = 'WARN'
            Title = 'Apagado anterior inesperado'
            Cause = 'El PC se apago sin hacer shutdown limpio. Normal tras un 41 (Kernel-Power).'
            Action = 'Correlaciona con evento 41 en la misma fecha. Si no hay 41, puede ser corte electrico o reset fisico.'
        }
        '*|*|6006' = @{
            Level = 'INFO'
            Title = 'Event Log detenido (apagado normal)'
            Cause = 'El servicio Event Log fue detenido de forma limpia. Ocurre en cada shutdown.'
            Action = 'Informativo. Si su ausencia contrasta con un 6008, hubo reboot sucio.'
        }
        '*|*|1074' = @{
            Level = 'INFO'
            Title = 'Reinicio/apagado iniciado por usuario o app'
            Cause = 'Algun proceso pidio el reinicio. El mensaje dice quien (ej. "Windows Update", "usuario X", "explorer.exe").'
            Action = 'Si no reconoces el iniciador: puede ser Windows Update (normal) o malware que fuerza reboot.'
        }
        '*|*|1001' = @{
            Level = 'WARN'
            Title = 'Windows Error Reporting / Bugcheck'
            Cause = 'Un crash BSOD se reporto. El mensaje contiene el stopcode (ej. 0x0000001A = MEMORY_MANAGEMENT).'
            Action = 'Mira el stopcode en el mensaje. Tabla rapida: 0x3B=driver, 0x7E=SYSTEM_THREAD, 0x1A=RAM, 0x9F=power/driver, 0x133=DPC_WATCHDOG (IO lento).'
        }
        '*|*|1000' = @{
            Level = 'WARN'
            Title = 'Application Error (app crashed)'
            Cause = 'Una aplicacion se cerro inesperadamente. El mensaje indica el exe + modulo faulty + direccion.'
            Action = 'Si se repite siempre con el mismo exe: reinstalar la app. Si es ntdll.dll como faulty module: puede ser hardware (RAM/disco).'
        }
        '*|*|1026' = @{
            Level = 'WARN'
            Title = '.NET Runtime: excepcion no controlada'
            Cause = 'App .NET crasheo con excepcion sin manejar (StackOverflow, OOM, InvalidOperationException, etc.).'
            Action = 'Mira el stacktrace en el mensaje. Si es StackOverflow: recursion infinita en codigo de terceros.'
        }
        '*|*|219' = @{
            Level = 'WARN'
            Title = 'Driver fallo al cargar'
            Cause = 'Un driver firmado fallo su inicializacion. Mensaje indica nombre del driver.'
            Action = 'Abre Device Manager, busca el dispositivo con el driver problemarico. Reinstala driver fresh (fabricante, NO Windows Update si hace falta).'
        }
        '*|*|7026' = @{
            Level = 'WARN'
            Title = 'Boot-start driver fallo'
            Cause = 'Uno o varios drivers esenciales no cargaron en arranque.'
            Action = 'Critico si el driver es de disco (AHCI, NVMe). Revisa mensaje: si es antivirus/VPN/virtualizacion, probablemente inofensivo.'
        }
        '*|*|7001' = @{
            Level = 'WARN'
            Title = 'Servicio dependencia fallo'
            Cause = 'Un servicio no arranco porque otro del que dependia fallo.'
            Action = 'Mira services.msc, intenta start manual. A veces indica WMI roto (reparar con winmgmt /resetrepository).'
        }
        '*|*|7031' = @{
            Level = 'WARN'
            Title = 'Servicio crasheo'
            Cause = 'Un servicio Windows terminio inesperadamente.'
            Action = 'Si repite: rehabilitar via services.msc o desinstalar app asociada. Si es Explorer/Shell: sfc /scannow + dism.'
        }
        '*|*|7034' = @{
            Level = 'WARN'
            Title = 'Servicio termino sin previo aviso'
            Cause = 'Similar a 7031 — servicio murio sin shutdown limpio.'
            Action = 'Igual que 7031.'
        }
        '*|*|7' = @{
            Level = 'CRITICAL'
            Title = 'Bad block en disco (Disk error)'
            Cause = 'El disco fisico tiene sectores corruptos. Mensaje tipico: "The device, \\Device\\HarddiskX, has a bad block".'
            Action = 'URGENTE. Ejecuta SMART check (CrystalDiskInfo). Si salud no es 100%, plan backup + reemplazo de disco YA. Tool Parts Upgrade te da el modelo.'
        }
        '*|*|51' = @{
            Level = 'CRITICAL'
            Title = 'Disk I/O error'
            Cause = 'Windows tuvo un error al leer/escribir al disco. Cable SATA suelto, controladora, o disco fallando.'
            Action = 'Verifica cables (abre caja). SMART check. Si NVMe: revisa que la BIOS este actualizada.'
        }
        '*|*|52' = @{
            Level = 'WARN'
            Title = 'Disk capacidad baja'
            Cause = 'Espacio libre menor al umbral critico.'
            Action = 'Tool Mantenimiento PRO -> liberar espacio.'
        }
        '*|*|55' = @{
            Level = 'WARN'
            Title = 'File system corrupt'
            Cause = 'NTFS/ReFS detecto corrupcion estructural.'
            Action = 'chkdsk C: /f (requiere reboot). Si repite: disco fallando fisicamente.'
        }
        '*|*|153' = @{
            Level = 'WARN'
            Title = 'IO operation retried'
            Cause = 'Operacion IO al disco tuvo que reintentarse. Sintoma temprano de disco moribundo.'
            Action = 'SMART check prioritario. Plan de reemplazo.'
        }
        '*|WHEA-Logger|1' = @{
            Level = 'CRITICAL'
            Title = 'Hardware error: CPU/Bus'
            Cause = 'WHEA (Windows Hardware Error Architecture) detecto fallo hardware no recuperable. Tipicamente CPU overheat, RAM corrupta, o PCIe inestable.'
            Action = 'Test RAM con MemTest86 4+ pases. Check temperaturas. BIOS al ultimo firmware.'
        }
        '*|WHEA-Logger|17' = @{
            Level = 'WARN'
            Title = 'Hardware error corregido'
            Cause = 'Error hardware que el sistema pudo corregir (ej. PCIe AER). No causa crash, pero indica degradacion.'
            Action = 'Si es frecuente: problema de placa/tarjeta expansion. Re-asiente PCIe (GPU/SSD). BIOS update.'
        }
        '*|WHEA-Logger|18' = @{
            Level = 'CRITICAL'
            Title = 'Fatal hardware error (Machine Check)'
            Cause = 'Machine Check Exception (MCE). CPU reporta error fatal. Muy probable inestabilidad hardware.'
            Action = 'Check CPU temp (HWiNFO). Remove OC. Test RAM. Si repite: CPU o placa posiblemente defectuosa.'
        }
        '*|WHEA-Logger|19' = @{
            Level = 'WARN'
            Title = 'Hardware error corregido (PCIe)'
            Cause = 'Error en bus PCIe corregido via AER.'
            Action = 'GPU/SSD PCIe mal asentada o cable defectuoso. Reseat + BIOS update.'
        }
        '*|WHEA-Logger|46' = @{
            Level = 'INFO'
            Title = 'Throttling CPU por temperatura'
            Cause = 'CPU redujo frecuencia por sobrecalentamiento.'
            Action = 'Tool Parts Upgrade -> ver temps. Limpieza de pasta termica + ventilador. Notebook viejo: casi seguro.'
        }
        '*|*|10016' = @{
            Level = 'INFO'
            Title = 'DCOM error de permisos'
            Cause = 'App intento llamar a un componente COM sin permisos. Casi siempre inofensivo.'
            Action = 'Ignorable. Microsoft lo reconoce como ruido. No toques DCOM permissions salvo que tengas sintoma concreto.'
        }
        '*|Microsoft-Windows-Kernel-Boot|134' = @{
            Level = 'INFO'
            Title = 'Tiempo de arranque registrado'
            Cause = 'Windows registro el tiempo que tardo el boot. Informativo.'
            Action = 'Si ves tiempo muy alto (>60s con SSD): defrag autostart, sfc, revisar programas de inicio.'
        }
        '*|*|4625' = @{
            Level = 'WARN'
            Title = 'Logon fallido'
            Cause = 'Alguien intento login con credenciales incorrectas. Mensaje contiene IP origen + usuario intentado.'
            Action = 'Si son muchos y de IPs externas: ataque por fuerza bruta. Desactiva RDP publico, usa VPN.'
        }
        '*|*|4720' = @{
            Level = 'WARN'
            Title = 'Cuenta de usuario creada'
            Cause = 'Una nueva cuenta local se creo.'
            Action = 'Verifica que la creaste tu. Si no: malware / acceso no autorizado. Ver quien la creo.'
        }
        '*|*|4726' = @{
            Level = 'WARN'
            Title = 'Cuenta de usuario eliminada'
            Cause = 'Una cuenta local se elimino.'
            Action = 'Verifica que no fue accidente. Si no lo hiciste tu: intrusion.'
        }
        '*|*|4724' = @{
            Level = 'WARN'
            Title = 'Password reset admin'
            Cause = 'Un admin reseteo el password de otra cuenta.'
            Action = 'Normal en helpdesk. Si no reconoces origen: acceso no autorizado.'
        }
        '*|*|4740' = @{
            Level = 'INFO'
            Title = 'Cuenta bloqueada por intentos fallidos'
            Cause = 'Account lockout (policy).'
            Action = 'Usuario olvido password o intento de ataque.'
        }
        '*|*|4672' = @{
            Level = 'INFO'
            Title = 'Privilegios especiales asignados'
            Cause = 'Un admin hizo login (normal).'
            Action = 'Informativo. Util para auditar quien tiene acceso.'
        }
        '*|*|16' = @{
            Level = 'INFO'
            Title = 'Microsoft-Windows-Time-Service sync'
            Cause = 'NTP sync tardio o fallido.'
            Action = 'Si repite: reiniciar w32time. sc config w32time start=auto + w32tm /resync.'
        }
        '*|*|36888' = @{
            Level = 'INFO'
            Title = 'Schannel fatal error'
            Cause = 'TLS handshake fallo. Frecuente con apps/navegadores antiguos y sitios que requieren TLS 1.2+.'
            Action = 'Si molesta: habilitar TLS 1.2 en Internet Options. Update Windows.'
        }
    }

    function _Kb-Lookup {
        param([string]$LogName, [string]$Provider, [int]$EventId)
        if ($null -eq $script:AtlasEventsKB) { return $null }
        $keys = @(
            "$LogName|$Provider|$EventId",
            "*|$Provider|$EventId",
            "*|*|$EventId"
        )
        foreach ($k in $keys) {
            if ($script:AtlasEventsKB.ContainsKey($k)) { return $script:AtlasEventsKB[$k] }
        }
        return $null
    }

    function _Level-Color {
        param([string]$Level)
        switch ($Level) {
            'CRITICAL' { 'Red' }
            'WARN'     { 'Yellow' }
            'INFO'     { 'DarkCyan' }
            default    { 'Gray' }
        }
    }

    function _Level-Icon {
        param([string]$Level)
        switch ($Level) {
            'CRITICAL' { '[X]' }
            'WARN'     { '[!]' }
            'INFO'     { '[i]' }
            default    { '   ' }
        }
    }

    function _Query-Events {
        param(
            [string]$LogName = 'System',
            [int[]]$Levels = @(1,2,3,4), # 1=Critical, 2=Error, 3=Warning, 4=Info (incluido por default para capturar 6006/1074/WHEA 46)
            [int[]]$Ids = $null,
            [int]$Hours = 24,
            [int]$MaxEvents = 500
        )
        $since = (Get-Date).AddHours(-[int]$Hours)
        $filter = @{
            LogName      = $LogName
            Level        = $Levels
            StartTime    = $since
        }
        if ($Ids -and $Ids.Count -gt 0) { $filter['Id'] = $Ids }
        try {
            return @(Get-WinEvent -FilterHashtable $filter -MaxEvents $MaxEvents -ErrorAction Stop)
        } catch {
            return @()
        }
    }

    function _Render-Events {
        param([array]$Events, [string]$Heading)
        Write-Host ''
        Write-Host "  --- $Heading ---" -ForegroundColor Cyan
        if (-not $Events -or $Events.Count -eq 0) {
            Write-Host '    (sin eventos en el rango consultado)' -ForegroundColor DarkGray
            return
        }
        # Agrupar por (Provider, Id) y mostrar resumen + primer mensaje
        $groups = $Events | Group-Object ProviderName, Id | Sort-Object Count -Descending
        foreach ($g in $groups) {
            $first = $g.Group[0]
            $kb = _Kb-Lookup $first.LogName $first.ProviderName ([int]$first.Id)
            $level = if ($kb) { $kb.Level } else { 'INFO' }
            $icon  = _Level-Icon $level
            $color = _Level-Color $level
            $title = if ($kb) { $kb.Title } else { "$($first.ProviderName) #$($first.Id)" }
            Write-Host ''
            Write-Host ("  $icon $title  [x$($g.Count)]") -ForegroundColor $color
            Write-Host ("     Provider: $($first.ProviderName) · EventID: $($first.Id) · Ultima: $($first.TimeCreated.ToString('yyyy-MM-dd HH:mm'))") -ForegroundColor DarkGray
            if ($kb) {
                Write-Host ("     Causa : $($kb.Cause)") -ForegroundColor Gray
                Write-Host ("     Accion: $($kb.Action)") -ForegroundColor White
            } else {
                $msg = ($first.Message -replace "`r?`n", ' ').Trim()
                if ($msg.Length -gt 180) { $msg = $msg.Substring(0,177) + '...' }
                Write-Host ("     $msg") -ForegroundColor Gray
            }
        }
    }

    function _Build-HtmlReport {
        param([string]$OutPath, [int]$Hours = 168)  # 7d default
        $sections = [ordered]@{
            'Ultimos Criticos (System+App)' = (_Query-Events -LogName 'System'      -Levels @(1,2) -Hours $Hours -MaxEvents 200) +
                                              (_Query-Events -LogName 'Application' -Levels @(1,2) -Hours $Hours -MaxEvents 200)
            'Reinicios Inesperados'         = _Query-Events -LogName 'System' -Ids @(41,6008,6006,1074) -Hours $Hours -MaxEvents 200
            'Hardware (WHEA / Disk)'        = _Query-Events -LogName 'System' -Ids @(1,17,18,19,46,47,7,51,52,55,153) -Hours $Hours -MaxEvents 200
            'App Crashes'                   = _Query-Events -LogName 'Application' -Ids @(1000,1001,1026) -Hours $Hours -MaxEvents 200
            'Drivers'                       = _Query-Events -LogName 'System' -Ids @(219,7026) -Hours $Hours -MaxEvents 200
        }

        # Seguridad requiere admin; capturamos por separado
        try {
            $sec = _Query-Events -LogName 'Security' -Ids @(4625,4720,4726,4724,4740) -Hours $Hours -MaxEvents 200
            if ($sec -and $sec.Count -gt 0) { $sections['Seguridad'] = $sec }
        } catch {}

        $hostName  = $env:COMPUTERNAME
        $generated = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
        $days = [int]([math]::Round($Hours/24))

        $htmlSections = ''
        foreach ($title in $sections.Keys) {
            $events = @($sections[$title])
            $htmlSections += "<section><h2>$([System.Net.WebUtility]::HtmlEncode($title)) <span class='count'>(" + $events.Count + ")</span></h2>"
            if ($events.Count -eq 0) {
                $htmlSections += "<p class='muted'>Sin eventos.</p></section>"
                continue
            }
            $groups = $events | Group-Object ProviderName, Id | Sort-Object Count -Descending
            $htmlSections += "<div class='events'>"
            foreach ($g in $groups) {
                $first = $g.Group[0]
                $kb = _Kb-Lookup $first.LogName $first.ProviderName ([int]$first.Id)
                $level = if ($kb) { $kb.Level } else { 'INFO' }
                $cls = $level.ToLower()
                # Raw string — el encoding se hace una sola vez al inyectarlo en $htmlSections.
                $evTitle = if ($kb) { $kb.Title } else { "$($first.ProviderName) #$($first.Id)" }
                $cause  = if ($kb) { [System.Net.WebUtility]::HtmlEncode($kb.Cause)  } else { '' }
                $action = if ($kb) { [System.Net.WebUtility]::HtmlEncode($kb.Action) } else { '' }
                $rawMsg = [System.Net.WebUtility]::HtmlEncode((($first.Message -replace "`r?`n", ' ').Trim()))
                if ($rawMsg.Length -gt 300) { $rawMsg = $rawMsg.Substring(0,297) + '...' }
                $htmlSections += "<div class='event $cls'>"
                $htmlSections += "<div class='ev-head'><span class='lvl'>$level</span><span class='ev-title'>$(([System.Net.WebUtility]::HtmlEncode($evTitle)))</span><span class='count'>x$($g.Count)</span></div>"
                $htmlSections += "<div class='meta'>Provider: <code>$([System.Net.WebUtility]::HtmlEncode($first.ProviderName))</code> · EventID: <code>$($first.Id)</code> · Ultima: <code>$($first.TimeCreated.ToString('yyyy-MM-dd HH:mm'))</code></div>"
                if ($kb) {
                    $htmlSections += "<div class='kb'><div><strong>Causa:</strong> $cause</div><div><strong>Accion:</strong> $action</div></div>"
                } else {
                    $htmlSections += "<div class='kb'><div class='raw'>$rawMsg</div></div>"
                }
                $htmlSections += '</div>'
            }
            $htmlSections += '</div></section>'
        }

        $html = @"
<!DOCTYPE html>
<html lang="es"><head><meta charset="utf-8"/>
<title>Diagnostico Eventos - $hostName</title>
<style>
  :root{--bg:#0f141b;--surf:#171d26;--surf2:#1e2631;--bord:#2c3444;--acc:#3b82f6;--text:#e5e7eb;--mut:#9ca3af;--ok:#22c55e;--warn:#eab308;--err:#ef4444}
  *{box-sizing:border-box}
  body{margin:0;background:var(--bg);color:var(--text);font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;font-size:13px;line-height:1.5}
  .wrap{max-width:1000px;margin:0 auto;padding:24px}
  header{background:linear-gradient(135deg,var(--acc),#1d4ed8);color:white;padding:28px;border-radius:10px;margin-bottom:20px;box-shadow:0 6px 24px rgba(59,130,246,.25)}
  header h1{margin:0 0 4px;font-size:26px;letter-spacing:-.5px}
  header .meta{opacity:.8;font-size:12px;margin-top:8px}
  section{background:var(--surf);border:1px solid var(--bord);border-radius:10px;padding:18px 22px;margin-bottom:16px}
  section h2{margin:0 0 12px;font-size:15px;color:#60a5fa;text-transform:uppercase;letter-spacing:.5px;border-bottom:1px solid var(--bord);padding-bottom:8px}
  section h2 .count{color:var(--mut);font-size:12px;font-weight:400;margin-left:8px}
  .event{background:var(--surf2);border-radius:8px;padding:12px 14px;margin:8px 0;border-left:4px solid var(--bord)}
  .event.critical{border-left-color:var(--err)}
  .event.warn{border-left-color:var(--warn)}
  .event.info{border-left-color:#60a5fa}
  .ev-head{display:flex;align-items:center;gap:10px;margin-bottom:4px}
  .lvl{font-size:10px;font-weight:700;padding:2px 7px;border-radius:4px;background:var(--bord);color:white;text-transform:uppercase;letter-spacing:.5px}
  .event.critical .lvl{background:var(--err)}
  .event.warn .lvl{background:var(--warn);color:#1a1300}
  .event.info .lvl{background:#60a5fa;color:#0a1828}
  .ev-title{flex:1;font-weight:600;font-size:14px}
  .count{color:var(--mut);font-size:12px}
  .meta{color:var(--mut);font-size:11px;margin-bottom:6px}
  code{background:#0d121a;padding:1px 6px;border-radius:3px;color:#cbd5e1;font-size:11px}
  .kb{font-size:12.5px;line-height:1.55}
  .kb div{margin:3px 0}
  .kb strong{color:#60a5fa}
  .kb .raw{color:var(--mut);font-style:italic;font-size:12px}
  .muted{color:var(--mut);font-style:italic}
  .toolbar{position:sticky;top:10px;z-index:10;text-align:right;margin-bottom:12px}
  .btn{background:var(--acc);color:white;border:0;border-radius:6px;padding:9px 16px;font-size:12px;cursor:pointer;font-weight:500}
  .btn:hover{background:#60a5fa}
  @media print{
    body{background:white !important;color:black !important;font-size:11pt}
    header{background:white !important;color:black !important;border:2px solid #333;box-shadow:none}
    header h1{color:#1d4ed8 !important}
    section{background:white !important;border:1px solid #999 !important;color:black !important;page-break-inside:avoid}
    section h2{color:#1d4ed8 !important;border-color:#999}
    .event{background:#f7f8fa !important;color:black !important;break-inside:avoid}
    .event.critical{border-left:4px solid #c00 !important}
    .event.warn{border-left:4px solid #c90 !important}
    .meta,.muted{color:#555 !important}
    code{background:#eee !important;color:#333 !important}
    .kb strong{color:#1d4ed8 !important}
    .toolbar,.no-print{display:none !important}
  }
</style></head><body>
<div class="wrap">
<div class="toolbar no-print"><button class="btn" onclick="window.print()">🖨  Imprimir / PDF</button></div>
<header>
  <h1>ATLAS PC SUPPORT · Diagnostico Eventos</h1>
  <div>Equipo: <strong>$hostName</strong> · Rango: ultimos $days dias</div>
  <div class="meta">Generado: $generated</div>
</header>
$htmlSections
</div></body></html>
"@

        Set-Content -LiteralPath $OutPath -Value $html -Encoding UTF8
        return $OutPath
    }

    # ----- Menu -----
    while ($true) {
        Clear-Host
        Write-Host ''
        Write-Host '================================================================' -ForegroundColor Cyan
        Write-Host '  Diagnostico Eventos (Windows Event Viewer)' -ForegroundColor Cyan
        Write-Host '================================================================' -ForegroundColor Cyan
        Write-Host ''
        Write-Host "  Equipo: $env:COMPUTERNAME"
        Write-Host ''
        Write-Host '  [1] Ultimos errores criticos (24h)' -ForegroundColor White
        Write-Host '  [2] Reinicios inesperados (7d)' -ForegroundColor White
        Write-Host '  [3] Hardware (WHEA / Disk) (7d)' -ForegroundColor White
        Write-Host '  [4] App crashes (7d)' -ForegroundColor White
        Write-Host '  [5] Drivers (7d)' -ForegroundColor White
        Write-Host '  [6] Seguridad (7d) [requiere admin]' -ForegroundColor White
        Write-Host '  [7] Exportar reporte HTML (ultimos 7d)' -ForegroundColor Yellow
        Write-Host '  [8] Buscar por EventID (base de conocimiento)' -ForegroundColor White
        Write-Host '  [Q] Salir' -ForegroundColor DarkGray
        Write-Host ''
        $opt = Read-Host '  Opcion'
        $opt = $opt.Trim().ToUpper()

        switch ($opt) {
            '1' {
                $a = _Query-Events -LogName 'System'      -Levels @(1,2) -Hours 24 -MaxEvents 200
                $b = _Query-Events -LogName 'Application' -Levels @(1,2) -Hours 24 -MaxEvents 200
                _Render-Events @($a + $b) 'Criticos / Errores (System + Application, 24h)'
                Read-Host "`n  ENTER para volver"
            }
            '2' {
                $e = _Query-Events -LogName 'System' -Ids @(41,6008,6006,1074) -Hours 168 -MaxEvents 200
                _Render-Events $e 'Reinicios inesperados (7d)'
                Read-Host "`n  ENTER para volver"
            }
            '3' {
                $e = _Query-Events -LogName 'System' -Ids @(1,17,18,19,46,47,7,51,52,55,153) -Hours 168 -MaxEvents 300
                _Render-Events $e 'Hardware WHEA + Disk (7d)'
                Read-Host "`n  ENTER para volver"
            }
            '4' {
                $e = _Query-Events -LogName 'Application' -Ids @(1000,1001,1026) -Hours 168 -MaxEvents 300
                _Render-Events $e 'Application crashes (7d)'
                Read-Host "`n  ENTER para volver"
            }
            '5' {
                $e = _Query-Events -LogName 'System' -Ids @(219,7026) -Hours 168 -MaxEvents 200
                _Render-Events $e 'Drivers fallidos (7d)'
                Read-Host "`n  ENTER para volver"
            }
            '6' {
                try {
                    $e = _Query-Events -LogName 'Security' -Ids @(4625,4720,4726,4724,4740) -Hours 168 -MaxEvents 300
                    _Render-Events $e 'Seguridad (7d)'
                } catch {
                    Write-Host ''
                    Write-Host "  [X] Acceso a Security log denegado: $($_.Exception.Message)" -ForegroundColor Red
                    Write-Host '      Relanza el panel como Administrador.' -ForegroundColor DarkGray
                }
                Read-Host "`n  ENTER para volver"
            }
            '7' {
                $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
                $desktop = [Environment]::GetFolderPath('Desktop')
                $out = Join-Path $desktop "atlas-eventos-$env:COMPUTERNAME-$stamp.html"
                Write-Host ''
                Write-Host '  Generando reporte HTML (ultimos 7d)... puede tardar 5-15s...' -ForegroundColor Yellow
                try {
                    $saved = _Build-HtmlReport -OutPath $out -Hours 168
                    Write-Host "  [OK] Guardado: $saved" -ForegroundColor Green
                    try { Start-Process $saved } catch {}
                } catch {
                    Write-Host "  [X] Error: $($_.Exception.Message)" -ForegroundColor Red
                }
                Read-Host "`n  ENTER para volver"
            }
            '8' {
                Write-Host ''
                $idTxt = Read-Host '  EventID a buscar (ej. 41, 6008, 4625)'
                $idN = 0
                if (-not [int]::TryParse($idTxt, [ref]$idN)) {
                    Write-Host '  [X] ID invalido.' -ForegroundColor Red
                    Read-Host "`n  ENTER"
                    continue
                }
                $kb = _Kb-Lookup '*' '*' $idN
                Write-Host ''
                if ($kb) {
                    $color = _Level-Color $kb.Level
                    Write-Host "  [$(_Level-Icon $kb.Level)] EventID $idN - $($kb.Title)" -ForegroundColor $color
                    Write-Host "      Severidad: $($kb.Level)" -ForegroundColor $color
                    Write-Host "      Causa    : $($kb.Cause)" -ForegroundColor Gray
                    Write-Host "      Accion   : $($kb.Action)" -ForegroundColor White
                } else {
                    Write-Host "  [i] EventID $idN no esta en la base de conocimiento." -ForegroundColor Yellow
                    Write-Host "      Consulta en: https://www.google.com/search?q=windows+event+id+$idN" -ForegroundColor DarkGray
                }
                Write-Host ''
                Write-Host '  Mostrando ocurrencias recientes en System + Application (30d, top 5)...' -ForegroundColor DarkGray
                $combined = @()
                foreach ($log in @('System','Application')) {
                    $r = _Query-Events -LogName $log -Ids @($idN) -Levels @(1,2,3,4) -Hours 720 -MaxEvents 20
                    $combined += $r
                }
                if ($combined.Count -eq 0) {
                    Write-Host '    (ninguna en los ultimos 30 dias)' -ForegroundColor DarkGray
                } else {
                    $combined | Sort-Object TimeCreated -Descending | Select-Object -First 5 | ForEach-Object {
                        $msg = ($_.Message -replace "`r?`n", ' ').Trim()
                        if ($msg.Length -gt 140) { $msg = $msg.Substring(0,137) + '...' }
                        Write-Host ("    - $($_.TimeCreated.ToString('yyyy-MM-dd HH:mm')) [$($_.LogName)] $msg") -ForegroundColor DarkGray
                    }
                }
                Read-Host "`n  ENTER para volver"
            }
            'Q' { return }
            default { }
        }
    }
}
