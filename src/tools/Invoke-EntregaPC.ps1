# ============================================================
# Invoke-EntregaPC
# Migrado de: Entrega_PC.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-EntregaPC {
    [CmdletBinding()]
    param()
﻿# =================================================================
# SCRIPT DE ENTREGA PREMIUM CENTRADO - ATLAS SOPORTE
# =================================================================

# 1. Forzar permisos de Administrador
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "ATENCIÓN: Este script necesita permisos de Administrador."
    Write-Warning "Haz clic derecho en el archivo y selecciona 'Ejecutar con PowerShell' como administrador."
    Pause
    return
}

# 2. Configurar la interfaz de la consola
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

# --- FUNCIÓN: Centrar Texto Mágicamente ---
function Escribir-Centrado {
    param([string]$texto, [string]$color)
    $anchoConsola = $Host.UI.RawUI.WindowSize.Width
    $espacios = " " * ([math]::Max(0, [math]::Floor(($anchoConsola - $texto.Length) / 2)))
    Write-Host ($espacios + $texto) -ForegroundColor $color
}

# --- FUNCIÓN: Mostrar el Logo ---
function Mostrar-Encabezado {
    Clear-Host
    Write-Host "`n"
    Escribir-Centrado " █████╗ ████████╗██╗      █████╗ ███████╗" "DarkYellow"
    Escribir-Centrado "██╔══██╗╚══██╔══╝██║     ██╔══██╗██╔════╝" "DarkYellow"
    Escribir-Centrado "███████║   ██║   ██║     ███████║███████╗" "DarkYellow"
    Escribir-Centrado "██╔══██║   ██║   ██║     ██╔══██║╚════██║" "DarkYellow"
    Escribir-Centrado "██║  ██║   ██║   ███████╗██║  ██║███████║" "DarkYellow"
    Escribir-Centrado "╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝" "DarkYellow"
    Escribir-Centrado "        P C   S U P P O R T              " "DarkYellow"
    Escribir-Centrado "=========================================" "DarkGray"
    Write-Host "`n"
}

# --- FUNCIÓN: Modificar Usuario Actual ---
function Modificar-UsuarioActual {
    $userName = $env:USERNAME
    Escribir-Centrado "--- CONFIGURANDO USUARIO ACTUAL: [$userName] ---" "Cyan"
    Write-Host ""
    Write-Host "   (Escriba '0' en cualquier momento para cancelar y volver)" -ForegroundColor DarkGray
    Write-Host ""
    
    $newDisplayName = Read-Host "   -> Nombre y apellido del cliente"
    if ($newDisplayName -eq "0") { return }
    
    Write-Host "   -> Contraseña (Escriba a ciegas y presione ENTER. Deje en blanco para NO usar clave)" -ForegroundColor Yellow
    $securePassword = Read-Host "      Clave" -AsSecureString

    try {
        if (![string]::IsNullOrWhiteSpace($newDisplayName)) {
            Set-LocalUser -Name $userName -FullName $newDisplayName
            Write-Host "`n   [OK] Nombre actualizado a: $newDisplayName" -ForegroundColor Green
        }
        if ($securePassword.Length -gt 0) {
            Set-LocalUser -Name $userName -Password $securePassword
            Write-Host "   [OK] Contraseña establecida." -ForegroundColor Green
        } else {
            Write-Host "`n   [OK] El usuario se mantiene sin contraseña." -ForegroundColor Green
        }
    } catch {
        Write-Host "`n   [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host "`n   Presione ENTER para volver al menú principal..." -ForegroundColor DarkGray
    Read-Host
}

# --- FUNCIÓN: Crear Usuario Nuevo ---
function Crear-NuevoUsuario {
    Escribir-Centrado "--- CREANDO NUEVO USUARIO ---" "Cyan"
    Write-Host ""
    Write-Host "   (Escriba '0' en cualquier momento para cancelar y volver)" -ForegroundColor DarkGray
    Write-Host ""
    
    $newUser = Read-Host "   -> Nombre interno de la cuenta (ej. jorge, sin espacios)"
    if ($newUser -eq "0" -or [string]::IsNullOrWhiteSpace($newUser)) { return }

    $newDisplayName = Read-Host "   -> Nombre completo para la pantalla (ej. Jorge Martínez)"
    if ($newDisplayName -eq "0") { return }
    
    Write-Host "   -> Contraseña (Escriba a ciegas y presione ENTER. Deje en blanco para NO usar clave)" -ForegroundColor Yellow
    $securePassword = Read-Host "      Clave" -AsSecureString
    
    $esAdmin = Read-Host "   -> ¿Hacer a este usuario Administrador? (S/N)"
    if ($esAdmin -eq "0") { return }

    try {
        if ($securePassword.Length -gt 0) {
            New-LocalUser -Name $newUser -FullName $newDisplayName -Password $securePassword -PasswordNeverExpires $true | Out-Null
        } else {
            New-LocalUser -Name $newUser -FullName $newDisplayName -NoPassword | Out-Null
        }
        Write-Host "`n   [OK] Usuario '$newUser' creado correctamente." -ForegroundColor Green

        if ($esAdmin -match "^[sS]") {
            $AdminGroup = Get-LocalGroup | Where-Object SID -eq "S-1-5-32-544"
            Add-LocalGroupMember -Group $AdminGroup -Member $newUser
            Write-Host "   [OK] Permisos de Administrador concedidos." -ForegroundColor Green
        } else {
            $UsersGroup = Get-LocalGroup | Where-Object SID -eq "S-1-5-32-545"
            Add-LocalGroupMember -Group $UsersGroup -Member $newUser
            Write-Host "   [OK] Permisos de Usuario Estándar concedidos." -ForegroundColor Green
        }
    } catch {
        Write-Host "`n   [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host "`n   Presione ENTER para volver al menú principal..." -ForegroundColor DarkGray
    Read-Host
}

# --- FUNCIÓN: Renombrar Equipo ---
function Renombrar-Equipo {
    Escribir-Centrado "--- RENOMBRAR EQUIPO ---" "Cyan"
    Write-Host ""
    $actual = $env:COMPUTERNAME
    Write-Host "   Nombre actual: $actual" -ForegroundColor White
    Write-Host ""
    $nuevo = Read-Host "   -> Nuevo nombre (0 para cancelar)"
    if ($nuevo -eq "0" -or [string]::IsNullOrWhiteSpace($nuevo)) { return }
    if ($nuevo -notmatch '^[A-Za-z0-9\-]{1,15}$') {
        Write-Host "`n   [ERROR] Nombre invalido. Solo A-Z 0-9 y guion, max 15." -ForegroundColor Red
        Read-Host "`n   ENTER para volver"
        return
    }
    try {
        Rename-Computer -NewName $nuevo -Force -ErrorAction Stop
        Write-Host "`n   [OK] Nombre cambiado a: $nuevo" -ForegroundColor Green
        Write-Host "   Debe reiniciar el equipo para aplicar." -ForegroundColor Yellow
    } catch {
        Write-Host "`n   [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "`n   ENTER para volver"
}

# --- HELPERS de escape HTML (inline, tool aislada) ---
function _Esc-Html {
    param([string]$Text)
    if ($null -eq $Text) { return '' }
    return ([System.Net.WebUtility]::HtmlEncode($Text))
}

function _Row {
    param([string]$Label, [string]$Value)
    $v = _Esc-Html $Value
    $l = _Esc-Html $Label
    return "<tr><th>$l</th><td>$v</td></tr>"
}

# --- FUNCION: Generar Checklist de Entrega (reporte HTML) ---
function Generar-ChecklistEntrega {
    Escribir-Centrado "--- GENERANDO CHECKLIST DE ENTREGA (HTML) ---" "Cyan"
    Write-Host ""
    Write-Host "   Recopilando informacion del equipo..." -ForegroundColor Yellow

    # Recopilar datos
    $now = Get-Date
    $generated = $now.ToString('yyyy-MM-dd HH:mm:ss')
    $hostName  = $env:COMPUTERNAME
    $userName  = $env:USERNAME

    $equipoRows = @()
    try {
        $cs   = Get-CimInstance Win32_ComputerSystem -ErrorAction Stop
        $bios = Get-CimInstance Win32_BIOS -ErrorAction Stop
        $os   = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
        $equipoRows += _Row 'Nombre'       $hostName
        $equipoRows += _Row 'Fabricante'   ($cs.Manufacturer)
        $equipoRows += _Row 'Modelo'       ($cs.Model)
        $equipoRows += _Row 'Serial BIOS'  ($bios.SerialNumber)
        $equipoRows += _Row 'OS'           ($os.Caption)
        $equipoRows += _Row 'Version'      ($os.Version)
        $equipoRows += _Row 'Build'        ($os.BuildNumber)
        $equipoRows += _Row 'Arquitectura' ($os.OSArchitecture)
        $equipoRows += _Row 'RAM total'    (("{0:N1} GB" -f ($cs.TotalPhysicalMemory/1GB)))
    } catch {
        $equipoRows += "<tr><td colspan='2' class='err'>Error obteniendo info equipo: $(_Esc-Html $_.Exception.Message)</td></tr>"
    }

    $activacion = ''
    try {
        $licInfo = cscript.exe //Nologo "C:\Windows\System32\slmgr.vbs" /xpr 2>&1
        $activacion = _Esc-Html (($licInfo -join "`n").Trim())
    } catch {
        $activacion = "<span class='err'>No se pudo consultar activacion.</span>"
    }

    $usuariosHtml = ''
    $adminsHtml   = ''
    try {
        $ul = Get-LocalUser -ErrorAction Stop | Where-Object { $_.Enabled }
        $usuariosHtml = ($ul | ForEach-Object {
            "<li><strong>$(_Esc-Html $_.Name)</strong> <span class='muted'>$(_Esc-Html $_.FullName)</span></li>"
        }) -join ''
        $adminGroup = Get-LocalGroup | Where-Object SID -eq 'S-1-5-32-544'
        if ($adminGroup) {
            $members = Get-LocalGroupMember -Group $adminGroup -ErrorAction SilentlyContinue
            if ($members) {
                $adminsHtml = ($members | ForEach-Object { "<li>$(_Esc-Html $_.Name)</li>" }) -join ''
            }
        }
    } catch {
        $usuariosHtml = "<li class='err'>Error: $(_Esc-Html $_.Exception.Message)</li>"
    }

    $bitlockerRows = @()
    try {
        $vols = Get-BitLockerVolume -ErrorAction Stop
        foreach ($v in $vols) {
            $status = "$(_Esc-Html $v.VolumeStatus) · Protection: $(_Esc-Html $v.ProtectionStatus) · Enc: $($v.EncryptionPercentage)%"
            $rk = $v.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
            $keys = ''
            foreach ($r in $rk) {
                $keys += "<div class='key-block'><div class='muted small'>Key ID: $(_Esc-Html $r.KeyProtectorId)</div><code>$(_Esc-Html $r.RecoveryPassword)</code></div>"
            }
            $bitlockerRows += "<tr><th>$(_Esc-Html $v.MountPoint)</th><td>$status$keys</td></tr>"
        }
    } catch {
        $bitlockerRows += "<tr><td colspan='2' class='err'>BitLocker no disponible: $(_Esc-Html $_.Exception.Message)</td></tr>"
    }

    $discosHtml = ''
    try {
        $discosHtml += '<table class="mini"><thead><tr><th>Modelo</th><th>Serial</th><th>Tamaño</th><th>Salud</th><th>Tipo</th></tr></thead><tbody>'
        Get-PhysicalDisk -ErrorAction Stop | ForEach-Object {
            $health = _Esc-Html "$($_.HealthStatus)"
            $cls = if ($_.HealthStatus -eq 'Healthy') { 'ok' } elseif ($_.HealthStatus -eq 'Warning') { 'warn' } else { 'err' }
            $discosHtml += "<tr><td>$(_Esc-Html $_.FriendlyName)</td><td><code>$(_Esc-Html $_.SerialNumber)</code></td><td>$("{0:N0} GB" -f ($_.Size/1GB))</td><td class='$cls'>$health</td><td>$(_Esc-Html $_.MediaType)</td></tr>"
        }
        $discosHtml += '</tbody></table>'
    } catch {
        $discosHtml = "<p class='err'>Error: $(_Esc-Html $_.Exception.Message)</p>"
    }

    $volumenesHtml = ''
    try {
        $volumenesHtml += '<table class="mini"><thead><tr><th>Drive</th><th>Label</th><th>Libre</th><th>Total</th><th>FS</th></tr></thead><tbody>'
        Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter } | Sort-Object DriveLetter | ForEach-Object {
            $pctFree = if ($_.Size -gt 0) { [int](($_.SizeRemaining/$_.Size)*100) } else { 0 }
            $cls = if ($pctFree -lt 10) { 'err' } elseif ($pctFree -lt 20) { 'warn' } else { 'ok' }
            $volumenesHtml += "<tr><td><strong>$($_.DriveLetter):</strong></td><td>$(_Esc-Html $_.FileSystemLabel)</td><td class='$cls'>$("{0:N1} GB" -f ($_.SizeRemaining/1GB)) ($pctFree%)</td><td>$("{0:N1} GB" -f ($_.Size/1GB))</td><td>$(_Esc-Html $_.FileSystem)</td></tr>"
        }
        $volumenesHtml += '</tbody></table>'
    } catch {
        $volumenesHtml = "<p class='err'>Error volumenes: $(_Esc-Html $_.Exception.Message)</p>"
    }

    $hotfixHtml = ''
    try {
        $hotfixHtml += '<table class="mini"><thead><tr><th>HotFix</th><th>Instalado</th><th>Tipo</th></tr></thead><tbody>'
        Get-HotFix -ErrorAction Stop | Sort-Object InstalledOn -Descending | Select-Object -First 10 | ForEach-Object {
            $hotfixHtml += "<tr><td><code>$(_Esc-Html $_.HotFixID)</code></td><td>$(_Esc-Html $_.InstalledOn.ToString('yyyy-MM-dd'))</td><td>$(_Esc-Html $_.Description)</td></tr>"
        }
        $hotfixHtml += '</tbody></table>'
    } catch {
        $hotfixHtml = "<p class='err'>Error HotFix: $(_Esc-Html $_.Exception.Message)</p>"
    }

    $redHtml = ''
    try {
        $ips = Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop | Where-Object { $_.IPAddress -notlike '169.*' -and $_.IPAddress -notlike '127.*' }
        if ($ips) {
            $redHtml = '<ul>'
            foreach ($ip in $ips) {
                $redHtml += "<li><strong>$(_Esc-Html $ip.InterfaceAlias):</strong> <code>$(_Esc-Html $ip.IPAddress)/$($ip.PrefixLength)</code></li>"
            }
            $redHtml += '</ul>'
        } else {
            $redHtml = "<p class='muted'>Sin interfaces activas.</p>"
        }
    } catch {}

    $defenderRows = @()
    try {
        $mp = Get-MpComputerStatus -ErrorAction Stop
        $defenderRows += _Row 'AV Enabled'          ([string]$mp.AntivirusEnabled)
        $defenderRows += _Row 'RealTime Protection' ([string]$mp.RealTimeProtectionEnabled)
        $defenderRows += _Row 'AV Signature'        ([string]$mp.AntivirusSignatureLastUpdated)
    } catch {}

    # --- Ensamblar HTML ---
    $checklistItems = @(
        'Hardware probado (pantalla, teclado, táctil, audio, USB, webcam, lector huellas)',
        'Batería al 100% y cargador incluido',
        'Antivirus activo y actualizado',
        'BitLocker activado y recovery key guardada en sitio seguro',
        'Windows Update al día',
        'Navegador limpio (sin cuentas guardadas del técnico)',
        'Usuario cliente creado con nombre correcto',
        'Password entregada físicamente o por canal seguro',
        'Cliente informado sobre garantía y contacto',
        'Equipo limpio (polvo, pantalla, teclado)',
        'Documentos de cliente recuperados y restaurados',
        'Programas solicitados por el cliente instalados'
    )
    $checklistHtml = ''
    $i = 0
    foreach ($item in $checklistItems) {
        $i++
        $checklistHtml += "<label class='check'><input type='checkbox' id='c$i'><span>$(_Esc-Html $item)</span></label>"
    }

    $equipoTable    = $equipoRows    -join ''
    $bitlockerTable = $bitlockerRows -join ''
    $defenderTable  = $defenderRows  -join ''

    # Uso here-string double-quoted para interpolacion; escapamos los $ de CSS con backtick.
    $html = @"
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8"/>
<title>Atlas PC Support - Checklist Entrega - $hostName</title>
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<style>
  :root {
    --bg: #0f141b;
    --surface: #171d26;
    --surface-alt: #1e2631;
    --border: #2c3444;
    --accent: #3b82f6;
    --accent-hover: #60a5fa;
    --text: #e5e7eb;
    --muted: #9ca3af;
    --ok: #22c55e;
    --warn: #eab308;
    --err: #ef4444;
    --radius: 10px;
  }
  * { box-sizing: border-box; }
  body {
    margin: 0;
    background: var(--bg);
    color: var(--text);
    font-family: -apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif;
    font-size: 14px;
    line-height: 1.5;
  }
  .wrap { max-width: 960px; margin: 0 auto; padding: 24px; }
  header {
    background: linear-gradient(135deg, var(--accent) 0%, #1d4ed8 100%);
    color: white;
    padding: 32px 24px;
    border-radius: var(--radius);
    margin-bottom: 24px;
    box-shadow: 0 6px 24px rgba(59,130,246,0.25);
  }
  header h1 { margin: 0 0 4px 0; font-size: 28px; letter-spacing: -0.5px; }
  header .subtitle { opacity: .85; font-size: 14px; }
  header .meta { margin-top: 12px; font-size: 12px; opacity: .75; }
  section {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    padding: 20px 24px;
    margin-bottom: 16px;
  }
  section h2 {
    margin: 0 0 12px 0;
    font-size: 16px;
    color: var(--accent-hover);
    letter-spacing: .5px;
    text-transform: uppercase;
    border-bottom: 1px solid var(--border);
    padding-bottom: 8px;
  }
  table { border-collapse: collapse; width: 100%; font-size: 13px; }
  table th, table td { text-align: left; padding: 6px 10px; border-bottom: 1px solid var(--border); }
  table th { color: var(--muted); font-weight: 500; white-space: nowrap; width: 30%; }
  table.mini th, table.mini td { padding: 5px 8px; font-size: 12px; }
  table.mini thead th { background: var(--surface-alt); color: var(--accent-hover); font-weight: 600; text-transform: uppercase; font-size: 11px; letter-spacing: .5px; border-bottom: 2px solid var(--border); }
  code { background: var(--surface-alt); padding: 2px 6px; border-radius: 4px; font-size: 12px; color: #cbd5e1; }
  pre { background: var(--surface-alt); padding: 10px; border-radius: 6px; white-space: pre-wrap; font-size: 12px; }
  ul { margin: 4px 0; padding-left: 20px; }
  li { margin: 2px 0; }
  .muted { color: var(--muted); }
  .small { font-size: 11px; }
  .ok { color: var(--ok); font-weight: 500; }
  .warn { color: var(--warn); font-weight: 500; }
  .err { color: var(--err); font-weight: 500; }
  .key-block { margin-top: 4px; background: var(--surface-alt); padding: 8px; border-radius: 4px; border-left: 3px solid var(--warn); }
  .key-block code { background: transparent; color: var(--warn); font-size: 13px; font-weight: 600; letter-spacing: .5px; }
  .check { display: flex; align-items: flex-start; padding: 10px 12px; margin: 4px 0; background: var(--surface-alt); border-radius: 6px; cursor: pointer; transition: background .15s; border: 1px solid transparent; }
  .check:hover { background: #252d3a; border-color: var(--border); }
  .check input[type=checkbox] { flex-shrink: 0; width: 18px; height: 18px; margin-right: 10px; accent-color: var(--accent); cursor: pointer; }
  .check input[type=checkbox]:checked + span { color: var(--ok); text-decoration: line-through; opacity: .7; }
  .check span { flex: 1; }
  .signature-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-top: 16px; }
  .signature-box { padding: 30px 10px 10px; border-top: 2px solid var(--border); text-align: center; color: var(--muted); font-size: 12px; min-height: 80px; }
  .toolbar { position: sticky; top: 10px; z-index: 10; display: flex; gap: 10px; justify-content: flex-end; margin-bottom: 12px; }
  .btn { background: var(--accent); color: white; border: 0; border-radius: 6px; padding: 10px 18px; font-size: 13px; cursor: pointer; font-weight: 500; transition: background .15s; }
  .btn:hover { background: var(--accent-hover); }
  .btn.secondary { background: var(--surface-alt); color: var(--text); border: 1px solid var(--border); }
  footer { margin-top: 32px; padding: 16px; text-align: center; color: var(--muted); font-size: 11px; }

  @media print {
    body { background: white !important; color: black !important; font-size: 11pt; }
    .wrap { max-width: 100%; padding: 0; }
    header { background: white !important; color: black !important; border: 2px solid #333; box-shadow: none; page-break-after: avoid; }
    header h1, header .subtitle { color: #1d4ed8 !important; }
    section { background: white !important; border: 1px solid #999 !important; color: black !important; page-break-inside: avoid; }
    section h2 { color: #1d4ed8 !important; border-color: #999; }
    table th, table td { border-bottom: 1px solid #ccc !important; color: black !important; }
    table.mini thead th { background: #eee !important; color: #1d4ed8 !important; }
    code, pre { background: #f5f5f5 !important; color: black !important; }
    .check { background: white !important; border: 1px solid #999 !important; break-inside: avoid; }
    .key-block { background: #fff8e6 !important; color: #666 !important; }
    .key-block code { color: #7a5a00 !important; }
    .muted { color: #666 !important; }
    .toolbar, .no-print { display: none !important; }
    .signature-box { border-top: 2px solid black; color: black; }
    a { color: black; text-decoration: none; }
  }
</style>
</head>
<body>
<div class="wrap">

<div class="toolbar no-print">
  <button class="btn" onclick="window.print()">🖨  Imprimir / Guardar PDF</button>
  <button class="btn secondary" onclick="toggleAll()">☑ Marcar todos</button>
</div>

<header>
  <h1>ATLAS PC SUPPORT</h1>
  <div class="subtitle">Checklist de Entrega — $(_Esc-Html $hostName)</div>
  <div class="meta">Generado: $(_Esc-Html $generated) · Operador: $(_Esc-Html $userName)</div>
</header>

<section>
  <h2>💻 Equipo</h2>
  <table>$equipoTable</table>
</section>

<section>
  <h2>🔑 Activación Windows</h2>
  <pre>$activacion</pre>
</section>

<section>
  <h2>👤 Usuarios</h2>
  <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px">
    <div>
      <h3 style="margin:0 0 6px;font-size:13px;color:var(--muted);text-transform:uppercase">Locales habilitados</h3>
      <ul>$usuariosHtml</ul>
    </div>
    <div>
      <h3 style="margin:0 0 6px;font-size:13px;color:var(--muted);text-transform:uppercase">Administradores</h3>
      <ul>$adminsHtml</ul>
    </div>
  </div>
</section>

<section>
  <h2>🔒 BitLocker</h2>
  <table>$bitlockerTable</table>
  <p class="small muted">Guarda las Recovery Keys en un sitio fuera del PC (gestor de contraseñas, impresión firmada, carpeta cliente).</p>
</section>

<section>
  <h2>💾 Discos físicos</h2>
  $discosHtml
  <h3 style="margin:16px 0 6px;font-size:13px;color:var(--muted);text-transform:uppercase">Volúmenes</h3>
  $volumenesHtml
</section>

<section>
  <h2>🌐 Red</h2>
  $redHtml
</section>

<section>
  <h2>🛡 Windows Defender</h2>
  <table>$defenderTable</table>
</section>

<section>
  <h2>🔄 Últimas actualizaciones (top 10)</h2>
  $hotfixHtml
</section>

<section>
  <h2>✅ Checklist manual pre-entrega</h2>
  $checklistHtml
</section>

<section>
  <h2>✍ Firmas</h2>
  <div class="signature-grid">
    <div class="signature-box">Firma Técnico<br/><span class="small">$(_Esc-Html $userName)</span></div>
    <div class="signature-box">Firma Cliente<br/><span class="small">_______________________</span></div>
  </div>
  <p class="small muted" style="margin-top:12px">Fecha entrega: ____________________</p>
</section>

<footer>
  Atlas PC Support · Reporte generado automáticamente · Guarda este archivo o impr. a PDF para registro
</footer>

</div>
<script>
function toggleAll(){
  var b=document.querySelectorAll(".check input[type=checkbox]");
  var all=true; for(var i=0;i<b.length;i++){ if(!b[i].checked){all=false;break;} }
  for(var j=0;j<b.length;j++){ b[j].checked=!all; }
}
</script>
</body>
</html>
"@

    # Guardar
    try {
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $desktop = [Environment]::GetFolderPath('Desktop')
        $out = Join-Path $desktop "atlas-entrega-$hostName-$stamp.html"
        Set-Content -Path $out -Value $html -Encoding UTF8
        Write-Host ""
        Write-Host "   [OK] Reporte HTML guardado en:" -ForegroundColor Green
        Write-Host "   $out" -ForegroundColor White
        Write-Host ""
        Write-Host "   Abriendo en navegador..." -ForegroundColor DarkGray
        try { Start-Process $out } catch {
            try { Start-Process 'explorer.exe' -ArgumentList $out } catch {}
        }
    } catch {
        Write-Host ""
        Write-Host "   [ERROR] No se pudo guardar: $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "`n   ENTER para volver"
}

# =================================================================
# BUCLE PRINCIPAL DEL MENÚ
# =================================================================
while ($true) {
    Mostrar-Encabezado

    $l1 = "[ 1 ]  Entregar equipo (Usuario actual: $env:USERNAME)"
    $l2 = "[ 2 ]  Crear un usuario nuevo adicional"
    $l3 = "[ 3 ]  Renombrar equipo"
    $l4 = "[ 4 ]  Generar CHECKLIST DE ENTREGA (reporte)"
    $l5 = "[ 5 ]  Salir y cerrar herramienta"

    $maxLen = [math]::Max($l1.Length, [math]::Max($l2.Length, [math]::Max($l3.Length, [math]::Max($l4.Length, $l5.Length))))

    Escribir-Centrado $l1.PadRight($maxLen) "White"
    Escribir-Centrado $l2.PadRight($maxLen) "White"
    Escribir-Centrado $l3.PadRight($maxLen) "White"
    Escribir-Centrado $l4.PadRight($maxLen) "Green"
    Escribir-Centrado $l5.PadRight($maxLen) "DarkGray"
    Write-Host ""

    $textoPrompt = "Seleccione una opción [1-5]"
    $ancho = $Host.UI.RawUI.WindowSize.Width
    $espacios = " " * ([math]::Max(0, [math]::Floor(($ancho - $textoPrompt.Length - 2) / 2)))
    Write-Host $espacios -NoNewline
    $opcion = Read-Host $textoPrompt

    switch ($opcion) {
        '1' { Mostrar-Encabezado; Modificar-UsuarioActual }
        '2' { Mostrar-Encabezado; Crear-NuevoUsuario }
        '3' { Mostrar-Encabezado; Renombrar-Equipo }
        '4' { Mostrar-Encabezado; Generar-ChecklistEntrega }
        '5' { Clear-Host; exit }
        default { Escribir-Centrado "Opción no válida." "Red"; Start-Sleep -s 1 }
    }
}
}
