# ============================================================
# Atlas PC Support - Branding loader
# Carga branding.json del repo o de una ruta personalizada.
# Los revendedores / técnicos editan branding.json para cambiar
# nombre, logo, colores, título de ventana, etc. sin tocar el código.
# ============================================================

function Get-AtlasBranding {
    [CmdletBinding()]
    param(
        [string]$OverridePath
    )

    $defaultBranding = @{
        brand = @{
            name         = "ATLAS PC SUPPORT"
            shortName    = "Atlas"
            tagline      = "Panel unificado de soporte técnico para Windows"
            version      = "1.0.0"
            companyUrl   = "https://github.com/mikepchelper-spec/atlas-pc-support"
            supportEmail = ""
            copyright    = "© 2026 Atlas PC Support"
        }
        theme = @{
            accentColor      = "#FF6600"
            darkMode         = $true
            useSystemAccent  = $false
            cornerRadius     = 8
            fontFamily       = "Segoe UI Variable"
        }
        language = "auto"
        window = @{
            title       = "ATLAS PC SUPPORT · Panel v1.0"
            width       = 1100
            height      = 720
            minWidth    = 900
            minHeight   = 600
            showSearch  = $true
            showFooter  = $true
        }
        behavior = @{
            autoElevate        = $true
            logPath            = "%LOCALAPPDATA%\AtlasPC\logs"
            dependenciesPath   = "%LOCALAPPDATA%\AtlasPC\bin"
            defaultCategory    = "Diagnóstico"
            confirmBeforeRun   = $false
        }
        categories = @(
            @{ id = "diagnostico";    label = "Diagnóstico";    icon = "🔍"; order = 1 }
            @{ id = "mantenimiento";  label = "Mantenimiento";  icon = "🛠"; order = 2 }
            @{ id = "copia";          label = "Copia de archivos"; icon = "📁"; order = 3 }
            @{ id = "redes";          label = "Redes";          icon = "🌐"; order = 4 }
            @{ id = "seguridad";      label = "Seguridad";      icon = "🔒"; order = 5 }
            @{ id = "software";       label = "Software";       icon = "📦"; order = 6 }
            @{ id = "entrega";        label = "Entrega";        icon = "✅"; order = 7 }
        )
    }

    $candidatePaths = @()
    if ($OverridePath) { $candidatePaths += $OverridePath }
    if ($PSScriptRoot) {
        $candidatePaths += (Join-Path $PSScriptRoot "..\..\branding.json")
        $candidatePaths += (Join-Path $PSScriptRoot "branding.json")
    }
    if ($env:LOCALAPPDATA) {
        $candidatePaths += (Join-Path $env:LOCALAPPDATA "AtlasPC\branding.json")
    }
    if ($env:APPDATA) {
        $candidatePaths += (Join-Path $env:APPDATA "AtlasPC\branding.json")
    }

    foreach ($path in $candidatePaths) {
        if ($path -and (Test-Path $path)) {
            try {
                $userBranding = Get-Content -Raw -Path $path | ConvertFrom-Json -AsHashtable
                Write-Verbose "Branding cargado desde: $path"
                return (Merge-AtlasBranding $defaultBranding $userBranding)
            } catch {
                Write-Warning "No se pudo parsear $path — usando branding por defecto. Error: $_"
            }
        }
    }

    return $defaultBranding
}

function Merge-AtlasBranding {
    param(
        [hashtable]$Default,
        [hashtable]$Override
    )
    $merged = @{}
    foreach ($key in $Default.Keys) { $merged[$key] = $Default[$key] }
    foreach ($key in $Override.Keys) {
        if ($merged.ContainsKey($key) -and $merged[$key] -is [hashtable] -and $Override[$key] -is [hashtable]) {
            $merged[$key] = Merge-AtlasBranding $merged[$key] $Override[$key]
        } else {
            $merged[$key] = $Override[$key]
        }
    }
    return $merged
}

function Expand-AtlasPath {
    param([string]$Path)
    if (-not $Path) { return "" }
    return [System.Environment]::ExpandEnvironmentVariables($Path)
}
