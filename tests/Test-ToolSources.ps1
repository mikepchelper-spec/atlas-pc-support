#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Valida que cada tool embebida en launcher.ps1 parsea sin errores.

.DESCRIPTION
    Recupera los sources crudos (base64) del launcher compilado,
    los embebe en el template que usa ToolRunner y valida sintaxis
    con [System.Management.Automation.Language.Parser]::ParseFile.

    Exit code 0 = todo OK, 1 = hubo errores.
#>
[CmdletBinding()]
param(
    [string]$LauncherPath = (Join-Path $PSScriptRoot '..' 'launcher.ps1')
)

$ErrorActionPreference = 'Stop'
if (-not (Test-Path $LauncherPath)) {
    throw "No existe launcher en: $LauncherPath"
}

$launcherText = Get-Content -Raw -Path $LauncherPath
$pattern = "(?m)^\`$script:AtlasToolSources\['([^']+)'\] = '([^']+)'$"
$matches = [regex]::Matches($launcherText, $pattern)

if ($matches.Count -eq 0) {
    throw "No se encontraron entradas de `$script:AtlasToolSources en el launcher."
}

Write-Host "Encontradas $($matches.Count) tool sources en launcher" -ForegroundColor Cyan

$fail = 0
foreach ($m in $matches) {
    $fn  = $m.Groups[1].Value
    $b64 = $m.Groups[2].Value

    try {
        $bytes = [Convert]::FromBase64String($b64)
        $raw   = [System.Text.Encoding]::UTF8.GetString($bytes)
    } catch {
        Write-Host "[FAIL] $fn : base64 no decodifica ($($_.Exception.Message))" -ForegroundColor Red
        $fail++; continue
    }

    $temp = [System.IO.Path]::GetTempFileName() + '.ps1'
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine('$ErrorActionPreference = ''Continue''')
    [void]$sb.AppendLine($raw)
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine('try {')
    [void]$sb.AppendLine("    $fn")
    [void]$sb.AppendLine('} catch {')
    [void]$sb.AppendLine("    Write-Host ('[!] Error en $fn : ' + `$_.Exception.Message) -ForegroundColor Red")
    [void]$sb.AppendLine('    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray')
    [void]$sb.AppendLine('}')
    [System.IO.File]::WriteAllText($temp, $sb.ToString(), [System.Text.UTF8Encoding]::new($false))

    $errs = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile($temp, [ref]$null, [ref]$errs)
    if ($errs -and $errs.Count -gt 0) {
        Write-Host "[FAIL] $fn ($($errs.Count) parse errors):" -ForegroundColor Red
        foreach ($e in ($errs | Select-Object -First 5)) {
            Write-Host ("  line {0} col {1}: {2}" -f $e.Extent.StartLineNumber, $e.Extent.StartColumnNumber, $e.Message) -ForegroundColor Red
        }
        Write-Host "  [temp: $temp]" -ForegroundColor DarkGray
        $fail++
    } else {
        Write-Host "[OK]   $fn ($($raw.Length) chars)" -ForegroundColor Green
        Remove-Item $temp -ErrorAction SilentlyContinue
    }
}

if ($fail -gt 0) {
    Write-Host ""
    Write-Host "=== $fail tools con errores de parse ===" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "TODAS las tools pasan parse check." -ForegroundColor Green
exit 0
