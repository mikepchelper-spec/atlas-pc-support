# ============================================================
# Invoke-DiagnosticoMaster
# Migrado de: Diagnostico_Master.ps1 (v82)
# Atlas PC Support — v1.0
# ============================================================

function Invoke-DiagnosticoMaster {
    [CmdletBinding()]
    param()

$Host.UI.RawUI.ForegroundColor = "Gray"
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(100, 55) } catch {} 
try { [Console]::CursorVisible = $true } catch {}

# --- 2. FUNCIONES DE DISEÑO ---

function Escribir-Centrado {
    param([string]$Texto, [ConsoleColor]$Color = "White", [boolean]$NewLine = $true)
    $Ancho = $Host.UI.RawUI.WindowSize.Width
    $PadLeft = [math]::Max(0, [math]::Floor(($Ancho - $Texto.Length) / 2))
    Write-Host (" " * $PadLeft) -NoNewline
    if ($NewLine) { Write-Host $Texto -ForegroundColor $Color } else { Write-Host $Texto -ForegroundColor $Color -NoNewline }
}

function Dibujar-Header {
    Clear-Host; Write-Host "`n`n"; 
    Escribir-Centrado "==========================================================" "DarkGray"
    Escribir-Centrado "A T L A S   P C   S U P P O R T" "DarkYellow"
    Escribir-Centrado "Protocolo de Diagnostico Integral v82" "White"
    Escribir-Centrado "==========================================================" "DarkGray"
    Write-Host "`n"
}

function Start-ProcessWithTimeout {
    param(
        [string]$FilePath,
        [string]$Arguments = "",
        [int]$TimeoutSeconds = 60,
        [string]$WindowStyle = "Hidden"
    )
    try {
        $proc = Start-Process $FilePath -ArgumentList $Arguments -PassThru -WindowStyle $WindowStyle -ErrorAction Stop
        $waited = $proc.WaitForExit($TimeoutSeconds * 1000)
        if (-not $waited) {
            $proc | Stop-Process -Force -ErrorAction SilentlyContinue
            Write-Host "    [TIMEOUT] Proceso excedio ${TimeoutSeconds}s - cancelado." -ForegroundColor Yellow
            return $false
        }
        return $true
    } catch {
        Write-Host "    [ERROR] No se pudo ejecutar: $_" -ForegroundColor Red
        return $false
    }
}

# --- 3. FUNCIÓN: DIAGNÓSTICO RAM + DETECCIÓN SOLDADA ---
function Get-RAMDiagnostic {
    $result = @{
        HtmlSection = ""; TextSummary = ""; MaxCapGB = 0
        SlotsTotal = 0; SlotsUsed = 0; SlotsLibres = 0
        Modules = @(); SolderedWarning = ""
        TotalGB = 0; AllSoldered = $false; HasFreeSlots = $false
        IsDualChannel = $false
    }
    
    try {
        $placa = Get-CimInstance Win32_PhysicalMemoryArray -ErrorAction Stop
        $modulos = Get-CimInstance Win32_PhysicalMemory -ErrorAction Stop
    } catch {
        $result.HtmlSection = "<h2>RAM Diagnostico</h2><pre>No se pudo acceder al hardware de memoria.</pre>"
        return $result
    }
    
    if ($placa.MaxCapacity -and $placa.MaxCapacity -gt 0) {
        $result.MaxCapGB = [math]::Round(($placa.MaxCapacity / 1024 / 1024), 0)
    }
    
    $result.SlotsTotal = if ($placa.MemoryDevices) { $placa.MemoryDevices } else { 0 }
    $result.SlotsUsed = @($modulos).Count
    $result.SlotsLibres = [math]::Max(0, $result.SlotsTotal - $result.SlotsUsed)
    $result.HasFreeSlots = ($result.SlotsLibres -gt 0)
    $result.TotalGB = [math]::Round(($modulos | Measure-Object Capacity -Sum).Sum / 1GB, 0)
    $result.IsDualChannel = ($result.SlotsUsed -ge 2)
    
    $maxCapDisplay = if ($result.MaxCapGB -gt 0) { "$($result.MaxCapGB) GB" } else { "No reportado (BIOS Legacy)" }
    
    $chassis = Get-CimInstance Win32_SystemEnclosure -ErrorAction SilentlyContinue
    $isLaptop = $false
    if ($chassis) {
        $laptopTypes = @(9, 10, 14, 31, 32)
        foreach ($ct in $chassis.ChassisTypes) { if ($ct -in $laptopTypes) { $isLaptop = $true; break } }
    }
    
    $formFactorNames = @{
        0="Desconocido"; 1="Otro"; 2="SIP"; 3="DIP"; 4="ZIP"; 5="SOJ"; 6="Propietario"
        7="SIMM"; 8="DIMM"; 9="TSOP"; 10="PGA"; 11="RIMM"; 12="SODIMM"; 13="SRIMM"
        14="SMD"; 15="SSMP"; 16="QFP"; 17="TQFP"; 18="SOIC"; 19="LCC"; 20="PLCC"
        21="BGA"; 22="FPBGA"; 23="LGA"; 24="FB-DIMM"
    }
    
    $solderedCount = 0; $removableCount = 0
    
    $htmlTable = "<table class='info-table'>"
    $htmlTable += "<tr><th>Slot</th><th>Fabricante</th><th>Capacidad</th><th>Velocidad</th><th>Estado XMP</th><th>Voltaje</th><th>Tipo</th><th>Part Number</th></tr>"
    $textDetail = "Slots: $($result.SlotsUsed)/$($result.SlotsTotal) | Max: ${maxCapDisplay}`n"
    
    foreach ($ram in $modulos) {
        $capGB = [math]::Round($ram.Capacity / 1GB, 0)
        $fab = if ($ram.Manufacturer) { $ram.Manufacturer.Trim() } else { "N/A" }
        $part = if ($ram.PartNumber) { $ram.PartNumber.Trim() } else { "N/A" }
        $slot = if ($ram.DeviceLocator) { $ram.DeviceLocator } else { "N/A" }
        $ff = if ($ram.FormFactor) { [int]$ram.FormFactor } else { 0 }
        $ffName = if ($formFactorNames.ContainsKey($ff)) { $formFactorNames[$ff] } else { "Tipo ${ff}" }
        $devLoc = if ($ram.DeviceLocator) { $ram.DeviceLocator } else { "" }
        $bankLabel = if ($ram.BankLabel) { $ram.BankLabel } else { "" }
        
        $voltaje = "N/A"
        if ($ram.ConfiguredVoltage -and $ram.ConfiguredVoltage -gt 0) {
            $voltaje = "$([math]::Round($ram.ConfiguredVoltage / 1000, 2)) V"
        }
        
        $configSpeed = if ($ram.ConfiguredClockSpeed) { $ram.ConfiguredClockSpeed } else { 0 }
        $nativeSpeed = if ($ram.Speed) { $ram.Speed } else { 0 }
        $speedDisplay = if ($configSpeed -gt 0) { "${configSpeed} MHz" } else { "N/A" }
        
        $xmpStatus = "OK"; $xmpColor = "#5cb85c"; $xmpIcon = "&#10004;"
        if ($configSpeed -gt 0 -and $nativeSpeed -gt 0 -and $configSpeed -lt $nativeSpeed) {
            $xmpStatus = "BAJA (${configSpeed} vs ${nativeSpeed} MHz) - XMP Apagado?"
            $xmpColor = "#d9534f"; $xmpIcon = "&#9888;"
        } elseif ($configSpeed -eq 0 -or $nativeSpeed -eq 0) {
            $xmpStatus = "No verificable"; $xmpColor = "#888"; $xmpIcon = "?"
        }
        
        $thisIsSoldered = ($devLoc -match "Solder|Onboard|On Board|Integrad") -or 
                          ($bankLabel -match "Solder|Onboard") -or 
                          ($ff -eq 0 -and $isLaptop) -or 
                          ($ff -in @(14, 21, 22))
        
        if ($thisIsSoldered) { $solderedCount++ } else { $removableCount++ }
        
        $typeDisplay = $ffName; $typeStyle = ""
        if ($thisIsSoldered) {
            $typeDisplay = "&#128274; ${ffName} (Soldada)"; $typeStyle = "color:#dc3545;font-weight:bold"
        } elseif ($ff -eq 8 -or $ff -eq 12 -or $ff -eq 24) {
            $typeDisplay = "&#128280; ${ffName} (Removible)"; $typeStyle = "color:#28a745"
        }
        
        $htmlTable += "<tr><td>${slot}</td><td>${fab}</td><td>${capGB} GB</td><td>${speedDisplay}</td>"
        $htmlTable += "<td style='color:${xmpColor};font-weight:bold'>${xmpIcon} ${xmpStatus}</td>"
        $htmlTable += "<td>${voltaje}</td><td style='${typeStyle};font-size:12px'>${typeDisplay}</td>"
        $htmlTable += "<td style='font-size:10px'>${part}</td></tr>"
        
        $textDetail += "  ${slot}: ${capGB}GB ${fab} @ ${speedDisplay} (${xmpStatus}) [${ffName}]`n"
        
        $result.Modules += @{
            Slot = $slot; Manufacturer = $fab; CapacityGB = $capGB
            Speed = $configSpeed; NativeSpeed = $nativeSpeed
            Voltage = $voltaje; PartNumber = $part; XMPStatus = $xmpStatus
            FormFactor = $ffName; IsSoldered = $thisIsSoldered
        }
    }
    
    $htmlTable += "</table>"
    $result.AllSoldered = ($solderedCount -eq @($modulos).Count -and $solderedCount -gt 0)
    
    $solderHtml = ""
    if ($solderedCount -gt 0 -and $solderedCount -eq @($modulos).Count) {
        $solderHtml = "<div style='background:#f8d7da;color:#721c24;padding:12px;border:1px solid #f5c6cb;border-radius:4px;margin-bottom:10px;font-size:13px'>"
        $solderHtml += "<strong>&#9888; RAM NO AMPLIABLE:</strong> Todos los modulos (${solderedCount}) estan soldados. No es posible ampliar la memoria."
        $solderHtml += "</div>"
        $result.SolderedWarning = "TODA soldada - NO ampliable"
    } elseif ($solderedCount -gt 0 -and $removableCount -gt 0) {
        $solderHtml = "<div style='background:#fff3cd;color:#856404;padding:12px;border:1px solid #ffeeba;border-radius:4px;margin-bottom:10px;font-size:13px'>"
        $solderHtml += "<strong>&#9432; MIXTA:</strong> ${solderedCount} soldado(s) + ${removableCount} removible(s). "
        if ($result.HasFreeSlots) { $solderHtml += "$($result.SlotsLibres) slot(s) libre(s)." }
        $solderHtml += "</div>"
        $result.SolderedWarning = "Mixta: ${solderedCount} soldado(s) + ${removableCount} removible(s)"
    } elseif ($removableCount -gt 0 -and $result.HasFreeSlots) {
        $solderHtml = "<div style='background:#d4edda;color:#155724;padding:12px;border:1px solid #c3e6cb;border-radius:4px;margin-bottom:10px;font-size:13px'>"
        $solderHtml += "<strong>&#10004; AMPLIABLE:</strong> ${removableCount} removible(s). $($result.SlotsLibres) slot(s) libre(s)."
        $solderHtml += "</div>"
    }
    
    $htmlSummary = "<div style='background:#f0f4f8;padding:10px 15px;border-radius:4px;margin-bottom:10px;font-size:13px'>"
    $htmlSummary += "<strong>Slots:</strong> $($result.SlotsUsed) de $($result.SlotsTotal) | "
    $htmlSummary += "<strong>Max:</strong> ${maxCapDisplay} | "
    $htmlSummary += "<strong>Canal:</strong> $(if($result.IsDualChannel){'Dual Channel'}else{'Single Channel'})"
    $htmlSummary += "</div>"
    
    $result.HtmlSection = $htmlSummary + $solderHtml + $htmlTable
    $result.TextSummary = $textDetail
    return $result
}

# --- 4. FUNCIÓN: CPU UPGRADE CHECK ---
function Get-CPUUpgradeInfo {
    $result = @{
        HtmlSection = ""; IsSoldered = $false; SocketType = ""
        UpgradeMethod = ""; Summary = ""
        Generation = 0; GenerationLabel = ""; IsBasic = $false
        CoreCount = 0; ThreadCount = 0; CPUName = ""
        ScoreLabel = ""; ScoreColor = ""
    }
    
    $proc = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $proc) {
        $result.HtmlSection = "<pre>No se pudo obtener info del procesador.</pre>"
        return $result
    }
    
    $result.CPUName = if ($proc.Name) { $proc.Name.Trim() } else { "Desconocido" }
    $result.CoreCount = if ($proc.NumberOfCores) { $proc.NumberOfCores } else { 0 }
    $result.ThreadCount = if ($proc.NumberOfLogicalProcessors) { $proc.NumberOfLogicalProcessors } else { 0 }
    $socketName = if ($proc.SocketDesignation) { $proc.SocketDesignation } else { "No reportado" }
    $result.SocketType = $socketName
    
    $upgradeCode = if ($proc.UpgradeMethod) { [int]$proc.UpgradeMethod } else { 2 }
    
    $upgradeMethodNames = @{
        1="Otro"; 2="Desconocido"; 3="Daughter Board"; 4="ZIF Socket"; 5="Reemplazable"
        6="Ninguno (BGA/Soldado)"; 7="LIF Socket"; 8="Slot 1"; 9="Slot 2"
        10="370-pin"; 11="Slot A"; 12="Slot M"; 13="Socket 423"; 14="Socket A (462)"
        15="Socket 478"; 16="Socket 754"; 17="Socket 940"; 18="Socket 939"
        19="mPGA604"; 20="LGA771"; 21="LGA775"; 22="S1"; 23="AM2"; 24="F (1207)"
        25="LGA1366"; 26="G34"; 27="AM3"; 28="C32"; 29="LGA1156"; 30="LGA1567"
        31="PGA988A"; 32="BGA1288"; 33="rPGA988B"; 34="BGA1023"; 35="BGA1224"
        36="LGA1155"; 37="LGA1356"; 38="LGA2011"; 39="FS1"; 40="FS2"; 41="FM1"
        42="FM2"; 43="LGA2011-3"; 44="LGA1356-3"; 45="LGA1150"; 46="BGA1168"
        47="BGA1234"; 48="BGA1364"; 49="AM4"; 50="LGA1151"; 51="BGA1356"
        52="BGA1440"; 53="BGA1515"; 54="LGA3647-1"; 55="SP3"; 56="SP3r2"
        57="LGA2066"; 58="BGA1392"; 59="BGA1510"; 60="BGA1528"; 61="LGA4189"
        62="LGA1200"; 63="LGA4677"; 64="LGA1700"; 65="BGA1744"; 66="BGA1781"
        67="BGA1211"; 68="BGA2422"; 69="LGA1211"; 70="LGA2085"; 71="LGA4710"
    }
    
    $upgradeMethodName = if ($upgradeMethodNames.ContainsKey($upgradeCode)) { $upgradeMethodNames[$upgradeCode] } else { "Codigo ${upgradeCode}" }
    $result.UpgradeMethod = $upgradeMethodName
    
    # Detección generación
    $cpuName = $result.CPUName
    $gen = 0; $genLabel = ""
    if ($cpuName -match "i[3579]-(\d{1,2})(\d{2,3})") { $gen = [int]$matches[1]; $genLabel = "Intel Gen ${gen}" }
    elseif ($cpuName -match "Core\s*Ultra") { $gen = 14; $genLabel = "Intel Core Ultra (Gen 14+)" }
    elseif ($cpuName -match "Intel.*\b(1[234]\d{2,3})\b") { $firstTwo = [int]($matches[1].Substring(0,2)); if ($firstTwo -ge 10 -and $firstTwo -le 14) { $gen=$firstTwo; $genLabel="Intel Gen ${gen}" } }
    elseif ($cpuName -match "Ryzen\s+[3579]\s+(\d)(\d{2,3})") { $gen = [int]$matches[1]; $genLabel = "AMD Ryzen Gen ${gen}" }
    elseif ($cpuName -match "Ryzen\s+[3579]\s+(\d)(\d{3})") { $gen = [int]$matches[1]; $genLabel = "AMD Ryzen Gen ${gen}" }
    elseif ($cpuName -match "Athlon|A[46]-|A[46]\s|E[12]-|FX-") { $gen = 1; $genLabel = "AMD Legacy" }
    $result.Generation = $gen; $result.GenerationLabel = $genLabel
    
    if ($cpuName -match "Celeron|Pentium|Atom|Sempron|Athlon") { $result.IsBasic = $true }
    elseif ($cpuName -match "i3-[234]\d{2}" -or ($cpuName -match "i3" -and $gen -le 4)) { $result.IsBasic = $true }
    elseif ($result.CoreCount -le 2 -and $result.ThreadCount -le 2) { $result.IsBasic = $true }
    
    if ($result.IsBasic -or $gen -le 3) { $result.ScoreLabel="BASICO"; $result.ScoreColor="#dc3545" }
    elseif ($gen -le 6) { $result.ScoreLabel="ANTIGUO"; $result.ScoreColor="#fd7e14" }
    elseif ($gen -le 9) { $result.ScoreLabel="ACEPTABLE"; $result.ScoreColor="#ffc107" }
    else { $result.ScoreLabel="BUENO"; $result.ScoreColor="#28a745" }
    if ($gen -eq 0 -and $result.CoreCount -ge 6) { $result.ScoreLabel="ACEPTABLE"; $result.ScoreColor="#ffc107" }
    
    # Detección BGA
    $bgaSignals = 0; $bgaReasons = @()
    if ($upgradeCode -eq 6) { $bgaSignals += 3; $bgaReasons += "UpgradeMethod = None/BGA" }
    elseif ($upgradeMethodName -match "BGA") { $bgaSignals += 3; $bgaReasons += "Socket BGA (${upgradeMethodName})" }
    if ($socketName -match "BGA") { $bgaSignals += 2; $bgaReasons += "Socket designado BGA" }
    if ($cpuName -match "[-\s](\d{4,5})[UYHPG]\b") { $bgaSignals += 1; $bgaReasons += "Sufijo mobile" }
    $chassis = Get-CimInstance Win32_SystemEnclosure -ErrorAction SilentlyContinue
    $isLaptop = $false
    if ($chassis) { foreach ($ct in $chassis.ChassisTypes) { if ($ct -in @(9,10,14,31,32)) { $isLaptop=$true; break } } }
    if ($isLaptop -and $bgaSignals -ge 1) { $bgaSignals += 1; $bgaReasons += "Equipo laptop" }
    
    if ($bgaSignals -ge 3) {
        $result.IsSoldered=$true; $statusIcon="&#128274;"; $statusText="SOLDADO (BGA) - No reemplazable"
        $statusColor="#dc3545"; $bgColor="#f8d7da"; $borderColor="#f5c6cb"; $textColor="#721c24"
        $advice="El procesador esta soldado a la placa. No es posible reemplazarlo."
    } elseif ($bgaSignals -ge 1) {
        $result.IsSoldered=$true; $statusIcon="&#9888;"; $statusText="PROBABLEMENTE SOLDADO"
        $statusColor="#fd7e14"; $bgColor="#fff3cd"; $borderColor="#ffeeba"; $textColor="#856404"
        $advice="Senales indican CPU probablemente soldado. Verifique con el fabricante."
    } else {
        $result.IsSoldered=$false; $statusIcon="&#128280;"; $statusText="SOCKET - Reemplazable"
        $statusColor="#28a745"; $bgColor="#d4edda"; $borderColor="#c3e6cb"; $textColor="#155724"
        $advice="El procesador usa socket ${socketName}. Es posible reemplazarlo por otro compatible."
    }
    
    $reasonList = if ($bgaReasons.Count -gt 0) { $bgaReasons -join " | " } else { "Sin senales especificas" }
    $alertHtml = "<div style='background:${bgColor};color:${textColor};padding:12px;border:1px solid ${borderColor};border-radius:4px;margin-top:10px;font-size:13px'>"
    $alertHtml += "<strong>${statusIcon} ${statusText}</strong><br>${advice}<br>"
    $alertHtml += "<span style='font-size:11px;opacity:0.8'>Deteccion: ${reasonList}</span></div>"
    
    $scoreLabel=$result.ScoreLabel; $scoreColor=$result.ScoreColor
    $genDisplay = if ($genLabel) { $genLabel } else { "No detectada" }
    $cpuTable = "<table class='info-table'>"
    $cpuTable += "<tr><th>Socket</th><td>${socketName}</td></tr>"
    $cpuTable += "<tr><th>Upgrade Method</th><td>${upgradeMethodName}</td></tr>"
    $cpuTable += "<tr><th>Generacion</th><td>${genDisplay}</td></tr>"
    $cpuTable += "<tr><th>Nucleos / Hilos</th><td>$($result.CoreCount)C / $($result.ThreadCount)T</td></tr>"
    $cpuTable += "<tr><th>Clasificacion</th><td style='color:${scoreColor};font-weight:bold'>${scoreLabel}</td></tr>"
    $cpuTable += "<tr><th>Reemplazable</th><td style='color:${statusColor};font-weight:bold'>${statusIcon} ${statusText}</td></tr>"
    $cpuTable += "</table>"
    $result.HtmlSection = $cpuTable + $alertHtml
    $result.Summary = "${statusText} | ${scoreLabel} | ${genDisplay}"
    return $result
}

# --- 5. FUNCIÓN: ANÁLISIS DE ALMACENAMIENTO ---
function Get-StorageAnalysis {
    $result = @{ Disks = @(); HasHDD = $false; HasSATASSD = $false; HasNVMe = $false; CriticalSpace = $false; HtmlSection = "" }
    $physDisks = Get-PhysicalDisk -ErrorAction SilentlyContinue
    $logDisks = Get-CimInstance Win32_LogicalDisk -ErrorAction SilentlyContinue | Where-Object { $_.DriveType -eq 3 }
    
    $htmlTable = "<table class='info-table'><tr><th>Disco</th><th>Tipo</th><th>Bus</th><th>Tamano</th><th>Salud</th><th>Clasificacion</th></tr>"
    if ($physDisks) {
        foreach ($pd in $physDisks) {
            $name = if ($pd.FriendlyName) { $pd.FriendlyName } else { "Disco" }
            $media = if ($pd.MediaType) { $pd.MediaType.ToString() } else { "Desconocido" }
            $bus = if ($pd.BusType) { $pd.BusType.ToString() } else { "Desconocido" }
            $sizeGB = if ($pd.Size) { [math]::Round($pd.Size / 1GB, 0) } else { 0 }
            $health = if ($pd.HealthStatus) { $pd.HealthStatus.ToString() } else { "Desconocido" }
            $healthColor = if ($health -eq "Healthy") { "#28a745" } else { "#dc3545" }
            $classification = ""; $classColor = ""
            if ($media -match "HDD" -or ($media -match "Unspecified" -and $sizeGB -gt 500 -and $bus -match "SATA|ATA" -and $bus -notmatch "NVMe")) {
                $result.HasHDD = $true; $classification = "&#9888; HDD MECANICO - Lento"; $classColor = "#dc3545"
            } elseif ($media -match "SSD" -and $bus -match "SATA|ATA" -and $bus -notmatch "NVMe") {
                $result.HasSATASSD = $true; $classification = "&#9432; SSD SATA - Medio"; $classColor = "#ffc107"
            } elseif ($bus -match "NVMe") {
                $result.HasNVMe = $true; $classification = "&#10004; NVMe - Rapido"; $classColor = "#28a745"
            }
            if ([string]::IsNullOrEmpty($classification)) {
                if ($media -match "SSD") { $classification = "SSD (bus no identificado)"; $classColor = "#888" }
                else { $classification = "No clasificado"; $classColor = "#888" }
            }
            $htmlTable += "<tr><td>${name}</td><td>${media}</td><td>${bus}</td><td>${sizeGB} GB</td><td style='color:${healthColor}'>${health}</td><td style='color:${classColor};font-weight:bold'>${classification}</td></tr>"
            $result.Disks += @{ Name=$name; Media=$media; Bus=$bus; SizeGB=$sizeGB; Health=$health; Class=$classification }
        }
    }
    $htmlTable += "</table>"
    
    $spaceHtml = ""
    if ($logDisks) {
        $spaceHtml = "<div style='margin-top:10px'>"
        foreach ($ld in $logDisks) {
            $totalGB = [math]::Round($ld.Size / 1GB, 1)
            $freeGB = [math]::Round($ld.FreeSpace / 1GB, 1)
            $usedPct = if ($ld.Size -gt 0) { [math]::Round((($ld.Size - $ld.FreeSpace) / $ld.Size) * 100, 0) } else { 0 }
            $barColor = if ($usedPct -ge 90) { "#dc3545" } elseif ($usedPct -ge 75) { "#ffc107" } else { "#28a745" }
            if ($usedPct -ge 90) { $result.CriticalSpace = $true }
            $spaceHtml += "<div style='margin:5px 0;font-size:13px'><strong>$($ld.DeviceID)</strong> ${freeGB}GB libre de ${totalGB}GB "
            $spaceHtml += "<div style='background:#e9ecef;border-radius:4px;height:14px;width:200px;display:inline-block;vertical-align:middle'>"
            $spaceHtml += "<div style='background:${barColor};height:100%;width:${usedPct}%;border-radius:4px'></div></div>"
            $spaceHtml += " <span style='color:${barColor};font-weight:bold'>${usedPct}%</span></div>"
        }
        $spaceHtml += "</div>"
    }
    $result.HtmlSection = $htmlTable + $spaceHtml
    return $result
}

# --- 6. FUNCIÓN: UPGRADE ADVISOR ENGINE ---
function Get-UpgradeAdvisor {
    param([hashtable]$RAMData, [hashtable]$CPUData, [hashtable]$StorageData, [string]$OSCaption)
    $recommendations = @(); $overallScore = 0; $maxScore = 0
    
    # RAM
    $maxScore += 25; $ramGB = $RAMData.TotalGB
    if ($ramGB -lt 4) {
        $overallScore += 0
        if ($RAMData.AllSoldered) { $ramAction="RAM soldada. Se recomienda reemplazar el equipo por uno con minimo 8GB."; $ramCost="Equipo nuevo: desde S/1,200" }
        elseif ($RAMData.HasFreeSlots) { $ramAction="Agregar modulo en slot libre. Hay $($RAMData.SlotsLibres) slot(s) disponible(s)."; $ramCost="Modulo 8GB DDR4: S/80-120 | DDR5: S/120-180" }
        else { $ramAction="Reemplazar modulo(s) existente(s) por mayor capacidad."; $ramCost="Modulo 8GB DDR4: S/80-120 | DDR5: S/120-180" }
        $recommendations += @{ Area="RAM"; Level="CRITICO"; Color="#dc3545"; Icon="&#9888;"; Title="RAM Insuficiente (${ramGB}GB)"; Action=$ramAction; Cost=$ramCost; Impact="Con menos de 4GB el sistema se congela frecuentemente. Windows necesita minimo 4GB solo para arrancar."; Score=0 }
    } elseif ($ramGB -lt 8) {
        $overallScore += 10
        if ($RAMData.AllSoldered) { $ramAction="RAM soldada - no ampliable. Funcional pero limitado."; $ramCost="N/A (soldada)" }
        elseif ($RAMData.HasFreeSlots) { $ramAction="Agregar modulo en slot libre ($($RAMData.SlotsLibres) disponible). Objetivo: 16GB."; $ramCost="Modulo 8GB DDR4: S/80-120 | DDR5: S/120-180" }
        else { $ramAction="Reemplazar por modulos de mayor capacidad. Objetivo: 16GB."; $ramCost="Kit 2x8GB DDR4: S/150-200" }
        $recommendations += @{ Area="RAM"; Level="BAJO"; Color="#fd7e14"; Icon="&#9432;"; Title="RAM Limitada (${ramGB}GB)"; Action=$ramAction; Cost=$ramCost; Impact="Con 8GB se mejora multitarea, navegacion con muchas pestanas y apps de Office."; Score=10 }
    } else { $overallScore += 25 }
    
    if (-not $RAMData.IsDualChannel -and $ramGB -ge 8 -and -not $RAMData.AllSoldered) {
        $recommendations += @{ Area="RAM"; Level="AVISO"; Color="#ffc107"; Icon="&#9432;"; Title="RAM en Single Channel"; Action="Agregar segundo modulo identico para Dual Channel. Mejora 10-20%."; Cost="Modulo identico: S/80-180"; Impact="Dual channel mejora rendimiento en juegos, edicion y tareas graficas."; Score=0 }
    }
    
    # CPU
    $maxScore += 25
    if ($CPUData.IsBasic -or $CPUData.Generation -le 3) {
        $overallScore += 0
        if ($CPUData.IsSoldered) { $cpuAction="CPU soldado. Se recomienda reemplazar el equipo completo."; $cpuCost="Equipo i5 Gen 12+: desde S/1,500" }
        else { $cpuAction="Reemplazar por CPU compatible con socket $($CPUData.SocketType)."; $cpuCost="CPU upgrade: S/200-600" }
        $recommendations += @{ Area="CPU"; Level="CRITICO"; Color="#dc3545"; Icon="&#9888;"; Title="Procesador Obsoleto"; Action=$cpuAction; Cost=$cpuCost; Impact="CPU basico/antiguo es el mayor cuello de botella. Todo se siente lento."; Score=0 }
    } elseif ($CPUData.Generation -le 6) {
        $overallScore += 10
        if ($CPUData.IsSoldered) { $cpuAction="CPU soldado. Funcional para oficina basica, considere reemplazo a mediano plazo."; $cpuCost="Equipo nuevo recomendado a futuro" }
        else { $cpuAction="Considere upgrade a CPU de mayor generacion."; $cpuCost="CPU upgrade: S/200-500" }
        $recommendations += @{ Area="CPU"; Level="ANTIGUO"; Color="#fd7e14"; Icon="&#9432;"; Title="Procesador Antiguo ($($CPUData.GenerationLabel))"; Action=$cpuAction; Cost=$cpuCost; Impact="Generaciones antiguas carecen de instrucciones modernas y eficiencia."; Score=10 }
    } elseif ($CPUData.Generation -le 9) { $overallScore += 20 }
    else { $overallScore += 25 }
    
    # DISCO
    $maxScore += 25
    if ($StorageData.HasHDD -and -not $StorageData.HasNVMe -and -not $StorageData.HasSATASSD) {
        $overallScore += 0
        $recommendations += @{ Area="DISCO"; Level="CRITICO"; Color="#dc3545"; Icon="&#9888;"; Title="Disco Mecanico (HDD) - MUY Lento"; Action="Reemplazar HDD por SSD. Mejora con MAYOR impacto. Arrancara 5-10x mas rapido."; Cost="SSD SATA 480GB: S/80-120 | NVMe 500GB: S/100-150"; Impact="Cambiar HDD a SSD es la mejora #1. Windows arranca en 15s en vez de 2+ min."; Score=0 }
    } elseif ($StorageData.HasSATASSD -and -not $StorageData.HasNVMe) {
        $overallScore += 18
        $recommendations += @{ Area="DISCO"; Level="AVISO"; Color="#ffc107"; Icon="&#9432;"; Title="SSD SATA (velocidad media)"; Action="Considere NVMe si la placa soporta. Mejora 3-5x en transferencias."; Cost="SSD NVMe 500GB: S/100-150 | 1TB: S/180-250"; Impact="NVMe mejora tiempos de carga, compilacion y transferencias grandes."; Score=18 }
    } elseif ($StorageData.HasNVMe) { $overallScore += 25 }
    else { $overallScore += 15 }
    
    if ($StorageData.CriticalSpace) {
        $recommendations += @{ Area="DISCO"; Level="CRITICO"; Color="#dc3545"; Icon="&#9888;"; Title="Espacio en Disco Critico (>90%)"; Action="Liberar espacio o agregar disco adicional urgentemente."; Cost="Disco adicional 500GB: S/80-150"; Impact="Disco >90% causa lentitud extrema, fallos de update y posible corrupcion."; Score=0 }
    }
    
    # SO
    $maxScore += 25; $osScore = 25
    if ($OSCaption -match "Windows 10") {
        $osScore = 15
        $recommendations += @{ Area="SO"; Level="AVISO"; Color="#fd7e14"; Icon="&#9432;"; Title="Windows 10 - Fin de Soporte Oct 2025"; Action="Planificar migracion a Windows 11 si el hardware es compatible."; Cost="Licencia Win11: S/50-150 (o upgrade gratuito)"; Impact="Sin soporte = sin parches de seguridad. Riesgo de vulnerabilidades."; Score=15 }
    } elseif ($OSCaption -match "Windows 7|Windows 8") {
        $osScore = 0
        $recommendations += @{ Area="SO"; Level="CRITICO"; Color="#dc3545"; Icon="&#9888;"; Title="Sistema Operativo Obsoleto"; Action="Actualizar a Windows 10/11 urgentemente."; Cost="Licencia Windows: S/50-150"; Impact="Sistema sin parches = vulnerable a malware y ransomware."; Score=0 }
    }
    $overallScore += $osScore
    
    # SCORE GLOBAL
    $globalPct = if ($maxScore -gt 0) { [math]::Round(($overallScore / $maxScore) * 100, 0) } else { 0 }
    if ($globalPct -ge 80) { $globalLabel="BUENO"; $globalColor="#28a745"; $globalIcon="&#10004;" }
    elseif ($globalPct -ge 60) { $globalLabel="ACEPTABLE"; $globalColor="#ffc107"; $globalIcon="&#9432;" }
    elseif ($globalPct -ge 35) { $globalLabel="BAJO"; $globalColor="#fd7e14"; $globalIcon="&#9888;" }
    else { $globalLabel="CRITICO"; $globalColor="#dc3545"; $globalIcon="&#9888;" }
    
    # HTML
    $html = ""
    if ($recommendations.Count -eq 0) {
        $html = "<div style='background:#d4edda;color:#155724;padding:20px;border-radius:6px;text-align:center;font-size:16px'><strong>&#10004; EQUIPO EN BUEN ESTADO</strong><br>No se detectaron areas criticas.</div>"
    } else {
        $html += "<div style='text-align:center;margin-bottom:20px'><div style='display:inline-block;background:${globalColor};color:#fff;padding:15px 30px;border-radius:50px;font-size:20px;font-weight:bold'>${globalIcon} ESTADO GENERAL: ${globalLabel} (${globalPct}/100)</div></div>"
        $html += "<table class='info-table' style='margin-top:15px'><tr><th style='width:70px'>Area</th><th style='width:80px'>Nivel</th><th>Diagnostico</th><th>Accion Recomendada</th><th style='width:180px'>Costo Estimado</th></tr>"
        $sorted = $recommendations | Sort-Object { switch($_.Level) { 'CRITICO'{0} 'BAJO'{1} 'ANTIGUO'{2} 'AVISO'{3} default{4} } }
        foreach ($rec in $sorted) {
            $recColor = $rec.Color
            $html += "<tr><td><strong>$($rec.Area)</strong></td>"
            $html += "<td style='color:#fff;background:${recColor};padding:3px 8px;border-radius:4px;font-weight:bold;text-align:center;white-space:nowrap'>$($rec.Icon) $($rec.Level)</td>"
            $html += "<td><strong>$($rec.Title)</strong><br><span style='font-size:11px;color:#666'>$($rec.Impact)</span></td>"
            $html += "<td>$($rec.Action)</td><td style='font-size:12px'>$($rec.Cost)</td></tr>"
        }
        $html += "</table>"
    }
    return @{ HtmlSection=$html; Recommendations=$recommendations; Score=$globalPct; ScoreLabel=$globalLabel; ScoreColor=$globalColor }
}

# --- 7. FUNCIÓN: PERFIL DE RED ---
function Get-NetworkProfile {
    $result = @{ HtmlSection = ""; TextSummary = "" }
    $adapters = Get-CimInstance Win32_NetworkAdapterConfiguration -ErrorAction SilentlyContinue | Where-Object { $_.IPEnabled }
    if (-not $adapters) { $result.HtmlSection = "<pre>Sin adaptadores de red activos.</pre>"; return $result }
    $htmlTable = "<table class='info-table'><tr><th>Adaptador</th><th>IP</th><th>MAC</th><th>Gateway</th><th>DNS</th></tr>"
    $textNet = ""
    foreach ($a in $adapters) {
        $desc = if ($a.Description) { $a.Description } else { "Desconocido" }
        $ip = if ($a.IPAddress) { ($a.IPAddress | Select-Object -First 1) } else { "N/A" }
        $mac = if ($a.MACAddress) { $a.MACAddress } else { "N/A" }
        $gw = if ($a.DefaultIPGateway) { ($a.DefaultIPGateway | Select-Object -First 1) } else { "N/A" }
        $dns = if ($a.DNSServerSearchOrder) { ($a.DNSServerSearchOrder -join ", ") } else { "N/A" }
        $htmlTable += "<tr><td>${desc}</td><td>${ip}</td><td style='font-family:Consolas;font-size:11px'>${mac}</td><td>${gw}</td><td style='font-size:11px'>${dns}</td></tr>"
        $textNet += "${desc} | IP: ${ip} | MAC: ${mac}`n"
    }
    $htmlTable += "</table>"; $result.HtmlSection = $htmlTable; $result.TextSummary = $textNet
    return $result
}

# =================================================================================
# BUCLE PRINCIPAL
# =================================================================================
do {
    $continuar = $false
    try {
        Dibujar-Header
        $pc = $env:COMPUTERNAME
        Escribir-Centrado "DETECTADO: $pc" "Gray"
        Write-Host "`n"
        $pad = [math]::Max(0, [math]::Floor(($Host.UI.RawUI.WindowSize.Width - 10) / 2))
        
        Escribir-Centrado "1. Ingrese Numero de PC" "White"
        Write-Host (" " * $pad) -NoNewline
        $numPC = Read-Host 
        if ([string]::IsNullOrWhiteSpace($numPC)) { $numPC = "0" }
        
        Write-Host ""
        Escribir-Centrado "2. Ingrese Alias/Area" "White"
        Write-Host (" " * $pad) -NoNewline
        $aliasPC = Read-Host 
        if ([string]::IsNullOrWhiteSpace($aliasPC)) { $aliasPC = "General" }
        $aliasPC = $aliasPC -replace '[\\/:*?"<>|]', ''

        Write-Host "`n"
        Escribir-Centrado "3. SELECCIONE TIPO DE INFORME:" "Cyan"
        Escribir-Centrado "[1] Informe Simplificado (Nativo Windows - Rapido)" "Gray"
        Escribir-Centrado "[2] Informe Detallado    (Motor CPU-Z - Tecnico)" "White"
        Write-Host "`n"
        Write-Host (" " * $pad) -NoNewline
        $selMode = Read-Host 
        if ([string]::IsNullOrWhiteSpace($selMode)) { $selMode = "1" }
        
        $root = [Environment]::GetFolderPath("Desktop"); $apps = Join-Path $root "Apps"
        $repoRoot = Join-Path $root "REPORTES_PC"
        if (!(Test-Path $repoRoot)) { New-Item -ItemType Directory -Path $repoRoot | Out-Null }

        $nombreBase = "${numPC}. Resultados_${pc}_${aliasPC}"
        $dir = Join-Path $repoRoot $nombreBase
        if (Test-Path $dir) {
            Write-Host ""; Escribir-Centrado "AVISO: La carpeta '$nombreBase' ya existe." "Yellow"
            Escribir-Centrado "[S] Sobreescribir  [R] Renombrar con timestamp  [C] Cancelar" "White"
            Write-Host (" " * $pad) -NoNewline; $opDup = Read-Host
            switch ($opDup.ToUpper()) { "R" { $ts=Get-Date -Format "HHmm"; $nombreBase="${numPC}. Resultados_${pc}_${aliasPC}_${ts}"; $dir=Join-Path $repoRoot $nombreBase } "C" { continue } default { } }
        }
        Escribir-Centrado "Creando carpeta: ${nombreBase}..." "DarkGray"
        if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
        $htmlFile = Join-Path $dir "${nombreBase}.html"

        # ===================== DIAGNÓSTICO =====================

        Write-Host "`n"; Escribir-Centrado "1. Analizando Sistema..." "Cyan"
        $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
        $cs = Get-CimInstance Win32_ComputerSystem -ErrorAction Stop
        $proc = Get-CimInstance Win32_Processor -ErrorAction Stop
        $csproduct = Get-CimInstance Win32_ComputerSystemProduct -ErrorAction SilentlyContinue
        $ramSticks = Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue
        $ramTotal=0; $ramDetalleStr="N/A"
        if ($ramSticks) { $ramTotal=[math]::Round(($ramSticks|Measure-Object Capacity -Sum).Sum/1GB,2); $ramDetalleStr=($ramSticks|ForEach-Object{"$([math]::Round($_.Capacity/1GB,0))GB"}) -join " + " }
        $modeloExacto = if ($csproduct -and $csproduct.Name) { $csproduct.Name } else { "N/A" }
        $txtSys = "Alias: ${aliasPC}`nOS: $($os.Caption) ($($os.OSArchitecture))`nEquipo: $($cs.Manufacturer) $($cs.Model)`nModelo Exacto: ${modeloExacto}`nCPU: $($proc.Name)`nRAM TOTAL: ${ramTotal} GB (${ramDetalleStr})`nPowerShell: $($PSVersionTable.PSVersion)"

        # --- 2. HARDWARE ---
        $htmlHardware = ""
        if ($selMode -eq "2") {
            Escribir-Centrado "   Buscando CPU-Z (Modo Detallado)..." "Magenta"
            $exeCpuz = Get-ChildItem -Path $apps -Filter "cpuz_x64.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
            if (!$exeCpuz) { $exeCpuz = Get-ChildItem -Path $apps -Filter "cpuz_x32.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 }
            if ($exeCpuz) {
                Escribir-Centrado "   > ENCONTRADO: $($exeCpuz.Name)" "Green"
                Escribir-Centrado "2. Extrayendo Hardware (Motor CPU-Z)..." "Cyan"
                $tempReportPath = Join-Path $env:TEMP "cpuz_report_$(Get-Date -Format 'HHmmss')"
                $arg = "-txt=${tempReportPath}"
                $cpuzOk = Start-ProcessWithTimeout -FilePath $exeCpuz.FullName -Arguments $arg -TimeoutSeconds 30 -WindowStyle "Normal"
                $reportFile = "${tempReportPath}.txt"
                if ($cpuzOk -and (Test-Path $reportFile)) {
                    try { $lines = Get-Content $reportFile -ErrorAction Stop } catch { $lines = Get-Content $reportFile -Encoding Default }
                    $cleanText=""; $currentSection=""; $startLog=$false; $isStorageSection=$false; $isGraphicsSection=$false
                    $keywords = @("Number of cores","Number of threads","Manufacturer","Name","Codename","Specification","Package","CPUID","Extended CPUID","Technology","Core Speed","Multiplier x Bus Speed","Temperature","Northbridge","Southbridge","Bus Specification","Graphic Interface","PCI-E Link Width","PCI-E Link Speed","Memory Type","Memory Size","Module Size","Size","Channels","Memory Frequency","DIMM #","SMBus address","Module format","Max bandwidth","Part number","Serial number","Manufacturing date","Nominal Voltage","Revision","Capacity","Type","Bus Type","Rotation speed","Features","Controller","Link Speed","Volume","Display adapter","Board Manufacturer","Cores","ROP Units","Memory size","Current Link Width","Current Link Speed")
                    foreach ($line in $lines) {
                        if ($line -match "^Processors Information") { $startLog=$true; $isStorageSection=$false; $isGraphicsSection=$false; $currentSection="`n<span class='categoria-resaltada'>Procesador</span>`n-------------------------------------------------------------------------"; $cleanText+=$currentSection+"`n"; continue }
                        if (-not $startLog) { continue }
                        if ($line -match "^Chipset") { $isStorageSection=$false; $isGraphicsSection=$false; $currentSection="`n<span class='categoria-resaltada'>Placa Base</span>`n-------------------------------------------------------------------------"; $cleanText+=$currentSection+"`n"; continue }
                        if ($line -match "^Memory SPD") { $isStorageSection=$false; $isGraphicsSection=$false; $currentSection="`n<span class='categoria-resaltada'>Memoria RAM (Detalle)</span>`n-------------------------------------------------------------------------"; $cleanText+=$currentSection+"`n"; continue }
                        if ($line -match "^Storage") { $isStorageSection=$true; $isGraphicsSection=$false; $currentSection="`n<span class='categoria-resaltada'>Almacenamiento</span>`n-------------------------------------------------------------------------"; $cleanText+=$currentSection+"`n"; continue }
                        if ($line -match "^Graphics") { $isStorageSection=$false; $isGraphicsSection=$true; $currentSection="`n<span class='categoria-resaltada'>Tarjeta Grafica</span>`n-------------------------------------------------------------------------"; $cleanText+=$currentSection+"`n"; continue }
                        if ($line -match "^(Software|DMI|Monitoring|LPCIO|PCI Devices|USB Devices)") { $currentSection="IGNORE"; continue }
                        if ($currentSection -eq "IGNORE") { continue }
                        if ($line -match "0x[0-9A-F]{8}") { continue }
                        foreach ($key in $keywords) {
                            if ($line -match "$key\s+" -or $line -match "^\s*$key") {
                                $checkValue=$line.Replace($key,"").Trim()
                                if ([string]::IsNullOrWhiteSpace($checkValue) -or $checkValue -eq ":" -or $checkValue -eq "=") { continue }
                                if ($key -eq "CPUID" -and $checkValue -match "^0x") { continue }
                                if ($isStorageSection -and $line -match "^\s*Name") { $cleanText+="`n   --- [ Disco Detectado ] ---`n" }
                                if ($isGraphicsSection -and $line -match "^\s*Display adapter") { $cleanText+="`n   --- [ Grafica Detectada ] ---`n" }
                                # FIX TEMPERATURA: Color por nivel térmico
                                if ($key -eq "Temperature" -and $line -match "(\d+)\s*degC") {
                                    $tempVal = [int]$matches[1]
                                    $tempColor = if ($tempVal -ge 85) { "#dc3545" } elseif ($tempVal -ge 70) { "#ff8c00" } else { "#28a745" }
                                    $tempLabel = if ($tempVal -ge 85) { " [CRITICO]" } elseif ($tempVal -ge 70) { " [CALIENTE]" } else { "" }
                                    $cleanText += "<span style='color:${tempColor};font-weight:bold'>${line}${tempLabel}</span>`n"
                                } else {
                                    $cleanText += $line + "`n"
                                }
                                break
                            }
                        }
                    }
                    $cleanText=$cleanText -replace "`n{3,}","`n`n"
                    $htmlHardware="<h2>2. Inventario Detallado (CPU-Z)</h2><pre>${cleanText}</pre>"
                    Remove-Item $reportFile -ErrorAction SilentlyContinue
                }
            }
        } else { Escribir-Centrado "2. Extrayendo Hardware (Modo Simplificado Nativo)..." "Cyan" }
        
        if ([string]::IsNullOrEmpty($htmlHardware)) {
            function Fmt-Line ($titulo, $valor) { return "<span class='categoria-resaltada'>${titulo}:</span> ${valor}`n" }
            $inv=""
            $bb=Get-CimInstance Win32_BaseBoard -ErrorAction SilentlyContinue; $bios=Get-CimInstance Win32_BIOS -ErrorAction SilentlyContinue
            $bbProduct=if($bb -and $bb.Product){$bb.Product}else{"N/A"}; $bbManuf=if($bb -and $bb.Manufacturer){$bb.Manufacturer}else{"N/A"}
            $bbSerial=if($bb -and $bb.SerialNumber){$bb.SerialNumber}else{"N/A"}; $biosSN=if($bios -and $bios.SerialNumber){$bios.SerialNumber}else{"N/A"}
            $biosVer=if($bios -and $bios.SMBIOSBIOSVersion){$bios.SMBIOSBIOSVersion}else{"N/A"}; $biosDate=if($bios -and $bios.ReleaseDate){$bios.ReleaseDate}else{"N/A"}
            $inv += Fmt-Line "Equipo" "$($cs.Manufacturer) $($cs.Model)"; $inv += Fmt-Line "Serie (SN)" $biosSN
            $inv += Fmt-Line "Placa Base" "${bbProduct} (Fab: ${bbManuf})"; $inv += Fmt-Line "Serie Placa" $bbSerial
            $inv += Fmt-Line "BIOS" "${biosVer} (${biosDate})"; $inv += "`n"
            $inv += Fmt-Line "Procesador" "$($proc.Name)"
            $socket=if($proc.SocketDesignation){$proc.SocketDesignation}else{"N/A"}; $inv += Fmt-Line "Socket CPU" $socket; $inv += "`n"
            $memS=Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue
            if($memS){$mi=1;foreach($m in $memS){$cap=[math]::Round($m.Capacity/1GB,0);$manuf=if($m.Manufacturer){$m.Manufacturer}else{"N/A"};$spd=if($m.Speed){$m.Speed}else{0};$inv+=Fmt-Line "RAM DIMM${mi}" "${cap}GB - ${manuf} @ ${spd}MHz";$mi++}};$inv+="`n"
            $dks=Get-CimInstance Win32_DiskDrive -ErrorAction SilentlyContinue|Where-Object{$_.MediaType -ne 'Removable Media'}
            if($dks){foreach($d in $dks){$sz=if($d.Size){[math]::Round($d.Size/1GB,1)}else{0};$dm=if($d.Model){$d.Model}else{"N/A"};$inv+=Fmt-Line "Disco" "${dm} (${sz} GB)"}}
            $htmlHardware="<h2>2. Inventario Simplificado</h2><pre>${inv}</pre>"
        }

        # --- 3-9: Resto del diagnóstico ---
        Escribir-Centrado "3. CPU Upgrade Check..." "Cyan"
        $cpuInfo = Get-CPUUpgradeInfo
        $htmlCPU = "<h2>3. Estado del Procesador</h2>" + $cpuInfo.HtmlSection
        $cpuColor = if ($cpuInfo.IsSoldered) { "Red" } else { "Green" }
        Write-Host "    $($cpuInfo.Summary)" -ForegroundColor $cpuColor

        Escribir-Centrado "4. Diagnostico RAM..." "Cyan"
        $ramDiag = Get-RAMDiagnostic
        $htmlRAM = "<h2>4. Diagnostico de Memoria RAM</h2>" + $ramDiag.HtmlSection
        Write-Host "    Slots: $($ramDiag.SlotsUsed)/$($ramDiag.SlotsTotal) | Total: $($ramDiag.TotalGB)GB | Canal: $(if($ramDiag.IsDualChannel){'Dual'}else{'Single'})" -ForegroundColor Gray
        if ($ramDiag.SolderedWarning) { Write-Host "    $($ramDiag.SolderedWarning)" -ForegroundColor Yellow }

        Escribir-Centrado "5. Analisis de Almacenamiento..." "Cyan"
        $storageData = Get-StorageAnalysis
        $htmlStorage = "<h2>5. Almacenamiento</h2>" + $storageData.HtmlSection
        foreach ($dk in $storageData.Disks) { Write-Host "    $($dk.Name): $($dk.Class)" -ForegroundColor Gray }

        Escribir-Centrado "6. Perfil de Red..." "Cyan"
        $netProfile = Get-NetworkProfile
        $htmlNet = "<h2>6. Perfil de Red</h2>" + $netProfile.HtmlSection

        Escribir-Centrado "7. Eventos Criticos..." "Cyan"
        $htmlBsod = "<h2>7. Registro de Eventos Criticos</h2><pre>Sin errores recientes.</pre>"
        $exeBsod = Join-Path $apps "BlueScreenView.exe"; $tmpBsod = Join-Path $root "temp_bsod.txt"
        if (Test-Path $exeBsod) {
            $bsodOk = Start-ProcessWithTimeout -FilePath $exeBsod -Arguments "/stext `"${tmpBsod}`"" -TimeoutSeconds 15
            if ($bsodOk -and (Test-Path $tmpBsod)) { $c=Get-Content $tmpBsod -Raw -ErrorAction SilentlyContinue; if($c -and $c.Length -gt 10){$safeC=[System.Net.WebUtility]::HtmlEncode($c);$htmlBsod="<h2>7. Registro de Eventos Criticos</h2><pre>${safeC}</pre>"}; Remove-Item $tmpBsod -ErrorAction SilentlyContinue }
        }

        Escribir-Centrado "8. Auditando Bateria..." "Cyan"
        $htmlBat=""; $exeBatView=Join-Path $apps "BatteryInfoView.exe"
        $designCap=0;$fullCap=0;$cycleCount=0;$chemistry="N/A";$voltage="N/A";$manufactureName="N/A"
        if (Test-Path $exeBatView) {
            $tmpBatInfo=Join-Path $root "temp_bat_info.txt"
            $batOk=Start-ProcessWithTimeout -FilePath $exeBatView -Arguments "/stext `"${tmpBatInfo}`"" -TimeoutSeconds 15
            if($batOk -and (Test-Path $tmpBatInfo)){try{$linesBat=$null;foreach($enc in @("Unicode","UTF8","Default")){try{$linesBat=Get-Content $tmpBatInfo -Encoding $enc -ErrorAction Stop;if($linesBat -and $linesBat.Count -gt 3){break}}catch{$linesBat=$null}};if($linesBat){foreach($l in $linesBat){if($l -match "Designed Capacity\s+:\s+([0-9]+)"){$designCap=[int64]$matches[1]};if($l -match "Full Charged Capacity\s+:\s+([0-9]+)"){$fullCap=[int64]$matches[1]};if($l -match "Number of charge/discharge cycles\s+:\s+([0-9]+)"){$cycleCount=[int]$matches[1]};if($l -match "Battery Manufacturer\s+:\s+(.*)"){$manufactureName=$matches[1].Trim()};if($l -match "Chemistry\s+:\s+(.*)"){$chemistry=$matches[1].Trim()};if($l -match "Voltage\s+:\s+(.*)"){$voltage=$matches[1].Trim()}}}}catch{};Remove-Item $tmpBatInfo -ErrorAction SilentlyContinue}
        }
        if($designCap -eq 0){$tmpBatXML=Join-Path $root "temp_battery_report.xml";Start-ProcessWithTimeout -FilePath "powercfg" -Arguments "/batteryreport /output `"${tmpBatXML}`" /xml" -TimeoutSeconds 15|Out-Null;if(Test-Path $tmpBatXML){try{[xml]$xmlBat=Get-Content $tmpBatXML -ErrorAction Stop;$batInfo=$xmlBat.BatteryReport.Batteries.Battery;if($batInfo.DesignCapacity){$designCap=[int64]$batInfo.DesignCapacity};if($batInfo.FullChargeCapacity){$fullCap=[int64]$batInfo.FullChargeCapacity};if($batInfo.CycleCount){$cycleCount=[int]$batInfo.CycleCount}}catch{};Remove-Item $tmpBatXML -ErrorAction SilentlyContinue}}
        if($designCap -gt 0){
            $healthPct=($fullCap/$designCap)*100;$saludStr="{0:N1}%" -f $healthPct
            if($healthPct -lt 50){$saludColor="#d9534f"}elseif($healthPct -lt 80){$saludColor="#f0ad4e"}else{$saludColor="#5cb85c"}
            $notaFraude=""
            if($healthPct -ge 98 -and $cycleCount -eq 0){$saludColor="#FF8C00";$saludStr+=" (?)";$notaFraude="<div style='background:#fff3cd;color:#856404;padding:10px;border:1px solid #ffeeba;border-radius:4px;margin-top:10px;font-size:12px'><strong>&#9888; ALERTA:</strong> Salud 100% con 0 ciclos es inusual. Verificar con prueba de descarga.</div>"}
            $wmiBat=Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue;$batStatus="Desconocido";$batPercent="0%"
            if($wmiBat){$batStatus=switch($wmiBat.BatteryStatus){1{"Descargando"}2{"Cargando"}3{"Cargado 100%"}4{"Bajo"}5{"Critico"}default{"En uso"}};$batPercent="$($wmiBat.EstimatedChargeRemaining)%"}
            $htmlBat="<h2>8. Analisis de Energia</h2><table class='info-table'><tr><th>Estado</th><td>${batStatus} (${batPercent})</td></tr><tr><th>Salud</th><td style='color:${saludColor};font-weight:bold'>${saludStr}</td></tr><tr><th>Ciclos</th><td>${cycleCount}</td></tr><tr><th>Capacidad</th><td>${designCap} / ${fullCap} mWh</td></tr><tr><th>Fabricante</th><td>${manufactureName} / ${chemistry}</td></tr></table>${notaFraude}"
        } else { $htmlBat="<h2>8. Analisis de Energia</h2><pre>No se detecto bateria (PC de Escritorio).</pre>" }

        # --- 9. UPGRADE ADVISOR ---
        Escribir-Centrado "9. Generando Recomendaciones de Upgrade..." "Magenta"
        $upgradeResult = Get-UpgradeAdvisor -RAMData $ramDiag -CPUData $cpuInfo -StorageData $storageData -OSCaption $os.Caption
        $htmlUpgrade = "<h2 style='background:#FF5500'>9. &#9889; RECOMENDACIONES DE UPGRADE - ATLAS ADVISOR</h2>" + $upgradeResult.HtmlSection
        $scoreCol = switch ($upgradeResult.ScoreLabel) { "CRITICO"{"Red"} "BAJO"{"Red"} "ACEPTABLE"{"Yellow"} default{"Green"} }
        Write-Host ""; Write-Host "    ========================================" -ForegroundColor $scoreCol
        Write-Host "    SCORE: $($upgradeResult.Score)/100 - $($upgradeResult.ScoreLabel)" -ForegroundColor $scoreCol
        Write-Host "    ========================================" -ForegroundColor $scoreCol
        if ($upgradeResult.Recommendations.Count -gt 0) { foreach ($rec in $upgradeResult.Recommendations) { $rcCol=switch($rec.Level){"CRITICO"{"Red"}"BAJO"{"Red"}default{"Yellow"}}; Write-Host "    [$($rec.Level)] $($rec.Title)" -ForegroundColor $rcCol } }
        else { Write-Host "    Sin recomendaciones - equipo en buen estado." -ForegroundColor Green }

        # --- 10. HTML ---
        Escribir-Centrado "10. Generando Reporte HTML..." "Green"
        $fechaReporte=Get-Date -Format 'dd/MM/yyyy HH:mm'; $yearReporte=Get-Date -Format 'yyyy'
        $css = @"
    <style>
        body{font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;background:#f4f4f9;color:#333;margin:0;padding:20px}
        .container{max-width:960px;margin:0 auto;background:#fff;box-shadow:0 0 15px rgba(0,0,0,.1);border-radius:8px;overflow:hidden}
        .header{background:#002147;color:#fff;padding:20px;text-align:center;border-bottom:5px solid #FF5500}
        .header h1{margin:0;font-size:28px;letter-spacing:3px;color:#FF5500;font-weight:800}
        .header p{margin:5px 0 0;color:#FFF;font-weight:bold;font-size:14px;letter-spacing:1px}
        .info-box{padding:20px;background:#f9f9f9;border-bottom:1px solid #eee;display:flex;justify-content:space-between;flex-wrap:wrap;gap:10px}
        .info-item strong{color:#555}
        .content-area{padding:20px}
        h2{background:#002147;color:white;padding:8px 15px;border-radius:4px;font-size:16px;margin-top:30px;margin-bottom:10px}
        pre{background:#fcfcfc;border:1px solid #e0e0e0;border-left:5px solid #FF5500;padding:15px;border-radius:4px;overflow-x:hidden;font-family:Consolas,monospace;font-size:11px;white-space:pre-wrap;word-wrap:break-word;color:#444}
        .info-table{width:100%;border-collapse:collapse;margin-top:10px;background:white;font-size:13px}
        .info-table th{background:#002147;color:white;text-align:left;padding:10px 15px}
        .info-table td{border-bottom:1px solid #ddd;padding:10px 15px}
        .info-table tr:nth-child(even){background:#f8f9fa}
        .categoria-resaltada{display:inline-block;font-weight:700;color:#002147;background:#eef6fc;padding:3px 8px;border-radius:4px;margin-bottom:5px;border-left:3px solid #002147}
        .footer{padding:20px;text-align:center;font-size:12px;color:#777;background:#fafafa;border-top:1px solid #eee}
    </style>
"@
        $html = @"
    <!DOCTYPE html><html lang="es"><head><meta charset="UTF-8">
    <title>Informe Tecnico - ATLAS PC SUPPORT - ${aliasPC}</title>${css}</head><body>
    <div class="container">
        <div class="header"><h1>ATLAS PC SUPPORT</h1><p>REPORTE DE DIAGNOSTICO TECNICO</p></div>
        <div class="info-box">
            <div class="info-item"><strong>Cliente/Alias:</strong> ${aliasPC}</div>
            <div class="info-item"><strong>Equipo:</strong> ${pc}</div>
            <div class="info-item"><strong>Fecha:</strong> ${fechaReporte}</div>
        </div>
        <div class="content-area">
            <h2>1. Resumen de Sistema</h2><pre>${txtSys}</pre>
            ${htmlHardware}
            ${htmlCPU}
            ${htmlRAM}
            ${htmlStorage}
            ${htmlNet}
            ${htmlBsod}
            ${htmlBat}
            ${htmlUpgrade}
        </div>
        <div class="footer">
            <p>Este informe fue generado automaticamente por ATLAS PC SUPPORT v82</p>
            <p>ATLAS PC SUPPORT &copy; ${yearReporte} - Huanuco, Peru</p>
        </div>
    </div></body></html>
"@
        $html | Out-File -FilePath $htmlFile -Encoding UTF8
        Write-Host "`n"; Escribir-Centrado "LISTO: ${htmlFile}" "Green"
        Invoke-Item $dir
        

        Write-Host "`n"; Escribir-Centrado "Presione [ESPACIO] para volver al menu o cualquier otra tecla para salir..." "Cyan"
        $key=$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        if($key.VirtualKeyCode -eq 32){$continuar=$true}else{$continuar=$false}
        
    } catch { 
        Write-Host "Error Fatal: $($_.Exception.Message)" -ForegroundColor Red 
        Write-Host "Linea: $($_.InvocationInfo.ScriptLineNumber)" -ForegroundColor DarkGray
        Read-Host "Presiona Enter para salir..."; $continuar=$false
    }
} while ($continuar)
}
