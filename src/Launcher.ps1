# ============================================================
# Atlas PC Support — Launcher (DEV / modo código fuente)
# Para desarrollo local. Carga módulos desde src/.
# El launcher.ps1 de distribución (en raíz del repo) se genera
# con build.ps1 y tiene todo embebido para `irm | iex`.
# ============================================================

#Requires -Version 5.1

$ErrorActionPreference = 'Stop'

# --- Descubrir rutas ---
if ($PSScriptRoot) {
    $script:AtlasRoot = Split-Path -Parent $PSScriptRoot
    $script:AtlasSrc  = $PSScriptRoot
} else {
    $script:AtlasRoot = (Get-Location).Path
    $script:AtlasSrc  = Join-Path $script:AtlasRoot 'src'
}

# --- Cargar librerías base ---
. (Join-Path $script:AtlasSrc 'lib\Branding.ps1')
. (Join-Path $script:AtlasSrc 'lib\Strings.ps1')
. (Join-Path $script:AtlasSrc 'lib\Admin.ps1')
. (Join-Path $script:AtlasSrc 'lib\Logging.ps1')
. (Join-Path $script:AtlasSrc 'lib\Dependencies.ps1')
. (Join-Path $script:AtlasSrc 'lib\PS7.ps1')
. (Join-Path $script:AtlasSrc 'lib\ToolRunner.ps1')

# --- Cargar todas las tools ---
$toolsDir = Join-Path $script:AtlasSrc 'tools'
Get-ChildItem -Path $toolsDir -Filter 'Invoke-*.ps1' | ForEach-Object { . $_.FullName }

# --- Cargar branding + manifiesto ---
$branding = Get-AtlasBranding
$currentLang = Set-AtlasLanguage $branding.language
Initialize-AtlasLog | Out-Null
Write-AtlasLog "Atlas PC Support iniciado ($($branding.brand.name) v$($branding.brand.version), lang=$currentLang)"

# Detectar PS 7 y cachear la ruta (ToolRunner la usa para lanzar tools en pwsh).
$ps7 = Initialize-AtlasPS7
if ($ps7) {
    Write-AtlasLog "PowerShell 7 disponible: $ps7"
} else {
    Write-AtlasLog "PowerShell 7 NO instalado; tools correran en Windows PowerShell 5.1. Recomendado: usar tool 'Actualizar PowerShell'."
}

$toolsManifestPath = Join-Path $script:AtlasRoot 'config\tools.json'
$manifest = Get-Content -Raw $toolsManifestPath | ConvertFrom-Json -AsHashtable
$tools = @($manifest.tools)

# --- Cargar XAML GUI ---
. (Join-Path $script:AtlasSrc 'gui\MainWindow.ps1')
$xamlTemplate = Get-Content -Raw (Join-Path $script:AtlasSrc 'gui\MainWindow.xaml')

# --- Lanzar GUI ---
Show-AtlasWindow -Branding $branding -Tools $tools -XamlTemplate $xamlTemplate
