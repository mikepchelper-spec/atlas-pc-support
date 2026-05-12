#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Valida que cada tool en el launcher parsea correctamente via AST.

.DESCRIPTION
    Usa el parser de PS para encontrar cada funcion Invoke-* en launcher.ps1
    y verifica que el AST puede extraerla correctamente.

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

$errs = $null
$ast = [System.Management.Automation.Language.Parser]::ParseFile($LauncherPath, [ref]$null, [ref]$errs)
if ($errs -and $errs.Count -gt 0) {
    Write-Host "FAIL: launcher.ps1 tiene $($errs.Count) errores de parse:" -ForegroundColor Red
    foreach ($e in ($errs | Select-Object -First 10)) {
        Write-Host ("  line {0} col {1}: {2}" -f $e.Extent.StartLineNumber, $e.Extent.StartColumnNumber, $e.Message) -ForegroundColor Red
    }
    exit 1
}

$funcDefs = $ast.FindAll({
    param($node)
    $node -is [System.Management.Automation.Language.FunctionDefinitionAst] -and
    $node.Name -like 'Invoke-*'
}, $false)

if ($funcDefs.Count -eq 0) {
    Write-Host "FAIL: No se encontraron funciones Invoke-* en el launcher." -ForegroundColor Red
    exit 1
}

Write-Host "Encontradas $($funcDefs.Count) funciones Invoke-* en launcher" -ForegroundColor Cyan

$allText = [System.IO.File]::ReadAllText($LauncherPath, [System.Text.UTF8Encoding]::new($false))
$fail = 0

foreach ($fn in ($funcDefs | Sort-Object { $_.Name })) {
    $name = $fn.Name
    try {
        $src = $allText.Substring($fn.Extent.StartOffset, $fn.Extent.EndOffset - $fn.Extent.StartOffset)
        if ($src.Length -lt 10) {
            Write-Host "[FAIL] $name : source demasiado corta ($($src.Length) chars)" -ForegroundColor Red
            $fail++
        } else {
            Write-Host "[OK]   $name ($($src.Length) chars)" -ForegroundColor Green
        }
    } catch {
        Write-Host "[FAIL] $name : $_" -ForegroundColor Red
        $fail++
    }
}

if ($fail -gt 0) {
    Write-Host ""
    Write-Host "=== $fail tools con errores ===" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "TODAS las tools pasan el check AST." -ForegroundColor Green
exit 0
