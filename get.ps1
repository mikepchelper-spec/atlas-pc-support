# ============================================================
# Atlas PC Support - get.ps1
# Downloads the launcher to a temp file and runs it with -File.
# Save locally and run:  pwsh -ExecutionPolicy Bypass -File get.ps1
# ============================================================

$ErrorActionPreference = 'Stop'

$launcherUrl  = 'https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1'

# Keep launcher at a stable path so ToolRunner can read its AST at runtime.
$atlasDir     = Join-Path $env:LOCALAPPDATA 'AtlasPC'
if (-not (Test-Path $atlasDir)) { New-Item -ItemType Directory -Path $atlasDir -Force | Out-Null }
$launcherPath = Join-Path $atlasDir 'launcher.ps1'

Write-Host '  [>] Downloading Atlas PC Support...' -ForegroundColor Cyan
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri ($launcherUrl + '?v=' + [guid]::NewGuid().ToString('N')) `
    -OutFile $launcherPath -UseBasicParsing -TimeoutSec 60 -ErrorAction Stop

# PS 5.1 reads BOM-less .ps1 files as ANSI when invoked with -File,
# which mojibakes UTF-8 accents and emojis. Prepend BOM if absent.
$bytes = [System.IO.File]::ReadAllBytes($launcherPath)
if ($bytes.Length -lt 3 -or $bytes[0] -ne 0xEF -or $bytes[1] -ne 0xBB -or $bytes[2] -ne 0xBF) {
    $bom = [byte[]](0xEF, 0xBB, 0xBF)
    $withBom = New-Object byte[] ($bom.Length + $bytes.Length)
    [System.Buffer]::BlockCopy($bom, 0, $withBom, 0, $bom.Length)
    [System.Buffer]::BlockCopy($bytes, 0, $withBom, $bom.Length, $bytes.Length)
    [System.IO.File]::WriteAllBytes($launcherPath, $withBom)
}

Write-Host '  [OK] Launching...' -ForegroundColor Green
& powershell.exe -NoProfile -ExecutionPolicy Bypass -Sta -File $launcherPath
