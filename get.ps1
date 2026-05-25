# ============================================================
# Atlas PC Support - get.ps1
# Downloads the launcher to a temp file and runs it with -File.
# Save locally and run:  pwsh -ExecutionPolicy Bypass -File get.ps1
# ============================================================

$ErrorActionPreference = 'Stop'

$launcherUrl  = 'https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1'
$launcherShaUrl = 'https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1.sha256'

# Keep launcher at a stable path so ToolRunner can read its AST at runtime.
$atlasDir     = Join-Path $env:LOCALAPPDATA 'AtlasPC'
if (-not (Test-Path $atlasDir)) { New-Item -ItemType Directory -Path $atlasDir -Force | Out-Null }
$launcherPath = Join-Path $atlasDir 'launcher.ps1'
$launcherTempPath = "$launcherPath.download"
if (Test-Path -LiteralPath $launcherTempPath) {
    Remove-Item -LiteralPath $launcherTempPath -Force -ErrorAction SilentlyContinue
}

Write-Host '  [>] Downloading Atlas PC Support...' -ForegroundColor Cyan
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri ($launcherUrl + '?v=' + [guid]::NewGuid().ToString('N')) `
    -OutFile $launcherTempPath -UseBasicParsing -TimeoutSec 60 -ErrorAction Stop

Write-Host '  [>] Verifying launcher integrity (SHA-256)...' -ForegroundColor Cyan
$shaRaw = (Invoke-WebRequest -Uri ($launcherShaUrl + '?v=' + [guid]::NewGuid().ToString('N')) `
    -UseBasicParsing -TimeoutSec 30 -ErrorAction Stop).Content
$expectedHash = (($shaRaw -split '\s+') | Where-Object { $_ } | Select-Object -First 1).ToLowerInvariant()
if (-not $expectedHash -or $expectedHash -notmatch '^[a-f0-9]{64}$') {
    throw "Invalid checksum metadata from server."
}
$actualHash = (Get-FileHash -LiteralPath $launcherTempPath -Algorithm SHA256 -ErrorAction Stop).Hash.ToLowerInvariant()
if ($actualHash -ne $expectedHash) {
    Remove-Item -LiteralPath $launcherTempPath -Force -ErrorAction SilentlyContinue
    throw "Integrity check failed. Expected SHA256=$expectedHash, got $actualHash."
}
Move-Item -LiteralPath $launcherTempPath -Destination $launcherPath -Force
Unblock-File -LiteralPath $launcherPath -ErrorAction SilentlyContinue
Write-Host "  [OK] SHA-256: $actualHash" -ForegroundColor Green

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
& powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Sta -File $launcherPath
