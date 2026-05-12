# ============================================================
# Atlas PC Support - get.ps1
#
# Safe launcher bootstrap: downloads launcher.ps1 to disk and
# runs it with -File so AMSI never sees irm|iex.
#
# Usage (PowerShell as Administrator):
#   irm https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/get.ps1 | iex
#
# Or save this file locally and run:
#   pwsh -ExecutionPolicy Bypass -File get.ps1
# ============================================================

$ErrorActionPreference = 'Stop'

$launcherUrl  = 'https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1'
$launcherPath = Join-Path $env:TEMP "atlas-launcher-$([guid]::NewGuid().ToString('N').Substring(0,8)).ps1"

try {
    Write-Host '  [>] Downloading Atlas PC Support...' -ForegroundColor Cyan
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri ($launcherUrl + '?v=' + [guid]::NewGuid().ToString('N')) `
        -OutFile $launcherPath -UseBasicParsing -TimeoutSec 60 -ErrorAction Stop

    # Strip UTF-8 BOM if present (some proxies/CDNs inject it)
    $bytes = [System.IO.File]::ReadAllBytes($launcherPath)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        [System.IO.File]::WriteAllBytes($launcherPath, $bytes[3..($bytes.Length - 1)])
    }

    Write-Host '  [OK] Launching panel...' -ForegroundColor Green
    & $PSHOME\powershell.exe -NoProfile -ExecutionPolicy Bypass -Sta -File $launcherPath
} finally {
    Remove-Item $launcherPath -ErrorAction SilentlyContinue
}
