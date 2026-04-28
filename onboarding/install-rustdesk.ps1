# ============================================================
# Atlas PC Support - RustDesk onboarding installer
#
# Purpose:
#   Bootstraps RustDesk on a new client's PC with Atlas's
#   self-hosted server (rustdesk.atlaspcsupport.com) pre-configured.
#
# Flow:
#   1. Detects CPU architecture (x64 / arm64).
#   2. Downloads the latest RustDesk release from GitHub.
#   3. Installs silently as a Windows service.
#   4. Applies Atlas server config via `rustdesk.exe --config`.
#   5. Generates a unique 16-char permanent password (per machine).
#   6. Reads the assigned ID via `rustdesk.exe --get-id`.
#   7. Writes a recovery file at C:\ProgramData\Atlas\rustdesk-*.txt
#   8. Pops up a WinForms dialog with copy buttons for ID + password.
#
# Usage (executed by install.bat or directly via iex):
#   iex (iwr -UseBasicParsing 'https://raw.githubusercontent.com/...').Content
#
# Requirements:
#   - Administrator privileges (the .bat wrapper handles elevation).
#   - Internet access (needs github.com + api.github.com).
# ============================================================

#region Configuration ------------------------------------------

# RustDesk "Server Config" string exported from Settings -> Network -> Export.
# This compact string contains: ID server host, relay host, API host (optional),
# and the public ed25519 key of Atlas's hbbs.
#
# To regenerate (one-time setup, when key/host changes):
#   1. Open RustDesk on Florin's master PC.
#   2. Settings -> Network -> Unlock.
#   3. Click "Export Server Config" -> a string is copied to your clipboard.
#   4. Paste it into the variable below (between the single quotes).
#   5. Commit + push.
$AtlasRustDeskConfig = '<<PASTE-EXPORTED-CONFIG-HERE>>'

# Static fallback (used only if the encoded config above is left as the placeholder):
# Direct host values. The public key is mandatory for encrypted self-host operation,
# so leaving it blank disables encryption (RustDesk will warn loudly).
$AtlasIdServer    = 'rustdesk.atlaspcsupport.com'
$AtlasRelayServer = 'rustdesk.atlaspcsupport.com'
$AtlasApiServer   = ''   # optional (Pro feature)
$AtlasPublicKey   = ''   # base64 ed25519 pubkey, e.g. 'XXX...UR24='

# Branding shown in the final popup.
$AtlasContactPhone   = '+51 9XX XXX XXX'
$AtlasContactWebsite = 'atlaspcsupport.com'
$AtlasOxfordBlue     = [System.Drawing.Color]::FromArgb(12, 35, 64)
$AtlasAccentGold     = [System.Drawing.Color]::FromArgb(212, 175, 55)

# Random password length (characters).
$AtlasPasswordLength = 16

#endregion

#region Helpers ------------------------------------------------

function Write-Step {
    param([string]$Message)
    Write-Host ""
    Write-Host "[Atlas] $Message" -ForegroundColor Cyan
}

function Write-Ok {
    param([string]$Message)
    Write-Host "        [OK] $Message" -ForegroundColor Green
}

function Write-Err {
    param([string]$Message)
    Write-Host "        [ERROR] $Message" -ForegroundColor Red
}

function Test-AtlasIsAdmin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $p  = New-Object Security.Principal.WindowsPrincipal($id)
    return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Get-AtlasArch {
    # Returns 'x86_64' or 'aarch64' to match RustDesk release filename suffixes.
    $arch = $env:PROCESSOR_ARCHITECTURE
    if ($arch -eq 'AMD64') { return 'x86_64' }
    if ($arch -eq 'ARM64') { return 'aarch64' }
    if ($arch -eq 'x86')   {
        # 32-bit Windows is no longer supported by RustDesk on releases past 1.2.x.
        # Fail loud rather than try to install a 64-bit binary.
        throw "32-bit Windows is no longer supported by RustDesk. Please use a 64-bit OS."
    }
    return 'x86_64'  # safe default for modern Windows
}

function Get-AtlasLatestRustDeskRelease {
    [CmdletBinding()]
    param([string]$Arch = 'x86_64')

    Write-Step "Consultando ultima version de RustDesk en GitHub..."
    try {
        $rel = Invoke-RestMethod -Uri 'https://api.github.com/repos/rustdesk/rustdesk/releases/latest' -UseBasicParsing -Headers @{ 'User-Agent' = 'AtlasPCSupport-Onboarding' }
    } catch {
        throw "No se pudo obtener la ultima version de RustDesk: $($_.Exception.Message)"
    }

    $version = $rel.tag_name
    if ([string]::IsNullOrWhiteSpace($version)) {
        throw "GitHub devolvio una respuesta vacia para la ultima version."
    }

    # Find an asset whose filename matches the architecture suffix and is an .exe.
    # Naming has varied across versions:
    #   rustdesk-1.2.6-x86_64.exe        (1.2.x)
    #   rustdesk-1.4.X-x86_64.exe        (1.4.x)
    #   rustdesk-1.X.X-aarch64.exe       (arm64)
    $pattern = "*-${Arch}.exe"
    $asset = $rel.assets | Where-Object { $_.name -like $pattern -and $_.name -notlike '*-portable-*' -and $_.name -notlike '*sciter*' } | Select-Object -First 1

    if (-not $asset) {
        throw "No se encontro un asset .exe para la arquitectura $Arch en la release $version."
    }

    Write-Ok "Encontrada release $version (asset: $($asset.name))"
    return [pscustomobject]@{
        Version     = $version
        DownloadUrl = $asset.browser_download_url
        FileName    = $asset.name
    }
}

function New-AtlasRandomPassword {
    [CmdletBinding()]
    param([int]$Length = 16)
    # Avoid ambiguous chars (0/O, 1/l/I) on purpose: this password gets read
    # aloud and copied by hand sometimes. Use unambiguous alphanumeric only.
    $chars = ([char[]]'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789').Clone()
    $rng   = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $bytes = New-Object 'byte[]' $Length
    $rng.GetBytes($bytes)
    -join ($bytes | ForEach-Object { $chars[$_ % $chars.Length] })
}

function Stop-AtlasIfPlaceholder {
    if ($AtlasRustDeskConfig -eq '<<PASTE-EXPORTED-CONFIG-HERE>>') {
        if ([string]::IsNullOrWhiteSpace($AtlasPublicKey)) {
            Write-Err 'Configuracion incompleta.'
            Write-Host ''
            Write-Host 'Atencion: este script todavia no contiene una "Server Config" exportada' -ForegroundColor Yellow
            Write-Host 'ni una clave publica de fallback. El tecnico de Atlas debe completar la' -ForegroundColor Yellow
            Write-Host 'variable $AtlasRustDeskConfig (o $AtlasPublicKey) antes de usar este' -ForegroundColor Yellow
            Write-Host 'instalador con clientes reales. Vea onboarding/README.md.' -ForegroundColor Yellow
            Write-Host ''
            throw 'Onboarding aborted: missing server config.'
        }
    }
}

#endregion

#region Main flow ----------------------------------------------

if (-not (Test-AtlasIsAdmin)) {
    throw 'Este script requiere privilegios de Administrador. Lanzelo desde install.bat o desde una consola elevada.'
}

Stop-AtlasIfPlaceholder

# ---- Step 1: Download latest RustDesk -----------------------
$arch    = Get-AtlasArch
$release = Get-AtlasLatestRustDeskRelease -Arch $arch

$tempDir = Join-Path $env:TEMP 'AtlasRustDeskOnboarding'
if (-not (Test-Path -LiteralPath $tempDir)) {
    New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
}
$installerPath = Join-Path $tempDir 'rustdesk-setup.exe'

Write-Step "Descargando $($release.FileName) ..."
try {
    Invoke-WebRequest -Uri $release.DownloadUrl -OutFile $installerPath -UseBasicParsing
    Write-Ok "Descargado a $installerPath"
} catch {
    throw "Fallo la descarga de RustDesk: $($_.Exception.Message)"
}

# ---- Step 2: Silent install + ensure service ----------------
Write-Step 'Instalando RustDesk (silent)...'
$proc = Start-Process -FilePath $installerPath -ArgumentList '--silent-install' -PassThru -Wait -WindowStyle Hidden
Write-Ok "Instalador finalizado con codigo $($proc.ExitCode)"

# Locate the installed binary. Default install path on x64 is "C:\Program Files\RustDesk".
$rustdeskDir = Join-Path $env:ProgramFiles 'RustDesk'
$rustdeskExe = Join-Path $rustdeskDir 'rustdesk.exe'

# Wait a few seconds for the installer to settle.
Start-Sleep -Seconds 5

if (-not (Test-Path -LiteralPath $rustdeskExe)) {
    throw "No se encontro $rustdeskExe tras la instalacion. La instalacion silenciosa puede haber fallado."
}

Write-Step 'Asegurando que el servicio esta instalado y corriendo...'
$svcName = 'RustDesk'
$svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue

if (-not $svc) {
    Write-Host '        Servicio no encontrado, instalando...' -ForegroundColor DarkGray
    Start-Process -FilePath $rustdeskExe -ArgumentList '--install-service' -Wait -WindowStyle Hidden
    Start-Sleep -Seconds 10
    $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
}

if (-not $svc) {
    throw "El servicio '$svcName' no se pudo instalar. Reintente manualmente."
}

# Ensure running.
$tries = 0
while ($svc.Status -ne 'Running' -and $tries -lt 6) {
    try { Start-Service -Name $svcName -ErrorAction Stop } catch {}
    Start-Sleep -Seconds 5
    $svc.Refresh()
    $tries++
}

if ($svc.Status -ne 'Running') {
    Write-Err "El servicio quedo en estado '$($svc.Status)'. Continuando, pero puede requerir reinicio."
} else {
    Write-Ok 'Servicio RustDesk corriendo.'
}

# ---- Step 3: Apply Atlas server config ----------------------
Write-Step 'Aplicando configuracion de servidor Atlas...'
if ($AtlasRustDeskConfig -and $AtlasRustDeskConfig -ne '<<PASTE-EXPORTED-CONFIG-HERE>>') {
    Start-Process -FilePath $rustdeskExe -ArgumentList @('--config', $AtlasRustDeskConfig) -Wait -WindowStyle Hidden
    Write-Ok 'Config aplicada via --config (Server Config exportada).'
} else {
    # Fallback: write the TOML file directly. This path is reached only if the
    # operator chose the "manual host + key" route and left $AtlasRustDeskConfig
    # as the placeholder.
    $tomlDir  = 'C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config'
    if (-not (Test-Path -LiteralPath $tomlDir)) {
        New-Item -ItemType Directory -Force -Path $tomlDir | Out-Null
    }
    $tomlPath = Join-Path $tomlDir 'RustDesk2.toml'
    $tomlBody = @"
rendezvous_server = '$AtlasIdServer'
nat_type = 0
serial = 0

[options]
custom-rendezvous-server = '$AtlasIdServer'
key = '$AtlasPublicKey'
relay-server = '$AtlasRelayServer'
api-server = '$AtlasApiServer'
"@
    Set-Content -LiteralPath $tomlPath -Value $tomlBody -Encoding UTF8
    Write-Ok "Config aplicada manualmente (TOML escrito en $tomlPath)."

    # Restart service so it picks up the new TOML.
    Restart-Service -Name $svcName -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 5
}

# ---- Step 4: Generate + set unique password -----------------
Write-Step 'Generando contrasena permanente unica para esta PC...'
$pwd = New-AtlasRandomPassword -Length $AtlasPasswordLength
Start-Process -FilePath $rustdeskExe -ArgumentList @('--password', $pwd) -Wait -WindowStyle Hidden
Write-Ok 'Contrasena fijada.'

# ---- Step 5: Read assigned ID -------------------------------
Write-Step 'Leyendo ID asignado por el servidor...'
$rdId = ''
$idTries = 0
while ([string]::IsNullOrWhiteSpace($rdId) -and $idTries -lt 6) {
    Start-Sleep -Seconds 4
    try {
        $rdId = (& $rustdeskExe --get-id 2>$null | Out-String).Trim()
    } catch {}
    $idTries++
}

if ([string]::IsNullOrWhiteSpace($rdId)) {
    Write-Err 'No se pudo leer el ID. Lo veras en la GUI de RustDesk al abrirla.'
    $rdId = '(no detectado - abrir RustDesk para verlo)'
} else {
    Write-Ok "ID detectado: $rdId"
}

# ---- Step 6: Persist recovery file --------------------------
$recDir  = Join-Path $env:ProgramData 'Atlas'
if (-not (Test-Path -LiteralPath $recDir)) { New-Item -ItemType Directory -Force -Path $recDir | Out-Null }
$stamp   = Get-Date -Format 'yyyyMMdd-HHmmss'
$recFile = Join-Path $recDir "rustdesk-onboarding-$stamp.txt"
@"
Atlas PC Support - RustDesk onboarding
Fecha: $(Get-Date)
Equipo: $env:COMPUTERNAME
Usuario: $env:USERNAME

ID:        $rdId
Password:  $pwd

ID Server:    $AtlasIdServer
Relay Server: $AtlasRelayServer

Guarde estos datos en Vaultwarden + RustDesk API Admin.
"@ | Set-Content -LiteralPath $recFile -Encoding UTF8
Write-Ok "Archivo de recuperacion: $recFile"

# ---- Step 7: Pop up a WinForms dialog with copy buttons -----
Write-Step 'Mostrando ventana con credenciales...'

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text          = 'Atlas PC Support - Acceso Remoto Instalado'
$form.Size          = New-Object System.Drawing.Size(540, 380)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox   = $false
$form.MinimizeBox   = $false
$form.TopMost       = $true
$form.BackColor     = $AtlasOxfordBlue
$form.ForeColor     = [System.Drawing.Color]::White

$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text     = 'RustDesk listo'
$lblTitle.Font     = New-Object System.Drawing.Font('Segoe UI', 20, [System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = [System.Drawing.Color]::White
$lblTitle.AutoSize = $true
$lblTitle.Location = New-Object System.Drawing.Point(24, 18)
$form.Controls.Add($lblTitle)

$lblSubtitle = New-Object System.Windows.Forms.Label
$lblSubtitle.Text     = 'Tu PC ya esta conectada al servidor Atlas. Comparte estos datos con tu tecnico:'
$lblSubtitle.Font     = New-Object System.Drawing.Font('Segoe UI', 9)
$lblSubtitle.ForeColor = [System.Drawing.Color]::LightGray
$lblSubtitle.AutoSize = $false
$lblSubtitle.Size     = New-Object System.Drawing.Size(490, 36)
$lblSubtitle.Location = New-Object System.Drawing.Point(24, 60)
$form.Controls.Add($lblSubtitle)

# ID row
$lblIdCap = New-Object System.Windows.Forms.Label
$lblIdCap.Text = 'ID:'
$lblIdCap.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$lblIdCap.AutoSize = $true
$lblIdCap.Location = New-Object System.Drawing.Point(24, 110)
$lblIdCap.ForeColor = $AtlasAccentGold
$form.Controls.Add($lblIdCap)

$txtId = New-Object System.Windows.Forms.TextBox
$txtId.Text = $rdId
$txtId.ReadOnly = $true
$txtId.Font = New-Object System.Drawing.Font('Consolas', 14, [System.Drawing.FontStyle]::Bold)
$txtId.BackColor = [System.Drawing.Color]::FromArgb(28, 50, 80)
$txtId.ForeColor = [System.Drawing.Color]::White
$txtId.BorderStyle = 'FixedSingle'
$txtId.Location = New-Object System.Drawing.Point(70, 105)
$txtId.Size = New-Object System.Drawing.Size(280, 32)
$form.Controls.Add($txtId)

$btnCopyId = New-Object System.Windows.Forms.Button
$btnCopyId.Text = 'Copiar'
$btnCopyId.Size = New-Object System.Drawing.Size(110, 30)
$btnCopyId.Location = New-Object System.Drawing.Point(360, 105)
$btnCopyId.BackColor = $AtlasAccentGold
$btnCopyId.ForeColor = $AtlasOxfordBlue
$btnCopyId.FlatStyle = 'Flat'
$btnCopyId.Add_Click({ [System.Windows.Forms.Clipboard]::SetText($txtId.Text); $btnCopyId.Text = 'Copiado!' })
$form.Controls.Add($btnCopyId)

# Password row
$lblPwCap = New-Object System.Windows.Forms.Label
$lblPwCap.Text = 'Password:'
$lblPwCap.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$lblPwCap.AutoSize = $true
$lblPwCap.Location = New-Object System.Drawing.Point(24, 160)
$lblPwCap.ForeColor = $AtlasAccentGold
$form.Controls.Add($lblPwCap)

$txtPw = New-Object System.Windows.Forms.TextBox
$txtPw.Text = $pwd
$txtPw.ReadOnly = $true
$txtPw.Font = New-Object System.Drawing.Font('Consolas', 14, [System.Drawing.FontStyle]::Bold)
$txtPw.BackColor = [System.Drawing.Color]::FromArgb(28, 50, 80)
$txtPw.ForeColor = [System.Drawing.Color]::White
$txtPw.BorderStyle = 'FixedSingle'
$txtPw.Location = New-Object System.Drawing.Point(125, 155)
$txtPw.Size = New-Object System.Drawing.Size(225, 32)
$form.Controls.Add($txtPw)

$btnCopyPw = New-Object System.Windows.Forms.Button
$btnCopyPw.Text = 'Copiar'
$btnCopyPw.Size = New-Object System.Drawing.Size(110, 30)
$btnCopyPw.Location = New-Object System.Drawing.Point(360, 155)
$btnCopyPw.BackColor = $AtlasAccentGold
$btnCopyPw.ForeColor = $AtlasOxfordBlue
$btnCopyPw.FlatStyle = 'Flat'
$btnCopyPw.Add_Click({ [System.Windows.Forms.Clipboard]::SetText($txtPw.Text); $btnCopyPw.Text = 'Copiado!' })
$form.Controls.Add($btnCopyPw)

# Footer / contact
$lblFooter = New-Object System.Windows.Forms.Label
$lblFooter.Text = "Servidor: $AtlasIdServer    |    $AtlasContactWebsite    |    $AtlasContactPhone"
$lblFooter.Font = New-Object System.Drawing.Font('Segoe UI', 9)
$lblFooter.ForeColor = [System.Drawing.Color]::LightGray
$lblFooter.AutoSize = $false
$lblFooter.TextAlign = 'MiddleCenter'
$lblFooter.Size = New-Object System.Drawing.Size(490, 24)
$lblFooter.Location = New-Object System.Drawing.Point(24, 215)
$form.Controls.Add($lblFooter)

$lblRecovery = New-Object System.Windows.Forms.Label
$lblRecovery.Text = "Copia de respaldo en: $recFile"
$lblRecovery.Font = New-Object System.Drawing.Font('Segoe UI', 8)
$lblRecovery.ForeColor = [System.Drawing.Color]::LightGray
$lblRecovery.AutoSize = $false
$lblRecovery.TextAlign = 'MiddleCenter'
$lblRecovery.Size = New-Object System.Drawing.Size(490, 20)
$lblRecovery.Location = New-Object System.Drawing.Point(24, 245)
$form.Controls.Add($lblRecovery)

$btnClose = New-Object System.Windows.Forms.Button
$btnClose.Text = 'Cerrar'
$btnClose.Size = New-Object System.Drawing.Size(120, 36)
$btnClose.Location = New-Object System.Drawing.Point(204, 290)
$btnClose.BackColor = [System.Drawing.Color]::FromArgb(60, 90, 130)
$btnClose.ForeColor = [System.Drawing.Color]::White
$btnClose.FlatStyle = 'Flat'
$btnClose.Add_Click({ $form.Close() })
$form.Controls.Add($btnClose)

[void] $form.ShowDialog()

#endregion

Write-Step 'Onboarding completado.'
Write-Host ''
Write-Host "  ID:       $rdId"        -ForegroundColor Yellow
Write-Host "  Password: $pwd"          -ForegroundColor Yellow
Write-Host ''
Write-Host "Recuerda copiar estos datos a Vaultwarden + RustDesk API Admin."
Write-Host "Backup local: $recFile"
