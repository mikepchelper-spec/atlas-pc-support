#Requires -Version 5.1
<#
.SYNOPSIS
  Compila el launcher distribuible `launcher.ps1` (raíz del repo) a partir
  de los módulos en src/. Embebe: lib, gui, tools, manifiesto y XAML.

.DESCRIPTION
  El archivo resultante es auto-contenido y puede ser invocado con:
      irm https://raw.githubusercontent.com/<owner>/<repo>/main/launcher.ps1 | iex

  Ejecuta este script con:
      pwsh -File build.ps1
#>
[CmdletBinding()]
param(
    [string]$OutFile = (Join-Path $PSScriptRoot 'launcher.ps1')
)

$ErrorActionPreference = 'Stop'

$src = Join-Path $PSScriptRoot 'src'
if (-not (Test-Path $src)) { throw "No existe $src" }

function Get-EmbeddedContent {
    param([string]$Path)
    $content = Get-Content -Raw -Path $Path -Encoding UTF8
    # Normaliza saltos de línea
    return $content -replace "`r`n", "`n"
}

$version      = '1.0.0'
$buildDate    = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
$manifest     = Get-EmbeddedContent (Join-Path $PSScriptRoot 'config\tools.json')
$xamlTemplate = Get-EmbeddedContent (Join-Path $src 'gui\MainWindow.xaml')

$libFiles = @(
    'lib\Branding.ps1'
    'lib\Strings.ps1'
    'lib\Admin.ps1'
    'lib\Logging.ps1'
    'lib\Dependencies.ps1'
    'lib\PS7.ps1'
    'lib\ToolRunner.ps1'
)
$libContent = foreach ($f in $libFiles) {
    $path = Join-Path $src $f
    "# ---- $f ----`n" + (Get-EmbeddedContent $path)
}
$libContent = $libContent -join "`n`n"

$guiContent = Get-EmbeddedContent (Join-Path $src 'gui\MainWindow.ps1')

$toolFiles = Get-ChildItem -Path (Join-Path $src 'tools') -Filter 'Invoke-*.ps1' | Sort-Object Name
$toolsContent = foreach ($t in $toolFiles) {
    "# ---- tools\$($t.Name) ----`n" + (Get-EmbeddedContent $t.FullName)
}
$toolsContent = $toolsContent -join "`n`n"

# Mapa de sources crudos por nombre de funcion, codificado base64.
# Usado por ToolRunner para escribir el script temporal SIN depender de
# (Get-Command).Definition, que en Windows PS 5.1 puede corromper
# here-strings y HTML embebido. Base64 evita todo problema de escape.
$toolSourcesBuilder = [System.Text.StringBuilder]::new()
[void]$toolSourcesBuilder.AppendLine('$script:AtlasToolSources = @{}')
foreach ($t in $toolFiles) {
    $raw = Get-EmbeddedContent $t.FullName
    $fnName = [System.IO.Path]::GetFileNameWithoutExtension($t.Name)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($raw)
    $b64   = [Convert]::ToBase64String($bytes)
    [void]$toolSourcesBuilder.AppendLine(("`$script:AtlasToolSources['{0}'] = '{1}'" -f $fnName, $b64))
}
$toolSourcesMap = $toolSourcesBuilder.ToString()

$banner = @"
# ============================================================
#  Atlas PC Support — launcher.ps1 (compilado)
#  Versión: $version
#  Build:   $buildDate
#  Repo:    https://github.com/mikepchelper-spec/atlas-pc-support
#
#  Uso:
#      irm https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1 | iex
#
#  Este archivo es AUTOGENERADO por build.ps1. NO lo edites a mano.
#  Las fuentes están en src/.
# ============================================================
"@

$epilog = @'

# ============================================================
#  BOOTSTRAP
# ============================================================

$ErrorActionPreference = 'Stop'

$branding = Get-AtlasBranding
# Preferencia guardada por el usuario (selector de idioma) manda sobre branding / auto-detect.
$savedLang = Get-AtlasLanguagePref
if ($savedLang) {
    $currentLang = Set-AtlasLanguage $savedLang
} else {
    $currentLang = Set-AtlasLanguage $branding.language
}
Initialize-AtlasLog | Out-Null
Write-AtlasLog "Atlas PC Support iniciado (launcher compilado v$script:AtlasVersion, lang=$currentLang, savedPref=$savedLang)"

# Detectar PS 7 y cachear la ruta (ToolRunner lo usa para lanzar tools en pwsh).
$ps7 = Initialize-AtlasPS7
if ($ps7) {
    Write-AtlasLog "PowerShell 7 disponible: $ps7"
} else {
    Write-AtlasLog "PowerShell 7 NO instalado; tools correran en Windows PowerShell 5.1. Usar la tool 'Actualizar PowerShell'."
}

try {
    $manifestObj = ConvertFrom-AtlasJson $script:AtlasToolsManifest
    $tools = @($manifestObj.tools)
} catch {
    throw "No se pudo parsear el manifiesto embebido: $_"
}

Show-AtlasWindow -Branding $branding -Tools $tools -XamlTemplate $script:AtlasXamlTemplate
'@

$manifestEscaped = $manifest.Replace("'", "''")
$xamlEscaped     = $xamlTemplate.Replace("'", "''")

$embeddedData = @"

# ============================================================
#  DATOS EMBEBIDOS
# ============================================================

`$script:AtlasVersion = '$version'
`$script:AtlasBuildDate = '$buildDate'

`$script:AtlasToolsManifest = @'
$manifestEscaped
'@

`$script:AtlasXamlTemplate = @'
$xamlEscaped
'@
"@

$output = @(
    $banner
    ""
    "#Requires -Version 5.1"
    ""
    $embeddedData
    ""
    "# ============================================================"
    "#  LIBRERÍAS (lib/)"
    "# ============================================================"
    ""
    $libContent
    ""
    "# ============================================================"
    "#  GUI"
    "# ============================================================"
    ""
    $guiContent
    ""
    "# ============================================================"
    "#  HERRAMIENTAS (tools/)"
    "# ============================================================"
    ""
    $toolsContent
    ""
    "# ============================================================"
    "#  SOURCES CRUDOS (base64) — usados por ToolRunner"
    "# ============================================================"
    ""
    $toolSourcesMap
    ""
    $epilog
) -join "`n"

# Write UTF-8 WITHOUT BOM.
#
# Two competing requirements:
#   (a) Windows PowerShell 5.1 reads BOM-less .ps1 files as ANSI/CP1252,
#       which mojibakes accents/emojis if the launcher is loaded by file
#       path (e.g. via run.bat → run-launcher.ps1 → launcher.ps1).
#   (b) PS 5.1's `irm <url> | iex` keeps the UTF-8 BOM as a literal U+FEFF
#       at the start of the string, which the PS 5.1 parser then chokes on
#       with: "The term '﻿#' is not recognized as a name of a cmdlet ...".
#
# We chose path (b) wins: file in the repo / on raw.githubusercontent.com
# stays BOM-less so `irm | iex` works for everyone. The offline USB path
# already has self-healing BOM repair in bootstrap.ps1 (PR #53), so when
# launcher.ps1 lands on disk via the bootstrap, the BOM is prepended
# right before run-launcher.ps1 invokes it. WriteAllText() emits the
# BOM-less variant on both Windows and Linux pwsh.
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
[System.IO.File]::WriteAllText($OutFile, $output, $utf8NoBom)

Write-Host ""
Write-Host "  Atlas PC Support — build completado" -ForegroundColor Green
Write-Host "  Archivo: $OutFile" -ForegroundColor Gray
$fi = Get-Item $OutFile
Write-Host "  Tamaño:  $([math]::Round($fi.Length / 1KB, 1)) KB ($([math]::Round($fi.Length / 1MB, 2)) MB)" -ForegroundColor Gray
Write-Host "  Build:   $buildDate" -ForegroundColor Gray
Write-Host ""
