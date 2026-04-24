# ============================================================
#  Atlas PC Support — launcher.ps1 (compilado)
#  Versión: 1.0.0
#  Build:   2026-04-24 02:41:10
#  Repo:    https://github.com/mikepchelper-spec/atlas-pc-support
#
#  Uso:
#      irm https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1 | iex
#
#  Este archivo es AUTOGENERADO por build.ps1. NO lo edites a mano.
#  Las fuentes están en src/.
# ============================================================

#Requires -Version 5.1


# ============================================================
#  DATOS EMBEBIDOS
# ============================================================

$script:AtlasVersion = '1.0.0'
$script:AtlasBuildDate = '2026-04-24 02:41:10'

$script:AtlasToolsManifest = @'
{
  "$comment": "Manifiesto de herramientas. Cada entrada describe una tool. El launcher usa esto para generar los botones de la UI.",
  "tools": [
    {
      "id": "fase-0",
      "name": "Fase 0 — IPv6 Hardening",
      "description": "Blindaje inicial: desactiva Teredo, 6to4 e ISATAP. Incluye bitácora técnica exportable.",
      "category": "seguridad",
      "function": "Invoke-Fase0",
      "source": "Fase0.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "ram-info",
      "name": "RAM Info",
      "description": "Diagnóstico avanzado de módulos de memoria: slots, velocidad, voltaje, XMP, detección soldada.",
      "category": "diagnostico",
      "function": "Invoke-RAMInfo",
      "source": "RAMInfo.ps1",
      "requiresAdmin": false,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "mod-personalizacion",
      "name": "Personalización Avanzada",
      "description": "Wallpaper vía API Win32, tema oscuro, color de acento, barra de tareas y marca de agua.",
      "category": "mantenimiento",
      "function": "Invoke-Personalizacion",
      "source": "Personalizacion.ps1",
      "requiresAdmin": false,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "stop-services",
      "name": "Stop Services (Optimizar)",
      "description": "Detiene y pasa a Manual servicios no esenciales: telemetría, Xbox, sensores, fax, etc.",
      "category": "mantenimiento",
      "function": "Invoke-StopServices",
      "source": "StopServices.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "fastcopy",
      "name": "FastCopy",
      "description": "Copia multi-origen con perfiles, comparación, MD5 y resumen exportable. Reemplaza Robocopy con mejor UX.",
      "category": "copia",
      "function": "Invoke-FastCopy",
      "source": "FastCopy.ps1",
      "requiresAdmin": false,
      "runsInNewWindow": true,
      "dependencies": ["FastCopy"]
    },
    {
      "id": "robocopy",
      "name": "Robocopy (Copia Inteligente)",
      "description": "Copia optimizada basada en robocopy: espejo, reintentos, logging centralizado.",
      "category": "copia",
      "function": "Invoke-Robocopy",
      "source": "Robocopy.ps1",
      "requiresAdmin": false,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "selector-dns",
      "name": "Selector DNS",
      "description": "Cambia el servidor DNS entre perfiles (Cloudflare, Google, OpenDNS, personalizado) con un clic.",
      "category": "redes",
      "function": "Invoke-SelectorDNS",
      "source": "SelectorDNS.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "hosts",
      "name": "Gestor HOSTS",
      "description": "Editor del archivo HOSTS de Windows con respaldo automático.",
      "category": "redes",
      "function": "Invoke-HostsManager",
      "source": "HostsManager.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "auditoria-router",
      "name": "Auditoría Router",
      "description": "Escaneo y auditoría de seguridad del router de la red local.",
      "category": "redes",
      "function": "Invoke-AuditoriaRouter",
      "source": "AuditoriaRouter.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "gestor-bitlocker",
      "name": "Gestor BitLocker",
      "description": "Estado, activación, suspensión y exportación de claves BitLocker.",
      "category": "seguridad",
      "function": "Invoke-GestorBitLocker",
      "source": "GestorBitLocker.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "menor-privilegio",
      "name": "Principio de Menor Privilegio",
      "description": "Auditoría y aplicación del principio de menor privilegio en cuentas locales.",
      "category": "seguridad",
      "function": "Invoke-MenorPrivilegio",
      "source": "MenorPrivilegio.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "extraer-licencias",
      "name": "Extraer Licencias",
      "description": "Extracción de claves de producto de Windows y Office (lectura segura).",
      "category": "seguridad",
      "function": "Invoke-ExtraerLicencias",
      "source": "ExtraerLicencias.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": []
    },
    {
      "id": "software-installer",
      "name": "Software Installer",
      "description": "Panel maestro de instalación de software vía winget: navegadores, utilidades, suite Atlas.",
      "category": "software",
      "function": "Invoke-SoftwareInstaller",
      "source": "SoftwareInstaller.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": ["winget"]
    },
    {
      "id": "bundle-atlas",
      "name": "Bundle Atlas Recomendado",
      "description": "Instala el pack pre-configurado de Atlas: Opera GX, 7-Zip, Chrome, VLC, WhatsApp, Zoom, PowerShell 7, digiKam, etc.",
      "category": "software",
      "function": "Invoke-BundleAtlas",
      "source": "BundleAtlas.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": ["winget"]
    },
    {
      "id": "entrega-pc",
      "name": "Entrega PC",
      "description": "Protocolo de cierre: limpieza final, resumen, bitácora y preparación para entrega al cliente.",
      "category": "entrega",
      "function": "Invoke-EntregaPC",
      "source": "EntregaPC.ps1",
      "requiresAdmin": true,
      "runsInNewWindow": true,
      "dependencies": []
    }
  ]
}

'@

$script:AtlasXamlTemplate = @'
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="{{WINDOW_TITLE}}"
    Height="{{WINDOW_HEIGHT}}"
    Width="{{WINDOW_WIDTH}}"
    MinWidth="{{WINDOW_MIN_WIDTH}}"
    MinHeight="{{WINDOW_MIN_HEIGHT}}"
    WindowStartupLocation="CenterScreen"
    Background="{{BG_COLOR}}"
    FontFamily="{{FONT_FAMILY}}"
    FontSize="13"
    TextOptions.TextFormattingMode="Display"
    TextOptions.TextRenderingMode="ClearType">

    <Window.Resources>
        <!-- Paleta Atlas -->
        <SolidColorBrush x:Key="AccentBrush"         Color="{{ACCENT_COLOR}}"/>
        <SolidColorBrush x:Key="AccentHoverBrush"    Color="{{ACCENT_HOVER}}"/>
        <SolidColorBrush x:Key="AccentPressedBrush"  Color="{{ACCENT_PRESSED}}"/>
        <SolidColorBrush x:Key="SurfaceBrush"        Color="{{SURFACE_COLOR}}"/>
        <SolidColorBrush x:Key="SurfaceAltBrush"     Color="{{SURFACE_ALT_COLOR}}"/>
        <SolidColorBrush x:Key="BorderBrush"         Color="{{BORDER_COLOR}}"/>
        <SolidColorBrush x:Key="TextPrimaryBrush"    Color="{{TEXT_PRIMARY}}"/>
        <SolidColorBrush x:Key="TextSecondaryBrush"  Color="{{TEXT_SECONDARY}}"/>
        <SolidColorBrush x:Key="TextMutedBrush"      Color="{{TEXT_MUTED}}"/>

        <!-- Botón primario (estilo Fluent) -->
        <Style x:Key="AtlasPrimaryButton" TargetType="Button">
            <Setter Property="Background" Value="{StaticResource AccentBrush}"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="BorderBrush" Value="{StaticResource AccentBrush}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="16,8"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border CornerRadius="{{CORNER_RADIUS}}"
                                Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}">
                            <ContentPresenter HorizontalAlignment="Center"
                                              VerticalAlignment="Center"
                                              Margin="{TemplateBinding Padding}"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="{StaticResource AccentHoverBrush}"/>
                                <Setter Property="BorderBrush" Value="{StaticResource AccentHoverBrush}"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter Property="Background" Value="{StaticResource AccentPressedBrush}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Botón secundario (outline) -->
        <Style x:Key="AtlasSecondaryButton" TargetType="Button" BasedOn="{StaticResource AtlasPrimaryButton}">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextPrimaryBrush}"/>
            <Setter Property="BorderBrush" Value="{StaticResource BorderBrush}"/>
        </Style>

        <!-- Tarjeta de herramienta -->
        <Style x:Key="ToolCard" TargetType="Border">
            <Setter Property="Background" Value="{StaticResource SurfaceBrush}"/>
            <Setter Property="BorderBrush" Value="{StaticResource BorderBrush}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="CornerRadius" Value="{{CORNER_RADIUS}}"/>
            <Setter Property="Padding" Value="16"/>
            <Setter Property="Margin" Value="0,0,12,12"/>
        </Style>

        <!-- Categoría pill -->
        <Style x:Key="CategoryPill" TargetType="RadioButton">
            <Setter Property="Foreground" Value="{StaticResource TextSecondaryBrush}"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Padding" Value="14,8"/>
            <Setter Property="Margin" Value="0,0,8,0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="RadioButton">
                        <Border x:Name="Pill"
                                CornerRadius="{{CORNER_RADIUS}}"
                                Background="Transparent"
                                BorderBrush="Transparent"
                                BorderThickness="1">
                            <ContentPresenter HorizontalAlignment="Center"
                                              VerticalAlignment="Center"
                                              Margin="{TemplateBinding Padding}"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Pill" Property="Background" Value="{StaticResource SurfaceAltBrush}"/>
                            </Trigger>
                            <Trigger Property="IsChecked" Value="True">
                                <Setter TargetName="Pill" Property="Background" Value="{StaticResource AccentBrush}"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Scrollbar minimalista -->
        <Style TargetType="ScrollBar">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Width" Value="10"/>
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>   <!-- Header -->
            <RowDefinition Height="Auto"/>   <!-- Tabs -->
            <RowDefinition Height="*"/>      <!-- Content -->
            <RowDefinition Height="Auto"/>   <!-- Footer -->
        </Grid.RowDefinitions>

        <!-- HEADER -->
        <Border Grid.Row="0" Background="{StaticResource SurfaceBrush}"
                BorderBrush="{StaticResource BorderBrush}"
                BorderThickness="0,0,0,1"
                Padding="24,18">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>

                <StackPanel Grid.Column="0" Orientation="Vertical">
                    <TextBlock Text="{{BRAND_NAME}}"
                               Foreground="{StaticResource AccentBrush}"
                               FontSize="22"
                               FontWeight="Bold"/>
                    <TextBlock Text="{{BRAND_TAGLINE}}"
                               Foreground="{StaticResource TextMutedBrush}"
                               FontSize="12"
                               Margin="0,2,0,0"/>
                </StackPanel>

                <TextBox x:Name="SearchBox"
                         Grid.Column="1"
                         MaxWidth="360"
                         Margin="24,0"
                         Padding="12,8"
                         Background="{StaticResource SurfaceAltBrush}"
                         Foreground="{StaticResource TextPrimaryBrush}"
                         BorderBrush="{StaticResource BorderBrush}"
                         FontSize="13"
                         VerticalContentAlignment="Center"
                         Tag="🔍  {{SEARCH_PLACEHOLDER}}"/>

                <StackPanel Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center">
                    <TextBlock x:Name="AdminBadge"
                               Text=""
                               Foreground="{StaticResource TextMutedBrush}"
                               FontSize="11"
                               Margin="0,0,12,0"
                               VerticalAlignment="Center"/>
                    <Button x:Name="BtnLogs"
                            Content="{{HEADER_LOGS}}"
                            Style="{StaticResource AtlasSecondaryButton}"
                            Margin="0,0,8,0"/>
                    <Button x:Name="BtnAbout"
                            Content="{{HEADER_ABOUT}}"
                            Style="{StaticResource AtlasSecondaryButton}"/>
                </StackPanel>
            </Grid>
        </Border>

        <!-- TABS / CATEGORÍAS -->
        <Border Grid.Row="1"
                Background="{{BG_COLOR}}"
                Padding="24,12,24,0">
            <StackPanel x:Name="CategoryBar"
                        Orientation="Horizontal"
                        VerticalAlignment="Center"/>
        </Border>

        <!-- CONTENT -->
        <ScrollViewer Grid.Row="2"
                      VerticalScrollBarVisibility="Auto"
                      HorizontalScrollBarVisibility="Disabled"
                      Padding="24,12,24,12">
            <ItemsControl x:Name="ToolsGrid">
                <ItemsControl.ItemsPanel>
                    <ItemsPanelTemplate>
                        <WrapPanel Orientation="Horizontal"/>
                    </ItemsPanelTemplate>
                </ItemsControl.ItemsPanel>
            </ItemsControl>
        </ScrollViewer>

        <!-- FOOTER -->
        <Border Grid.Row="3"
                Background="{StaticResource SurfaceBrush}"
                BorderBrush="{StaticResource BorderBrush}"
                BorderThickness="0,1,0,0"
                Padding="24,10">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <TextBlock Grid.Column="0"
                           x:Name="StatusText"
                           Text="{{STATUS_READY}}"
                           Foreground="{StaticResource TextMutedBrush}"
                           FontSize="11"
                           VerticalAlignment="Center"/>
                <TextBlock Grid.Column="1"
                           Text="{{BRAND_COPYRIGHT}} · v{{BRAND_VERSION}}"
                           Foreground="{StaticResource TextMutedBrush}"
                           FontSize="11"
                           VerticalAlignment="Center"/>
            </Grid>
        </Border>
    </Grid>
</Window>

'@

# ============================================================
#  LIBRERÍAS (lib/)
# ============================================================

# ---- lib\Branding.ps1 ----
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
            accentColor      = "#FF5500"
            secondaryColor   = "#002147"
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
            @{ id = "copia";          label = "Backup & Sync";  icon = "📁"; order = 3 }
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


# ---- lib\Strings.ps1 ----
# ============================================================
# Atlas PC Support — Strings / i18n
# Idiomas soportados: es (por defecto), en, ro
# Añadir otros: copia el bloque 'es' y traduce los valores.
# ============================================================

$script:AtlasStringsDict = @{
    'es' = @{
        'app.tagline'             = 'Panel unificado de soporte técnico para Windows'
        'search.placeholder'      = 'Buscar herramienta...'
        'category.all'            = 'Todo'
        'category.diagnostico'    = 'Diagnóstico'
        'category.mantenimiento'  = 'Mantenimiento'
        'category.copia'          = 'Backup & Sync'
        'category.redes'          = 'Redes'
        'category.seguridad'      = 'Seguridad'
        'category.software'       = 'Software'
        'category.entrega'        = 'Entrega'
        'header.admin'            = '🛡  Admin'
        'header.user'             = '👤 Usuario'
        'header.logs'             = '📋 Logs'
        'header.about'            = 'ℹ️ Acerca de'
        'button.run'              = '▶  Ejecutar'
        'badge.requiresAdmin'     = '🛡  requiere admin'
        'status.ready'            = 'Listo'
        'status.launching'        = 'Lanzando: {0}...'
        'status.lastRun'          = 'Listo — última: {0}'
        'status.toolsShown'       = '{0} herramienta(s) mostrada(s)'
        'logs.empty'              = 'Aún no hay logs. Ejecuta alguna herramienta primero.'
        'about.title'             = 'Acerca de'
        'about.description'       = 'Panel inspirado en WinUtil (Chris Titus Tech).{NEWLINE}Licencia: MIT.'
        'about.web'               = 'Web'
        'tool.closePrompt'        = 'Presiona Enter para cerrar esta ventana...'
        'tool.error'              = '[!] Error en {0}: {1}'
        'tool.notLoaded'          = "No se pudo serializar la función '{0}'. ¿Está cargada?"
    }
    'en' = @{
        'app.tagline'             = 'Unified Windows tech-support panel'
        'search.placeholder'      = 'Search tool...'
        'category.all'            = 'All'
        'category.diagnostico'    = 'Diagnostics'
        'category.mantenimiento'  = 'Maintenance'
        'category.copia'          = 'Backup & Sync'
        'category.redes'          = 'Network'
        'category.seguridad'      = 'Security'
        'category.software'       = 'Software'
        'category.entrega'        = 'Handover'
        'header.admin'            = '🛡  Admin'
        'header.user'             = '👤 User'
        'header.logs'             = '📋 Logs'
        'header.about'            = 'ℹ️ About'
        'button.run'              = '▶  Run'
        'badge.requiresAdmin'     = '🛡  requires admin'
        'status.ready'            = 'Ready'
        'status.launching'        = 'Launching: {0}...'
        'status.lastRun'          = 'Ready — last: {0}'
        'status.toolsShown'       = '{0} tool(s) shown'
        'logs.empty'              = 'No logs yet. Run a tool first.'
        'about.title'             = 'About'
        'about.description'       = 'Panel inspired by WinUtil (Chris Titus Tech).{NEWLINE}License: MIT.'
        'about.web'               = 'Web'
        'tool.closePrompt'        = 'Press Enter to close this window...'
        'tool.error'              = '[!] Error in {0}: {1}'
        'tool.notLoaded'          = "Could not serialize the function '{0}'. Is it loaded?"
    }
    'ro' = @{
        'app.tagline'             = 'Panou unificat de suport tehnic pentru Windows'
        'search.placeholder'      = 'Caută unealta...'
        'category.all'            = 'Toate'
        'category.diagnostico'    = 'Diagnostic'
        'category.mantenimiento'  = 'Mentenanță'
        'category.copia'          = 'Backup & Sync'
        'category.redes'          = 'Rețea'
        'category.seguridad'      = 'Securitate'
        'category.software'       = 'Software'
        'category.entrega'        = 'Predare'
        'header.admin'            = '🛡  Admin'
        'header.user'             = '👤 Utilizator'
        'header.logs'             = '📋 Jurnale'
        'header.about'            = 'ℹ️ Despre'
        'button.run'              = '▶  Rulează'
        'badge.requiresAdmin'     = '🛡  necesită admin'
        'status.ready'            = 'Gata'
        'status.launching'        = 'Se lansează: {0}...'
        'status.lastRun'          = 'Gata — ultima: {0}'
        'status.toolsShown'       = '{0} unealtă(e) afișată(e)'
        'logs.empty'              = 'Încă nu există jurnale. Rulează o unealtă mai întâi.'
        'about.title'             = 'Despre'
        'about.description'       = 'Panou inspirat din WinUtil (Chris Titus Tech).{NEWLINE}Licență: MIT.'
        'about.web'               = 'Web'
        'tool.closePrompt'        = 'Apasă Enter pentru a închide această fereastră...'
        'tool.error'              = '[!] Eroare în {0}: {1}'
        'tool.notLoaded'          = "Nu s-a putut serializa funcția '{0}'. Este încărcată?"
    }
}

$script:AtlasCurrentLang = 'es'

function Get-AtlasSystemLanguage {
    try {
        $culture = [System.Globalization.CultureInfo]::CurrentUICulture
        $two = $culture.TwoLetterISOLanguageName.ToLower()
        if ($script:AtlasStringsDict.ContainsKey($two)) {
            return $two
        }
    } catch {}
    return 'es'
}

function Set-AtlasLanguage {
    [CmdletBinding()]
    param(
        [string]$Language = 'auto'
    )
    if ($Language -eq 'auto' -or -not $Language) {
        $Language = Get-AtlasSystemLanguage
    }
    $Language = $Language.ToLower()
    if (-not $script:AtlasStringsDict.ContainsKey($Language)) {
        Write-Warning "Idioma '$Language' no soportado. Usando 'es'."
        $Language = 'es'
    }
    $script:AtlasCurrentLang = $Language
    return $Language
}

function Get-AtlasString {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position=0)] [string]$Key,
        [Parameter(Position=1, ValueFromRemainingArguments=$true)] [object[]]$Args
    )
    $dict = $script:AtlasStringsDict[$script:AtlasCurrentLang]
    if (-not $dict.ContainsKey($Key)) {
        # fallback a español
        $dict = $script:AtlasStringsDict['es']
    }
    $value = $dict[$Key]
    if (-not $value) { return $Key }
    if ($Args -and $Args.Count -gt 0) {
        $value = [string]::Format($value, $Args)
    }
    $value = $value -replace '\{NEWLINE\}', [Environment]::NewLine
    return $value
}

function Get-AtlasSupportedLanguages {
    return @($script:AtlasStringsDict.Keys)
}


# ---- lib\Admin.ps1 ----
# ============================================================
# Atlas PC Support - Auto-elevation
# Sustituye a los .bat de cada tool.
# ============================================================

function Test-IsAdmin {
    [CmdletBinding()]
    param()
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($id)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Invoke-SelfElevate {
    [CmdletBinding()]
    param(
        [string]$ScriptPath = $PSCommandPath
    )
    if (Test-IsAdmin) { return $true }

    if (-not $ScriptPath) {
        Write-Warning "No se puede auto-elevar: no hay ruta de script."
        return $false
    }

    try {
        Start-Process -FilePath "powershell.exe" `
            -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$ScriptPath`"") `
            -Verb RunAs | Out-Null
        exit 0
    } catch {
        Write-Warning "No se pudo elevar: $_"
        return $false
    }
}

function Invoke-AsAdmin {
    <#
    .SYNOPSIS
    Ejecuta un bloque de código en una nueva ventana de PowerShell elevada.
    .PARAMETER ScriptBlock
    Bloque de código a ejecutar.
    .PARAMETER Title
    Título de la ventana.
    .PARAMETER Wait
    Esperar a que termine antes de volver.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [scriptblock]$ScriptBlock,
        [string]$Title = "Atlas PC Support",
        [switch]$Wait
    )

    $encoded = [Convert]::ToBase64String(
        [System.Text.Encoding]::Unicode.GetBytes($ScriptBlock.ToString())
    )

    $psArgs = @(
        "-NoProfile",
        "-ExecutionPolicy", "Bypass",
        "-EncodedCommand", $encoded
    )

    $startArgs = @{
        FilePath     = "powershell.exe"
        ArgumentList = $psArgs
        Verb         = "RunAs"
    }
    if ($Wait) { $startArgs.Wait = $true }

    try {
        Start-Process @startArgs | Out-Null
        return $true
    } catch {
        Write-Warning "No se pudo lanzar ventana elevada: $_"
        return $false
    }
}


# ---- lib\Logging.ps1 ----
# ============================================================
# Atlas PC Support - Central logging
# ============================================================

$script:AtlasLogFile = $null

function Initialize-AtlasLog {
    [CmdletBinding()]
    param(
        [string]$LogPath = (Expand-AtlasPath "%LOCALAPPDATA%\AtlasPC\logs")
    )

    if (-not (Test-Path $LogPath)) {
        New-Item -ItemType Directory -Path $LogPath -Force | Out-Null
    }
    $date = Get-Date -Format "yyyy-MM-dd"
    $script:AtlasLogFile = Join-Path $LogPath "atlas-$date.log"

    $header = @"

================================================================
 Atlas PC Support — sesión iniciada $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
 Equipo : $env:COMPUTERNAME
 Usuario: $env:USERNAME
================================================================
"@
    Add-Content -Path $script:AtlasLogFile -Value $header -Encoding UTF8
    return $script:AtlasLogFile
}

function Write-AtlasLog {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position=0)] [string]$Message,
        [ValidateSet('INFO','WARN','ERROR','DEBUG')] [string]$Level = 'INFO',
        [string]$Tool = ''
    )
    if (-not $script:AtlasLogFile) { Initialize-AtlasLog | Out-Null }
    $ts   = Get-Date -Format "HH:mm:ss"
    $tool = if ($Tool) { "[$Tool] " } else { "" }
    $line = "[$ts] [$Level] $tool$Message"
    try {
        Add-Content -Path $script:AtlasLogFile -Value $line -Encoding UTF8
    } catch {
        # no op — logging nunca debe romper la tool
    }
}

function Get-AtlasLogPath {
    if (-not $script:AtlasLogFile) { Initialize-AtlasLog | Out-Null }
    return $script:AtlasLogFile
}


# ---- lib\Dependencies.ps1 ----
# ============================================================
# Atlas PC Support - Dependency manager
# Resuelve y descarga dependencias externas (FastCopy, etc.)
# a %LOCALAPPDATA%\AtlasPC\bin\ bajo demanda.
# ============================================================

$script:AtlasDepsRegistry = @{
    'FastCopy' = @{
        DisplayName    = 'FastCopy'
        ExecutableName = 'FastCopy.exe'
        WingetId       = 'FastCopy.FastCopy'
        DownloadUrl    = 'https://fastcopy.jp/archive/FastCopy5.7.21_installer.exe'
        SearchPaths    = @(
            'C:\Program Files\FastCopy\FastCopy.exe',
            'C:\Program Files (x86)\FastCopy\FastCopy.exe',
            '%LOCALAPPDATA%\FastCopy\FastCopy.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\FastCopy\FastCopy.exe'
        )
    }
    'winget' = @{
        DisplayName    = 'Windows Package Manager'
        ExecutableName = 'winget.exe'
        SearchPaths    = @(
            '%LOCALAPPDATA%\Microsoft\WindowsApps\winget.exe'
        )
    }
}

function Resolve-AtlasDependency {
    <#
    .SYNOPSIS
    Busca una dependencia en el sistema; si no la encuentra,
    intenta instalarla con winget o descargarla.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [string]$Name,
        [switch]$InstallIfMissing
    )

    if (-not $script:AtlasDepsRegistry.ContainsKey($Name)) {
        Write-AtlasLog "Dependencia desconocida: $Name" -Level ERROR -Tool 'Deps'
        return $null
    }
    $dep = $script:AtlasDepsRegistry[$Name]

    foreach ($p in $dep.SearchPaths) {
        $expanded = Expand-AtlasPath $p
        if (Test-Path $expanded) {
            Write-AtlasLog "Encontrada $Name en $expanded" -Tool 'Deps'
            return $expanded
        }
    }
    $inPath = Get-Command $dep.ExecutableName -ErrorAction SilentlyContinue
    if ($inPath) { return $inPath.Source }

    if (-not $InstallIfMissing) {
        Write-AtlasLog "$Name no encontrada (no se pidió instalar)." -Level WARN -Tool 'Deps'
        return $null
    }

    if ($dep.WingetId -and (Get-Command 'winget' -ErrorAction SilentlyContinue)) {
        Write-AtlasLog "Instalando $Name vía winget ($($dep.WingetId))" -Tool 'Deps'
        try {
            winget install --id $dep.WingetId --exact --accept-source-agreements --accept-package-agreements --silent | Out-Null
        } catch {
            Write-AtlasLog "winget falló: $_" -Level WARN -Tool 'Deps'
        }
        foreach ($p in $dep.SearchPaths) {
            $expanded = Expand-AtlasPath $p
            if (Test-Path $expanded) { return $expanded }
        }
    }

    Write-AtlasLog "No se pudo resolver $Name. Revisa la ruta manualmente." -Level ERROR -Tool 'Deps'
    return $null
}

function Register-AtlasDependency {
    param(
        [Parameter(Mandatory)] [string]$Name,
        [Parameter(Mandatory)] [hashtable]$Definition
    )
    $script:AtlasDepsRegistry[$Name] = $Definition
}


# ---- lib\ToolRunner.ps1 ----
# ============================================================
# Atlas PC Support - Tool runner
# Ejecuta una herramienta en una nueva ventana de PowerShell.
#
# Enfoque:
#   * Obtener el cuerpo de la funcion de la tool (Get-Command ....Definition).
#   * Escribir un .ps1 temporal a %TEMP%\AtlasPC\<id>.ps1.
#   * Lanzar powershell.exe -File <temp.ps1>, con elevacion si procede.
#
# Por que NO usamos -EncodedCommand:
#   1. Limite de longitud de CreateProcess (~32 KB). Tools grandes como
#      FastCopy o Robocopy superan el limite y Windows devuelve
#      "The filename or extension is too long".
#   2. Al construir el script con here-strings interpolables, variables
#      como $Host, $code, $WindowWidth presentes en el cuerpo de la tool
#      se expanden ANTES de mandarse al hijo, produciendo sintaxis rota.
# ============================================================

function Invoke-AtlasTool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [hashtable]$Tool,
        [hashtable]$Branding
    )

    Write-AtlasLog "Ejecutando: $($Tool.name) [$($Tool.id)]" -Tool 'Runner'

    $function = $Tool.function
    $cmd = Get-Command $function -CommandType Function -ErrorAction SilentlyContinue
    if (-not $cmd) {
        $msg = "La funcion '$function' no esta cargada. Revisa src/tools/ y tools.json."
        Write-AtlasLog $msg -Level ERROR -Tool 'Runner'
        [System.Windows.MessageBox]::Show($msg, 'Atlas PC Support', 'OK', 'Error') | Out-Null
        return
    }

    $runInNew = $true
    if ($Tool.ContainsKey('runsInNewWindow')) {
        $runInNew = [bool]$Tool.runsInNewWindow
    }

    if (-not $runInNew) {
        try { & $function } catch {
            Write-AtlasLog "Error en ${function}: $_" -Level ERROR -Tool 'Runner'
            [System.Windows.MessageBox]::Show("Error: $_", 'Atlas PC Support', 'OK', 'Error') | Out-Null
        }
        return
    }

    # ----------- Construir el script temporal -----------
    $funcBody = $cmd.Definition
    if (-not $funcBody) {
        $msg = "No se pudo serializar la funcion '$function'."
        Write-AtlasLog $msg -Level ERROR -Tool 'Runner'
        [System.Windows.MessageBox]::Show($msg, 'Atlas PC Support', 'OK', 'Error') | Out-Null
        return
    }

    # Limpiar BOM UTF-8 y otros caracteres invisibles del inicio.
    $funcBody = $funcBody -replace "^[\uFEFF\u200B]+", ""
    $funcBody = $funcBody.TrimStart()

    $brandName = if ($Branding -and $Branding.brand -and $Branding.brand.shortName) { $Branding.brand.shortName } else { 'Atlas PC Support' }
    $title = "$brandName - $($Tool.name)"

    # Construir el contenido del .ps1 SIN interpolacion del cuerpo:
    # usamos un StringBuilder para que $Host, $code, etc. del cuerpo de
    # la tool se escriban literalmente y los evalue el hijo.
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine('# Atlas PC Support - runner temp script')
    [void]$sb.AppendLine('$ErrorActionPreference = ''Continue''')
    [void]$sb.AppendLine('try { $Host.UI.RawUI.WindowTitle = ' + ("'{0}'" -f ($title -replace "'","''")) + ' } catch {}')
    [void]$sb.AppendLine('')
    # Define la funcion de la tool:
    [void]$sb.AppendLine("function $function {")
    [void]$sb.AppendLine($funcBody)
    [void]$sb.AppendLine('}')
    [void]$sb.AppendLine('')
    # Invocar con captura de errores y pausa al final (incluso si revienta).
    [void]$sb.AppendLine('try {')
    [void]$sb.AppendLine("    $function")
    [void]$sb.AppendLine('} catch {')
    [void]$sb.AppendLine('    Write-Host ""')
    [void]$sb.AppendLine("    Write-Host ('[!] Error en $function : ' + `$_.Exception.Message) -ForegroundColor Red")
    [void]$sb.AppendLine('    Write-Host ""')
    [void]$sb.AppendLine('    Write-Host "Traza:" -ForegroundColor DarkGray')
    [void]$sb.AppendLine('    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray')
    [void]$sb.AppendLine('}')
    [void]$sb.AppendLine('Write-Host ""')
    [void]$sb.AppendLine('Write-Host "-----------------------------------" -ForegroundColor DarkGray')
    [void]$sb.AppendLine('Write-Host "Presiona Enter para cerrar esta ventana..." -ForegroundColor Yellow')
    [void]$sb.AppendLine('[void][Console]::ReadLine()')

    $tempDir = Join-Path $env:TEMP 'AtlasPC'
    if (-not (Test-Path $tempDir)) {
        New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    }
    $tempScript = Join-Path $tempDir "run-$($Tool.id)-$(Get-Random).ps1"

    # Escribir SIN BOM para evitar que el BOM cause "The term '﻿#' is not recognized".
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($tempScript, $sb.ToString(), $utf8NoBom)

    Write-AtlasLog "Temp script: $tempScript" -Tool 'Runner' -Level DEBUG

    $psArgs = @(
        '-NoProfile',
        '-ExecutionPolicy', 'Bypass',
        '-File', $tempScript
    )

    $startArgs = @{
        FilePath     = 'powershell.exe'
        ArgumentList = $psArgs
    }
    if ($Tool.requiresAdmin -and -not (Test-IsAdmin)) {
        $startArgs.Verb = 'RunAs'
    }

    try {
        Start-Process @startArgs | Out-Null
    } catch {
        $errMsg = "No se pudo lanzar la tool '$($Tool.name)': $($_.Exception.Message)"
        Write-AtlasLog $errMsg -Level ERROR -Tool 'Runner'
        [System.Windows.MessageBox]::Show($errMsg, 'Atlas PC Support', 'OK', 'Error') | Out-Null
    }
}


# ============================================================
#  GUI
# ============================================================

# ============================================================
# Atlas PC Support — MainWindow.ps1
# Construye la ventana WPF, aplica branding, renderiza herramientas.
# ============================================================

function ConvertTo-AtlasHex {
    param([string]$Hex)
    if (-not $Hex) { return "#FFFFFF" }
    if ($Hex -notmatch '^#') { $Hex = "#$Hex" }
    return $Hex
}

# Recorre el arbol logico de WPF buscando el primer descendiente del tipo indicado.
function Find-AtlasDescendant {
    param(
        [Parameter(Mandatory)] $Root,
        [Parameter(Mandatory)] [type]$Type
    )
    if ($null -eq $Root) { return $null }
    if ($Root -is $Type) { return $Root }

    # Intentar varios "hijos" segun el tipo de contenedor WPF
    $kids = @()
    if ($Root.PSObject.Properties.Match('Child').Count -gt 0 -and $Root.Child) {
        $kids += $Root.Child
    }
    if ($Root.PSObject.Properties.Match('Children').Count -gt 0 -and $Root.Children) {
        foreach ($c in $Root.Children) { $kids += $c }
    }
    if ($Root.PSObject.Properties.Match('Content').Count -gt 0 -and $Root.Content -and ($Root.Content -is [System.Windows.DependencyObject])) {
        $kids += $Root.Content
    }
    if ($Root.PSObject.Properties.Match('Items').Count -gt 0 -and $Root.Items) {
        foreach ($c in $Root.Items) {
            if ($c -is [System.Windows.DependencyObject]) { $kids += $c }
        }
    }

    foreach ($kid in $kids) {
        $found = Find-AtlasDescendant -Root $kid -Type $Type
        if ($found) { return $found }
    }
    return $null
}

function Get-AtlasPalette {
    param([hashtable]$Branding)

    $accent = ConvertTo-AtlasHex $Branding.theme.accentColor
    $dark   = [bool]$Branding.theme.darkMode
    $secondary = if ($Branding.theme.secondaryColor) { ConvertTo-AtlasHex $Branding.theme.secondaryColor } else { $null }

    if ($dark) {
        # Si hay secondaryColor (ej. Atlas navy #002147), tínta sutilmente el fondo
        $bg      = if ($secondary) { (Get-AtlasColorShift $secondary -15) } else { '#0F1115' }
        $surface = if ($secondary) { (Get-AtlasColorShift $secondary 0)   } else { '#1A1D23' }
        $surfAlt = if ($secondary) { (Get-AtlasColorShift $secondary 15)  } else { '#23272F' }
        return @{
            BgColor          = $bg
            SurfaceColor     = $surface
            SurfaceAltColor  = $surfAlt
            BorderColor      = '#2E333D'
            TextPrimary      = '#F5F5F5'
            TextSecondary    = '#C5C7CC'
            TextMuted        = '#9BA0AA'
            AccentColor      = $accent
            AccentHover      = (Get-AtlasColorShift $accent 20)
            AccentPressed    = (Get-AtlasColorShift $accent -20)
        }
    } else {
        return @{
            BgColor          = '#F7F8FA'
            SurfaceColor     = '#FFFFFF'
            SurfaceAltColor  = '#F0F1F4'
            BorderColor      = '#E0E2E7'
            TextPrimary      = '#1A1D23'
            TextSecondary    = '#434750'
            TextMuted        = '#8A8E95'
            AccentColor      = $accent
            AccentHover      = (Get-AtlasColorShift $accent -10)
            AccentPressed    = (Get-AtlasColorShift $accent -25)
        }
    }
}

function Get-AtlasColorShift {
    param([string]$Hex, [int]$Delta)
    $Hex = $Hex.TrimStart('#')
    $r = [Convert]::ToInt32($Hex.Substring(0,2), 16)
    $g = [Convert]::ToInt32($Hex.Substring(2,2), 16)
    $b = [Convert]::ToInt32($Hex.Substring(4,2), 16)
    $r = [Math]::Max(0, [Math]::Min(255, $r + $Delta))
    $g = [Math]::Max(0, [Math]::Min(255, $g + $Delta))
    $b = [Math]::Max(0, [Math]::Min(255, $b + $Delta))
    return ('#{0:X2}{1:X2}{2:X2}' -f $r, $g, $b)
}

function Expand-AtlasXaml {
    param(
        [string]$Xaml,
        [hashtable]$Branding,
        [hashtable]$Palette
    )
    $tagline = $Branding.brand.tagline
    if (-not $tagline) { $tagline = Get-AtlasString 'app.tagline' }

    $map = @{
        'WINDOW_TITLE'       = $Branding.window.title
        'WINDOW_WIDTH'       = $Branding.window.width
        'WINDOW_HEIGHT'      = $Branding.window.height
        'WINDOW_MIN_WIDTH'   = $Branding.window.minWidth
        'WINDOW_MIN_HEIGHT'  = $Branding.window.minHeight
        'BRAND_NAME'         = $Branding.brand.name
        'BRAND_TAGLINE'      = $tagline
        'BRAND_VERSION'      = $Branding.brand.version
        'BRAND_COPYRIGHT'    = $Branding.brand.copyright
        'FONT_FAMILY'        = $Branding.theme.fontFamily
        'CORNER_RADIUS'      = $Branding.theme.cornerRadius
        'ACCENT_COLOR'       = $Palette.AccentColor
        'ACCENT_HOVER'       = $Palette.AccentHover
        'ACCENT_PRESSED'     = $Palette.AccentPressed
        'BG_COLOR'           = $Palette.BgColor
        'SURFACE_COLOR'      = $Palette.SurfaceColor
        'SURFACE_ALT_COLOR'  = $Palette.SurfaceAltColor
        'BORDER_COLOR'       = $Palette.BorderColor
        'TEXT_PRIMARY'       = $Palette.TextPrimary
        'TEXT_SECONDARY'     = $Palette.TextSecondary
        'TEXT_MUTED'         = $Palette.TextMuted
        'SEARCH_PLACEHOLDER' = (Get-AtlasString 'search.placeholder')
        'HEADER_LOGS'        = (Get-AtlasString 'header.logs')
        'HEADER_ABOUT'       = (Get-AtlasString 'header.about')
        'STATUS_READY'       = (Get-AtlasString 'status.ready')
    }
    foreach ($k in $map.Keys) {
        $Xaml = $Xaml.Replace("{{$k}}", [string]$map[$k])
    }
    return $Xaml
}

function New-AtlasToolCard {
    param(
        [hashtable]$Tool,
        [hashtable]$Branding,
        [hashtable]$Palette
    )

    $width = 320
    $xaml = @"
<Border xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'
        xmlns:x='http://schemas.microsoft.com/winfx/2006/xaml'
        Background='$($Palette.SurfaceColor)'
        BorderBrush='$($Palette.BorderColor)'
        BorderThickness='1'
        CornerRadius='$($Branding.theme.cornerRadius)'
        Padding='16'
        Margin='0,0,12,12'
        Width='$width'>
    <StackPanel>
        <StackPanel Orientation='Horizontal' Margin='0,0,0,6'>
            <TextBlock Text='{{ICON}}' FontSize='18' Margin='0,0,8,0' Foreground='$($Palette.AccentColor)'/>
            <TextBlock Text='{{NAME}}' FontSize='15' FontWeight='SemiBold' Foreground='$($Palette.TextPrimary)' TextTrimming='CharacterEllipsis'/>
        </StackPanel>
        <TextBlock Text='{{DESCRIPTION}}'
                   Foreground='$($Palette.TextSecondary)'
                   FontSize='12'
                   TextWrapping='Wrap'
                   Height='56'
                   Margin='0,0,0,10'/>
        <StackPanel Orientation='Horizontal'>
            <Button x:Name='BtnRun' Content='{{BTN_RUN}}' Tag='{{ID}}' Padding='14,6'
                    Background='$($Palette.AccentColor)' Foreground='White'
                    BorderBrush='$($Palette.AccentColor)' BorderThickness='1'
                    Cursor='Hand'/>
            <TextBlock x:Name='AdminIcon' Text='{{ADMIN_BADGE}}'
                       Foreground='$($Palette.TextMuted)' FontSize='11'
                       Margin='12,0,0,0' VerticalAlignment='Center'/>
        </StackPanel>
    </StackPanel>
</Border>
"@

    $iconMap = @{
        'diagnostico'   = '🔍'
        'mantenimiento' = '🛠'
        'copia'         = '📁'
        'redes'         = '🌐'
        'seguridad'     = '🔒'
        'software'      = '📦'
        'entrega'       = '✅'
    }
    $icon = $iconMap[$Tool.category]
    if (-not $icon) { $icon = '⚙' }

    $adminBadge = if ($Tool.requiresAdmin) { (Get-AtlasString 'badge.requiresAdmin') } else { "" }
    $btnRunText = Get-AtlasString 'button.run'

    $xaml = $xaml.Replace('{{ICON}}', $icon).
                  Replace('{{NAME}}', [System.Security.SecurityElement]::Escape($Tool.name)).
                  Replace('{{DESCRIPTION}}', [System.Security.SecurityElement]::Escape($Tool.description)).
                  Replace('{{ID}}', $Tool.id).
                  Replace('{{BTN_RUN}}', [System.Security.SecurityElement]::Escape($btnRunText)).
                  Replace('{{ADMIN_BADGE}}', $adminBadge)

    return $xaml
}

function Show-AtlasWindow {
    param(
        [hashtable]$Branding,
        [array]$Tools,
        [string]$XamlTemplate
    )

    Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

    $palette = Get-AtlasPalette -Branding $Branding
    $xaml    = Expand-AtlasXaml -Xaml $XamlTemplate -Branding $Branding -Palette $palette

    try {
        [xml]$xamlDoc = $xaml
    } catch {
        throw "XAML inválido tras expansión de branding: $_"
    }

    $reader = New-Object System.Xml.XmlNodeReader $xamlDoc
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # Agarrar controles
    $categoryBar = $window.FindName('CategoryBar')
    $toolsGrid   = $window.FindName('ToolsGrid')
    $searchBox   = $window.FindName('SearchBox')
    $statusText  = $window.FindName('StatusText')
    $adminBadge  = $window.FindName('AdminBadge')
    $btnLogs     = $window.FindName('BtnLogs')
    $btnAbout    = $window.FindName('BtnAbout')

    # Badge de admin en header
    if (Test-IsAdmin) {
        $adminBadge.Text = Get-AtlasString 'header.admin'
        $adminBadge.Foreground = [System.Windows.Media.Brushes]::LimeGreen
    } else {
        $adminBadge.Text = Get-AtlasString 'header.user'
    }

    # Categorías — usa label traducido si el brand no sobreescribe
    $categories = @($Branding.categories) | Sort-Object -Property order
    $allCat = New-Object System.Windows.Controls.RadioButton
    $allCat.Content = Get-AtlasString 'category.all'
    $allCat.Style = $window.FindResource('CategoryPill')
    $allCat.Tag = '__all__'
    $allCat.IsChecked = $true
    [void]$categoryBar.Children.Add($allCat)

    foreach ($cat in $categories) {
        $rb = New-Object System.Windows.Controls.RadioButton
        $translatedLabel = Get-AtlasString "category.$($cat.id)"
        $label = if ($translatedLabel -ne "category.$($cat.id)") { $translatedLabel } else { $cat.label }
        $rb.Content = "$($cat.icon) $label"
        $rb.Style = $window.FindResource('CategoryPill')
        $rb.Tag = $cat.id
        [void]$categoryBar.Children.Add($rb)
    }

    # Renderizar tools
    $script:AllCards = @()
    foreach ($tool in $Tools) {
        $cardXaml = New-AtlasToolCard -Tool $tool -Branding $Branding -Palette $palette
        [xml]$cardDoc = $cardXaml
        $cardReader = New-Object System.Xml.XmlNodeReader $cardDoc
        $card = [Windows.Markup.XamlReader]::Load($cardReader)
        $card.Tag = $tool

        # Walk visual tree robustly para encontrar el boton "Run"
        $btn = Find-AtlasDescendant -Root $card -Type ([System.Windows.Controls.Button])
        if ($btn) {
            # Guardar el tool completo en el Tag del boton, evita depender de scope compartido
            $btn.Tag = $tool
            Write-AtlasLog ("Bound click handler: tool={0}" -f $tool.id) -Level DEBUG

            $btn.Add_Click({
                param($eventSender, $eventArgs)
                try {
                    # $eventSender es el boton, fallback a $this si PowerShell no lo binde
                    $theBtn = if ($eventSender) { $eventSender } else { $this }
                    $t = $theBtn.Tag
                    if (-not $t) {
                        Write-AtlasLog "Click: Button.Tag esta vacio" -Level WARN
                        return
                    }
                    Write-AtlasLog ("Click: lanzando tool={0} function={1}" -f $t.id, $t.function) -Level INFO

                    $statusText = $script:MainWindow.FindName('StatusText')
                    if ($statusText) { $statusText.Text = Get-AtlasString 'status.launching' $t.name }

                    Invoke-AtlasTool -Tool $t -Branding $script:Branding

                    if ($statusText) { $statusText.Text = Get-AtlasString 'status.lastRun' $t.name }
                } catch {
                    Write-AtlasLog ("Click handler fallo: {0}" -f $_.Exception.Message) -Level ERROR
                    [System.Windows.MessageBox]::Show(
                        "Error al lanzar la herramienta:`n`n$($_.Exception.Message)",
                        "Atlas PC Support",
                        'OK', 'Error') | Out-Null
                }
            })
        } else {
            Write-AtlasLog ("NO se encontro el boton Run para tool={0}" -f $tool.id) -Level ERROR
        }

        $script:AllCards += [pscustomobject]@{ Card = $card; Tool = $tool }
        [void]$toolsGrid.Items.Add($card)
    }

    # Función filtro
    $applyFilter = {
        $selectedCat = ($categoryBar.Children | Where-Object { $_.IsChecked }).Tag
        $query = $searchBox.Text.Trim().ToLower()

        $toolsGrid.Items.Clear()
        foreach ($entry in $script:AllCards) {
            $t = $entry.Tool
            $matchesCat = ($selectedCat -eq '__all__') -or ($t.category -eq $selectedCat)
            $matchesQuery = (-not $query) -or ($t.name.ToLower().Contains($query)) -or ($t.description.ToLower().Contains($query))
            if ($matchesCat -and $matchesQuery) {
                [void]$toolsGrid.Items.Add($entry.Card)
            }
        }
        $statusText.Text = Get-AtlasString 'status.toolsShown' $toolsGrid.Items.Count
    }

    foreach ($rb in $categoryBar.Children) {
        $rb.Add_Checked($applyFilter)
    }
    $searchBox.Add_TextChanged($applyFilter)

    # Botones header
    $btnLogs.Add_Click({
        $logPath = Get-AtlasLogPath
        if (Test-Path $logPath) {
            Start-Process notepad.exe -ArgumentList $logPath
        } else {
            [System.Windows.MessageBox]::Show((Get-AtlasString 'logs.empty'), $script:Branding.brand.shortName) | Out-Null
        }
    })
    $btnAbout.Add_Click({
        $webLabel = Get-AtlasString 'about.web'
        $tagline = if ($script:Branding.brand.tagline) { $script:Branding.brand.tagline } else { Get-AtlasString 'app.tagline' }
        $msg = @"
$($script:Branding.brand.name) v$($script:Branding.brand.version)

$tagline

$($webLabel): $($script:Branding.brand.companyUrl)
$($script:Branding.brand.copyright)

$(Get-AtlasString 'about.description')
"@
        [System.Windows.MessageBox]::Show($msg, (Get-AtlasString 'about.title'), "OK", "Information") | Out-Null
    })

    $script:MainWindow = $window
    $script:Branding = $Branding
    $script:AllTools = $Tools

    [void]$window.ShowDialog()
}


# ============================================================
#  HERRAMIENTAS (tools/)
# ============================================================

# ---- tools\Invoke-AuditoriaRouter.ps1 ----
# ============================================================
# Invoke-AuditoriaRouter
# Migrado de: AuditoriaRouter.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-AuditoriaRouter {
    [CmdletBinding()]
    param(
        # Modulo O: lanza el informe completo sin interaccion
        [switch]$Auto
    )
# (#Requires movido al launcher principal)
# ================================================================
#  Atlas PC Support - Herramientas de Red  v3.0
#  Compatibilidad: Windows 10 / 11 / Server 2019+, PS 5+
# ================================================================
[console]::BackgroundColor = "Black"
[console]::ForegroundColor = "Gray"
Clear-Host

# ================================================================
#  VARIABLES GLOBALES DE SESION
# ================================================================
$script:HistorialSesion = [System.Collections.Generic.List[string]]::new()
$script:ArchivoEstado   = "$env:TEMP\AtlasRed_UltimoEscaneo.txt"
$script:MostrarInfo     = $true        # El usuario puede deshabilitarlo con X en la info card
$script:ModoAuto        = $Auto.IsPresent

# ================================================================
#  TABLA OUI - Prefijos MAC (3 octetos) -> Fabricante
#  ~200 entradas de los fabricantes mas comunes en redes domesticas
# ================================================================
$script:OUI = @{
    # Apple
    "00-17-F2"="Apple";"00-1C-BF"="Apple";"00-1E-52"="Apple";"00-23-12"="Apple"
    "00-26-B9"="Apple";"3C-07-54"="Apple";"F4-F1-5A"="Apple";"04-15-52"="Apple"
    "04-26-65"="Apple";"60-03-08"="Apple";"60-C5-47"="Apple";"70-EC-E4"="Apple"
    "78-D7-5F"="Apple";"A4-5E-60"="Apple";"AC-87-A3"="Apple";"B8-8D-12"="Apple"
    "C8-BC-C8"="Apple";"F0-B4-79"="Apple";"D8-BB-C1"="Apple";"E0-AC-CB"="Apple"
    "00-F7-6F"="Apple";"04-4B-ED"="Apple";"04-E5-36"="Apple";"08-74-02"="Apple"
    "0C-4D-E9"="Apple";"10-41-7F"="Apple";"14-5A-05"="Apple";"18-65-90"="Apple"
    "1C-36-BB"="Apple";"20-78-F0"="Apple";"24-A0-74"="Apple";"28-5A-EB"="Apple"
    "34-15-9E"="Apple";"38-C9-86"="Apple";"3C-15-C2"="Apple";"40-30-04"="Apple"
    "44-00-10"="Apple";"48-60-BC"="Apple";"4C-57-CA"="Apple";"50-EA-D6"="Apple"
    "54-26-96"="Apple";"58-55-CA"="Apple";"5C-8D-4E"="Apple";"60-9A-10"="Apple"
    "64-A3-CB"="Apple";"68-AB-1E"="Apple";"6C-40-08"="Apple";"70-14-A6"="Apple"
    "74-E1-B6"="Apple";"78-CA-39"="Apple";"7C-6D-62"="Apple";"80-82-23"="Apple"
    "84-38-35"="Apple";"88-1F-A1"="Apple";"8C-7B-9D"="Apple";"90-3C-92"="Apple"
    "94-F6-A3"="Apple";"98-01-A7"="Apple";"9C-20-7B"="Apple";"A0-99-9B"="Apple"
    "A4-C3-61"="Apple";"A8-5B-78"="Apple";"AC-3C-0B"="Apple";"B0-34-95"="Apple"
    "B4-18-D1"="Apple";"B8-09-8A"="Apple";"BC-3B-AF"="Apple";"C0-9F-42"="Apple"
    "C4-2C-03"="Apple";"C8-2A-14"="Apple";"CC-44-63"="Apple";"D0-03-4B"="Apple"
    "D4-61-9D"="Apple";"D8-1D-72"="Apple";"DC-2B-2A"="Apple";"E0-5F-45"="Apple"
    "E4-CE-8F"="Apple";"E8-80-2E"="Apple";"EC-35-86"="Apple";"F0-DC-E2"="Apple"
    "F4-31-C3"="Apple";"F8-1E-DF"="Apple";"FC-25-3F"="Apple"
    # TP-Link
    "00-0A-EB"="TP-Link";"14-CF-92"="TP-Link";"18-D6-C7"="TP-Link";"20-DC-E6"="TP-Link"
    "28-28-5D"="TP-Link";"30-DE-4B"="TP-Link";"50-C7-BF"="TP-Link";"54-E6-FC"="TP-Link"
    "60-E3-27"="TP-Link";"70-4F-57"="TP-Link";"74-DA-88"="TP-Link";"84-16-F9"="TP-Link"
    "90-F6-52"="TP-Link";"98-DA-C4"="TP-Link";"B0-48-7A"="TP-Link";"C4-6E-1F"="TP-Link"
    "C8-3A-35"="TP-Link";"D8-07-B6"="TP-Link";"EC-08-6B"="TP-Link";"F8-1A-67"="TP-Link"
    "C4-E9-84"="TP-Link";"34-29-12"="TP-Link";"44-94-FC"="TP-Link";"50-3E-AA"="TP-Link"
    "64-70-02"="TP-Link";"7C-39-56"="TP-Link";"80-35-C1"="TP-Link";"AC-84-C6"="TP-Link"
    "B4-B0-24"="TP-Link";"D4-6E-5C"="TP-Link";"F4-EC-38"="TP-Link";"1C-3B-F3"="TP-Link"
    # ASUS
    "00-0C-6E"="ASUS";"00-11-2F"="ASUS";"00-13-D4"="ASUS";"00-15-F2"="ASUS"
    "00-17-31"="ASUS";"00-1A-92"="ASUS";"00-1D-60"="ASUS";"00-1E-8C"="ASUS"
    "00-24-8C"="ASUS";"00-26-18"="ASUS";"04-92-26"="ASUS";"08-60-6E"="ASUS"
    "10-BF-48"="ASUS";"14-DA-E9"="ASUS";"1C-87-2C"="ASUS";"2C-4D-54"="ASUS"
    "30-5A-3A"="ASUS";"38-D5-47"="ASUS";"50-46-5D"="ASUS";"60-45-CB"="ASUS"
    "74-D0-2B"="ASUS";"90-E6-BA"="ASUS";"A0-F3-C1"="ASUS";"AC-22-0B"="ASUS"
    "B0-6E-BF"="ASUS";"BC-AE-C5"="ASUS";"C8-60-00"="ASUS";"FC-34-97"="ASUS"
    "04-D9-F5"="ASUS";"08-62-66"="ASUS";"0C-9D-92"="ASUS";"10-78-D2"="ASUS"
    ;"18-31-BF"="ASUS";"20-CF-30"="ASUS";"24-4B-FE"="ASUS"
    "2C-56-DC"="ASUS";"3C-97-0E"="ASUS";"40-16-7E"="ASUS"
    "44-8A-5B"="ASUS";"48-5B-39"="ASUS";"4C-ED-FB"="ASUS";"50-AF-73"="ASUS"
    "54-04-A6"="ASUS";"58-11-22"="ASUS";"5C-AD-CF"="ASUS";"60-A4-4C"="ASUS"
    "64-00-6A"="ASUS";"68-1C-A2"="ASUS";"6C-FD-B9"="ASUS";"70-4D-7B"="ASUS"
    ;"78-24-AF"="ASUS";"7C-10-C9"="ASUS";"80-1F-02"="ASUS"
    "84-A9-C4"="ASUS";"88-D7-F6"="ASUS";"8C-8D-28"="ASUS";"90-48-9A"="ASUS"
    "94-08-53"="ASUS";"98-EE-CB"="ASUS";"9C-5C-8E"="ASUS";"A8-5E-45"="ASUS"
    "BC-EE-7B"="ASUS";"C8-D3-FF"="ASUS";"CC-28-AA"="ASUS";"D0-17-C2"="ASUS"
    # Samsung
    "00-1D-25"="Samsung";"00-21-19"="Samsung";"00-23-39"="Samsung";"00-24-54"="Samsung"
    "08-08-C2"="Samsung";"10-1D-C0"="Samsung";"14-49-E0"="Samsung";"18-1E-B0"="Samsung"
    "1C-62-B8"="Samsung";"24-4B-81"="Samsung";"28-98-7B"="Samsung";"38-AA-3C"="Samsung"
    "40-0E-85"="Samsung";"44-78-3E"="Samsung";"50-01-BB"="Samsung";"5C-3C-27"="Samsung"
    "60-6B-BD"="Samsung";"6C-2F-2C"="Samsung";"70-F9-27"="Samsung";"84-25-DB"="Samsung"
    "8C-71-F8"="Samsung";"94-76-B7"="Samsung";"A0-07-98"="Samsung";"B4-79-A7"="Samsung"
    "CC-07-AB"="Samsung";"DC-A9-04"="Samsung";"F0-25-B7"="Samsung";"FC-A1-3E"="Samsung"
    "2C-AE-2B"="Samsung";"34-14-5F"="Samsung";"40-B8-37"="Samsung";"48-13-7E"="Samsung"
    "50-CC-F8"="Samsung";"5C-E8-EB"="Samsung";"68-48-98"="Samsung";"78-59-5E"="Samsung"
    "84-55-A5"="Samsung";"8C-A9-82"="Samsung";"90-18-7C"="Samsung";"9C-3A-AF"="Samsung"
    "A4-EB-D3"="Samsung";"BC-20-A4"="Samsung";"C0-BD-D1"="Samsung";"C4-57-6E"="Samsung"
    # Xiaomi
    "0C-1D-AF"="Xiaomi";"10-2A-B3"="Xiaomi";"28-6C-07"="Xiaomi";"34-80-B3"="Xiaomi"
    "38-A4-ED"="Xiaomi";"50-8F-4C"="Xiaomi";"64-09-80"="Xiaomi";"74-23-44"="Xiaomi"
    "78-11-DC"="Xiaomi";"8C-BE-BE"="Xiaomi";"A0-86-C6"="Xiaomi";"AC-F7-F3"="Xiaomi"
    "B0-E4-35"="Xiaomi";"C4-0B-CB"="Xiaomi";"D4-97-0B"="Xiaomi";"F4-8B-32"="Xiaomi"
    "FC-64-BA"="Xiaomi";"64-B4-73"="Xiaomi";"00-9E-C8"="Xiaomi";"04-CF-8C"="Xiaomi"
    "18-59-36"="Xiaomi";"20-82-C0"="Xiaomi";"28-E3-1F"="Xiaomi";"34-CE-00"="Xiaomi"
    "40-31-3C"="Xiaomi";"48-2C-A0"="Xiaomi";"50-64-2B"="Xiaomi";"58-44-98"="Xiaomi"
    # Huawei
    "00-0F-E2"="Huawei";"00-18-82"="Huawei";"00-1E-10"="Huawei";"00-25-9E"="Huawei"
    "04-BD-70"="Huawei";"0C-37-96"="Huawei";"1C-8E-5C"="Huawei";"28-3C-E4"="Huawei"
    "2C-AB-00"="Huawei";"34-6B-D3"="Huawei";"40-4D-8E"="Huawei";"48-46-FB"="Huawei"
    "54-89-98"="Huawei";"5C-C3-07"="Huawei";"60-DE-44"="Huawei";"70-72-CF"="Huawei"
    "78-1D-BA"="Huawei";"80-38-BC"="Huawei";"98-E7-F4"="Huawei";"A0-08-6F"="Huawei"
    "C8-51-95"="Huawei";"D4-12-43"="Huawei";"E8-CD-2D"="Huawei";"F4-63-1F"="Huawei"
    "04-C0-6F"="Huawei";"08-19-A6"="Huawei";"10-1B-54"="Huawei";"14-B9-68"="Huawei"
    "18-C5-8A"="Huawei";"20-08-ED"="Huawei";"24-69-A5"="Huawei";"2C-E8-75"="Huawei"
    "30-87-D9"="Huawei";"3C-47-11"="Huawei";"44-6A-B7"="Huawei";"48-DB-50"="Huawei"
    # NETGEAR
    "00-1A-4B"="NETGEAR";"00-1B-2F"="NETGEAR";"00-1E-2A"="NETGEAR";"00-22-3F"="NETGEAR"
    "00-24-B2"="NETGEAR";"20-4E-7F"="NETGEAR";"28-C6-8E"="NETGEAR";"2C-B0-5D"="NETGEAR"
    "6C-F0-49"="NETGEAR";"84-1B-5E"="NETGEAR";"9C-D3-6D"="NETGEAR";"A0-40-A0"="NETGEAR"
    "C0-3F-0E"="NETGEAR";"E0-91-F5"="NETGEAR";"E4-F4-C6"="NETGEAR";"10-DA-43"="NETGEAR"
    "30-46-9A"="NETGEAR";"6C-B0-CE"="NETGEAR";"80-37-73"="NETGEAR"
    # D-Link
    "00-0D-88"="D-Link";"00-11-95"="D-Link";"00-13-46"="D-Link";"00-15-E9"="D-Link"
    "00-17-9A"="D-Link";"00-19-5B"="D-Link";"00-1B-11"="D-Link";"00-1C-F0"="D-Link"
    "00-21-91"="D-Link";"00-22-B0"="D-Link";"00-24-01"="D-Link";"00-26-5A"="D-Link"
    "14-D6-4D"="D-Link";"1C-7E-E5"="D-Link";"28-10-7B"="D-Link";"34-08-04"="D-Link"
    "5C-D9-98"="D-Link";"78-54-2E"="D-Link";"90-94-E4"="D-Link";"B8-A3-86"="D-Link"
    "C8-BE-19"="D-Link";"CC-B2-55"="D-Link";"F0-7D-68"="D-Link";"FC-75-16"="D-Link"
    "18-0F-76"="D-Link";"20-E5-2A"="D-Link";"40-9B-CD"="D-Link"
    # Intel (NICs en laptops/PCs)
    "00-0E-35"="Intel";"00-16-EA"="Intel";"00-1B-21"="Intel";"00-1E-67"="Intel"
    "00-21-6A"="Intel";"00-22-FB"="Intel";"00-24-D7"="Intel"
    "A0-88-B4"="Intel";"A4-C3-F0"="Intel";"B8-CA-3A"="Intel";"C4-85-08"="Intel"
    "DC-53-60"="Intel";"E8-2A-EA"="Intel";"F8-34-41"="Intel";"7C-5C-F8"="Intel"
    "00-00-F0"="Intel";"00-02-B3"="Intel";"00-03-47"="Intel";"00-04-23"="Intel"
    "00-07-E9"="Intel";"00-0C-F1"="Intel";"00-0E-0C"="Intel";"00-12-F0"="Intel"
    "00-13-02"="Intel";"00-13-20"="Intel";"00-13-CE"="Intel";"00-15-00"="Intel"
    "00-16-76"="Intel";"00-19-D1"="Intel";"00-1C-C0"="Intel";"00-1D-E0"="Intel"
    "00-1F-3B"="Intel";"00-21-5C"="Intel";"00-23-14"="Intel";"00-23-AE"="Intel"
    ;"00-26-C6"="Intel";"00-27-10"="Intel";"04-0E-3C"="Intel"
    # Cisco / Linksys
    "00-14-BF"="Cisco/Linksys";"00-18-F8"="Cisco/Linksys";"00-1A-70"="Cisco"
    "00-1B-54"="Cisco";"00-1C-10"="Cisco";"00-22-BD"="Cisco";"00-23-BE"="Cisco"
    "00-25-2E"="Cisco";"0C-D9-96"="Cisco";"1C-E6-C7"="Cisco";"58-AC-78"="Cisco"
    "64-9E-F3"="Cisco";"84-78-AC"="Cisco";"98-90-96"="Cisco";"A4-6C-2A"="Cisco"
    "B4-14-89"="Cisco";"C8-00-84"="Cisco";"DC-8C-37"="Cisco";"F0-29-29"="Cisco"
    "00-02-16"="Cisco";"00-03-6B"="Cisco";"00-04-DD"="Cisco";"00-05-DC"="Cisco"
    "00-06-28"="Cisco";"00-07-0D"="Cisco";"00-08-A3"="Cisco";"00-09-12"="Cisco"
    "00-0A-8A"="Cisco";"00-0B-BE"="Cisco";"00-0C-85"="Cisco";"00-0D-29"="Cisco"
    "00-0E-D7"="Cisco";"00-0F-8F"="Cisco";"00-10-07"="Cisco";"00-10-79"="Cisco"
    "00-10-F6"="Cisco";"00-11-21"="Cisco";"00-12-00"="Cisco";"00-13-19"="Cisco"
    # Google (Chromecast, Nest, Pixel, Home)
    "00-1A-11"="Google";"08-9E-08"="Google";"20-DF-B9"="Google";"3C-5A-B4"="Google"
    "48-D6-D5"="Google";"54-60-09"="Google";"6C-AD-F8"="Google";"A4-77-33"="Google"
    "AC-67-B2"="Google";"F4-F5-D8"="Google";"58-CB-52"="Google";"D8-EB-97"="Google"
    "1C-F2-9A"="Google";"30-FD-38"="Google";"38-8B-59"="Google";"4C-BC-98"="Google"
    "54-52-00"="Google";"7C-1E-06"="Google";"9C-9D-7E"="Google"
    # Amazon (Alexa, Echo, Fire TV, Kindle)
    "00-BB-3A"="Amazon";"18-74-2E"="Amazon";"34-D2-70"="Amazon";"40-B4-CD"="Amazon"
    "44-65-0D"="Amazon";"50-DC-E7"="Amazon";"68-37-E9"="Amazon";"78-E1-03"="Amazon"
    "84-D6-D0"="Amazon";"A0-02-DC"="Amazon";"B4-7C-59"="Amazon";"F0-27-2D"="Amazon"
    "0C-47-C9"="Amazon";"10-AE-60"="Amazon";"28-EF-01"="Amazon"
    ;"40-4E-36"="Amazon";"50-F5-DA"="Amazon"
    "74-75-48"="Amazon";"FC-A1-83"="Amazon"
    # Microsoft (Surface, Xbox, HoloLens)
    "00-03-FF"="Microsoft";"00-15-5D"="Hyper-V";"00-1D-D8"="Microsoft"
    "28-18-78"="Microsoft";"48-50-73"="Microsoft";"7C-1E-52"="Microsoft"
    "DC-B4-C4"="Microsoft";"98-5F-D3"="Microsoft";"60-45-BD"="Microsoft"
    "00-50-F2"="Microsoft";"70-77-81"="Microsoft"
    # Raspberry Pi Foundation
    "28-CD-C1"="Raspberry Pi";"B8-27-EB"="Raspberry Pi"
    "DC-A6-32"="Raspberry Pi";"E4-5F-01"="Raspberry Pi"
    # Ubiquiti (UniFi, AmpliFi, EdgeRouter)
    "00-15-6D"="Ubiquiti";"00-27-22"="Ubiquiti";"04-18-D6"="Ubiquiti"
    "24-A4-3C"="Ubiquiti";"44-D9-E7"="Ubiquiti";"68-72-51"="Ubiquiti"
    "74-83-C2"="Ubiquiti";"78-8A-20"="Ubiquiti";"80-2A-A8"="Ubiquiti"
    "DC-9F-DB"="Ubiquiti";"F0-9F-C2"="Ubiquiti";"18-E8-29"="Ubiquiti"
    # Virtualizacion
    "00-0C-29"="VMware";"00-50-56"="VMware";"00-05-69"="VMware"
    "08-00-27"="VirtualBox";"52-54-00"="QEMU/KVM"
    # Realtek (chips de red genericos en placas base)
    "00-E0-4C"="Realtek";"00-01-6C"="Realtek";"52-54-AB"="Realtek"
    # Otros fabricantes de red comunes
    "00-10-18"="Broadcom";"00-10-4A"="3Com";"00-60-08"="3Com";"00-00-F4"="Allied Telesis"
    "00-00-0C"="Cisco";"00-AA-00"="Intel";"02-00-4C"="Hyper-V"
}
# ================================================================
#  DATOS DE LAS PANTALLAS DE INFORMACION POR MODULO
# ================================================================
$script:Info = @{
    "A" = @{
        Titulo = "Auditoria de Puertos LAN"
        Color  = "Cyan"
        Desc   = @(
            "Prueba conexion TCP a los puertos mas relevantes del router",
            "usando TcpClient con timeout de 1 segundo por puerto. Es mucho",
            "mas rapido que Test-NetConnection porque no espera al ICMP.",
            "Puertos base: 21, 22, 23, 80, 443, 8080, 8443, 8888, 9090.",
            "Puedes agregar puertos adicionales al inicio del escaneo."
        )
        Prec   = @(
            "Algunos routers con IDS/IPS registran el escaneo en sus logs.",
            "  Inofensivo, pero puede aparecer como 'actividad sospechosa'.",
            "No ejecutar contra una IP que no sea tu propio gateway.",
            "Falsos negativos posibles si el router usa DROP en vez de REJECT."
        )
        Recs   = @(
            "Ejecuta A antes de C para saber si el panel usa HTTP o HTTPS.",
            "Combina con el modulo H para saber si esos puertos estan en WAN.",
            "Si el puerto 23 (Telnet) aparece abierto, cerrarlo es urgente:",
            "  Panel del router -> Administracion -> desactivar Telnet."
        )
        Ejem   = @(
            "Panel del router inaccesible: comprueba si 80 o 443 responden.",
            "  Si ambos estan cerrados, el panel de administracion esta OFF.",
            "Router lento sin razon aparente: Telnet abierto puede indicar",
            "  acceso remoto activo no autorizado drenando recursos."
        )
    }
    "B" = @{
        Titulo = "Escaneo de Dispositivos + Deteccion de IPs Duplicadas"
        Color  = "Cyan"
        Desc   = @(
            "Envia pings a toda la subred (.1 a .254) y registra cada",
            "dispositivo que responde. Muestra IP, MAC, nombre DNS y",
            "fabricante. Detecta conflictos de IP (mismo MAC, distinta IP)",
            "que pueden causar cortes aleatorios de conexion."
        )
        Prec   = @(
            "El escaneo de 254 hosts puede tardar entre 30 y 90 segundos.",
            "Dispositivos con firewall activo pueden no responder al ping",
            "  aunque esten conectados (falsos negativos esperables).",
            "El nombre DNS puede quedar como 'Oculto' en muchos dispositivos."
        )
        Recs   = @(
            "Ejecutar cuando el cliente reporta 'alguien se colo en mi WiFi'",
            "  o cuando hay cortes aleatorios de red sin razon aparente.",
            "Combina con el modulo N (comparativa) para ver cambios en el tiempo.",
            "Usa el modulo J para ver los fabricantes de forma agrupada."
        )
        Ejem   = @(
            "Dos dispositivos con la misma IP causan desconexiones aleatorias:",
            "  el escaneo mostrara una alerta de conflicto de IP.",
            "Dispositivo con MAC desconocida en la lista: podria ser un",
            "  intruso - investigar con el modulo J."
        )
    }
    "C" = @{
        Titulo = "Abrir Panel del Router (deteccion automatica HTTP/S)"
        Color  = "Cyan"
        Desc   = @(
            "Detecta si el router acepta HTTPS (puerto 443) o HTTP (puerto 80)",
            "antes de abrir el navegador, y usa el protocolo correcto.",
            "Evita el error tipico de teclear http:// en un router que solo",
            "responde en https:// o viceversa."
        )
        Prec   = @(
            "Algunos routers con proteccion CSRF bloquean accesos desde",
            "  enlaces directos. En ese caso, abre el navegador manualmente.",
            "La advertencia 'Conexion no segura' en HTTPS es completamente",
            "  normal en redes locales (certificado autofirmado)."
        )
        Recs   = @(
            "Ejecuta primero el modulo A para confirmar que al menos uno",
            "  de los puertos (80 o 443) esta activo.",
            "Credenciales por defecto comunes: admin/admin, admin/1234,",
            "  admin/(en blanco). Consulta la etiqueta debajo del router."
        )
        Ejem   = @(
            "Soporte rapido: acceso al panel sin recordar si es http o https.",
            "Router con HTTPS habilitado: el modulo C abre directamente",
            "  la version segura para evitar la advertencia del navegador."
        )
    }
    "D" = @{
        Titulo = "Diagnostico de Latencia y Estabilidad"
        Color  = "Yellow"
        Desc   = @(
            "Envia 10 pings a tres destinos: el router (LAN), Cloudflare",
            "(1.1.1.1) y Google (8.8.8.8). Calcula minimo, maximo y media.",
            "Identifica automaticamente si el problema esta en la red local",
            "o en el proveedor de Internet (ISP)."
        )
        Prec   = @(
            "Los pings a Internet pueden bloquearse con VPN activa,",
            "  dando falsos negativos en los destinos WAN.",
            "En redes corporativas algunos firewalls bloquean ICMP.",
            "Un solo test no es representativo: ejecutar en distintos momentos."
        )
        Recs   = @(
            "Latencia al router > 20ms = problema en la red local (WiFi, cable).",
            "Latencia a Internet > 100ms = probable problema con el ISP.",
            "Perdida de paquetes > 30% = fallo grave que requiere atencion.",
            "Comparar resultados en hora punta vs hora baja."
        )
        Ejem   = @(
            "Cliente reporta 'Internet lento': si el ping al router es alto",
            "  el problema es la LAN. Si el router responde bien pero 1.1.1.1",
            "  falla, llamar al ISP con los datos del test como evidencia.",
            "Videoconferencias que se cortan: buscar perdida de paquetes > 5%."
        )
    }
    "E" = @{
        Titulo = "Informacion Completa del Adaptador de Red"
        Color  = "White"
        Desc   = @(
            "Muestra todos los datos del adaptador de red activo: nombre,",
            "descripcion, estado, velocidad de enlace, MAC propia, IP local,",
            "mascara de red (notacion /XX), puerta de enlace y servidores",
            "DNS configurados."
        )
        Prec   = @(
            "Si hay multiples adaptadores (VPN activa + adaptador fisico),",
            "  muestra el asociado a la ruta por defecto mas optima.",
            "La velocidad puede aparecer como N/A en adaptadores WiFi virtuales."
        )
        Recs   = @(
            "Ejecutar siempre como primer modulo en cualquier diagnostico.",
            "IP en 169.254.x.x (APIPA): el DHCP no esta respondiendo.",
            "DNS en 127.0.0.1: hay un servicio local actuando de DNS",
            "  (Pi-hole, VPN, DNSCrypt). Puede ser intencionado o no."
        )
        Ejem   = @(
            "PC sin Internet pero con IP correcta: verificar si el gateway",
            "  es el del router o uno incorrecto asignado por error.",
            "Maquina con velocidad 10Mbps en red Gigabit: cable o puerto",
            "  del switch en modo half-duplex o deteriorado."
        )
    }
    "F" = @{
        Titulo = "Test de Resolucion DNS"
        Color  = "White"
        Desc   = @(
            "Resuelve 5 dominios conocidos (Google, Cloudflare, Microsoft,",
            "Amazon, YouTube) midiendo el tiempo de respuesta en ms.",
            "Alerta si algun dominio tarda mas de 500ms o falla.",
            "Diagnostica si el problema de 'webs que no abren' es DNS."
        )
        Prec   = @(
            "Si el equipo usa un DNS local (Pi-hole, AdGuard), la latencia",
            "  puede ser mas alta sin que eso sea un problema.",
            "Fallos completos con ping funcional = DNS del router caido."
        )
        Recs   = @(
            "Si todos los dominios fallan pero el ping a 8.8.8.8 funciona,",
            "  el DNS esta caido. Solucion rapida: cambiar DNS a 1.1.1.1",
            "  en la configuracion de red del equipo o del router.",
            "Tiempos > 200ms de forma consistente: cambiar a DNS publico."
        )
        Ejem   = @(
            "Webs lentas pero descargas rapidas: el DNS esta tardando mucho",
            "  en resolver. Cambio a 1.1.1.1 suele solucionar el problema.",
            "Algunas webs no abren: resolucion selectiva fallando,",
            "  posible lista de bloqueo o cache DNS corrupta en el router."
        )
    }
    "H" = @{
        Titulo = "Deteccion de Puertos Peligrosos Expuestos en Internet (WAN)"
        Color  = "Red"
        Desc   = @(
            "Obtiene tu IP publica via api.ipify.org y escanea desde Internet",
            "los puertos mas peligrosos: 21 (FTP), 22 (SSH), 23 (Telnet),",
            "80 (HTTP), 443 (HTTPS), 3389 (RDP) y 8080 (HTTP-Alt).",
            "Detecta si tu router esta expuesto a ataques externos."
        )
        Prec   = @(
            "Algunos ISP usan CG-NAT: el resultado podria no reflejar",
            "  la exposicion real del router (IPs compartidas).",
            "Redes con hairpin NAT pueden reportar puertos como cerrados.",
            "SOLO escanear tu propia red. Nunca usar contra IPs ajenas."
        )
        Recs   = @(
            "Puerto 23 o 3389 abiertos desde Internet: URGENTE cerrarlos.",
            "  Panel del router -> Administracion remota -> desactivar.",
            "Puerto 22 abierto: cambiar SSH a un puerto no estandar",
            "  y habilitar autenticacion por clave, no por contrasena."
        )
        Ejem   = @(
            "Router recibiendo ataques de fuerza bruta: puertos 22 o 23",
            "  abiertos en WAN son el vector. Cerrarlos detiene el ataque.",
            "Cliente con Internet lento por las noches: puerto 23 abierto",
            "  puede indicar que el router esta siendo utilizado como proxy."
        )
    }
    "J" = @{
        Titulo = "Identificacion de Fabricantes por Prefijo MAC (OUI)"
        Color  = "White"
        Desc   = @(
            "Escanea la red y cruza cada MAC con una tabla local de 200+",
            "prefijos OUI para identificar el fabricante del chip de red.",
            "Muestra los resultados agrupados por fabricante para facilitar",
            "la identificacion de dispositivos desconocidos.",
            "No requiere conexion a Internet: la tabla esta embebida."
        )
        Prec   = @(
            "El OUI identifica al fabricante del CHIP de red, no del dispositivo.",
            "  Un router Xiaomi puede usar un chip Intel o Realtek.",
            "MACs aleatorizadas (Android 10+, iOS 14+, Windows 10 reciente)",
            "  pueden aparecer como 'Desconocido' o con fabricante incorrecto.",
            "La tabla cubre los mas comunes pero no es exhaustiva."
        )
        Recs   = @(
            "Cuando aparece un fabricante inesperado (Raspberry Pi, Amazon,",
            "  QEMU) en casa de un cliente, investigar ese dispositivo.",
            "Si varios dispositivos muestran el mismo fabricante (Intel),",
            "  es probable que sean laptops o PCs con NIC integrada."
        )
        Ejem   = @(
            "Aparece 'Raspberry Pi' en la red del cliente: alguien instalo",
            "  una mini-PC, posiblemente un servidor o un relay de red.",
            "Aparece 'Amazon': es un Echo, Fire TV, Kindle o Ring.",
            "Aparece 'VMware'/'QEMU': hay una maquina virtual en la red."
        )
    }
    "L" = @{
        Titulo = "Deteccion de Version de Firmware del Router"
        Color  = "DarkYellow"
        Desc   = @(
            "Intenta acceder sin autenticacion a rutas conocidas de paginas",
            "de informacion del firmware en TP-Link, ASUS, D-Link, Movistar",
            "y routers genericos. Extrae la version si la encuentra.",
            "Funciona en aproximadamente el 60-70% de los routers domesticos."
        )
        Prec   = @(
            "Algunos routers requieren login para mostrar la version.",
            "  En ese caso, usar el modulo C para acceder al panel.",
            "El resultado puede variar segun la configuracion del fabricante.",
            "No genera ningun cambio en el router: es solo lectura."
        )
        Recs   = @(
            "Si encuentras la version, comparar con la disponible en la web",
            "  del fabricante. Mas de 1 ano sin actualizar = riesgo.",
            "TP-Link y ASUS suelen exponer la version sin autenticacion.",
            "En caso de duda, acceder manualmente al panel (modulo C)."
        )
        Ejem   = @(
            "Router con firmware de 2019 en 2024: probablemente vulnerable",
            "  a CVEs publicos. Recomendar actualizacion al cliente.",
            "Version no encontrada: el router require login o no es compatible",
            "  con las rutas conocidas. Usar el modulo C manualmente."
        )
    }
    "M" = @{
        Titulo = "Informe Completo Automatico (A + E + F + D)"
        Color  = "Green"
        Desc   = @(
            "Ejecuta automaticamente los modulos A, E, F y D en secuencia",
            "sin interaccion del usuario. Al finalizar genera un unico",
            "archivo TXT consolidado con fecha y hora en el Escritorio.",
            "Ideal para inicio o fin de una visita de soporte tecnico."
        )
        Prec   = @(
            "La ejecucion completa tarda entre 2 y 5 minutos.",
            "  No cerrar la ventana a la mitad del proceso.",
            "Requiere conexion de red activa para todos los modulos.",
            "El archivo TXT se sobrescribe si ya existe uno del mismo segundo."
        )
        Recs   = @(
            "Lanzar al inicio de la visita para tener una linea base.",
            "Lanzar al final para documentar el estado tras los cambios.",
            "Enviar el TXT al cliente por email como registro de la visita.",
            "Para ejecutar sin interaccion desde un .bat: AuditoriaRouter.ps1 -Auto"
        )
        Ejem   = @(
            "Mantenimiento preventivo mensual: lanzar M, esperar, adjuntar",
            "  el TXT al ticket de soporte como evidencia del estado.",
            "Tarea programada: configurar en el Programador de Tareas de",
            "  Windows con el parametro -Auto para ejecucion nocturna."
        )
    }
    "N" = @{
        Titulo = "Comparativa de Dispositivos (Antes / Ahora)"
        Color  = "Magenta"
        Desc   = @(
            "Escanea la red actual y la compara con el ultimo escaneo",
            "guardado en disco. Muestra en verde los dispositivos nuevos",
            "y en rojo los que han desaparecido. Los dispositivos sin",
            "cambios se muestran en gris."
        )
        Prec   = @(
            "El estado guardado persiste entre sesiones en una carpeta temp.",
            "  Si se limpia %TEMP%, el historial se pierde.",
            "Dispositivos apagados pueden aparecer como 'desaparecidos'",
            "  aunque sigan perteneciendo a la red."
        )
        Recs   = @(
            "En la primera visita al cliente: ejecutar para guardar el estado base.",
            "En visitas posteriores: ejecutar para detectar dispositivos nuevos.",
            "Si aparece un dispositivo nuevo inesperado: cruzar con modulo J",
            "  para identificar el fabricante."
        )
        Ejem   = @(
            "Cliente dice 'alguien se conecto a mi WiFi': comparar con el",
            "  escaneo anterior para ver exactamente que dispositivo es nuevo.",
            "Tras cambiar la contrasena del WiFi: verificar que no queden",
            "  dispositivos del escaneo anterior que no deberian estar."
        )
    }
    "P" = @{
        Titulo = "Test de Velocidad de Descarga"
        Color  = "Yellow"
        Desc   = @(
            "Descarga un archivo de ~5MB desde los servidores de Cloudflare",
            "y mide la velocidad real de descarga en MB/s y Mbps.",
            "No depende de aplicaciones externas ni de Speedtest.net.",
            "Proporciona una estimacion rapida y sin instalacion."
        )
        Prec   = @(
            "El resultado puede variar con la carga del servidor y la hora.",
            "  Ejecutar varias veces para obtener una media representativa.",
            "Mide la velocidad del equipo, no del router: otros dispositivos",
            "  en la red consumiendo ancho de banda afectaran el resultado.",
            "Requiere acceso a Internet (cloudflare.com)."
        )
        Recs   = @(
            "Comparar el resultado con la velocidad contratada con el ISP.",
            "  Regla practica: se espera al menos el 70% de la velocidad",
            "  contratada en condiciones normales.",
            "Ejecutar tanto en WiFi como en cable para comparar diferencias."
        )
        Ejem   = @(
            "Cliente con 300 Mbps contratados obteniendo 5 Mbps: posible",
            "  QoS mal configurado, throttling del ISP o router saturado.",
            "Diferencia grande entre WiFi y cable: problema de cobertura o",
            "  interferencias en el canal WiFi. Recomendacion: cambiar canal."
        )
    }
    "Q" = @{
        Titulo = "Deteccion de Portal Cautivo"
        Color  = "DarkYellow"
        Desc   = @(
            "Hace una peticion HTTP a connectivitycheck.gstatic.com/generate_204.",
            "Si devuelve HTTP 204: conexion limpia a Internet.",
            "Si devuelve HTTP 200 o redirige: hay un portal cautivo activo",
            "que requiere aceptacion antes de navegar (hoteles, aeropuertos)."
        )
        Prec   = @(
            "En redes muy restrictivas puede dar falso positivo.",
            "  Verificar manualmente abriendo el navegador si hay duda.",
            "Algunos sistemas de control parental o filtros de contenido",
            "  pueden interceptar la peticion y dar un falso positivo."
        )
        Recs   = @(
            "Ejecutar cuando 'hay conexion WiFi pero las webs no cargan'.",
            "  Es el sintoma clasico del portal cautivo sin aceptar.",
            "Solucion: abrir cualquier URL HTTP (sin S) en el navegador.",
            "  Ejemplo: http://neverssl.com redirige siempre al portal."
        )
        Ejem   = @(
            "WiFi de hotel: ping funciona, DNS resuelve, pero webs no abren.",
            "  Portal cautivo sin aceptar los terminos. Abrir navegador.",
            "Red corporativa nueva: portal de registro de dispositivos activo.",
            "  El IT del cliente debe aprobar el MAC del equipo."
        )
    }
}

# ================================================================
#  FUNCIONES UTILITARIAS BASE
# ================================================================

function Escribir-Centrado {
    param([string]$Texto, [ConsoleColor]$Color = "Gray")
    $W = $Host.UI.RawUI.WindowSize.Width
    if ($Texto.Length -lt $W) {
        $Esp = [Math]::Floor(($W - $Texto.Length) / 2)
        Write-Host (" " * $Esp + $Texto) -ForegroundColor $Color
    } else {
        Write-Host $Texto -ForegroundColor $Color
    }
}

function Obtener-Router {
    $Routes = Get-NetRoute -DestinationPrefix "0.0.0.0/0" -ErrorAction SilentlyContinue |
              Sort-Object RouteMetric
    foreach ($R in $Routes) {
        $A = Get-NetAdapter -InterfaceIndex $R.InterfaceIndex -ErrorAction SilentlyContinue
        if ($A -and $A.InterfaceDescription -notmatch "VPN|TAP|Tunnel|WireGuard|OpenVPN|PPP|Loopback|Virtual") {
            return @{ Gateway = $R.NextHop; InterfaceIndex = $R.InterfaceIndex }
        }
    }
    $F = $Routes | Select-Object -First 1
    if ($F) { return @{ Gateway = $F.NextHop; InterfaceIndex = $F.InterfaceIndex } }
    return $null
}

function Obtener-SubredBase {
    param([string]$Gateway, [int]$InterfaceIndex)
    $C = Get-NetIPAddress -InterfaceIndex $InterfaceIndex -AddressFamily IPv4 `
         -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($C -and $C.PrefixLength -ge 24) {
        $O = $C.IPAddress.Split('.')
        return "$($O[0]).$($O[1]).$($O[2])"
    }
    return $Gateway.Substring(0, $Gateway.LastIndexOf('.'))
}

function Test-Puerto {
    param([string]$Destino, [int]$Puerto, [int]$TimeoutMs = 1000)
    try {
        $tcp   = New-Object System.Net.Sockets.TcpClient
        $async = $tcp.BeginConnect($Destino, $Puerto, $null, $null)
        $ok    = $async.AsyncWaitHandle.WaitOne($TimeoutMs, $false)
        if ($ok -and $tcp.Connected) { $tcp.EndConnect($async) | Out-Null; $tcp.Close(); return $true }
        $tcp.Close()
    } catch { }
    return $false
}

function Get-MACDesdeARP {
    param([string]$IP)
    try {
        foreach ($L in (arp -a $IP 2>$null)) {
            if ($L -match [regex]::Escape($IP) -and
                $L -match '([0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2})') {
                $M = $Matches[1].ToUpper()
                if ($M -ne "FF-FF-FF-FF-FF-FF" -and $M -ne "00-00-00-00-00-00") { return $M }
            }
        }
    } catch { }
    return "Desconocida"
}

function Get-Fabricante {
    param([string]$MAC)
    if ($MAC -eq "Desconocida") { return "Desconocido" }
    $Prefijo = ($MAC -replace ":", "-").ToUpper().Substring(0, 8)
    if ($script:OUI.ContainsKey($Prefijo)) { return $script:OUI[$Prefijo] }
    return "Desconocido"
}

function Exportar-Informe {
    param([string[]]$Contenido, [string]$NombreModulo)
    $Fecha      = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $Escritorio = [Environment]::GetFolderPath("Desktop")
    $Archivo    = "$Escritorio\AtlasRed_${NombreModulo}_${Fecha}.txt"
    $Contenido | Out-File -FilePath $Archivo -Encoding UTF8
    Write-Host "  Informe guardado: $Archivo" -ForegroundColor Green
    return $Archivo
}

# ================================================================
#  PANTALLA DE INFORMACION DEL MODULO
#  Retorna $true para continuar, $false para cancelar
# ================================================================
function Mostrar-InfoModulo {
    param([string]$Letra)

    if (-not $script:MostrarInfo -or $script:ModoAuto) { return $true }

    $D = $script:Info[$Letra]
    if (-not $D) { return $true }

    Clear-Host
    $Sep = "-" * 64

    Write-Host ""
    Write-Host "  $Sep" -ForegroundColor DarkGray
    Write-Host ("  [ $Letra ]  " + $D.Titulo.ToUpper()) -ForegroundColor $D.Color
    Write-Host "  $Sep" -ForegroundColor DarkGray

    Write-Host "`n  QUE HACE" -ForegroundColor Yellow
    foreach ($L in $D.Desc)  { Write-Host "    $L" -ForegroundColor Gray }

    Write-Host "`n  PRECAUCIONES" -ForegroundColor DarkYellow
    foreach ($L in $D.Prec)  { Write-Host "    $L" -ForegroundColor Gray }

    Write-Host "`n  RECOMENDACIONES" -ForegroundColor Cyan
    foreach ($L in $D.Recs)  { Write-Host "    $L" -ForegroundColor Gray }

    Write-Host "`n  EJEMPLOS DE USO" -ForegroundColor Green
    foreach ($L in $D.Ejem)  { Write-Host "    $L" -ForegroundColor Gray }

    Write-Host ""
    Write-Host "  $Sep" -ForegroundColor DarkGray
    Write-Host "  S = continuar   N = cancelar   X = no mostrar info en el futuro" -ForegroundColor DarkGray
    Write-Host "  $Sep" -ForegroundColor DarkGray
    $R = Read-Host "  Tu eleccion"

    if ($R.ToUpper() -eq "X") { $script:MostrarInfo = $false; return $true }
    if ($R.ToUpper() -eq "N") { return $false }
    return $true
}

function Esperar-Enter {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not $script:ModoAuto) {
        Read-Host "`n  Presiona ENTER para volver al menu..."
    }
}

# ================================================================
#  MODULO A - AUDITORIA DE PUERTOS LAN
# ================================================================
function Modulo-Auditoria {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "A")) { return @() }

    Clear-Host
    Write-Host ""
    Write-Host "  [ A ]  AUDITORIA DE PUERTOS LAN" -ForegroundColor Cyan
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray

    $RI = Obtener-Router
    if (-not $RI) { Write-Host "`n  No se pudo detectar el router." -ForegroundColor Red; Esperar-Enter -Silencioso:$Silencioso; return @() }
    $GW = $RI.Gateway
    Write-Host "`n  Router detectado: $GW" -ForegroundColor White

    $Base = @(21, 22, 23, 80, 443, 8080, 8443, 8888, 9090)
    Write-Host "  Puertos base    : $($Base -join ', ')" -ForegroundColor DarkGray

    $Extra = ""
    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Extra = Read-Host "`n  Puertos adicionales separados por coma (o ENTER para omitir)"
    }

    $Puertos = $Base
    if ($Extra.Trim() -ne "") {
        $Add = $Extra -split ',' | ForEach-Object { $_.Trim() } |
               Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ }
        $Puertos = ($Puertos + $Add) | Sort-Object -Unique
    }

    Write-Host "`n  Escaneando $($Puertos.Count) puertos en $GW...`n" -ForegroundColor DarkGray

    $Leyendas = @{
        21 = "FTP         Transferencia de archivos. INSEGURO si expuesto."
        22 = "SSH         Acceso CLI cifrado. Normal en routers administrables."
        23 = "Telnet      Texto plano, sin cifrado. MUY PELIGROSO si abierto."
        80 = "HTTP        Panel del router por red local."
        443= "HTTPS       Panel seguro del router por red local."
        8080="HTTP-Alt    Panel secundario en muchos routers."
        8443="HTTPS-Alt   Panel HTTPS secundario."
        8888="Alt comun   Presente en algunos routers modernos."
        9090="Admin-Alt   Puerto de administracion alternativo."
        3389="RDP         Escritorio remoto Windows. CRITICO si abierto."
    }

    $Log      = @("=== AUDITORIA DE PUERTOS LAN === $(Get-Date)", "Router: $GW", "")
    $Abiertos = @()

    foreach ($P in $Puertos) {
        $Ok = Test-Puerto -Destino $GW -Puerto $P -TimeoutMs 1000
        if ($Ok) {
            Write-Host "  [ABIERTO]  Puerto $P" -ForegroundColor Red
            $Log += "  [ABIERTO]  Puerto $P"
            $Abiertos += $P
        } else {
            Write-Host "  [cerrado]  Puerto $P" -ForegroundColor DarkGreen
            $Log += "  [cerrado]  Puerto $P"
        }
    }

    Write-Host "`n  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host "  LEYENDA DE PUERTOS" -ForegroundColor Cyan
    foreach ($P in $Puertos) {
        if ($Leyendas.ContainsKey($P)) { Write-Host "    [$P]  $($Leyendas[$P])" -ForegroundColor Gray }
    }
    Write-Host "`n  NOTA: Puertos abiertos en LAN son normales. El riesgo real es" -ForegroundColor DarkGray
    Write-Host "        si aparecen abiertos desde Internet. Usar el modulo H." -ForegroundColor DarkGray

    $script:HistorialSesion.Add("[A] Auditoria $GW | Abiertos: $(if ($Abiertos.Count) { $Abiertos -join ',' } else { 'Ninguno' })")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "Auditoria" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
    return $Log
}

# ================================================================
#  MODULO B - ESCANEO DE DISPOSITIVOS + DETECCION IPs DUPLICADAS (K)
# ================================================================
function Modulo-Escaneo {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "B")) { return @() }

    Clear-Host
    Write-Host ""
    Write-Host "  [ B ]  ESCANEO DE DISPOSITIVOS" -ForegroundColor Cyan
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray

    $RI = Obtener-Router
    if (-not $RI) { Write-Host "`n  No se pudo detectar el router." -ForegroundColor Red; Esperar-Enter -Silencioso:$Silencioso; return @() }
    $GW  = $RI.Gateway
    $Sub = Obtener-SubredBase -Gateway $GW -InterfaceIndex $RI.InterfaceIndex

    Write-Host "`n  Subred: ${Sub}.1 - ${Sub}.254" -ForegroundColor White
    Write-Host "  Esto puede tardar hasta 90 segundos. Por favor espera.`n" -ForegroundColor DarkGray

    $Ping        = New-Object System.Net.NetworkInformation.Ping
    $Encontrados = [System.Collections.Generic.List[hashtable]]::new()
    $MACVisto    = @{}
    $Log         = @("=== ESCANEO DE DISPOSITIVOS === $(Get-Date)", "Subred: ${Sub}.x", "")

    for ($i = 1; $i -le 254; $i++) {
        $IP = "$Sub.$i"
        try {
            if ($Ping.Send($IP, 150).Status -eq 'Success') {

                $Host_ = "Oculto"
                try { $H = [System.Net.Dns]::GetHostEntry($IP); if ($H.HostName) { $Host_ = $H.HostName } } catch { }

                $null = arp -a 2>$null
                Start-Sleep -Milliseconds 80
                $MAC  = Get-MACDesdeARP -IP $IP
                $Fab  = Get-Fabricante -MAC $MAC

                # Modulo K: deteccion de conflicto de IP
                $Conflicto = ""
                if ($MAC -ne "Desconocida") {
                    if ($MACVisto.ContainsKey($MAC)) {
                        $Conflicto = "  [!!! CONFLICTO: misma MAC que $($MACVisto[$MAC])]"
                    } else {
                        $MACVisto[$MAC] = $IP
                    }
                }

                $Entrada = @{ IP = $IP; MAC = $MAC; Host = $Host_; Fab = $Fab }
                $Encontrados.Add($Entrada)

                if ($IP -eq $GW) {
                    Write-Host "  [ROUTER]   $IP  $MAC  $Fab" -ForegroundColor Green
                    $Log += "  [ROUTER]   $IP | $MAC | $Fab"
                } elseif ($Conflicto) {
                    Write-Host "  [CONFLICTO]$IP  $MAC  $Fab$Conflicto" -ForegroundColor Red
                    $Log += "  [CONFLICTO]$IP | $MAC | $Fab$Conflicto"
                } else {
                    Write-Host "  [disp]     $IP  $MAC  $Fab  |  $Host_" -ForegroundColor Cyan
                    $Log += "  [disp]     $IP | $MAC | $Fab | $Host_"
                }
            }
        } catch { }
    }

    Write-Host "`n  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host "  Total encontrados: $($Encontrados.Count) dispositivos" -ForegroundColor Yellow
    if ($MACVisto.Count -lt ($Encontrados | Where-Object { $_.MAC -ne "Desconocida" } | Measure-Object).Count) {
        Write-Host "  AVISO: Se detectaron conflictos de IP. Ver lineas marcadas [CONFLICTO]." -ForegroundColor Red
    }

    # Guardar estado para modulo N
    try {
        $Lineas = $Encontrados | ForEach-Object { "$($_.IP)|$($_.MAC)|$($_.Host)" }
        $Lineas | Out-File $script:ArchivoEstado -Encoding UTF8 -Force
        Write-Host "  Estado guardado para comparativa (modulo N)." -ForegroundColor DarkGray
    } catch { }

    $script:HistorialSesion.Add("[B] Escaneo ${Sub}.x | $($Encontrados.Count) dispositivos")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "Escaneo" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
    return $Log
}

# ================================================================
#  MODULO C - PANEL DEL ROUTER
# ================================================================
function Modulo-Panel {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "C")) { return }

    Clear-Host
    Write-Host ""
    Write-Host "  [ C ]  PANEL DEL ROUTER" -ForegroundColor Cyan
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray

    $RI = Obtener-Router
    if (-not $RI) { Write-Host "`n  No se pudo detectar el router." -ForegroundColor Red; Esperar-Enter -Silencioso:$Silencioso; return }
    $GW = $RI.Gateway

    Write-Host "`n  Detectando protocolo en $GW..." -ForegroundColor DarkGray
    $URL = $null
    if (Test-Puerto -Destino $GW -Puerto 443 -TimeoutMs 1500) {
        $URL = "https://$GW"
        Write-Host "  Puerto 443 disponible  ->  usando HTTPS" -ForegroundColor Green
    } elseif (Test-Puerto -Destino $GW -Puerto 80 -TimeoutMs 1500) {
        $URL = "http://$GW"
        Write-Host "  Puerto 80 disponible   ->  usando HTTP" -ForegroundColor Yellow
    } else {
        $URL = "http://$GW"
        Write-Host "  Ningun puerto confirmo respuesta. Intentando HTTP..." -ForegroundColor DarkGray
    }

    Write-Host "`n  Abriendo: $URL" -ForegroundColor White
    Write-Host "  Si el navegador muestra 'Sitio no seguro', es normal en LAN." -ForegroundColor DarkGray
    Write-Host "  Credenciales habituales: admin / admin  |  admin / 1234  |  admin / (vacio)" -ForegroundColor DarkGray

    try { Start-Process $URL } catch { Write-Host "  Error al abrir el navegador." -ForegroundColor Red }

    $script:HistorialSesion.Add("[C] Panel abierto: $URL")
    Esperar-Enter -Silencioso:$Silencioso
}

# ================================================================
#  MODULO D - DIAGNOSTICO DE LATENCIA
# ================================================================
function Modulo-Latencia {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "D")) { return @() }

    Clear-Host
    Write-Host ""
    Write-Host "  [ D ]  DIAGNOSTICO DE LATENCIA" -ForegroundColor Yellow
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray

    $RI = Obtener-Router
    if (-not $RI) { Write-Host "`n  No se pudo detectar el router." -ForegroundColor Red; Esperar-Enter -Silencioso:$Silencioso; return @() }
    $GW = $RI.Gateway

    $Objetivos = @(
        @{ N = "Router   (LAN)    "; IP = $GW       },
        @{ N = "Cloudflare (WAN)  "; IP = "1.1.1.1" },
        @{ N = "Google     (WAN)  "; IP = "8.8.8.8" }
    )

    $Log = @("=== DIAGNOSTICO DE LATENCIA === $(Get-Date)", "Router: $GW", "")
    $PO  = New-Object System.Net.NetworkInformation.Ping
    $N   = 10

    foreach ($Obj in $Objetivos) {
        Write-Host "`n  $($Obj.N.Trim()) ($($Obj.IP))  -  $N pings" -ForegroundColor Cyan
        $T = @(); $F = 0
        for ($p = 1; $p -le $N; $p++) {
            try {
                $R = $PO.Send($Obj.IP, 2000)
                if ($R.Status -eq 'Success') {
                    $T += $R.RoundtripTime
                    Write-Host "    Ping $p : $($R.RoundtripTime) ms" -ForegroundColor DarkGray
                } else { $F++; Write-Host "    Ping $p : TIMEOUT" -ForegroundColor DarkRed }
            } catch { $F++; Write-Host "    Ping $p : ERROR" -ForegroundColor DarkRed }
            Start-Sleep -Milliseconds 200
        }
        if ($T.Count -gt 0) {
            $Min = ($T | Measure-Object -Minimum).Minimum
            $Max = ($T | Measure-Object -Maximum).Maximum
            $Avg = [Math]::Round(($T | Measure-Object -Average).Average, 1)
            $Res = "Min:${Min}ms  Max:${Max}ms  Media:${Avg}ms  Perdidos:$F/$N"
            Write-Host "  RESULTADO  $Res" -ForegroundColor Yellow
            $Log += "  $($Obj.N.Trim()): $Res"
            if ($Obj.IP -eq $GW     -and $Avg -gt 20)  { Write-Host "  AVISO: Latencia al router alta. Posible congestion en LAN o WiFi debil." -ForegroundColor Red }
            if ($Obj.IP -ne $GW     -and $Avg -gt 100) { Write-Host "  AVISO: Latencia a Internet alta. Posible problema con el ISP." -ForegroundColor Red }
            if ($F -gt ($N / 2))                        { Write-Host "  AVISO: Mas de la mitad de los pings se perdieron. Fallo grave." -ForegroundColor Red }
        } else {
            Write-Host "  Sin respuestas. Destino inaccesible." -ForegroundColor Red
            $Log += "  $($Obj.N.Trim()): SIN RESPUESTA"
        }
    }

    $script:HistorialSesion.Add("[D] Diagnostico de latencia completado")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "Latencia" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
    return $Log
}

# ================================================================
#  MODULO E - INFO DEL ADAPTADOR
# ================================================================
function Modulo-InfoAdaptador {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "E")) { return @() }

    Clear-Host
    Write-Host ""
    Write-Host "  [ E ]  INFORMACION DEL ADAPTADOR DE RED" -ForegroundColor White
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray

    $RI = Obtener-Router
    if (-not $RI) { Write-Host "`n  No se pudo detectar el router." -ForegroundColor Red; Esperar-Enter -Silencioso:$Silencioso; return @() }
    $GW = $RI.Gateway
    $II = $RI.InterfaceIndex

    $A   = Get-NetAdapter -InterfaceIndex $II -ErrorAction SilentlyContinue
    $IP  = Get-NetIPAddress -InterfaceIndex $II -AddressFamily IPv4 -ErrorAction SilentlyContinue | Select-Object -First 1
    $DNS = Get-DnsClientServerAddress -InterfaceIndex $II -AddressFamily IPv4 -ErrorAction SilentlyContinue
    $EC  = if ($A.Status -eq 'Up') { 'Green' } else { 'Red' }

    Write-Host ""
    Write-Host "  ADAPTADOR ACTIVO" -ForegroundColor Cyan
    Write-Host "  Nombre         : $($A.Name)"
    Write-Host "  Descripcion    : $($A.InterfaceDescription)"
    Write-Host "  Estado         : $($A.Status)" -ForegroundColor $EC
    Write-Host "  Velocidad      : $(if ($A.LinkSpeed) { $A.LinkSpeed } else { 'N/A' })"
    Write-Host "  MAC propia     : $($A.MacAddress)" -ForegroundColor Yellow

    Write-Host ""
    Write-Host "  CONFIGURACION IP" -ForegroundColor Cyan
    $IPColor = if ($IP.IPAddress -match "^169\.254") { "Red" } else { "Yellow" }
    Write-Host "  IP Local       : $($IP.IPAddress)" -ForegroundColor $IPColor
    if ($IP.IPAddress -match "^169\.254") {
        Write-Host "  AVISO: IP APIPA (169.254.x.x). El DHCP no esta respondiendo." -ForegroundColor Red
    }
    Write-Host "  Mascara de red : /$($IP.PrefixLength)"
    Write-Host "  Puerta enlace  : $GW"

    Write-Host ""
    Write-Host "  SERVIDORES DNS" -ForegroundColor Cyan
    if ($DNS -and $DNS.ServerAddresses.Count -gt 0) {
        foreach ($S in $DNS.ServerAddresses) {
            $DNSColor = "White"
            $DNSNota  = ""
            if ($S -eq "127.0.0.1")  { $DNSColor = "Yellow"; $DNSNota = "  (DNS local activo: Pi-hole, VPN o DNSCrypt)" }
            if ($S -eq "1.1.1.1")    { $DNSNota = "  (Cloudflare)" }
            if ($S -eq "8.8.8.8")    { $DNSNota = "  (Google)" }
            if ($S -eq "9.9.9.9")    { $DNSNota = "  (Quad9)" }
            if ($S -eq "208.67.222.222") { $DNSNota = "  (OpenDNS)" }
            Write-Host "  -> $S$DNSNota" -ForegroundColor $DNSColor
        }
    } else { Write-Host "  No se encontraron DNS configurados." -ForegroundColor DarkGray }

    $Log = @(
        "=== INFO ADAPTADOR === $(Get-Date)",
        "Nombre    : $($A.Name)  |  $($A.InterfaceDescription)",
        "Estado    : $($A.Status)  |  Velocidad: $($A.LinkSpeed)",
        "MAC       : $($A.MacAddress)",
        "IP        : $($IP.IPAddress)/$($IP.PrefixLength)",
        "Gateway   : $GW",
        "DNS       : $($DNS.ServerAddresses -join ', ')"
    )

    $script:HistorialSesion.Add("[E] Adaptador: $($A.Name) | IP: $($IP.IPAddress) | GW: $GW")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "Adaptador" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
    return $Log
}

# ================================================================
#  MODULO F - TEST DNS
# ================================================================
function Modulo-TestDNS {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "F")) { return @() }

    Clear-Host
    Write-Host ""
    Write-Host "  [ F ]  TEST DE RESOLUCION DNS" -ForegroundColor White
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host ""

    $Doms = @("google.com","cloudflare.com","microsoft.com","amazon.com","youtube.com")
    $Log  = @("=== TEST DNS === $(Get-Date)", "")
    $F    = 0

    foreach ($D in $Doms) {
        $T0 = Get-Date
        try {
            $R  = [System.Net.Dns]::GetHostEntry($D)
            $Ms = [Math]::Round((New-TimeSpan -Start $T0 -End (Get-Date)).TotalMilliseconds)
            $IP = ($R.AddressList | Select-Object -First 2 | ForEach-Object { $_.IPAddressToString }) -join ", "
            $C  = if ($Ms -gt 500) { "Yellow" } else { "Green" }
            Write-Host "  [OK]    $D" -NoNewline -ForegroundColor $C
            Write-Host "   ${Ms}ms  ->  $IP" -ForegroundColor DarkGray
            if ($Ms -gt 500) { Write-Host "          AVISO: resolucion lenta. DNS del router puede estar congestionado." -ForegroundColor DarkYellow }
            $Log += "  [OK]    $D : ${Ms}ms -> $IP"
        } catch {
            $Ms = [Math]::Round((New-TimeSpan -Start $T0 -End (Get-Date)).TotalMilliseconds)
            Write-Host "  [FALLO] $D  (${Ms}ms)" -ForegroundColor Red
            $Log += "  [FALLO] $D : ${Ms}ms"
            $F++
        }
    }

    Write-Host ""
    if ($F -eq $Doms.Count) {
        Write-Host "  AVISO: Todos los dominios fallaron. Sin Internet o DNS completamente caido." -ForegroundColor Red
        Write-Host "  Solucion rapida: cambiar DNS a 1.1.1.1 en la configuracion del adaptador." -ForegroundColor Yellow
    } elseif ($F -gt 0) {
        Write-Host "  AVISO: $F dominio(s) fallaron. Posible filtracion o cache DNS corrupta." -ForegroundColor Yellow
    }

    $script:HistorialSesion.Add("[F] Test DNS: $($Doms.Count - $F)/$($Doms.Count) dominios OK")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "DNS" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
    return $Log
}

# ================================================================
#  MODULO H - PUERTOS WAN PELIGROSOS
# ================================================================
function Modulo-PuertosWAN {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "H")) { return @() }

    Clear-Host
    Write-Host ""
    Write-Host "  [ H ]  PUERTOS PELIGROSOS EN INTERNET (WAN)" -ForegroundColor Red
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host "`n  Obteniendo IP publica..." -ForegroundColor DarkGray

    $IPP = $null
    foreach ($Srv in @("https://api.ipify.org","https://api.my-ip.io/ip","https://ifconfig.me/ip")) {
        try { $IPP = (Invoke-RestMethod -Uri $Srv -TimeoutSec 5 -ErrorAction Stop).Trim()
              if ($IPP -match '^\d{1,3}(\.\d{1,3}){3}$') { break } else { $IPP = $null }
        } catch { $IPP = $null }
    }

    if (-not $IPP) { Write-Host "  No se pudo obtener la IP publica." -ForegroundColor Red; Esperar-Enter -Silencioso:$Silencioso; return @() }

    Write-Host "  IP Publica: $IPP" -ForegroundColor White
    Write-Host "`n  Escaneando puertos criticos desde Internet...`n" -ForegroundColor DarkGray

    $Puertos = @(
        @{ P = 21;   N = "FTP";      R = "CRITICO" }
        @{ P = 22;   N = "SSH";      R = "ALTO"    }
        @{ P = 23;   N = "Telnet";   R = "CRITICO" }
        @{ P = 80;   N = "HTTP";     R = "MEDIO"   }
        @{ P = 443;  N = "HTTPS";    R = "BAJO"    }
        @{ P = 3389; N = "RDP";      R = "CRITICO" }
        @{ P = 8080; N = "HTTP-Alt"; R = "MEDIO"   }
    )

    $Log     = @("=== PUERTOS WAN === $(Get-Date)", "IP Publica: $IPP", "")
    $Alertas = @()

    foreach ($E in $Puertos) {
        $Ok = Test-Puerto -Destino $IPP -Puerto $E.P -TimeoutMs 2000
        if ($Ok) {
            $C = switch ($E.R) { "CRITICO" { "Red" } "ALTO" { "Yellow" } default { "DarkYellow" } }
            Write-Host ("  [EXPUESTO]  Puerto {0,-5} ({1,-10}) RIESGO {2}" -f $E.P, $E.N, $E.R) -ForegroundColor $C
            $Log += "  [EXPUESTO]  Puerto $($E.P) ($($E.N)) [$($E.R)]"
            $Alertas += $E.P
        } else {
            Write-Host ("  [OK]        Puerto {0,-5} ({1,-10}) cerrado/filtrado" -f $E.P, $E.N) -ForegroundColor DarkGreen
            $Log += "  [OK]        Puerto $($E.P) ($($E.N))"
        }
    }

    Write-Host ""
    if ($Alertas.Count -gt 0) {
        Write-Host "  ACCION RECOMENDADA:" -ForegroundColor Yellow
        Write-Host "    Panel del router (modulo C) -> Administracion remota -> desactivar." -ForegroundColor Yellow
        Write-Host "    O en Port Forwarding: eliminar las reglas de los puertos marcados." -ForegroundColor Yellow
    } else {
        Write-Host "  Sin puertos criticos expuestos. Router bien configurado." -ForegroundColor Green
    }

    $script:HistorialSesion.Add("[H] WAN $IPP | Expuestos: $(if ($Alertas.Count) { $Alertas -join ',' } else { 'Ninguno' })")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "WAN" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
    return $Log
}

# ================================================================
#  MODULO J - FABRICANTES POR MAC (OUI)
# ================================================================
function Modulo-Fabricantes {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "J")) { return }

    Clear-Host
    Write-Host ""
    Write-Host "  [ J ]  IDENTIFICACION DE FABRICANTES POR MAC" -ForegroundColor White
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray

    $RI = Obtener-Router
    if (-not $RI) { Write-Host "`n  No se pudo detectar el router." -ForegroundColor Red; Esperar-Enter -Silencioso:$Silencioso; return }
    $GW  = $RI.Gateway
    $Sub = Obtener-SubredBase -Gateway $GW -InterfaceIndex $RI.InterfaceIndex

    Write-Host "`n  Escaneando ${Sub}.1 - ${Sub}.254 (tabla OUI local, sin Internet)..." -ForegroundColor DarkGray
    Write-Host ""

    $Ping    = New-Object System.Net.NetworkInformation.Ping
    $Grupos  = @{}   # Fabricante -> Lista de IPs
    $Log     = @("=== FABRICANTES POR MAC === $(Get-Date)", "Subred: ${Sub}.x", "")

    for ($i = 1; $i -le 254; $i++) {
        $IP = "$Sub.$i"
        try {
            if ($Ping.Send($IP, 150).Status -eq 'Success') {
                $null = arp -a 2>$null; Start-Sleep -Milliseconds 80
                $MAC = Get-MACDesdeARP -IP $IP
                $Fab = Get-Fabricante  -MAC $MAC
                $Tag = if ($IP -eq $GW) { " [ROUTER]" } else { "" }

                if (-not $Grupos.ContainsKey($Fab)) { $Grupos[$Fab] = [System.Collections.Generic.List[string]]::new() }
                $Grupos[$Fab].Add("$IP  |  $MAC$Tag")
            }
        } catch { }
    }

    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host "  RESULTADOS AGRUPADOS POR FABRICANTE`n" -ForegroundColor Cyan

    $Total = 0
    foreach ($Fab in ($Grupos.Keys | Sort-Object)) {
        $Alerta = $Fab -match "VMware|VirtualBox|QEMU|Raspberry Pi|Ubiquiti"
        $C = if ($Fab -eq "Desconocido") { "DarkGray" } elseif ($Alerta) { "Yellow" } else { "White" }
        Write-Host "  $Fab ($($Grupos[$Fab].Count) dispositivo(s))" -ForegroundColor $C
        $Log += "  $Fab ($($Grupos[$Fab].Count)):"
        foreach ($L in $Grupos[$Fab]) {
            Write-Host "    -> $L" -ForegroundColor DarkGray
            $Log += "    -> $L"
            $Total++
        }
        if ($Alerta) { Write-Host "    NOTA: Fabricante inusual en red domestica. Verificar." -ForegroundColor Yellow }
        $Log += ""
        Write-Host ""
    }

    Write-Host "  Total: $Total dispositivos encontrados." -ForegroundColor Yellow
    $script:HistorialSesion.Add("[J] Fabricantes ${Sub}.x | $Total dispositivos | $($Grupos.Count) fabricantes")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "Fabricantes" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
}

# ================================================================
#  MODULO L - VERSION DE FIRMWARE DEL ROUTER
# ================================================================
function Modulo-Firmware {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "L")) { return }

    Clear-Host
    Write-Host ""
    Write-Host "  [ L ]  DETECCION DE FIRMWARE DEL ROUTER" -ForegroundColor DarkYellow
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray

    $RI = Obtener-Router
    if (-not $RI) { Write-Host "`n  No se pudo detectar el router." -ForegroundColor Red; Esperar-Enter -Silencioso:$Silencioso; return }
    $GW = $RI.Gateway

    Write-Host "`n  Probando rutas conocidas en $GW...`n" -ForegroundColor DarkGray

    # Rutas conocidas por fabricante (accesibles sin autenticacion en muchos modelos)
    $Rutas = @(
        @{ URL = "http://$GW/help/aboutinfo.htm";       Marca = "TP-Link (clasico)"  }
        @{ URL = "http://$GW/userRpm/AboutRpm.htm";     Marca = "TP-Link (alt)"      }
        @{ URL = "http://$GW/cgi-bin/status";           Marca = "TP-Link (cgi)"      }
        @{ URL = "http://$GW/about.html";               Marca = "D-Link"             }
        @{ URL = "http://$GW/info.html";                Marca = "D-Link (alt)"       }
        @{ URL = "http://$GW/Main_Analysis_Content.asp";Marca = "ASUS"               }
        @{ URL = "https://$GW/appGet.cgi?hook=get_system_info()"; Marca = "ASUS (HTTPS)" }
        @{ URL = "http://$GW/statusInfo.html";          Marca = "Huawei/Movistar"    }
        @{ URL = "http://$GW/html/status.html";         Marca = "Huawei (alt)"       }
        @{ URL = "http://$GW/firmware.html";            Marca = "Generico"           }
        @{ URL = "http://$GW/status.html";              Marca = "Generico (alt)"     }
    )

    $Encontrada = $false
    $Log = @("=== FIRMWARE DEL ROUTER === $(Get-Date)", "Gateway: $GW", "")

    foreach ($R in $Rutas) {
        Write-Host "  Probando: $($R.Marca)..." -ForegroundColor DarkGray -NoNewline
        try {
            $Resp = Invoke-WebRequest -Uri $R.URL -TimeoutSec 3 -UseBasicParsing `
                    -ErrorAction Stop -WarningAction SilentlyContinue
            $HTML = $Resp.Content

            # Patrones de version en el HTML
            $Version = $null
            $Patrones = @(
                'Firmware[^<:]*(?:Version)?[^<:]*:[^<"]*?([\d]+\.[\d]+[\d\.]*)',
                'Software Version[^<]*?([0-9]+\.[0-9]+[0-9A-Za-z\._-]*)',
                'FW Version[^<]*?([0-9]+\.[0-9]+[0-9A-Za-z\._-]*)',
                'HW Version[^<]*?([0-9]+\.[0-9]+[0-9A-Za-z\._-]*)',
                'Version[^<"]*?([0-9]+\.[0-9]+\.[0-9]+[0-9A-Za-z\._-]*)',
                '"firmware"[^"]*"([^"]+)"',
                'firmwareVersion[^"]*"([^"]+)"'
            )

            foreach ($Pat in $Patrones) {
                if ($HTML -match $Pat) {
                    $Version = $Matches[1].Trim()
                    break
                }
            }

            if ($Version) {
                Write-Host "  ENCONTRADO" -ForegroundColor Green
                Write-Host ""
                Write-Host "  Marca/Modelo detectado : $($R.Marca)" -ForegroundColor White
                Write-Host "  Version firmware       : $Version" -ForegroundColor Yellow
                Write-Host "  URL fuente             : $($R.URL)" -ForegroundColor DarkGray
                Write-Host ""
                Write-Host "  RECOMENDACION: Compara esta version con la disponible en la web" -ForegroundColor Cyan
                Write-Host "  del fabricante. Si tiene mas de 1 ano, considera actualizarla." -ForegroundColor Cyan
                $Log += "  Marca   : $($R.Marca)"
                $Log += "  Version : $Version"
                $Log += "  URL     : $($R.URL)"
                $Encontrada = $true
                break
            } elseif ($Resp.StatusCode -eq 200) {
                Write-Host "  responde (sin version parseable)" -ForegroundColor DarkGray
            } else {
                Write-Host "  sin acceso" -ForegroundColor DarkGray
            }
        } catch {
            Write-Host "  sin acceso" -ForegroundColor DarkGray
        }
    }

    if (-not $Encontrada) {
        Write-Host ""
        Write-Host "  No se encontro la version de firmware de forma automatica." -ForegroundColor Yellow
        Write-Host "  Opciones manuales:" -ForegroundColor DarkGray
        Write-Host "    1. Usa el modulo C para acceder al panel del router." -ForegroundColor Gray
        Write-Host "    2. Busca la version en: Administracion > Actualizacion de firmware." -ForegroundColor Gray
        Write-Host "    3. Revisa la etiqueta fisica en la parte inferior del router." -ForegroundColor Gray
        $Log += "  Resultado: No encontrado de forma automatica."
    }

    $script:HistorialSesion.Add("[L] Firmware $GW | $(if ($Encontrada) { 'Encontrado' } else { 'No encontrado' })")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "Firmware" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
}

# ================================================================
#  MODULO M - INFORME COMPLETO AUTOMATICO
# ================================================================
function Modulo-InformeCompleto {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not $script:ModoAuto -and -not (Mostrar-InfoModulo "M")) { return }

    Clear-Host
    Write-Host ""
    Write-Host "  [ M ]  INFORME COMPLETO AUTOMATICO" -ForegroundColor Green
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host "`n  Ejecutando modulos A, E, F y D en secuencia..." -ForegroundColor DarkGray
    Write-Host "  No cerrar esta ventana. Tardara entre 2 y 5 minutos.`n" -ForegroundColor Yellow

    $LogTotal = @(
        "================================================================"
        "  INFORME COMPLETO - Atlas PC Support  v3.0"
        "  Fecha: $(Get-Date)"
        "================================================================"
        ""
    )

    Write-Host "  [1/4]  Auditoria de Puertos..." -ForegroundColor Cyan
    $LA = Modulo-Auditoria -Silencioso
    $LogTotal += @("", "--- [ A ] AUDITORIA DE PUERTOS ---") + $LA

    Write-Host "`n  [2/4]  Info del Adaptador..." -ForegroundColor Cyan
    $LE = Modulo-InfoAdaptador -Silencioso
    $LogTotal += @("", "--- [ E ] INFO DEL ADAPTADOR ---") + $LE

    Write-Host "`n  [3/4]  Test DNS..." -ForegroundColor Cyan
    $LF = Modulo-TestDNS -Silencioso
    $LogTotal += @("", "--- [ F ] TEST DNS ---") + $LF

    Write-Host "`n  [4/4]  Diagnostico de Latencia..." -ForegroundColor Cyan
    $LD = Modulo-Latencia -Silencioso
    $LogTotal += @("", "--- [ D ] LATENCIA ---") + $LD

    $LogTotal += @("", "================================================================", "  Fin del informe", "================================================================")

    Write-Host ""
    $Archivo = Exportar-Informe -Contenido $LogTotal -NombreModulo "InformeCompleto"

    $script:HistorialSesion.Add("[M] Informe completo generado: $Archivo")
    Write-Host "`n  Informe completo listo." -ForegroundColor Green

    Esperar-Enter -Silencioso:$Silencioso
}

# ================================================================
#  MODULO N - COMPARATIVA DE DISPOSITIVOS
# ================================================================
function Modulo-Comparativa {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "N")) { return }

    Clear-Host
    Write-Host ""
    Write-Host "  [ N ]  COMPARATIVA DE DISPOSITIVOS" -ForegroundColor Magenta
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray

    # Cargar estado previo
    $Previo = @{}
    if (Test-Path $script:ArchivoEstado) {
        $FechaMod = (Get-Item $script:ArchivoEstado).LastWriteTime
        Write-Host "`n  Estado previo encontrado: $FechaMod" -ForegroundColor DarkGray
        foreach ($L in (Get-Content $script:ArchivoEstado)) {
            $P = $L -split '\|'
            if ($P.Count -ge 2) { $Previo[$P[0]] = @{ MAC = $P[1]; Host = if ($P.Count -ge 3) { $P[2] } else { "Oculto" } } }
        }
        Write-Host "  Dispositivos en estado previo: $($Previo.Count)" -ForegroundColor DarkGray
    } else {
        Write-Host "`n  No hay estado previo guardado." -ForegroundColor Yellow
        Write-Host "  Ejecuta el modulo B primero para guardar una linea base." -ForegroundColor Yellow
        Esperar-Enter -Silencioso:$Silencioso; return
    }

    Write-Host "`n  Escaneando la red actual..." -ForegroundColor DarkGray
    $RI = Obtener-Router
    if (-not $RI) { Write-Host "  No se pudo detectar el router." -ForegroundColor Red; Esperar-Enter -Silencioso:$Silencioso; return }
    $Sub  = Obtener-SubredBase -Gateway $RI.Gateway -InterfaceIndex $RI.InterfaceIndex
    $Ping = New-Object System.Net.NetworkInformation.Ping

    $Actual = @{}
    for ($i = 1; $i -le 254; $i++) {
        $IP = "$Sub.$i"
        try {
            if ($Ping.Send($IP, 150).Status -eq 'Success') {
                $null = arp -a 2>$null; Start-Sleep -Milliseconds 60
                $MAC    = Get-MACDesdeARP -IP $IP
                $HostN  = "Oculto"
                try { $H = [System.Net.Dns]::GetHostEntry($IP); if ($H.HostName) { $HostN = $H.HostName } } catch { }
                $Actual[$IP] = @{ MAC = $MAC; Host = $HostN }
            }
        } catch { }
    }

    Write-Host "`n  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host "  RESULTADO DE LA COMPARATIVA`n" -ForegroundColor Cyan

    $Log = @("=== COMPARATIVA DE DISPOSITIVOS === $(Get-Date)", "Subred: ${Sub}.x", "")

    # Dispositivos nuevos
    $Nuevos = $Actual.Keys | Where-Object { -not $Previo.ContainsKey($_) }
    if ($Nuevos) {
        Write-Host "  DISPOSITIVOS NUEVOS (no estaban en el escaneo anterior)" -ForegroundColor Yellow
        $Log += "  NUEVOS:"
        foreach ($IP in ($Nuevos | Sort-Object)) {
            $Fab = Get-Fabricante -MAC $Actual[$IP].MAC
            Write-Host "  [+] $IP  |  $($Actual[$IP].MAC)  |  $Fab  |  $($Actual[$IP].Host)" -ForegroundColor Green
            $Log += "  [+] $IP | $($Actual[$IP].MAC) | $Fab | $($Actual[$IP].Host)"
        }
        $Log += ""
        Write-Host ""
    }

    # Dispositivos desaparecidos
    $Idos = $Previo.Keys | Where-Object { -not $Actual.ContainsKey($_) }
    if ($Idos) {
        Write-Host "  DISPOSITIVOS DESAPARECIDOS (estaban antes, ya no responden)" -ForegroundColor DarkGray
        $Log += "  DESAPARECIDOS:"
        foreach ($IP in ($Idos | Sort-Object)) {
            Write-Host "  [-] $IP  |  $($Previo[$IP].MAC)  |  $($Previo[$IP].Host)" -ForegroundColor DarkGray
            $Log += "  [-] $IP | $($Previo[$IP].MAC) | $($Previo[$IP].Host)"
        }
        $Log += ""
        Write-Host ""
    }

    # Sin cambios
    $Iguales = $Actual.Keys | Where-Object { $Previo.ContainsKey($_) }
    Write-Host "  SIN CAMBIOS: $($Iguales.Count) dispositivo(s)" -ForegroundColor DarkGray
    $Log += "  SIN CAMBIOS: $($Iguales.Count)"

    Write-Host ""
    if (-not $Nuevos -and -not $Idos) {
        Write-Host "  La red no ha cambiado desde el ultimo escaneo." -ForegroundColor Green
    }

    # Guardar el nuevo estado como el actual
    try {
        ($Actual.Keys | ForEach-Object { "$_|$($Actual[$_].MAC)|$($Actual[$_].Host)" }) |
        Out-File $script:ArchivoEstado -Encoding UTF8 -Force
    } catch { }

    $script:HistorialSesion.Add("[N] Comparativa | +$($Nuevos.Count) nuevos | -$($Idos.Count) desaparecidos")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "Comparativa" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
}

# ================================================================
#  MODULO P - TEST DE VELOCIDAD DE DESCARGA
# ================================================================
function Modulo-Velocidad {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "P")) { return }

    Clear-Host
    Write-Host ""
    Write-Host "  [ P ]  TEST DE VELOCIDAD DE DESCARGA" -ForegroundColor Yellow
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host ""

    $URL_5MB  = "https://speed.cloudflare.com/__down?bytes=5242880"
    $URL_10MB = "https://speed.cloudflare.com/__down?bytes=10485760"

    $Resultados = @()
    $Log = @("=== TEST DE VELOCIDAD === $(Get-Date)", "Servidor: Cloudflare CDN", "")

    foreach ($Prueba in @(@{ URL = $URL_5MB; Tam = 5 }, @{ URL = $URL_10MB; Tam = 10 })) {
        Write-Host "  Descargando $($Prueba.Tam) MB desde Cloudflare..." -ForegroundColor DarkGray -NoNewline
        try {
            $T0   = Get-Date
            $null = Invoke-WebRequest -Uri $Prueba.URL -UseBasicParsing -TimeoutSec 60 -ErrorAction Stop
            $Secs = (New-TimeSpan -Start $T0 -End (Get-Date)).TotalSeconds
            $MBs  = [Math]::Round($Prueba.Tam / $Secs, 2)
            $Mbps = [Math]::Round($MBs * 8, 1)

            $C = if ($Mbps -lt 5) { "Red" } elseif ($Mbps -lt 25) { "Yellow" } else { "Green" }
            Write-Host " OK" -ForegroundColor Green
            Write-Host ("  Resultado ($($Prueba.Tam) MB):  {0,7} MB/s  =  {1,8} Mbps  (en {2:F1}s)" -f $MBs, $Mbps, $Secs) -ForegroundColor $C
            $Log     += "  Test $($Prueba.Tam) MB : $MBs MB/s = $Mbps Mbps en $([Math]::Round($Secs,1))s"
            $Resultados += $Mbps
        } catch {
            Write-Host " ERROR" -ForegroundColor Red
            Write-Host "  No se pudo descargar el archivo. Verifica la conexion." -ForegroundColor Red
            $Log += "  Test $($Prueba.Tam) MB : ERROR"
        }
        Write-Host ""
    }

    if ($Resultados.Count -gt 0) {
        $Media = [Math]::Round(($Resultados | Measure-Object -Average).Average, 1)
        Write-Host "  Media aproximada: $Media Mbps" -ForegroundColor White
        Write-Host ""
        Write-Host "  REFERENCIA:" -ForegroundColor Cyan
        Write-Host "    < 5 Mbps    Muy lenta. Problemas graves de conexion." -ForegroundColor Red
        Write-Host "    5 - 25 Mbps Basica. Navegacion y streaming SD." -ForegroundColor Yellow
        Write-Host "    25 - 100 Mbps Buena. Streaming HD y videollamadas." -ForegroundColor Green
        Write-Host "    > 100 Mbps  Excelente. Apta para cualquier uso." -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  NOTA: Ejecutar en cable y en WiFi para comparar diferencias." -ForegroundColor DarkGray
        $Log += "  Media: $Media Mbps"
    }

    $script:HistorialSesion.Add("[P] Test velocidad | Media: $(if ($Resultados.Count) { ($Resultados | Measure-Object -Average).Average.ToString('F1') } else { 'ERROR' }) Mbps")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "Velocidad" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
}

# ================================================================
#  MODULO Q - DETECCION DE PORTAL CAUTIVO
# ================================================================
function Modulo-PortalCautivo {
    param([switch]$Silencioso)
    if (-not $Silencioso -and -not (Mostrar-InfoModulo "Q")) { return }

    Clear-Host
    Write-Host ""
    Write-Host "  [ Q ]  DETECCION DE PORTAL CAUTIVO" -ForegroundColor DarkYellow
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host "`n  Verificando conectividad limpia a Internet...`n" -ForegroundColor DarkGray

    $Log = @("=== PORTAL CAUTIVO === $(Get-Date)", "")
    $Resultado = "DESCONOCIDO"

    try {
        # Google genera_204 es el estandar de deteccion de portal cautivo
        $R = Invoke-WebRequest -Uri "http://connectivitycheck.gstatic.com/generate_204" `
             -UseBasicParsing -TimeoutSec 5 -MaximumRedirection 0 -ErrorAction Stop

        if ($R.StatusCode -eq 204) {
            Write-Host "  RESULTADO: Conexion limpia" -ForegroundColor Green
            Write-Host "  HTTP 204 recibido -> No hay portal cautivo activo." -ForegroundColor Green
            Write-Host "`n  Tu dispositivo tiene acceso directo a Internet sin intercepcion." -ForegroundColor White
            $Resultado = "LIMPIA"
            $Log      += "  Resultado : Conexion limpia (HTTP 204)"
        } elseif ($R.StatusCode -eq 200) {
            Write-Host "  RESULTADO: Portal cautivo detectado" -ForegroundColor Red
            Write-Host "  HTTP 200 en lugar de 204 -> La respuesta fue interceptada." -ForegroundColor Red
            Write-Host "`n  ACCION RECOMENDADA:" -ForegroundColor Yellow
            Write-Host "    Abre el navegador y navega a http://neverssl.com" -ForegroundColor Yellow
            Write-Host "    El portal de registro se abrira automaticamente." -ForegroundColor Yellow
            $Resultado = "PORTAL CAUTIVO"
            $Log      += "  Resultado : Portal cautivo detectado (HTTP 200)"
        } else {
            Write-Host "  RESULTADO: Respuesta inesperada (HTTP $($R.StatusCode))" -ForegroundColor Yellow
            $Resultado = "INESPERADO ($($R.StatusCode))"
            $Log      += "  Resultado : Respuesta inesperada HTTP $($R.StatusCode)"
        }
    } catch {
        # Una redireccion (30x) normalmente es portal cautivo
        $Msg = $_.Exception.Message
        if ($Msg -match "redirect|30[0-9]|Location") {
            Write-Host "  RESULTADO: Portal cautivo detectado (redireccion 3xx)" -ForegroundColor Red
            Write-Host "`n  ACCION RECOMENDADA:" -ForegroundColor Yellow
            Write-Host "    Abre el navegador y navega a http://neverssl.com" -ForegroundColor Yellow
            $Resultado = "PORTAL CAUTIVO (redireccion)"
            $Log      += "  Resultado : Portal cautivo - redireccion detectada"
        } else {
            Write-Host "  RESULTADO: Sin conexion a Internet" -ForegroundColor Red
            Write-Host "  No se pudo alcanzar el servidor de verificacion." -ForegroundColor DarkGray
            Write-Host "`n  Comprueba que el WiFi/cable este conectado y ejecuta el modulo D." -ForegroundColor Yellow
            $Resultado = "SIN INTERNET"
            $Log      += "  Resultado : Sin conexion a Internet"
        }
    }

    # Prueba adicional con Apple
    try {
        $R2 = Invoke-WebRequest -Uri "http://captive.apple.com/hotspot-detect.html" `
              -UseBasicParsing -TimeoutSec 5 -MaximumRedirection 0 -ErrorAction Stop
        $EsPortal2 = $R2.Content -notmatch "Success"
        $Log += "  Apple captive.apple.com : $(if ($EsPortal2) { 'Portal detectado' } else { 'Limpio' })"
    } catch { }

    $script:HistorialSesion.Add("[Q] Portal cautivo: $Resultado")

    if (-not $Silencioso -and -not $script:ModoAuto) {
        $Exp = Read-Host "`n  Exportar informe a TXT? (S/N)"
        if ($Exp.ToUpper() -eq "S") { Exportar-Informe -Contenido $Log -NombreModulo "PortalCautivo" | Out-Null }
    }

    Esperar-Enter -Silencioso:$Silencioso
}

# ================================================================
#  MODULO I - HISTORIAL DE SESION
# ================================================================
function Mostrar-Historial {
    Clear-Host
    Write-Host ""
    Write-Host "  [ I ]  HISTORIAL DE SESION" -ForegroundColor DarkGray
    Write-Host "  $("-" * 60)" -ForegroundColor DarkGray
    Write-Host ""
    if ($script:HistorialSesion.Count -eq 0) {
        Write-Host "  Aun no has ejecutado ninguna herramienta en esta sesion." -ForegroundColor DarkGray
    } else {
        Write-Host "  Acciones realizadas esta sesion:`n" -ForegroundColor Cyan
        $n = 1
        foreach ($E in $script:HistorialSesion) {
            Write-Host ("  {0,2}. {1}" -f $n, $E) -ForegroundColor White
            $n++
        }
    }
    Esperar-Enter
}

# ================================================================
#  MODO AUTO (-Auto): ejecutar informe completo y salir
# ================================================================
if ($script:ModoAuto) {
    Modulo-InformeCompleto -Silencioso
    return
}

# ================================================================
#  MENU PRINCIPAL
# ================================================================
while ($true) {
    Clear-Host
    Write-Host "`n"
    Escribir-Centrado "  +--------------------------------------------------------------+  " "DarkGray"
    Escribir-Centrado "  |                                                              |  " "Yellow"
    Escribir-Centrado "  |                   ATLAS PC SUPPORT                          |  " "Yellow"
    Escribir-Centrado "  |               HERRAMIENTAS DE RED  v3.0                     |  " "Yellow"
    Escribir-Centrado "  |                                                              |  " "Yellow"
    Escribir-Centrado "  +--------------------------------------------------------------+  " "DarkGray"
    Write-Host ""
    Escribir-Centrado "  +--- DIAGNOSTICO BASICO ------+---- HERRAMIENTAS AVANZADAS --+  " "DarkGray"
    Escribir-Centrado "  |                             |                              |  " "DarkGray"
    Escribir-Centrado "  |  [A]  Auditoria Puertos LAN |  [L]  Firmware del Router   |  " "White"
    Escribir-Centrado "  |  [B]  Escaneo Dispositivos  |  [M]  Informe Automatico    |  " "White"
    Escribir-Centrado "  |  [C]  Panel del Router      |  [N]  Comparativa Redes     |  " "Cyan"
    Escribir-Centrado "  |  [D]  Latencia / Estabilidad|  [P]  Test de Velocidad     |  " "White"
    Escribir-Centrado "  |  [E]  Info del Adaptador    |  [Q]  Portal Cautivo        |  " "White"
    Escribir-Centrado "  |  [F]  Test de DNS           |                              |  " "White"
    Escribir-Centrado "  |  [H]  Puertos WAN           |  [J]  Fabricantes (MAC/OUI) |  " "White"
    Escribir-Centrado "  |                             |                              |  " "DarkGray"
    Escribir-Centrado "  +--- SESION ------------------+------------------------------+  " "DarkGray"
    Escribir-Centrado "  |  [I]  Historial de Sesion   |  [S]  Salir                 |  " "DarkGray"
    Escribir-Centrado "  +-----------------------------+------------------------------+  " "DarkGray"
    Write-Host ""
    if ($script:HistorialSesion.Count -gt 0) {
        Escribir-Centrado "  Acciones en esta sesion: $($script:HistorialSesion.Count)  |  Info: $(if ($script:MostrarInfo) { 'activada' } else { 'desactivada' })  " "DarkGray"
        Write-Host ""
    }

    $Op = Read-Host "  Elige una opcion"

    switch ($Op.ToUpper()) {
        "A" { Modulo-Auditoria     }
        "B" { Modulo-Escaneo       }
        "C" { Modulo-Panel         }
        "D" { Modulo-Latencia      }
        "E" { Modulo-InfoAdaptador }
        "F" { Modulo-TestDNS       }
        "H" { Modulo-PuertosWAN    }
        "I" { Mostrar-Historial    }
        "J" { Modulo-Fabricantes   }
        "L" { Modulo-Firmware      }
        "M" { Modulo-InformeCompleto }
        "N" { Modulo-Comparativa   }
        "P" { Modulo-Velocidad     }
        "Q" { Modulo-PortalCautivo }
        "S" {
            if ($script:HistorialSesion.Count -gt 0) {
                Write-Host ""
                Write-Host "  --- RESUMEN DE SESION ---" -ForegroundColor Yellow
                $n = 1
                foreach ($E in $script:HistorialSesion) {
                    Write-Host ("  {0,2}. {1}" -f $n, $E) -ForegroundColor DarkGray
                    $n++
                }
            }
            Write-Host "`n  Cerrando herramientas... Hasta pronto, Atlas!" -ForegroundColor Yellow
            Start-Sleep -Seconds 1
            [console]::ResetColor()
            Clear-Host
            return
        }
        default {
            Write-Host "`n  Opcion no valida. Elige una letra del menu." -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
}
}


# ---- tools\Invoke-BundleAtlas.ps1 ----
# ============================================================
# Invoke-BundleAtlas
# Migrado de: InstallBundle.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-BundleAtlas {
    [CmdletBinding()]
    param()
Clear-Host
Write-Host ""
Write-Host "========================================================"
Write-Host ""
Write-Host "        __  __      _ ______     __  __  ______" -ForegroundColor Cyan
Write-Host "       / / / /___  (_) ____/__  / /_/ / / /  _/" -ForegroundColor Cyan
Write-Host "      / / / / __ \/ / / __/ _ \/ __/ / / // /" -ForegroundColor Cyan
Write-Host "     / /_/ / / / / / /_/ /  __/ /_/ /_/ // /" -ForegroundColor Cyan
Write-Host "     \____/_/ /_/_/\____/\___/\__/\____/___/" -ForegroundColor Cyan
Write-Host "          UniGetUI Package Installer Script" 
Write-Host "        Created with UniGetUI Version 3.3.6"
Write-Host ""
Write-Host "========================================================"
Write-Host ""
Write-Host "NOTES:" -ForegroundColor Yellow
Write-Host "  - The install process will not be as reliable as importing a bundle with UniGetUI. Expect issues and errors." -ForegroundColor Yellow
Write-Host "  - Packages will be installed with the install options specified at the time of creation of this script." -ForegroundColor Yellow
Write-Host "  - Error/Sucess detection may not be 100% accurate." -ForegroundColor Yellow
Write-Host "  - Some of the packages may require elevation. Some of them may ask for permission, but others may fail. Consider running this script elevated." -ForegroundColor Yellow
Write-Host "  - You can skip confirmation prompts by running this script with the parameter `/DisablePausePrompts` " -ForegroundColor Yellow
Write-Host ""
Write-Host ""
if ($args[0] -ne "/DisablePausePrompts") { pause }
Write-Host ""
Write-Host "This script will attempt to install the following packages:"
Write-Host "  - Opera GX Stable from WinGet"
Write-Host "  - JW Library from WinGet"
Write-Host "  - ExplorerTabUtility from WinGet"
Write-Host "  - 7-Zip from WinGet"
Write-Host "  - zoxide from WinGet"
Write-Host "  - dupeGuru from WinGet"
Write-Host "  - Zoom Workplace (EXE) from WinGet"
Write-Host "  - SwifDoo PDF from WinGet"
Write-Host "  - Google Chrome from WinGet"
Write-Host "  - VLC media player from WinGet"
Write-Host "  - Oh My Posh from WinGet"
Write-Host "  - PowerShell from WinGet"
Write-Host "  - Proton Drive from WinGet"
Write-Host "  - digiKam from WinGet"
Write-Host "  - WhatsApp from WinGet"
Write-Host "  - Simple Sticky Notes from WinGet"
Write-Host ""
if ($args[0] -ne "/DisablePausePrompts") { pause }
Clear-Host

$success_count=0
$failure_count=0
$commands_run=0
$results=""

$commands= @(
    'cmd.exe /C winget.exe install --id "Opera.OperaAir" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "9WZDNCRFJ3B4" --exact --source msstore --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "w4po.ExplorerTabUtility" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "7zip.7zip" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "ajeetdsouza.zoxide" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "DupeGuru.DupeGuru" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "Zoom.Zoom.EXE" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "XPFP0XKLHXJHRD" --exact --source msstore --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "Google.Chrome" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "VideoLAN.VLC" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "JanDeDobbeleer.OhMyPosh" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "Microsoft.PowerShell" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "Proton.ProtonDrive" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "KDE.digiKam" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "9NKSQGP7F2NH" --exact --source msstore --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force',
    'cmd.exe /C winget.exe install --id "Simnet.SimpleStickyNotes" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force'
)

foreach ($command in $commands) {
    Write-Host "Running: $command" -ForegroundColor Yellow
    cmd.exe /C $command
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[  OK  ] $command" -ForegroundColor Green
        $success_count++
        $results += "$([char]0x1b)[32m[  OK  ] $command`n"
    }
    else {
        Write-Host "[ FAIL ] $command" -ForegroundColor Red
        $failure_count++
        $results += "$([char]0x1b)[31m[ FAIL ] $command`n"
    }
    $commands_run++
    Write-Host ""
}

Write-Host "========================================================"
Write-Host "                  OPERATION SUMMARY"
Write-Host "========================================================"
Write-Host "Total commands run: $commands_run"
Write-Host "Successful: $success_count"
Write-Host "Failed: $failure_count"
Write-Host ""
Write-Host "Details:"
Write-Host "$results$([char]0x1b)[37m"
Write-Host "========================================================"

if ($failure_count -gt 0) {
    Write-Host "Some commands failed. Please check the log above." -ForegroundColor Yellow
}
else {
    Write-Host "All commands executed successfully!" -ForegroundColor Green
}
Write-Host ""
if ($args[0] -ne "/DisablePausePrompts") { pause }
exit $failure_count
}


# ---- tools\Invoke-EntregaPC.ps1 ----
# ============================================================
# Invoke-EntregaPC
# Migrado de: Entrega_PC.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-EntregaPC {
    [CmdletBinding()]
    param()
﻿# =================================================================
# SCRIPT DE ENTREGA PREMIUM CENTRADO - ATLAS SOPORTE
# =================================================================

# 1. Forzar permisos de Administrador
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "ATENCIÓN: Este script necesita permisos de Administrador."
    Write-Warning "Haz clic derecho en el archivo y selecciona 'Ejecutar con PowerShell' como administrador."
    Pause
    return
}

# 2. Configurar la interfaz de la consola
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

# --- FUNCIÓN: Centrar Texto Mágicamente ---
function Escribir-Centrado {
    param([string]$texto, [string]$color)
    $anchoConsola = $Host.UI.RawUI.WindowSize.Width
    $espacios = " " * ([math]::Max(0, [math]::Floor(($anchoConsola - $texto.Length) / 2)))
    Write-Host ($espacios + $texto) -ForegroundColor $color
}

# --- FUNCIÓN: Mostrar el Logo ---
function Mostrar-Encabezado {
    Clear-Host
    Write-Host "`n"
    Escribir-Centrado " █████╗ ████████╗██╗      █████╗ ███████╗" "DarkYellow"
    Escribir-Centrado "██╔══██╗╚══██╔══╝██║     ██╔══██╗██╔════╝" "DarkYellow"
    Escribir-Centrado "███████║   ██║   ██║     ███████║███████╗" "DarkYellow"
    Escribir-Centrado "██╔══██║   ██║   ██║     ██╔══██║╚════██║" "DarkYellow"
    Escribir-Centrado "██║  ██║   ██║   ███████╗██║  ██║███████║" "DarkYellow"
    Escribir-Centrado "╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝" "DarkYellow"
    Escribir-Centrado "        P C   S U P P O R T              " "DarkYellow"
    Escribir-Centrado "=========================================" "DarkGray"
    Write-Host "`n"
}

# --- FUNCIÓN: Modificar Usuario Actual ---
function Modificar-UsuarioActual {
    $userName = $env:USERNAME
    Escribir-Centrado "--- CONFIGURANDO USUARIO ACTUAL: [$userName] ---" "Cyan"
    Write-Host ""
    Write-Host "   (Escriba '0' en cualquier momento para cancelar y volver)" -ForegroundColor DarkGray
    Write-Host ""
    
    $newDisplayName = Read-Host "   -> Nombre y apellido del cliente"
    if ($newDisplayName -eq "0") { return }
    
    Write-Host "   -> Contraseña (Escriba a ciegas y presione ENTER. Deje en blanco para NO usar clave)" -ForegroundColor Yellow
    $securePassword = Read-Host "      Clave" -AsSecureString

    try {
        if (![string]::IsNullOrWhiteSpace($newDisplayName)) {
            Set-LocalUser -Name $userName -FullName $newDisplayName
            Write-Host "`n   [OK] Nombre actualizado a: $newDisplayName" -ForegroundColor Green
        }
        if ($securePassword.Length -gt 0) {
            Set-LocalUser -Name $userName -Password $securePassword
            Write-Host "   [OK] Contraseña establecida." -ForegroundColor Green
        } else {
            Write-Host "`n   [OK] El usuario se mantiene sin contraseña." -ForegroundColor Green
        }
    } catch {
        Write-Host "`n   [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host "`n   Presione ENTER para volver al menú principal..." -ForegroundColor DarkGray
    Read-Host
}

# --- FUNCIÓN: Crear Usuario Nuevo ---
function Crear-NuevoUsuario {
    Escribir-Centrado "--- CREANDO NUEVO USUARIO ---" "Cyan"
    Write-Host ""
    Write-Host "   (Escriba '0' en cualquier momento para cancelar y volver)" -ForegroundColor DarkGray
    Write-Host ""
    
    $newUser = Read-Host "   -> Nombre interno de la cuenta (ej. jorge, sin espacios)"
    if ($newUser -eq "0" -or [string]::IsNullOrWhiteSpace($newUser)) { return }

    $newDisplayName = Read-Host "   -> Nombre completo para la pantalla (ej. Jorge Martínez)"
    if ($newDisplayName -eq "0") { return }
    
    Write-Host "   -> Contraseña (Escriba a ciegas y presione ENTER. Deje en blanco para NO usar clave)" -ForegroundColor Yellow
    $securePassword = Read-Host "      Clave" -AsSecureString
    
    $esAdmin = Read-Host "   -> ¿Hacer a este usuario Administrador? (S/N)"
    if ($esAdmin -eq "0") { return }

    try {
        if ($securePassword.Length -gt 0) {
            New-LocalUser -Name $newUser -FullName $newDisplayName -Password $securePassword -PasswordNeverExpires $true | Out-Null
        } else {
            New-LocalUser -Name $newUser -FullName $newDisplayName -NoPassword | Out-Null
        }
        Write-Host "`n   [OK] Usuario '$newUser' creado correctamente." -ForegroundColor Green

        if ($esAdmin -match "^[sS]") {
            $AdminGroup = Get-LocalGroup | Where-Object SID -eq "S-1-5-32-544"
            Add-LocalGroupMember -Group $AdminGroup -Member $newUser
            Write-Host "   [OK] Permisos de Administrador concedidos." -ForegroundColor Green
        } else {
            $UsersGroup = Get-LocalGroup | Where-Object SID -eq "S-1-5-32-545"
            Add-LocalGroupMember -Group $UsersGroup -Member $newUser
            Write-Host "   [OK] Permisos de Usuario Estándar concedidos." -ForegroundColor Green
        }
    } catch {
        Write-Host "`n   [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host "`n   Presione ENTER para volver al menú principal..." -ForegroundColor DarkGray
    Read-Host
}

# =================================================================
# BUCLE PRINCIPAL DEL MENÚ
# =================================================================
while ($true) {
    Mostrar-Encabezado
    
    # 1. Definir las líneas
    $l1 = "[ 1 ]  Entregar equipo (Usuario actual: $env:USERNAME)"
    $l2 = "[ 2 ]  Crear un usuario nuevo adicional"
    $l3 = "[ 3 ]  Salir y cerrar herramienta"
    
    # 2. Calcular la línea más larga para alinear el bloque
    $maxLen = [math]::Max($l1.Length, [math]::Max($l2.Length, $l3.Length))
    
    # 3. Imprimir rellenando con espacios a la derecha (.PadRight)
    Escribir-Centrado $l1.PadRight($maxLen) "White"
    Escribir-Centrado $l2.PadRight($maxLen) "White"
    Escribir-Centrado $l3.PadRight($maxLen) "DarkGray"
    Write-Host ""
    
    # Truco para centrar el prompt de elección (sin los dos puntos dobles)
    $textoPrompt = "Seleccione una opción [1-3]"
    $ancho = $Host.UI.RawUI.WindowSize.Width
    $espacios = " " * ([math]::Max(0, [math]::Floor(($ancho - $textoPrompt.Length - 2) / 2)))
    Write-Host $espacios -NoNewline
    $opcion = Read-Host $textoPrompt

    switch ($opcion) {
        '1' { Mostrar-Encabezado; Modificar-UsuarioActual }
        '2' { Mostrar-Encabezado; Crear-NuevoUsuario }
        '3' { Clear-Host; exit }
        default { Escribir-Centrado "Opción no válida." "Red"; Start-Sleep -s 1 }
    }
}
}


# ---- tools\Invoke-ExtraerLicencias.ps1 ----
# ============================================================
# Invoke-ExtraerLicencias
# Migrado de: EXTAER+LICENCIAS.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-ExtraerLicencias {
    [CmdletBinding()]
    param()
# ============================================================================
# Script: Extractor de Licencias ATLAS y Auditor (Estable)
# Arquitectura: PowerShell (Compatible v2.0+)
# Objetivo: Extracción de BIOS, OS Actual y Detección de Originalidad
# ============================================================================

<#
.SYNOPSIS
    Fuerza la elevación de privilegios de Administrador de manera estable.
#>
$ErrorActionPreference = "Stop"

# (auto-elevación gestionada por Atlas Launcher)

<#
.SYNOPSIS
    Funciones de interfaz de usuario para alineación y formato estandarizado.
#>
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - Herramienta de Licencias"

function Write-Centered {
    param(
        [string]$Text,
        [ConsoleColor]$Color = 'White'
    )
    $windowWidth = $Host.UI.RawUI.WindowSize.Width
    if ($windowWidth -gt $Text.Length) {
        $padding = [math]::Max(0, [math]::Floor(($windowWidth - $Text.Length) / 2))
        $spaces = " " * $padding
        Write-Host "$spaces$Text" -ForegroundColor $Color
    } else {
        Write-Host $Text -ForegroundColor $Color
    }
}

function Show-Header {
    Clear-Host
    Write-Host "`n"
    Write-Centered -Text "========================================" -Color Yellow
    Write-Centered -Text "ATLAS PC SUPPORT" -Color Yellow
    Write-Centered -Text "========================================" -Color Yellow
    Write-Host "`n"
}

<#
.SYNOPSIS
    OPCIÓN 1: Extracción de clave inyectada en placa base (BIOS/UEFI)
#>
function Get-BiosKey {
    Show-Header
    Write-Centered -Text "--- EXTRACCIÓN DE CLAVE DE BIOS (DE FÁBRICA) ---" -Color Cyan
    Write-Host "`n"
    
    try {
        $wmiQuery = Get-WmiObject -Query 'select * from SoftwareLicensingService' -ErrorAction Stop
        $biosKey = $wmiQuery.OA3xOriginalProductKey
        $biosDesc = $wmiQuery.OA3xOriginalProductKeyDescription

        if ([string]::IsNullOrWhiteSpace($biosKey)) {
            Write-Centered -Text "[!] No se encontró clave OEM en la BIOS/UEFI." -Color Red
            Write-Centered -Text "Este equipo no vino con Windows preinstalado de fábrica." -Color Gray
        } else {
            Write-Centered -Text "[+] CLAVE BIOS ENCONTRADA:" -Color Green
            if (-not [string]::IsNullOrWhiteSpace($biosDesc)) {
                Write-Centered -Text "Edición de Fábrica: $biosDesc" -Color Cyan
            }
            Write-Centered -Text $biosKey -Color Yellow
            $biosKey | clip
            Write-Host "`n"
            Write-Centered -Text "(Copiada al portapapeles de manera segura)" -Color Gray
        }
    } catch {
        Write-Centered -Text "[X] Error al consultar la tabla ACPI: $($_.Exception.Message)" -Color Red
    }
    
    Write-Host "`n"
    Write-Centered -Text "Presione ENTER para volver al menú..." -Color White
    $null = Read-Host
}

<#
.SYNOPSIS
    OPCIÓN 2: Extracción de la clave instalada actualmente (Registro Avanzado Base24)
#>
function Get-CurrentKey {
    Show-Header
    Write-Centered -Text "--- EXTRACCIÓN DE CLAVE ACTUAL (OS INSTALADO) ---" -Color Cyan
    Write-Host "`n"
    
    try {
        # 1. Mostrar la Clave de la BIOS como referencia cruzada
        $sls = Get-WmiObject -Query 'select * from SoftwareLicensingService' -ErrorAction SilentlyContinue
        $biosRefKey = $sls.OA3xOriginalProductKey
        $biosRefDesc = $sls.OA3xOriginalProductKeyDescription
        
        if (-not [string]::IsNullOrWhiteSpace($biosRefKey)) {
            Write-Centered -Text "[+] CLAVE DE FÁBRICA (BIOS) DE REFERENCIA:" -Color DarkCyan
            if (-not [string]::IsNullOrWhiteSpace($biosRefDesc)) {
                Write-Centered -Text "Edición de Fábrica: $biosRefDesc" -Color Cyan
            }
            Write-Centered -Text $biosRefKey -Color Gray
            Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray
        }

        # 2. Búsqueda en el Registro para el OS Actual
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
        $backupKey = (Get-ItemProperty -Path $regPath -Name BackupProductKeyDefault -ErrorAction SilentlyContinue).BackupProductKeyDefault

        $hexPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
        
        # Corrección: Leer edición real desde WMI para evitar el falso "Windows 10" del registro de Win 11
        $currentEdition = (Get-WmiObject -Class Win32_OperatingSystem -ErrorAction SilentlyContinue).Caption -replace '^Microsoft\s+', ''
        
        $digitalProductId = (Get-ItemProperty -Path $hexPath -Name DigitalProductId -ErrorAction SilentlyContinue).DigitalProductId
        
        $decodedKey = $null
        $isKMSOrDigital = $false

        if ($digitalProductId -ne $null -and $digitalProductId.Length -ge 67) {
            $isWin8Or10 = [math]::Floor($digitalProductId[66] / 6) -band 1
            $digitalProductId[66] = ($digitalProductId[66] -band 0xF7) -bOr (($isWin8Or10 -band 2) * 4)
            $chars = "BCDFGHJKMPQRTVWXY2346789"
            $decodedKeyStr = ""
            for ($i = 24; $i -ge 0; $i--) {
                $current = 0
                for ($j = 14; $j -ge 0; $j--) {
                    $current = $current * 256 + $digitalProductId[$j + 52]
                    $digitalProductId[$j + 52] = [math]::Floor($current / 24)
                    $current = $current % 24
                }
                $decodedKeyStr = $chars[$current] + $decodedKeyStr
                $last = $current
            }
            if ($isWin8Or10 -eq 1) {
                $decodedKeyStr = $decodedKeyStr.Substring(1, $last) + "N" + $decodedKeyStr.Substring($last + 1)
            }
            $decodedKey = $decodedKeyStr.Insert(5, "-").Insert(11, "-").Insert(17, "-").Insert(23, "-")
            
            if ($decodedKey -eq "BBBBB-BBBBB-BBBBB-BBBBB-BBBBB") {
                $decodedKey = $null
                $isKMSOrDigital = $true
            }
        }

        $activeWmi = Get-WmiObject -Query "SELECT PartialProductKey, Description FROM SoftwareLicensingProduct WHERE LicenseStatus = 1 AND PartialProductKey IS NOT NULL" -ErrorAction SilentlyContinue

        if ($activeWmi) {
            Write-Centered -Text "[+] EVIDENCIA EN MOTOR DE ACTIVACIÓN (ÚNICOS DATOS REALES):" -Color Cyan
            foreach ($lic in $activeWmi) {
                Write-Centered -Text "Parcial: ******-******-******-******-$($lic.PartialProductKey)" -Color White
            }
            Write-Host ""
        }

        if (-not [string]::IsNullOrWhiteSpace($currentEdition)) {
            Write-Centered -Text "Edición Instalada: $currentEdition" -Color Cyan
            Write-Host ""
        }

        if ($isKMSOrDigital) {
            Write-Centered -Text "[!] ALERTA TÉCNICA: CLAVE OCULTA POR DISEÑO" -Color Yellow
            Write-Centered -Text "Windows ha borrado la clave del registro por seguridad corporativa." -Color Gray
            Write-Centered -Text "La licencia es MAK o Digital y no reside físicamente en el disco." -Color Gray
        } elseif (-not [string]::IsNullOrWhiteSpace($decodedKey)) {
            Write-Centered -Text "[+] CLAVE DECODIFICADA DEL REGISTRO:" -Color Green
            Write-Centered -Text $decodedKey -Color Yellow
            $decodedKey | clip
        }

        if (-not [string]::IsNullOrWhiteSpace($backupKey)) {
            Write-Host ""
            Write-Centered -Text "[+] CLAVE DE RESPALDO ENCONTRADA:" -Color DarkCyan
            Write-Centered -Text $backupKey -Color Gray
        }

    } catch {
        Write-Centered -Text "[X] Error crítico de decodificación." -Color Red
    }
    
    Write-Host "`n"
    Write-Centered -Text "Presione ENTER para volver al menú..." -Color White
    $null = Read-Host
}

<#
.SYNOPSIS
    OPCIÓN 3: Auditoría nativa mediante SLMGR
#>
function Invoke-NativeAudit {
    Show-Header
    Write-Centered -Text "--- AUDITORÍA NATIVA DEL SISTEMA (SLMGR) ---" -Color Cyan
    Write-Host "`n"
    Write-Centered -Text "Iniciando herramienta oficial de Microsoft..." -Color Gray
    
    # Ejecuta el comando nativo de Windows para mostrar información de la licencia
    cscript //nologo C:\Windows\System32\slmgr.vbs /dli
    
    Write-Host "`n"
    Write-Centered -Text "--- ANÁLISIS DE ORIGINALIDAD ---" -Color Cyan
    try {
        $wmi = Get-WmiObject -Query "SELECT Description, LicenseStatus FROM SoftwareLicensingProduct WHERE LicenseStatus = 1 AND PartialProductKey IS NOT NULL"
        foreach ($item in $wmi) {
            if ($item.Description -match "VOLUME_KMSCLIENT") {
                Write-Centered -Text "[!] DETECTADO: CANAL KMS (Posible activación por emulador)" -Color Yellow
            } elseif ($item.Description -match "VOLUME_MAK|RETAIL|OEM") {
                Write-Centered -Text "[+] DETECTADO: CANAL ORIGINAL ($($item.Description -replace '.*, ', ''))" -Color Green
            }
        }
    } catch {}

    Write-Host "`n"
    Write-Centered -Text "Presione ENTER para volver al menú..." -Color White
    $null = Read-Host
}

<#
.SYNOPSIS
    OPCIÓN 4: Información de Sistema (Incluye Clave BIOS, Clave Actual y Auditoría Visual)
#>
function Get-OsInfo {
    Show-Header
    Write-Centered -Text "--- INFORMACIÓN DEL SISTEMA OPERATIVO ---" -Color Cyan
    Write-Host "`n"
    
    # Variables para almacenar el reporte exportable
    $reportTxt = "========================================`r`nATLAS PC SUPPORT - REPORTE DE SISTEMA`r`n========================================`r`n`r`n"
    $reportHtml = "<html><head><meta charset='UTF-8'><title>Reporte ATLAS</title><style>body{font-family:'Segoe UI',Tahoma,sans-serif;background:#121212;color:#e0e0e0;text-align:center} .container{max-width:700px;margin:auto;background:#1e1e1e;padding:20px;border-radius:10px;box-shadow:0 4px 8px rgba(0,0,0,0.5)} h2{color:#f1c40f} .ok{color:#2ecc71} .warn{color:#f39c12} .info{color:#3498db;font-style:italic;font-size:0.9em;margin-top:5px;}</style></head><body><div class='container'><h2>ATLAS PC SUPPORT<br><small>Reporte de Licencias</small></h2><hr>"

    try {
        # Obtener datos del OS
        $os = Get-WmiObject -Class Win32_OperatingSystem
        Write-Centered -Text "Sistema: $($os.Caption)" -Color White
        Write-Centered -Text "Versión: $($os.Version)" -Color White
        Write-Centered -Text "Arquitectura: $($os.OSArchitecture)" -Color White
        Write-Centered -Text "Serie del OS: $($os.SerialNumber)" -Color White
        
        $reportTxt += "--- SISTEMA OPERATIVO ---`r`nSistema: $($os.Caption)`r`nVersión: $($os.Version)`r`nArquitectura: $($os.OSArchitecture)`r`nSerie: $($os.SerialNumber)`r`n`r`n"
        $reportHtml += "<h3>SISTEMA OPERATIVO</h3><p>Sistema: $($os.Caption)<br>Versión: $($os.Version)<br>Arquitectura: $($os.OSArchitecture)<br>Serie: $($os.SerialNumber)</p><hr>"
        
        Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray
        
        # ---------------------------------------------------------
        # Obtener datos de la BIOS (Punto 1 integrado)
        # ---------------------------------------------------------
        Write-Centered -Text "--- CLAVE DE FÁBRICA (BIOS/UEFI) ---" -Color Cyan
        $sls = Get-WmiObject -Query 'select * from SoftwareLicensingService'
        $biosKey = $sls.OA3xOriginalProductKey
        $biosDesc = $sls.OA3xOriginalProductKeyDescription
        
        $reportTxt += "--- CLAVE DE FÁBRICA (BIOS/UEFI) ---`r`n"
        $reportHtml += "<h3>CLAVE DE FÁBRICA (BIOS/UEFI)</h3>"

        if ([string]::IsNullOrWhiteSpace($biosKey)) {
            Write-Centered -Text "Clave BIOS: No encontrada (Equipo sin Windows de fábrica)" -Color Gray
            $reportTxt += "Estado: No encontrada.`r`n`r`n"
            $reportHtml += "<p>Estado: No encontrada.</p><hr>"
        } else {
            $descText = if ([string]::IsNullOrWhiteSpace($biosDesc)) { "Versión Desconocida" } else { $biosDesc }
            Write-Centered -Text "Versión de Fábrica: $descText" -Color Cyan
            Write-Centered -Text "Clave BIOS: $biosKey" -Color Green
            Write-Centered -Text "[i] LEYENDA: Las claves inyectadas en BIOS (OEM) provienen del" -Color DarkCyan
            Write-Centered -Text "fabricante del equipo y son licencias genuinas por naturaleza." -Color DarkCyan

            $reportTxt += "Versión de Fábrica: $descText`r`nClave BIOS: $biosKey`r`n[i] LEYENDA: Las claves inyectadas en BIOS (OEM) provienen del fabricante del equipo y son licencias genuinas por naturaleza.`r`n`r`n"
            $reportHtml += "<p>Versión de Fábrica: <strong style='color:#3498db'>$descText</strong></p><p>Clave BIOS: <strong class='ok'>$biosKey</strong></p><p class='info'>[i] LEYENDA: Las claves inyectadas en BIOS (OEM) provienen del fabricante del equipo y son licencias genuinas por naturaleza.</p><hr>"
        }
        
        Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray

        # ---------------------------------------------------------
        # Obtener datos de la Clave Actual (Punto 2 integrado)
        # ---------------------------------------------------------
        Write-Centered -Text "--- CLAVE ACTUAL (OS INSTALADO) ---" -Color Cyan
        
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
        $backupKey = (Get-ItemProperty -Path $regPath -Name BackupProductKeyDefault -ErrorAction SilentlyContinue).BackupProductKeyDefault

        $hexPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
        
        # Corrección WMI:
        $currentEdition = (Get-WmiObject -Class Win32_OperatingSystem -ErrorAction SilentlyContinue).Caption -replace '^Microsoft\s+', ''
        
        $digitalProductId = (Get-ItemProperty -Path $hexPath -Name DigitalProductId -ErrorAction SilentlyContinue).DigitalProductId
        
        $decodedKey = $null
        $isKMSOrDigital = $false

        if ($digitalProductId -ne $null -and $digitalProductId.Length -ge 67) {
            $isWin8Or10 = [math]::Floor($digitalProductId[66] / 6) -band 1
            $digitalProductId[66] = ($digitalProductId[66] -band 0xF7) -bOr (($isWin8Or10 -band 2) * 4)
            $chars = "BCDFGHJKMPQRTVWXY2346789"
            $decodedKeyStr = ""
            for ($i = 24; $i -ge 0; $i--) {
                $current = 0
                for ($j = 14; $j -ge 0; $j--) {
                    $current = $current * 256 + $digitalProductId[$j + 52]
                    $digitalProductId[$j + 52] = [math]::Floor($current / 24)
                    $current = $current % 24
                }
                $decodedKeyStr = $chars[$current] + $decodedKeyStr
                $last = $current
            }
            if ($isWin8Or10 -eq 1) {
                $decodedKeyStr = $decodedKeyStr.Substring(1, $last) + "N" + $decodedKeyStr.Substring($last + 1)
            }
            $decodedKey = $decodedKeyStr.Insert(5, "-").Insert(11, "-").Insert(17, "-").Insert(23, "-")
            
            if ($decodedKey -eq "BBBBB-BBBBB-BBBBB-BBBBB-BBBBB") {
                $decodedKey = $null
                $isKMSOrDigital = $true
            }
        }

        $reportTxt += "--- CLAVE ACTUAL (OS INSTALADO) ---`r`n"
        $reportHtml += "<h3>CLAVE ACTUAL (OS INSTALADO)</h3>"

        $edText = if ([string]::IsNullOrWhiteSpace($currentEdition)) { "Edición Desconocida" } else { $currentEdition }
        Write-Centered -Text "Edición Instalada: $edText" -Color Cyan
        $reportTxt += "Edición Instalada: $edText`r`n"
        $reportHtml += "<p>Edición Instalada: <strong style='color:#3498db'>$edText</strong></p>"

        if ($isKMSOrDigital) {
            Write-Centered -Text "Clave Decodificada: [Oculta por seguridad corporativa]" -Color Yellow
            $reportTxt += "Estado: Clave física oculta (MAK/KMS o Digital).`r`n"
            $reportHtml += "<p class='warn'>Estado: Clave física oculta (MAK/KMS o Digital).</p>"
        } elseif (-not [string]::IsNullOrWhiteSpace($decodedKey)) {
            Write-Centered -Text "Clave Decodificada: $decodedKey" -Color Green
            $reportTxt += "Clave Decodificada: $decodedKey`r`n"
            $reportHtml += "<p>Clave Decodificada: <strong class='ok'>$decodedKey</strong></p>"
        } else {
            Write-Centered -Text "Clave Decodificada: No encontrada" -Color Gray
            $reportTxt += "Clave Decodificada: No encontrada`r`n"
            $reportHtml += "<p>Clave Decodificada: No encontrada</p>"
        }

        if (-not [string]::IsNullOrWhiteSpace($backupKey)) {
            Write-Centered -Text "Clave de Respaldo: $backupKey" -Color DarkCyan
            $reportTxt += "Clave de Respaldo: $backupKey`r`n"
            $reportHtml += "<p>Clave de Respaldo: <strong>$backupKey</strong></p>"
        }

        $reportTxt += "`r`n"
        $reportHtml += "<hr>"
        Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray

        # ---------------------------------------------------------
        # Obtener datos de Originalidad Visual (Punto 3 integrado)
        # ---------------------------------------------------------
        Write-Centered -Text "--- ANÁLISIS DE ORIGINALIDAD ---" -Color Cyan
        $wmiLic = Get-WmiObject -Query "SELECT Description, LicenseStatus FROM SoftwareLicensingProduct WHERE LicenseStatus = 1 AND PartialProductKey IS NOT NULL"
        
        $reportTxt += "--- ANÁLISIS DE ORIGINALIDAD ---`r`n"
        $reportHtml += "<h3>ANÁLISIS DE ORIGINALIDAD</h3>"

        if (-not $wmiLic) {
            Write-Centered -Text "[!] No se detectó ninguna licencia activa en el sistema." -Color Red
            $reportTxt += "Estado: Sin licencia activa.`r`n"
            $reportHtml += "<p class='warn'>Estado: Sin licencia activa.</p>"
        } else {
            foreach ($item in $wmiLic) {
                $cleanDesc = $item.Description -replace '.*, ', ''
                if ($item.Description -match "VOLUME_KMSCLIENT") {
                    Write-Centered -Text "[!] DETECTADO: CANAL KMS ($cleanDesc)" -Color Yellow
                    Write-Centered -Text "[i] LEYENDA: Activación por volumen. Si este equipo no pertenece" -Color DarkCyan
                    Write-Centered -Text "a una empresa, es muy probable que se haya usado un emulador (Pirata)." -Color DarkCyan

                    $reportTxt += "[!] DETECTADO: CANAL KMS ($cleanDesc)`r`n[i] LEYENDA: Activación por volumen. Si este equipo no pertenece a una empresa, es muy probable que se haya usado un emulador (Pirata).`r`n"
                    $reportHtml += "<p class='warn'>[!] DETECTADO: CANAL KMS ($cleanDesc)</p><p class='info'>[i] LEYENDA: Activación por volumen. Si este equipo no pertenece a una empresa, es muy probable que se haya usado un emulador (Pirata).</p>"
                } elseif ($item.Description -match "VOLUME_MAK|RETAIL|OEM") {
                    Write-Centered -Text "[+] DETECTADO: CANAL ORIGINAL ($cleanDesc)" -Color Green
                    Write-Centered -Text "[i] LEYENDA: Se ha comprobado con el motor de licencias de Windows" -Color DarkCyan
                    Write-Centered -Text "que el canal actual es oficial y se encuentra ACTIVADO legalmente." -Color DarkCyan

                    $reportTxt += "[+] DETECTADO: CANAL ORIGINAL ($cleanDesc)`r`n[i] LEYENDA: Se ha comprobado con el motor de licencias de Windows que el canal actual es oficial y se encuentra ACTIVADO legalmente.`r`n"
                    $reportHtml += "<p class='ok'>[+] DETECTADO: CANAL ORIGINAL ($cleanDesc)</p><p class='info'>[i] LEYENDA: Se ha comprobado con el motor de licencias de Windows que el canal actual es oficial y se encuentra ACTIVADO legalmente.</p>"
                } else {
                    Write-Centered -Text "[?] DETECTADO: CANAL DESCONOCIDO ($cleanDesc)" -Color Gray
                    
                    $reportTxt += "[?] DETECTADO: CANAL DESCONOCIDO ($cleanDesc)`r`n"
                    $reportHtml += "<p>[?] DETECTADO: CANAL DESCONOCIDO ($cleanDesc)</p>"
                }
            }
        }
        $reportHtml += "</div></body></html>"
        
    } catch {
        Write-Centered -Text "[X] Error al obtener información del sistema." -Color Red
    }
    
    # Menú de Exportación
    Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray
    Write-Centered -Text "--- EXPORTAR ESTE REPORTE ---" -Color Yellow
    Write-Centered -Text "[ 1 ] Guardar como Documento de Texto (.txt)" -Color White
    Write-Centered -Text "[ 2 ] Guardar como Página Web (.html)" -Color White
    Write-Centered -Text "[ 0 ] Volver al menú sin guardar" -Color Red
    Write-Host "`n"

    $exportLoop = $true
    while ($exportLoop) {
        $expSel = Read-Host " Seleccione una opción"
        $desktopPath = [Environment]::GetFolderPath("Desktop")
        
        switch ($expSel) {
            '1' {
                $outPath = "$desktopPath\ATLAS_Reporte_Licencias.txt"
                [System.IO.File]::WriteAllText($outPath, $reportTxt)
                Write-Host "`n"
                Write-Centered -Text "[+] Guardado con éxito en su Escritorio:" -Color Green
                Write-Centered -Text "ATLAS_Reporte_Licencias.txt" -Color Gray
                $exportLoop = $false
            }
            '2' {
                $outPath = "$desktopPath\ATLAS_Reporte_Licencias.html"
                [System.IO.File]::WriteAllText($outPath, $reportHtml, [System.Text.Encoding]::UTF8)
                Write-Host "`n"
                Write-Centered -Text "[+] Guardado con éxito en su Escritorio:" -Color Green
                Write-Centered -Text "ATLAS_Reporte_Licencias.html" -Color Gray
                $exportLoop = $false
            }
            '0' {
                $exportLoop = $false
            }
            default {
                Write-Centered -Text "[!] Selección inválida. Intente nuevamente." -Color Red
            }
        }
    }

    Write-Host "`n"
    Write-Centered -Text "Presione ENTER para volver al menú principal..." -Color White
    $null = Read-Host
}

# Bucle principal
$menuLoop = $true
while ($menuLoop) {
    Show-Header
    Write-Centered -Text "M E N U   P R I N C I P A L" -Color Cyan
    Write-Host "`n"
    Write-Centered -Text "[ 1 ] Extraer Clave de Fábrica (BIOS/UEFI)" -Color White
    Write-Centered -Text "[ 2 ] Extraer y Diagnosticar Clave Actual (Registro)" -Color White
    Write-Centered -Text "[ 3 ] Auditoría Nativa y Originalidad (SLMGR)" -Color White
    Write-Centered -Text "[ 4 ] Reporte Completo (OS, BIOS, Actual y Originalidad)" -Color White
    Write-Centered -Text "[ 0 ] Salir" -Color Red
    Write-Host "`n"
    
    $selection = Read-Host " Seleccione una opción"
    
    switch ($selection) {
        '1' { Get-BiosKey }
        '2' { Get-CurrentKey }
        '3' { Invoke-NativeAudit }
        '4' { Get-OsInfo }
        '0' { $menuLoop = $false }
    }
}
}


# ---- tools\Invoke-Fase0.ps1 ----
# ============================================================
# Invoke-Fase0
# Migrado de: Fase+0.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-Fase0 {
    [CmdletBinding()]
    param()
<#
    .SYNOPSIS
    ATLAS PC SUPPORT - FASE 0: IPv6 Hardening Tool v4.0 (Smart Custom Log)
#>

# --- 1. CONFIGURACIÓN INICIAL ---
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$AtlasOrange = "$([char]0x1b)[38;2;255;102;0m"
$AtlasWhite  = "$([char]0x1b)[38;2;255;255;255m"
$AtlasGray   = "$([char]0x1b)[38;2;100;100;100m"
$AtlasGreen  = "$([char]0x1b)[38;2;0;255;0m"
$AtlasRed    = "$([char]0x1b)[38;2;255;50;50m"
$Reset       = "$([char]0x1b)[0m"

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

# Variables globales para el sistema de logs
$global:IsLogging = $false 
$global:LogFile = ""

# --- 2. AUTO-ELEVACIÓN A ADMINISTRADOR ---
# (auto-elevación gestionada por Atlas Launcher)

# --- 3. FUNCIONES VISUALES ---
function Write-Centered {
    param([string]$Text, [string]$Color = $AtlasWhite)
    $WindowWidth = $Host.UI.RawUI.WindowSize.Width
    $Padding = [math]::Max(0, [int](($WindowWidth - $Text.Length) / 2))
    $LeftSpaces = " " * $Padding
    Write-Host "$LeftSpaces$Color$Text$Reset"
}

function Show-Header {
    Clear-Host
    Write-Host "`n`n`n"
    Write-Centered "ATLAS PC SUPPORT" $AtlasOrange
    Write-Centered "SEGURIDAD FASE 0" $AtlasWhite
    Write-Centered "================================" $AtlasGray
    
    if ($global:IsLogging) {
        Write-Centered "[ REC ] BITÁCORA ACTIVA" $AtlasRed
    } else {
        Write-Centered "[   ] BITÁCORA INACTIVA" $AtlasGray
    }
    Write-Host "`n`n"
}

# --- 4. MOTOR DE LOGS PERSONALIZADO ---
function Write-AtlasLog {
    param([string]$Message)
    # Solo escribe en el archivo si la bitácora está activa
    if ($global:IsLogging -and $global:LogFile) {
        $Timestamp = Get-Date -Format "HH:mm:ss"
        "[$Timestamp] $Message" | Out-File -FilePath $global:LogFile -Append -Encoding UTF8
    }
}

function Start-AtlasLog {
    if ($global:IsLogging) {
        Show-Header; Write-Centered "La bitácora ya está iniciada." $AtlasOrange; Start-Sleep -Seconds 2; return
    }

    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    $LogFolder = Join-Path -Path $DesktopPath -ChildPath "ATLAS_SUPPORT"
    if (-not (Test-Path -Path $LogFolder)) { New-Item -ItemType Directory -Path $LogFolder -Force | Out-Null }
    
    $TimeString = Get-Date -Format "yyyyMMdd_HHmmss"
    $global:LogFile = Join-Path -Path $LogFolder -ChildPath "Reporte_Fase0_$TimeString.txt"
    $global:IsLogging = $true
    
    # Escribir encabezado profesional en el archivo de texto
    $ReportHeader = "=========================================`n" +
                    " ATLAS PC SUPPORT - REPORTE TÉCNICO`n" +
                    "=========================================`n" +
                    "Fecha de inicio : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')`n" +
                    "Equipo Cliente  : $env:COMPUTERNAME`n" +
                    "Usuario         : $env:USERNAME`n" +
                    "=========================================`n"
    $ReportHeader | Out-File -FilePath $global:LogFile -Encoding UTF8
    
    Show-Header
    Write-Centered "Bitácora iniciada correctamente." $AtlasGreen
    Start-Sleep -Seconds 1
}

function Stop-AtlasLog {
    if (-not $global:IsLogging) { return }
    
    Write-AtlasLog "--- CIERRE DE SESIÓN ---"
    $global:IsLogging = $false
    
    Show-Header
    Write-Centered "Reporte guardado exitosamente." $AtlasGreen
    Start-Sleep -Seconds 1
}

# --- 5. FUNCIONES DE LÓGICA CON LOGS ---
function Hardening-Apply {
    Show-Header
    Write-Centered "[ APLICANDO PROTOCOLO DE BLINDAJE ]" $AtlasWhite
    Write-Host "`n"
    
    Write-AtlasLog "-> INICIANDO PROTOCOLO DE BLINDAJE (FASE 0)"

    Write-Centered "Desactivando Teredo Tunneling... [OK]" $AtlasGreen
    Write-AtlasLog "[EJECUTANDO] Desactivando Teredo Tunneling..."
    $res1 = netsh interface teredo set state disabled
    Write-AtlasLog "Resultado: $res1"
    
    Write-Centered "Desactivando 6to4 Interface... [OK]" $AtlasGreen
    Write-AtlasLog "[EJECUTANDO] Desactivando 6to4 Interface..."
    $res2 = netsh interface ipv6 6to4 set state state=disabled undoonstop=disabled
    Write-AtlasLog "Resultado: $res2"

    Write-Centered "Desactivando ISATAP Tunneling... [OK]" $AtlasGreen
    Write-AtlasLog "[EJECUTANDO] Desactivando ISATAP Tunneling..."
    $res3 = netsh interface ipv6 isatap set state state=disabled
    Write-AtlasLog "Resultado: $res3"

    Write-AtlasLog "-> FASE 0 COMPLETADA CON ÉXITO."

    Write-Host "`n"
    Write-Centered "FASE 0 COMPLETADA." $AtlasOrange
    Write-Host "`n"
    Write-Centered "[ Presiona cualquier tecla para volver ]" $AtlasGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Restore-Defaults {
    Show-Header
    Write-Centered "[ RESTAURANDO VALORES DE FÁBRICA ]" $AtlasRed
    Write-Host "`n"

    Write-AtlasLog "-> REVIRTIENDO CAMBIOS (RESTAURACIÓN DE FÁBRICA)"

    Write-Centered "Restaurando Teredo... [OK]" $AtlasWhite
    $res1 = netsh interface teredo set state type=default
    Write-AtlasLog "[EJECUTANDO] Restaurando Teredo... Resultado: $res1"

    Write-Centered "Restaurando 6to4... [OK]" $AtlasWhite
    $res2 = netsh interface ipv6 6to4 set state state=enabled
    Write-AtlasLog "[EJECUTANDO] Restaurando 6to4... Resultado: $res2"

    Write-Centered "Restaurando ISATAP... [OK]" $AtlasWhite
    $res3 = netsh interface ipv6 isatap set state state=enabled
    Write-AtlasLog "[EJECUTANDO] Restaurando ISATAP... Resultado: $res3"

    Write-AtlasLog "-> ADVERTENCIA: El equipo ha sido devuelto a su estado predeterminado."

    Write-Host "`n"
    Write-Centered "WARN: El equipo ha vuelto a su estado vulnerable." $AtlasWhite
    Write-Host "`n"
    Write-Centered "[ Presiona cualquier tecla para volver ]" $AtlasGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Check-Status {
    Show-Header
    Write-Centered "[ ESTADO ACTUAL DE LA RED ]" $AtlasWhite
    Write-Host "`n"
    
    Write-AtlasLog "-> SOLICITANDO ESTADO ACTUAL DE INTERFACES"

    $Teredo = (netsh interface teredo show state | Out-String).Trim()
    $6to4 = (netsh interface ipv6 6to4 show state | Out-String).Trim()
    
    # Grabamos el resultado limpio en el log
    Write-AtlasLog "--- RESULTADO TEREDO ---`n$Teredo"
    Write-AtlasLog "--- RESULTADO 6to4 ---`n$6to4"

    Write-Centered "--- TEREDO STATE ---" $AtlasGray
    Write-Centered "$Teredo" $AtlasWhite
    Write-Host "`n"
    Write-Centered "--- 6to4 STATE ---" $AtlasGray
    Write-Centered "$6to4" $AtlasWhite
    Write-Host "`n"
    Write-Centered "[ Presiona cualquier tecla para volver ]" $AtlasGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# --- 6. MENÚ PRINCIPAL ---
do {
    Show-Header
    
    Write-Centered "[1] Iniciar bitácora               " $AtlasGreen
    Write-Centered "[2] EJECUTAR BLINDAJE (Recomendado)" $AtlasWhite
    Write-Centered "[3] Verificar Estado Actual        " $AtlasWhite
    Write-Centered "[4] Restaurar Configuración (Undo) " $AtlasRed
    Write-Centered "[5] Finalizar bitácora             " $AtlasGray
    Write-Centered "[Q] Salir                          " $AtlasGray
    
    Write-Host "`n      > Atlas_Admin@Terminal: " -NoNewline -ForegroundColor DarkYellow
    $Selection = Read-Host

    switch ($Selection) {
        '1' { Start-AtlasLog }
        '2' { Hardening-Apply }
        '3' { Check-Status }
        '4' { Restore-Defaults }
        '5' { Stop-AtlasLog }
        'q' { Stop-AtlasLog; exit }
        'Q' { Stop-AtlasLog; exit }
    }
} while ($true)
}


# ---- tools\Invoke-FastCopy.ps1 ----
# ============================================================
# Invoke-FastCopy
# Migrado de: FastCopy.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-FastCopy {
    [CmdletBinding()]
    param()
# ========================================================
# ATLAS PC SUPPORT - FASTCOPY EDITION v3 (PowerShell)
# Multi-origen + Perfiles + Comparar + Notificacion
# MD5 + Speed adapt + Resumen exportable + Exclusiones
# ========================================================

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Gray"
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - FastCopy v3"
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(110, 48) } catch {}
$ErrorActionPreference = "Continue"

# ==================== BUSCAR FASTCOPY ====================

function Find-FastCopy {
    $searchPaths = @(
        (Join-Path $PSScriptRoot "FastCopy.exe"),
        (Join-Path $PSScriptRoot "fastcopy\FastCopy.exe"),
        (Join-Path $PSScriptRoot "..\Apps\FastCopy\FastCopy.exe"),
        (Join-Path $PSScriptRoot "Apps\FastCopy\FastCopy.exe"),
        "C:\Program Files\FastCopy\FastCopy.exe",
        "C:\Program Files (x86)\FastCopy\FastCopy.exe",
        (Join-Path $env:LOCALAPPDATA "FastCopy\FastCopy.exe")
    )
    foreach ($path in $searchPaths) {
        if (Test-Path $path) { return (Resolve-Path $path).Path }
    }
    $inPath = Get-Command "FastCopy.exe" -ErrorAction SilentlyContinue
    if ($inPath) { return $inPath.Source }
    $found = Get-ChildItem -Path $PSScriptRoot -Filter "FastCopy.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) { return $found.FullName }
    return $null
}

# ==================== FUNCIONES BASE ====================

function Write-Centered {
    param ([string]$Text, [string]$Color = "White")
    $W = try { $Host.UI.RawUI.WindowSize.Width } catch { 80 }
    $Pad = [math]::Max(0, [math]::Floor(($W - $Text.Length) / 2))
    Write-Host (" " * $Pad + $Text) -ForegroundColor $Color
}

function Clean-Path {
    param([string]$RawPath)
    return $RawPath.Trim().Trim('"').Trim("'").TrimEnd('\')
}

function Format-Size {
    param([long]$Bytes)
    if ($Bytes -ge 1GB) { return "{0:N2} GB" -f ($Bytes / 1GB) }
    if ($Bytes -ge 1MB) { return "{0:N1} MB" -f ($Bytes / 1MB) }
    if ($Bytes -ge 1KB) { return "{0:N0} KB" -f ($Bytes / 1KB) }
    return "$Bytes B"
}

function Format-Duration {
    param([TimeSpan]$Duration)
    if ($Duration.TotalHours -ge 1) { return "{0}h {1}m {2}s" -f [int]$Duration.TotalHours, $Duration.Minutes, $Duration.Seconds }
    if ($Duration.TotalMinutes -ge 1) { return "{0}m {1}s" -f [int]$Duration.TotalMinutes, $Duration.Seconds }
    return "{0:N1}s" -f $Duration.TotalSeconds
}

function Get-FolderStats {
    param([string]$Path)
    $items = Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue
    $totalSize = ($items | Measure-Object Length -Sum -ErrorAction SilentlyContinue).Sum
    if (-not $totalSize) { $totalSize = 0 }
    return @{ Files = $items.Count; Size = $totalSize; SizeMB = [math]::Round($totalSize / 1MB, 1) }
}

function Detect-DriveType {
    param([string]$DriveLetter)
    $letter = $DriveLetter.TrimEnd(':', '\')
    try {
        $vol = Get-Volume -DriveLetter $letter -ErrorAction Stop
        if ($vol.DriveType -eq 'Removable') {
            return @{ Type = "USB"; Speed = "autoslow"; Desc = "USB Removible"; Color = "Yellow"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
        }
        $part = Get-Partition -DriveLetter $letter -ErrorAction Stop
        $disk = Get-Disk -Number $part.DiskNumber -ErrorAction Stop
        $phys = Get-PhysicalDisk -ErrorAction SilentlyContinue | Where-Object { $_.DeviceId -eq $disk.Number.ToString() }
        if ($disk.BusType -eq 'USB') {
            return @{ Type = "USB"; Speed = "autoslow"; Desc = "USB Externo"; Color = "Yellow"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
        }
        if ($disk.BusType -eq 'NVMe' -or ($phys -and $phys.MediaType -match 'SSD')) {
            return @{ Type = "SSD"; Speed = "full"; Desc = "SSD/NVMe"; Color = "Green"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
        }
        return @{ Type = "HDD"; Speed = "full"; Desc = "HDD Mecanico"; Color = "Cyan"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
    } catch {
        return @{ Type = "UNKNOWN"; Speed = "autoslow"; Desc = "No detectado"; Color = "Gray"; Label = ""; FreeBytes = 0 }
    }
}

# ==================== EXPLORADOR DE ARCHIVOS ====================

function Select-FolderDialog {
    param([string]$Description = "Selecciona una carpeta")
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = $Description
    $dialog.ShowNewFolderButton = $true
    if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { return $dialog.SelectedPath }
    return $null
}

function Select-FileDialog {
    param([string]$Title = "Selecciona un archivo")
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Title = $Title
    $dialog.Filter = "Todos los archivos (*.*)|*.*"
    if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { return $dialog.FileName }
    return $null
}

function Get-PathFromUser {
    param([string]$Prompt = "RUTA", [string]$Mode = "any")
    Write-Host ""
    Write-Host "  ARRASTRA, escribe ruta, o usa el explorador:" -ForegroundColor White
    Write-Host "      [E] Abrir explorador" -ForegroundColor Cyan
    Write-Host "      [B] Volver  [S] Salir" -ForegroundColor DarkGray
    Write-Host ""
    $userInput = Read-Host "      ${Prompt}"
    if ($userInput -eq "S" -or $userInput -eq "s") { return "EXIT" }
    if ($userInput -eq "B" -or $userInput -eq "b") { return "BACK" }
    if ($userInput -eq "E" -or $userInput -eq "e") {
        if ($Mode -eq "folder") {
            $path = Select-FolderDialog -Description "Selecciona carpeta"
        } else {
            Write-Host "      [1] Carpeta  [2] Archivo" -ForegroundColor White
            $tipo = Read-Host "      >"
            if ($tipo -eq "2") { $path = Select-FileDialog } else { $path = Select-FolderDialog }
        }
        if (-not $path) { return "BACK" }
        return $path
    }
    return Clean-Path $userInput
}

# ==================== PERFILES DE RESPALDO ====================

function Get-UserProfile {
    $userRoot = [Environment]::GetFolderPath("UserProfile")
    
    $profiles = @{
        "1" = @{
            Name = "RESPALDO COMPLETO DE USUARIO"
            Desc = "Desktop + Documentos + Fotos + Videos + Descargas + Favoritos"
            Paths = @(
                (Join-Path $userRoot "Desktop"),
                (Join-Path $userRoot "Documents"),
                (Join-Path $userRoot "Pictures"),
                (Join-Path $userRoot "Videos"),
                (Join-Path $userRoot "Downloads"),
                (Join-Path $userRoot "Favorites")
            )
        }
        "2" = @{
            Name = "SOLO DOCUMENTOS Y ESCRITORIO"
            Desc = "Desktop + Documentos (lo mas critico)"
            Paths = @(
                (Join-Path $userRoot "Desktop"),
                (Join-Path $userRoot "Documents")
            )
        }
        "3" = @{
            Name = "FOTOS Y VIDEOS"
            Desc = "Pictures + Videos"
            Paths = @(
                (Join-Path $userRoot "Pictures"),
                (Join-Path $userRoot "Videos")
            )
        }
        "4" = @{
            Name = "OUTLOOK + CORREO"
            Desc = "PST/OST de Outlook + Signatures"
            Paths = @(
                (Join-Path $userRoot "Documents\Outlook Files"),
                (Join-Path $env:LOCALAPPDATA "Microsoft\Outlook"),
                (Join-Path $env:APPDATA "Microsoft\Signatures")
            )
        }
        "5" = @{
            Name = "NAVEGADORES (Favoritos/Bookmarks)"
            Desc = "Chrome + Edge + Firefox bookmarks"
            Paths = @(
                (Join-Path $env:LOCALAPPDATA "Google\Chrome\User Data\Default"),
                (Join-Path $env:LOCALAPPDATA "Microsoft\Edge\User Data\Default"),
                (Join-Path $env:APPDATA "Mozilla\Firefox\Profiles")
            )
        }
    }
    return $profiles
}

function Show-ProfileMenu {
    Write-Host ""
    Write-Centered "=== PERFILES DE RESPALDO RAPIDO ===" "DarkYellow"
    Write-Host ""
    
    $profiles = Get-UserProfile
    foreach ($key in ($profiles.Keys | Sort-Object)) {
        $p = $profiles[$key]
        Write-Host "      [${key}] $($p.Name)" -ForegroundColor White
        Write-Host "          $($p.Desc)" -ForegroundColor DarkGray
        
        # Contar carpetas que existen
        $existCount = ($p.Paths | Where-Object { Test-Path $_ }).Count
        $totalCount = $p.Paths.Count
        $existColor = if ($existCount -eq $totalCount) { "Green" } elseif ($existCount -gt 0) { "Yellow" } else { "Red" }
        Write-Host "          Carpetas: ${existCount}/${totalCount} encontradas" -ForegroundColor $existColor
        Write-Host ""
    }
    
    Write-Host "      [B] Volver" -ForegroundColor DarkGray
    Write-Host ""
    $sel = Read-Host "      >"
    
    if ($sel -eq "B" -or $sel -eq "b") { return $null }
    if ($profiles.ContainsKey($sel)) {
        $selected = $profiles[$sel]
        $validPaths = @($selected.Paths | Where-Object { Test-Path $_ })
        if ($validPaths.Count -eq 0) {
            Write-Host "      [ERROR] Ninguna carpeta del perfil existe." -ForegroundColor Red
            return $null
        }
        return @{ Name = $selected.Name; Paths = $validPaths }
    }
    Write-Host "      Opcion no valida." -ForegroundColor Red
    return $null
}

# ==================== MULTI-ORIGEN ====================

function Get-MultipleOrigins {
    $origins = @()
    Write-Host ""
    Write-Centered "=== MULTI-ORIGEN ===" "DarkYellow"
    Write-Host ""
    Write-Host "      Agrega carpetas/archivos uno por uno." -ForegroundColor DarkGray
    Write-Host "      Escribe [OK] cuando termines." -ForegroundColor DarkGray
    
    while ($true) {
        Write-Host ""
        Write-Host "      Origenes agregados: $($origins.Count)" -ForegroundColor $(if ($origins.Count -gt 0) { "Green" } else { "Gray" })
        if ($origins.Count -gt 0) {
            foreach ($o in $origins) {
                $oName = Split-Path $o -Leaf
                Write-Host "        -> ${oName}" -ForegroundColor Cyan
            }
        }
        
        $pathResult = Get-PathFromUser -Prompt "AGREGAR (o [OK] para continuar)" -Mode "any"
        
        if ($pathResult -eq "EXIT") { return "EXIT" }
        if ($pathResult -eq "BACK") {
            if ($origins.Count -gt 0) { return $origins }
            return "BACK"
        }
        if ($pathResult -eq "OK" -or $pathResult -eq "ok") {
            if ($origins.Count -eq 0) {
                Write-Host "      [ERROR] Agrega al menos un origen." -ForegroundColor Red
                continue
            }
            return $origins
        }
        
        if (-not (Test-Path $pathResult)) {
            Write-Host "      [ERROR] No existe: ${pathResult}" -ForegroundColor Red
            continue
        }
        
        if ($origins -contains $pathResult) {
            Write-Host "      [!] Ya esta en la lista." -ForegroundColor Yellow
            continue
        }
        
        $origins += $pathResult
        $itemName = Split-Path $pathResult -Leaf
        $itemType = if (Test-Path $pathResult -PathType Container) { "CARPETA" } else { "ARCHIVO" }
        Write-Host "      [+] ${itemType}: ${itemName}" -ForegroundColor Green
    }
}

# ==================== COMPARAR ANTES DE COPIAR ====================

function Compare-BeforeCopy {
    param([string[]]$Origins, [string]$Destino)
    
    Write-Host ""
    Write-Centered "ANALIZANDO DIFERENCIAS..." "Yellow"
    Write-Host ""
    
    $totalNew = 0; $totalModified = 0; $totalEqual = 0; $totalSizeNew = 0; $totalSizeMod = 0
    
    foreach ($origen in $Origins) {
        $srcName = Split-Path $origen -Leaf
        $isFile = -not (Test-Path $origen -PathType Container)
        
        if ($isFile) {
            $srcFile = Get-Item $origen
            $dstFile = Join-Path $Destino $srcFile.Name
            if (-not (Test-Path $dstFile)) {
                $totalNew++; $totalSizeNew += $srcFile.Length
            } elseif ($srcFile.LastWriteTime -gt (Get-Item $dstFile).LastWriteTime) {
                $totalModified++; $totalSizeMod += $srcFile.Length
            } else {
                $totalEqual++
            }
        } else {
            $dstSubFolder = Join-Path $Destino $srcName
            $srcFiles = Get-ChildItem -Path $origen -Recurse -File -ErrorAction SilentlyContinue
            
            foreach ($sf in $srcFiles) {
                $relPath = $sf.FullName.Substring($origen.Length).TrimStart('\')
                $df = Join-Path $dstSubFolder $relPath
                
                if (-not (Test-Path $df)) {
                    $totalNew++; $totalSizeNew += $sf.Length
                } elseif ($sf.LastWriteTime -gt (Get-Item $df -ErrorAction SilentlyContinue).LastWriteTime) {
                    $totalModified++; $totalSizeMod += $sf.Length
                } else {
                    $totalEqual++
                }
            }
        }
    }
    
    $totalTransfer = $totalSizeNew + $totalSizeMod
    
    Write-Host "    NUEVOS:      ${totalNew} archivos ($(Format-Size $totalSizeNew))" -ForegroundColor Green
    Write-Host "    MODIFICADOS: ${totalModified} archivos ($(Format-Size $totalSizeMod))" -ForegroundColor Yellow
    Write-Host "    IGUALES:     ${totalEqual} archivos (sin cambios)" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    TRANSFERIR:  $($totalNew + $totalModified) archivos ($(Format-Size $totalTransfer))" -ForegroundColor Cyan
    
    return @{
        New = $totalNew; Modified = $totalModified; Equal = $totalEqual
        SizeNew = $totalSizeNew; SizeModified = $totalSizeMod; SizeTotal = $totalTransfer
    }
}

# ==================== EXCLUSIONES ====================

function Get-Exclusions {
    Write-Host ""
    Write-Host "  [?] EXCLUSIONES:" -ForegroundColor Cyan
    Write-Host "      [1] Ninguna (copiar todo)" -ForegroundColor White
    Write-Host "      [2] Temporales (.tmp, .log, .bak, cache)" -ForegroundColor White
    Write-Host "      [3] ISOs y VMs (.iso, .vhd, .wim)" -ForegroundColor White
    Write-Host "      [4] Personalizado (escribir extensiones)" -ForegroundColor White
    Write-Host "      [B] Volver" -ForegroundColor DarkGray
    Write-Host ""
    $sel = Read-Host "      >"
    
    switch ($sel) {
        "2" {
            Write-Host "      [OK] Excluyendo temporales y cache" -ForegroundColor Green
            return @{ 
                Files = @("*.tmp", "*.log", "*.bak", "*.cache", "*.temp", "~*")
                Dirs = @("Temp", "tmp", "Cache", "__pycache__", "node_modules", ".git")
                Label = "Temporales/Cache"
            }
        }
        "3" {
            Write-Host "      [OK] Excluyendo ISOs y VMs" -ForegroundColor Green
            return @{
                Files = @("*.iso", "*.vhd", "*.vhdx", "*.wim", "*.esd", "*.vmdk")
                Dirs = @()
                Label = "ISOs/VMs"
            }
        }
        "4" {
            Write-Host "      Extensiones separadas por coma (ej: .mp4,.avi,.mkv):" -ForegroundColor White
            $custom = Read-Host "      >"
            if (-not [string]::IsNullOrWhiteSpace($custom)) {
                $exts = ($custom -split ',') | ForEach-Object {
                    $e = $_.Trim()
                    if ($e -notmatch '^\*') { $e = "*${e}" }
                    $e
                }
                Write-Host "      [OK] Excluyendo: $($exts -join ', ')" -ForegroundColor Green
                return @{ Files = $exts; Dirs = @(); Label = "Personalizado" }
            }
            return @{ Files = @(); Dirs = @(); Label = "Ninguna" }
        }
        "B" { return "BACK" }
        default { return @{ Files = @(); Dirs = @(); Label = "Ninguna" } }
    }
}

# ==================== NOTIFICACION ====================

function Send-Notification {
    param([string]$Title, [string]$Message, [bool]$Success = $true)
    
    # Sonido
    if ($Success) {
        [Console]::Beep(800, 200); [Console]::Beep(1000, 200); [Console]::Beep(1200, 300)
    } else {
        [Console]::Beep(400, 500); [Console]::Beep(300, 500)
    }
    
    # Toast notification de Windows
    try {
        Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
        $notify = New-Object System.Windows.Forms.NotifyIcon
        $notify.Icon = [System.Drawing.SystemIcons]::Information
        $notify.BalloonTipTitle = $Title
        $notify.BalloonTipText = $Message
        $notify.BalloonTipIcon = if ($Success) { "Info" } else { "Error" }
        $notify.Visible = $true
        $notify.ShowBalloonTip(5000)
        
        Start-Sleep -Seconds 6
        $notify.Dispose()
    } catch {}
}

# ==================== RESUMEN EXPORTABLE ====================

function Export-CopyReport {
    param(
        [string[]]$Origins, [string]$Destino, [string]$Mode, [string]$DiskType,
        [hashtable]$Result, [hashtable]$Integrity, [hashtable]$Comparison,
        [string]$ExclusionLabel, [string]$Cliente
    )
    
    $reportFile = Join-Path ([Environment]::GetFolderPath("Desktop")) "Resumen_Atlas_${Cliente}_$(Get-Date -Format 'yyyy-MM-dd_HHmm').txt"
    
    $r = @()
    $r += "================================================================"
    $r += "  ATLAS PC SUPPORT - RESUMEN DE COPIA"
    $r += "================================================================"
    $r += ""
    $r += "FECHA:       $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
    $r += "EQUIPO:      $env:COMPUTERNAME"
    $r += "USUARIO:     $env:USERNAME"
    $r += "PROYECTO:    ${Cliente}"
    $r += ""
    $r += "--- CONFIGURACION ---"
    $r += "MOTOR:       FastCopy"
    $r += "MODO:        ${Mode}"
    $r += "DISCO:       ${DiskType}"
    $r += "EXCLUSIONES: ${ExclusionLabel}"
    $r += ""
    $r += "--- ORIGENES ---"
    foreach ($o in $Origins) { $r += "  -> ${o}" }
    $r += ""
    $r += "--- DESTINO ---"
    $r += "  -> ${Destino}"
    $r += ""
    $r += "--- RESULTADO ---"
    $r += "ESTADO:      $(if ($Result.OK) { 'EXITOSO' } else { 'CON ERRORES' })"
    $r += "TIEMPO:      $(Format-Duration $Result.Elapsed)"
    $r += "COPIADO:     $(Format-Size $Result.BytesCopied)"
    $r += "VELOCIDAD:   $($Result.SpeedMBps) MB/s"
    
    if ($Comparison) {
        $r += ""
        $r += "--- ANALISIS PRE-COPIA ---"
        $r += "NUEVOS:      $($Comparison.New) archivos"
        $r += "MODIFICADOS: $($Comparison.Modified) archivos"
        $r += "IGUALES:     $($Comparison.Equal) archivos"
    }
    
    if ($Integrity) {
        $r += ""
        $r += "--- VERIFICACION MD5 ---"
        $r += "VERIFICADOS: $($Integrity.Checked) archivos"
        $r += "OK:          $($Integrity.Passed)"
        $r += "FALLOS:      $($Integrity.Failed)"
        $r += "FALTANTES:   $($Integrity.Missing)"
        $r += "RESULTADO:   $(if ($Integrity.OK) { 'INTEGRIDAD VERIFICADA' } else { 'PROBLEMAS DETECTADOS' })"
    }
    
    $r += ""
    $r += "--- LOG ---"
    $r += "ARCHIVO:     $(if ($Result.LogFile) { $Result.LogFile } else { 'N/A' })"
    $r += ""
    $r += "================================================================"
    $r += "  Generado por ATLAS PC SUPPORT - FastCopy v3"
    $r += "================================================================"
    
    ($r -join "`r`n") | Out-File -FilePath $reportFile -Encoding UTF8
    return $reportFile
}

# ==================== VERIFICACIÓN MD5 ====================

function Test-CopyIntegrity {
    param([string]$Origen, [string]$Destino, [int]$SampleSize = 15)
    Write-Host ""
    Write-Centered "VERIFICANDO INTEGRIDAD MD5..." "Yellow"
    Write-Host ""

    $srcStats = Get-FolderStats $Origen
    $dstStats = Get-FolderStats $Destino
    Write-Host "    Archivos - Origen: $($srcStats.Files) | Destino: $($dstStats.Files)" -ForegroundColor Gray
    Write-Host "    Tamano   - Origen: $(Format-Size $srcStats.Size) | Destino: $(Format-Size $dstStats.Size)" -ForegroundColor Gray

    $countMatch = ($srcStats.Files -eq $dstStats.Files)
    Write-Host "    Conteo:  $(if ($countMatch) { 'COINCIDE' } else { 'DIFERENTE (puede ser normal)' })" -ForegroundColor $(if ($countMatch) { "Green" } else { "Yellow" })

    $srcFiles = Get-ChildItem -Path $Origen -Recurse -File -ErrorAction SilentlyContinue
    if (-not $srcFiles -or $srcFiles.Count -eq 0) {
        Write-Host "    Sin archivos." -ForegroundColor Gray
        return @{ OK = $true; Checked = 0; Passed = 0; Failed = 0; Missing = 0 }
    }

    Write-Host ""; Write-Host "    Hash MD5 (muestra de ${SampleSize})..." -ForegroundColor DarkGray

    $bySize = $srcFiles | Sort-Object Length -Descending | Select-Object -First 5
    $byDate = $srcFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 5
    $randomCount = [math]::Min([math]::Max(1, $SampleSize - 10), $srcFiles.Count)
    $random = $srcFiles | Get-Random -Count $randomCount
    $sample = @($bySize) + @($byDate) + @($random) | Sort-Object FullName -Unique | Select-Object -First $SampleSize

    $checked = 0; $passed = 0; $failed = 0; $missing = 0; $failedFiles = @()

    foreach ($sf in $sample) {
        $checked++
        $relPath = $sf.FullName.Substring($Origen.Length).TrimStart('\')
        $dstFile = Join-Path $Destino $relPath
        $pct = [math]::Round(($checked / $sample.Count) * 100, 0)
        Write-Host "`r    [${pct}%] ${checked}/$($sample.Count)..." -NoNewline -ForegroundColor DarkGray

        if (-not (Test-Path $dstFile)) { $missing++; $failedFiles += "FALTA: ${relPath}"; continue }
        try {
            $h1 = (Get-FileHash $sf.FullName -Algorithm MD5 -ErrorAction Stop).Hash
            $h2 = (Get-FileHash $dstFile -Algorithm MD5 -ErrorAction Stop).Hash
            if ($h1 -eq $h2) { $passed++ } else { $failed++; $failedFiles += "CORRUPTO: ${relPath}" }
        } catch { $failed++; $failedFiles += "ERROR: ${relPath}" }
    }

    Write-Host ""; Write-Host ""
    if ($failed -eq 0 -and $missing -eq 0) {
        Write-Host "    [OK] INTEGRIDAD: ${passed}/${checked} verificados" -ForegroundColor Green
    } else {
        Write-Host "    [!!] OK=${passed} | FALLOS=${failed} | FALTANTES=${missing}" -ForegroundColor Red
        foreach ($f in $failedFiles) { Write-Host "         $f" -ForegroundColor Red }
    }
    return @{ OK = ($failed -eq 0 -and $missing -eq 0); Checked = $checked; Passed = $passed; Failed = $failed; Missing = $missing }
}

# ==================== EJECUTAR FASTCOPY ====================

function Start-FastCopy {
    param(
        [string]$FastCopyExe, [string[]]$Origins, [string]$Destino,
        [string]$Mode, [string]$SpeedMode, [string]$DiskType,
        [array]$ExcludeFiles, [array]$ExcludeDirs
    )

    Write-Host ""
    Write-Centered "EJECUTANDO FASTCOPY (${DiskType} | ${Mode} | speed=${SpeedMode})" "Yellow"
    Write-Host ""

    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $allResults = @()
    $totalBytesCopied = 0
    $allOK = $true
    $logFile = Join-Path ([Environment]::GetFolderPath("Desktop")) "Log_FastCopy_$(Get-Date -Format 'yyyy-MM-dd_HHmm').log"

    foreach ($origen in $Origins) {
        $srcName = Split-Path $origen -Leaf
        Write-Host "    Copiando: ${srcName}..." -ForegroundColor Cyan
        
        $fcArgs = @()
        switch ($Mode) {
            "COMPLETA"    { $fcArgs += "/cmd=force_copy" }
            "INCREMENTAL" { $fcArgs += "/cmd=diff" }
            "MOVER"       { $fcArgs += "/cmd=move" }
            "SINCRONIZAR" { $fcArgs += "/cmd=sync" }
            default       { $fcArgs += "/cmd=force_copy" }
        }

        $fcArgs += "/speed=${SpeedMode}"
        $fcArgs += "/estimate"
        $fcArgs += "/auto_close"
        $fcArgs += "/error_stop=FALSE"
        $fcArgs += "/log"
        $fcArgs += "/logfile=`"${logFile}`""

        if (-not (Test-Path $Destino)) {
            New-Item -ItemType Directory -Path $Destino -Force | Out-Null
        }

        # Exclusiones
        if ($ExcludeFiles -and $ExcludeFiles.Count -gt 0) {
            $exclStr = ($ExcludeFiles -join ";")
            $fcArgs += "/exclude=`"${exclStr}`""
        }

        $fcArgs += "`"${origen}`""
        $fcArgs += "/to=`"${Destino}\`""

        $argString = $fcArgs -join " "

        $preSize = 0
        if (Test-Path $Destino) {
            try { $preSize = (Get-ChildItem $Destino -Recurse -File -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum } catch {}
            if (-not $preSize) { $preSize = 0 }
        }

        $process = Start-Process -FilePath $FastCopyExe -ArgumentList $argString -PassThru -Wait
        $exitCode = $process.ExitCode

        $postSize = 0
        if (Test-Path $Destino) {
            try { $postSize = (Get-ChildItem $Destino -Recurse -File -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum } catch {}
            if (-not $postSize) { $postSize = 0 }
        }
        $copied = [math]::Max(0, $postSize - $preSize)
        $totalBytesCopied += $copied

        if ($exitCode -ne 0) { $allOK = $false }

        $statusIcon = if ($exitCode -eq 0) { "[OK]" } else { "[!!]" }
        $statusColor = if ($exitCode -eq 0) { "Green" } else { "Red" }
        Write-Host "    ${statusIcon} ${srcName} - $(Format-Size $copied)" -ForegroundColor $statusColor
    }

    $sw.Stop(); $elapsed = $sw.Elapsed
    $speedMBps = if ($elapsed.TotalSeconds -gt 0) { [math]::Round(($totalBytesCopied / 1MB) / $elapsed.TotalSeconds, 1) } else { 0 }

    Write-Host ""
    Write-Host "    ========================================================" -ForegroundColor White
    $resultColor = if ($allOK) { "Green" } else { "Red" }
    $resultMsg = if ($allOK) { "COMPLETADO EXITOSAMENTE" } else { "COMPLETADO CON ERRORES - revisa el log" }
    Write-Host "    RESULTADO: ${resultMsg}" -ForegroundColor $resultColor
    Write-Host "    ========================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "    Origenes:  $($Origins.Count)" -ForegroundColor Gray
    Write-Host "    Tiempo:    $(Format-Duration $elapsed)" -ForegroundColor Gray
    Write-Host "    Copiado:   $(Format-Size $totalBytesCopied)" -ForegroundColor Gray
    Write-Host "    Velocidad: ${speedMBps} MB/s" -ForegroundColor Gray
    Write-Host "    Log:       $(Split-Path $logFile -Leaf)" -ForegroundColor DarkGray

    return @{
        ExitCode = $(if ($allOK) { 0 } else { 1 }); OK = $allOK; Elapsed = $elapsed
        BytesCopied = $totalBytesCopied; SpeedMBps = $speedMBps; LogFile = $logFile
    }
}

# ==================== INICIO ====================

Clear-Host

$fastCopyExe = Find-FastCopy

if (-not $fastCopyExe) {
    Write-Host ""
    Write-Centered "============================================" "Red"
    Write-Centered "FASTCOPY NO ENCONTRADO" "Red"
    Write-Centered "============================================" "Red"
    Write-Host ""
    Write-Host "    Buscado en:" -ForegroundColor DarkGray
    Write-Host "    - Carpeta del script ($PSScriptRoot)" -ForegroundColor DarkGray
    Write-Host "    - Program Files" -ForegroundColor DarkGray
    Write-Host "    - PATH del sistema" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    SOLUCION:" -ForegroundColor Yellow
    Write-Host "    1. Descarga FastCopy de: https://fastcopy.jp" -ForegroundColor White
    Write-Host "    2. Coloca FastCopy.exe junto a este script" -ForegroundColor White
    Write-Host ""
    Read-Host "    ENTER para salir"
    exit 1
}

# ==================== BUCLE PRINCIPAL ====================

do {
    Clear-Host
    Write-Host "`n"
    Write-Centered "==========================================================" "Cyan"
    Write-Centered "|       ATLAS PC SUPPORT - FASTCOPY EDITION v3           |" "Yellow"
    Write-Centered "==========================================================" "Cyan"
    Write-Host ""
    Write-Host "    Motor: $(Split-Path $fastCopyExe -Leaf)" -ForegroundColor DarkGray
    Write-Host ""
    Write-Centered "[ 1 ] Copia normal (un origen)" "White"
    Write-Centered "[ 2 ] Multi-origen (varias carpetas)" "White"
    Write-Centered "[ 3 ] Perfil rapido (respaldo de usuario)" "Cyan"
    Write-Centered "[ S ] Salir" "DarkGray"
    Write-Host ""
    
    $menuSel = Read-Host "      >"
    if ($menuSel -eq "S" -or $menuSel -eq "s") { exit }

    # =============================================
    # OBTENER ORIGENES
    # =============================================
    $origenes = @()
    $isMulti = $false
    $isProfile = $false
    $profileName = ""

    switch ($menuSel) {
        "1" {
            # Un solo origen
            :askSingle while ($true) {
                Write-Host ""
                Write-Host "  [1] ORIGEN:" -ForegroundColor White
                $pathResult = Get-PathFromUser -Prompt "ORIGEN" -Mode "any"
                if ($pathResult -eq "EXIT") { exit }
                if ($pathResult -eq "BACK") { break }
                if (-not (Test-Path $pathResult)) {
                    Write-Host "      [ERROR] No existe: ${pathResult}" -ForegroundColor Red
                    continue
                }
                $origenes = @($pathResult)
                break
            }
        }
        "2" {
            $multiResult = Get-MultipleOrigins
            if ($multiResult -eq "EXIT") { exit }
            if ($multiResult -eq "BACK") { continue }
            $origenes = @($multiResult)
            $isMulti = $true
        }
        "3" {
            $profile = Show-ProfileMenu
            if (-not $profile) { continue }
            $origenes = @($profile.Paths)
            $isProfile = $true
            $profileName = $profile.Name
        }
        default { continue }
    }

    if ($origenes.Count -eq 0) { continue }

    # Mostrar origenes seleccionados
    Write-Host ""
    $totalSize = 0; $totalFiles = 0
    foreach ($o in $origenes) {
        $oName = Split-Path $o -Leaf
        if (Test-Path $o -PathType Container) {
            $stats = Get-FolderStats $o
            $totalSize += $stats.Size; $totalFiles += $stats.Files
            Write-Host "      [OK] ${oName} ($($stats.Files) archivos, $(Format-Size $stats.Size))" -ForegroundColor Green
        } else {
            $fi = Get-Item $o
            $totalSize += $fi.Length; $totalFiles++
            Write-Host "      [OK] ${oName} ($(Format-Size $fi.Length))" -ForegroundColor Green
        }
    }
    $srcStats = @{ Files = $totalFiles; Size = $totalSize; SizeMB = [math]::Round($totalSize / 1MB, 1) }
    Write-Host ""
    Write-Host "      TOTAL: ${totalFiles} archivos | $(Format-Size $totalSize)" -ForegroundColor White

    # =============================================
    # DESTINO
    # =============================================
    $destino = $null; $driveInfo = $null

    :askDest while ($true) {
        Write-Host ""
        Write-Host "  [2] DESTINO:" -ForegroundColor White
        $pathResult = Get-PathFromUser -Prompt "DESTINO" -Mode "folder"
        if ($pathResult -eq "EXIT") { exit }
        if ($pathResult -eq "BACK") { break }
        if (-not (Test-Path $pathResult)) {
            Write-Host "      [ERROR] No accesible: ${pathResult}" -ForegroundColor Red
            continue
        }

        # Validar que ningun origen sea el destino
        $conflict = $false
        foreach ($o in $origenes) {
            try {
                $fO = (Resolve-Path $o).Path; $fD = (Resolve-Path $pathResult).Path
                if ($fO -eq $fD) { Write-Host "      [ERROR] Origen = Destino: $o" -ForegroundColor Red; $conflict = $true; break }
            } catch {}
        }
        if ($conflict) { continue }

        $destDriveLetter = $pathResult.Substring(0, 1)
        $driveInfo = Detect-DriveType $destDriveLetter
        $labelDisplay = if ($driveInfo.Label) { " ($($driveInfo.Label))" } else { "" }
        Write-Host "      [OK] Disco: $($driveInfo.Desc)${labelDisplay}" -ForegroundColor $driveInfo.Color
        Write-Host "      Libre: $(Format-Size $driveInfo.FreeBytes)" -ForegroundColor Gray

        if ($driveInfo.FreeBytes -gt 0 -and $totalSize -gt $driveInfo.FreeBytes) {
            Write-Host "      [!!!] ESPACIO INSUFICIENTE" -ForegroundColor Red
            Write-Host "      Necesitas: $(Format-Size $totalSize) | Disponible: $(Format-Size $driveInfo.FreeBytes)" -ForegroundColor Red
            Write-Host "      [F] Forzar  [B] Volver" -ForegroundColor Yellow
            $espOp = Read-Host "      >"
            if ($espOp -ne "F" -and $espOp -ne "f") { continue }
        }
        $destino = $pathResult; break
    }
    if (-not $destino) { continue }

    # =============================================
    # NOMBRE
    # =============================================
    Write-Host ""
    Write-Host "  [3] Nombre del proyecto (ENTER = Respaldo):" -ForegroundColor White
    $cliente = Read-Host "      NOMBRE"
    if ([string]::IsNullOrWhiteSpace($cliente)) {
        if ($isProfile) { $cliente = $profileName -replace '\s+', '_' }
        else { $cliente = "Respaldo" }
    }
    $cliente = $cliente -replace '[\\/:*?"<>|]', '_'
    $fechaHoy = Get-Date -Format 'yyyy-MM-dd'
    $rutaFinal = Join-Path $destino "${cliente}_${fechaHoy}"

    # =============================================
    # MODO
    # =============================================
    Write-Host ""
    Write-Host "  [4] MODO DE COPIA:" -ForegroundColor Cyan
    Write-Host "      [1] COMPLETA     - Copia todo" -ForegroundColor White
    Write-Host "      [2] INCREMENTAL  - Solo nuevos/modificados" -ForegroundColor White
    Write-Host "      [3] SINCRONIZAR  - Espejo exacto" -ForegroundColor White
    Write-Host "      [4] MOVER        - Mueve (borra origen)" -ForegroundColor Red
    Write-Host "      [B] Volver" -ForegroundColor DarkGray
    Write-Host ""
    $modoSel = Read-Host "      >"
    if ($modoSel -eq "B" -or $modoSel -eq "b") { continue }
    $modo = switch ($modoSel) {
        "2" { "INCREMENTAL" }
        "3" { "SINCRONIZAR" }
        "4" {
            Write-Host "      [!!!] Eliminara archivos del ORIGEN. Seguro? [S/N]" -ForegroundColor Red
            $mc = Read-Host "      >"
            if ($mc -eq "S" -or $mc -eq "s") { "MOVER" } else { "SKIP" }
        }
        default { "COMPLETA" }
    }
    if ($modo -eq "SKIP") { continue }

    # =============================================
    # EXCLUSIONES
    # =============================================
    $exclusions = @{ Files = @(); Dirs = @(); Label = "Ninguna" }
    if ($origenes.Count -ge 1) {
        $exclResult = Get-Exclusions
        if ($exclResult -eq "BACK") { continue }
        if ($exclResult) { $exclusions = $exclResult }
    }

    # =============================================
    # COMPARAR (solo incremental o si hay destino previo)
    # =============================================
    $comparison = $null
    if (Test-Path $rutaFinal) {
        Write-Host ""
        Write-Host "      Destino ya existe. Analizar diferencias? [S/N]" -ForegroundColor Yellow
        $compSel = Read-Host "      >"
        if ($compSel -eq "S" -or $compSel -eq "s") {
            $comparison = Compare-BeforeCopy -Origins $origenes -Destino $rutaFinal
        }
    }

    # =============================================
    # PREVIEW
    # =============================================
    Clear-Host
    Write-Host "`n"
    Write-Centered "==================== PREVIEW ====================" "White"
    Write-Host ""
    
    if ($isProfile) {
        Write-Host "    PERFIL:    ${profileName}" -ForegroundColor Cyan
    }
    Write-Host "    ORIGENES:  $($origenes.Count)" -ForegroundColor Gray
    foreach ($o in $origenes) {
        Write-Host "               $(Split-Path $o -Leaf)" -ForegroundColor White
    }
    Write-Host "    TOTAL:     ${totalFiles} archivos | $(Format-Size $totalSize)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "    DESTINO:   ${rutaFinal}" -ForegroundColor White
    Write-Host "    DISCO:     $($driveInfo.Desc)" -ForegroundColor $driveInfo.Color
    Write-Host "    MODO:      ${modo}" -ForegroundColor $(if ($modo -eq "MOVER") { "Red" } elseif ($modo -eq "SINCRONIZAR") { "Yellow" } else { "Cyan" })
    Write-Host "    SPEED:     $($driveInfo.Speed) (auto)" -ForegroundColor Gray
    Write-Host "    EXCLUIR:   $($exclusions.Label)" -ForegroundColor DarkGray

    if ($comparison) {
        Write-Host ""
        Write-Host "    ANALISIS:  $($comparison.New) nuevos, $($comparison.Modified) modificados, $($comparison.Equal) iguales" -ForegroundColor Cyan
        Write-Host "    TRANSFERIR: $(Format-Size $comparison.SizeTotal)" -ForegroundColor Cyan
    }

    $avgSpeed = switch ($driveInfo.Type) { "USB" { 30 } "HDD" { 100 } "SSD" { 400 } default { 50 } }
    $estSize = if ($comparison) { $comparison.SizeTotal } else { $totalSize }
    if ($estSize -gt 0) {
        $etaSec = ($estSize / 1MB) / $avgSpeed
        $etaSpan = [TimeSpan]::FromSeconds($etaSec)
        Write-Host "    ETA:       ~$(Format-Duration $etaSpan)" -ForegroundColor DarkGray
    }

    if ($modo -eq "MOVER") { Write-Host ""; Write-Host "    [!!!] ARCHIVOS SE ELIMINARAN DEL ORIGEN" -ForegroundColor Red }
    if ($modo -eq "SINCRONIZAR") { Write-Host ""; Write-Host "    [!] Extras en destino seran ELIMINADOS" -ForegroundColor Yellow }

    Write-Host ""
    Write-Centered "=================================================" "White"
    Write-Host ""
    Write-Host "    [S] INICIAR  [B] Volver  [N] Cancelar" -ForegroundColor White
    Write-Host ""
    $confirmar = Read-Host "    >"
    if ($confirmar -ne "S" -and $confirmar -ne "s") { continue }

    # =============================================
    # EJECUTAR
    # =============================================
    Clear-Host
    Write-Host "`n"

    $result = Start-FastCopy -FastCopyExe $fastCopyExe -Origins $origenes -Destino $rutaFinal `
        -Mode $modo -SpeedMode $driveInfo.Speed -DiskType $driveInfo.Type `
        -ExcludeFiles $exclusions.Files -ExcludeDirs $exclusions.Dirs

    # NOTIFICACION
    $notifMsg = "$(Format-Size $result.BytesCopied) en $(Format-Duration $result.Elapsed) a $($result.SpeedMBps) MB/s"
    if ($result.OK) {
        Send-Notification -Title "Atlas - Copia Completada" -Message $notifMsg -Success $true
    } else {
        Send-Notification -Title "Atlas - Copia con Errores" -Message "Revisa el log" -Success $false
    }

    # =============================================
    # VERIFICACION MD5
    # =============================================
    $integrity = $null
    if ($result.OK -and $modo -ne "MOVER") {
        Write-Host ""
        Write-Host "    Verificar integridad MD5? [S/N]" -ForegroundColor DarkGray
        $verSel = Read-Host "    >"
        if ($verSel -eq "S" -or $verSel -eq "s") {
            # Verificar el primer origen (el más importante)
            $integrity = Test-CopyIntegrity -Origen $origenes[0] -Destino $rutaFinal
        }
    }

    # =============================================
    # POST-COPIA
    # =============================================
    :postMenu while ($true) {
        Write-Host ""
        Write-Host "    --------------------------------------------------------" -ForegroundColor DarkGray
        Write-Host "    [A] Abrir carpeta destino" -ForegroundColor Cyan
        Write-Host "    [R] REPETIR con otro destino" -ForegroundColor Green
        Write-Host "    [X] Exportar resumen para ticket" -ForegroundColor Yellow
        Write-Host "    [N] Nueva copia" -ForegroundColor White
        Write-Host "    [L] Ver log" -ForegroundColor DarkGray
        Write-Host "    [S] Salir" -ForegroundColor DarkGray
        Write-Host "    --------------------------------------------------------" -ForegroundColor DarkGray
        Write-Host ""
        $postOp = Read-Host "    >"

        switch ($postOp.ToUpper()) {
            "A" {
                if (Test-Path $rutaFinal) { Invoke-Item $rutaFinal }
                else { Write-Host "    No encontrada." -ForegroundColor Red }
            }
            "R" {
                Write-Host ""
                $newPath = Get-PathFromUser -Prompt "DESTINO" -Mode "folder"
                if ($newPath -eq "BACK" -or $newPath -eq "EXIT" -or -not $newPath) { continue }
                if (-not (Test-Path $newPath)) { Write-Host "    No accesible." -ForegroundColor Red; continue }

                $newDriveInfo = Detect-DriveType ($newPath.Substring(0, 1))
                $newRutaFinal = Join-Path $newPath "${cliente}_${fechaHoy}"
                $newLabel = if ($newDriveInfo.Label) { " ($($newDriveInfo.Label))" } else { "" }
                Write-Host "    Disco: $($newDriveInfo.Desc)${newLabel}" -ForegroundColor $newDriveInfo.Color
                Write-Host "    Destino: ${newRutaFinal}" -ForegroundColor White
                Write-Host "    [S] Copiar  [N] Cancelar" -ForegroundColor White
                $rc = Read-Host "    >"

                if ($rc -eq "S" -or $rc -eq "s") {
                    Clear-Host; Write-Host "`n"
                    $r2 = Start-FastCopy -FastCopyExe $fastCopyExe -Origins $origenes -Destino $newRutaFinal `
                        -Mode $modo -SpeedMode $newDriveInfo.Speed -DiskType $newDriveInfo.Type `
                        -ExcludeFiles $exclusions.Files -ExcludeDirs $exclusions.Dirs
                    
                    $n2Msg = "$(Format-Size $r2.BytesCopied) en $(Format-Duration $r2.Elapsed)"
                    Send-Notification -Title "Atlas - Copia $(if ($r2.OK) {'OK'} else {'Error'})" -Message $n2Msg -Success $r2.OK

                    if ($r2.OK -and $modo -ne "MOVER") {
                        Write-Host "    Verificar MD5? [S/N]" -ForegroundColor DarkGray
                        $v2 = Read-Host "    >"
                        if ($v2 -eq "S" -or $v2 -eq "s") { Test-CopyIntegrity -Origen $origenes[0] -Destino $newRutaFinal | Out-Null }
                    }
                }
            }
            "X" {
                $reportFile = Export-CopyReport -Origins $origenes -Destino $rutaFinal -Mode $modo `
                    -DiskType $driveInfo.Type -Result $result -Integrity $integrity `
                    -Comparison $comparison -ExclusionLabel $exclusions.Label -Cliente $cliente
                Write-Host "    [OK] Resumen: $(Split-Path $reportFile -Leaf)" -ForegroundColor Green
                Write-Host "    Listo para adjuntar al ticket." -ForegroundColor Cyan
                
                Write-Host "    Abrir? [S/N]" -ForegroundColor DarkGray
                $openReport = Read-Host "    >"
                if ($openReport -eq "S" -or $openReport -eq "s") { Start-Process notepad $reportFile }
            }
            "N" { break }
            "L" {
                if ($result.LogFile -and (Test-Path $result.LogFile)) { Start-Process notepad $result.LogFile }
                else { Write-Host "    Log no encontrado." -ForegroundColor Red }
            }
            "S" { exit }
        }
        if ($postOp -eq "N" -or $postOp -eq "n") { break }
    }

} while ($true)
}


# ---- tools\Invoke-GestorBitLocker.ps1 ----
# ============================================================
# Invoke-GestorBitLocker
# Migrado de: GestorBitLocker.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-GestorBitLocker {
    [CmdletBinding()]
    param(
        [ValidateSet("Extract","Status","")]
        [string]$Action = "",
        [string]$Output = "",
        [string]$MountPoint = ""
    )
# =======================================================
# Gestor de BitLocker v3 - Atlas PC Support
# TPM + Progreso + Backup USB + QR + Health Check + Log
# AD/Azure backup + CLI mode + Alerta discos sin proteger
# =======================================================

# (auto-elevación gestionada por Atlas Launcher)


[console]::BackgroundColor = "Black"
[console]::ForegroundColor = "Gray"
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - Gestor BitLocker v3"
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(105, 48) } catch {}

# Log file
$logFile = Join-Path $PSScriptRoot "ATLAS_bitlocker.log"

# ==================== FUNCIONES BASE ====================

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $user = "$env:USERDOMAIN\$env:USERNAME"
    $pc = $env:COMPUTERNAME
    $entry = "${timestamp} | ${Level} | ${pc} | ${user} | ${Message}"
    try { $entry | Out-File -FilePath $script:logFile -Append -Encoding UTF8 } catch {}
}

function Escribir-Centrado {
    param([string]$Texto, [ConsoleColor]$Color = "Gray")
    $AnchoVentana = $Host.UI.RawUI.WindowSize.Width
    if ($Texto.Length -lt $AnchoVentana) {
        $Espacios = [Math]::Floor(($AnchoVentana - $Texto.Length) / 2)
        Write-Host (" " * $Espacios + $Texto) -ForegroundColor $Color
    } else {
        Write-Host $Texto -ForegroundColor $Color
    }
}

function Show-DiskTable {
    param([switch]$OnlyEncrypted, [switch]$Silent)
    
    $volumes = Get-BitLockerVolume -ErrorAction SilentlyContinue
    if (-not $volumes) {
        if (-not $Silent) { Write-Host "    No se pudo acceder a BitLocker." -ForegroundColor Red }
        return $null
    }
    
    if ($OnlyEncrypted) {
        $volumes = $volumes | Where-Object { $_.VolumeStatus -ne 'FullyDecrypted' }
        if (-not $volumes) {
            if (-not $Silent) { Write-Host "    No hay discos con BitLocker activo." -ForegroundColor Yellow }
            return $null
        }
    }
    
    if (-not $Silent) {
        Write-Host ""
        Write-Host "    DISCO   ESTADO                  ENCRIPTADO   TAMANO    METODO" -ForegroundColor DarkGray
        Write-Host "    -----   ------                  ----------   ------    ------" -ForegroundColor DarkGray
        
        foreach ($v in $volumes) {
            $mount = $v.MountPoint
            $status = $v.VolumeStatus.ToString()
            $pct = "$($v.EncryptionPercentage)%"
            $capGB = if ($v.CapacityGB) { "{0:N1} GB" -f $v.CapacityGB } else { "N/A" }
            $method = if ($v.EncryptionMethod) { $v.EncryptionMethod.ToString() } else { "-" }
            
            $statusColor = switch ($status) {
                "FullyEncrypted" { "Green" }
                "FullyDecrypted" { "Gray" }
                "EncryptionInProgress" { "Yellow" }
                "DecryptionInProgress" { "Yellow" }
                default { "White" }
            }
            $statusLabel = switch ($status) {
                "FullyEncrypted" { "ENCRIPTADO" }
                "FullyDecrypted" { "LIBRE" }
                "EncryptionInProgress" { "ENCRIPTANDO..." }
                "DecryptionInProgress" { "DESENCRIPTANDO..." }
                default { $status }
            }
            $icon = switch ($status) {
                "FullyEncrypted" { "[X]" }
                "FullyDecrypted" { "[ ]" }
                "EncryptionInProgress" { "[~]" }
                "DecryptionInProgress" { "[~]" }
                default { "[?]" }
            }
            
            Write-Host "    ${icon} ${mount}" -NoNewline -ForegroundColor $statusColor
            Write-Host ("   " + $statusLabel.PadRight(24)) -NoNewline -ForegroundColor $statusColor
            Write-Host ($pct.PadRight(13)) -NoNewline -ForegroundColor White
            Write-Host ($capGB.PadRight(10)) -NoNewline -ForegroundColor Gray
            Write-Host $method -ForegroundColor DarkGray
        }
        Write-Host ""
    }
    return $volumes
}

function Validate-DriveLetter {
    param([string]$Input, [array]$ValidVolumes)
    if ([string]::IsNullOrWhiteSpace($Input)) { return $null }
    $clean = $Input.Trim().ToUpper().Replace(":", "")
    if ($clean.Length -ne 1 -or $clean -notmatch "^[A-Z]$") {
        Write-Host "    Letra invalida. Usa una sola letra (ej: C, D, E)." -ForegroundColor Red
        return $null
    }
    $disco = "${clean}:"
    $found = $ValidVolumes | Where-Object { $_.MountPoint -eq $disco }
    if (-not $found) {
        Write-Host "    El disco ${disco} no existe." -ForegroundColor Red
        return $null
    }
    return @{ Letter = $disco; Volume = $found }
}

function Get-TPMStatus {
    $result = @{ HasTPM = $false; IsReady = $false; Version = "N/A"; Summary = "" }
    try {
        $tpm = Get-Tpm -ErrorAction Stop
        $result.HasTPM = $tpm.TpmPresent
        $result.IsReady = $tpm.TpmReady
        try {
            $tpmWMI = Get-CimInstance -Namespace "root\cimv2\Security\MicrosoftTpm" -ClassName Win32_Tpm -ErrorAction Stop
            if ($tpmWMI.SpecVersion) { $result.Version = ($tpmWMI.SpecVersion -split ',')[0].Trim() }
        } catch { }
        if ($result.HasTPM -and $result.IsReady) { $result.Summary = "TPM $($result.Version) presente y listo" }
        elseif ($result.HasTPM) { $result.Summary = "TPM presente pero NO listo" }
        else { $result.Summary = "Sin TPM detectado" }
    } catch { $result.Summary = "No se pudo consultar TPM" }
    return $result
}

function Show-EncryptionProgress {
    param([string]$MountPoint, [string]$Mode = "Encrypting")
    $label = if ($Mode -eq "Encrypting") { "ENCRIPTANDO" } else { "DESENCRIPTANDO" }
    $color = if ($Mode -eq "Encrypting") { "Cyan" } else { "Magenta" }
    Write-Host ""
    Escribir-Centrado "Monitoreando (CTRL+C para dejar en segundo plano)..." "DarkGray"
    Write-Host ""
    $lastPct = -1
    try {
        while ($true) {
            $vol = Get-BitLockerVolume -MountPoint $MountPoint -ErrorAction SilentlyContinue
            if (-not $vol) { break }
            $pct = $vol.EncryptionPercentage; $status = $vol.VolumeStatus.ToString()
            if ($pct -ne $lastPct) {
                $barWidth = 40; $filled = [math]::Floor($pct / 100 * $barWidth); $empty = $barWidth - $filled
                $bar = ("#" * $filled) + ("-" * $empty)
                Write-Host "`r    ${label} ${MountPoint}: [${bar}] ${pct}%   " -NoNewline -ForegroundColor $color
                $lastPct = $pct
            }
            if ($status -eq "FullyEncrypted" -or $status -eq "FullyDecrypted") {
                Write-Host ""; Write-Host ""
                $doneMsg = if ($Mode -eq "Encrypting") { "Encriptacion completada." } else { "Desencriptacion completada." }
                Escribir-Centrado $doneMsg "Green"
                Write-Log "${doneMsg} Disco: ${MountPoint}"
                break
            }
            Start-Sleep -Seconds 3
        }
    } catch { Write-Host ""; Write-Host ""; Escribir-Centrado "Monitoreo detenido. Continua en segundo plano." "Yellow" }
}

# ==================== HEALTH CHECK PRE-ENCRIPTACION ====================

function Test-PreEncryptionHealth {
    param([string]$MountPoint)
    
    $issues = @(); $warnings = @(); $canProceed = $true
    $driveLetter = $MountPoint.TrimEnd(':')
    
    Write-Host ""
    Escribir-Centrado "HEALTH CHECK PRE-ENCRIPTACION" "Yellow"
    Write-Host ""
    
    # 1. BATERIA (critico en laptops)
    Write-Host "    [1/5] Bateria..." -NoNewline -ForegroundColor DarkGray
    $battery = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue
    if ($battery) {
        $charge = $battery.EstimatedChargeRemaining
        $plugged = $battery.BatteryStatus -eq 2
        if ($charge -lt 30 -and -not $plugged) {
            $issues += "BATERIA CRITICA: ${charge}% sin cargador. Conecta el cargador antes de encriptar."
            $canProceed = $false
            Write-Host " FALLO (${charge}%)" -ForegroundColor Red
        } elseif ($charge -lt 50 -and -not $plugged) {
            $warnings += "Bateria al ${charge}%. Se recomienda conectar el cargador."
            Write-Host " AVISO (${charge}%)" -ForegroundColor Yellow
        } elseif ($plugged) {
            Write-Host " OK (${charge}%, cargador conectado)" -ForegroundColor Green
        } else {
            Write-Host " OK (${charge}%)" -ForegroundColor Green
        }
    } else {
        Write-Host " N/A (escritorio)" -ForegroundColor Gray
    }
    
    # 2. ESPACIO EN DISCO
    Write-Host "    [2/5] Espacio en disco..." -NoNewline -ForegroundColor DarkGray
    $logDisk = Get-CimInstance Win32_LogicalDisk -ErrorAction SilentlyContinue | Where-Object { $_.DeviceID -eq $MountPoint }
    if ($logDisk) {
        $freeGB = [math]::Round($logDisk.FreeSpace / 1GB, 1)
        $totalGB = [math]::Round($logDisk.Size / 1GB, 1)
        $usedPct = [math]::Round((($logDisk.Size - $logDisk.FreeSpace) / $logDisk.Size) * 100, 0)
        if ($freeGB -lt 1) {
            $issues += "DISCO CASI LLENO: Solo ${freeGB}GB libre. BitLocker necesita espacio para metadatos."
            $canProceed = $false
            Write-Host " FALLO (${freeGB}GB libre)" -ForegroundColor Red
        } elseif ($usedPct -gt 95) {
            $warnings += "Disco al ${usedPct}% de capacidad. Recomendado liberar espacio."
            Write-Host " AVISO (${usedPct}%)" -ForegroundColor Yellow
        } else {
            Write-Host " OK (${freeGB}GB libre de ${totalGB}GB)" -ForegroundColor Green
        }
    } else {
        Write-Host " N/A" -ForegroundColor Gray
    }
    
    # 3. ESTADO SMART DEL DISCO
    Write-Host "    [3/5] Salud del disco (SMART)..." -NoNewline -ForegroundColor DarkGray
    try {
        $partition = Get-Partition -DriveLetter $driveLetter -ErrorAction Stop
        $physDisk = Get-PhysicalDisk -ErrorAction SilentlyContinue | Where-Object { $_.DeviceId -eq $partition.DiskNumber.ToString() }
        if (-not $physDisk) {
            $physDisk = Get-PhysicalDisk -ErrorAction SilentlyContinue | Select-Object -First 1
        }
        if ($physDisk) {
            $health = $physDisk.HealthStatus.ToString()
            if ($health -ne "Healthy") {
                $issues += "DISCO CON PROBLEMAS: Estado SMART = ${health}. Encriptar un disco danado puede causar perdida total."
                $canProceed = $false
                Write-Host " FALLO (${health})" -ForegroundColor Red
            } else {
                $opStatus = if ($physDisk.OperationalStatus) { $physDisk.OperationalStatus.ToString() } else { "OK" }
                Write-Host " OK (${health}, ${opStatus})" -ForegroundColor Green
            }
        } else {
            Write-Host " No verificable" -ForegroundColor Yellow
        }
    } catch {
        Write-Host " No verificable" -ForegroundColor Yellow
    }
    
    # 4. SISTEMA DE ARCHIVOS
    Write-Host "    [4/5] Sistema de archivos..." -NoNewline -ForegroundColor DarkGray
    try {
        $vol = Get-Volume -DriveLetter $driveLetter -ErrorAction Stop
        $fs = if ($vol.FileSystem) { $vol.FileSystem } else { "Desconocido" }
        if ($fs -ne "NTFS" -and $fs -ne "ReFS") {
            $issues += "SISTEMA DE ARCHIVOS INCOMPATIBLE: ${fs}. BitLocker requiere NTFS o ReFS."
            $canProceed = $false
            Write-Host " FALLO (${fs})" -ForegroundColor Red
        } else {
            Write-Host " OK (${fs})" -ForegroundColor Green
        }
    } catch {
        Write-Host " No verificable" -ForegroundColor Yellow
    }
    
    # 5. PROCESOS CRITICOS
    Write-Host "    [5/5] Procesos criticos..." -NoNewline -ForegroundColor DarkGray
    $chkdsk = Get-Process -Name "chkdsk" -ErrorAction SilentlyContinue
    $defrag = Get-Process -Name "defrag" -ErrorAction SilentlyContinue
    if ($chkdsk -or $defrag) {
        $procName = if ($chkdsk) { "chkdsk" } else { "defrag" }
        $warnings += "${procName} en ejecucion. Espera a que termine antes de encriptar."
        Write-Host " AVISO (${procName} activo)" -ForegroundColor Yellow
    } else {
        Write-Host " OK" -ForegroundColor Green
    }
    
    # RESUMEN
    Write-Host ""
    if ($issues.Count -gt 0) {
        Escribir-Centrado "PROBLEMAS CRITICOS (no se recomienda continuar):" "Red"
        foreach ($issue in $issues) { Write-Host "    [X] ${issue}" -ForegroundColor Red }
    }
    if ($warnings.Count -gt 0) {
        Write-Host ""
        Escribir-Centrado "AVISOS:" "Yellow"
        foreach ($warn in $warnings) { Write-Host "    [!] ${warn}" -ForegroundColor Yellow }
    }
    if ($issues.Count -eq 0 -and $warnings.Count -eq 0) {
        Escribir-Centrado "TODOS LOS CHEQUEOS PASARON" "Green"
    }
    
    Write-Log "HealthCheck ${MountPoint}: Issues=${issues.Count}, Warnings=${warnings.Count}, CanProceed=${canProceed}"
    
    return @{ CanProceed = $canProceed; Issues = $issues; Warnings = $warnings }
}

# ==================== ALERTA DISCOS SIN PROTEGER ====================

function Show-UnprotectedAlert {
    $allVols = Get-BitLockerVolume -ErrorAction SilentlyContinue
    if (-not $allVols) { return }
    
    $unprotected = @()
    foreach ($v in $allVols) {
        # Solo alertar discos del sistema y datos (no removibles)
        $driveLetter = $v.MountPoint.TrimEnd(':')
        try {
            $volInfo = Get-Volume -DriveLetter $driveLetter -ErrorAction SilentlyContinue
            if ($volInfo -and $volInfo.DriveType -eq 'Fixed' -and $v.VolumeStatus -eq 'FullyDecrypted') {
                $capGB = if ($v.CapacityGB) { "{0:N0}" -f $v.CapacityGB } else { "?" }
                $unprotected += "${driveLetter}: (${capGB}GB)"
            }
        } catch { }
    }
    
    if ($unprotected.Count -gt 0) {
        Write-Host ""
        $alertLine = "ALERTA: $($unprotected.Count) disco(s) fijo(s) SIN PROTECCION: $($unprotected -join ', ')"
        Escribir-Centrado $alertLine "Red"
    }
}

# ==================== GENERAR QR ====================

function Generate-QRCode {
    param([string]$Data, [string]$OutputPath, [string]$Label = "")
    
    # Generar QR como HTML con tabla (funciona sin dependencias externas)
    # Usa una representación simple que se puede imprimir
    
    $qrSize = 21  # QR Version 1
    
    # Método alternativo: generar imagen BMP usando .NET
    try {
        Add-Type -AssemblyName System.Drawing -ErrorAction Stop
        
        $cellSize = 10
        $margin = 40
        $textHeight = if ($Label) { 60 } else { 0 }
        
        # Generar patrón QR simplificado (encode como texto legible en imagen)
        $lines = @()
        $lines += "ATLAS PC SUPPORT"
        $lines += "BITLOCKER RECOVERY KEY"
        $lines += ""
        if ($Label) { $lines += $Label; $lines += "" }
        
        # Dividir la clave en grupos legibles
        $lines += "CLAVE:"
        if ($Data.Length -gt 20) {
            $chunks = [regex]::Matches($Data, '.{1,12}') | ForEach-Object { $_.Value }
            foreach ($chunk in $chunks) { $lines += "  $chunk" }
        } else {
            $lines += "  $Data"
        }
        $lines += ""
        $lines += "Fecha: $(Get-Date -Format 'dd/MM/yyyy')"
        $lines += "PC: $env:COMPUTERNAME"
        
        # Crear imagen
        $imgWidth = 500
        $lineHeight = 22
        $imgHeight = ($lines.Count * $lineHeight) + 80
        
        $bmp = New-Object System.Drawing.Bitmap($imgWidth, $imgHeight)
        $gfx = [System.Drawing.Graphics]::FromImage($bmp)
        $gfx.Clear([System.Drawing.Color]::White)
        
        # Borde
        $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::Black, 2)
        $gfx.DrawRectangle($pen, 5, 5, $imgWidth - 10, $imgHeight - 10)
        
        # Texto
        $fontTitle = New-Object System.Drawing.Font("Consolas", 14, [System.Drawing.FontStyle]::Bold)
        $fontNormal = New-Object System.Drawing.Font("Consolas", 12)
        $fontKey = New-Object System.Drawing.Font("Consolas", 13, [System.Drawing.FontStyle]::Bold)
        $brush = [System.Drawing.Brushes]::Black
        $brushRed = [System.Drawing.Brushes]::DarkRed
        
        $y = 20
        foreach ($line in $lines) {
            $font = $fontNormal
            $b = $brush
            if ($line -match "^ATLAS|^BITLOCKER") { $font = $fontTitle }
            if ($line -match "^\s{2}\d" -or $line -match "^\s{2}[A-F0-9]") { $font = $fontKey; $b = $brushRed }
            $gfx.DrawString($line, $font, $b, 20, $y)
            $y += $lineHeight
        }
        
        $gfx.Dispose()
        $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $bmp.Dispose()
        
        return $true
    } catch {
        # Fallback: guardar como texto formateado para imprimir
        $txtPath = $OutputPath -replace '\.png$', '.txt'
        $border = "+" + ("-" * 48) + "+"
        $content = @()
        $content += $border
        $content += "|  ATLAS PC SUPPORT - BITLOCKER RECOVERY KEY    |"
        $content += $border
        if ($Label) { $content += "|  ${Label}".PadRight(49) + "|" }
        $content += "|  CLAVE:".PadRight(49) + "|"
        $content += "|  ${Data}".PadRight(49) + "|"
        $content += "|  PC: $env:COMPUTERNAME | $(Get-Date -Format 'dd/MM/yyyy')".PadRight(49) + "|"
        $content += $border
        $content += "  Recortar y pegar en la carcasa del equipo."
        
        $content -join "`r`n" | Out-File -FilePath $txtPath -Encoding UTF8
        return $txtPath
    }
}

# ==================== BACKUP A AD / AZURE ====================

function Backup-KeyToAD {
    param([string]$MountPoint)
    
    $vol = Get-BitLockerVolume -MountPoint $MountPoint -ErrorAction SilentlyContinue
    if (-not $vol) { return $false }
    
    $recoveryKeys = $vol.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
    if (-not $recoveryKeys) {
        Write-Host "    No hay claves de recuperacion para respaldar." -ForegroundColor Yellow
        return $false
    }
    
    $success = $false
    
    foreach ($key in $recoveryKeys) {
        $keyId = $key.KeyProtectorId
        
        # Intentar AD On-Premise
        Write-Host "    Intentando backup a Active Directory..." -ForegroundColor DarkGray
        try {
            Backup-BitLockerKeyProtector -MountPoint $MountPoint -KeyProtectorId $keyId -ErrorAction Stop
            Write-Host "    [OK] Clave respaldada en Active Directory." -ForegroundColor Green
            Write-Log "AD Backup OK: ${MountPoint} KeyID: ${keyId}"
            $success = $true
        } catch {
            $adError = $_.Exception.Message
            if ($adError -match "not joined|domain|directory") {
                Write-Host "    [--] Equipo no esta en dominio AD." -ForegroundColor DarkGray
            } else {
                Write-Host "    [--] AD no disponible: $adError" -ForegroundColor DarkGray
            }
        }
        
        # Intentar Azure AD
        Write-Host "    Intentando backup a Azure AD / Entra ID..." -ForegroundColor DarkGray
        try {
            $dsregStatus = dsregcmd /status 2>&1
            $isAzureJoined = ($dsregStatus | Select-String "AzureAdJoined\s*:\s*YES" -Quiet)
            
            if ($isAzureJoined) {
                BackupToAAD-BitLockerKeyProtector -MountPoint $MountPoint -KeyProtectorId $keyId -ErrorAction Stop
                Write-Host "    [OK] Clave respaldada en Azure AD / Entra ID." -ForegroundColor Green
                Write-Log "Azure AD Backup OK: ${MountPoint} KeyID: ${keyId}"
                $success = $true
            } else {
                Write-Host "    [--] Equipo no esta unido a Azure AD." -ForegroundColor DarkGray
            }
        } catch {
            Write-Host "    [--] Azure AD no disponible." -ForegroundColor DarkGray
        }
    }
    
    return $success
}

# ==================== MODO CLI ====================

if ($Action -ne "") {
    switch ($Action) {
        "Extract" {
            $VolumenesBL = Get-BitLockerVolume -ErrorAction SilentlyContinue | Where-Object { $_.VolumeStatus -ne 'FullyDecrypted' }
            if (-not $VolumenesBL) { Write-Host "Sin discos protegidos."; exit 1 }
            
            $outputPath = if ($Output) { $Output } else { Join-Path ([Environment]::GetFolderPath("Desktop")) "BL_$env:COMPUTERNAME_$(Get-Date -Format 'yyyyMMdd_HHmm').txt" }
            
            $content = "ATLAS PC SUPPORT - BITLOCKER KEYS`r`nPC: $env:COMPUTERNAME`r`nFecha: $(Get-Date)`r`n---`r`n"
            foreach ($Vol in $VolumenesBL) {
                $keys = $Vol.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
                foreach ($k in $keys) {
                    $content += "$($Vol.MountPoint) -> $($k.RecoveryPassword)`r`n"
                    Write-Host "$($Vol.MountPoint) -> $($k.RecoveryPassword)"
                }
            }
            $content | Out-File -FilePath $outputPath -Encoding UTF8
            Write-Host "Guardado en: ${outputPath}"
            Write-Log "CLI Extract: ${outputPath}"
            return
        }
        "Status" {
            $vols = Get-BitLockerVolume -ErrorAction SilentlyContinue
            foreach ($v in $vols) {
                $status = $v.VolumeStatus.ToString()
                $pct = $v.EncryptionPercentage
                Write-Host "$($v.MountPoint) | ${status} | ${pct}%"
            }
            return
        }
    }
}

# ==================== MENU PRINCIPAL ====================

Clear-Host

while ($true) {
    Clear-Host
    Write-Host "`n"
    Escribir-Centrado "===================================================" "DarkGray"
    Escribir-Centrado "|                                                 |" "DarkYellow"
    Escribir-Centrado "|               ATLAS PC SUPPORT                  |" "DarkYellow"
    Escribir-Centrado "|             GESTOR BITLOCKER v3                  |" "DarkYellow"
    Escribir-Centrado "|                                                 |" "DarkYellow"
    Escribir-Centrado "===================================================" "DarkGray"
    
    # TPM status
    Write-Host ""
    $tpmInfo = Get-TPMStatus
    $tpmColor = if ($tpmInfo.HasTPM -and $tpmInfo.IsReady) { "Green" } elseif ($tpmInfo.HasTPM) { "Yellow" } else { "Red" }
    Escribir-Centrado "TPM: $($tpmInfo.Summary)" $tpmColor
    
    # Discos protegidos
    $blVolumes = Get-BitLockerVolume -ErrorAction SilentlyContinue | Where-Object { $_.VolumeStatus -ne 'FullyDecrypted' }
    $blCount = if ($blVolumes) { @($blVolumes).Count } else { 0 }
    Escribir-Centrado "Discos protegidos: ${blCount}" $(if ($blCount -gt 0) { "Cyan" } else { "DarkGray" })
    
    # ALERTA DISCOS SIN PROTEGER
    Show-UnprotectedAlert
    
    Write-Host ""
    Escribir-Centrado "[ 1 ] Escanear y Guardar Claves" "White"
    Escribir-Centrado "[ 2 ] Activar BitLocker" "White"
    Escribir-Centrado "[ 3 ] Desactivar BitLocker" "White"
    Escribir-Centrado "[ 4 ] Ver Estado Completo" "White"
    Escribir-Centrado "[ 5 ] Ver Historial de Operaciones" "White"
    Escribir-Centrado "[ S ] Salir" "DarkGray"
    Write-Host ""
    Escribir-Centrado "===================================================" "DarkGray"
    Write-Host ""
    
    $Opcion = Read-Host "  Opcion"

    switch ($Opcion.ToUpper()) {
        # =============================================
        # 1. EXTRAER CLAVES (+ USB + QR + AD + Clipboard)
        # =============================================
        "1" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== EXTRACCION DE CLAVES BITLOCKER ===" "DarkYellow"
            Write-Host ""
            
            $NombreEquipo = $env:COMPUTERNAME
            $UsuarioActual = $env:USERNAME
            $FechaHora = Get-Date -Format 'dd-MM-yyyy_HHmm'
            $NombreArchivo = "BL_${NombreEquipo}_${FechaHora}.txt"
            
            Write-Host "    Escaneando discos protegidos..." -ForegroundColor DarkGray
            $VolumenesBL = Get-BitLockerVolume -ErrorAction SilentlyContinue | Where-Object { $_.VolumeStatus -ne 'FullyDecrypted' }
            
            if (-not $VolumenesBL) {
                Escribir-Centrado "No se encontraron discos con BitLocker activo." "Red"
            } else {
                $Contenido = "===================================================`r`n"
                $Contenido += "      ATLAS PC SUPPORT - RESPALDO DE BITLOCKER`r`n"
                $Contenido += "===================================================`r`n"
                $Contenido += "Fecha               : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')`r`n"
                $Contenido += "Nombre del Equipo   : ${NombreEquipo}`r`n"
                $Contenido += "Usuario Activo      : ${UsuarioActual}`r`n"
                $Contenido += "---------------------------------------------------`r`n`r`n"
                
                $ClavesEncontradas = 0
                $clavesParaClipboard = @()
                $clavesParaQR = @()
                
                foreach ($Vol in $VolumenesBL) {
                    $Claves = $Vol.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
                    if ($Claves) {
                        foreach ($Clave in $Claves) {
                            $mount = $Vol.MountPoint
                            $key = $Clave.RecoveryPassword
                            $keyId = $Clave.KeyProtectorId
                            
                            $Contenido += "UNIDAD: ${mount}`r`n"
                            $Contenido += "ID:     ${keyId}`r`n"
                            $Contenido += "CLAVE:  ${key}`r`n`r`n"
                            
                            $clavesParaClipboard += "${mount} -> ${key}"
                            $clavesParaQR += @{ Mount = $mount; Key = $key; KeyId = $keyId }
                            
                            Write-Host "    [OK] ${mount} -> ${key}" -ForegroundColor Green
                            $ClavesEncontradas++
                        }
                    }
                }
                
                if ($ClavesEncontradas -eq 0) {
                    Escribir-Centrado "No se encontraron claves de recuperacion." "Red"
                } else {
                    $Contenido += "===================================================`r`n"
                    $Contenido += "TOTAL: ${ClavesEncontradas} clave(s)`r`n"
                    
                    Write-Host ""
                    Escribir-Centrado "${ClavesEncontradas} clave(s) encontrada(s)" "Green"
                    Write-Log "Extraccion: ${ClavesEncontradas} claves de ${NombreEquipo}"
                    
                    $rutasGuardadas = @()
                    
                    # Guardar en escritorio
                    $RutaEscritorio = [Environment]::GetFolderPath("Desktop")
                    $RutaCompleta = Join-Path $RutaEscritorio $NombreArchivo
                    try {
                        $Contenido | Out-File -FilePath $RutaCompleta -Encoding UTF8
                        Write-Host "    [OK] Escritorio: ${NombreArchivo}" -ForegroundColor Cyan
                        $rutasGuardadas += $RutaCompleta
                    } catch { Write-Host "    [ERROR] No se guardo en escritorio." -ForegroundColor Red }
                    
                    # USB
                    $usbs = Get-Volume -ErrorAction SilentlyContinue | Where-Object { $_.DriveType -eq 'Removable' -and $_.DriveLetter -and $_.Size -gt 0 }
                    if ($usbs) {
                        Write-Host ""
                        Write-Host "    USB detectado(s). Guardar copia? [S/N]" -ForegroundColor Yellow
                        $usbSel = Read-Host "    >"
                        if ($usbSel -eq "S" -or $usbSel -eq "s") {
                            foreach ($u in $usbs) {
                                try {
                                    $usbPath = Join-Path ($u.DriveLetter + ":\") $NombreArchivo
                                    $Contenido | Out-File -FilePath $usbPath -Encoding UTF8
                                    Write-Host "    [OK] USB $($u.DriveLetter): ${NombreArchivo}" -ForegroundColor Green
                                    $rutasGuardadas += $usbPath
                                } catch { Write-Host "    [ERROR] USB $($u.DriveLetter): $($_.Exception.Message)" -ForegroundColor Red }
                            }
                        }
                    }
                    
                    # QR / Imagen imprimible
                    Write-Host ""
                    Write-Host "    Generar imagen imprimible de las claves? [S/N]" -ForegroundColor Yellow
                    $qrSel = Read-Host "    >"
                    if ($qrSel -eq "S" -or $qrSel -eq "s") {
                        foreach ($kInfo in $clavesParaQR) {
                            $qrFileName = "BL_KEY_${NombreEquipo}_$($kInfo.Mount.TrimEnd(':'))_${FechaHora}.png"
                            $qrPath = Join-Path $RutaEscritorio $qrFileName
                            $label = "Disco: $($kInfo.Mount) | PC: ${NombreEquipo}"
                            $qrResult = Generate-QRCode -Data $kInfo.Key -OutputPath $qrPath -Label $label
                            if ($qrResult -eq $true) {
                                Write-Host "    [OK] Imagen: ${qrFileName}" -ForegroundColor Green
                                $rutasGuardadas += $qrPath
                            } elseif ($qrResult) {
                                Write-Host "    [OK] Texto imprimible: $(Split-Path $qrResult -Leaf)" -ForegroundColor Green
                                $rutasGuardadas += $qrResult
                            } else {
                                Write-Host "    [ERROR] No se genero imagen." -ForegroundColor Red
                            }
                        }
                        Write-Host ""
                        Escribir-Centrado "Imprime la imagen y pegala en la carcasa del equipo." "Cyan"
                    }
                    
                    # AD / Azure AD backup
                    Write-Host ""
                    Write-Host "    Intentar backup a Active Directory / Azure AD? [S/N]" -ForegroundColor Yellow
                    $adSel = Read-Host "    >"
                    if ($adSel -eq "S" -or $adSel -eq "s") {
                        foreach ($Vol in $VolumenesBL) {
                            $adOk = Backup-KeyToAD -MountPoint $Vol.MountPoint
                        }
                    }
                    
                    # Clipboard
                    Write-Host ""
                    Write-Host "    Copiar claves al portapapeles? [S/N]" -ForegroundColor DarkGray
                    $clipSel = Read-Host "    >"
                    if ($clipSel -eq "S" -or $clipSel -eq "s") {
                        try {
                            ($clavesParaClipboard -join "`r`n") | Set-Clipboard
                            Write-Host "    [OK] Copiado al portapapeles." -ForegroundColor Green
                        } catch { Write-Host "    [ERROR] Clipboard no disponible." -ForegroundColor Red }
                    }
                    
                    # Resumen
                    Write-Host ""
                    Escribir-Centrado "RESUMEN DE BACKUPS:" "White"
                    foreach ($ruta in $rutasGuardadas) { Write-Host "    -> ${ruta}" -ForegroundColor Gray }
                }
            }
            Write-Host "`n"; Read-Host "    ENTER para volver..."
        }

        # =============================================
        # 2. ACTIVAR BITLOCKER (con Health Check)
        # =============================================
        "2" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== ACTIVAR BITLOCKER ===" "DarkYellow"
            Write-Host ""
            
            # TPM check
            $tpm = Get-TPMStatus
            $tpmColor = if ($tpm.HasTPM -and $tpm.IsReady) { "Green" } elseif ($tpm.HasTPM) { "Yellow" } else { "Red" }
            Write-Host "    TPM: $($tpm.Summary)" -ForegroundColor $tpmColor
            
            if (-not $tpm.HasTPM) {
                Write-Host "    Sin TPM = contrasena requerida en cada arranque." -ForegroundColor Yellow
                Write-Host ""
                Write-Host "    [C] Continuar con contrasena  [B] Volver" -ForegroundColor White
                $tpmChoice = Read-Host "    >"
                if ($tpmChoice -ne "C" -and $tpmChoice -ne "c") { continue }
            } elseif (-not $tpm.IsReady) {
                Write-Host "    Puede requerir activacion en BIOS." -ForegroundColor Yellow
            }
            
            Write-Host ""
            $allVolumes = Show-DiskTable
            if (-not $allVolumes) { Read-Host "    ENTER para volver..."; continue }
            
            Write-Host "    Disco a encriptar (o [B] para volver):" -ForegroundColor White
            $input = Read-Host "    >"
            if ($input -eq "B" -or $input -eq "b") { continue }
            
            $validated = Validate-DriveLetter -Input $input -ValidVolumes $allVolumes
            if (-not $validated) { Read-Host "    ENTER para volver..."; continue }
            
            $disco = $validated.Letter; $vol = $validated.Volume
            
            if ($vol.VolumeStatus -eq 'FullyEncrypted') {
                Write-Host "    ${disco} YA esta encriptado." -ForegroundColor Yellow
                Read-Host "    ENTER para volver..."; continue
            }
            if ($vol.VolumeStatus -eq 'EncryptionInProgress') {
                Write-Host "    ${disco} ya se esta encriptando." -ForegroundColor Yellow
                Show-EncryptionProgress -MountPoint $disco -Mode "Encrypting"
                Read-Host "    ENTER para volver..."; continue
            }
            
            # HEALTH CHECK
            $health = Test-PreEncryptionHealth -MountPoint $disco
            
            if (-not $health.CanProceed) {
                Write-Host ""
                Escribir-Centrado "NO SE RECOMIENDA ENCRIPTAR EN ESTE ESTADO." "Red"
                Write-Host ""
                Write-Host "    [F] Forzar de todos modos  [B] Volver (recomendado)" -ForegroundColor Yellow
                $forceChoice = Read-Host "    >"
                if ($forceChoice -ne "F" -and $forceChoice -ne "f") {
                    Write-Log "Encriptacion cancelada por HealthCheck: ${disco}"
                    continue
                }
                Write-Log "HealthCheck FORZADO por usuario: ${disco}"
            }
            
            # Confirmación
            $capGB = if ($vol.CapacityGB) { "{0:N1}" -f $vol.CapacityGB } else { "?" }
            Write-Host ""
            Escribir-Centrado "CONFIRMAR: Activar BitLocker en ${disco} (${capGB} GB)?" "Yellow"
            Write-Host "    [S] Encriptar  [N] Cancelar" -ForegroundColor White
            $confirm = Read-Host "    >"
            if ($confirm -ne "S" -and $confirm -ne "s") { continue }
            
            Write-Host ""
            Write-Host "    Activando BitLocker en ${disco}..." -ForegroundColor Yellow
            
            try {
                if ($tpm.HasTPM -and $tpm.IsReady) {
                    Enable-BitLocker -MountPoint $disco -EncryptionMethod XtsAes256 -RecoveryPasswordProtector -ErrorAction Stop
                } else {
                    Write-Host "    Ingresa contrasena para arranque:" -ForegroundColor Cyan
                    $secPwd = Read-Host "    Contrasena" -AsSecureString
                    Enable-BitLocker -MountPoint $disco -EncryptionMethod XtsAes256 -PasswordProtector -Password $secPwd -ErrorAction Stop
                    Add-BitLockerKeyProtector -MountPoint $disco -RecoveryPasswordProtector -ErrorAction Stop
                }
                
                Write-Host ""
                Escribir-Centrado "BitLocker ACTIVADO en ${disco}" "Green"
                Escribir-Centrado "USA OPCION [1] PARA GUARDAR LA CLAVE!" "Cyan"
                Write-Log "BitLocker ACTIVADO: ${disco} (XtsAes256)"
                
                # AD backup automatico
                Write-Host ""
                Backup-KeyToAD -MountPoint $disco
                
                Write-Host ""
                Write-Host "    [M] Monitorear progreso  [ENTER] Volver" -ForegroundColor DarkGray
                $monSel = Read-Host "    >"
                if ($monSel -eq "M" -or $monSel -eq "m") {
                    Show-EncryptionProgress -MountPoint $disco -Mode "Encrypting"
                }
            } catch {
                Write-Host "    [ERROR] $($_.Exception.Message)" -ForegroundColor Red
                Write-Log "ERROR activando BitLocker ${disco}: $($_.Exception.Message)" "ERROR"
                
                $msg = $_.Exception.Message
                if ($msg -match "TPM") {
                    Write-Host "    SUGERENCIA: Activa TPM en BIOS." -ForegroundColor Yellow
                }
                if ($msg -match "policy|Group Policy") {
                    Write-Host "    SUGERENCIA: gpedit.msc > Computer Config > Admin Templates > BitLocker" -ForegroundColor Yellow
                }
            }
            Write-Host ""; Read-Host "    ENTER para volver..."
        }

        # =============================================
        # 3. DESACTIVAR BITLOCKER
        # =============================================
        "3" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== DESACTIVAR BITLOCKER ===" "DarkYellow"
            Write-Host ""
            
            $encVolumes = Show-DiskTable -OnlyEncrypted
            if (-not $encVolumes) { Read-Host "    ENTER para volver..."; continue }
            
            Write-Host "    Disco a desencriptar (o [B]):" -ForegroundColor White
            $input = Read-Host "    >"
            if ($input -eq "B" -or $input -eq "b") { continue }
            
            $validated = Validate-DriveLetter -Input $input -ValidVolumes $encVolumes
            if (-not $validated) { Read-Host "    ENTER para volver..."; continue }
            
            $disco = $validated.Letter; $vol = $validated.Volume
            
            if ($vol.VolumeStatus -eq 'DecryptionInProgress') {
                Write-Host "    Ya se esta desencriptando." -ForegroundColor Yellow
                Show-EncryptionProgress -MountPoint $disco -Mode "Decrypting"
                Read-Host "    ENTER para volver..."; continue
            }
            
            $capGB = if ($vol.CapacityGB) { "{0:N1}" -f $vol.CapacityGB } else { "?" }
            Write-Host ""
            Escribir-Centrado "CONFIRMAR: Desactivar BitLocker en ${disco} (${capGB} GB)?" "Red"
            Write-Host "    ADVERTENCIA: Los datos quedaran sin proteccion." -ForegroundColor Yellow
            Write-Host "    [S] Desencriptar  [N] Cancelar" -ForegroundColor White
            $confirm = Read-Host "    >"
            if ($confirm -ne "S" -and $confirm -ne "s") { continue }
            
            try {
                Disable-BitLocker -MountPoint $disco -ErrorAction Stop
                Escribir-Centrado "Desencriptacion iniciada en ${disco}." "Green"
                Write-Log "BitLocker DESACTIVADO: ${disco}"
                
                Write-Host "    [M] Monitorear  [ENTER] Volver" -ForegroundColor DarkGray
                $monSel = Read-Host "    >"
                if ($monSel -eq "M" -or $monSel -eq "m") {
                    Show-EncryptionProgress -MountPoint $disco -Mode "Decrypting"
                }
            } catch {
                Write-Host "    [ERROR] $($_.Exception.Message)" -ForegroundColor Red
                Write-Log "ERROR desactivando ${disco}: $($_.Exception.Message)" "ERROR"
            }
            Write-Host ""; Read-Host "    ENTER para volver..."
        }

        # =============================================
        # 4. ESTADO COMPLETO
        # =============================================
        "4" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== ESTADO COMPLETO ===" "DarkYellow"
            Write-Host ""
            
            $tpm = Get-TPMStatus
            $tpmColor = if ($tpm.HasTPM -and $tpm.IsReady) { "Green" } elseif ($tpm.HasTPM) { "Yellow" } else { "Red" }
            Write-Host "    TPM: $($tpm.Summary)" -ForegroundColor $tpmColor
            
            Show-DiskTable | Out-Null
            
            # Alerta
            Show-UnprotectedAlert
            
            # Protectores
            Write-Host ""
            Write-Host "    PROTECTORES ACTIVOS:" -ForegroundColor DarkGray
            Write-Host "    --------------------" -ForegroundColor DarkGray
            $allVols = Get-BitLockerVolume -ErrorAction SilentlyContinue
            $hasProtectors = $false
            foreach ($v in $allVols) {
                if ($v.VolumeStatus -ne 'FullyDecrypted' -and $v.KeyProtector) {
                    foreach ($kp in $v.KeyProtector) {
                        $kpType = $kp.KeyProtectorType.ToString()
                        $kpId = if ($kp.KeyProtectorId) { $kp.KeyProtectorId.Substring(0, [math]::Min(20, $kp.KeyProtectorId.Length)) + "..." } else { "" }
                        $typeLabel = switch ($kpType) {
                            "RecoveryPassword" { "Clave Recuperacion" }
                            "Tpm" { "TPM" }
                            "TpmPin" { "TPM + PIN" }
                            "Password" { "Contrasena" }
                            "ExternalKey" { "Llave Externa" }
                            default { $kpType }
                        }
                        Write-Host "    $($v.MountPoint) -> ${typeLabel} ${kpId}" -ForegroundColor Gray
                        $hasProtectors = $true
                    }
                }
            }
            if (-not $hasProtectors) { Write-Host "    (ninguno)" -ForegroundColor DarkGray }
            
            Write-Host "`n"; Read-Host "    ENTER para volver..."
        }

        # =============================================
        # 5. HISTORIAL
        # =============================================
        "5" {
            Clear-Host
            Write-Host "`n"
            Escribir-Centrado "=== HISTORIAL DE OPERACIONES ===" "DarkYellow"
            Write-Host ""
            
            if (Test-Path $logFile) {
                $logContent = Get-Content $logFile -Tail 50 -ErrorAction SilentlyContinue
                if ($logContent) {
                    Write-Host "    Ultimas operaciones (max 50):" -ForegroundColor DarkGray
                    Write-Host "    " + ("-" * 80) -ForegroundColor DarkGray
                    Write-Host ""
                    foreach ($line in $logContent) {
                        $lineColor = "Gray"
                        if ($line -match "ERROR") { $lineColor = "Red" }
                        elseif ($line -match "ACTIVADO") { $lineColor = "Green" }
                        elseif ($line -match "DESACTIVADO") { $lineColor = "Yellow" }
                        elseif ($line -match "Extraccion|Extract") { $lineColor = "Cyan" }
                        elseif ($line -match "FORZADO") { $lineColor = "Red" }
                        Write-Host "    ${line}" -ForegroundColor $lineColor
                    }
                } else {
                    Write-Host "    Log vacio." -ForegroundColor DarkGray
                }
            } else {
                Write-Host "    No hay historial aun." -ForegroundColor DarkGray
                Write-Host "    Se creara automaticamente con cada operacion." -ForegroundColor DarkGray
            }
            
            Write-Host ""
            Write-Host "    Archivo: ${logFile}" -ForegroundColor DarkGray
            Write-Host ""
            Write-Host "    [L] Limpiar historial  [ENTER] Volver" -ForegroundColor DarkGray
            $logAction = Read-Host "    >"
            if ($logAction -eq "L" -or $logAction -eq "l") {
                Write-Host "    Seguro? [S/N]" -ForegroundColor Yellow
                $logConfirm = Read-Host "    >"
                if ($logConfirm -eq "S" -or $logConfirm -eq "s") {
                    Remove-Item $logFile -Force -ErrorAction SilentlyContinue
                    Write-Host "    Historial limpiado." -ForegroundColor Green
                    Start-Sleep 1
                }
            }
        }

        "S" {
            Write-Host ""
            Escribir-Centrado "Cerrando..." "DarkYellow"
            Write-Log "Sesion cerrada"
            Start-Sleep -Seconds 1
            [console]::ResetColor()
            Clear-Host
            return
        }

        default {
            Escribir-Centrado "Opcion no valida." "Red"
            Start-Sleep -Seconds 1
        }
    }
}
}


# ---- tools\Invoke-HostsManager.ps1 ----
# ============================================================
# Invoke-HostsManager
# Migrado de: HOSTS.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-HostsManager {
    [CmdletBinding()]
    param()

}


# ---- tools\Invoke-MenorPrivilegio.ps1 ----
# ============================================================
# Invoke-MenorPrivilegio
# Migrado de: Principio_Menor_Privilegio.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-MenorPrivilegio {
    [CmdletBinding()]
    param()
﻿# ATLAS PC SUPPORT - SECURITY SUITE v3.0
# Herramienta: Principio de Menor Privilegio + Hardening UAC
# Fixes: BSTR leak, SecureString check, wmic deprecated, shutdown /l, ErrorActionPreference
# Upscale: Auditoria, Deshabilitar cuenta, Politica de contraseñas, UAC en header, informe .txt

$ErrorActionPreference = "Stop"

# --- 0. AUTO-ELEVACION ---
# (auto-elevación gestionada por Atlas Launcher)

# --- 1. CONFIGURACION VISUAL ---
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT | Security Suite v3.0"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Gray"
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(90, 48) } catch {}
Clear-Host
try { [Console]::CursorVisible = $true } catch {}

# --- 2. DETECCION MULTI-IDIOMA (SIDs) ---
try {
    $objSIDAdmin = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544")
    $adminGroupName = $objSIDAdmin.Translate([System.Security.Principal.NTAccount]).Value.Split("\")[-1]

    $objSIDUser = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-545")
    $stdGroupName = $objSIDUser.Translate([System.Security.Principal.NTAccount]).Value.Split("\")[-1]
} catch {
    $adminGroupName = "Administradores"
    $stdGroupName = "Usuarios"
}

# --- 3. HELPERS ---

function Escribir-Centrado {
    param([string]$Texto, [ConsoleColor]$Color = "White", [boolean]$NewLine = $true)
    try {
        $Ancho = $Host.UI.RawUI.WindowSize.Width
        $PadLeft = [math]::Max(0, [math]::Floor(($Ancho - $Texto.Length) / 2))
        Write-Host (" " * $PadLeft) -NoNewline
        if ($NewLine) { Write-Host $Texto -ForegroundColor $Color }
        else { Write-Host $Texto -ForegroundColor $Color -NoNewline }
    } catch { Write-Host $Texto -ForegroundColor $Color }
}

function Obtener-EstadoUAC {
    try {
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
        $lua  = (Get-ItemProperty -Path $regPath -Name "EnableLUA" -ErrorAction SilentlyContinue).EnableLUA
        $sdt  = (Get-ItemProperty -Path $regPath -Name "PromptOnSecureDesktop" -ErrorAction SilentlyContinue).PromptOnSecureDesktop
        $usr  = (Get-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorUser" -ErrorAction SilentlyContinue).ConsentPromptBehaviorUser
        $adm  = (Get-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorAdmin" -ErrorAction SilentlyContinue).ConsentPromptBehaviorAdmin
        if ($lua -eq 1 -and $sdt -eq 1 -and $usr -eq 1 -and $adm -eq 2) { return @{ Texto = "UAC: MAXIMO [OK]"; Color = "Green" } }
        elseif ($lua -eq 0) { return @{ Texto = "UAC: DESACTIVADO [RIESGO]"; Color = "Red" } }
        else { return @{ Texto = "UAC: PARCIAL [REVISAR]"; Color = "Yellow" } }
    } catch { return @{ Texto = "UAC: DESCONOCIDO"; Color = "DarkGray" } }
}

function Obtener-RolUsuario {
    param([string]$NombreUsuario)
    try {
        $miembros = Get-LocalGroupMember -SID "S-1-5-32-544" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name.Split("\")[-1] }
        if ($miembros -contains $NombreUsuario) { return "Administrador" } else { return "Estandar" }
    } catch { return "Desconocido" }
}

function Dibujar-Header {
    Clear-Host
    Write-Host "`n"
    $uac = Obtener-EstadoUAC
    $rol = Obtener-RolUsuario $env:USERNAME
    $rolColor = if ($rol -eq "Administrador") { "Cyan" } else { "Green" }

    Escribir-Centrado "==========================================================" "DarkGray"
    Escribir-Centrado "A T L A S   P C   S U P P O R T" "Cyan"
    Escribir-Centrado "Security Suite v3.0" "DarkGray"
    Escribir-Centrado "==========================================================" "DarkGray"
    Write-Host ""
    Escribir-Centrado "Usuario: $env:USERNAME  |  Rol: $rol" $rolColor
    Escribir-Centrado $uac.Texto $uac.Color
    Escribir-Centrado "==========================================================" "DarkGray"
    Write-Host ""
}

function Validar-Contrasena {
    param([System.Security.SecureString]$Pass)
    if ($Pass.Length -lt 8) { return "La contrasena debe tener al menos 8 caracteres." }
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Pass)
    try {
        $plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
        if ($plain -notmatch '[0-9]')         { return "Debe contener al menos un numero." }
        if ($plain -notmatch '[A-Z]')         { return "Debe contener al menos una mayuscula." }
        if ($plain -notmatch '[^a-zA-Z0-9]') { return "Debe contener al menos un caracter especial." }
        return $null
    } finally {
        [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    }
}


function Escribir-Descripcion {
    param(
        [string]$Que,
        [string]$Recomendacion,
        [string]$Precaucion
    )
    $w = $Host.UI.RawUI.WindowSize.Width
    $sep = "-" * 54
    $pad = [math]::Max(0, [math]::Floor(($w - 56) / 2))
    $s = " " * $pad
    Write-Host "$s+$sep+" -ForegroundColor DarkGray
    Write-Host "$s|  " -NoNewline; Write-Host ("QUE HACE:".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    # Wrap Que
    $words = $Que -split ' '; $line = "  "; foreach ($word in $words) { if (($line + $word).Length -gt 51) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor White -NoNewline; Write-Host "|" -ForegroundColor DarkGray; $line = "  $word " } else { $line += "$word " } }; if ($line.Trim()) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor White -NoNewline; Write-Host "|" -ForegroundColor DarkGray }
    Write-Host "$s|  " -NoNewline; Write-Host ("".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    Write-Host "$s|  " -NoNewline; Write-Host ("RECOMENDACION:".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    $words = $Recomendacion -split ' '; $line = "  "; foreach ($word in $words) { if (($line + $word).Length -gt 51) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor Cyan -NoNewline; Write-Host "|" -ForegroundColor DarkGray; $line = "  $word " } else { $line += "$word " } }; if ($line.Trim()) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor Cyan -NoNewline; Write-Host "|" -ForegroundColor DarkGray }
    Write-Host "$s|  " -NoNewline; Write-Host ("".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    Write-Host "$s|  " -NoNewline; Write-Host ("PRECAUCION:".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    $words = $Precaucion -split ' '; $line = "  "; foreach ($word in $words) { if (($line + $word).Length -gt 51) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor Yellow -NoNewline; Write-Host "|" -ForegroundColor DarkGray; $line = "  $word " } else { $line += "$word " } }; if ($line.Trim()) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor Yellow -NoNewline; Write-Host "|" -ForegroundColor DarkGray }
    Write-Host "$s+$sep+" -ForegroundColor DarkGray
    Write-Host ""
}


function Escribir-Descripcion {
    param([string]$Que, [string]$Recomendacion, [string]$Precaucion)
    $w   = $Host.UI.RawUI.WindowSize.Width
    $sep = "-" * 54
    $pad = [math]::Max(0, [math]::Floor(($w - 58) / 2))
    $s   = " " * $pad
    function WrapLine($txt, $col) {
        $words = $txt -split ' '; $line = "  "
        foreach ($word in $words) {
            if (($line + $word).Length -gt 51) {
                Write-Host "$s|  " -NoNewline
                Write-Host ($line.PadRight(53)) -ForegroundColor $col -NoNewline
                Write-Host "|" -ForegroundColor DarkGray
                $line = "  $word "
            } else { $line += "$word " }
        }
        if ($line.Trim()) {
            Write-Host "$s|  " -NoNewline
            Write-Host ($line.PadRight(53)) -ForegroundColor $col -NoNewline
            Write-Host "|" -ForegroundColor DarkGray
        }
    }
    function LabelLine($lbl) {
        Write-Host "$s|  " -NoNewline
        Write-Host ($lbl.PadRight(53)) -ForegroundColor DarkGray -NoNewline
        Write-Host "|" -ForegroundColor DarkGray
    }
    function BlankLine {
        Write-Host "$s|  " -NoNewline
        Write-Host ("".PadRight(53)) -NoNewline
        Write-Host "|" -ForegroundColor DarkGray
    }
    Write-Host "$s+$sep+" -ForegroundColor DarkGray
    LabelLine "  QUE HACE:"
    WrapLine $Que "White"
    BlankLine
    LabelLine "  RECOMENDACION:"
    WrapLine $Recomendacion "Cyan"
    BlankLine
    LabelLine "  PRECAUCION:"
    WrapLine $Precaucion "Yellow"
    Write-Host "$s+$sep+" -ForegroundColor DarkGray
    Write-Host ""
}

function Desencriptar-Pass {
    param([System.Security.SecureString]$Pass)
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Pass)
    try { return [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) }
    finally { [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR) }
}

# --- 4. LOGICA DEL MENU ---

do {
    Dibujar-Header

    $anchoPantalla = $Host.UI.RawUI.WindowSize.Width
    $textoReferencia = "5. Deshabilitar / Habilitar Cuenta de Usuario"
    $padBloque = [math]::Max(0, [math]::Floor(($anchoPantalla - $textoReferencia.Length) / 2))
    $espacio = " " * $padBloque
    $padInput = [math]::Max(0, [math]::Floor(($anchoPantalla - 10) / 2))

    Write-Host "$espacio" -NoNewline; Write-Host "1. Crear NUEVO Administrador (Respaldo)" -ForegroundColor White
    Write-Host "$espacio" -NoNewline; Write-Host "2. Convertir Usuario Actual a ESTANDAR" -ForegroundColor White
    Write-Host "$espacio" -NoNewline; Write-Host "3. Configuracion del UAC - Seguridad Maxima" -ForegroundColor Cyan
    Write-Host "$espacio" -NoNewline; Write-Host "4. Auditoria de Usuarios del Sistema" -ForegroundColor Yellow
    Write-Host "$espacio" -NoNewline; Write-Host "5. Deshabilitar / Habilitar Cuenta de Usuario" -ForegroundColor Magenta
    Write-Host "$espacio" -NoNewline; Write-Host "6. Configurar Politica de Contrasenas" -ForegroundColor DarkCyan
    Write-Host "$espacio" -NoNewline; Write-Host "7. Exportar Informe de Seguridad (.txt)" -ForegroundColor DarkYellow
    Write-Host "$espacio" -NoNewline; Write-Host "8. Salir" -ForegroundColor DarkGray
    Write-Host ""

    Write-Host (" " * $padInput) -NoNewline
    $seleccion = Read-Host "Opcion"

    switch ($seleccion) {

        # =========================================================
        "1" {
            Dibujar-Header
            Escribir-Centrado ">>> CREAR NUEVO ADMINISTRADOR <<<" "Green"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Crea una cuenta de Administrador local nueva con contrasena segura y sin caducidad. Sirve como cuenta de respaldo para recuperar el sistema si la cuenta principal falla." `
                -Recomendacion "Usa un nombre discreto (no admin ni backup). Guarda las credenciales en un gestor seguro como Bitwarden. Crea solo una cuenta de respaldo por equipo." `
                -Precaucion "Tener dos cuentas Admin activas amplia la superficie de ataque. Crea esta cuenta, verifica que funciona y luego aplica la opcion 2 al usuario principal."
            Escribir-Centrado "(Nombre en blanco = volver)" "DarkGray"
            Write-Host (" " * ($padInput - 5)) -NoNewline
            $newAdminUser = Read-Host "Nombre Admin"
            if ([string]::IsNullOrWhiteSpace($newAdminUser)) { break }

            # Comprobar si ya existe
            $existe = Get-LocalUser -Name $newAdminUser -ErrorAction SilentlyContinue
            if ($existe) {
                Escribir-Centrado "ERROR: Ya existe una cuenta con ese nombre." "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            Write-Host (" " * ($padInput - 5)) -NoNewline
            Write-Host "Contrasena (min 8 car., 1 num., 1 MAY., 1 especial): " -NoNewline -ForegroundColor Yellow
            $passSecure = Read-Host -AsSecureString

            if ($passSecure.Length -eq 0) {
                Escribir-Centrado "ERROR: La contrasena no puede estar vacia." "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            $errPass = Validar-Contrasena $passSecure
            if ($errPass) {
                Escribir-Centrado "ERROR: $errPass" "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            Write-Host ""
            Escribir-Centrado "Procesando..." "Cyan"

            try {
                New-LocalUser -Name $newAdminUser -Password $passSecure -PasswordNeverExpires $true -ErrorAction Stop | Out-Null
                Add-LocalGroupMember -SID "S-1-5-32-544" -Member $newAdminUser -ErrorAction Stop
                Escribir-Centrado "EXITO: Administrador '$newAdminUser' creado." "Green"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "2" {
            Dibujar-Header
            Escribir-Centrado ">>> CONVERTIR A ESTANDAR <<<" "Yellow"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Quita los privilegios de Administrador al usuario actual y lo convierte en usuario Estandar. Aplica el principio de menor privilegio para el uso diario del cliente." `
                -Recomendacion "Esta es la configuracion ideal para el dia a dia. Reduce drasticamente el riesgo de infecciones por malware y cambios accidentales en el sistema." `
                -Precaucion "IRREVERSIBLE sin otro Admin activo. El script lo verifica automaticamente, pero asegurate de que la cuenta de respaldo (opcion 1) ya existe y funciona antes de continuar."

            # Verificar que exista otro admin antes de proceder
            try {
                $todosAdmins = @(Get-LocalGroupMember -SID "S-1-5-32-544" -ErrorAction Stop | ForEach-Object { $_.Name.Split("\")[-1] })
                $otrosAdmins = $todosAdmins | Where-Object { $_ -ne $env:USERNAME }
                if ($otrosAdmins.Count -eq 0) {
                    Escribir-Centrado "BLOQUEADO: No existe otro Administrador activo." "Red"
                    Escribir-Centrado "Crea uno primero con la opcion 1." "Yellow"
                    Read-Host "`nPresione Enter para continuar..."
                    break
                }
            } catch {
                Escribir-Centrado "ERROR al verificar admins: $($_.Exception.Message)" "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            Escribir-Centrado "ATENCION: Esta accion quitara tus permisos de Admin." "Red"
            Escribir-Centrado "Otro administrador detectado: OK" "Green"
            Write-Host ""
            Escribir-Centrado "(Escribe 'SI' para confirmar, o Enter para volver)" "Gray"
            Write-Host (" " * ($padInput - 10)) -NoNewline
            $confirm = Read-Host "Confirmar"
            if ($confirm -ne "SI") { break }

            $targetUser = $env:USERNAME
            Escribir-Centrado "Procesando..." "Cyan"

            try {
                Add-LocalGroupMember -SID "S-1-5-32-545" -Member $targetUser -ErrorAction SilentlyContinue
                Remove-LocalGroupMember -SID "S-1-5-32-544" -Member $targetUser -ErrorAction Stop
                Escribir-Centrado "PERMISOS ACTUALIZADOS. Ahora eres usuario Estandar." "Green"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            Write-Host ""
            Write-Host (" " * ($padInput - 10)) -NoNewline
            $logoff = Read-Host "Cerrar sesion ahora para aplicar cambios? (S/N)"
            if ($logoff -eq "S" -or $logoff -eq "s") {
                Start-Process "shutdown.exe" -ArgumentList "/l"
                return
            }
        }

        # =========================================================
        "3" {
            Dibujar-Header
            Escribir-Centrado ">>> BLINDAJE DE SEGURIDAD (UAC) <<<" "Cyan"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Activa el Control de Cuentas de Usuario (UAC) al nivel maximo. Obliga a introducir credenciales de Admin para instalar software o cambiar configuraciones criticas del sistema." `
                -Recomendacion "Ejecutar siempre despues de convertir al usuario a Estandar (opcion 2). Es la segunda capa de defensa mas importante. Aplica en cada entrega de equipo." `
                -Precaucion "El cliente vera mas ventanas de confirmacion. Informa que es por seguridad. Puede interrumpir flujos de trabajo de usuarios acostumbrados a trabajar sin UAC activo."
            Escribir-Centrado "Se aplicaran estas 4 reglas de registro:" "White"
            Write-Host ""
            Escribir-Centrado "  [1] EnableLUA = 1              (UAC activo)" "Gray"
            Escribir-Centrado "  [2] PromptOnSecureDesktop = 1  (Escritorio seguro)" "Gray"
            Escribir-Centrado "  [3] ConsentPromptBehaviorUser = 1  (Credenciales para estandar)" "Gray"
            Escribir-Centrado "  [4] ConsentPromptBehaviorAdmin = 2 (Credenciales para admins)" "Gray"
            Write-Host ""
            Escribir-Centrado "(Enter para aplicar, 'N' para cancelar)" "Gray"
            Write-Host (" " * $padInput) -NoNewline
            $uacConf = Read-Host ""
            if ($uacConf -eq "N" -or $uacConf -eq "n") { break }

            try {
                $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
                Escribir-Centrado "Aplicando reglas de registro..." "DarkGray"

                Set-ItemProperty -Path $regPath -Name "EnableLUA"                    -Value 1 -ErrorAction Stop
                Set-ItemProperty -Path $regPath -Name "PromptOnSecureDesktop"        -Value 1 -ErrorAction Stop
                Set-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorUser"    -Value 1 -ErrorAction Stop
                Set-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorAdmin"   -Value 2 -ErrorAction Stop

                Write-Host ""
                Escribir-Centrado "CONFIGURACION APLICADA." "Green"
                Escribir-Centrado "Windows pedira credenciales para instalar software." "Gray"
                Escribir-Centrado "Se requiere reinicio para aplicar completamente." "Yellow"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "4" {
            Dibujar-Header
            Escribir-Centrado ">>> AUDITORIA DE USUARIOS DEL SISTEMA <<<" "Yellow"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Lista todas las cuentas locales del equipo mostrando nombre, rol (Admin/Estandar), estado (activa/desactivada) y si tienen contrasena requerida." `
                -Recomendacion "Ejecuta antes y despues de cualquier cambio para verificar el estado real. Ideal para documentar la configuracion al inicio y al final de una intervencion tecnica." `
                -Precaucion "Solo lectura, no realiza ningun cambio. Si ves cuentas Admin desconocidas o cuentas activas sin contrasena, investiga antes de continuar con otras opciones."

            try {
                $usuarios = Get-LocalUser -ErrorAction Stop
                $admins   = @(Get-LocalGroupMember -SID "S-1-5-32-544" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name.Split("\")[-1] })

                $anchoPantalla2 = $Host.UI.RawUI.WindowSize.Width
                $lineaEncabezado = "{0,-22} {1,-14} {2,-12} {3,-10}" -f "USUARIO","ROL","ESTADO","CLAVE"
                $padAudit = [math]::Max(0, [math]::Floor(($anchoPantalla2 - $lineaEncabezado.Length) / 2))
                $spc = " " * $padAudit

                Write-Host "$spc$lineaEncabezado" -ForegroundColor DarkGray
                Write-Host "$spc$("-" * $lineaEncabezado.Length)" -ForegroundColor DarkGray

                foreach ($u in $usuarios) {
                    $rol    = if ($admins -contains $u.Name) { "Admin" } else { "Estandar" }
                    $estado = if ($u.Enabled) { "Activa" } else { "Desactivada" }
                    $clave  = if ($u.PasswordRequired) { "Requerida" } else { "No req." }
                    $linea  = "{0,-22} {1,-14} {2,-12} {3,-10}" -f $u.Name, $rol, $estado, $clave

                    $color = if (!$u.Enabled) { "DarkGray" }
                             elseif ($rol -eq "Admin") { "Cyan" }
                             else { "White" }
                    Write-Host "$spc$linea" -ForegroundColor $color
                }
                Write-Host ""
                Escribir-Centrado "Total: $($usuarios.Count) cuenta(s) | Admins: $($admins.Count)" "DarkGray"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "5" {
            Dibujar-Header
            Escribir-Centrado ">>> DESHABILITAR / HABILITAR CUENTA <<<" "Magenta"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Desactiva o reactiva una cuenta local sin eliminarla. Una cuenta desactivada no puede iniciar sesion pero conserva todos sus datos y configuracion intactos." `
                -Recomendacion "Prefiere deshabilitar sobre eliminar. Si en el futuro necesitas recuperar acceso a esa cuenta, podras reactivarla sin perder datos ni configuracion del perfil." `
                -Precaucion "No puedes deshabilitar tu propia cuenta activa. No deshabilites la unica cuenta Admin del sistema o el equipo quedara inaccesible sin reinstalar Windows."

            try {
                $usuarios = Get-LocalUser -ErrorAction Stop | Where-Object { $_.Name -ne $env:USERNAME }
                if ($usuarios.Count -eq 0) {
                    Escribir-Centrado "No hay otras cuentas disponibles." "Yellow"
                    Read-Host "`nPresione Enter para continuar..."
                    break
                }

                $anchoPantalla3 = $Host.UI.RawUI.WindowSize.Width
                $i = 1
                foreach ($u in $usuarios) {
                    $estado = if ($u.Enabled) { "[ACTIVA]" } else { "[DESACTIVADA]" }
                    $color  = if ($u.Enabled) { "White" } else { "DarkGray" }
                    $linea  = "  $i. $($u.Name) $estado"
                    $pad3   = [math]::Max(0, [math]::Floor(($anchoPantalla3 - $linea.Length) / 2))
                    Write-Host (" " * $pad3 + $linea) -ForegroundColor $color
                    $i++
                }

                Write-Host ""
                Escribir-Centrado "(Numero de cuenta, o Enter para volver)" "DarkGray"
                Write-Host (" " * $padInput) -NoNewline
                $numStr = Read-Host "Cuenta"
                if ([string]::IsNullOrWhiteSpace($numStr)) { break }

                $num = 0
                if (![int]::TryParse($numStr, [ref]$num) -or $num -lt 1 -or $num -gt $usuarios.Count) {
                    Escribir-Centrado "Numero invalido." "Red"
                    Read-Host "`nPresione Enter para continuar..."
                    break
                }

                $cuentaElegida = @($usuarios)[$num - 1]
                if ($cuentaElegida.Enabled) {
                    Disable-LocalUser -Name $cuentaElegida.Name -ErrorAction Stop
                    Escribir-Centrado "Cuenta '$($cuentaElegida.Name)' DESHABILITADA." "Yellow"
                } else {
                    Enable-LocalUser -Name $cuentaElegida.Name -ErrorAction Stop
                    Escribir-Centrado "Cuenta '$($cuentaElegida.Name)' HABILITADA." "Green"
                }
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "6" {
            Dibujar-Header
            Escribir-Centrado ">>> POLITICA DE CONTRASENAS <<<" "DarkCyan"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Configura las reglas globales de contrasenas del sistema: longitud minima, dias hasta caducidad y numero de intentos fallidos antes de bloquear la cuenta." `
                -Recomendacion "Valores recomendados: longitud minima 10, expiracion 90 dias, bloqueo tras 5 intentos. Para uso domestico puedes poner expiracion 0 (nunca caduca)." `
                -Precaucion "Estos cambios afectan a TODAS las cuentas del equipo. Un lockout muy agresivo (3 intentos) puede bloquear al cliente si olvida su contrasena con frecuencia."

            try {
                $politicaActual = net accounts 2>$null | Select-String "Minimum|Maximum|Lockout" | ForEach-Object { "  " + $_.Line.Trim() }
                Escribir-Centrado "Politica actual:" "DarkGray"
                $politicaActual | ForEach-Object { Escribir-Centrado $_ "Gray" }
            } catch {}

            Write-Host ""
            Escribir-Centrado "--- Configurar nueva politica ---" "DarkCyan"
            Write-Host ""

            Write-Host (" " * ($padInput - 8)) -NoNewline
            $minLen = Read-Host "Longitud minima (Enter = no cambiar)"

            Write-Host (" " * ($padInput - 8)) -NoNewline
            $maxAge = Read-Host "Dias hasta expiracion (Enter = no cambiar, 0 = nunca)"

            Write-Host (" " * ($padInput - 8)) -NoNewline
            $lockout = Read-Host "Intentos antes de bloquear (Enter = no cambiar)"

            $cambios = 0
            try {
                if (![string]::IsNullOrWhiteSpace($minLen) -and $minLen -match '^\d+$') {
                    net accounts /minpwlen:$minLen | Out-Null; $cambios++
                }
                if (![string]::IsNullOrWhiteSpace($maxAge) -and $maxAge -match '^\d+$') {
                    net accounts /maxpwage:$maxAge | Out-Null; $cambios++
                }
                if (![string]::IsNullOrWhiteSpace($lockout) -and $lockout -match '^\d+$') {
                    net accounts /lockoutthreshold:$lockout | Out-Null; $cambios++
                }
                if ($cambios -gt 0) { Escribir-Centrado "$cambios cambio(s) aplicados." "Green" }
                else { Escribir-Centrado "Sin cambios." "DarkGray" }
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "7" {
            Dibujar-Header
            Escribir-Centrado ">>> EXPORTAR INFORME DE SEGURIDAD <<<" "DarkYellow"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Genera un archivo .txt en el escritorio con el estado completo de seguridad: nivel UAC, lista de usuarios con roles y estados, y politica de contrasenas vigente." `
                -Recomendacion "Genera el informe al inicio y al final de cada intervencion. Guardalo en la ficha del cliente como evidencia del trabajo realizado y estado del equipo." `
                -Precaucion "El informe contiene informacion sensible (nombres de cuentas, configuracion). No lo dejes en el escritorio del cliente: guardalo en tu sistema y elimina la copia local."
            Escribir-Centrado "Generando informe..." "Cyan"

            try {
                $uac      = Obtener-EstadoUAC
                $usuarios = Get-LocalUser -ErrorAction Stop
                $admins   = @(Get-LocalGroupMember -SID "S-1-5-32-544" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name.Split("\")[-1] })
                $politica = net accounts 2>$null

                $lineas = @()
                $lineas += "=========================================================="
                $lineas += "  ATLAS PC SUPPORT - INFORME DE SEGURIDAD"
                $lineas += "  Fecha    : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
                $lineas += "  Equipo   : $env:COMPUTERNAME"
                $lineas += "  Usuario  : $env:USERNAME"
                $lineas += "=========================================================="
                $lineas += ""
                $lineas += "--- ESTADO UAC ---"
                $lineas += "  " + $uac.Texto
                $lineas += ""
                $lineas += "--- USUARIOS LOCALES ---"
                $lineas += "  {0,-22} {1,-14} {2,-12} {3}" -f "NOMBRE","ROL","ESTADO","CLAVE"
                $lineas += "  " + ("-" * 60)
                foreach ($u in $usuarios) {
                    $rol    = if ($admins -contains $u.Name) { "Admin" } else { "Estandar" }
                    $estado = if ($u.Enabled) { "Activa" } else { "Desactivada" }
                    $clave  = if ($u.PasswordRequired) { "Requerida" } else { "No req." }
                    $lineas += "  {0,-22} {1,-14} {2,-12} {3}" -f $u.Name, $rol, $estado, $clave
                }
                $lineas += ""
                $lineas += "--- POLITICA DE CONTRASENAS ---"
                $politica | ForEach-Object { $lineas += "  $_" }
                $lineas += ""
                $lineas += "=========================================================="
                $lineas += "  Informe generado por Atlas PC Support Security Suite v3.0"
                $lineas += "=========================================================="

                $rutaInforme = "$env:USERPROFILE\Desktop\Informe_Seguridad_$(Get-Date -Format 'yyyyMMdd_HHmm').txt"
                $lineas | Out-File -FilePath $rutaInforme -Encoding UTF8
                Escribir-Centrado "Informe guardado en:" "Green"
                Escribir-Centrado $rutaInforme "White"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "8" { Exit }
    }

} while ($true)
}


# ---- tools\Invoke-Personalizacion.ps1 ----
# ============================================================
# Invoke-Personalizacion
# Migrado de: MOD.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-Personalizacion {
    [CmdletBinding()]
    param()
<#
    .SYNOPSIS
    ATLAS PC SUPPORT - CORE LOGIC
    .DESCRIPTION
    Implementación técnica de personalización vía Registro y API Win32.
#>

# ==========================================
# CONFIGURACION INICIAL Y API
# ==========================================
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - PERSONALIZACION AVANZADA"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

# Definición C# para llamar a SystemParametersInfo (EL TRUCO para el Wallpaper)
$code = @'
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    public const int SPI_SETDESKWALLPAPER = 0x0014;
    public const int SPIF_UPDATEINIFILE = 0x01;
    public const int SPIF_SENDWININICHANGE = 0x02;

    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
'@
Add-Type -TypeDefinition $code

# ==========================================
# FUNCIONES DE INTERFAZ (UI)
# ==========================================
function Write-Centered {
    param([string]$Text, [ConsoleColor]$Color = "White")
    $WindowWidth = $Host.UI.RawUI.WindowSize.Width
    $Padding = [math]::Max(0, [int](($WindowWidth - $Text.Length) / 2))
    Write-Host (" " * $Padding) -NoNewline
    Write-Host $Text -ForegroundColor $Color
}

function Show-Header {
    Clear-Host
    Write-Host "`n"
    Write-Centered "==========================================" "Yellow"
    Write-Centered "          ATLAS PC SUPPORT                " "Yellow"
    Write-Centered "==========================================" "Yellow"
    Write-Host "`n"
}

# ==========================================
# FUNCIONES LOGICAS (EL CEREBRO)
# ==========================================

# 1. Fondo de Pantalla (API SystemParametersInfo)
function Set-AtlasWallpaper {
    param([string]$PathImagen)
    if (Test-Path $PathImagen) {
        try {
            [Wallpaper]::SystemParametersInfo(0x0014, 0, $PathImagen, 0x01 -bor 0x02)
            Write-Centered "Fondo aplicado correctamente (API Win32)." "Green"
        } catch {
            Write-Centered "Error al llamar a la API." "Red"
        }
    } else {
        Write-Centered "Error: No se encuentra la imagen en: $PathImagen" "Red"
    }
}

# 2. Tema Oscuro (Registro)
function Set-DarkTheme {
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        Set-ItemProperty -Path $RegPath -Name "AppsUseLightTheme" -Value 0 -Force
        Set-ItemProperty -Path $RegPath -Name "SystemUsesLightTheme" -Value 0 -Force
        Write-Centered "Tema Oscuro aplicado." "Green"
    } catch { Write-Centered "Error al aplicar tema." "Red" }
}

# 4. Color de Acento (Registro DWM)
function Set-AccentColor {
    # Establece un color Cian/Turquesa estilo Atlas (Formato ABGR Decimal o Hex)
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\DWM"
        # 0xffd700 es dorado en formato DWORD (ejemplo)
        Set-ItemProperty -Path $RegPath -Name "AccentColor" -Value 0xffd700 -Force 
        Set-ItemProperty -Path $RegPath -Name "ColorPrevalence" -Value 1 -Force
        Write-Centered "Color de acento modificado." "Green"
    } catch { Write-Centered "Error en DWM." "Red" }
}

# 5. Barra de Tareas (Registro Explorer)
function Optimize-Taskbar {
    try {
        $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        # TaskbarAl: 0 = Izquierda, 1 = Centro (Windows 11)
        Set-ItemProperty -Path $RegPath -Name "TaskbarAl" -Value 0 -Force
        # Ocultar iconos de busqueda para limpiar
        Set-ItemProperty -Path $RegPath -Name "SearchboxTaskbarMode" -Value 0 -Force
        Write-Centered "Configuracion de barra de tareas aplicada." "Green"
        Write-Centered "Reiniciando Explorer..." "Yellow"
        Stop-Process -Name "explorer" -Force
    } catch { Write-Centered "Error en Taskbar." "Red" }
}

# 6. Marca de Agua (Registro Seguro)
function Toggle-Watermark {
    try {
        $RegPath = "HKCU:\Control Panel\Desktop"
        # PaintDesktopVersion: 1 = Mostrar versión, 0 = Ocultar
        Set-ItemProperty -Path $RegPath -Name "PaintDesktopVersion" -Value 0 -Force
        Write-Centered "Marca de agua deshabilitada (Requiere reinicio)." "Green"
    } catch { Write-Centered "Error en registro." "Red" }
}

# ==========================================
# BUCLE PRINCIPAL
# ==========================================
$ejecutar = $true
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

while ($ejecutar) {
    Show-Header
    Write-Centered "MENU AVANZADO DE PERSONALIZACION" "Cyan"
    Write-Host "`n"

    $M = " " * ([int](($Host.UI.RawUI.WindowSize.Width / 2) - 20))
    
    Write-Host "$M [1] Cambiar Fondo (Wallpaper.jpg local)"
    Write-Host "$M [2] Forzar Tema Oscuro (Apps & Sistema)"
    Write-Host "$M [3] Aplicar Color Acento ATLAS (Dorado)"
    Write-Host "$M [4] Alinear Barra Tareas a la Izquierda"
    Write-Host "$M [5] Ocultar Marca de Agua (PaintDesktop)"
    Write-Host "$M [6] Configurar Menu Inicio (Limpieza)"
    Write-Host "`n"
    Write-Host "$M [0] Volver / Salir" -ForegroundColor Gray
    Write-Host "`n"
    Write-Centered "Seleccione opcion:" "Gray"

    $sel = Read-Host

    switch ($sel) {
        '1' { 
            # Busca una imagen llamada 'wallpaper.jpg' en la misma carpeta del script
            Set-AtlasWallpaper -PathImagen "$ScriptPath\wallpaper.jpg" 
            Start-Sleep 2
        }
        '2' { Set-DarkTheme; Start-Sleep 1 }
        '3' { Set-AccentColor; Start-Sleep 1 }
        '4' { Optimize-Taskbar; Start-Sleep 2 }
        '5' { Toggle-Watermark; Start-Sleep 1 }
        '6' {
             # Ejemplo simple para Menu Inicio
             Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0 -Force
             Write-Centered "Sugerencias de inicio deshabilitadas." "Green"
             Start-Sleep 1
        }
        '0' { $ejecutar = $false }
    }
}
}


# ---- tools\Invoke-RAMInfo.ps1 ----
# ============================================================
# Invoke-RAMInfo
# Migrado de: RAM1.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-RAMInfo {
    [CmdletBinding()]
    param()
# ==========================================================
# DIAGNOSTICO DE MEMORIA RAM AVANZADO - ATLAS PC SUPPORT
# ==========================================================

# Variable para acumular el reporte en texto plano
$ReporteTexto = ""

# Funcion auxiliar para escribir en pantalla Y guardar en memoria
function Log-Out {
    param (
        [string]$Mensaje,
        [string]$Color = "White",
        [switch]$NoNewLine
    )
    
    # 1. Escribir en consola con color
    if ($NoNewLine) {
        Write-Host $Mensaje -ForegroundColor $Color -NoNewline
    } else {
        Write-Host $Mensaje -ForegroundColor $Color
    }

    # 2. Guardar en variable para el reporte TXT
    $script:ReporteTexto += $Mensaje
    if (-not $NoNewLine) { $script:ReporteTexto += "`r`n" }
}

Clear-Host
Log-Out "==================================" "Cyan"
Log-Out " REPORTE DE HARDWARE DE MEMORIA RAM" "Cyan"
Log-Out " Fecha: $(Get-Date -Format 'yyyy-MM-dd HH:mm')" "Gray"
Log-Out "==================================" "Cyan"

# --- OBTENCION DE DATOS ---
try {
    $placa = Get-CimInstance Win32_PhysicalMemoryArray -ErrorAction Stop
    $modulos = Get-CimInstance Win32_PhysicalMemory -ErrorAction Stop
} catch {
    Log-Out "[ERROR] No se pudo acceder al hardware. Ejecuta como Administrador." "Red"
    Pause
    return
}

# --- SECCION A: RESUMEN DE LA PLACA ---
Log-Out "`n[A] CAPACIDAD DE LA PLACA BASE" "Yellow"

if ($placa.MaxCapacity -gt 0) {
    # Calculo seguro compatible con PS 5.1
    $maxGB = [math]::Round(($placa.MaxCapacity / 1024 / 1024), 0)
} else {
    $maxGB = "Desconocido (BIOS Legacy)"
}

$slotsUsados = $modulos.Count
$slotsTotales = $placa.MemoryDevices

Log-Out "Slots Totales:      $slotsTotales"
Log-Out "Slots Ocupados:     $slotsUsados"
Log-Out "Maximo Soportado:   $maxGB GB" "Green"

# --- SECCION B: DETALLE POR MODULO ---
Log-Out "`n[B] DETALLE TECNICO POR MODULO" "Yellow"

# Array para guardar objetos (HTML)
$DatosHTML = @()

foreach ($ram in $modulos) {
    $voltaje = $ram.ConfiguredVoltage / 1000
    
    # Logica de velocidad corregida para PS 5.1
    $estadoVelocidad = "Optimo"
    if ($ram.ConfiguredClockSpeed -lt $ram.Speed) {
        $estadoVelocidad = "BAJA VELOCIDAD (XMP Apagado?)"
    }

    Log-Out "-----------------------------------"
    Log-Out "Ubicacion:        $($ram.DeviceLocator)" "Cyan"
    Log-Out "Fabricante:       $($ram.Manufacturer)"
    Log-Out "Capacidad:        $([math]::Round($ram.Capacity / 1GB, 0)) GB"
    Log-Out "Part Number:      $($ram.PartNumber)"
    Log-Out "Velocidad:        $($ram.ConfiguredClockSpeed) MHz (Nativo: $($ram.Speed) MHz)"
    
    # CORRECCION AQUI: Usamos IF clasico en lugar de ?
    if ($estadoVelocidad -eq "Optimo") {
        Log-Out "Estado Vel.:      $estadoVelocidad" "Green"
    } else {
        Log-Out "Estado Vel.:      $estadoVelocidad" "Red"
    }

    Log-Out "Voltaje:          $voltaje V"
    
    # Guardar objeto para HTML
    $ObjTemp = New-Object PSObject -Property @{
        Ubicacion   = $ram.DeviceLocator
        Fabricante  = $ram.Manufacturer
        Capacidad   = "$([math]::Round($ram.Capacity / 1GB, 0)) GB"
        Velocidad   = "$($ram.ConfiguredClockSpeed) MHz"
        Voltaje     = "$voltaje V"
        PartNumber  = $ram.PartNumber
    }
    $DatosHTML += $ObjTemp
}

Log-Out "`n=================================="

# --- MENU DE EXPORTACION ---
Write-Host "`nQue deseas hacer con este reporte?" -ForegroundColor Yellow
Write-Host " [1] Guardar en TXT (Bloc de notas)"
Write-Host " [2] Guardar en HTML (Navegador - Recomendado)"
Write-Host " [3] Salir"

$opcion = Read-Host "`n Elige una opcion"

$NombreBase = "ReporteRAM_$(Get-Date -Format 'yyyyMMdd_HHmm')"
$RutaEscritorio = [Environment]::GetFolderPath("Desktop")

switch ($opcion) {
    "1" { 
        $RutaFinal = "$RutaEscritorio\$NombreBase.txt"
        $ReporteTexto | Out-File -FilePath $RutaFinal -Encoding UTF8
        Write-Host "`n[OK] Reporte guardado en el Escritorio: $NombreBase.txt" -ForegroundColor Green
    }
    "2" { 
        $RutaFinal = "$RutaEscritorio\$NombreBase.html"
        
        # Generar HTML simple
        $Estilo = "<style>body{font-family:Segoe UI, sans-serif; background:#f0f0f0; padding:20px} h2{color:#0078D7} table{border-collapse:collapse; width:100%; background:white} th, td{border:1px solid #ddd; padding:8px; text-align:left} th{background-color:#0078D7; color:white} .info{background:#fff; padding:15px; border-radius:5px; margin-bottom:20px}</style>"
        $Encabezado = "<h2>Reporte ATLAS PC SUPPORT - Memoria RAM</h2><div class='info'><p><b>Fecha:</b> $(Get-Date)</p><p><b>Maximo Soportado:</b> $maxGB GB</p></div>"
        
        # ConvertTo-Html compatible con PS 5.1
        $CuerpoTabla = $DatosHTML | Select-Object Ubicacion, Fabricante, Capacidad, Velocidad, Voltaje, PartNumber | ConvertTo-Html -Fragment
        $HTMLFinal = "<html><head><title>Reporte RAM</title>$Estilo</head><body>$Encabezado $CuerpoTabla</body></html>"
        
        $HTMLFinal | Out-File -FilePath $RutaFinal -Encoding UTF8
        Write-Host "`n[OK] Reporte HTML generado en el Escritorio." -ForegroundColor Green
        Start-Process $RutaFinal
    }
    Default { Write-Host "Saliendo..." }
}
}


# ---- tools\Invoke-Robocopy.ps1 ----
# ============================================================
# Invoke-Robocopy
# Migrado de: Robocopy.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-Robocopy {
    [CmdletBinding()]
    param()
# ========================================================
# ATLAS PC SUPPORT - COPIA INTELIGENTE v8 (PowerShell)
# Auto-detect + MD5 + Speed + ETA + Exclusiones + Modos
# ========================================================

# SIN auto-elevación: robocopy no necesita admin
# y la elevación BLOQUEA el drag-and-drop de Windows

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Gray"
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - Copia Inteligente v8"
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(110, 45) } catch {}
$ErrorActionPreference = "Continue"

# ==================== FUNCIONES ====================

function Write-Centered {
    param ([string]$Text, [string]$Color = "White")
    $W = try { $Host.UI.RawUI.WindowSize.Width } catch { 80 }
    $Pad = [math]::Max(0, [math]::Floor(($W - $Text.Length) / 2))
    Write-Host (" " * $Pad + $Text) -ForegroundColor $Color
}

function Clean-Path {
    param([string]$RawPath)
    return $RawPath.Trim().Trim('"').Trim("'").TrimEnd('\')
}

function Format-Size {
    param([long]$Bytes)
    if ($Bytes -ge 1GB) { return "{0:N2} GB" -f ($Bytes / 1GB) }
    if ($Bytes -ge 1MB) { return "{0:N1} MB" -f ($Bytes / 1MB) }
    if ($Bytes -ge 1KB) { return "{0:N0} KB" -f ($Bytes / 1KB) }
    return "$Bytes B"
}

function Format-Duration {
    param([TimeSpan]$Duration)
    if ($Duration.TotalHours -ge 1) { return "{0}h {1}m {2}s" -f [int]$Duration.TotalHours, $Duration.Minutes, $Duration.Seconds }
    if ($Duration.TotalMinutes -ge 1) { return "{0}m {1}s" -f [int]$Duration.TotalMinutes, $Duration.Seconds }
    return "{0:N1}s" -f $Duration.TotalSeconds
}

function Get-FolderStats {
    param([string]$Path)
    $items = Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue
    $totalSize = ($items | Measure-Object Length -Sum -ErrorAction SilentlyContinue).Sum
    if (-not $totalSize) { $totalSize = 0 }
    return @{ Files = $items.Count; Size = $totalSize; SizeMB = [math]::Round($totalSize / 1MB, 1) }
}

function Detect-DriveType {
    param([string]$DriveLetter)
    $letter = $DriveLetter.TrimEnd(':', '\')
    try {
        $vol = Get-Volume -DriveLetter $letter -ErrorAction Stop
        if ($vol.DriveType -eq 'Removable') {
            return @{ Type = "USB"; MT = 2; Desc = "USB Removible"; Color = "Yellow"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
        }
        $part = Get-Partition -DriveLetter $letter -ErrorAction Stop
        $disk = Get-Disk -Number $part.DiskNumber -ErrorAction Stop
        $phys = Get-PhysicalDisk -ErrorAction SilentlyContinue | Where-Object { $_.DeviceId -eq $disk.Number.ToString() }

        if ($disk.BusType -eq 'USB') {
            return @{ Type = "USB"; MT = 2; Desc = "USB Externo"; Color = "Yellow"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
        }
        if ($disk.BusType -eq 'NVMe' -or ($phys -and $phys.MediaType -match 'SSD')) {
            return @{ Type = "SSD"; MT = 32; Desc = "SSD/NVMe"; Color = "Green"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
        }
        return @{ Type = "HDD"; MT = 8; Desc = "HDD Mecanico"; Color = "Cyan"; Label = $vol.FileSystemLabel; FreeBytes = $vol.SizeRemaining }
    } catch {
        return @{ Type = "UNKNOWN"; MT = 8; Desc = "No detectado"; Color = "Gray"; Label = ""; FreeBytes = 0 }
    }
}

# ==================== EXPLORADOR DE ARCHIVOS (alternativa a drag-drop) ====================

function Select-FolderDialog {
    param([string]$Description = "Selecciona una carpeta")
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = $Description
    $dialog.ShowNewFolderButton = $true
    $result = $dialog.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $dialog.SelectedPath
    }
    return $null
}

function Select-FileDialog {
    param([string]$Title = "Selecciona un archivo")
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Title = $Title
    $dialog.Filter = "Todos los archivos (*.*)|*.*"
    $dialog.Multiselect = $false
    $result = $dialog.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $dialog.FileName
    }
    return $null
}

function Get-PathFromUser {
    param([string]$Prompt = "ORIGEN", [string]$Mode = "any")
    
    Write-Host ""
    Write-Host "  ARRASTRA aqui, escribe la ruta, o usa el explorador:" -ForegroundColor White
    Write-Host "      [E] Abrir explorador de archivos" -ForegroundColor Cyan
    Write-Host "      [B] Volver  [S] Salir" -ForegroundColor DarkGray
    Write-Host ""
    $input = Read-Host "      ${Prompt}"
    
    if ($input -eq "S" -or $input -eq "s") { return "EXIT" }
    if ($input -eq "B" -or $input -eq "b") { return "BACK" }
    
    if ($input -eq "E" -or $input -eq "e") {
        if ($Mode -eq "folder") {
            $path = Select-FolderDialog -Description "Selecciona carpeta de ${Prompt}"
        } else {
            # Preguntar si carpeta o archivo
            Write-Host "      [1] Carpeta  [2] Archivo" -ForegroundColor White
            $tipo = Read-Host "      >"
            if ($tipo -eq "2") {
                $path = Select-FileDialog -Title "Selecciona archivo"
            } else {
                $path = Select-FolderDialog -Description "Selecciona carpeta"
            }
        }
        if (-not $path) { return "BACK" }
        return $path
    }
    
    return Clean-Path $input
}

# ==================== VERIFICACIÓN MD5 ====================

function Test-CopyIntegrity {
    param([string]$Origen, [string]$Destino, [int]$SampleSize = 15)

    Write-Host ""
    Write-Centered "VERIFICANDO INTEGRIDAD..." "Yellow"
    Write-Host ""

    $srcStats = Get-FolderStats $Origen
    $dstStats = Get-FolderStats $Destino

    Write-Host "    Archivos - Origen: $($srcStats.Files) | Destino: $($dstStats.Files)" -ForegroundColor Gray
    Write-Host "    Tamano   - Origen: $(Format-Size $srcStats.Size) | Destino: $(Format-Size $dstStats.Size)" -ForegroundColor Gray

    $countMatch = ($srcStats.Files -eq $dstStats.Files)
    $countColor = if ($countMatch) { "Green" } else { "Yellow" }
    Write-Host "    Conteo:  $(if ($countMatch) { 'COINCIDE' } else { 'DIFERENTE (normal si se excluyeron archivos)' })" -ForegroundColor $countColor

    Write-Host ""
    Write-Host "    Verificacion MD5 (muestra de ${SampleSize})..." -ForegroundColor DarkGray

    $srcFiles = Get-ChildItem -Path $Origen -Recurse -File -ErrorAction SilentlyContinue
    if (-not $srcFiles -or $srcFiles.Count -eq 0) {
        Write-Host "    Sin archivos para verificar." -ForegroundColor Gray
        return @{ OK = $true; Checked = 0; Passed = 0; Failed = 0; Missing = 0 }
    }

    $bySize = $srcFiles | Sort-Object Length -Descending | Select-Object -First 5
    $byDate = $srcFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 5
    $randomCount = [math]::Min([math]::Max(1, $SampleSize - 10), $srcFiles.Count)
    $random = $srcFiles | Get-Random -Count $randomCount
    $sample = @($bySize) + @($byDate) + @($random) | Sort-Object FullName -Unique | Select-Object -First $SampleSize

    $checked = 0; $passed = 0; $failed = 0; $missing = 0; $failedFiles = @()

    foreach ($srcFile in $sample) {
        $checked++
        $relPath = $srcFile.FullName.Substring($Origen.Length).TrimStart('\')
        $dstFile = Join-Path $Destino $relPath

        $pct = [math]::Round(($checked / $sample.Count) * 100, 0)
        Write-Host "`r    [${pct}%] Verificando ${checked}/$($sample.Count)..." -NoNewline -ForegroundColor DarkGray

        if (-not (Test-Path $dstFile)) {
            $missing++; $failedFiles += "FALTA: ${relPath}"; continue
        }
        try {
            $hashSrc = (Get-FileHash -Path $srcFile.FullName -Algorithm MD5 -ErrorAction Stop).Hash
            $hashDst = (Get-FileHash -Path $dstFile -Algorithm MD5 -ErrorAction Stop).Hash
            if ($hashSrc -eq $hashDst) { $passed++ }
            else { $failed++; $failedFiles += "CORRUPTO: ${relPath}" }
        } catch { $failed++; $failedFiles += "ERROR: ${relPath}" }
    }

    Write-Host ""; Write-Host ""

    if ($failed -eq 0 -and $missing -eq 0) {
        Write-Host "    [OK] INTEGRIDAD MD5: ${passed}/${checked} archivos verificados" -ForegroundColor Green
    } else {
        Write-Host "    [!!] PROBLEMAS: OK=${passed} | FALLOS=${failed} | FALTANTES=${missing}" -ForegroundColor Red
        foreach ($f in $failedFiles) { Write-Host "         $f" -ForegroundColor Red }
    }

    return @{ OK = ($failed -eq 0 -and $missing -eq 0); Checked = $checked; Passed = $passed; Failed = $failed; Missing = $missing }
}

# ==================== COPIA CON MONITOREO ====================

function Start-SmartCopy {
    param(
        [string]$Origen, [string]$Destino, [bool]$IsFile, [string]$FileName,
        [int]$MT, [string]$DiskType, [string]$Mode,
        [array]$ExcludeDirs, [array]$ExcludeFiles
    )

    Write-Host ""
    Write-Centered "COPIANDO... (${DiskType} | MT:${MT} | ${Mode})" "Yellow"
    Write-Host ""

    $sw = [System.Diagnostics.Stopwatch]::StartNew()

    $roboArgs = @()
    if ($IsFile) {
        $srcDir = Split-Path $Origen -Parent
        $roboArgs += "`"${srcDir}`""
        $roboArgs += "`"${Destino}`""
        $roboArgs += "`"${FileName}`""
    } else {
        $roboArgs += "`"${Origen}`""
        $roboArgs += "`"${Destino}`""
        $roboArgs += "/E"
    }

    $roboArgs += "/J"; $roboArgs += "/MT:${MT}"; $roboArgs += "/R:2"; $roboArgs += "/W:2"
    $roboArgs += "/FFT"; $roboArgs += "/ETA"; $roboArgs += "/NP"; $roboArgs += "/TEE"; $roboArgs += "/DCOPY:DAT"

    if (-not $IsFile) {
        $roboArgs += "/XJ"
        if ($Mode -eq "INCREMENTAL") { $roboArgs += "/XO" }
    }

    $logFile = Join-Path ([Environment]::GetFolderPath("Desktop")) "Log_Atlas_$(Get-Date -Format 'yyyy-MM-dd_HHmm').txt"
    $roboArgs += "/LOG+:`"${logFile}`""

    $defaultXD = @("System Volume Information", "`$RECYCLE.BIN", "Recovery")
    $allXD = $defaultXD + $ExcludeDirs
    if ($allXD.Count -gt 0 -and -not $IsFile) {
        $roboArgs += "/XD"
        foreach ($xd in $allXD) { $roboArgs += "`"${xd}`"" }
    }

    $defaultXF = @("Pagefile.sys", "Hiberfil.sys", "swapfile.sys", "Thumbs.db")
    $allXF = $defaultXF + $ExcludeFiles
    if ($allXF.Count -gt 0 -and -not $IsFile) {
        $roboArgs += "/XF"
        foreach ($xf in $allXF) { $roboArgs += "`"${xf}`"" }
    }

    $argString = $roboArgs -join " "

    $preSize = 0
    if (Test-Path $Destino) {
        try { $preSize = (Get-ChildItem $Destino -Recurse -File -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum } catch {}
        if (-not $preSize) { $preSize = 0 }
    }

    $process = Start-Process -FilePath "robocopy" -ArgumentList $argString -NoNewWindow -PassThru -Wait
    $exitCode = $process.ExitCode
    $sw.Stop(); $elapsed = $sw.Elapsed

    $postSize = 0
    if (Test-Path $Destino) {
        try { $postSize = (Get-ChildItem $Destino -Recurse -File -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum } catch {}
        if (-not $postSize) { $postSize = 0 }
    }
    $bytesCopied = [math]::Max(0, $postSize - $preSize)
    $speedMBps = if ($elapsed.TotalSeconds -gt 0) { [math]::Round(($bytesCopied / 1MB) / $elapsed.TotalSeconds, 1) } else { 0 }

    Write-Host ""
    Write-Host "    ========================================================" -ForegroundColor White
    $resultMsg = switch ($exitCode) {
        0 { "SIN CAMBIOS - Todo ya estaba copiado" }
        1 { "COPIADO EXITOSAMENTE" }
        2 { "Archivos extras en destino" }
        3 { "Copiado + extras en destino" }
        4 { "Algunos archivos no coinciden" }
        5 { "Copiado + no coincidencias" }
        default { if ($exitCode -le 7) { "Completado (codigo ${exitCode})" } else { "ERROR (codigo ${exitCode})" } }
    }
    $resultColor = if ($exitCode -le 3) { "Green" } elseif ($exitCode -le 7) { "Yellow" } else { "Red" }

    Write-Host "    RESULTADO: ${resultMsg}" -ForegroundColor $resultColor
    Write-Host "    ========================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "    Tiempo:    $(Format-Duration $elapsed)" -ForegroundColor Gray
    Write-Host "    Copiado:   $(Format-Size $bytesCopied)" -ForegroundColor Gray
    Write-Host "    Velocidad: ${speedMBps} MB/s" -ForegroundColor Gray
    Write-Host "    Log:       $(Split-Path $logFile -Leaf)" -ForegroundColor DarkGray

    return @{
        ExitCode = $exitCode; OK = ($exitCode -le 7); Elapsed = $elapsed
        BytesCopied = $bytesCopied; SpeedMBps = $speedMBps; LogFile = $logFile
    }
}

# ==================== BUCLE PRINCIPAL ====================

do {
    Clear-Host
    Write-Host "`n"
    Write-Centered "==========================================================" "Cyan"
    Write-Centered "|     ATLAS PC SUPPORT - COPIA INTELIGENTE v8            |" "Yellow"
    Write-Centered "==========================================================" "Cyan"
    Write-Host ""

    # =============================================
    # PASO 1: ORIGEN
    # =============================================
    $origen = $null; $isFile = $false; $srcName = ""; $srcStats = $null

    :askSource while ($true) {
        Write-Host ""
        Write-Host "  [1] ORIGEN (arrastra, escribe ruta, o explorador):" -ForegroundColor White
        
        $pathResult = Get-PathFromUser -Prompt "ORIGEN" -Mode "any"
        
        if ($pathResult -eq "EXIT") { exit }
        if ($pathResult -eq "BACK") { break }
        
        if (-not (Test-Path $pathResult)) {
            Write-Host "      [ERROR] No existe: ${pathResult}" -ForegroundColor Red
            continue
        }

        $origen = $pathResult
        $isFile = -not (Test-Path $origen -PathType Container)

        if ($isFile) {
            $srcFileObj = Get-Item $origen
            $srcName = $srcFileObj.Name
            $srcStats = @{ Files = 1; Size = $srcFileObj.Length; SizeMB = [math]::Round($srcFileObj.Length / 1MB, 1) }
            Write-Host ""
            Write-Host "      [OK] ARCHIVO: ${srcName} ($(Format-Size $srcFileObj.Length))" -ForegroundColor Green
        } else {
            $srcName = Split-Path $origen -Leaf
            Write-Host "      Escaneando..." -ForegroundColor DarkGray
            $srcStats = Get-FolderStats $origen
            Write-Host "      [OK] CARPETA: ${srcName}" -ForegroundColor Green
            Write-Host "      $($srcStats.Files) archivos | $(Format-Size $srcStats.Size)" -ForegroundColor Gray
        }
        break
    }

    if (-not $origen) { continue }

    # =============================================
    # PASO 2: DESTINO
    # =============================================
    $destino = $null; $driveInfo = $null

    :askDest while ($true) {
        Write-Host ""
        Write-Host "  [2] DESTINO:" -ForegroundColor White
        
        $pathResult = Get-PathFromUser -Prompt "DESTINO" -Mode "folder"
        
        if ($pathResult -eq "EXIT") { exit }
        if ($pathResult -eq "BACK") { break }
        
        $destBase = $pathResult
        if (-not (Test-Path $destBase)) {
            Write-Host "      [ERROR] No accesible: ${destBase}" -ForegroundColor Red
            continue
        }

        try {
            $fullOrigen = (Resolve-Path $origen).Path
            $fullDest = (Resolve-Path $destBase).Path
            if ($fullOrigen -eq $fullDest) {
                Write-Host "      [ERROR] Origen y destino son iguales!" -ForegroundColor Red
                continue
            }
            if ($fullDest.StartsWith($fullOrigen + "\")) {
                Write-Host "      [ERROR] Destino dentro del origen = recursion!" -ForegroundColor Red
                continue
            }
        } catch {}

        $destDriveLetter = $destBase.Substring(0, 1)
        $driveInfo = Detect-DriveType $destDriveLetter

        $labelDisplay = if ($driveInfo.Label) { " ($($driveInfo.Label))" } else { "" }
        Write-Host "      [OK] Disco: $($driveInfo.Desc)${labelDisplay}" -ForegroundColor $driveInfo.Color
        Write-Host "      Libre: $(Format-Size $driveInfo.FreeBytes)" -ForegroundColor Gray

        if ($driveInfo.FreeBytes -gt 0 -and $srcStats.Size -gt $driveInfo.FreeBytes) {
            Write-Host ""
            Write-Host "      [!!!] ESPACIO INSUFICIENTE" -ForegroundColor Red
            Write-Host "      Necesitas: $(Format-Size $srcStats.Size) | Disponible: $(Format-Size $driveInfo.FreeBytes)" -ForegroundColor Red
            Write-Host "      [F] Forzar  [B] Volver" -ForegroundColor Yellow
            $espOp = Read-Host "      >"
            if ($espOp -ne "F" -and $espOp -ne "f") { continue }
        }

        $destino = $destBase
        break
    }

    if (-not $destino) { continue }

    # =============================================
    # PASO 3: NOMBRE
    # =============================================
    Write-Host ""
    Write-Host "  [3] Nombre del proyecto (ENTER = Respaldo):" -ForegroundColor White
    $cliente = Read-Host "      NOMBRE"
    if ([string]::IsNullOrWhiteSpace($cliente)) { $cliente = "Respaldo" }
    $cliente = $cliente -replace '[\\/:*?"<>|]', '_'

    $fechaHoy = Get-Date -Format 'yyyy-MM-dd'
    $rutaFinal = Join-Path $destino "${cliente}_${fechaHoy}"

    # =============================================
    # PASO 4: MODO
    # =============================================
    Write-Host ""
    Write-Host "  [4] MODO DE COPIA:" -ForegroundColor Cyan
    Write-Host "      [1] COMPLETA - Copia todo (primera vez)" -ForegroundColor White
    Write-Host "      [2] INCREMENTAL - Solo nuevos/modificados" -ForegroundColor White
    Write-Host "      [B] Volver" -ForegroundColor DarkGray
    Write-Host ""
    $modoSel = Read-Host "      >"
    if ($modoSel -eq "B" -or $modoSel -eq "b") { continue }
    $modo = if ($modoSel -eq "2") { "INCREMENTAL" } else { "COMPLETA" }

    # =============================================
    # PASO 5: EXCLUSIONES
    # =============================================
    $extraXD = @(); $extraXF = @()

    if (-not $isFile) {
        Write-Host ""
        Write-Host "  [5] EXCLUSIONES:" -ForegroundColor Cyan
        Write-Host "      [1] Ninguna (copiar todo)" -ForegroundColor White
        Write-Host "      [2] Temporales (.tmp, .log, .bak, cache)" -ForegroundColor White
        Write-Host "      [3] ISOs y VMs (.iso, .vhd, .wim)" -ForegroundColor White
        Write-Host "      [4] Personalizado (escribir extensiones)" -ForegroundColor White
        Write-Host "      [B] Volver" -ForegroundColor DarkGray
        Write-Host ""
        $exclSel = Read-Host "      >"
        if ($exclSel -eq "B" -or $exclSel -eq "b") { continue }

        switch ($exclSel) {
            "2" {
                $extraXF = @("*.tmp", "*.log", "*.bak", "*.cache", "*.temp", "~*")
                $extraXD = @("Temp", "tmp", "Cache", "__pycache__", "node_modules", ".git")
                Write-Host "      [OK] Excluyendo temporales y cache" -ForegroundColor Green
            }
            "3" {
                $extraXF = @("*.iso", "*.vhd", "*.vhdx", "*.wim", "*.esd", "*.vmdk")
                Write-Host "      [OK] Excluyendo ISOs y VMs" -ForegroundColor Green
            }
            "4" {
                Write-Host "      Extensiones separadas por coma (ej: .mp4,.avi,.mkv):" -ForegroundColor White
                $customExcl = Read-Host "      >"
                if (-not [string]::IsNullOrWhiteSpace($customExcl)) {
                    $extraXF = ($customExcl -split ',') | ForEach-Object {
                        $ext = $_.Trim()
                        if ($ext -notmatch '^\*') { $ext = "*${ext}" }
                        $ext
                    }
                    Write-Host "      [OK] Excluyendo: $($extraXF -join ', ')" -ForegroundColor Green
                }
            }
        }
    }

    # =============================================
    # PASO 6: PREVIEW
    # =============================================
    Clear-Host
    Write-Host "`n"
    Write-Centered "==================== PREVIEW ====================" "White"
    Write-Host ""

    if ($isFile) {
        Write-Host "    TIPO:      Archivo suelto" -ForegroundColor Gray
        Write-Host "    ARCHIVO:   ${srcName}" -ForegroundColor White
        Write-Host "    TAMANO:    $(Format-Size $srcStats.Size)" -ForegroundColor Gray
    } else {
        Write-Host "    TIPO:      Carpeta" -ForegroundColor Gray
        Write-Host "    ORIGEN:    ${srcName}" -ForegroundColor White
        Write-Host "    ARCHIVOS:  $($srcStats.Files) | $(Format-Size $srcStats.Size)" -ForegroundColor Gray
    }

    Write-Host ""
    Write-Host "    DESTINO:   ${rutaFinal}" -ForegroundColor White
    Write-Host "    DISCO:     $($driveInfo.Desc)" -ForegroundColor $driveInfo.Color
    Write-Host "    HILOS:     MT:$($driveInfo.MT) (auto)" -ForegroundColor Gray
    Write-Host "    MODO:      ${modo}" -ForegroundColor Cyan

    if ($extraXF.Count -gt 0 -or $extraXD.Count -gt 0) {
        Write-Host "    EXCLUIR:   $($extraXF.Count) tipo(s) archivo + $($extraXD.Count) carpeta(s)" -ForegroundColor DarkGray
    }

    $avgSpeed = switch ($driveInfo.Type) { "USB" { 25 } "HDD" { 80 } "SSD" { 300 } default { 50 } }
    if ($srcStats.SizeMB -gt 0) {
        $etaSec = $srcStats.SizeMB / $avgSpeed
        $etaSpan = [TimeSpan]::FromSeconds($etaSec)
        Write-Host "    ETA:       ~$(Format-Duration $etaSpan) (estimado para $($driveInfo.Type))" -ForegroundColor DarkGray
    }

    Write-Host ""
    Write-Centered "=================================================" "White"
    Write-Host ""
    Write-Host "    [S] INICIAR COPIA  [B] Volver  [N] Cancelar" -ForegroundColor White
    Write-Host ""
    $confirmar = Read-Host "    >"
    if ($confirmar -ne "S" -and $confirmar -ne "s") { continue }

    # =============================================
    # PASO 7: EJECUTAR
    # =============================================
    Clear-Host
    Write-Host "`n"

    $fileName = if ($isFile) { $srcName } else { "" }

    $result = Start-SmartCopy -Origen $origen -Destino $rutaFinal -IsFile $isFile -FileName $fileName `
        -MT $driveInfo.MT -DiskType $driveInfo.Type -Mode $modo `
        -ExcludeDirs $extraXD -ExcludeFiles $extraXF

    # =============================================
    # PASO 8: VERIFICACION
    # =============================================
    if ($result.OK -and -not $isFile) {
        Write-Host ""
        Write-Host "    Verificar integridad MD5? [S/N]" -ForegroundColor DarkGray
        $verSel = Read-Host "    >"
        if ($verSel -eq "S" -or $verSel -eq "s") {
            $integrity = Test-CopyIntegrity -Origen $origen -Destino $rutaFinal
        }
    }

    # =============================================
    # PASO 9: POST-COPIA
    # =============================================
    :postMenu while ($true) {
        Write-Host ""
        Write-Host "    --------------------------------------------------------" -ForegroundColor DarkGray
        Write-Host "    [A] Abrir carpeta destino" -ForegroundColor Cyan
        Write-Host "    [R] REPETIR con OTRO destino (mismo origen)" -ForegroundColor Green
        Write-Host "    [N] Nueva copia (otro origen)" -ForegroundColor White
        Write-Host "    [L] Ver log" -ForegroundColor DarkGray
        Write-Host "    [S] Salir" -ForegroundColor DarkGray
        Write-Host "    --------------------------------------------------------" -ForegroundColor DarkGray
        Write-Host ""
        $postOp = Read-Host "    >"

        switch ($postOp.ToUpper()) {
            "A" {
                if (Test-Path $rutaFinal) { Invoke-Item $rutaFinal }
                else { Write-Host "    Carpeta no encontrada." -ForegroundColor Red }
            }
            "R" {
                Write-Host ""
                Write-Host "    Nuevo DESTINO:" -ForegroundColor White
                
                $newPath = Get-PathFromUser -Prompt "DESTINO" -Mode "folder"
                if ($newPath -eq "BACK" -or $newPath -eq "EXIT" -or -not $newPath) { continue }
                
                $newDestBase = $newPath
                if (-not (Test-Path $newDestBase)) {
                    Write-Host "    Ruta no accesible." -ForegroundColor Red
                    continue
                }

                $newDriveInfo = Detect-DriveType ($newDestBase.Substring(0, 1))
                $newRutaFinal = Join-Path $newDestBase "${cliente}_${fechaHoy}"

                $newLabelDisplay = if ($newDriveInfo.Label) { " ($($newDriveInfo.Label))" } else { "" }
                Write-Host "    Disco: $($newDriveInfo.Desc)${newLabelDisplay} | MT:$($newDriveInfo.MT)" -ForegroundColor $newDriveInfo.Color
                Write-Host "    Destino: ${newRutaFinal}" -ForegroundColor White
                Write-Host ""
                Write-Host "    [S] Copiar  [N] Cancelar" -ForegroundColor White
                $repConf = Read-Host "    >"

                if ($repConf -eq "S" -or $repConf -eq "s") {
                    Clear-Host; Write-Host "`n"
                    $result2 = Start-SmartCopy -Origen $origen -Destino $newRutaFinal -IsFile $isFile -FileName $fileName `
                        -MT $newDriveInfo.MT -DiskType $newDriveInfo.Type -Mode $modo `
                        -ExcludeDirs $extraXD -ExcludeFiles $extraXF

                    if ($result2.OK -and -not $isFile) {
                        Write-Host ""; Write-Host "    Verificar MD5? [S/N]" -ForegroundColor DarkGray
                        $v2 = Read-Host "    >"
                        if ($v2 -eq "S" -or $v2 -eq "s") { Test-CopyIntegrity -Origen $origen -Destino $newRutaFinal | Out-Null }
                    }
                }
            }
            "N" { break }
            "L" {
                if (Test-Path $result.LogFile) { Start-Process notepad $result.LogFile }
                else { Write-Host "    Log no encontrado." -ForegroundColor Red }
            }
            "S" { exit }
        }

        if ($postOp -eq "N" -or $postOp -eq "n") { break }
    }

} while ($true)
}


# ---- tools\Invoke-SelectorDNS.ps1 ----
# ============================================================
# Invoke-SelectorDNS
# Migrado de: SelectorDNS.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-SelectorDNS {
    [CmdletBinding()]
    param()
# ==============================================================================
# Atlas PC Support - Advanced DNS Selector v2.0
# Bilingue, Navegable, Full-Featured
# Fixes: TryParse guard, ReadKey, Write-Centered fuera del loop,
#        BackgroundColor + Clear-Host inmediato, header box alineado,
#        null-safe adapter check.
# Upscales: DNS status, latency test, custom DNS, per-adapter, backup/restore,
#           more providers, DoH toggle, startup task, activity log, UI polish.
# ==============================================================================

#region ── Inicializacion ─────────────────────────────────────────────────────
[console]::BackgroundColor = "Black"
[console]::ForegroundColor = "White"
Clear-Host  # FIX: Clear inmediato para que el BackgroundColor aplique de una vez

$sysLang = (Get-UICulture).TwoLetterISOLanguageName
$es      = ($sysLang -eq 'es')

$logFile    = Join-Path $PSScriptRoot "dns_log.txt"
$backupFile = Join-Path $PSScriptRoot "dns_backup.json"

#region agent log
$script:AgentDebugLogPaths = @(
    (Join-Path $env:USERPROFILE "debug-aea107.log")
    (Join-Path $PSScriptRoot   "debug-aea107.log")
) | Select-Object -Unique
function Write-AgentDbg {
    param([string]$hypothesisId, [string]$location, [string]$message, [hashtable]$data = @{})
    try {
        $payload = [ordered]@{
            sessionId    = "aea107"
            hypothesisId = $hypothesisId
            location     = $location
            message      = $message
            data         = $data
            timestamp    = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
        }
        $line = $payload | ConvertTo-Json -Compress -Depth 8
        foreach ($p in $script:AgentDebugLogPaths) {
            try { Add-Content -Path $p -Value $line -Encoding UTF8 -ErrorAction Stop } catch { }
        }
    } catch { }
}
Write-AgentDbg -hypothesisId "INIT" -location "SelectorDNS.ps1:post-vars" -message "script_start" -data @{
    HostName = $Host.Name
    PSVer    = $PSVersionTable.PSVersion.ToString()
    PSEd     = $PSVersionTable.PSEdition
    Root     = $PSScriptRoot
    LogPaths = @($script:AgentDebugLogPaths)
}
#endregion
#endregion

#region ── Diccionario Bilingue ───────────────────────────────────────────────
$txt = @{
    # Encabezado
    VerStr       = "v2.0"
    # Opciones DNS
    Opt1         = if ($es) { " 1. DNS Automatico        (Windows por defecto)" }       else { " 1. Automatic DNS         (Windows default)" }
    HeaderCF     = "--- CLOUDFLARE -----------------------------------------------"
    Opt2         = " 2. Basico               (1.1.1.1  | Max Speed)"
    Opt3         = " 3. Avanzado             (1.1.1.2  | Malware Block)"
    Opt4         = " 4. Familiar             (1.1.1.3  | Malware + Adult)"
    HeaderGG     = "--- GOOGLE ---------------------------------------------------"
    Opt5         = " 5. Google DNS           (8.8.8.8  | General Purpose)"
    HeaderQ9     = "--- QUAD9 ----------------------------------------------------"
    Opt6         = " 6. Quad9                (9.9.9.9  | Malware + Privacy)"
    HeaderOD     = "--- OPENDNS --------------------------------------------------"
    Opt7         = " 7. OpenDNS Home         (208.67.222.222 | General)"
    Opt8         = " 8. OpenDNS FamilyShield (208.67.222.123 | Adult Block)"
    HeaderMV     = "--- MULLVAD --------------------------------------------------"
    Opt9         = " 9. Mullvad 1            (194.242.2.2 | Solo DNS Resolver)"
    Opt10        = "10. Mullvad 2            (194.242.2.3 | AdBlock)"
    Opt11        = "11. Mullvad 3            (194.242.2.4 | Ads+Trackers+Adware)"
    Opt12        = "12. Mullvad 4            (194.242.2.5 | Social Media+Molest.)"
    Opt13        = "13. Mullvad 5            (194.242.2.6 | Adult+Gambling)"
    Opt14        = "14. Mullvad 6            (194.242.2.9 | Extreme)"
    HeaderND     = "--- NEXTDNS --------------------------------------------------"
    Opt15        = "15. NextDNS              (45.90.28.0  | Configurable)"
    HeaderCU     = "--- PERSONALIZADO / CUSTOM -----------------------------------"
    Opt16        = if ($es) { "16. DNS Personalizado    (Ingresa tus propias IPs)" }     else { "16. Custom DNS           (Enter your own IPs)" }
    # Herramientas
    HeaderTools  = if ($es) { "===== HERRAMIENTAS =====================================" } else { "===== TOOLS ============================================" }
    Opt17        = if ($es) { "17. Test de Latencia DNS    (Ping a todos los servers)" } else { "17. DNS Latency Test        (Ping all servers)" }
    Opt18        = if ($es) { "18. Backup DNS actual       (Guardar config actual)" }     else { "18. Backup current DNS      (Save current config)" }
    Opt19        = if ($es) { "19. Restaurar desde Backup  (Revertir cambios)" }          else { "19. Restore from Backup     (Revert changes)" }
    Opt20        = if ($es) { "20. Toggle DNS-over-HTTPS   (DoH On/Off)" }                else { "20. Toggle DNS-over-HTTPS   (DoH On/Off)" }
    Opt21        = if ($es) { "21. Persistencia al Inicio  (Tarea Programada)" }          else { "21. Startup Persistence     (Scheduled Task)" }
    Opt22        = if ($es) { "22. Ver Registro            (Ultimas 30 entradas)" }       else { "22. View Activity Log       (Last 30 entries)" }
    Opt23        = if ($es) { "23. Seleccion por Adaptador (Elegir NIC especifica)" }     else { "23. Per-Adapter Selection   (Choose specific NIC)" }
    Opt24        = if ($es) { "24. Test Seguridad DNS      (Cloudflare ESNI browser)" }   else { "24. DNS Security Test       (Cloudflare ESNI browser)" }
    Opt0         = if ($es) { " 0. Salir" }                                               else { " 0. Exit" }
    # Prompts y mensajes
    Prompt       = if ($es) { "Elige una opcion (0-24)" }              else { "Choose an option (0-24)" }
    PromptDNSOpt = if ($es) { "Perfil DNS a aplicar (1-15): " }        else { "DNS profile to apply (1-15): " }
    ErrNoAdap    = if ($es) { "[ERROR] No se encontraron adaptadores." } else { "[ERROR] No adapters found." }
    Applying     = if ($es) { "Aplicando configuracion..." }            else { "Applying configuration..." }
    Opening      = if ($es) { "Abriendo navegador..." }                 else { "Opening browser..." }
    OkAuto       = if ($es) { "-> DNS Automatico" }                     else { "-> Automatic DNS" }
    OkDNS        = if ($es) { "-> Usando" }                             else { "-> Using" }
    ErrInv       = if ($es) { "[ERROR] Opcion no valida." }             else { "[ERROR] Invalid option." }
    ErrBlank     = if ($es) { "[ERROR] Debes ingresar un numero (0-24)." } else { "[ERROR] Enter a number (0-24)." }
    FlushDNS     = if ($es) { "Limpiando cache DNS..." }                else { "Flushing DNS cache..." }
    Done         = if ($es) { "Hecho! Proceso terminado exitosamente." } else { "Done! Process finished successfully." }
    Next         = if ($es) { " Presiona cualquier tecla para volver al menu..." } else { " Press any key to return to menu..." }
    CurrentDNS   = if ($es) { "DNS ACTIVO" }                            else { "ACTIVE DNS" }
    Auto         = if ($es) { "Automatico" }                            else { "Automatic" }
    # Custom DNS
    CustomPrim   = if ($es) { "  DNS Primario   (ej: 8.8.8.8)  : " }   else { "  Primary DNS    (e.g. 8.8.8.8) : " }
    CustomSec    = if ($es) { "  DNS Secundario (ej: 8.8.4.4)  : " }   else { "  Secondary DNS  (e.g. 8.8.4.4) : " }
    CustomApply  = if ($es) { "Aplicar a todos los adaptadores? (s/n) [n = elegir]: " } else { "Apply to all adapters? (y/n) [n = choose]: " }
    # Backup / Restore
    BackupOk     = if ($es) { "[OK] Backup guardado en:" }              else { "[OK] Backup saved to:" }
    BackupNone   = if ($es) { "[ERROR] No se encontro archivo de backup en:" } else { "[ERROR] No backup file found at:" }
    RestoreOk    = if ($es) { "[OK] DNS restaurado desde backup." }     else { "[OK] DNS restored from backup." }
    # Latencia
    PingTesting  = if ($es) { "Probando latencia (3 pings por servidor)..." } else { "Testing latency (3 pings per server)..." }
    Fastest      = if ($es) { "Mas rapido" }                            else { "Fastest" }
    NoResp       = if ($es) { "Sin respuesta" }                         else { "No response" }
    # DoH
    DoHStatus    = if ($es) { "Estado DoH actual:" }                    else { "Current DoH status:" }
    DoHOn        = if ($es) { "ACTIVADO" }                              else { "ENABLED" }
    DoHOff       = if ($es) { "DESACTIVADO" }                          else { "DISABLED" }
    DoHChoose    = if ($es) { "  [1] Activar DoH   [2] Desactivar DoH   [0] Cancelar: " } else { "  [1] Enable DoH   [2] Disable DoH   [0] Cancel: " }
    DoHNote      = if ($es) { "(Requiere reinicio para aplicarse completamente)" } else { "(Restart required for full effect)" }
    # Tarea programada
    TaskExists   = if ($es) { "Ya existe la tarea 'AtlasDNS'. Eliminarla? (s/n): " } else { "Task 'AtlasDNS' already exists. Remove it? (y/n): " }
    TaskCreated  = if ($es) { "[OK] Tarea creada. El DNS se re-aplicara al iniciar sesion." } else { "[OK] Task created. DNS will re-apply on logon." }
    TaskRemoved  = if ($es) { "[OK] Tarea programada eliminada." }      else { "[OK] Scheduled task removed." }
    TaskNone     = if ($es) { "(No hay tarea activa actualmente)" }     else { "(No active task currently)" }
    # Log
    LogEmpty     = if ($es) { "(El registro esta vacio)" }              else { "(The log is empty)" }
    LogPath      = if ($es) { "Archivo: " }                             else { "File: " }
    # Per-adapter
    AdapHeader   = if ($es) { "Adaptadores disponibles:" }              else { "Available adapters:" }
    AdapPrompt   = if ($es) { "  Numero de adaptador o [T]odos: " }    else { "  Adapter number or [A]ll: " }
    AdapAll      = if ($es) { "Todos los adaptadores" }                 else { "All adapters" }
}
#endregion

#region ── Perfiles DNS ──────────────────────────────────────────────────────
$dnsProfiles = [ordered]@{
    '1'  = @{ Label = "Automatic";               Addr = @() }
    '2'  = @{ Label = "Cloudflare Basic";         Addr = @("1.1.1.1","1.0.0.1","2606:4700:4700::1111","2606:4700:4700::1001") }
    '3'  = @{ Label = "Cloudflare Advanced";      Addr = @("1.1.1.2","1.0.0.2","2606:4700:4700::1112","2606:4700:4700::1002") }
    '4'  = @{ Label = "Cloudflare Family";        Addr = @("1.1.1.3","1.0.0.3","2606:4700:4700::1113","2606:4700:4700::1003") }
    '5'  = @{ Label = "Google DNS";               Addr = @("8.8.8.8","8.8.4.4","2001:4860:4860::8888","2001:4860:4860::8844") }
    '6'  = @{ Label = "Quad9";                    Addr = @("9.9.9.9","149.112.112.112","2620:fe::fe","2620:fe::9") }
    '7'  = @{ Label = "OpenDNS Home";             Addr = @("208.67.222.222","208.67.220.220") }
    '8'  = @{ Label = "OpenDNS FamilyShield";     Addr = @("208.67.222.123","208.67.220.123") }
    '9'  = @{ Label = "Mullvad 1 (Resolver)";     Addr = @("194.242.2.2","2a07:e340::2") }
    '10' = @{ Label = "Mullvad 2 (AdBlock)";      Addr = @("194.242.2.3","2a07:e340::3") }
    '11' = @{ Label = "Mullvad 3 (Tracker)";      Addr = @("194.242.2.4","2a07:e340::4") }
    '12' = @{ Label = "Mullvad 4 (Social)";       Addr = @("194.242.2.5","2a07:e340::5") }
    '13' = @{ Label = "Mullvad 5 (Adult)";        Addr = @("194.242.2.6","2a07:e340::6") }
    '14' = @{ Label = "Mullvad 6 (Extreme)";      Addr = @("194.242.2.9","2a07:e340::9") }
    '15' = @{ Label = "NextDNS";                  Addr = @("45.90.28.0","45.90.30.0","2a07:a8c0::","2a07:a8c1::") }
}

# Templates DoH por IP
$dohTemplates = @{
    "1.1.1.1"              = "https://cloudflare-dns.com/dns-query"
    "1.0.0.1"              = "https://cloudflare-dns.com/dns-query"
    "2606:4700:4700::1111" = "https://cloudflare-dns.com/dns-query"
    "2606:4700:4700::1001" = "https://cloudflare-dns.com/dns-query"
    "1.1.1.2"              = "https://security.cloudflare-dns.com/dns-query"
    "1.0.0.2"              = "https://security.cloudflare-dns.com/dns-query"
    "2606:4700:4700::1112" = "https://security.cloudflare-dns.com/dns-query"
    "2606:4700:4700::1002" = "https://security.cloudflare-dns.com/dns-query"
    "1.1.1.3"              = "https://family.cloudflare-dns.com/dns-query"
    "1.0.0.3"              = "https://family.cloudflare-dns.com/dns-query"
    "2606:4700:4700::1113" = "https://family.cloudflare-dns.com/dns-query"
    "2606:4700:4700::1003" = "https://family.cloudflare-dns.com/dns-query"
    "8.8.8.8"              = "https://dns.google/dns-query"
    "8.8.4.4"              = "https://dns.google/dns-query"
    "2001:4860:4860::8888" = "https://dns.google/dns-query"
    "2001:4860:4860::8844" = "https://dns.google/dns-query"
    "9.9.9.9"              = "https://dns.quad9.net/dns-query"
    "149.112.112.112"      = "https://dns.quad9.net/dns-query"
    "2620:fe::fe"          = "https://dns.quad9.net/dns-query"
    "2620:fe::9"           = "https://dns.quad9.net/dns-query"
    "194.242.2.2"          = "https://doh.mullvad.net/dns-query"
    "2a07:e340::2"         = "https://doh.mullvad.net/dns-query"
    "194.242.2.3"          = "https://adblock.doh.mullvad.net/dns-query"
    "2a07:e340::3"         = "https://adblock.doh.mullvad.net/dns-query"
    "194.242.2.4"          = "https://adblock.doh.mullvad.net/dns-query"
    "2a07:e340::4"         = "https://adblock.doh.mullvad.net/dns-query"
    "194.242.2.5"          = "https://adblock.doh.mullvad.net/dns-query"
    "2a07:e340::5"         = "https://adblock.doh.mullvad.net/dns-query"
    "194.242.2.6"          = "https://adblock.doh.mullvad.net/dns-query"
    "2a07:e340::6"         = "https://adblock.doh.mullvad.net/dns-query"
    "194.242.2.9"          = "https://adblock.doh.mullvad.net/dns-query"
    "2a07:e340::9"         = "https://adblock.doh.mullvad.net/dns-query"
    "45.90.28.0"           = "https://dns.nextdns.io/dns-query"
    "45.90.30.0"           = "https://dns.nextdns.io/dns-query"
    "2a07:a8c0::"          = "https://dns.nextdns.io/dns-query"
    "2a07:a8c1::"          = "https://dns.nextdns.io/dns-query"
}

# IPs de referencia para el test de latencia
$latencyTargets = [ordered]@{
    "Cloudflare Basic"      = "1.1.1.1"
    "Cloudflare Advanced"   = "1.1.1.2"
    "Cloudflare Family"     = "1.1.1.3"
    "Google DNS"            = "8.8.8.8"
    "Quad9"                 = "9.9.9.9"
    "OpenDNS Home"          = "208.67.222.222"
    "OpenDNS FamilyShield"  = "208.67.222.123"
    "Mullvad 1"             = "194.242.2.2"
    "Mullvad 2"             = "194.242.2.3"
    "Mullvad 3"             = "194.242.2.4"
    "Mullvad 6 (Extreme)"   = "194.242.2.9"
    "NextDNS"               = "45.90.28.0"
}
#endregion

#region ── Funciones Helper ───────────────────────────────────────────────────

function Write-Centered {
    param([string]$Text, [ConsoleColor]$Color = "White")
    $wProbe = $null
    $probeErr = $null
    try { $wProbe = $Host.UI.RawUI.WindowSize.Width } catch { $probeErr = $_.Exception.Message }
    #region agent log
    Write-AgentDbg -hypothesisId "B" -location "Write-Centered" -message "layout" -data @{ wProbe = $wProbe; textLen = $Text.Length; probeErr = $probeErr }
    #endregion
    $w   = $Host.UI.RawUI.WindowSize.Width
    $pad = [math]::Max(0, [math]::Floor(($w - $Text.Length) / 2))
    Write-Host ((" " * $pad) + $Text) -ForegroundColor $Color
}

function Press-AnyKey {
    Write-Host ""
    Write-Host $txt.Next -ForegroundColor DarkGray
    #region agent log
    try {
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        Write-AgentDbg -hypothesisId "A" -location "Press-AnyKey" -message "readkey_ok" -data @{ host = $Host.Name }
    } catch {
        Write-AgentDbg -hypothesisId "A" -location "Press-AnyKey" -message "readkey_fail" -data @{ host = $Host.Name; ex = $_.Exception.Message; type = $_.Exception.GetType().FullName }
        throw
    }
    #endregion
}

function Write-Log {
    param([string]$Msg)
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$ts | $Msg" | Out-File -FilePath $logFile -Append -Encoding UTF8
}

function Get-PhysicalAdapters {
    return Get-NetAdapter -Physical | Where-Object {
        $_.InterfaceDescription -notmatch "Bluetooth" -and $_.Status -ne "Not Present"
    }
}

function Get-DNSStatusLines {
    $adapters = Get-PhysicalAdapters
    if (-not $adapters) { return @("  (no adapters)") }
    $lines = @()
    foreach ($a in $adapters) {
        $ipv4dns = (Get-DnsClientServerAddress -InterfaceAlias $a.Name -AddressFamily IPv4 -ErrorAction SilentlyContinue).ServerAddresses
        $dnsStr  = if ($ipv4dns) { ($ipv4dns | Select-Object -First 2) -join "  |  " } else { $txt.Auto }
        $status  = if ($a.Status -eq "Up") { "[UP] " } else { "[--] " }
        $color   = if ($a.Status -eq "Up") { "Green" } else { "DarkGray" }
        $lines  += @{ Text = "  $status$($a.Name.PadRight(20)) $dnsStr"; Color = $color }
    }
    return $lines
}

function Register-DoHTemplates {
    # RAIZ DEL BUG ANTERIOR: PowerShell registry provider interpreta '2606:' como
    # PSDrive al parsear rutas con IPv6 (ej: \DoHAddresses\2606:4700::1).
    # Fix: reg.exe llama directamente a la Win32 API — sin ese parsing de rutas,
    # soporta '::' en nombres de clave de registro sin ningun problema.
    param([string[]]$Addresses)
    $base = "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\DoHAddresses"

    foreach ($ip in $Addresses) {
        if (-not $dohTemplates.ContainsKey($ip)) { continue }
        $tmpl = $dohTemplates[$ip]
        & reg add "$base\$ip" /v DohTemplate       /t REG_SZ    /d $tmpl /f 2>&1 | Out-Null
        & reg add "$base\$ip" /v AutoUpgrade        /t REG_DWORD /d 1     /f 2>&1 | Out-Null
        & reg add "$base\$ip" /v AllowFallbackToUdp /t REG_DWORD /d 0     /f 2>&1 | Out-Null
        $ok = ($LASTEXITCODE -eq 0)
        Write-Host "    DoH global [$ip] $(if ($ok) { '[OK]' } else { '[FAIL]' })" `
            -ForegroundColor $(if ($ok) { 'DarkGray' } else { 'Red' })
    }
}

function Set-InterfaceDoH {
    # Usa reg.exe (Win32 API) para evitar el bug de parsing de '::' de PowerShell.
    # Escribe en DOS paths: GUID y Index, por si Windows usa uno u otro segun build.
    param([string]$AdapterName, [string[]]$Addresses)
    try {
        $adapter = Get-NetAdapter -Name $AdapterName -ErrorAction Stop
        $guid    = $adapter.InterfaceGuid    # {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
        $idx     = $adapter.InterfaceIndex   # numero (ej: 5, 12)
        $iscBase = "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters"

        foreach ($ip in $Addresses) {
            if (-not $dohTemplates.ContainsKey($ip)) { continue }
            $tmpl = $dohTemplates[$ip]
            # Intentar con GUID y con Index — Windows usa uno segun version/build
            foreach ($id in @($guid, "$idx")) {
                $p = "$iscBase\$id\DohInterfaceSettings\$ip"
                & reg add $p /v DohTemplate       /t REG_SZ    /d $tmpl /f 2>&1 | Out-Null
                & reg add $p /v AutoUpgrade        /t REG_DWORD /d 1     /f 2>&1 | Out-Null
                & reg add $p /v AllowFallbackToUdp /t REG_DWORD /d 0     /f 2>&1 | Out-Null
            }
            $ok = ($LASTEXITCODE -eq 0)
            Write-Host "    DoH iface [$AdapterName][$ip] $(if ($ok) { '[OK]' } else { '[FAIL]' })" `
                -ForegroundColor $(if ($ok) { 'DarkGray' } else { 'Red' })
        }
    } catch {
        Write-Host "    DoH iface [$AdapterName] [FAIL] $_" -ForegroundColor Red
    }
}

function Apply-DNS {
    param(
        [string[]]$AdapterNames,
        [string[]]$Addresses,
        [string]$Label
    )
    Write-Host ""
    Write-Host "  $($txt.Applying)" -ForegroundColor Cyan

    # PASO 1 — registrar templates DoH globalmente via registro (IPv4 + IPv6)
    if ($Addresses.Count -gt 0) {
        Register-DoHTemplates -Addresses $Addresses
        # Activar DoH automatico: Windows usa los templates para todos los adaptadores
        $dohReg = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
        Set-ItemProperty -Path $dohReg -Name "EnableAutoDoh" -Value 2 -Type DWord `
            -ErrorAction SilentlyContinue
    }

    foreach ($n in $AdapterNames) {
        try {
            if ($Addresses.Count -eq 0) {
                Set-DnsClientServerAddress -InterfaceAlias $n -ResetServerAddresses -ErrorAction Stop
                Write-Host "  [OK] $($n.PadRight(22)) $($txt.OkAuto)" -ForegroundColor Green
                Write-Log "SET | $n | Automatic"
            } else {
                # PASO 2 — asignar IPs (-AddressFamily no existe en WinPS 5.1)
                Set-DnsClientServerAddress -InterfaceAlias $n -ServerAddresses $Addresses `
                    -ErrorAction Stop
                Write-Host "  [OK] $($n.PadRight(22)) $($txt.OkDNS) $Label" -ForegroundColor Green
                Write-Log "SET | $n | $Label | $($Addresses -join ', ')"

                # PASO 3 — escribir config DoH por interfaz via registro (GUID, no nombre)
                Set-InterfaceDoH -AdapterName $n -Addresses $Addresses
            }
        } catch {
            #region agent log
            Write-AgentDbg -hypothesisId "E" -location "Apply-DNS:catch" -message "set_dns_fail" -data @{ adapter = $n; label = $Label; ex = $_.Exception.Message }
            #endregion
            Write-Host "  [FAIL] $n -> $_" -ForegroundColor Red
            Write-Log "FAIL | $n | $Label | $_"
        }
    }

    Write-Host ""
    Write-Host "  $($txt.FlushDNS)" -ForegroundColor DarkGray
    Clear-DnsClientCache
    Write-Host "  $($txt.Done)" -ForegroundColor Green
}

function Select-AdapterNames {
    $all = Get-PhysicalAdapters
    if (-not $all) {
        Write-Host "`n  $($txt.ErrNoAdap)" -ForegroundColor Red
        return $null
    }
    Write-Host ""
    Write-Host "  $($txt.AdapHeader)" -ForegroundColor Cyan
    for ($i = 0; $i -lt $all.Count; $i++) {
        $st    = if ($all[$i].Status -eq "Up") { "[UP]" } else { "[--]" }
        $col   = if ($all[$i].Status -eq "Up") { "White" } else { "DarkGray" }
        Write-Host "  [$($i+1)] $st $($all[$i].Name.PadRight(20)) $($all[$i].InterfaceDescription)" -ForegroundColor $col
    }
    $allKey = if ($es) { "T" } else { "A" }
    Write-Host "  [$allKey] $($txt.AdapAll)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host -NoNewline $txt.AdapPrompt -ForegroundColor Yellow
    $sel = (Read-Host).Trim()
    #region agent log
    $idxTry = 0
    $tpOk = [int]::TryParse($sel, [ref]$idxTry)
    Write-AgentDbg -hypothesisId "D" -location "Select-AdapterNames" -message "adapter_pick" -data @{ sel = $sel; tryParse = $tpOk; idx = $idxTry; adapterCount = $all.Count }
    #endregion
    if ($sel -match "^[TtAa]$") {
        return $all.Name
    }
    $idx = 0
    if ([int]::TryParse($sel, [ref]$idx) -and $idx -ge 1 -and $idx -le $all.Count) {
        return @($all[$idx - 1].Name)
    }
    Write-Host "`n  $($txt.ErrInv)" -ForegroundColor Red
    return $null
}

function Invoke-LatencyTest {
    Write-Host ""
    Write-Host "  $($txt.PingTesting)" -ForegroundColor Cyan
    Write-Host ("  " + ("-" * 58)) -ForegroundColor DarkGray
    Write-Host ("  " + "SERVER".PadRight(26) + "IP".PadRight(18) + "AVG LATENCY") -ForegroundColor DarkGray
    Write-Host ("  " + ("-" * 58)) -ForegroundColor DarkGray
    $results = @()
    foreach ($entry in $latencyTargets.GetEnumerator()) {
        Write-Host -NoNewline "  $($entry.Key.PadRight(26))$($entry.Value.PadRight(18))"
        try {
            $pings = Test-Connection -ComputerName $entry.Value -Count 3 -ErrorAction Stop
            $avg   = [math]::Round(($pings | Measure-Object -Property ResponseTime -Average).Average, 1)
            $bar   = if ($avg -lt 20)  { "Green" }
                     elseif ($avg -lt 60) { "Yellow" }
                     else { "Red" }
            $block = if ($avg -lt 20)  { "[FAST]  " }
                     elseif ($avg -lt 60) { "[OK]    " }
                     else { "[SLOW]  " }
            Write-Host "$block$avg ms" -ForegroundColor $bar
            $results += [PSCustomObject]@{ Name=$entry.Key; IP=$entry.Value; Avg=$avg }
        } catch {
            Write-Host $txt.NoResp -ForegroundColor Red
            $results += [PSCustomObject]@{ Name=$entry.Key; IP=$entry.Value; Avg=99999 }
        }
    }
    Write-Host ("  " + ("-" * 58)) -ForegroundColor DarkGray
    $best = $results | Where-Object { $_.Avg -lt 99999 } | Sort-Object Avg | Select-Object -First 1
    if ($best) {
        Write-Host "`n  $($txt.Fastest): " -NoNewline -ForegroundColor White
        Write-Host "$($best.Name) [$($best.IP)] - $($best.Avg) ms" -ForegroundColor Green
        Write-Log "LATENCY TEST | Fastest: $($best.Name) [$($best.IP)] - $($best.Avg) ms"
    }
}

function Invoke-Backup {
    $adapters = Get-PhysicalAdapters
    if (-not $adapters) { Write-Host "`n  $($txt.ErrNoAdap)" -ForegroundColor Red; return }
    $backup = @{}
    foreach ($a in $adapters) {
        $v4 = (Get-DnsClientServerAddress -InterfaceAlias $a.Name -AddressFamily IPv4 -ErrorAction SilentlyContinue).ServerAddresses
        $v6 = (Get-DnsClientServerAddress -InterfaceAlias $a.Name -AddressFamily IPv6 -ErrorAction SilentlyContinue).ServerAddresses
        $backup[$a.Name] = @{ IPv4 = $v4; IPv6 = $v6 }
    }
    $backup | ConvertTo-Json -Depth 5 | Out-File -FilePath $backupFile -Encoding UTF8
    Write-Host ""
    Write-Host "  $($txt.BackupOk)" -ForegroundColor Green
    Write-Host "  $backupFile"       -ForegroundColor Cyan
    Write-Log "BACKUP SAVED | $backupFile"
}

function Invoke-Restore {
    if (-not (Test-Path $backupFile)) {
        Write-Host ""
        Write-Host "  $($txt.BackupNone)" -ForegroundColor Red
        Write-Host "  $backupFile"         -ForegroundColor DarkGray
        return
    }
    $backup = Get-Content $backupFile -Raw | ConvertFrom-Json
    Write-Host ""
    Write-Host "  $($txt.Applying)" -ForegroundColor Cyan
    foreach ($adapterName in $backup.PSObject.Properties.Name) {
        $v4 = $backup.$adapterName.IPv4
        try {
            if ($v4) {
                Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses $v4 -ErrorAction Stop
            } else {
                Set-DnsClientServerAddress -InterfaceAlias $adapterName -ResetServerAddresses -ErrorAction Stop
            }
            Write-Host "  [OK] $adapterName" -ForegroundColor Green
            Write-Log "RESTORE | $adapterName | IPv4: $($v4 -join ', ')"
        } catch {
            Write-Host "  [FAIL] $adapterName -> $_" -ForegroundColor Red
        }
    }
    Clear-DnsClientCache
    Write-Host ""
    Write-Host "  $($txt.RestoreOk)" -ForegroundColor Green
}

function Invoke-DoHToggle {
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
    $current = (Get-ItemProperty -Path $regPath -Name "EnableAutoDoh" -ErrorAction SilentlyContinue).EnableAutoDoh
    Write-Host ""
    Write-Host "  $($txt.DoHStatus) " -NoNewline -ForegroundColor White
    if ($current -eq 2) { Write-Host $txt.DoHOn -ForegroundColor Green }
    else                 { Write-Host $txt.DoHOff -ForegroundColor Yellow }
    Write-Host ""
    Write-Host "  [1] $($txt.DoHOn)" -ForegroundColor Green
    Write-Host "  [2] $($txt.DoHOff)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host -NoNewline $txt.DoHChoose -ForegroundColor Yellow
    $ans = (Read-Host).Trim()

    if ($ans -eq '1') {
        # — recolectar todas las IPs activas en cada adaptador
        $adapters   = Get-PhysicalAdapters
        $adapterDNS = @{}
        if ($adapters) {
            foreach ($a in $adapters) {
                $v4 = (Get-DnsClientServerAddress -InterfaceAlias $a.Name -AddressFamily IPv4 -ErrorAction SilentlyContinue).ServerAddresses
                $v6 = (Get-DnsClientServerAddress -InterfaceAlias $a.Name -AddressFamily IPv6 -ErrorAction SilentlyContinue).ServerAddresses
                $all = @()
                if ($v4) { $all += $v4 }
                if ($v6) { $all += $v6 }
                if ($all.Count -gt 0) { $adapterDNS[$a.Name] = $all }
            }
        }
        # — registrar templates globalmente via registro (IPv4 + IPv6)
        $allIPs = ($adapterDNS.Values | ForEach-Object { $_ } | Select-Object -Unique)
        if ($allIPs) {
            Write-Host "  (Registrando templates DoH...)" -ForegroundColor DarkGray
            Register-DoHTemplates -Addresses $allIPs
        }
        # — EnableAutoDoh = 2
        Set-ItemProperty -Path $regPath -Name "EnableAutoDoh" -Value 2 -Type DWord
        # — config DoH por interfaz via registro (GUID)
        foreach ($adName in $adapterDNS.Keys) {
            Set-InterfaceDoH -AdapterName $adName -Addresses $adapterDNS[$adName]
        }
        Write-Host "  -> $($txt.DoHOn)" -ForegroundColor Green
        Write-Log "DoH ENABLED"

    } elseif ($ans -eq '2') {
        Set-ItemProperty -Path $regPath -Name "EnableAutoDoh" -Value 0 -Type DWord
        Write-Host "  -> $($txt.DoHOff)" -ForegroundColor Yellow
        Write-Log "DoH DISABLED"

    } else {
        Write-Host "`n  $($txt.ErrInv)" -ForegroundColor Red
        return
    }
    Write-Host "  $($txt.DoHNote)" -ForegroundColor DarkGray
}

function Invoke-StartupTask {
    $taskName     = "AtlasDNSSelector"
    $existingTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
    Write-Host ""
    if ($existingTask) {
        Write-Host "  " -NoNewline
        Write-Host -NoNewline $txt.TaskExists -ForegroundColor Yellow
        $ans = (Read-Host).Trim()
        if ($ans -match "^[SsYy]$") {
            Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue
            Write-Host "  $($txt.TaskRemoved)" -ForegroundColor Yellow
            Write-Log "STARTUP TASK REMOVED"
        }
    } else {
        $scriptPath = $PSCommandPath
        $action     = New-ScheduledTaskAction -Execute "powershell.exe" `
                          -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`""
        $trigger    = New-ScheduledTaskTrigger -AtLogOn
        $settings   = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Minutes 5) -MultipleInstances IgnoreNew
        $principal  = New-ScheduledTaskPrincipal -RunLevel Highest -LogonType Interactive

        Register-ScheduledTask -TaskName $taskName `
            -Action $action -Trigger $trigger -Settings $settings -Principal $principal `
            -Description "Atlas PC Support - DNS Selector auto-apply on logon" | Out-Null

        Write-Host "  $($txt.TaskCreated)" -ForegroundColor Green
        Write-Log "STARTUP TASK CREATED | $scriptPath"
    }
}

function Show-Log {
    Write-Host ""
    if (-not (Test-Path $logFile)) {
        Write-Host "  $($txt.LogEmpty)" -ForegroundColor DarkGray
        return
    }
    $lines = Get-Content $logFile -Tail 30
    if (-not $lines) {
        Write-Host "  $($txt.LogEmpty)" -ForegroundColor DarkGray
        return
    }
    Write-Host ("  " + ("-" * 64)) -ForegroundColor DarkGray
    foreach ($line in $lines) {
        $col = switch -Regex ($line) {
            "FAIL"    { "Red" }
            "BACKUP|RESTORE" { "Cyan" }
            "DoH"     { "Magenta" }
            "LATENCY" { "Yellow" }
            "TASK"    { "Blue" }
            default   { "Gray" }
        }
        Write-Host "  $line" -ForegroundColor $col
    }
    Write-Host ("  " + ("-" * 64)) -ForegroundColor DarkGray
    Write-Host "  $($txt.LogPath)$logFile" -ForegroundColor DarkGray
}

function Invoke-CustomDNS {
    Write-Host ""
    Write-Host -NoNewline $txt.CustomPrim -ForegroundColor Yellow
    $prim = (Read-Host).Trim()
    if (-not $prim) { Write-Host "  $($txt.ErrInv)" -ForegroundColor Red; return }
    Write-Host -NoNewline $txt.CustomSec -ForegroundColor Yellow
    $sec = (Read-Host).Trim()
    $addresses = if ($sec) { @($prim, $sec) } else { @($prim) }
    $label     = "Custom ($($addresses -join ' / '))"
    Write-Host ""
    Write-Host -NoNewline "  $($txt.CustomApply)" -ForegroundColor Yellow
    $ans = (Read-Host).Trim()
    if ($ans -match "^[SsYy]$") {
        $adapters = Get-PhysicalAdapters
        if (-not $adapters) { Write-Host "  $($txt.ErrNoAdap)" -ForegroundColor Red; return }
        Apply-DNS -AdapterNames $adapters.Name -Addresses $addresses -Label $label
    } else {
        $selected = Select-AdapterNames
        if ($selected) { Apply-DNS -AdapterNames $selected -Addresses $addresses -Label $label }
    }
}

function Invoke-PerAdapterDNS {
    Write-Host ""
    Write-Host "  $($txt.PromptDNSOpt)" -ForegroundColor Cyan
    foreach ($k in $dnsProfiles.Keys) {
        $label = $dnsProfiles[$k].Label
        Write-Host "  [$k] $label" -ForegroundColor White
    }
    Write-Host ""
    Write-Host -NoNewline "  >> " -ForegroundColor Yellow
    $dnsOpt = (Read-Host).Trim()
    if ($dnsProfiles.Keys -contains $dnsOpt) {
        $profile  = $dnsProfiles[$dnsOpt]
        $selected = Select-AdapterNames
        if ($selected) {
            Apply-DNS -AdapterNames $selected -Addresses $profile.Addr -Label $profile.Label
        }
    } elseif ($dnsOpt -eq '16') {
        Invoke-CustomDNS
    } else {
        Write-Host "`n  $($txt.ErrInv)" -ForegroundColor Red
    }
}

#endregion

#region ── Loop Principal ────────────────────────────────────────��───────────
do {
    Clear-Host
    $swProbe = $null
    $swErr = $null
    try { $swProbe = $Host.UI.RawUI.WindowSize.Width } catch { $swErr = $_.Exception.Message }
    #region agent log
    Write-AgentDbg -hypothesisId "B" -location "main:loop" -message "menu_windowsize" -data @{ swProbe = $swProbe; swErr = $swErr; host = $Host.Name }
    #endregion
    $screenW  = $Host.UI.RawUI.WindowSize.Width
    $menuW    = 64
    $lm       = " " * [math]::Max(0, [math]::Floor(($screenW - $menuW) / 2))
    Write-Host ""
    Write-Centered "################################################################" "Yellow"
    Write-Centered "#                                                              #" "Yellow"
    Write-Centered "#           A T L A S   P C   S U P P O R T                  #" "Yellow"
    Write-Centered "#              DNS Selector  v2.0                             #" "Yellow"
    Write-Centered "#                                                              #" "Yellow"
    Write-Centered "################################################################" "Yellow"
    Write-Host ""
    Write-Host "$lm[ $($txt.CurrentDNS) ]" -ForegroundColor DarkCyan
    $statusLines = Get-DNSStatusLines
    foreach ($sl in $statusLines) {
        Write-Host "$lm$($sl.Text)" -ForegroundColor $sl.Color
    }
    Write-Host ""
    Write-Host "$lm$($txt.Opt1)" -ForegroundColor Green
    Write-Host ""
    Write-Host "$lm$($txt.HeaderCF)" -ForegroundColor Cyan
    Write-Host "$lm$($txt.Opt2)"
    Write-Host "$lm$($txt.Opt3)"
    Write-Host "$lm$($txt.Opt4)"
    Write-Host ""
    Write-Host "$lm$($txt.HeaderGG)" -ForegroundColor Cyan
    Write-Host "$lm$($txt.Opt5)"
    Write-Host ""
    Write-Host "$lm$($txt.HeaderQ9)" -ForegroundColor Cyan
    Write-Host "$lm$($txt.Opt6)"
    Write-Host ""
    Write-Host "$lm$($txt.HeaderOD)" -ForegroundColor Cyan
    Write-Host "$lm$($txt.Opt7)"
    Write-Host "$lm$($txt.Opt8)"
    Write-Host ""
    Write-Host "$lm$($txt.HeaderMV)" -ForegroundColor Cyan
    Write-Host "$lm$($txt.Opt9)"
    Write-Host "$lm$($txt.Opt10)"
    Write-Host "$lm$($txt.Opt11)"
    Write-Host "$lm$($txt.Opt12)"
    Write-Host "$lm$($txt.Opt13)"
    Write-Host "$lm$($txt.Opt14)"
    Write-Host ""
    Write-Host "$lm$($txt.HeaderND)" -ForegroundColor Cyan
    Write-Host "$lm$($txt.Opt15)"
    Write-Host ""
    Write-Host "$lm$($txt.HeaderCU)" -ForegroundColor Cyan
    Write-Host "$lm$($txt.Opt16)"
    Write-Host ""
    Write-Host "$lm$($txt.HeaderTools)" -ForegroundColor Magenta
    Write-Host "$lm$($txt.Opt17)"
    Write-Host "$lm$($txt.Opt18)"
    Write-Host "$lm$($txt.Opt19)"
    Write-Host "$lm$($txt.Opt20)"
    Write-Host "$lm$($txt.Opt21)"
    Write-Host "$lm$($txt.Opt22)"
    Write-Host "$lm$($txt.Opt23)"
    Write-Host "$lm$($txt.Opt24)"
    Write-Host ""
    Write-Host "$lm$($txt.Opt0)" -ForegroundColor Red
    Write-Host ""
    Write-Host -NoNewline "$lm$($txt.Prompt): " -ForegroundColor Yellow
    $rawMenu = Read-Host
    if ($null -eq $rawMenu) { $rawMenu = "" }
    $opcion = $rawMenu.Trim()
    $parsed = 0
    $isNum  = [int]::TryParse($opcion, [ref]$parsed)
    #region agent log
    $inProfile = $dnsProfiles.Keys -contains $opcion
    $opcLen = if ($null -ne $opcion) { $opcion.Length } else { -1 }
    Write-AgentDbg -hypothesisId "C" -location "main:menu" -message "option_read" -data @{
        opcion     = $(if ($null -eq $opcion) { "<null>" } elseif ($opcion -eq "") { "<empty>" } else { $opcion })
        opcLen     = $opcLen
        isNum      = $isNum
        parsed     = $parsed
        inProfile  = $inProfile
        runId      = "post-fix"
    }
    #endregion
    if ($opcion -eq '0') { break }
    if ([string]::IsNullOrWhiteSpace($opcion)) {
        #region agent log
        Write-AgentDbg -hypothesisId "C" -location "main:menu" -message "blank_input_show_err" -data @{ runId = "post-fix" }
        #endregion
        Write-Host "`n  $($txt.ErrBlank)" -ForegroundColor Red
        Press-AnyKey
        continue
    }
    switch ($opcion) {
        { $dnsProfiles.Keys -contains $_ } {
            $profile  = $dnsProfiles[$opcion]
            $adapters = Get-PhysicalAdapters
            if (-not $adapters) {
                Write-Host "`n  $($txt.ErrNoAdap)" -ForegroundColor Red
            } else {
                Apply-DNS -AdapterNames $adapters.Name -Addresses $profile.Addr -Label $profile.Label
            }
        }
        '16' { Invoke-CustomDNS }
        '17' { Invoke-LatencyTest }
        '18' { Invoke-Backup }
        '19' { Invoke-Restore }
        '20' { Invoke-DoHToggle }
        '21' { Invoke-StartupTask }
        '22' { Show-Log }
        '23' { Invoke-PerAdapterDNS }
        '24' {
            Write-Host "`n  $($txt.Opening)" -ForegroundColor Magenta
            Start-Process "https://www.cloudflare.com/ssl/encrypted-sni/"
        }
        default {
            if ($opcion -ne '') {
                Write-Host "`n  $($txt.ErrInv)" -ForegroundColor Red
            }
        }
    }
    Press-AnyKey
} while ($true)
Write-Host ""
Write-Centered "$(if ($es) { 'Gracias por usar Atlas PC Support. Hasta luego!' } else { 'Thank you for using Atlas PC Support. Goodbye!' })" "Yellow"
Write-Host ""
#endregion
}


# ---- tools\Invoke-SoftwareInstaller.ps1 ----
# ============================================================
# Invoke-SoftwareInstaller
# Migrado de: Software_Installer.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-SoftwareInstaller {
    [CmdletBinding()]
    param()
& {
    $Host.UI.RawUI.WindowTitle = "Atlas PC Support - Panel Maestro v2.1"
    
    # --- DICCIONARIO DE PROGRAMAS ---
    $programas = @(
        [pscustomobject]@{ ID = 1; Cat = "Navegadores"; Nombre = "Chrome"; WingetID = "Google.Chrome" }
        [pscustomobject]@{ ID = 2; Cat = "Navegadores"; Nombre = "Firefox"; WingetID = "Mozilla.Firefox" }
        [pscustomobject]@{ ID = 3; Cat = "Navegadores"; Nombre = "Brave"; WingetID = "Brave.Brave" }
        [pscustomobject]@{ ID = 4; Cat = "Navegadores"; Nombre = "Opera"; WingetID = "Opera.Opera" }
        [pscustomobject]@{ ID = 5; Cat = "Navegadores"; Nombre = "DuckDuckGo"; WingetID = "DuckDuckGo.DesktopBrowser" }
        [pscustomobject]@{ ID = 6; Cat = "Navegadores"; Nombre = "Vivaldi"; WingetID = "VivaldiTechnologies.Vivaldi" }
        
        [pscustomobject]@{ ID = 7; Cat = "Utilidades"; Nombre = "WinRAR"; WingetID = "RARLab.WinRAR" }
        [pscustomobject]@{ ID = 8; Cat = "Utilidades"; Nombre = "7-Zip"; WingetID = "7zip.7zip" }
        [pscustomobject]@{ ID = 9; Cat = "Utilidades"; Nombre = "Adobe PDF"; WingetID = "Adobe.Acrobat.Reader.64-bit" }
        [pscustomobject]@{ ID = 10; Cat = "Utilidades"; Nombre = "PDF24"; WingetID = "geeksoftwareGmbH.PDF24Creator" }
        [pscustomobject]@{ ID = 11; Cat = "Utilidades"; Nombre = "AnyDesk"; WingetID = "AnyDeskSoftware.AnyDesk" }
        [pscustomobject]@{ ID = 12; Cat = "Utilidades"; Nombre = "RustDesk"; WingetID = "RustDesk.RustDesk" }
        
        [pscustomobject]@{ ID = 13; Cat = "Social"; Nombre = "WhatsApp"; WingetID = "9NKSQGP7F2NH"; Source = "msstore" }
        [pscustomobject]@{ ID = 14; Cat = "Social"; Nombre = "Telegram"; WingetID = "Telegram.TelegramDesktop" }
        [pscustomobject]@{ ID = 15; Cat = "Social"; Nombre = "Zoom"; WingetID = "Zoom.Zoom" }
        [pscustomobject]@{ ID = 16; Cat = "Social"; Nombre = "Teams"; WingetID = "Microsoft.Teams" }

        [pscustomobject]@{ ID = 17; Cat = "Multimedia"; Nombre = "VLC Player"; WingetID = "VideoLAN.VLC" }
        [pscustomobject]@{ ID = 18; Cat = "Multimedia"; Nombre = "Spotify"; WingetID = "Spotify.Spotify" }

        [pscustomobject]@{ ID = 19; Cat = "Gaming"; Nombre = "Steam"; WingetID = "Valve.Steam" }
        [pscustomobject]@{ ID = 20; Cat = "Gaming"; Nombre = "Epic Games"; WingetID = "EpicGames.EpicGamesLauncher" }
        [pscustomobject]@{ ID = 21; Cat = "Gaming"; Nombre = "Discord"; WingetID = "Discord.Discord" }

        [pscustomobject]@{ ID = 22; Cat = "Mantenimiento"; Nombre = "Limpiar Temp"; WingetID = "CLEANUP" }
        [pscustomobject]@{ ID = 23; Cat = "Mantenimiento"; Nombre = "Actualizar Apps"; WingetID = "UPGRADE" }
    )

    $silencioso = @("--accept-package-agreements", "--accept-source-agreements", "-e", "--silent")

    # --- INICIO DEL BUCLE ---
    do {
        Clear-Host
        Write-Host "======================================================================" -ForegroundColor Cyan
        Write-Host "                ATLAS PC SUPPORT - PANEL DE CONTROL                   " -ForegroundColor Yellow
        Write-Host "======================================================================" -ForegroundColor Cyan

        # Renderizado del menú con categorías
        $cats = $programas | Select-Object -ExpandProperty Cat -Unique
        foreach ($c in $cats) {
            Write-Host "`n--- $($c.ToUpper()) ---" -ForegroundColor Yellow
            $appsCat = $programas | Where-Object { $_.Cat -eq $c }
            for ($i = 0; $i -lt $appsCat.Count; $i += 3) {
                $linea = ""
                for ($j = 0; $j -lt 3; $j++) {
                    if (($i + $j) -lt $appsCat.Count) {
                        $p = $appsCat[$i + $j]
                        $texto = "[$($p.ID)] $($p.Nombre)"
                        $linea += $texto.PadRight(23)
                    }
                }
                Write-Host "  $linea"
            }
        }

        Write-Host "`n======================================================================" -ForegroundColor Cyan
        Write-Host "  [S] BUSCADOR MANUAL   [Q] SALIR" -ForegroundColor Magenta
        Write-Host "======================================================================" -ForegroundColor Cyan

        $seleccion = Read-Host "`nEscribe los números (comas) o letra"
        
        if ($seleccion.Trim().ToUpper() -eq 'Q') {
            Write-Host "`nCerrando herramientas Atlas... ¡Buen trabajo!" -ForegroundColor Cyan
            break
        } elseif ($seleccion.Trim().ToUpper() -eq 'S') {
            Write-Host "`n[BUSCADOR MANUAL]" -ForegroundColor Magenta
            $busqueda = Read-Host "Nombre del programa"
            winget search $busqueda
            $id_manual = Read-Host "`nID para instalar (Enter para volver)"
            if ($id_manual) { 
                Write-Host "`nInstalando $id_manual..." -ForegroundColor Cyan
                winget install --id $id_manual $silencioso 
                Read-Host "`nInstalación finalizada. Presiona Enter para volver al menú."
            }
        } else {
            $idsElegidos = $seleccion -split ',' | ForEach-Object { $_.Trim() }
            foreach ($id in $idsElegidos) {
                $app = $programas | Where-Object { [string]$_.ID -eq $id }
                if ($app) {
                    if ($app.WingetID -eq "CLEANUP") {
                        Write-Host "`n[+] Limpiando temporales..." -ForegroundColor Green
                        Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue
                        Write-Host "[OK] Temporales limpios."
                    } elseif ($app.WingetID -eq "UPGRADE") {
                        Write-Host "`n[+] Actualizando aplicaciones..." -ForegroundColor Cyan
                        winget upgrade --all $silencioso
                    } else {
                        Write-Host "`n[+] Instalando $($app.Nombre)..." -ForegroundColor Cyan
                        if ($app.Source -eq "msstore") {
                            winget install --id $($app.WingetID) --source msstore --accept-package-agreements --accept-source-agreements -e
                        } else {
                            winget install --id $($app.WingetID) $silencioso
                        }
                        Write-Host "[OK] $($app.Nombre) listo." -ForegroundColor Green
                    }
                }
            }
            if ($seleccion -ne "") {
                Read-Host "`nTarea finalizada. Presiona Enter para volver al menú principal."
            }
        }
    } while ($true)
}
}


# ---- tools\Invoke-StopServices.ps1 ----
# ============================================================
# Invoke-StopServices
# Migrado de: Stop+services+-+pendiente.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-StopServices {
    [CmdletBinding()]
    param()
$ServiciosAOptimizar = @(
    "DiagTrack", "dmwappushservice", "WerSvc", "wisvc", "PcaSvc",
    "XblAuthManager", "XblGameSave", "XboxNetApiSvc", "XboxGipSvc",
    "TabletInputService", "SensorService", "SensorDataService", "SensrSvc", "WbioSrvc",
    "MapsBroker", "WalletService", "RetailDemo", "Fax", "RemoteRegistry"
)

foreach ($Servicio in $ServiciosAOptimizar) {
    # Aquí iría la lógica para detenerlos y pasarlos a Manual
}
}



# ============================================================
#  BOOTSTRAP
# ============================================================

$ErrorActionPreference = 'Stop'

$branding = Get-AtlasBranding
$currentLang = Set-AtlasLanguage $branding.language
Initialize-AtlasLog | Out-Null
Write-AtlasLog "Atlas PC Support iniciado (launcher compilado v$script:AtlasVersion, lang=$currentLang)"

try {
    $manifestObj = $script:AtlasToolsManifest | ConvertFrom-Json -AsHashtable
    $tools = @($manifestObj.tools)
} catch {
    throw "No se pudo parsear el manifiesto embebido: $_"
}

Show-AtlasWindow -Branding $branding -Tools $tools -XamlTemplate $script:AtlasXamlTemplate