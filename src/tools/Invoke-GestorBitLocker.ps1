# ============================================================
# Invoke-GestorBitLocker
# Migrado de: GestorBitLocker.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-GestorBitLocker {
    [CmdletBinding()]
    param(
        [ValidateSet("Extract","Status","")]
        [string]$Action = "",
        [string]$Output = "",
        [string]$MountPoint = ""
    )
# =======================================================
# Gestor de BitLocker v3 - Atlas PC Support
# TPM + Progreso + Backup USB + QR + Health Check + Log
# AD/Azure backup + CLI mode + Alerta discos sin proteger
# =======================================================

# (auto-elevación gestionada por Atlas Launcher)


[console]::BackgroundColor = "Black"
[console]::ForegroundColor = "Gray"
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - Gestor BitLocker v3"
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(105, 48) } catch {}

# Log file
$logFile = Join-Path $PSScriptRoot "ATLAS_bitlocker.log"

# ==================== FUNCIONES BASE ====================

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $user = "$env:USERDOMAIN\$env:USERNAME"
    $pc = $env:COMPUTERNAME
    $entry = "${timestamp} | ${Level} | ${pc} | ${user} | ${Message}"
    try { $entry | Out-File -FilePath $script:logFile -Append -Encoding UTF8 } catch {}
}

function Escribir-Centrado {
    param([string]$Texto, [ConsoleColor]$Color = "Gray")
    $AnchoVentana = $Host.UI.RawUI.WindowSize.Width
    if ($Texto.Length -lt $AnchoVentana) {
        $Espacios = [Math]::Floor(($AnchoVentana - $Texto.Length) / 2)
        Write-Host (" " * $Espacios + $Texto) -ForegroundColor $Color
    } else {
        Write-Host $Texto -ForegroundColor $Color
    }
}

function Show-DiskTable {
    param([switch]$OnlyEncrypted, [switch]$Silent)
    
    $volumes = Get-BitLockerVolume -ErrorAction SilentlyContinue
    if (-not $volumes) {
        if (-not $Silent) { Write-Host "    No se pudo acceder a BitLocker." -ForegroundColor Red }
        return $null
    }
    
    if ($OnlyEncrypted) {
        $volumes = $volumes | Where-Object { $_.VolumeStatus -ne 'FullyDecrypted' }
        if (-not $volumes) {
            if (-not $Silent) { Write-Host "    No hay discos con BitLocker activo." -ForegroundColor Yellow }
            return $null
        }
    }
    
    if (-not $Silent) {
        Write-Host ""
        Write-Host "    DISCO   ESTADO                  ENCRIPTADO   TAMANO    METODO" -ForegroundColor DarkGray
        Write-Host "    -----   ------                  ----------   ------    ------" -ForegroundColor DarkGray
        
        foreach ($v in $volumes) {
            $mount = $v.MountPoint
            $status = $v.VolumeStatus.ToString()
            $pct = "$($v.EncryptionPercentage)%"
            $capGB = if ($v.CapacityGB) { "{0:N1} GB" -f $v.CapacityGB } else { "N/A" }
            $method = if ($v.EncryptionMethod) { $v.EncryptionMethod.ToString() } else { "-" }
            
            $statusColor = switch ($status) {
                "FullyEncrypted" { "Green" }
                "FullyDecrypted" { "Gray" }
                "EncryptionInProgress" { "Yellow" }
                "DecryptionInProgress" { "Yellow" }
                default { "White" }
            }
            $statusLabel = switch ($status) {
                "FullyEncrypted" { "ENCRIPTADO" }
                "FullyDecrypted" { "LIBRE" }
                "EncryptionInProgress" { "ENCRIPTANDO..." }
                "DecryptionInProgress" { "DESENCRIPTANDO..." }
                default { $status }
            }
            $icon = switch ($status) {
                "FullyEncrypted" { "[X]" }
                "FullyDecrypted" { "[ ]" }
                "EncryptionInProgress" { "[~]" }
                "DecryptionInProgress" { "[~]" }
                default { "[?]" }
            }
            
            Write-Host "    ${icon} ${mount}" -NoNewline -ForegroundColor $statusColor
            Write-Host ("   " + $statusLabel.PadRight(24)) -NoNewline -ForegroundColor $statusColor
            Write-Host ($pct.PadRight(13)) -NoNewline -ForegroundColor White
            Write-Host ($capGB.PadRight(10)) -NoNewline -ForegroundColor Gray
            Write-Host $method -ForegroundColor DarkGray
        }
        Write-Host ""
    }
    return $volumes
}

function Validate-DriveLetter {
    param([string]$Input, [array]$ValidVolumes)
    if ([string]::IsNullOrWhiteSpace($Input)) { return $null }
    $clean = $Input.Trim().ToUpper().Replace(":", "")
    if ($clean.Length -ne 1 -or $clean -notmatch "^[A-Z]$") {
        Write-Host "    Letra invalida. Usa una sola letra (ej: C, D, E)." -ForegroundColor Red
        return $null
    }
    $disco = "${clean}:"
    $found = $ValidVolumes | Where-Object { $_.MountPoint -eq $disco }
    if (-not $found) {
        Write-Host "    El disco ${disco} no existe." -ForegroundColor Red
        return $null
    }
    return @{ Letter = $disco; Volume = $found }
}

function Get-TPMStatus {
    $result = @{ HasTPM = $false; IsReady = $false; Version = "N/A"; Summary = "" }
    try {
        $tpm = Get-Tpm -ErrorAction Stop
        $result.HasTPM = $tpm.TpmPresent
        $result.IsReady = $tpm.TpmReady
        try {
            $tpmWMI = Get-CimInstance -Namespace "root\cimv2\Security\MicrosoftTpm" -ClassName Win32_Tpm -ErrorAction Stop
            if ($tpmWMI.SpecVersion) { $result.Version = ($tpmWMI.SpecVersion -split ',')[0].Trim() }
        } catch { }
        if ($result.HasTPM -and $result.IsReady) { $result.Summary = "TPM $($result.Version) presente y listo" }
        elseif ($result.HasTPM) { $result.Summary = "TPM presente pero NO listo" }
        else { $result.Summary = "Sin TPM detectado" }
    } catch { $result.Summary = "No se pudo consultar TPM" }
    return $result
}

function Show-EncryptionProgress {
    param([string]$MountPoint, [string]$Mode = "Encrypting")
    $label = if ($Mode -eq "Encrypting") { "ENCRIPTANDO" } else { "DESENCRIPTANDO" }
    $color = if ($Mode -eq "Encrypting") { "Cyan" } else { "Magenta" }
    Write-Host ""
    Escribir-Centrado "Monitoreando (CTRL+C para dejar en segundo plano)..." "DarkGray"
    Write-Host ""
    $lastPct = -1
    try {
        while ($true) {
            $vol = Get-BitLockerVolume -MountPoint $MountPoint -ErrorAction SilentlyContinue
            if (-not $vol) { break }
            $pct = $vol.EncryptionPercentage; $status = $vol.VolumeStatus.ToString()
            if ($pct -ne $lastPct) {
                $barWidth = 40; $filled = [math]::Floor($pct / 100 * $barWidth); $empty = $barWidth - $filled
                $bar = ("#" * $filled) + ("-" * $empty)
                Write-Host "`r    ${label} ${MountPoint}: [${bar}] ${pct}%   " -NoNewline -ForegroundColor $color
                $lastPct = $pct
            }
            if ($status -eq "FullyEncrypted" -or $status -eq "FullyDecrypted") {
                Write-Host ""; Write-Host ""
                $doneMsg = if ($Mode -eq "Encrypting") { "Encriptacion completada." } else { "Desencriptacion completada." }
                Escribir-Centrado $doneMsg "Green"
                Write-Log "${doneMsg} Disco: ${MountPoint}"
                break
            }
            Start-Sleep -Seconds 3
        }
    } catch { Write-Host ""; Write-Host ""; Escribir-Centrado "Monitoreo detenido. Continua en segundo plano." "Yellow" }
}

# ==================== HEALTH CHECK PRE-ENCRIPTACION ====================

function Test-PreEncryptionHealth {
    param([string]$MountPoint)
    
    $issues = @(); $warnings = @(); $canProceed = $true
    $driveLetter = $MountPoint.TrimEnd(':')
    
    Write-Host ""
    Escribir-Centrado "HEALTH CHECK PRE-ENCRIPTACION" "Yellow"
    Write-Host ""
    
    # 1. BATERIA (critico en laptops)
    Write-Host "    [1/5] Bateria..." -NoNewline -ForegroundColor DarkGray
    $battery = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue
    if ($battery) {
        $charge = $battery.EstimatedChargeRemaining
        $plugged = $battery.BatteryStatus -eq 2
        if ($charge -lt 30 -and -not $plugged) {
            $issues += "BATERIA CRITICA: ${charge}% sin cargador. Conecta el cargador antes de encriptar."
            $canProceed = $false
            Write-Host " FALLO (${charge}%)" -ForegroundColor Red
        } elseif ($charge -lt 50 -and -not $plugged) {
            $warnings += "Bateria al ${charge}%. Se recomienda conectar el cargador."
            Write-Host " AVISO (${charge}%)" -ForegroundColor Yellow
        } elseif ($plugged) {
            Write-Host " OK (${charge}%, cargador conectado)" -ForegroundColor Green
        } else {
            Write-Host " OK (${charge}%)" -ForegroundColor Green
        }
    } else {
        Write-Host " N/A (escritorio)" -ForegroundColor Gray
    }
    
    # 2. ESPACIO EN DISCO
    Write-Host "    [2/5] Espacio en disco..." -NoNewline -ForegroundColor DarkGray
    $logDisk = Get-CimInstance Win32_LogicalDisk -ErrorAction SilentlyContinue | Where-Object { $_.DeviceID -eq $MountPoint }
    if ($logDisk) {
        $freeGB = [math]::Round($logDisk.FreeSpace / 1GB, 1)
        $totalGB = [math]::Round($logDisk.Size / 1GB, 1)
        $usedPct = [math]::Round((($logDisk.Size - $logDisk.FreeSpace) / $logDisk.Size) * 100, 0)
        if ($freeGB -lt 1) {
            $issues += "DISCO CASI LLENO: Solo ${freeGB}GB libre. BitLocker necesita espacio para metadatos."
            $canProceed = $false
            Write-Host " FALLO (${freeGB}GB libre)" -ForegroundColor Red
        } elseif ($usedPct -gt 95) {
            $warnings += "Disco al ${usedPct}% de capacidad. Recomendado liberar espacio."
            Write-Host " AVISO (${usedPct}%)" -ForegroundColor Yellow
        } else {
            Write-Host " OK (${freeGB}GB libre de ${totalGB}GB)" -ForegroundColor Green
        }
    } else {
        Write-Host " N/A" -ForegroundColor Gray
    }
    
    # 3. ESTADO SMART DEL DISCO
    Write-Host "    [3/5] Salud del disco (SMART)..." -NoNewline -ForegroundColor DarkGray
    try {
        $partition = Get-Partition -DriveLetter $driveLetter -ErrorAction Stop
        $physDisk = Get-PhysicalDisk -ErrorAction SilentlyContinue | Where-Object { $_.DeviceId -eq $partition.DiskNumber.ToString() }
        if (-not $physDisk) {
            $physDisk = Get-PhysicalDisk -ErrorAction SilentlyContinue | Select-Object -First 1
        }
        if ($physDisk) {
            $health = $physDisk.HealthStatus.ToString()
            if ($health -ne "Healthy") {
                $issues += "DISCO CON PROBLEMAS: Estado SMART = ${health}. Encriptar un disco danado puede causar perdida total."
                $canProceed = $false
                Write-Host " FALLO (${health})" -ForegroundColor Red
            } else {
                $opStatus = if ($physDisk.OperationalStatus) { $physDisk.OperationalStatus.ToString() } else { "OK" }
                Write-Host " OK (${health}, ${opStatus})" -ForegroundColor Green
            }
        } else {
            Write-Host " No verificable" -ForegroundColor Yellow
        }
    } catch {
        Write-Host " No verificable" -ForegroundColor Yellow
    }
    
    # 4. SISTEMA DE ARCHIVOS
    Write-Host "    [4/5] Sistema de archivos..." -NoNewline -ForegroundColor DarkGray
    try {
        $vol = Get-Volume -DriveLetter $driveLetter -ErrorAction Stop
        $fs = if ($vol.FileSystem) { $vol.FileSystem } else { "Desconocido" }
        if ($fs -ne "NTFS" -and $fs -ne "ReFS") {
            $issues += "SISTEMA DE ARCHIVOS INCOMPATIBLE: ${fs}. BitLocker requiere NTFS o ReFS."
            $canProceed = $false
            Write-Host " FALLO (${fs})" -ForegroundColor Red
        } else {
            Write-Host " OK (${fs})" -ForegroundColor Green
        }
    } catch {
        Write-Host " No verificable" -ForegroundColor Yellow
    }
    
    # 5. PROCESOS CRITICOS
    Write-Host "    [5/5] Procesos criticos..." -NoNewline -ForegroundColor DarkGray
    $chkdsk = Get-Process -Name "chkdsk" -ErrorAction SilentlyContinue
    $defrag = Get-Process -Name "defrag" -ErrorAction SilentlyContinue
    if ($chkdsk -or $defrag) {
        $procName = if ($chkdsk) { "chkdsk" } else { "defrag" }
        $warnings += "${procName} en ejecucion. Espera a que termine antes de encriptar."
        Write-Host " AVISO (${procName} activo)" -ForegroundColor Yellow
    } else {
        Write-Host " OK" -ForegroundColor Green
    }
    
    # RESUMEN
    Write-Host ""
    if ($issues.Count -gt 0) {
        Escribir-Centrado "PROBLEMAS CRITICOS (no se recomienda continuar):" "Red"
        foreach ($issue in $issues) { Write-Host "    [X] ${issue}" -ForegroundColor Red }
    }
    if ($warnings.Count -gt 0) {
        Write-Host ""
        Escribir-Centrado "AVISOS:" "Yellow"
        foreach ($warn in $warnings) { Write-Host "    [!] ${warn}" -ForegroundColor Yellow }
    }
    if ($issues.Count -eq 0 -and $warnings.Count -eq 0) {
        Escribir-Centrado "TODOS LOS CHEQUEOS PASARON" "Green"
    }
    
    Write-Log "HealthCheck ${MountPoint}: Issues=${issues.Count}, Warnings=${warnings.Count}, CanProceed=${canProceed}"
    
    return @{ CanProceed = $canProceed; Issues = $issues; Warnings = $warnings }
}

# ==================== ALERTA DISCOS SIN PROTEGER ====================

function Show-UnprotectedAlert {
    $allVols = Get-BitLockerVolume -ErrorAction SilentlyContinue
    if (-not $allVols) { return }
    
    $unprotected = @()
    foreach ($v in $allVols) {
        # Solo alertar discos del sistema y datos (no removibles)
        $driveLetter = $v.MountPoint.TrimEnd(':')
        try {
            $volInfo = Get-Volume -DriveLetter $driveLetter -ErrorAction SilentlyContinue
            if ($volInfo -and $volInfo.DriveType -eq 'Fixed' -and $v.VolumeStatus -eq 'FullyDecrypted') {
                $capGB = if ($v.CapacityGB) { "{0:N0}" -f $v.CapacityGB } else { "?" }
                $unprotected += "${driveLetter}: (${capGB}GB)"
            }
        } catch { }
    }
    
    if ($unprotected.Count -gt 0) {
        Write-Host ""
        $alertLine = "ALERTA: $($unprotected.Count) disco(s) fijo(s) SIN PROTECCION: $($unprotected -join ', ')"
        Escribir-Centrado $alertLine "Red"
    }
}

# ==================== GENERAR QR ====================

function Generate-QRCode {
    param([string]$Data, [string]$OutputPath, [string]$Label = "")
    
    # Generar QR como HTML con tabla (funciona sin dependencias externas)
    # Usa una representación simple que se puede imprimir
    
    $qrSize = 21  # QR Version 1
    
    # Método alternativo: generar imagen BMP usando .NET
    try {
        Add-Type -AssemblyName System.Drawing -ErrorAction Stop
        
        $cellSize = 10
        $margin = 40
        $textHeight = if ($Label) { 60 } else { 0 }
        
        # Generar patrón QR simplificado (encode como texto legible en imagen)
        $lines = @()
        $lines += "ATLAS PC SUPPORT"
        $lines += "BITLOCKER RECOVERY KEY"
        $lines += ""
        if ($Label) { $lines += $Label; $lines += "" }
        
        # Dividir la clave en grupos legibles
        $lines += "CLAVE:"
        if ($Data.Length -gt 20) {
            $chunks = [regex]::Matches($Data, '.{1,12}') | ForEach-Object { $_.Value }
            foreach ($chunk in $chunks) { $lines += "  $chunk" }
        } else {
            $lines += "  $Data"
        }
        $lines += ""
        $lines += "Fecha: $(Get-Date -Format 'dd/MM/yyyy')"
        $lines += "PC: $env:COMPUTERNAME"
        
        # Crear imagen
        $imgWidth = 500
        $lineHeight = 22
        $imgHeight = ($lines.Count * $lineHeight) + 80
        
        $bmp = New-Object System.Drawing.Bitmap($imgWidth, $imgHeight)
        $gfx = [System.Drawing.Graphics]::FromImage($bmp)
        $gfx.Clear([System.Drawing.Color]::White)
        
        # Borde
        $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::Black, 2)
        $gfx.DrawRectangle($pen, 5, 5, $imgWidth - 10, $imgHeight - 10)
        
        # Texto
        $fontTitle = New-Object System.Drawing.Font("Consolas", 14, [System.Drawing.FontStyle]::Bold)
        $fontNormal = New-Object System.Drawing.Font("Consolas", 12)
        $fontKey = New-Object System.Drawing.Font("Consolas", 13, [System.Drawing.FontStyle]::Bold)
        $brush = [System.Drawing.Brushes]::Black
        $brushRed = [System.Drawing.Brushes]::DarkRed
        
        $y = 20
        foreach ($line in $lines) {
            $font = $fontNormal
            $b = $brush
            if ($line -match "^ATLAS|^BITLOCKER") { $font = $fontTitle }
            if ($line -match "^\s{2}\d" -or $line -match "^\s{2}[A-F0-9]") { $font = $fontKey; $b = $brushRed }
            $gfx.DrawString($line, $font, $b, 20, $y)
            $y += $lineHeight
        }
        
        $gfx.Dispose()
        $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $bmp.Dispose()
        
        return $true
    } catch {
        # Fallback: guardar como texto formateado para imprimir
        $txtPath = $OutputPath -replace '\.png$', '.txt'
        $border = "+" + ("-" * 48) + "+"
        $content = @()
        $content += $border
        $content += "|  ATLAS PC SUPPORT - BITLOCKER RECOVERY KEY    |"
        $content += $border
        if ($Label) { $content += "|  ${Label}".PadRight(49) + "|" }
        $content += "|  CLAVE:".PadRight(49) + "|"
        $content += "|  ${Data}".PadRight(49) + "|"
        $content += "|  PC: $env:COMPUTERNAME | $(Get-Date -Format 'dd/MM/yyyy')".PadRight(49) + "|"
        $content += $border
        $content += "  Recortar y pegar en la carcasa del equipo."
        
        $content -join "`r`n" | Out-File -FilePath $txtPath -Encoding UTF8
        return $txtPath
    }
}

# ==================== BACKUP A AD / AZURE ====================

function Backup-KeyToAD {
    param([string]$MountPoint)
    
    $vol = Get-BitLockerVolume -MountPoint $MountPoint -ErrorAction SilentlyContinue
    if (-not $vol) { return $false }
    
    $recoveryKeys = $vol.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
    if (-not $recoveryKeys) {
        Write-Host "    No hay claves de recuperacion para respaldar." -ForegroundColor Yellow
        return $false
    }
    
    $success = $false
    
    foreach ($key in $recoveryKeys) {
        $keyId = $key.KeyProtectorId
        
        # Intentar AD On-Premise
        Write-Host "    Intentando backup a Active Directory..." -ForegroundColor DarkGray
        try {
            Backup-BitLockerKeyProtector -MountPoint $MountPoint -KeyProtectorId $keyId -ErrorAction Stop
            Write-Host "    [OK] Clave respaldada en Active Directory." -ForegroundColor Green
            Write-Log "AD Backup OK: ${MountPoint} KeyID: ${keyId}"
            $success = $true
        } catch {
            $adError = $_.Exception.Message
            if ($adError -match "not joined|domain|directory") {
                Write-Host "    [--] Equipo no esta en dominio AD." -ForegroundColor DarkGray
            } else {
                Write-Host "    [--] AD no disponible: $adError" -ForegroundColor DarkGray
            }
        }
        
        # Intentar Azure AD
        Write-Host "    Intentando backup a Azure AD / Entra ID..." -ForegroundColor DarkGray
        try {
            $dsregStatus = dsregcmd /status 2>&1
            $isAzureJoined = ($dsregStatus | Select-String "AzureAdJoined\s*:\s*YES" -Quiet)
            
            if ($isAzureJoined) {
                BackupToAAD-BitLockerKeyProtector -MountPoint $MountPoint -KeyProtectorId $keyId -ErrorAction Stop
                Write-Host "    [OK] Clave respaldada en Azure AD / Entra ID." -ForegroundColor Green
                Write-Log "Azure AD Backup OK: ${MountPoint} KeyID: ${keyId}"
                $success = $true
            } else {
                Write-Host "    [--] Equipo no esta unido a Azure AD." -ForegroundColor DarkGray
            }
        } catch {
            Write-Host "    [--] Azure AD no disponible." -ForegroundColor DarkGray
        }
    }
    
    return $success
}

# ==================== MODO CLI ====================

if ($Action -ne "") {
    switch ($Action) {
        "Extract" {
            $VolumenesBL = Get-BitLockerVolume -ErrorAction SilentlyContinue | Where-Object { $_.VolumeStatus -ne 'FullyDecrypted' }
            if (-not $VolumenesBL) { Write-Host "Sin discos protegidos."; exit 1 }
            
            $outputPath = if ($Output) { $Output } else { Join-Path ([Environment]::GetFolderPath("Desktop")) "BL_$env:COMPUTERNAME_$(Get-Date -Format 'yyyyMMdd_HHmm').txt" }
            
            $content = "ATLAS PC SUPPORT - BITLOCKER KEYS`r`nPC: $env:COMPUTERNAME`r`nFecha: $(Get-Date)`r`n---`r`n"
            foreach ($Vol in $VolumenesBL) {
                $keys = $Vol.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
                foreach ($k in $keys) {
                    $content += "$($Vol.MountPoint) -> $($k.RecoveryPassword)`r`n"
                    Write-Host "$($Vol.MountPoint) -> $($k.RecoveryPassword)"
                }
            }
            $content | Out-File -FilePath $outputPath -Encoding UTF8
            Write-Host "Guardado en: ${outputPath}"
            Write-Log "CLI Extract: ${outputPath}"
            return
        }
        "Status" {
            $vols = Get-BitLockerVolume -ErrorAction SilentlyContinue
            foreach ($v in $vols) {
                $status = $v.VolumeStatus.ToString()
                $pct = $v.EncryptionPercentage
                Write-Host "$($v.MountPoint) | ${status} | ${pct}%"
            }
            return
        }
    }
}

# ==================== MENU PRINCIPAL ====================

Clear-Host

while ($true) {
    Clear-Host
    Write-Host "`n"
    Escribir-Centrado "===================================================" "DarkGray"
    Escribir-Centrado "|                                                 |" "DarkYellow"
    Escribir-Centrado "|               ATLAS PC SUPPORT                  |" "DarkYellow"
    Escribir-Centrado "|             GESTOR BITLOCKER v3                  |" "DarkYellow"
    Escribir-Centrado "|                                                 |" "DarkYellow"
    Escribir-Centrado "===================================================" "DarkGray"
    
    # TPM status
    Write-Host ""
    $tpmInfo = Get-TPMStatus
    $tpmColor = if ($tpmInfo.HasTPM -and $tpmInfo.IsReady) { "Green" } elseif ($tpmInfo.HasTPM) { "Yellow" } else { "Red" }
    Escribir-Centrado "TPM: $($tpmInfo.Summary)" $tpmColor
    
    # Discos protegidos
    $blVolumes = Get-BitLockerVolume -ErrorAction SilentlyContinue | Where-Object { $_.VolumeStatus -ne 'FullyDecrypted' }
    $blCount = if ($blVolumes) { @($blVolumes).Count } else { 0 }
    Escribir-Centrado "Discos protegidos: ${blCount}" $(if ($blCount -gt 0) { "Cyan" } else { "DarkGray" })
    
    # ALERTA DISCOS SIN PROTEGER
    Show-UnprotectedAlert
    
    Write-Host ""
    Escribir-Centrado "[ 1 ] Escanear y Guardar Claves" "White"
    Escribir-Centrado "[ 2 ] Activar BitLocker" "White"
    Escribir-Centrado "[ 3 ] Desactivar BitLocker" "White"
    Escribir-Centrado "[ 4 ] Ver Estado Completo" "White"
    Escribir-Centrado "[ 5 ] Ver Historial de Operaciones" "White"
    Escribir-Centrado "[ S ] Salir" "DarkGray"
    Write-Host ""
    Escribir-Centrado "===================================================" "DarkGray"
    Write-Host ""
    
    $Opcion = Read-Host "  Opcion"

    switch ($Opcion.ToUpper()) {
        # =============================================
        # 1. EXTRAER CLAVES (+ USB + QR + AD + Clipboard)
        # =============================================
        "1" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== EXTRACCION DE CLAVES BITLOCKER ===" "DarkYellow"
            Write-Host ""
            
            $NombreEquipo = $env:COMPUTERNAME
            $UsuarioActual = $env:USERNAME
            $FechaHora = Get-Date -Format 'dd-MM-yyyy_HHmm'
            $NombreArchivo = "BL_${NombreEquipo}_${FechaHora}.txt"
            
            Write-Host "    Escaneando discos protegidos..." -ForegroundColor DarkGray
            $VolumenesBL = Get-BitLockerVolume -ErrorAction SilentlyContinue | Where-Object { $_.VolumeStatus -ne 'FullyDecrypted' }
            
            if (-not $VolumenesBL) {
                Escribir-Centrado "No se encontraron discos con BitLocker activo." "Red"
            } else {
                $Contenido = "===================================================`r`n"
                $Contenido += "      ATLAS PC SUPPORT - RESPALDO DE BITLOCKER`r`n"
                $Contenido += "===================================================`r`n"
                $Contenido += "Fecha               : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')`r`n"
                $Contenido += "Nombre del Equipo   : ${NombreEquipo}`r`n"
                $Contenido += "Usuario Activo      : ${UsuarioActual}`r`n"
                $Contenido += "---------------------------------------------------`r`n`r`n"
                
                $ClavesEncontradas = 0
                $clavesParaClipboard = @()
                $clavesParaQR = @()
                
                foreach ($Vol in $VolumenesBL) {
                    $Claves = $Vol.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
                    if ($Claves) {
                        foreach ($Clave in $Claves) {
                            $mount = $Vol.MountPoint
                            $key = $Clave.RecoveryPassword
                            $keyId = $Clave.KeyProtectorId
                            
                            $Contenido += "UNIDAD: ${mount}`r`n"
                            $Contenido += "ID:     ${keyId}`r`n"
                            $Contenido += "CLAVE:  ${key}`r`n`r`n"
                            
                            $clavesParaClipboard += "${mount} -> ${key}"
                            $clavesParaQR += @{ Mount = $mount; Key = $key; KeyId = $keyId }
                            
                            Write-Host "    [OK] ${mount} -> ${key}" -ForegroundColor Green
                            $ClavesEncontradas++
                        }
                    }
                }
                
                if ($ClavesEncontradas -eq 0) {
                    Escribir-Centrado "No se encontraron claves de recuperacion." "Red"
                } else {
                    $Contenido += "===================================================`r`n"
                    $Contenido += "TOTAL: ${ClavesEncontradas} clave(s)`r`n"
                    
                    Write-Host ""
                    Escribir-Centrado "${ClavesEncontradas} clave(s) encontrada(s)" "Green"
                    Write-Log "Extraccion: ${ClavesEncontradas} claves de ${NombreEquipo}"
                    
                    $rutasGuardadas = @()
                    
                    # Guardar en escritorio
                    $RutaEscritorio = [Environment]::GetFolderPath("Desktop")
                    $RutaCompleta = Join-Path $RutaEscritorio $NombreArchivo
                    try {
                        $Contenido | Out-File -FilePath $RutaCompleta -Encoding UTF8
                        Write-Host "    [OK] Escritorio: ${NombreArchivo}" -ForegroundColor Cyan
                        $rutasGuardadas += $RutaCompleta
                    } catch { Write-Host "    [ERROR] No se guardo en escritorio." -ForegroundColor Red }
                    
                    # USB
                    $usbs = Get-Volume -ErrorAction SilentlyContinue | Where-Object { $_.DriveType -eq 'Removable' -and $_.DriveLetter -and $_.Size -gt 0 }
                    if ($usbs) {
                        Write-Host ""
                        Write-Host "    USB detectado(s). Guardar copia? [S/N]" -ForegroundColor Yellow
                        $usbSel = Read-Host "    >"
                        if ($usbSel -eq "S" -or $usbSel -eq "s") {
                            foreach ($u in $usbs) {
                                try {
                                    $usbPath = Join-Path ($u.DriveLetter + ":\") $NombreArchivo
                                    $Contenido | Out-File -FilePath $usbPath -Encoding UTF8
                                    Write-Host "    [OK] USB $($u.DriveLetter): ${NombreArchivo}" -ForegroundColor Green
                                    $rutasGuardadas += $usbPath
                                } catch { Write-Host "    [ERROR] USB $($u.DriveLetter): $($_.Exception.Message)" -ForegroundColor Red }
                            }
                        }
                    }
                    
                    # QR / Imagen imprimible
                    Write-Host ""
                    Write-Host "    Generar imagen imprimible de las claves? [S/N]" -ForegroundColor Yellow
                    $qrSel = Read-Host "    >"
                    if ($qrSel -eq "S" -or $qrSel -eq "s") {
                        foreach ($kInfo in $clavesParaQR) {
                            $qrFileName = "BL_KEY_${NombreEquipo}_$($kInfo.Mount.TrimEnd(':'))_${FechaHora}.png"
                            $qrPath = Join-Path $RutaEscritorio $qrFileName
                            $label = "Disco: $($kInfo.Mount) | PC: ${NombreEquipo}"
                            $qrResult = Generate-QRCode -Data $kInfo.Key -OutputPath $qrPath -Label $label
                            if ($qrResult -eq $true) {
                                Write-Host "    [OK] Imagen: ${qrFileName}" -ForegroundColor Green
                                $rutasGuardadas += $qrPath
                            } elseif ($qrResult) {
                                Write-Host "    [OK] Texto imprimible: $(Split-Path $qrResult -Leaf)" -ForegroundColor Green
                                $rutasGuardadas += $qrResult
                            } else {
                                Write-Host "    [ERROR] No se genero imagen." -ForegroundColor Red
                            }
                        }
                        Write-Host ""
                        Escribir-Centrado "Imprime la imagen y pegala en la carcasa del equipo." "Cyan"
                    }
                    
                    # AD / Azure AD backup
                    Write-Host ""
                    Write-Host "    Intentar backup a Active Directory / Azure AD? [S/N]" -ForegroundColor Yellow
                    $adSel = Read-Host "    >"
                    if ($adSel -eq "S" -or $adSel -eq "s") {
                        foreach ($Vol in $VolumenesBL) {
                            $adOk = Backup-KeyToAD -MountPoint $Vol.MountPoint
                        }
                    }
                    
                    # Clipboard
                    Write-Host ""
                    Write-Host "    Copiar claves al portapapeles? [S/N]" -ForegroundColor DarkGray
                    $clipSel = Read-Host "    >"
                    if ($clipSel -eq "S" -or $clipSel -eq "s") {
                        try {
                            ($clavesParaClipboard -join "`r`n") | Set-Clipboard
                            Write-Host "    [OK] Copiado al portapapeles." -ForegroundColor Green
                        } catch { Write-Host "    [ERROR] Clipboard no disponible." -ForegroundColor Red }
                    }
                    
                    # Resumen
                    Write-Host ""
                    Escribir-Centrado "RESUMEN DE BACKUPS:" "White"
                    foreach ($ruta in $rutasGuardadas) { Write-Host "    -> ${ruta}" -ForegroundColor Gray }
                }
            }
            Write-Host "`n"; Read-Host "    ENTER para volver..."
        }

        # =============================================
        # 2. ACTIVAR BITLOCKER (con Health Check)
        # =============================================
        "2" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== ACTIVAR BITLOCKER ===" "DarkYellow"
            Write-Host ""
            
            # TPM check
            $tpm = Get-TPMStatus
            $tpmColor = if ($tpm.HasTPM -and $tpm.IsReady) { "Green" } elseif ($tpm.HasTPM) { "Yellow" } else { "Red" }
            Write-Host "    TPM: $($tpm.Summary)" -ForegroundColor $tpmColor
            
            if (-not $tpm.HasTPM) {
                Write-Host "    Sin TPM = contrasena requerida en cada arranque." -ForegroundColor Yellow
                Write-Host ""
                Write-Host "    [C] Continuar con contrasena  [B] Volver" -ForegroundColor White
                $tpmChoice = Read-Host "    >"
                if ($tpmChoice -ne "C" -and $tpmChoice -ne "c") { continue }
            } elseif (-not $tpm.IsReady) {
                Write-Host "    Puede requerir activacion en BIOS." -ForegroundColor Yellow
            }
            
            Write-Host ""
            $allVolumes = Show-DiskTable
            if (-not $allVolumes) { Read-Host "    ENTER para volver..."; continue }
            
            Write-Host "    Disco a encriptar (o [B] para volver):" -ForegroundColor White
            $input = Read-Host "    >"
            if ($input -eq "B" -or $input -eq "b") { continue }
            
            $validated = Validate-DriveLetter -Input $input -ValidVolumes $allVolumes
            if (-not $validated) { Read-Host "    ENTER para volver..."; continue }
            
            $disco = $validated.Letter; $vol = $validated.Volume
            
            if ($vol.VolumeStatus -eq 'FullyEncrypted') {
                Write-Host "    ${disco} YA esta encriptado." -ForegroundColor Yellow
                Read-Host "    ENTER para volver..."; continue
            }
            if ($vol.VolumeStatus -eq 'EncryptionInProgress') {
                Write-Host "    ${disco} ya se esta encriptando." -ForegroundColor Yellow
                Show-EncryptionProgress -MountPoint $disco -Mode "Encrypting"
                Read-Host "    ENTER para volver..."; continue
            }
            
            # HEALTH CHECK
            $health = Test-PreEncryptionHealth -MountPoint $disco
            
            if (-not $health.CanProceed) {
                Write-Host ""
                Escribir-Centrado "NO SE RECOMIENDA ENCRIPTAR EN ESTE ESTADO." "Red"
                Write-Host ""
                Write-Host "    [F] Forzar de todos modos  [B] Volver (recomendado)" -ForegroundColor Yellow
                $forceChoice = Read-Host "    >"
                if ($forceChoice -ne "F" -and $forceChoice -ne "f") {
                    Write-Log "Encriptacion cancelada por HealthCheck: ${disco}"
                    continue
                }
                Write-Log "HealthCheck FORZADO por usuario: ${disco}"
            }
            
            # Confirmación
            $capGB = if ($vol.CapacityGB) { "{0:N1}" -f $vol.CapacityGB } else { "?" }
            Write-Host ""
            Escribir-Centrado "CONFIRMAR: Activar BitLocker en ${disco} (${capGB} GB)?" "Yellow"
            Write-Host "    [S] Encriptar  [N] Cancelar" -ForegroundColor White
            $confirm = Read-Host "    >"
            if ($confirm -ne "S" -and $confirm -ne "s") { continue }
            
            Write-Host ""
            Write-Host "    Activando BitLocker en ${disco}..." -ForegroundColor Yellow
            
            try {
                if ($tpm.HasTPM -and $tpm.IsReady) {
                    Enable-BitLocker -MountPoint $disco -EncryptionMethod XtsAes256 -RecoveryPasswordProtector -ErrorAction Stop
                } else {
                    Write-Host "    Ingresa contrasena para arranque:" -ForegroundColor Cyan
                    $secPwd = Read-Host "    Contrasena" -AsSecureString
                    Enable-BitLocker -MountPoint $disco -EncryptionMethod XtsAes256 -PasswordProtector -Password $secPwd -ErrorAction Stop
                    Add-BitLockerKeyProtector -MountPoint $disco -RecoveryPasswordProtector -ErrorAction Stop
                }
                
                Write-Host ""
                Escribir-Centrado "BitLocker ACTIVADO en ${disco}" "Green"
                Escribir-Centrado "USA OPCION [1] PARA GUARDAR LA CLAVE!" "Cyan"
                Write-Log "BitLocker ACTIVADO: ${disco} (XtsAes256)"
                
                # AD backup automatico
                Write-Host ""
                Backup-KeyToAD -MountPoint $disco
                
                Write-Host ""
                Write-Host "    [M] Monitorear progreso  [ENTER] Volver" -ForegroundColor DarkGray
                $monSel = Read-Host "    >"
                if ($monSel -eq "M" -or $monSel -eq "m") {
                    Show-EncryptionProgress -MountPoint $disco -Mode "Encrypting"
                }
            } catch {
                Write-Host "    [ERROR] $($_.Exception.Message)" -ForegroundColor Red
                Write-Log "ERROR activando BitLocker ${disco}: $($_.Exception.Message)" "ERROR"
                
                $msg = $_.Exception.Message
                if ($msg -match "TPM") {
                    Write-Host "    SUGERENCIA: Activa TPM en BIOS." -ForegroundColor Yellow
                }
                if ($msg -match "policy|Group Policy") {
                    Write-Host "    SUGERENCIA: gpedit.msc > Computer Config > Admin Templates > BitLocker" -ForegroundColor Yellow
                }
            }
            Write-Host ""; Read-Host "    ENTER para volver..."
        }

        # =============================================
        # 3. DESACTIVAR BITLOCKER
        # =============================================
        "3" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== DESACTIVAR BITLOCKER ===" "DarkYellow"
            Write-Host ""
            
            $encVolumes = Show-DiskTable -OnlyEncrypted
            if (-not $encVolumes) { Read-Host "    ENTER para volver..."; continue }
            
            Write-Host "    Disco a desencriptar (o [B]):" -ForegroundColor White
            $input = Read-Host "    >"
            if ($input -eq "B" -or $input -eq "b") { continue }
            
            $validated = Validate-DriveLetter -Input $input -ValidVolumes $encVolumes
            if (-not $validated) { Read-Host "    ENTER para volver..."; continue }
            
            $disco = $validated.Letter; $vol = $validated.Volume
            
            if ($vol.VolumeStatus -eq 'DecryptionInProgress') {
                Write-Host "    Ya se esta desencriptando." -ForegroundColor Yellow
                Show-EncryptionProgress -MountPoint $disco -Mode "Decrypting"
                Read-Host "    ENTER para volver..."; continue
            }
            
            $capGB = if ($vol.CapacityGB) { "{0:N1}" -f $vol.CapacityGB } else { "?" }
            Write-Host ""
            Escribir-Centrado "CONFIRMAR: Desactivar BitLocker en ${disco} (${capGB} GB)?" "Red"
            Write-Host "    ADVERTENCIA: Los datos quedaran sin proteccion." -ForegroundColor Yellow
            Write-Host "    [S] Desencriptar  [N] Cancelar" -ForegroundColor White
            $confirm = Read-Host "    >"
            if ($confirm -ne "S" -and $confirm -ne "s") { continue }
            
            try {
                Disable-BitLocker -MountPoint $disco -ErrorAction Stop
                Escribir-Centrado "Desencriptacion iniciada en ${disco}." "Green"
                Write-Log "BitLocker DESACTIVADO: ${disco}"
                
                Write-Host "    [M] Monitorear  [ENTER] Volver" -ForegroundColor DarkGray
                $monSel = Read-Host "    >"
                if ($monSel -eq "M" -or $monSel -eq "m") {
                    Show-EncryptionProgress -MountPoint $disco -Mode "Decrypting"
                }
            } catch {
                Write-Host "    [ERROR] $($_.Exception.Message)" -ForegroundColor Red
                Write-Log "ERROR desactivando ${disco}: $($_.Exception.Message)" "ERROR"
            }
            Write-Host ""; Read-Host "    ENTER para volver..."
        }

        # =============================================
        # 4. ESTADO COMPLETO
        # =============================================
        "4" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== ESTADO COMPLETO ===" "DarkYellow"
            Write-Host ""
            
            $tpm = Get-TPMStatus
            $tpmColor = if ($tpm.HasTPM -and $tpm.IsReady) { "Green" } elseif ($tpm.HasTPM) { "Yellow" } else { "Red" }
            Write-Host "    TPM: $($tpm.Summary)" -ForegroundColor $tpmColor
            
            Show-DiskTable | Out-Null
            
            # Alerta
            Show-UnprotectedAlert
            
            # Protectores
            Write-Host ""
            Write-Host "    PROTECTORES ACTIVOS:" -ForegroundColor DarkGray
            Write-Host "    --------------------" -ForegroundColor DarkGray
            $allVols = Get-BitLockerVolume -ErrorAction SilentlyContinue
            $hasProtectors = $false
            foreach ($v in $allVols) {
                if ($v.VolumeStatus -ne 'FullyDecrypted' -and $v.KeyProtector) {
                    foreach ($kp in $v.KeyProtector) {
                        $kpType = $kp.KeyProtectorType.ToString()
                        $kpId = if ($kp.KeyProtectorId) { $kp.KeyProtectorId.Substring(0, [math]::Min(20, $kp.KeyProtectorId.Length)) + "..." } else { "" }
                        $typeLabel = switch ($kpType) {
                            "RecoveryPassword" { "Clave Recuperacion" }
                            "Tpm" { "TPM" }
                            "TpmPin" { "TPM + PIN" }
                            "Password" { "Contrasena" }
                            "ExternalKey" { "Llave Externa" }
                            default { $kpType }
                        }
                        Write-Host "    $($v.MountPoint) -> ${typeLabel} ${kpId}" -ForegroundColor Gray
                        $hasProtectors = $true
                    }
                }
            }
            if (-not $hasProtectors) { Write-Host "    (ninguno)" -ForegroundColor DarkGray }
            
            Write-Host "`n"; Read-Host "    ENTER para volver..."
        }

        # =============================================
        # 5. HISTORIAL
        # =============================================
        "5" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== HISTORIAL DE OPERACIONES ===" "DarkYellow"
            Write-Host ""
            
            if (Test-Path $logFile) {
                $logContent = Get-Content $logFile -Tail 50 -ErrorAction SilentlyContinue
                if ($logContent) {
                    Write-Host "    Ultimas operaciones (max 50):" -ForegroundColor DarkGray
                    Write-Host "    " + ("-" * 80) -ForegroundColor DarkGray
                    Write-Host ""
                    foreach ($line in $logContent) {
                        $lineColor = "Gray"
                        if ($line -match "ERROR") { $lineColor = "Red" }
                        elseif ($line -match "ACTIVADO") { $lineColor = "Green" }
                        elseif ($line -match "DESACTIVADO") { $lineColor = "Yellow" }
                        elseif ($line -match "Extraccion|Extract") { $lineColor = "Cyan" }
                        elseif ($line -match "FORZADO") { $lineColor = "Red" }
                        Write-Host "    ${line}" -ForegroundColor $lineColor
                    }
                } else {
                    Write-Host "    Log vacio." -ForegroundColor DarkGray
                }
            } else {
                Write-Host "    No hay historial aun." -ForegroundColor DarkGray
                Write-Host "    Se creara automaticamente con cada operacion." -ForegroundColor DarkGray
            }
            
            Write-Host ""
            Write-Host "    Archivo: ${logFile}" -ForegroundColor DarkGray
            Write-Host ""
            Write-Host "    [L] Limpiar historial  [ENTER] Volver" -ForegroundColor DarkGray
            $logAction = Read-Host "    >"
            if ($logAction -eq "L" -or $logAction -eq "l") {
                Write-Host "    Seguro? [S/N]" -ForegroundColor Yellow
                $logConfirm = Read-Host "    >"
                if ($logConfirm -eq "S" -or $logConfirm -eq "s") {
                    Remove-Item $logFile -Force -ErrorAction SilentlyContinue
                    Write-Host "    Historial limpiado." -ForegroundColor Green
                    Start-Sleep 1
                }
            }
        }

        "S" {
            Write-Host ""
            Escribir-Centrado "Cerrando..." "DarkYellow"
            Write-Log "Sesion cerrada"
            Start-Sleep -Seconds 1
            [console]::ResetColor()
            Clear-Host
            return
        }

        default {
            Escribir-Centrado "Opcion no valida." "Red"
            Start-Sleep -Seconds 1
        }
    }
}
}
