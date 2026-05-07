function Invoke-AIReadiness {
    [CmdletBinding()]
    param()

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

    $T = @{
        en = @{
            HdrTitle     = 'A T L A S   P C   S U P P O R T'
            HdrSub       = 'AI Readiness Assessment'
            AskClient    = 'Client name (e.g. Demo Corp)'
            AskConsult   = 'Consultant name (e.g. Atlas PC Support)'
            Running      = 'Running audit — this may take 20-30 seconds...'
            Done         = 'Done. Report saved to:'
            ReportOpened = 'Report opened in browser.'
            ErrNoScript  = 'ERROR: AI-Readiness.ps1 not found at expected path:'
            ErrFailed    = 'ERROR: Audit failed.'
            PressKey     = 'Press any key to exit...'
        }
        es = @{
            HdrTitle     = 'A T L A S   P C   S U P P O R T'
            HdrSub       = 'Auditoria de Aptitud para IA'
            AskClient    = 'Nombre del cliente (ej: Empresa SAC)'
            AskConsult   = 'Nombre consultora (ej: Atlas PC Support)'
            Running      = 'Ejecutando auditoria — puede tomar 20-30 segundos...'
            Done         = 'Listo. Reporte guardado en:'
            ReportOpened = 'Reporte abierto en el navegador.'
            ErrNoScript  = 'ERROR: AI-Readiness.ps1 no encontrado en:'
            ErrFailed    = 'ERROR: La auditoria fallo.'
            PressKey     = 'Presiona cualquier tecla para salir...'
        }
    }

    $lang = _Atlas-DetectLang
    $L = if ($T.ContainsKey($lang)) { $T[$lang] } else { $T['en'] }

    $esc = [char]0x1B

    function Write-Header {
        Clear-Host
        Write-Host "`n  $esc[38;5;208m$($L.HdrTitle)$esc[0m" -NoNewline
        Write-Host "  |  $($L.HdrSub)`n"
        Write-Host "  $esc[90m$('─' * 54)$esc[0m`n"
    }

    Write-Header

    # Locate AI-Readiness.ps1 — search relative to launcher location first,
    # then next to the running script, then on the Desktop.
    $searchPaths = @(
        (Join-Path $PSScriptRoot              'ai-readiness-audit\AI-Readiness.ps1'),
        (Join-Path $PSScriptRoot              'AI-Readiness.ps1'),
        (Join-Path $env:USERPROFILE           'Desktop\BEDROCK\ai-readiness-audit\AI-Readiness.ps1'),
        (Join-Path $env:USERPROFILE           'Desktop\ai-readiness-audit\AI-Readiness.ps1')
    )

    $auditScript = $null
    foreach ($p in $searchPaths) {
        if (Test-Path -LiteralPath $p) { $auditScript = $p; break }
    }

    if (-not $auditScript) {
        Write-Host "  $esc[31m$($L.ErrNoScript)$esc[0m" -ForegroundColor Red
        foreach ($p in $searchPaths) { Write-Host "    $p" }
        Write-Host ''
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        return
    }

    $clientName = Read-Host "  $($L.AskClient)"
    if ([string]::IsNullOrWhiteSpace($clientName)) { $clientName = 'Cliente Demo' }

    $consultName = Read-Host "  $($L.AskConsult)"
    if ([string]::IsNullOrWhiteSpace($consultName)) { $consultName = 'Atlas PC Support' }

    $outDir = Join-Path (Split-Path $auditScript) 'INFORMES'

    Write-Host ''
    Write-Host "  $esc[33m$($L.Running)$esc[0m"
    Write-Host ''

    try {
        & powershell.exe -ExecutionPolicy Bypass -NoProfile -File $auditScript `
            -Language $lang.ToUpper() `
            -ClientName $clientName `
            -ConsultantName $consultName `
            -OutDir $outDir `
            -NoOpen

        $safeClient = ($clientName -replace '[\\/:*?"<>|]', '_').Trim()
        if ([string]::IsNullOrWhiteSpace($safeClient)) { $safeClient = 'SinNombre' }
        $reportPath = Join-Path $outDir "$safeClient\report.html"

        if (Test-Path -LiteralPath $reportPath) {
            Write-Host "  $esc[32m$($L.Done)$esc[0m"
            Write-Host "  $esc[90m$reportPath$esc[0m`n"
            Start-Process $reportPath
            Write-Host "  $($L.ReportOpened)`n"
        } else {
            Write-Host "  $esc[31m$($L.ErrFailed)$esc[0m`n"
        }
    } catch {
        Write-Host "  $esc[31m$($L.ErrFailed) $_$esc[0m`n"
    }

    Write-Host "  $($L.PressKey)"
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}
