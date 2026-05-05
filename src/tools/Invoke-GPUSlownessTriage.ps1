function Invoke-GPUSlownessTriage {
    <#
    .SYNOPSIS
      GPU Slowness Triage: safe read-only check for signs that a slow PC may
      have GPU/driver instability instead of a problem maintenance can fix.
    #>

    [CmdletBinding()]
    param()

    $ErrorActionPreference = 'Stop'

    function _Atlas-DetectLang {
        if ($env:ATLAS_LANG) { return [string]$env:ATLAS_LANG }
        try {
            $cfg = Join-Path $env:LOCALAPPDATA 'AtlasPC\config.json'
            if (Test-Path -LiteralPath $cfg) {
                $obj = Get-Content -Raw -LiteralPath $cfg -Encoding UTF8 | ConvertFrom-Json
                if ($obj.language) { return [string]$obj.language }
            }
        } catch {}
        try {
            if ((Get-Culture).TwoLetterISOLanguageName -eq 'es') { return 'es' }
        } catch {}
        return 'en'
    }

    $T = @{
        en = @{
            Title         = 'GPU Slowness Triage'
            Subtitle      = 'Read-only check for GPU / display-driver instability'
            Intro1        = 'Purpose: avoid promising a cleanup/reinstall when the evidence points to a dying GPU or unstable display driver.'
            Intro2        = 'Safe mode: no FurMark, no stress test, no system changes.'
            AskClient     = 'Client / alias (optional)'
            AskTech       = 'Technician (optional)'
            StepGpu       = '1. Reading GPU inventory...'
            StepDx        = '2. Running dxdiag snapshot...'
            StepEvents    = '3. Reading display/WHEA/TDR events...'
            StepRel       = '4. Reading Reliability Monitor signals...'
            StepNvidia    = '5. Checking nvidia-smi if available...'
            StepReport    = '6. Generating report...'
            Done          = 'Done.'
            HtmlSaved     = 'HTML report: {0}'
            JsonSaved     = 'JSON result: {0}'
            OpenAsk       = 'Open HTML report now? [Y/N]'
            EnterExit     = 'Press Enter to exit...'
            VerdictApto   = 'APTO'
            VerdictObs    = 'OBSERVATION'
            VerdictRisk   = 'GPU/DRIVER RISK'
            AdviceApto    = 'No strong GPU/driver failure signal was found. It is reasonable to continue with normal maintenance, while still checking SSD/RAM/CPU/software.'
            AdviceObs     = 'Moderate GPU/driver signals were found. Explain to the customer that maintenance may help, but there is no guarantee.'
            AdviceRisk    = 'Do not promise that thermal paste or a Windows reinstall will fix the slowness. Validate GPU/driver/hardware first and protect customer data.'
            NoFindings    = 'No strong GPU/driver red flags found.'
            Limitations   = 'Limitations: this is a triage report, not a definitive lab diagnosis. Safe mode does not stress the GPU and may not capture intermittent thermal failures.'
            HtmlTitle     = 'ATLAS PC SUPPORT - GPU Slowness Triage'
            HtmlLang      = 'en'
            FieldComputer = 'Computer'
            FieldDate     = 'Date'
            FieldClient   = 'Client'
            FieldTech     = 'Technician'
            FieldVerdict  = 'Verdict'
            FieldScore    = 'Risk score'
            FieldAdvice   = 'Recommendation'
            SectionGpu    = 'GPU inventory'
            SectionSignals= 'Risk signals'
            SectionEvents = 'Relevant events'
            SectionDx     = 'dxdiag summary'
            SectionNvidia = 'NVIDIA sensors'
            SeverityHigh  = 'High'
            SeverityMed   = 'Medium'
            SeverityLow   = 'Low'
        }
        es = @{
            Title         = 'Triaje de Lentitud por GPU'
            Subtitle      = 'Chequeo solo-lectura de inestabilidad GPU / driver de video'
            Intro1        = 'Objetivo: evitar prometer limpieza/reinstalacion cuando la evidencia apunta a GPU moribunda o driver de video inestable.'
            Intro2        = 'Modo seguro: sin FurMark, sin stress test, sin cambios al sistema.'
            AskClient     = 'Cliente / alias (opcional)'
            AskTech       = 'Tecnico (opcional)'
            StepGpu       = '1. Leyendo inventario GPU...'
            StepDx        = '2. Ejecutando snapshot dxdiag...'
            StepEvents    = '3. Leyendo eventos Display/WHEA/TDR...'
            StepRel       = '4. Leyendo senales de Monitor de confiabilidad...'
            StepNvidia    = '5. Revisando nvidia-smi si existe...'
            StepReport    = '6. Generando reporte...'
            Done          = 'Listo.'
            HtmlSaved     = 'Reporte HTML: {0}'
            JsonSaved     = 'Resultado JSON: {0}'
            OpenAsk       = 'Abrir reporte HTML ahora? [S/N]'
            EnterExit     = 'Pulsa Enter para salir...'
            VerdictApto   = 'APTO'
            VerdictObs    = 'OBSERVACION'
            VerdictRisk   = 'RIESGO GPU/DRIVER'
            AdviceApto    = 'No se encontraron senales fuertes de fallo GPU/driver. Es razonable seguir con mantenimiento normal, revisando tambien SSD/RAM/CPU/software.'
            AdviceObs     = 'Se encontraron senales moderadas de GPU/driver. Avisa al cliente que el mantenimiento puede ayudar, pero sin garantia.'
            AdviceRisk    = 'No prometas que pasta termica o reinstalar Windows va a resolver la lentitud. Valida GPU/driver/hardware primero y protege los datos del cliente.'
            NoFindings    = 'No se encontraron alertas fuertes de GPU/driver.'
            Limitations   = 'Limitaciones: esto es triaje, no diagnostico definitivo de laboratorio. El modo seguro no estresa la GPU y puede no capturar fallos termicos intermitentes.'
            HtmlTitle     = 'ATLAS PC SUPPORT - Triaje de Lentitud por GPU'
            HtmlLang      = 'es'
            FieldComputer = 'Equipo'
            FieldDate     = 'Fecha'
            FieldClient   = 'Cliente'
            FieldTech     = 'Tecnico'
            FieldVerdict  = 'Veredicto'
            FieldScore    = 'Puntaje de riesgo'
            FieldAdvice   = 'Recomendacion'
            SectionGpu    = 'Inventario GPU'
            SectionSignals= 'Senales de riesgo'
            SectionEvents = 'Eventos relevantes'
            SectionDx     = 'Resumen dxdiag'
            SectionNvidia = 'Sensores NVIDIA'
            SeverityHigh  = 'Alta'
            SeverityMed   = 'Media'
            SeverityLow   = 'Baja'
        }
    }

    $lang = _Atlas-DetectLang
    if (-not $T.ContainsKey($lang)) { $lang = 'en' }
    $L = $T[$lang]

    function Write-Info([string]$Text) { Write-Host "  $Text" -ForegroundColor Cyan }
    function Write-Ok([string]$Text) { Write-Host "  $Text" -ForegroundColor Green }
    function Write-WarnLine([string]$Text) { Write-Host "  $Text" -ForegroundColor Yellow }
    function HtmlEnc([object]$Value) {
        if ($null -eq $Value) { return '' }
        return [System.Net.WebUtility]::HtmlEncode([string]$Value)
    }
    function To-Display([object]$Value) {
        if ($null -eq $Value -or [string]::IsNullOrWhiteSpace([string]$Value)) { return '-' }
        return [string]$Value
    }
    function Convert-DriverDate([object]$Value) {
        if ($null -eq $Value) { return $null }
        try {
            if ($Value -is [datetime]) { return $Value }
            $s = [string]$Value
            if ($s -match '^\d{14}\.') {
                return [System.Management.ManagementDateTimeConverter]::ToDateTime($s)
            }
            return [datetime]::Parse($s)
        } catch {
            return $null
        }
    }
    function Add-Finding {
        param(
            [System.Collections.ArrayList]$List,
            [int]$Points,
            [string]$Severity,
            [string]$Signal,
            [string]$Evidence,
            [string]$Recommendation
        )
        [void]$List.Add([pscustomobject]@{
            Points = $Points
            Severity = $Severity
            Signal = $Signal
            Evidence = $Evidence
            Recommendation = $Recommendation
        })
    }
    function Get-DesktopPath {
        try {
            $desktop = [Environment]::GetFolderPath('Desktop')
            if (-not [string]::IsNullOrWhiteSpace($desktop)) { return $desktop }
        } catch {}
        if ($env:USERPROFILE) { return $env:USERPROFILE }
        return $env:TEMP
    }

    function Get-GpuInventory {
        $items = @()
        try {
            $items = @(Get-CimInstance Win32_VideoController -ErrorAction Stop | ForEach-Object {
                $driverDate = Convert-DriverDate $_.DriverDate
                $adapterGb = $null
                try {
                    if ($_.AdapterRAM -and [double]$_.AdapterRAM -gt 0) {
                        $adapterGb = [math]::Round(([double]$_.AdapterRAM / 1GB), 2)
                    }
                } catch {}
                [pscustomobject]@{
                    Name = $_.Name
                    DriverVersion = $_.DriverVersion
                    DriverDate = $driverDate
                    DriverDateText = if ($driverDate) { $driverDate.ToString('yyyy-MM-dd') } else { [string]$_.DriverDate }
                    AdapterRAMGB = $adapterGb
                    VideoProcessor = $_.VideoProcessor
                    PNPDeviceID = $_.PNPDeviceID
                    Status = $_.Status
                    ConfigManagerErrorCode = $_.ConfigManagerErrorCode
                }
            })
        } catch {
            $items = @([pscustomobject]@{
                Name = 'Unable to read Win32_VideoController'
                DriverVersion = ''
                DriverDate = $null
                DriverDateText = ''
                AdapterRAMGB = $null
                VideoProcessor = ''
                PNPDeviceID = ''
                Status = ''
                ConfigManagerErrorCode = $null
            })
        }
        return $items
    }

    function Invoke-DxDiagSnapshot {
        param([string]$OutFile)
        $summary = [ordered]@{
            Available = $false
            Problems = @()
            DisplayLines = @()
            RawPath = $OutFile
        }
        try {
            $dx = Get-Command dxdiag.exe -ErrorAction SilentlyContinue
            if (-not $dx) { return [pscustomobject]$summary }
            $summary.Available = $true
            Start-Process -FilePath $dx.Source -ArgumentList "/whql:off /t `"$OutFile`"" -Wait -WindowStyle Hidden
            if (Test-Path -LiteralPath $OutFile) {
                $lines = @(Get-Content -LiteralPath $OutFile -ErrorAction Stop)
                $summary.DisplayLines = @($lines | Where-Object {
                    $_ -match 'Card name:|Manufacturer:|Chip type:|Display Memory:|Dedicated Memory:|Driver Version:|Driver Date/Size:|DDI Version:|Feature Levels:|Problem:|No problems found'
                } | Select-Object -First 80)
                $problemLines = @($lines | Where-Object { $_ -match 'Problem:' -and $_ -notmatch 'No problems found' })
                $summary.Problems = $problemLines
            }
        } catch {
            $summary.Problems = @("dxdiag error: $($_.Exception.Message)")
        }
        return [pscustomobject]$summary
    }

    function Get-TargetedEvents {
        param([datetime]$Since)
        $events = New-Object System.Collections.ArrayList

        $systemProviders = @(
            'Display',
            'nvlddmkm',
            'amdkmdag',
            'amdwddmg',
            'igfx',
            'igfxn',
            'dxgkrnl',
            'Microsoft-Windows-DxgKrnl',
            'Microsoft-Windows-WHEA-Logger'
        )

        foreach ($provider in $systemProviders) {
            try {
                $found = @(Get-WinEvent -FilterHashtable @{ LogName = 'System'; ProviderName = $provider; StartTime = $Since } -ErrorAction Stop)
                foreach ($ev in $found) { [void]$events.Add($ev) }
            } catch {}
        }

        foreach ($id in 4101, 14, 13, 117, 141, 144, 1001) {
            try {
                $found = @(Get-WinEvent -FilterHashtable @{ LogName = 'System'; Id = $id; StartTime = $Since } -ErrorAction Stop | Where-Object {
                    $_.ProviderName -match 'Display|nvlddmkm|amdkmdag|amdwddmg|igfx|dxg|WHEA|BugCheck'
                })
                foreach ($ev in $found) { [void]$events.Add($ev) }
            } catch {}
        }

        try {
            $wer = @(Get-WinEvent -FilterHashtable @{ LogName = 'Application'; Id = 1001; StartTime = $Since } -ErrorAction Stop | Where-Object {
                $_.ProviderName -match 'Windows Error Reporting' -and $_.Message -match 'LiveKernelEvent|117|141|144|VIDEO_TDR|Display|graphics|hardware error'
            })
            foreach ($ev in $wer) { [void]$events.Add($ev) }
        } catch {}

        $unique = @($events | Sort-Object LogName, ProviderName, Id, TimeCreated, RecordId -Unique | Sort-Object TimeCreated -Descending)
        return $unique
    }

    function Get-ReliabilitySignals {
        param([datetime]$Since)
        try {
            return @(Get-CimInstance Win32_ReliabilityRecords -ErrorAction Stop | Where-Object {
                try { ([datetime]$_.TimeGenerated) -ge $Since } catch { $true }
            } | Where-Object {
                "$($_.SourceName) $($_.ProductName) $($_.Message)" -match 'LiveKernelEvent|VIDEO_TDR|Display|graphics|GPU|hardware error|117|141|144'
            } | Select-Object -First 50)
        } catch {
            return @()
        }
    }

    function Get-LiveKernelReportFiles {
        param([datetime]$Since)
        $roots = @(
            "$env:SystemRoot\LiveKernelReports",
            "$env:SystemRoot\Minidump"
        )
        $files = @()
        foreach ($root in $roots) {
            if (-not $root -or -not (Test-Path -LiteralPath $root)) { continue }
            try {
                $files += @(Get-ChildItem -LiteralPath $root -Recurse -File -ErrorAction SilentlyContinue | Where-Object {
                    $_.LastWriteTime -ge $Since -and ($_.FullName -match 'WATCHDOG|WHEA|VIDEO|GRAPHICS|GPU|\.dmp$')
                } | Select-Object FullName, LastWriteTime, Length)
            } catch {}
        }
        return @($files | Sort-Object LastWriteTime -Descending)
    }

    function Get-NvidiaSmiSignals {
        $data = [ordered]@{
            Available = $false
            Rows = @()
            Errors = @()
        }
        try {
            $cmd = Get-Command nvidia-smi -ErrorAction SilentlyContinue
            if (-not $cmd) { return [pscustomobject]$data }
            $data.Available = $true
            $query = 'name,driver_version,temperature.gpu,utilization.gpu,memory.used,memory.total,retired_pages.pending,retired_pages.double_bit'
            $lines = @(& $cmd.Source "--query-gpu=$query" '--format=csv,noheader,nounits' 2>$null)
            foreach ($line in $lines) {
                $parts = @($line -split ',\s*')
                if ($parts.Count -lt 6) { continue }
                $data.Rows += [pscustomobject]@{
                    Name = $parts[0]
                    DriverVersion = $parts[1]
                    TemperatureC = [int]($parts[2] -replace '[^\d-]', '')
                    UtilizationPercent = [int]($parts[3] -replace '[^\d-]', '')
                    MemoryUsedMB = [int]($parts[4] -replace '[^\d-]', '')
                    MemoryTotalMB = [int]($parts[5] -replace '[^\d-]', '')
                    RetiredPagesPending = if ($parts.Count -gt 6) { $parts[6] } else { '' }
                    RetiredPagesDoubleBit = if ($parts.Count -gt 7) { $parts[7] } else { '' }
                }
            }
        } catch {
            $data.Errors += $_.Exception.Message
        }
        return [pscustomobject]$data
    }

    function Get-Verdict {
        param([int]$Score)
        if ($Score -ge 70) {
            return [pscustomobject]@{ Level = $L.VerdictRisk; Css = 'risk'; Advice = $L.AdviceRisk }
        }
        if ($Score -ge 40) {
            return [pscustomobject]@{ Level = $L.VerdictObs; Css = 'obs'; Advice = $L.AdviceObs }
        }
        return [pscustomobject]@{ Level = $L.VerdictApto; Css = 'ok'; Advice = $L.AdviceApto }
    }

    function New-GpuTriageHtml {
        param([hashtable]$Data)

        $findingRows = if ($Data.Findings.Count -gt 0) {
            ($Data.Findings | ForEach-Object {
                "<tr><td>$(HtmlEnc $_.Severity)</td><td>$(HtmlEnc $_.Signal)</td><td>$(HtmlEnc $_.Evidence)</td><td>$(HtmlEnc $_.Recommendation)</td><td>$($_.Points)</td></tr>"
            }) -join "`n"
        } else {
            "<tr><td colspan='5'>$(HtmlEnc $L.NoFindings)</td></tr>"
        }

        $gpuRows = ($Data.Gpus | ForEach-Object {
            "<tr><td>$(HtmlEnc $_.Name)</td><td>$(HtmlEnc $_.DriverVersion)</td><td>$(HtmlEnc $_.DriverDateText)</td><td>$(HtmlEnc $_.AdapterRAMGB)</td><td>$(HtmlEnc $_.Status)</td><td>$(HtmlEnc $_.ConfigManagerErrorCode)</td></tr>"
        }) -join "`n"

        $eventRows = if ($Data.Events.Count -gt 0) {
            ($Data.Events | Select-Object -First 30 | ForEach-Object {
                $msg = ([string]$_.Message) -replace '\s+', ' '
                if ($msg.Length -gt 240) { $msg = $msg.Substring(0, 240) + '...' }
                "<tr><td>$(HtmlEnc $_.TimeCreated)</td><td>$(HtmlEnc $_.ProviderName)</td><td>$(HtmlEnc $_.Id)</td><td>$(HtmlEnc $_.LevelDisplayName)</td><td>$(HtmlEnc $msg)</td></tr>"
            }) -join "`n"
        } else {
            "<tr><td colspan='5'>-</td></tr>"
        }

        $dxRows = if ($Data.DxDiag.DisplayLines.Count -gt 0) {
            ($Data.DxDiag.DisplayLines | ForEach-Object { "<li>$(HtmlEnc $_)</li>" }) -join "`n"
        } else {
            '<li>-</li>'
        }

        $nvidiaRows = if ($Data.Nvidia.Rows.Count -gt 0) {
            ($Data.Nvidia.Rows | ForEach-Object {
                "<tr><td>$(HtmlEnc $_.Name)</td><td>$(HtmlEnc $_.TemperatureC)</td><td>$(HtmlEnc $_.UtilizationPercent)</td><td>$(HtmlEnc $_.MemoryUsedMB)/$(HtmlEnc $_.MemoryTotalMB)</td><td>$(HtmlEnc $_.RetiredPagesPending)</td><td>$(HtmlEnc $_.RetiredPagesDoubleBit)</td></tr>"
            }) -join "`n"
        } else {
            "<tr><td colspan='6'>nvidia-smi: $(if ($Data.Nvidia.Available) { 'no data' } else { 'not available' })</td></tr>"
        }

@"
<!doctype html>
<html lang="$($L.HtmlLang)">
<head>
<meta charset="utf-8"/>
<title>$(HtmlEnc $L.HtmlTitle)</title>
<style>
body{font-family:Segoe UI,Arial,sans-serif;margin:24px;color:#1f2937}
h1{margin-bottom:4px}.muted{color:#6b7280}.card{border:1px solid #d1d5db;border-radius:12px;padding:14px;margin:12px 0}
.badge{display:inline-block;border-radius:999px;padding:6px 12px;font-weight:700}
.ok{background:#dcfce7;color:#166534}.obs{background:#fef3c7;color:#92400e}.risk{background:#fee2e2;color:#991b1b}
table{border-collapse:collapse;width:100%;margin-top:8px}th,td{border:1px solid #e5e7eb;padding:7px;font-size:13px;vertical-align:top}th{background:#f9fafb;text-align:left}
code{background:#f3f4f6;padding:1px 4px;border-radius:4px}
</style>
</head>
<body>
<h1>$(HtmlEnc $L.Title)</h1>
<p class="muted">$(HtmlEnc $L.Subtitle)</p>
<p class="muted">$(HtmlEnc $L.FieldComputer): $(HtmlEnc $Data.Computer) | $(HtmlEnc $L.FieldDate): $(HtmlEnc $Data.Date) | $(HtmlEnc $L.FieldClient): $(HtmlEnc $Data.Client) | $(HtmlEnc $L.FieldTech): $(HtmlEnc $Data.Tech)</p>

<div class="card">
<h2>$(HtmlEnc $L.FieldVerdict)</h2>
<p><span class="badge $($Data.Verdict.Css)">$(HtmlEnc $Data.Verdict.Level)</span></p>
<p><b>$(HtmlEnc $L.FieldScore):</b> $($Data.Score)/100</p>
<p><b>$(HtmlEnc $L.FieldAdvice):</b> $(HtmlEnc $Data.Verdict.Advice)</p>
<p class="muted">$(HtmlEnc $L.Limitations)</p>
</div>

<div class="card">
<h2>$(HtmlEnc $L.SectionSignals)</h2>
<table><tr><th>Severity</th><th>Signal</th><th>Evidence</th><th>Recommendation</th><th>Points</th></tr>
$findingRows
</table>
</div>

<div class="card">
<h2>$(HtmlEnc $L.SectionGpu)</h2>
<table><tr><th>Name</th><th>Driver</th><th>Driver date</th><th>VRAM GB</th><th>Status</th><th>PNP code</th></tr>
$gpuRows
</table>
</div>

<div class="card">
<h2>$(HtmlEnc $L.SectionEvents)</h2>
<table><tr><th>Time</th><th>Provider</th><th>ID</th><th>Level</th><th>Message</th></tr>
$eventRows
</table>
</div>

<div class="card">
<h2>$(HtmlEnc $L.SectionDx)</h2>
<ul>$dxRows</ul>
<p class="muted">Raw dxdiag: <code>$(HtmlEnc $Data.DxDiag.RawPath)</code></p>
</div>

<div class="card">
<h2>$(HtmlEnc $L.SectionNvidia)</h2>
<table><tr><th>Name</th><th>Temp C</th><th>Util %</th><th>Memory MB</th><th>Retired pending</th><th>Retired double-bit</th></tr>
$nvidiaRows
</table>
</div>
</body></html>
"@
    }

    Clear-Host
    Write-Host '================================================================' -ForegroundColor DarkCyan
    Write-Host "  $($L.Title)" -ForegroundColor Cyan
    Write-Host '================================================================' -ForegroundColor DarkCyan
    Write-Host "  $($L.Intro1)"
    Write-Host "  $($L.Intro2)" -ForegroundColor Yellow
    Write-Host ''

    $client = Read-Host "  $($L.AskClient)"
    $tech = Read-Host "  $($L.AskTech)"
    if ([string]::IsNullOrWhiteSpace($client)) { $client = '-' }
    if ([string]::IsNullOrWhiteSpace($tech)) { $tech = '-' }

    $baseDir = Join-Path (Get-DesktopPath) ("Atlas_GPU_Triage_{0}" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
    New-Item -ItemType Directory -Path $baseDir -Force | Out-Null
    $dxPath = Join-Path $baseDir 'dxdiag.txt'
    $jsonPath = Join-Path $baseDir 'gpu_triage_result.json'
    $htmlPath = Join-Path $baseDir 'gpu_triage_report.html'
    $since = (Get-Date).AddDays(-30)
    $findings = New-Object System.Collections.ArrayList

    Write-Info $L.StepGpu
    $gpus = @(Get-GpuInventory)
    foreach ($gpu in $gpus) {
        if ([string]$gpu.Name -match 'Microsoft Basic Display|Basic Render|Basic Video') {
            Add-Finding $findings 25 $L.SeverityMed 'Basic display driver' $gpu.Name 'Install or repair the vendor GPU driver before promising performance work.'
        }
        if ($null -ne $gpu.ConfigManagerErrorCode -and [int]$gpu.ConfigManagerErrorCode -ne 0) {
            Add-Finding $findings 35 $L.SeverityHigh 'GPU device error' "ConfigManagerErrorCode=$($gpu.ConfigManagerErrorCode) on $($gpu.Name)" 'Fix device/driver state before maintenance promises.'
        }
        if ($gpu.DriverDate) {
            $ageDays = ((Get-Date) - $gpu.DriverDate).TotalDays
            if ($ageDays -ge 1460) {
                Add-Finding $findings 18 $L.SeverityMed 'Very old GPU driver' "$($gpu.Name) driver date $($gpu.DriverDateText)" 'Update or clean-install GPU driver, then retest.'
            } elseif ($ageDays -ge 730) {
                Add-Finding $findings 10 $L.SeverityLow 'Old GPU driver' "$($gpu.Name) driver date $($gpu.DriverDateText)" 'Consider driver update before OS reinstall.'
            }
        }
    }

    Write-Info $L.StepDx
    $dx = Invoke-DxDiagSnapshot -OutFile $dxPath
    if ($dx.Problems.Count -gt 0) {
        Add-Finding $findings 25 $L.SeverityMed 'dxdiag display problem' (($dx.Problems | Select-Object -First 3) -join ' | ') 'Resolve DirectX/display driver problems before promising cleanup results.'
    }

    Write-Info $L.StepEvents
    $events = @(Get-TargetedEvents -Since $since)
    $tdrEvents = @($events | Where-Object { $_.Id -in 4101, 117, 141, 144 -or $_.Message -match 'TDR|LiveKernelEvent|VIDEO_TDR|Display driver stopped responding' })
    $driverEvents = @($events | Where-Object { $_.ProviderName -match 'nvlddmkm|amdkmdag|amdwddmg|igfx|dxg' })
    $wheaEvents = @($events | Where-Object { $_.ProviderName -match 'WHEA' })
    $bugCheckTdr = @($events | Where-Object { $_.Message -match '0x00000116|0x00000117|VIDEO_TDR_FAILURE|VIDEO_SCHEDULER_INTERNAL_ERROR' })

    if ($tdrEvents.Count -ge 3) {
        Add-Finding $findings 35 $L.SeverityHigh 'Repeated TDR/LiveKernelEvent' "$($tdrEvents.Count) TDR-like events in last 30 days" 'Treat as GPU/driver instability until proven otherwise.'
    } elseif ($tdrEvents.Count -gt 0) {
        Add-Finding $findings 20 $L.SeverityMed 'TDR/LiveKernelEvent seen' "$($tdrEvents.Count) TDR-like event(s) in last 30 days" 'Warn customer and retest after driver/thermal checks.'
    }
    if ($driverEvents.Count -ge 5) {
        Add-Finding $findings 20 $L.SeverityMed 'Repeated display driver events' "$($driverEvents.Count) vendor/dxg display events" 'Review GPU driver and hardware stability.'
    }
    if ($wheaEvents.Count -ge 3) {
        Add-Finding $findings 30 $L.SeverityHigh 'Repeated WHEA hardware events' "$($wheaEvents.Count) WHEA events" 'Do not treat as simple software slowness; validate hardware.'
    } elseif ($wheaEvents.Count -gt 0) {
        Add-Finding $findings 18 $L.SeverityMed 'WHEA hardware event' "$($wheaEvents.Count) WHEA event(s)" 'Investigate hardware path before promising maintenance.'
    }
    if ($bugCheckTdr.Count -gt 0) {
        Add-Finding $findings 40 $L.SeverityHigh 'Video bugcheck signature' "$($bugCheckTdr.Count) video bugcheck/TDR signature(s)" 'Prioritize GPU/driver diagnosis over cleanup/reinstall promises.'
    }

    Write-Info $L.StepRel
    $reliability = @(Get-ReliabilitySignals -Since $since)
    if ($reliability.Count -gt 0) {
        Add-Finding $findings 20 $L.SeverityMed 'Reliability Monitor GPU signals' "$($reliability.Count) relevant reliability record(s)" 'Use Reliability Monitor details to explain risk to customer.'
    }
    $lkFiles = @(Get-LiveKernelReportFiles -Since $since)
    if ($lkFiles.Count -gt 0) {
        Add-Finding $findings 25 $L.SeverityMed 'Recent LiveKernel/minidump files' "$($lkFiles.Count) dump file(s) under LiveKernelReports/Minidump" 'Inspect dumps or treat as instability evidence before normal maintenance promises.'
    }

    Write-Info $L.StepNvidia
    $nvidia = Get-NvidiaSmiSignals
    foreach ($row in @($nvidia.Rows)) {
        if ($row.TemperatureC -ge 90) {
            Add-Finding $findings 25 $L.SeverityMed 'High NVIDIA temperature now' "$($row.Name): $($row.TemperatureC) C" 'Check cooling before promising software maintenance.'
        } elseif ($row.TemperatureC -ge 84) {
            Add-Finding $findings 12 $L.SeverityLow 'Warm NVIDIA temperature now' "$($row.Name): $($row.TemperatureC) C" 'Consider cleaning/cooling verification.'
        }
        if ("$($row.RetiredPagesPending) $($row.RetiredPagesDoubleBit)" -match '[1-9]') {
            Add-Finding $findings 35 $L.SeverityHigh 'NVIDIA retired page warning' "$($row.Name): pending=$($row.RetiredPagesPending), double-bit=$($row.RetiredPagesDoubleBit)" 'Possible VRAM/GPU hardware issue; do not promise maintenance fix.'
        }
    }

    $score = [int](($findings | Measure-Object -Property Points -Sum).Sum)
    if ($score -gt 100) { $score = 100 }
    $verdict = Get-Verdict -Score $score

    Write-Info $L.StepReport
    $data = @{
        Computer = $env:COMPUTERNAME
        Date = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
        Client = $client
        Tech = $tech
        Score = $score
        Verdict = $verdict
        Findings = @($findings)
        Gpus = $gpus
        Events = $events
        Reliability = $reliability
        LiveKernelFiles = $lkFiles
        DxDiag = $dx
        Nvidia = $nvidia
    }

    $jsonSafe = $data.Clone()
    $jsonSafe.Events = @($events | Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, LogName, Message)
    $jsonSafe.Reliability = @($reliability | Select-Object TimeGenerated, SourceName, ProductName, Message)
    $jsonSafe | ConvertTo-Json -Depth 8 | Out-File -FilePath $jsonPath -Encoding UTF8
    New-GpuTriageHtml -Data $data | Out-File -FilePath $htmlPath -Encoding UTF8

    Write-Host ''
    if ($verdict.Css -eq 'risk') {
        Write-WarnLine "$($L.FieldVerdict): $($verdict.Level) ($score/100)"
    } elseif ($verdict.Css -eq 'obs') {
        Write-WarnLine "$($L.FieldVerdict): $($verdict.Level) ($score/100)"
    } else {
        Write-Ok "$($L.FieldVerdict): $($verdict.Level) ($score/100)"
    }
    Write-Host "  $($verdict.Advice)"
    Write-Host ''
    Write-Ok ($L.HtmlSaved -f $htmlPath)
    Write-Ok ($L.JsonSaved -f $jsonPath)

    $open = Read-Host "  $($L.OpenAsk)"
    if ($open -match '^[SsYy]') {
        try { Start-Process -FilePath $htmlPath | Out-Null } catch {}
    }
    Write-Host ''
    Read-Host "  $($L.EnterExit)" | Out-Null
}
