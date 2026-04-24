# ============================================================
# Invoke-Robocopy
# Migrado de: Robocopy.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-Robocopy {
    [CmdletBinding()]
    param()
# ========================================================
# ATLAS PC SUPPORT - COPIA INTELIGENTE v8 (PowerShell)
# Auto-detect + MD5 + Speed + ETA + Exclusiones + Modos
# ========================================================

# SIN auto-elevación: robocopy no necesita admin
# y la elevación BLOQUEA el drag-and-drop de Windows

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Gray"
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - Copia Inteligente v8"
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(110, 45) } catch {}
$ErrorActionPreference = "Continue"

# ==================== FUNCIONES ====================

function Write-Centered {
    param ([string]$Text, [string]$Color = "White")
    $W = try { $Host.UI.RawUI.WindowSize.Width } catch { 80 }
    $Pad = [math]::Max(0, [math]::Floor(($W - $Text.Length) / 2))
    Write-Host (" " * $Pad + $Text) -ForegroundColor $Color
}

function Clean-Path {
    param([string]$RawPath)
    return $RawPath.Trim().Trim('"').Trim("'").TrimEnd('\')
}

function Format-Size {
    param([long]$Bytes)
    if ($Bytes -ge 1GB) { return "{0:N2} GB" -f ($Bytes / 1GB) }
    if ($Bytes -ge 1MB) { return "{0:N1} MB" -f ($Bytes / 1MB) }
    if ($Bytes -ge 1KB) { return "{0:N0} KB" -f ($Bytes / 1KB) }
    return "$Bytes B"
}

function Format-Duration {
    param([TimeSpan]$Duration)
    if ($Duration.TotalHours -ge 1) { return "{0}h {1}m {2}s" -f [int]$Duration.TotalHours, $Duration.Minutes, $Duration.Seconds }
    if ($Duration.TotalMinutes -ge 1) { return "{0}m {1}s" -f [int]$Duration.TotalMinutes, $Duration.Seconds }
    return "{0:N1}s" -f $Duration.TotalSeconds
}

function Get-FolderStats {
    param([string]$Path)
    $items = Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue
    $totalSize = ($items | Measure-Object Length -Sum -ErrorAction SilentlyContinue).Sum
    if (-not $totalSize) { $totalSize = 0 }
    return @{ Files = $items.Count; Size = $totalSize; SizeMB = [math]::Round($totalSize / 1MB, 1) }
}

function Detect-DriveType {
    param([string]$DriveLetter)
    $letter = $DriveLetter.TrimEnd(':', '\')
    try {
        $vol = Get-Volume -DriveLetter $letter -ErrorAction Stop
        if ($vol.DriveType -eq 'Removable') {
            return @{ Type = "USB"; MT = 2; Desc = "USB Removible"; Color = "Yellow"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
        }
        $part = Get-Partition -DriveLetter $letter -ErrorAction Stop
        $disk = Get-Disk -Number $part.DiskNumber -ErrorAction Stop
        $phys = Get-PhysicalDisk -ErrorAction SilentlyContinue | Where-Object { $_.DeviceId -eq $disk.Number.ToString() }

        if ($disk.BusType -eq 'USB') {
            return @{ Type = "USB"; MT = 2; Desc = "USB Externo"; Color = "Yellow"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
        }
        if ($disk.BusType -eq 'NVMe' -or ($phys -and $phys.MediaType -match 'SSD')) {
            return @{ Type = "SSD"; MT = 32; Desc = "SSD/NVMe"; Color = "Green"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
        }
        return @{ Type = "HDD"; MT = 8; Desc = "HDD Mecanico"; Color = "Cyan"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
    } catch {
        return @{ Type = "UNKNOWN"; MT = 8; Desc = "No detectado"; Color = "Gray"; Label = ""; FreeBytes = 0 }
    }
}

# ==================== EXPLORADOR DE ARCHIVOS (alternativa a drag-drop) ====================

function Select-FolderDialog {
    param([string]$Description = "Selecciona una carpeta")
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = $Description
    $dialog.ShowNewFolderButton = $true
    $result = $dialog.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $dialog.SelectedPath
    }
    return $null
}

function Select-FileDialog {
    param([string]$Title = "Selecciona un archivo")
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Title = $Title
    $dialog.Filter = "Todos los archivos (*.*)|*.*"
    $dialog.Multiselect = $false
    $result = $dialog.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $dialog.FileName
    }
    return $null
}

function Get-PathFromUser {
    param([string]$Prompt = "ORIGEN", [string]$Mode = "any")
    
    Write-Host ""
    Write-Host "  ARRASTRA aqui, escribe la ruta, o usa el explorador:" -ForegroundColor White
    Write-Host "      [E] Abrir explorador de archivos" -ForegroundColor Cyan
    Write-Host "      [B] Volver  [S] Salir" -ForegroundColor DarkGray
    Write-Host ""
    $input = Read-Host "      ${Prompt}"
    
    if ($input -eq "S" -or $input -eq "s") { return "EXIT" }
    if ($input -eq "B" -or $input -eq "b") { return "BACK" }
    
    if ($input -eq "E" -or $input -eq "e") {
        if ($Mode -eq "folder") {
            $path = Select-FolderDialog -Description "Selecciona carpeta de ${Prompt}"
        } else {
            # Preguntar si carpeta o archivo
            Write-Host "      [1] Carpeta  [2] Archivo" -ForegroundColor White
            $tipo = Read-Host "      >"
            if ($tipo -eq "2") {
                $path = Select-FileDialog -Title "Selecciona archivo"
            } else {
                $path = Select-FolderDialog -Description "Selecciona carpeta"
            }
        }
        if (-not $path) { return "BACK" }
        return $path
    }
    
    return Clean-Path $input
}

# ==================== VERIFICACIÓN MD5 ====================

function Test-CopyIntegrity {
    param([string]$Origen, [string]$Destino, [int]$SampleSize = 15)

    Write-Host ""
    Write-Centered "VERIFICANDO INTEGRIDAD..." "Yellow"
    Write-Host ""

    $srcStats = Get-FolderStats $Origen
    $dstStats = Get-FolderStats $Destino

    Write-Host "    Archivos - Origen: $($srcStats.Files) | Destino: $($dstStats.Files)" -ForegroundColor Gray
    Write-Host "    Tamano   - Origen: $(Format-Size $srcStats.Size) | Destino: $(Format-Size $dstStats.Size)" -ForegroundColor Gray

    $countMatch = ($srcStats.Files -eq $dstStats.Files)
    $countColor = if ($countMatch) { "Green" } else { "Yellow" }
    Write-Host "    Conteo:  $(if ($countMatch) { 'COINCIDE' } else { 'DIFERENTE (normal si se excluyeron archivos)' })" -ForegroundColor $countColor

    Write-Host ""
    Write-Host "    Verificacion MD5 (muestra de ${SampleSize})..." -ForegroundColor DarkGray

    $srcFiles = Get-ChildItem -Path $Origen -Recurse -File -ErrorAction SilentlyContinue
    if (-not $srcFiles -or $srcFiles.Count -eq 0) {
        Write-Host "    Sin archivos para verificar." -ForegroundColor Gray
        return @{ OK = $true; Checked = 0; Passed = 0; Failed = 0; Missing = 0 }
    }

    $bySize = $srcFiles | Sort-Object Length -Descending | Select-Object -First 5
    $byDate = $srcFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 5
    $randomCount = [math]::Min([math]::Max(1, $SampleSize - 10), $srcFiles.Count)
    $random = $srcFiles | Get-Random -Count $randomCount
    $sample = @($bySize) + @($byDate) + @($random) | Sort-Object FullName -Unique | Select-Object -First $SampleSize

    $checked = 0; $passed = 0; $failed = 0; $missing = 0; $failedFiles = @()

    foreach ($srcFile in $sample) {
        $checked++
        $relPath = $srcFile.FullName.Substring($Origen.Length).TrimStart('\')
        $dstFile = Join-Path $Destino $relPath

        $pct = [math]::Round(($checked / $sample.Count) * 100, 0)
        Write-Host "`r    [${pct}%] Verificando ${checked}/$($sample.Count)..." -NoNewline -ForegroundColor DarkGray

        if (-not (Test-Path $dstFile)) {
            $missing++; $failedFiles += "FALTA: ${relPath}"; continue
        }
        try {
            $hashSrc = (Get-FileHash -Path $srcFile.FullName -Algorithm MD5 -ErrorAction Stop).Hash
            $hashDst = (Get-FileHash -Path $dstFile -Algorithm MD5 -ErrorAction Stop).Hash
            if ($hashSrc -eq $hashDst) { $passed++ }
            else { $failed++; $failedFiles += "CORRUPTO: ${relPath}" }
        } catch { $failed++; $failedFiles += "ERROR: ${relPath}" }
    }

    Write-Host ""; Write-Host ""

    if ($failed -eq 0 -and $missing -eq 0) {
        Write-Host "    [OK] INTEGRIDAD MD5: ${passed}/${checked} archivos verificados" -ForegroundColor Green
    } else {
        Write-Host "    [!!] PROBLEMAS: OK=${passed} | FALLOS=${failed} | FALTANTES=${missing}" -ForegroundColor Red
        foreach ($f in $failedFiles) { Write-Host "         $f" -ForegroundColor Red }
    }

    return @{ OK = ($failed -eq 0 -and $missing -eq 0); Checked = $checked; Passed = $passed; Failed = $failed; Missing = $missing }
}

# ==================== COPIA CON MONITOREO ====================

function Start-SmartCopy {
    param(
        [string]$Origen, [string]$Destino, [bool]$IsFile, [string]$FileName,
        [int]$MT, [string]$DiskType, [string]$Mode,
        [array]$ExcludeDirs, [array]$ExcludeFiles
    )

    Write-Host ""
    Write-Centered "COPIANDO... (${DiskType} | MT:${MT} | ${Mode})" "Yellow"
    Write-Host ""

    $sw = [System.Diagnostics.Stopwatch]::StartNew()

    $roboArgs = @()
    if ($IsFile) {
        $srcDir = Split-Path $Origen -Parent
        $roboArgs += "`"${srcDir}`""
        $roboArgs += "`"${Destino}`""
        $roboArgs += "`"${FileName}`""
    } else {
        $roboArgs += "`"${Origen}`""
        $roboArgs += "`"${Destino}`""
        $roboArgs += "/E"
    }

    $roboArgs += "/J"; $roboArgs += "/MT:${MT}"; $roboArgs += "/R:2"; $roboArgs += "/W:2"
    $roboArgs += "/FFT"; $roboArgs += "/ETA"; $roboArgs += "/NP"; $roboArgs += "/TEE"; $roboArgs += "/DCOPY:DAT"

    if (-not $IsFile) {
        $roboArgs += "/XJ"
        if ($Mode -eq "INCREMENTAL") { $roboArgs += "/XO" }
    }

    $logFile = Join-Path ([Environment]::GetFolderPath("Desktop")) "Log_Atlas_$(Get-Date -Format 'yyyy-MM-dd_HHmm').txt"
    $roboArgs += "/LOG+:`"${logFile}`""

    $defaultXD = @("System Volume Information", "`$RECYCLE.BIN", "Recovery")
    $allXD = $defaultXD + $ExcludeDirs
    if ($allXD.Count -gt 0 -and -not $IsFile) {
        $roboArgs += "/XD"
        foreach ($xd in $allXD) { $roboArgs += "`"${xd}`"" }
    }

    $defaultXF = @("Pagefile.sys", "Hiberfil.sys", "swapfile.sys", "Thumbs.db")
    $allXF = $defaultXF + $ExcludeFiles
    if ($allXF.Count -gt 0 -and -not $IsFile) {
        $roboArgs += "/XF"
        foreach ($xf in $allXF) { $roboArgs += "`"${xf}`"" }
    }

    $argString = $roboArgs -join " "

    $preSize = 0
    if (Test-Path $Destino) {
        try { $preSize = (Get-ChildItem $Destino -Recurse -File -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum } catch {}
        if (-not $preSize) { $preSize = 0 }
    }

    $process = Start-Process -FilePath "robocopy" -ArgumentList $argString -NoNewWindow -PassThru -Wait
    $exitCode = $process.ExitCode
    $sw.Stop(); $elapsed = $sw.Elapsed

    $postSize = 0
    if (Test-Path $Destino) {
        try { $postSize = (Get-ChildItem $Destino -Recurse -File -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum } catch {}
        if (-not $postSize) { $postSize = 0 }
    }
    $bytesCopied = [math]::Max(0, $postSize - $preSize)
    $speedMBps = if ($elapsed.TotalSeconds -gt 0) { [math]::Round(($bytesCopied / 1MB) / $elapsed.TotalSeconds, 1) } else { 0 }

    Write-Host ""
    Write-Host "    ========================================================" -ForegroundColor White
    $resultMsg = switch ($exitCode) {
        0 { "SIN CAMBIOS - Todo ya estaba copiado" }
        1 { "COPIADO EXITOSAMENTE" }
        2 { "Archivos extras en destino" }
        3 { "Copiado + extras en destino" }
        4 { "Algunos archivos no coinciden" }
        5 { "Copiado + no coincidencias" }
        default { if ($exitCode -le 7) { "Completado (codigo ${exitCode})" } else { "ERROR (codigo ${exitCode})" } }
    }
    $resultColor = if ($exitCode -le 3) { "Green" } elseif ($exitCode -le 7) { "Yellow" } else { "Red" }

    Write-Host "    RESULTADO: ${resultMsg}" -ForegroundColor $resultColor
    Write-Host "    ========================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "    Tiempo:    $(Format-Duration $elapsed)" -ForegroundColor Gray
    Write-Host "    Copiado:   $(Format-Size $bytesCopied)" -ForegroundColor Gray
    Write-Host "    Velocidad: ${speedMBps} MB/s" -ForegroundColor Gray
    Write-Host "    Log:       $(Split-Path $logFile -Leaf)" -ForegroundColor DarkGray

    return @{
        ExitCode = $exitCode; OK = ($exitCode -le 7); Elapsed = $elapsed
        BytesCopied = $bytesCopied; SpeedMBps = $speedMBps; LogFile = $logFile
    }
}

# ==================== BUCLE PRINCIPAL ====================

do {
    Clear-Host
    Write-Host "`n"
    Write-Centered "==========================================================" "Cyan"
    Write-Centered "|     ATLAS PC SUPPORT - COPIA INTELIGENTE v8            |" "Yellow"
    Write-Centered "==========================================================" "Cyan"
    Write-Host ""

    # =============================================
    # PASO 1: ORIGEN
    # =============================================
    $origen = $null; $isFile = $false; $srcName = ""; $srcStats = $null

    :askSource while ($true) {
        Write-Host ""
        Write-Host "  [1] ORIGEN (arrastra, escribe ruta, o explorador):" -ForegroundColor White
        
        $pathResult = Get-PathFromUser -Prompt "ORIGEN" -Mode "any"
        
        if ($pathResult -eq "EXIT") { exit }
        if ($pathResult -eq "BACK") { break }
        
        if (-not (Test-Path $pathResult)) {
            Write-Host "      [ERROR] No existe: ${pathResult}" -ForegroundColor Red
            continue
        }

        $origen = $pathResult
        $isFile = -not (Test-Path $origen -PathType Container)

        if ($isFile) {
            $srcFileObj = Get-Item $origen
            $srcName = $srcFileObj.Name
            $srcStats = @{ Files = 1; Size = $srcFileObj.Length; SizeMB = [math]::Round($srcFileObj.Length / 1MB, 1) }
            Write-Host ""
            Write-Host "      [OK] ARCHIVO: ${srcName} ($(Format-Size $srcFileObj.Length))" -ForegroundColor Green
        } else {
            $srcName = Split-Path $origen -Leaf
            Write-Host "      Escaneando..." -ForegroundColor DarkGray
            $srcStats = Get-FolderStats $origen
            Write-Host "      [OK] CARPETA: ${srcName}" -ForegroundColor Green
            Write-Host "      $($srcStats.Files) archivos | $(Format-Size $srcStats.Size)" -ForegroundColor Gray
        }
        break
    }

    if (-not $origen) { continue }

    # =============================================
    # PASO 2: DESTINO
    # =============================================
    $destino = $null; $driveInfo = $null

    :askDest while ($true) {
        Write-Host ""
        Write-Host "  [2] DESTINO:" -ForegroundColor White
        
        $pathResult = Get-PathFromUser -Prompt "DESTINO" -Mode "folder"
        
        if ($pathResult -eq "EXIT") { exit }
        if ($pathResult -eq "BACK") { break }
        
        $destBase = $pathResult
        if (-not (Test-Path $destBase)) {
            Write-Host "      [ERROR] No accesible: ${destBase}" -ForegroundColor Red
            continue
        }

        try {
            $fullOrigen = (Resolve-Path $origen).Path
            $fullDest = (Resolve-Path $destBase).Path
            if ($fullOrigen -eq $fullDest) {
                Write-Host "      [ERROR] Origen y destino son iguales!" -ForegroundColor Red
                continue
            }
            if ($fullDest.StartsWith($fullOrigen + "\")) {
                Write-Host "      [ERROR] Destino dentro del origen = recursion!" -ForegroundColor Red
                continue
            }
        } catch {}

        $destDriveLetter = $destBase.Substring(0, 1)
        $driveInfo = Detect-DriveType $destDriveLetter

        $labelDisplay = if ($driveInfo.Label) { " ($($driveInfo.Label))" } else { "" }
        Write-Host "      [OK] Disco: $($driveInfo.Desc)${labelDisplay}" -ForegroundColor $driveInfo.Color
        Write-Host "      Libre: $(Format-Size $driveInfo.FreeBytes)" -ForegroundColor Gray

        if ($driveInfo.FreeBytes -gt 0 -and $srcStats.Size -gt $driveInfo.FreeBytes) {
            Write-Host ""
            Write-Host "      [!!!] ESPACIO INSUFICIENTE" -ForegroundColor Red
            Write-Host "      Necesitas: $(Format-Size $srcStats.Size) | Disponible: $(Format-Size $driveInfo.FreeBytes)" -ForegroundColor Red
            Write-Host "      [F] Forzar  [B] Volver" -ForegroundColor Yellow
            $espOp = Read-Host "      >"
            if ($espOp -ne "F" -and $espOp -ne "f") { continue }
        }

        $destino = $destBase
        break
    }

    if (-not $destino) { continue }

    # =============================================
    # PASO 3: NOMBRE
    # =============================================
    Write-Host ""
    Write-Host "  [3] Nombre del proyecto (ENTER = Respaldo):" -ForegroundColor White
    $cliente = Read-Host "      NOMBRE"
    if ([string]::IsNullOrWhiteSpace($cliente)) { $cliente = "Respaldo" }
    $cliente = $cliente -replace '[\\/:*?"<>|]', '_'

    $fechaHoy = Get-Date -Format 'yyyy-MM-dd'
    $rutaFinal = Join-Path $destino "${cliente}_${fechaHoy}"

    # =============================================
    # PASO 4: MODO
    # =============================================
    Write-Host ""
    Write-Host "  [4] MODO DE COPIA:" -ForegroundColor Cyan
    Write-Host "      [1] COMPLETA - Copia todo (primera vez)" -ForegroundColor White
    Write-Host "      [2] INCREMENTAL - Solo nuevos/modificados" -ForegroundColor White
    Write-Host "      [B] Volver" -ForegroundColor DarkGray
    Write-Host ""
    $modoSel = Read-Host "      >"
    if ($modoSel -eq "B" -or $modoSel -eq "b") { continue }
    $modo = if ($modoSel -eq "2") { "INCREMENTAL" } else { "COMPLETA" }

    # =============================================
    # PASO 5: EXCLUSIONES
    # =============================================
    $extraXD = @(); $extraXF = @()

    if (-not $isFile) {
        Write-Host ""
        Write-Host "  [5] EXCLUSIONES:" -ForegroundColor Cyan
        Write-Host "      [1] Ninguna (copiar todo)" -ForegroundColor White
        Write-Host "      [2] Temporales (.tmp, .log, .bak, cache)" -ForegroundColor White
        Write-Host "      [3] ISOs y VMs (.iso, .vhd, .wim)" -ForegroundColor White
        Write-Host "      [4] Personalizado (escribir extensiones)" -ForegroundColor White
        Write-Host "      [B] Volver" -ForegroundColor DarkGray
        Write-Host ""
        $exclSel = Read-Host "      >"
        if ($exclSel -eq "B" -or $exclSel -eq "b") { continue }

        switch ($exclSel) {
            "2" {
                $extraXF = @("*.tmp", "*.log", "*.bak", "*.cache", "*.temp", "~*")
                $extraXD = @("Temp", "tmp", "Cache", "__pycache__", "node_modules", ".git")
                Write-Host "      [OK] Excluyendo temporales y cache" -ForegroundColor Green
            }
            "3" {
                $extraXF = @("*.iso", "*.vhd", "*.vhdx", "*.wim", "*.esd", "*.vmdk")
                Write-Host "      [OK] Excluyendo ISOs y VMs" -ForegroundColor Green
            }
            "4" {
                Write-Host "      Extensiones separadas por coma (ej: .mp4,.avi,.mkv):" -ForegroundColor White
                $customExcl = Read-Host "      >"
                if (-not [string]::IsNullOrWhiteSpace($customExcl)) {
                    $extraXF = ($customExcl -split ',') | ForEach-Object {
                        $ext = $_.Trim()
                        if ($ext -notmatch '^\*') { $ext = "*${ext}" }
                        $ext
                    }
                    Write-Host "      [OK] Excluyendo: $($extraXF -join ', ')" -ForegroundColor Green
                }
            }
        }
    }

    # =============================================
    # PASO 6: PREVIEW
    # =============================================
    Clear-Host
    Write-Host "`n"
    Write-Centered "==================== PREVIEW ====================" "White"
    Write-Host ""

    if ($isFile) {
        Write-Host "    TIPO:      Archivo suelto" -ForegroundColor Gray
        Write-Host "    ARCHIVO:   ${srcName}" -ForegroundColor White
        Write-Host "    TAMANO:    $(Format-Size $srcStats.Size)" -ForegroundColor Gray
    } else {
        Write-Host "    TIPO:      Carpeta" -ForegroundColor Gray
        Write-Host "    ORIGEN:    ${srcName}" -ForegroundColor White
        Write-Host "    ARCHIVOS:  $($srcStats.Files) | $(Format-Size $srcStats.Size)" -ForegroundColor Gray
    }

    Write-Host ""
    Write-Host "    DESTINO:   ${rutaFinal}" -ForegroundColor White
    Write-Host "    DISCO:     $($driveInfo.Desc)" -ForegroundColor $driveInfo.Color
    Write-Host "    HILOS:     MT:$($driveInfo.MT) (auto)" -ForegroundColor Gray
    Write-Host "    MODO:      ${modo}" -ForegroundColor Cyan

    if ($extraXF.Count -gt 0 -or $extraXD.Count -gt 0) {
        Write-Host "    EXCLUIR:   $($extraXF.Count) tipo(s) archivo + $($extraXD.Count) carpeta(s)" -ForegroundColor DarkGray
    }

    $avgSpeed = switch ($driveInfo.Type) { "USB" { 25 } "HDD" { 80 } "SSD" { 300 } default { 50 } }
    if ($srcStats.SizeMB -gt 0) {
        $etaSec = $srcStats.SizeMB / $avgSpeed
        $etaSpan = [TimeSpan]::FromSeconds($etaSec)
        Write-Host "    ETA:       ~$(Format-Duration $etaSpan) (estimado para $($driveInfo.Type))" -ForegroundColor DarkGray
    }

    Write-Host ""
    Write-Centered "=================================================" "White"
    Write-Host ""
    Write-Host "    [S] INICIAR COPIA  [B] Volver  [N] Cancelar" -ForegroundColor White
    Write-Host ""
    $confirmar = Read-Host "    >"
    if ($confirmar -ne "S" -and $confirmar -ne "s") { continue }

    # =============================================
    # PASO 7: EJECUTAR
    # =============================================
    Clear-Host
    Write-Host "`n"

    $fileName = if ($isFile) { $srcName } else { "" }

    $result = Start-SmartCopy -Origen $origen -Destino $rutaFinal -IsFile $isFile -FileName $fileName `
        -MT $driveInfo.MT -DiskType $driveInfo.Type -Mode $modo `
        -ExcludeDirs $extraXD -ExcludeFiles $extraXF

    # =============================================
    # PASO 8: VERIFICACION
    # =============================================
    if ($result.OK -and -not $isFile) {
        Write-Host ""
        Write-Host "    Verificar integridad MD5? [S/N]" -ForegroundColor DarkGray
        $verSel = Read-Host "    >"
        if ($verSel -eq "S" -or $verSel -eq "s") {
            $integrity = Test-CopyIntegrity -Origen $origen -Destino $rutaFinal
        }
    }

    # =============================================
    # PASO 9: POST-COPIA
    # =============================================
    :postMenu while ($true) {
        Write-Host ""
        Write-Host "    --------------------------------------------------------" -ForegroundColor DarkGray
        Write-Host "    [A] Abrir carpeta destino" -ForegroundColor Cyan
        Write-Host "    [R] REPETIR con OTRO destino (mismo origen)" -ForegroundColor Green
        Write-Host "    [N] Nueva copia (otro origen)" -ForegroundColor White
        Write-Host "    [L] Ver log" -ForegroundColor DarkGray
        Write-Host "    [S] Salir" -ForegroundColor DarkGray
        Write-Host "    --------------------------------------------------------" -ForegroundColor DarkGray
        Write-Host ""
        $postOp = Read-Host "    >"

        switch ($postOp.ToUpper()) {
            "A" {
                if (Test-Path $rutaFinal) { Invoke-Item $rutaFinal }
                else { Write-Host "    Carpeta no encontrada." -ForegroundColor Red }
            }
            "R" {
                Write-Host ""
                Write-Host "    Nuevo DESTINO:" -ForegroundColor White
                
                $newPath = Get-PathFromUser -Prompt "DESTINO" -Mode "folder"
                if ($newPath -eq "BACK" -or $newPath -eq "EXIT" -or -not $newPath) { continue }
                
                $newDestBase = $newPath
                if (-not (Test-Path $newDestBase)) {
                    Write-Host "    Ruta no accesible." -ForegroundColor Red
                    continue
                }

                $newDriveInfo = Detect-DriveType ($newDestBase.Substring(0, 1))
                $newRutaFinal = Join-Path $newDestBase "${cliente}_${fechaHoy}"

                $newLabelDisplay = if ($newDriveInfo.Label) { " ($($newDriveInfo.Label))" } else { "" }
                Write-Host "    Disco: $($newDriveInfo.Desc)${newLabelDisplay} | MT:$($newDriveInfo.MT)" -ForegroundColor $newDriveInfo.Color
                Write-Host "    Destino: ${newRutaFinal}" -ForegroundColor White
                Write-Host ""
                Write-Host "    [S] Copiar  [N] Cancelar" -ForegroundColor White
                $repConf = Read-Host "    >"

                if ($repConf -eq "S" -or $repConf -eq "s") {
                    Clear-Host; Write-Host "`n"
                    $result2 = Start-SmartCopy -Origen $origen -Destino $newRutaFinal -IsFile $isFile -FileName $fileName `
                        -MT $newDriveInfo.MT -DiskType $newDriveInfo.Type -Mode $modo `
                        -ExcludeDirs $extraXD -ExcludeFiles $extraXF

                    if ($result2.OK -and -not $isFile) {
                        Write-Host ""; Write-Host "    Verificar MD5? [S/N]" -ForegroundColor DarkGray
                        $v2 = Read-Host "    >"
                        if ($v2 -eq "S" -or $v2 -eq "s") { Test-CopyIntegrity -Origen $origen -Destino $newRutaFinal | Out-Null }
                    }
                }
            }
            "N" { break }
            "L" {
                if (Test-Path $result.LogFile) { Start-Process notepad $result.LogFile }
                else { Write-Host "    Log no encontrado." -ForegroundColor Red }
            }
            "S" { exit }
        }

        if ($postOp -eq "N" -or $postOp -eq "n") { break }
    }

} while ($true)
}
