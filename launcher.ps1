# ============================================================
#  Atlas PC Support — launcher.ps1 (compilado)
#  Versión: 1.0.0
#  Build:   2026-04-24 11:26:04
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
$script:AtlasBuildDate = '2026-04-24 11:26:04'

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
      "id": "parts-upgrade",
      "name": "Parts Upgrade Advisor",
      "description": "Analiza RAM, CPU (socket/BGA) y almacenamiento (NVMe/SATA/M.2). Recomendaciones y precauciones de compra.",
      "category": "diagnostico",
      "function": "Invoke-PartsUpgrade",
      "source": "PartsUpgrade.ps1",
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
#   * Tomar la SOURCE CRUDA del archivo src/tools/Invoke-X.ps1
#     (inyectada por build.ps1 como base64 en $script:AtlasToolSources).
#   * Escribir esa fuente + una llamada a Invoke-X + un try/catch/pausa
#     en un .ps1 temporal.
#   * Envolverlo en un .cmd que llama powershell.exe -File y DESPUES
#     hace pause, para sobrevivir llamadas a 'exit' dentro de la tool.
#   * Lanzar cmd.exe via Start-Process, con elevacion si procede.
#
# Por que NO usamos (Get-Command ....Definition):
#   En Windows PowerShell 5.1, .Definition puede normalizar
#   whitespace y corromper here-strings / HTML embebidos, lo que
#   genera errores de parse en tiempo de ejecucion (missing brace,
#   '<' es operador reservado, etc.). Embebiendo la fuente cruda
#   en base64 evitamos todo el roundtrip y nos aseguramos de que
#   lo que se ejecuta es lo que hay en src/tools/.
#
# Por que NO usamos -EncodedCommand:
#   1. Limite de longitud de CreateProcess (~32 KB). Tools grandes
#      (FastCopy, Robocopy) superan el limite.
#   2. Interpolacion prematura de variables del cuerpo.
# ============================================================

function Invoke-AtlasTool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [hashtable]$Tool,
        [hashtable]$Branding
    )

    Write-AtlasLog "Ejecutando: $($Tool.name) [$($Tool.id)]" -Tool 'Runner'

    $function = $Tool.function

    $runInNew = $true
    if ($Tool.ContainsKey('runsInNewWindow')) {
        $runInNew = [bool]$Tool.runsInNewWindow
    }

    # Ejecucion inline (sin nueva ventana) es para helpers/gui; raro.
    if (-not $runInNew) {
        try { & $function } catch {
            Write-AtlasLog "Error en ${function}: $_" -Level ERROR -Tool 'Runner'
            [System.Windows.MessageBox]::Show("Error: $_", 'Atlas PC Support', 'OK', 'Error') | Out-Null
        }
        return
    }

    # ----------- Recuperar la source cruda del map embebido -----------
    $rawSource = $null
    if ($script:AtlasToolSources -and $script:AtlasToolSources.ContainsKey($function)) {
        try {
            $b64   = $script:AtlasToolSources[$function]
            $bytes = [Convert]::FromBase64String($b64)
            $rawSource = [System.Text.Encoding]::UTF8.GetString($bytes)
        } catch {
            Write-AtlasLog "Fallo decoding base64 de '$function': $_" -Level ERROR -Tool 'Runner'
        }
    }

    if (-not $rawSource) {
        # Fallback al metodo antiguo (por si alguien usa ToolRunner fuera del
        # launcher compilado, p.ej. desde src/ directamente).
        $cmd = Get-Command $function -CommandType Function -ErrorAction SilentlyContinue
        if (-not $cmd) {
            $msg = "La funcion '$function' no esta cargada ni disponible como source."
            Write-AtlasLog $msg -Level ERROR -Tool 'Runner'
            [System.Windows.MessageBox]::Show($msg, 'Atlas PC Support', 'OK', 'Error') | Out-Null
            return
        }
        $funcBody = $cmd.Definition
        $funcBody = $funcBody -replace "[\uFEFF\u200B]", ""
        $rawSource = "function $function {`n$funcBody`n}`n"
    } else {
        # Limpiar BOM / zero-width del texto (por si se colaron al guardar).
        $rawSource = $rawSource -replace "[\uFEFF\u200B]", ""
    }

    $brandName = if ($Branding -and $Branding.brand -and $Branding.brand.shortName) { $Branding.brand.shortName } else { 'Atlas PC Support' }
    $title = "$brandName - $($Tool.name)"

    # ----------- Construir el .ps1 temporal -----------
    # El orden del script temporal:
    #   1) set title
    #   2) source cruda de la tool (define la funcion)
    #   3) try { call funcion } catch { print error + stacktrace }
    #   4) NO hacemos Read-Host aqui: el .cmd wrapper hace el pause.
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine('# Atlas PC Support - runner temp script')
    [void]$sb.AppendLine('$ErrorActionPreference = ''Continue''')
    [void]$sb.AppendLine('try { $Host.UI.RawUI.WindowTitle = ' + ("'{0}'" -f ($title -replace "'","''")) + ' } catch {}')
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine($rawSource)
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine('try {')
    [void]$sb.AppendLine("    $function")
    [void]$sb.AppendLine('} catch {')
    [void]$sb.AppendLine('    Write-Host ""')
    [void]$sb.AppendLine("    Write-Host ('[!] Error en $function : ' + `$_.Exception.Message) -ForegroundColor Red")
    [void]$sb.AppendLine('    Write-Host ""')
    [void]$sb.AppendLine('    Write-Host "Traza:" -ForegroundColor DarkGray')
    [void]$sb.AppendLine('    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray')
    [void]$sb.AppendLine('}')

    $tempDir = Join-Path $env:TEMP 'AtlasPC'
    if (-not (Test-Path $tempDir)) {
        New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    }
    $stamp       = "$($Tool.id)-$(Get-Random)"
    $tempScript  = Join-Path $tempDir "run-$stamp.ps1"
    $tempWrapper = Join-Path $tempDir "run-$stamp.cmd"

    # .ps1 en UTF-8 CON BOM. CRITICO: Windows PowerShell 5.1 lee los .ps1
    # como ANSI/CP-1252 si no detecta BOM, lo que corrompe caracteres
    # acentuados (UTF-8 'Ó' bytes C3 93 -> se interpreta como 'Ã"' que
    # contiene un caracter de comilla y rompe el parse en cascada).
    # Con BOM, PS 5.1 reconoce UTF-8 y lo decodifica correctamente.
    $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
    [System.IO.File]::WriteAllText($tempScript, $sb.ToString(), $utf8WithBom)

    # .cmd wrapper: sobrevive a 'exit' dentro de la tool (pause al final
    # siempre se ejecuta porque corre en proceso cmd, no powershell).
    $psFile = $tempScript.Replace('%', '%%')
    $wrapperLines = @(
        '@echo off',
        'chcp 65001 > nul 2>&1',
        ('powershell.exe -NoProfile -ExecutionPolicy Bypass -File "' + $psFile + '"'),
        'echo.',
        'echo ============================================',
        'echo   Tool finalizada. Presiona una tecla para cerrar.',
        'echo ============================================',
        'pause > nul'
    )
    [System.IO.File]::WriteAllLines($tempWrapper, $wrapperLines, [System.Text.ASCIIEncoding]::new())

    Write-AtlasLog "Temp wrapper: $tempWrapper" -Tool 'Runner' -Level DEBUG

    $startArgs = @{
        FilePath     = 'cmd.exe'
        ArgumentList = @('/c', "`"$tempWrapper`"")
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

# --- FUNCIÓN: Renombrar Equipo ---
function Renombrar-Equipo {
    Escribir-Centrado "--- RENOMBRAR EQUIPO ---" "Cyan"
    Write-Host ""
    $actual = $env:COMPUTERNAME
    Write-Host "   Nombre actual: $actual" -ForegroundColor White
    Write-Host ""
    $nuevo = Read-Host "   -> Nuevo nombre (0 para cancelar)"
    if ($nuevo -eq "0" -or [string]::IsNullOrWhiteSpace($nuevo)) { return }
    if ($nuevo -notmatch '^[A-Za-z0-9\-]{1,15}$') {
        Write-Host "`n   [ERROR] Nombre invalido. Solo A-Z 0-9 y guion, max 15." -ForegroundColor Red
        Read-Host "`n   ENTER para volver"
        return
    }
    try {
        Rename-Computer -NewName $nuevo -Force -ErrorAction Stop
        Write-Host "`n   [OK] Nombre cambiado a: $nuevo" -ForegroundColor Green
        Write-Host "   Debe reiniciar el equipo para aplicar." -ForegroundColor Yellow
    } catch {
        Write-Host "`n   [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "`n   ENTER para volver"
}

# --- FUNCIÓN: Generar Checklist de Entrega (reporte) ---
function Generar-ChecklistEntrega {
    Escribir-Centrado "--- GENERANDO CHECKLIST DE ENTREGA ---" "Cyan"
    Write-Host ""
    Write-Host "   Recopilando informacion del equipo..." -ForegroundColor Yellow

    $report = @()
    $report += "==========================================="
    $report += "  ATLAS PC SUPPORT - CHECKLIST DE ENTREGA"
    $report += "==========================================="
    $report += "  Generado: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    $report += ""

    # Equipo
    try {
        $cs = Get-CimInstance Win32_ComputerSystem -ErrorAction Stop
        $bios = Get-CimInstance Win32_BIOS -ErrorAction Stop
        $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
        $report += "[EQUIPO]"
        $report += ("  Nombre:        {0}" -f $env:COMPUTERNAME)
        $report += ("  Fabricante:    {0}" -f $cs.Manufacturer)
        $report += ("  Modelo:        {0}" -f $cs.Model)
        $report += ("  Serial BIOS:   {0}" -f $bios.SerialNumber)
        $report += ("  OS:            {0}" -f $os.Caption)
        $report += ("  Version:       {0}" -f $os.Version)
        $report += ("  Build:         {0}" -f $os.BuildNumber)
        $report += ("  Arquitectura:  {0}" -f $os.OSArchitecture)
        $report += ("  RAM total:     {0:N1} GB" -f ($cs.TotalPhysicalMemory/1GB))
        $report += ""
    } catch {
        $report += "  [!] Error obteniendo info equipo: $($_.Exception.Message)"
    }

    # Activacion
    try {
        $licInfo = cscript.exe //Nologo "C:\Windows\System32\slmgr.vbs" /xpr 2>&1
        $report += "[ACTIVACION WINDOWS]"
        $licInfo | ForEach-Object { $report += "  $_" }
        $report += ""
    } catch {
        $report += "  [!] No se pudo consultar activacion."
    }

    # Usuarios
    try {
        $report += "[USUARIOS LOCALES]"
        Get-LocalUser -ErrorAction Stop | Where-Object { $_.Enabled } | ForEach-Object {
            $report += ("  - {0,-20} (FullName: {1})" -f $_.Name, $_.FullName)
        }
        $report += ""
        $report += "[ADMINISTRADORES]"
        $adminGroup = Get-LocalGroup | Where-Object SID -eq "S-1-5-32-544"
        if ($adminGroup) {
            Get-LocalGroupMember -Group $adminGroup -ErrorAction SilentlyContinue | ForEach-Object {
                $report += ("  - {0}" -f $_.Name)
            }
        }
        $report += ""
    } catch {
        $report += "  [!] Error listando usuarios: $($_.Exception.Message)"
    }

    # BitLocker
    try {
        $report += "[BITLOCKER]"
        $vols = Get-BitLockerVolume -ErrorAction Stop
        foreach ($v in $vols) {
            $report += ("  {0}: {1,-15} Protection: {2,-5} Enc: {3}%" -f $v.MountPoint, $v.VolumeStatus, $v.ProtectionStatus, $v.EncryptionPercentage)
            $rk = $v.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
            foreach ($r in $rk) {
                $report += ("     Recovery Key ID: {0}" -f $r.KeyProtectorId)
                $report += ("     Recovery Key:    {0}" -f $r.RecoveryPassword)
            }
        }
        $report += ""
    } catch {
        $report += "  [!] BitLocker no disponible o error: $($_.Exception.Message)"
        $report += ""
    }

    # Discos
    try {
        $report += "[DISCOS FISICOS]"
        Get-PhysicalDisk -ErrorAction Stop | ForEach-Object {
            $report += ("  - {0} {1}  {2:N0} GB  Health: {3}  Media: {4}" -f $_.FriendlyName, $_.SerialNumber, ($_.Size/1GB), $_.HealthStatus, $_.MediaType)
        }
        $report += ""
        $report += "[VOLUMENES]"
        Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter } | Sort-Object DriveLetter | ForEach-Object {
            $report += ("  {0}: {1,-15} {2:N1} GB libre de {3:N1} GB ({4})" -f $_.DriveLetter, $_.FileSystemLabel, ($_.SizeRemaining/1GB), ($_.Size/1GB), $_.FileSystem)
        }
        $report += ""
    } catch {
        $report += "  [!] Error discos: $($_.Exception.Message)"
    }

    # Windows Update
    try {
        $report += "[ULTIMAS ACTUALIZACIONES INSTALADAS]"
        Get-HotFix -ErrorAction Stop | Sort-Object InstalledOn -Descending | Select-Object -First 10 | ForEach-Object {
            $report += ("  - {0}  {1}  ({2})" -f $_.HotFixID, $_.InstalledOn, $_.Description)
        }
        $report += ""
    } catch {
        $report += "  [!] Error HotFix: $($_.Exception.Message)"
    }

    # Red
    try {
        $report += "[RED]"
        Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop | Where-Object { $_.IPAddress -notlike '169.*' -and $_.IPAddress -notlike '127.*' } | ForEach-Object {
            $report += ("  {0}: {1}/{2}" -f $_.InterfaceAlias, $_.IPAddress, $_.PrefixLength)
        }
        $report += ""
    } catch {}

    # Defender
    try {
        $mp = Get-MpComputerStatus -ErrorAction Stop
        $report += "[WINDOWS DEFENDER]"
        $report += ("  AV Enabled:          {0}" -f $mp.AntivirusEnabled)
        $report += ("  RealTime Protection: {0}" -f $mp.RealTimeProtectionEnabled)
        $report += ("  AV Signature:        {0}" -f $mp.AntivirusSignatureLastUpdated)
        $report += ""
    } catch {}

    # Checklist manual
    $report += "[CHECKLIST MANUAL PRE-ENTREGA]"
    $report += "  [ ] Hardware probado (pantalla, teclado, tactil, audio, USB)"
    $report += "  [ ] Bateria al 100% y cargador incluido"
    $report += "  [ ] Antivirus activo y actualizado"
    $report += "  [ ] BitLocker activado y recovery key guardada"
    $report += "  [ ] Windows Update al dia"
    $report += "  [ ] Navegador limpio (sin cuentas guardadas del tecnico)"
    $report += "  [ ] Usuario cliente creado con nombre correcto"
    $report += "  [ ] Password entregada fisicamente o por canal seguro"
    $report += "  [ ] Cliente informado sobre garantia y contacto"
    $report += "  [ ] Equipo limpio (polvo, pantalla, teclado)"
    $report += ""
    $report += "==========================================="
    $report += "  FIN DEL REPORTE"
    $report += "==========================================="

    # Guardar
    try {
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $desktop = [Environment]::GetFolderPath('Desktop')
        $out = Join-Path $desktop "atlas-entrega-$($env:COMPUTERNAME)-$stamp.txt"
        Set-Content -Path $out -Value $report -Encoding UTF8
        Write-Host ""
        Write-Host "   [OK] Reporte guardado en:" -ForegroundColor Green
        Write-Host "   $out" -ForegroundColor White
        try { Start-Process notepad.exe $out } catch {}
    } catch {
        Write-Host ""
        Write-Host "   [ERROR] No se pudo guardar: $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "`n   ENTER para volver"
}

# =================================================================
# BUCLE PRINCIPAL DEL MENÚ
# =================================================================
while ($true) {
    Mostrar-Encabezado

    $l1 = "[ 1 ]  Entregar equipo (Usuario actual: $env:USERNAME)"
    $l2 = "[ 2 ]  Crear un usuario nuevo adicional"
    $l3 = "[ 3 ]  Renombrar equipo"
    $l4 = "[ 4 ]  Generar CHECKLIST DE ENTREGA (reporte)"
    $l5 = "[ 5 ]  Salir y cerrar herramienta"

    $maxLen = [math]::Max($l1.Length, [math]::Max($l2.Length, [math]::Max($l3.Length, [math]::Max($l4.Length, $l5.Length))))

    Escribir-Centrado $l1.PadRight($maxLen) "White"
    Escribir-Centrado $l2.PadRight($maxLen) "White"
    Escribir-Centrado $l3.PadRight($maxLen) "White"
    Escribir-Centrado $l4.PadRight($maxLen) "Green"
    Escribir-Centrado $l5.PadRight($maxLen) "DarkGray"
    Write-Host ""

    $textoPrompt = "Seleccione una opción [1-5]"
    $ancho = $Host.UI.RawUI.WindowSize.Width
    $espacios = " " * ([math]::Max(0, [math]::Floor(($ancho - $textoPrompt.Length - 2) / 2)))
    Write-Host $espacios -NoNewline
    $opcion = Read-Host $textoPrompt

    switch ($opcion) {
        '1' { Mostrar-Encabezado; Modificar-UsuarioActual }
        '2' { Mostrar-Encabezado; Crear-NuevoUsuario }
        '3' { Mostrar-Encabezado; Renombrar-Equipo }
        '4' { Mostrar-Encabezado; Generar-ChecklistEntrega }
        '5' { Clear-Host; exit }
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
    $atlasApps = if ($env:LOCALAPPDATA) { Join-Path $env:LOCALAPPDATA 'AtlasPC\apps\FastCopy' } else { $null }
    $searchPaths = @(
        (Join-Path $PSScriptRoot "FastCopy.exe"),
        (Join-Path $PSScriptRoot "fastcopy\FastCopy.exe"),
        (Join-Path $PSScriptRoot "..\Apps\FastCopy\FastCopy.exe"),
        (Join-Path $PSScriptRoot "Apps\FastCopy\FastCopy.exe"),
        "C:\Program Files\FastCopy\FastCopy.exe",
        "C:\Program Files (x86)\FastCopy\FastCopy.exe",
        (Join-Path $env:LOCALAPPDATA "FastCopy\FastCopy.exe")
    )
    if ($atlasApps) { $searchPaths += (Join-Path $atlasApps 'FastCopy.exe') }
    foreach ($path in $searchPaths) {
        if ($path -and (Test-Path $path)) { return (Resolve-Path $path).Path }
    }
    $inPath = Get-Command "FastCopy.exe" -ErrorAction SilentlyContinue
    if ($inPath) { return $inPath.Source }
    if ($PSScriptRoot) {
        $found = Get-ChildItem -Path $PSScriptRoot -Filter "FastCopy.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($found) { return $found.FullName }
    }
    return $null
}

function Install-FastCopyAuto {
    # Descarga el installer oficial de FastCopy (fastcopy.jp redirige a GitHub),
    # lo ejecuta silenciosamente a %LOCALAPPDATA%\AtlasPC\apps\FastCopy y
    # devuelve la ruta al .exe.
    $targetDir = Join-Path $env:LOCALAPPDATA 'AtlasPC\apps\FastCopy'
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    # URLs en orden de preferencia (version mas reciente primero).
    # fastcopy.jp hace redirect 302 a GitHub/FastCopyLab.
    $urls = @(
        'https://fastcopy.jp/archive/FastCopy5.11.2_installer.exe',
        'https://github.com/FastCopyLab/FastCopyDist2/raw/main/FastCopy5.11.2_installer.exe',
        'https://fastcopy.jp/archive/FastCopy5.9.0_installer.exe'
    )

    $installerPath = Join-Path $env:TEMP ("FastCopy-installer-" + [guid]::NewGuid().ToString('N').Substring(0,8) + ".exe")
    $ok = $false
    foreach ($url in $urls) {
        Write-Host "    Descargando: $url" -ForegroundColor Gray
        try {
            $ProgressPreference = 'SilentlyContinue'
            Invoke-WebRequest -Uri $url -OutFile $installerPath -UseBasicParsing -TimeoutSec 120 -ErrorAction Stop
            if ((Get-Item $installerPath).Length -gt 200KB) { $ok = $true; break }
        } catch {
            Write-Host "    Fallo: $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }
    if (-not $ok) { throw "No se pudo descargar el installer de FastCopy." }

    # El installer oficial de FastCopy NO es InnoSetup; es custom.
    # Switches (segun el propio instalador):
    #   /SILENT ... silent install
    #   /DIR=<dir> ... target dir
    #   /EXTRACT64 ... extraer solo archivos (sin instalar)
    #   /NOSUBDIR ... no crear subcarpeta
    #   /AGREE_LICENSE ... aceptar licencia
    # Usamos /EXTRACT64 para solo dejar los archivos en $targetDir
    # sin modificar menu inicio / Program Files / registro.
    Write-Host "    Extrayendo FastCopy a $targetDir ..." -ForegroundColor Gray
    $procArgs = @('/EXTRACT64', '/NOSUBDIR', '/AGREE_LICENSE', ("/DIR=`"$targetDir`""))
    try {
        $p = Start-Process -FilePath $installerPath -ArgumentList $procArgs -Wait -PassThru -ErrorAction Stop
        if ($p.ExitCode -ne 0) {
            Write-Host "    /EXTRACT64 termino con codigo $($p.ExitCode). Probando /SILENT install..." -ForegroundColor Yellow
            $p2 = Start-Process -FilePath $installerPath -ArgumentList @('/SILENT', '/AGREE_LICENSE', ("/DIR=`"$targetDir`"")) -Wait -PassThru -ErrorAction Stop
            if ($p2.ExitCode -ne 0) {
                Write-Host "    /SILENT tambien fallo. Ejecutando en modo interactivo..." -ForegroundColor Yellow
                Start-Process -FilePath $installerPath -Wait
            }
        }
    } catch {
        throw "Fallo ejecutando el instalador: $($_.Exception.Message)"
    } finally {
        Remove-Item $installerPath -ErrorAction SilentlyContinue
    }

    # Buscar el .exe en target (el installer puede poner FastCopy.exe directo o en subcarpeta).
    $exe = Get-ChildItem -Path $targetDir -Filter 'FastCopy.exe' -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $exe) {
        # Si el usuario eligio el default (Program Files), buscar ahi.
        $fallbacks = @(
            "$env:ProgramFiles\FastCopy\FastCopy.exe",
            "${env:ProgramFiles(x86)}\FastCopy\FastCopy.exe"
        )
        foreach ($fb in $fallbacks) {
            if (Test-Path $fb) { $exe = Get-Item $fb; break }
        }
    }
    if (-not $exe) { throw "FastCopy.exe no encontrado tras la instalacion." }
    return $exe.FullName
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
    Write-Host "    - $env:LOCALAPPDATA\AtlasPC\apps\FastCopy" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    Opciones:" -ForegroundColor Yellow
    Write-Host "      [D] Descargar automaticamente de fastcopy.jp (recomendado)" -ForegroundColor White
    Write-Host "      [S] Salir e instalarlo manualmente" -ForegroundColor White
    Write-Host ""
    $choice = Read-Host "    Seleccion [D/S]"

    if ($choice -match '^[Dd]$') {
        Write-Host ""
        Write-Host "    Descargando FastCopy..." -ForegroundColor Cyan
        try {
            $fastCopyExe = Install-FastCopyAuto
            Write-Host ""
            Write-Host "    FastCopy instalado: $fastCopyExe" -ForegroundColor Green
            Start-Sleep -Seconds 1
        } catch {
            Write-Host ""
            Write-Host "    ERROR en la descarga: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host "    Descarga manual: https://fastcopy.jp" -ForegroundColor Yellow
            Read-Host "    ENTER para salir"
            return
        }
    } else {
        Write-Host "    Abre https://fastcopy.jp y coloca FastCopy.exe en:" -ForegroundColor Gray
        Write-Host "      $env:LOCALAPPDATA\AtlasPC\apps\FastCopy\" -ForegroundColor Gray
        Read-Host "    ENTER para salir"
        return
    }
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
# Editor interactivo del archivo hosts de Windows con backups.
# Atlas PC Support - v1.0
# ============================================================

function Invoke-HostsManager {
    [CmdletBinding()]
    param()

    $hostsPath = Join-Path $env:SystemRoot 'System32\drivers\etc\hosts'

    try { $Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - GESTOR HOSTS" } catch {}

    $principal = [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin   = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    do {
        Clear-Host
        Write-Host ""
        Write-Host "  =================================================" -ForegroundColor DarkGray
        Write-Host "   ATLAS PC SUPPORT - GESTOR DEL ARCHIVO HOSTS" -ForegroundColor Yellow
        Write-Host "  =================================================" -ForegroundColor DarkGray
        Write-Host "  Ruta:  $hostsPath" -ForegroundColor Gray
        Write-Host "  Admin: $(if ($isAdmin) { 'SI' } else { 'NO (las escrituras fallaran)' })" -ForegroundColor $(if ($isAdmin) { 'Green' } else { 'Yellow' })
        Write-Host ""
        Write-Host "  Opciones:" -ForegroundColor Cyan
        Write-Host "    [1] Ver contenido actual"
        Write-Host "    [2] Hacer backup con timestamp"
        Write-Host "    [3] Agregar entrada (IP + nombre)"
        Write-Host "    [4] Eliminar lineas que contengan un nombre"
        Write-Host "    [5] Abrir en Notepad (admin)"
        Write-Host "    [6] Restaurar default (backup automatico previo)"
        Write-Host "    [Q] Salir"
        Write-Host ""
        $sel = Read-Host "  Seleccion"

        switch ($sel) {
            '1' {
                Write-Host ""
                if (Test-Path $hostsPath) {
                    Get-Content $hostsPath | ForEach-Object { Write-Host "    $_" -ForegroundColor Gray }
                } else {
                    Write-Host "  (no existe)" -ForegroundColor Red
                }
                Write-Host ""
                Read-Host "  Enter para continuar" | Out-Null
            }
            '2' {
                try {
                    $stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'
                    $backup = Join-Path (Split-Path $hostsPath) "hosts.backup.$stamp"
                    Copy-Item $hostsPath $backup -Force
                    Write-Host ""
                    Write-Host "  Backup creado: $backup" -ForegroundColor Green
                } catch {
                    Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '3' {
                $ip   = Read-Host "  IP"
                $name = Read-Host "  Nombre host"
                if ($ip -and $name) {
                    try {
                        $line = "{0}`t{1}`t# Atlas-added {2}" -f $ip, $name, (Get-Date -Format 'yyyy-MM-dd')
                        Add-Content -Path $hostsPath -Value "`r`n$line" -Encoding UTF8
                        Write-Host "  Agregada: $ip  $name" -ForegroundColor Green
                    } catch {
                        Write-Host "  Error (necesita admin?): $($_.Exception.Message)" -ForegroundColor Red
                    }
                } else {
                    Write-Host "  Cancelado (IP o nombre vacios)." -ForegroundColor Yellow
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '4' {
                $name = Read-Host "  Nombre a eliminar (lineas que lo contengan)"
                if ($name) {
                    try {
                        $pattern = [regex]::Escape($name)
                        $content = Get-Content $hostsPath
                        $kept    = $content | Where-Object { $_ -notmatch $pattern }
                        $deleted = $content.Count - $kept.Count
                        Set-Content -Path $hostsPath -Value $kept -Encoding UTF8
                        Write-Host "  Eliminadas $deleted linea(s) que contenian '$name'." -ForegroundColor Green
                    } catch {
                        Write-Host "  Error (necesita admin?): $($_.Exception.Message)" -ForegroundColor Red
                    }
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '5' {
                try {
                    Start-Process notepad.exe -ArgumentList $hostsPath -Verb RunAs
                    Write-Host "  Notepad abierto (en nueva ventana elevada)." -ForegroundColor Green
                } catch {
                    Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '6' {
                $ok = Read-Host "  Esto SOBREESCRIBE hosts. Confirmar? [s/N]"
                if ($ok -match '^[sSyY]$') {
                    try {
                        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
                        $before = Join-Path (Split-Path $hostsPath) "hosts.before-reset.$stamp"
                        Copy-Item $hostsPath $before -Force
                        $default = @"
# Copyright (c) 1993-2009 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# Localhost name resolution is handled within DNS itself.
#`t127.0.0.1`tlocalhost
#`t::1`tlocalhost
"@
                        Set-Content -Path $hostsPath -Value $default -Encoding UTF8
                        Write-Host "  hosts restaurado. Backup previo en: $before" -ForegroundColor Green
                    } catch {
                        Write-Host "  Error (necesita admin): $($_.Exception.Message)" -ForegroundColor Red
                    }
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            { $_ -match '^[qQ]$' } { return }
        }
    } while ($true)
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


# ---- tools\Invoke-PartsUpgrade.ps1 ----
# ============================================================
# Invoke-PartsUpgrade
# Parts Upgrade Advisor: RAM + CPU + Almacenamiento
# Atlas PC Support — v1.0
# ============================================================

function Invoke-PartsUpgrade {
    [CmdletBinding()]
    param()

    $ErrorActionPreference = 'Continue'
    $Host.UI.RawUI.WindowTitle = 'ATLAS PC SUPPORT - Parts Upgrade Advisor'
    try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(110, 50) } catch {}
    Clear-Host

    $script:ReporteTexto = ''
    $script:HtmlSections = @()

    function Log-Out { param([string]$Msg, [string]$Color='White', [switch]$NoNewLine)
        if ($NoNewLine) { Write-Host $Msg -ForegroundColor $Color -NoNewline }
        else { Write-Host $Msg -ForegroundColor $Color }
        $script:ReporteTexto += $Msg
        if (-not $NoNewLine) { $script:ReporteTexto += "`r`n" }
    }

    function Section-Header { param([string]$Title)
        Log-Out ''
        Log-Out ('=' * 70) 'Cyan'
        Log-Out "  $Title" 'Yellow'
        Log-Out ('=' * 70) 'Cyan'
    }

    # ================================================================
    # INFO GENERAL
    # ================================================================
    Section-Header 'ATLAS PARTS UPGRADE ADVISOR'
    Log-Out ("Fecha: {0}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm')) 'Gray'
    Log-Out ("Equipo: {0}" -f $env:COMPUTERNAME) 'Gray'

    $cs = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
    $csp = Get-CimInstance Win32_ComputerSystemProduct -ErrorAction SilentlyContinue
    $bb = Get-CimInstance Win32_BaseBoard -ErrorAction SilentlyContinue
    $chassis = Get-CimInstance Win32_SystemEnclosure -ErrorAction SilentlyContinue
    $isLaptop = $false
    if ($chassis) { foreach ($ct in $chassis.ChassisTypes) { if ($ct -in @(9,10,14,31,32)) { $isLaptop = $true; break } } }

    if ($cs) { Log-Out ("Fabricante:   {0}" -f $cs.Manufacturer) }
    if ($cs) { Log-Out ("Modelo:       {0}" -f $cs.Model) }
    if ($csp -and $csp.Name) { Log-Out ("Modelo exacto: {0}" -f $csp.Name) }
    if ($bb) { Log-Out ("Placa base:   {0} {1}" -f $bb.Manufacturer, $bb.Product) }
    Log-Out ("Form factor:  {0}" -f $(if ($isLaptop) {'Laptop'} else {'Desktop/Otro'}))

    # ================================================================
    # RAM
    # ================================================================
    Section-Header '1. MEMORIA RAM'

    try {
        $placa = Get-CimInstance Win32_PhysicalMemoryArray -ErrorAction Stop
        $modulos = @(Get-CimInstance Win32_PhysicalMemory -ErrorAction Stop)
    } catch {
        Log-Out '[ERROR] No se pudo consultar la RAM. Ejecuta como administrador.' 'Red'
        $placa = $null; $modulos = @()
    }

    $maxGB = $null
    if ($placa -and $placa.MaxCapacity -gt 0) {
        $maxGB = [math]::Round(($placa.MaxCapacity / 1024 / 1024), 0)
    }
    $slotsTotales = if ($placa) { $placa.MemoryDevices } else { 0 }
    $slotsUsados = $modulos.Count
    $slotsLibres = [Math]::Max(0, [int]$slotsTotales - [int]$slotsUsados)
    $ramTotalGB = if ($modulos) { [math]::Round((($modulos | Measure-Object Capacity -Sum).Sum / 1GB), 2) } else { 0 }

    Log-Out ("Slots totales:  {0}" -f $slotsTotales)
    Log-Out ("Slots ocupados: {0}" -f $slotsUsados)
    Log-Out ("Slots libres:   {0}" -f $slotsLibres)
    Log-Out ("RAM total:      {0} GB" -f $ramTotalGB) 'Green'
    if ($maxGB) { Log-Out ("Maximo segun BIOS: {0} GB" -f $maxGB) 'Green' }

    $ramTypes = @{}
    Log-Out ''
    Log-Out '--- Modulos instalados ---' 'Yellow'
    foreach ($ram in $modulos) {
        $capGB = [math]::Round($ram.Capacity / 1GB, 0)
        $ramTypeCode = [int]$ram.SMBIOSMemoryType
        $ramTypeMap = @{
            20='DDR'; 21='DDR2'; 24='DDR3'; 26='DDR4'; 34='DDR5'
        }
        $ramTypeName = if ($ramTypeMap.ContainsKey($ramTypeCode)) { $ramTypeMap[$ramTypeCode] } else { "Tipo $ramTypeCode" }
        $ramTypes[$ramTypeName] = $true
        $nat = $ram.Speed
        $cfg = $ram.ConfiguredClockSpeed
        $xmpFlag = if ($cfg -lt $nat) { '  [XMP APAGADO]' } else { '' }
        Log-Out ("  [{0}] {1} GB {2} @ {3}/{4} MHz  {5}  PN: {6}{7}" -f `
            $ram.DeviceLocator, $capGB, $ramTypeName, $cfg, $nat, $ram.Manufacturer, $ram.PartNumber, $xmpFlag)
    }

    # Recomendaciones RAM
    Log-Out ''
    Log-Out '--- Recomendaciones RAM ---' 'Magenta'
    $ramTypesList = @($ramTypes.Keys) -join ', '
    if ($slotsLibres -gt 0) {
        Log-Out ("[OK] Tienes {0} slot(s) libre(s). Puedes ampliar." -f $slotsLibres) 'Green'
        Log-Out ("     Compra modulos del MISMO tipo ({0}) y MISMA velocidad ({1} MHz) para modo dual-channel." -f $ramTypesList, ($modulos[0].Speed))
    } else {
        Log-Out '[!] Todos los slots estan ocupados. Para ampliar habra que reemplazar modulos por unos de mayor capacidad.' 'Yellow'
    }
    if ($ramTotalGB -lt 8) {
        Log-Out '[!] RAM total < 8 GB. Recomendado: minimo 8 GB (uso general), 16 GB (productividad), 32 GB+ (gaming/pro).' 'Yellow'
    } elseif ($ramTotalGB -lt 16) {
        Log-Out '[i] 8 GB es aceptable para uso basico, pero 16 GB es lo optimo hoy.' 'White'
    } else {
        Log-Out ("[OK] {0} GB de RAM es suficiente para la mayoria de usos." -f $ramTotalGB) 'Green'
    }
    Log-Out ''
    Log-Out '--- Precauciones al comprar RAM ---' 'Cyan'
    Log-Out '  * Mismo tipo (DDR4 con DDR4, DDR5 con DDR5, nunca mezclar).'
    Log-Out '  * Mismo form factor: DIMM (escritorio) o SO-DIMM (laptop).'
    Log-Out '  * Velocidad IGUAL o SUPERIOR al modulo existente (si pones menor, el CPU la bajara).'
    Log-Out '  * Voltaje IGUAL. Mezclar 1.35V con 1.2V da inestabilidad.'
    Log-Out '  * Marca/latencias parecidas para dual-channel limpio.'
    Log-Out '  * Verifica con CPU-Z la RAM actual antes de comprar.'

    # ================================================================
    # CPU
    # ================================================================
    Section-Header '2. CPU (Procesador)'

    $proc = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $proc) {
        Log-Out '[ERROR] No se pudo consultar el CPU.' 'Red'
    } else {
        $cpuName = if ($proc.Name) { $proc.Name.Trim() } else { 'Desconocido' }
        $cores = $proc.NumberOfCores
        $threads = $proc.NumberOfLogicalProcessors
        $socketName = if ($proc.SocketDesignation) { $proc.SocketDesignation } else { 'No reportado' }
        $upgradeCode = if ($proc.UpgradeMethod) { [int]$proc.UpgradeMethod } else { 2 }

        $upgradeMethodNames = @{
            1='Otro'; 2='Desconocido'; 3='Daughter Board'; 4='ZIF Socket'; 5='Reemplazable'
            6='Ninguno (BGA/Soldado)'; 7='LIF Socket'; 8='Slot 1'; 9='Slot 2'
            10='370-pin'; 11='Slot A'; 12='Slot M'; 13='Socket 423'; 14='Socket A (462)'
            15='Socket 478'; 16='Socket 754'; 17='Socket 940'; 18='Socket 939'
            19='mPGA604'; 20='LGA771'; 21='LGA775'; 22='S1'; 23='AM2'; 24='F (1207)'
            25='LGA1366'; 26='G34'; 27='AM3'; 28='C32'; 29='LGA1156'; 30='LGA1567'
            31='PGA988A'; 32='BGA1288'; 33='rPGA988B'; 34='BGA1023'; 35='BGA1224'
            36='LGA1155'; 37='LGA1356'; 38='LGA2011'; 39='FS1'; 40='FS2'; 41='FM1'
            42='FM2'; 43='LGA2011-3'; 44='LGA1356-3'; 45='LGA1150'; 46='BGA1168'
            47='BGA1234'; 48='BGA1364'; 49='AM4'; 50='LGA1151'; 51='BGA1356'
            52='BGA1440'; 53='BGA1515'; 54='LGA3647-1'; 55='SP3'; 56='SP3r2'
            57='LGA2066'; 58='BGA1392'; 59='BGA1510'; 60='BGA1528'; 61='LGA4189'
            62='LGA1200'; 63='LGA4677'; 64='LGA1700'; 65='BGA1744'; 66='BGA1781'
            67='BGA1211'; 68='BGA2422'; 69='LGA1211'; 70='LGA2085'; 71='LGA4710'
        }
        $upgradeMethodName = if ($upgradeMethodNames.ContainsKey($upgradeCode)) { $upgradeMethodNames[$upgradeCode] } else { "Codigo $upgradeCode" }

        # Generacion
        $gen = 0; $genLabel = ''
        if ($cpuName -match 'i[3579]-(\d{1,2})(\d{2,3})') { $gen = [int]$matches[1]; $genLabel = "Intel Gen $gen" }
        elseif ($cpuName -match 'Core\s*Ultra') { $gen = 14; $genLabel = 'Intel Core Ultra (Gen 14+)' }
        elseif ($cpuName -match 'Ryzen\s+[3579]\s+(\d)(\d{2,4})') { $gen = [int]$matches[1]; $genLabel = "AMD Ryzen Gen $gen" }
        elseif ($cpuName -match 'Athlon|A[46]-|A[46]\s|E[12]-|FX-') { $gen = 1; $genLabel = 'AMD Legacy' }

        Log-Out ("Procesador: {0}" -f $cpuName) 'Green'
        Log-Out ("Nucleos/Hilos: {0}C / {1}T" -f $cores, $threads)
        Log-Out ("Socket reportado: {0}" -f $socketName)
        Log-Out ("Upgrade method: {0}" -f $upgradeMethodName)
        if ($genLabel) { Log-Out ("Generacion: {0}" -f $genLabel) }

        # Deteccion BGA/soldado
        $bgaSignals = 0; $bgaReasons = @()
        if ($upgradeCode -eq 6) { $bgaSignals += 3; $bgaReasons += 'UpgradeMethod = None/BGA' }
        elseif ($upgradeMethodName -match 'BGA') { $bgaSignals += 3; $bgaReasons += "Socket BGA ($upgradeMethodName)" }
        if ($socketName -match 'BGA') { $bgaSignals += 2; $bgaReasons += 'Socket designado BGA' }
        if ($cpuName -match '[-\s](\d{4,5})[UYHPG]\b') { $bgaSignals += 1; $bgaReasons += 'Sufijo mobile (U/Y/H/P/G)' }
        if ($isLaptop -and $bgaSignals -ge 1) { $bgaSignals += 1; $bgaReasons += 'Equipo laptop' }

        Log-Out ''
        Log-Out '--- Reemplazable? ---' 'Magenta'
        if ($bgaSignals -ge 3) {
            Log-Out '[X] CPU SOLDADO A LA PLACA (BGA). NO es reemplazable.' 'Red'
            Log-Out '    Actualizacion: imposible salvo reemplazo completo de placa base (y con eso, el PC entero).'
        } elseif ($bgaSignals -ge 1) {
            Log-Out '[?] CPU PROBABLEMENTE SOLDADO. Verifica con el fabricante antes de comprar nada.' 'Yellow'
        } else {
            Log-Out ("[OK] CPU en SOCKET ({0}) - Reemplazable." -f $socketName) 'Green'
            Log-Out '    Puedes cambiarlo por otro CPU compatible con este socket y chipset.'
        }
        if ($bgaReasons.Count -gt 0) { Log-Out ("    Senales detectadas: {0}" -f ($bgaReasons -join ' | ')) 'DarkGray' }

        # Recomendaciones CPU
        Log-Out ''
        Log-Out '--- Recomendaciones CPU ---' 'Magenta'
        if ($bgaSignals -ge 3) {
            Log-Out '  No hay upgrade posible. Si quieres mas rendimiento, considera un equipo nuevo o SSD+RAM para extender vida util.'
        } else {
            Log-Out ("  1) Anota el socket: {0}" -f $socketName)
            Log-Out "  2) Busca el modelo exacto de la placa base (arriba) y descarga su 'CPU Support List' oficial."
            Log-Out '  3) Revisa requisito de BIOS: muchos chipsets Intel/AMD requieren actualizar BIOS antes de poner CPU mas nuevo.'
            Log-Out '  4) Compara TDP: un CPU con TDP superior al del disipador actual podra pero termicamente castigado. Cambia disipador si subes de 65W a 95W+.'
            Log-Out '  5) Verifica generacion compatible: no todos los sockets admiten todas las gens (ej: LGA1200 admite 10th/11th gen solo).'
        }
        Log-Out ''
        Log-Out '--- Precauciones al comprar CPU ---' 'Cyan'
        Log-Out '  * Socket y chipset compatibles (no solo el socket fisico).'
        Log-Out '  * BIOS actualizada a version que soporte el CPU objetivo.'
        Log-Out '  * TDP compatible con el disipador/fuente. Si subes TDP, cambia pasta termica minimo.'
        Log-Out '  * En laptops: casi SIEMPRE soldado. Ahorrate tiempo, no hay upgrade.'
        Log-Out '  * Si el CPU viene sin fan (tipo "tray" o "OEM"), compra uno aparte.'
    }

    # ================================================================
    # ALMACENAMIENTO
    # ================================================================
    Section-Header '3. ALMACENAMIENTO (Discos y slots)'

    $physDisks = @(Get-PhysicalDisk -ErrorAction SilentlyContinue)
    $nvmeCount = 0; $sataSsdCount = 0; $hddCount = 0; $usbCount = 0

    if ($physDisks.Count -eq 0) {
        Log-Out '[ERROR] No se pudieron enumerar discos.' 'Red'
    } else {
        Log-Out '--- Discos instalados ---' 'Yellow'
        foreach ($pd in $physDisks) {
            $name = if ($pd.FriendlyName) { $pd.FriendlyName } else { 'Disco' }
            $bus = if ($pd.BusType) { $pd.BusType.ToString() } else { '?' }
            $media = if ($pd.MediaType) { $pd.MediaType.ToString() } else { '?' }
            $sizeGB = if ($pd.Size) { [math]::Round($pd.Size / 1GB, 0) } else { 0 }
            $health = if ($pd.HealthStatus) { $pd.HealthStatus.ToString() } else { '?' }

            $kind = 'Otro'
            if ($bus -match 'NVMe') { $kind = 'NVMe (M.2)'; $nvmeCount++ }
            elseif ($bus -match 'USB') { $kind = 'USB externo'; $usbCount++ }
            elseif ($media -match 'HDD') { $kind = 'HDD mecanico'; $hddCount++ }
            elseif ($media -match 'SSD' -and $bus -match 'SATA|ATA') { $kind = 'SSD SATA'; $sataSsdCount++ }
            elseif ($bus -match 'SATA|ATA') {
                if ($sizeGB -lt 300) { $kind = 'SSD SATA (inferido)'; $sataSsdCount++ }
                else { $kind = 'HDD (inferido)'; $hddCount++ }
            }

            Log-Out ("  {0}  [{1}]  bus={2}  media={3}  tam={4} GB  salud={5}" -f $kind, $name, $bus, $media, $sizeGB, $health)
        }
    }

    Log-Out ''
    Log-Out '--- Resumen almacenamiento ---' 'Yellow'
    Log-Out ("  NVMe (M.2):    {0}" -f $nvmeCount)
    Log-Out ("  SSD SATA:      {0}" -f $sataSsdCount)
    Log-Out ("  HDD mecanico:  {0}" -f $hddCount)
    Log-Out ("  USB externo:   {0}" -f $usbCount)

    # Slots disponibles - inferencia
    Log-Out ''
    Log-Out '--- Slots fisicos disponibles (inferencia) ---' 'Magenta'
    Log-Out 'Windows NO expone directamente "slots M.2 libres". Se infiere del modelo de placa base.'
    if ($bb) {
        Log-Out ("Placa base detectada: {0} {1}" -f $bb.Manufacturer, $bb.Product) 'Cyan'
        Log-Out 'Para saber slots reales:'
        $searchQuery = [uri]::EscapeDataString(("{0} {1} specifications M.2 SATA slots" -f $bb.Manufacturer, $bb.Product))
        Log-Out ("  1) Busca en Google: {0} specifications M.2 SATA slots" -f "$($bb.Manufacturer) $($bb.Product)")
        Log-Out ("  2) URL directa: https://www.google.com/search?q={0}" -f $searchQuery)
    } else {
        Log-Out 'No se pudo detectar modelo de placa base. Consulta etiqueta fisica o CPU-Z -> Mainboard.'
    }
    Log-Out ''
    if ($isLaptop) {
        Log-Out 'En laptops tipicos:'
        Log-Out '  - 1 slot M.2 NVMe (a veces 2 en gaming).'
        Log-Out '  - A veces 1 bahia 2.5" SATA (cada vez menos comun).'
        Log-Out '  - Rara vez se puede anadir disco sin desmontar.'
    } else {
        Log-Out 'En desktop tipico (ATX mid-range):'
        Log-Out '  - 1-3 slots M.2 (uno suele ser PCIe 4.0 o superior, otros PCIe 3.0).'
        Log-Out '  - 2-6 puertos SATA (para SSD 2.5" o HDD 3.5").'
        Log-Out '  - Verifica M.2: algunos slots son M.2 SATA, otros M.2 NVMe, otros ambos ("combo").'
    }

    # Recomendaciones storage
    Log-Out ''
    Log-Out '--- Recomendaciones almacenamiento ---' 'Magenta'
    if ($hddCount -gt 0 -and $nvmeCount -eq 0 -and $sataSsdCount -eq 0) {
        Log-Out '[!!] El SISTEMA arranca de HDD. Migrar a SSD da 5-10x mejora percibida. Prioridad MAXIMA.' 'Red'
    } elseif ($hddCount -gt 0) {
        Log-Out '[i] Tienes HDD presente. Util para datos/backup. Sistema deberia estar en SSD (ya parece serlo).'
    }
    if ($nvmeCount -eq 0 -and -not $isLaptop) {
        Log-Out '[i] Sin NVMe. Considera migrar a M.2 NVMe para lectura secuencial >3 GB/s (SATA SSD tope es 550 MB/s).'
    }
    Log-Out ''
    Log-Out '--- Precauciones al comprar almacenamiento ---' 'Cyan'
    Log-Out '  * M.2 NVMe vs M.2 SATA: NO son intercambiables. Verifica cual admite tu slot.'
    Log-Out '  * PCIe 4.0 vs 3.0: un SSD PCIe 4.0 funciona en slot PCIe 3.0 pero limitado a la velocidad del slot.'
    Log-Out '  * Tamano M.2: 2280 es el estandar (80 mm). 2230/2242 existen en laptops ultraslim.'
    Log-Out '  * DRAM cache: SSDs sin DRAM (QLC low-end) se degradan rapido con cargas sostenidas.'
    Log-Out '  * TBW (terabytes writes): revisa endurance antes de comprar para servidor/editor de video.'
    Log-Out '  * Compra SSD >= 500 GB (el coste GB es casi igual y rendimiento mejora).'
    Log-Out '  * Clona con herramienta del fabricante (Samsung Magician, Crucial Storage Executive, etc) o Macrium Reflect.'

    # ================================================================
    # OTROS COMPONENTES (complementos)
    # ================================================================
    Section-Header '4. OTROS COMPONENTES'

    # GPU
    $gpus = @(Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue | Where-Object { $_.Name -notmatch 'Microsoft Basic|Remote' })
    if ($gpus.Count -gt 0) {
        Log-Out '--- GPU ---' 'Yellow'
        foreach ($g in $gpus) {
            $vram = if ($g.AdapterRAM -gt 0) { [math]::Round($g.AdapterRAM / 1MB, 0) } else { 0 }
            Log-Out ("  {0} ({1} MB VRAM reportado)" -f $g.Name, $vram)
        }
        if ($isLaptop) {
            Log-Out '  [i] GPU en laptops NO es upgradeable (soldada al mainboard o en MXM raro).' 'Yellow'
        } else {
            Log-Out '  [i] GPU en desktop: upgradeable si tienes PCIe libre y fuente suficiente (W).' 'Green'
            Log-Out '  [!] Al comprar GPU verifica: conector (8/6/12VHPWR), largo fisico (caja), TDP vs fuente, slot PCIe.' 'Cyan'
        }
    }

    # PSU - limitado en info
    Log-Out ''
    Log-Out '--- Fuente de poder (PSU) ---' 'Yellow'
    Log-Out '  Windows NO expone la marca/wattage de la PSU. Revisa la etiqueta fisica dentro de la caja.'
    Log-Out '  Para upgrade de GPU o CPU potente: verifica que la fuente sea 80+ Bronze o superior y con wattage suficiente.'

    # BIOS
    Log-Out ''
    Log-Out '--- BIOS / UEFI ---' 'Yellow'
    try {
        $bios = Get-CimInstance Win32_BIOS -ErrorAction Stop
        Log-Out ("  Version:  {0}" -f $bios.SMBIOSBIOSVersion)
        $biosDate = $null
        if ($bios.ReleaseDate) {
            try { $biosDate = [Management.ManagementDateTimeConverter]::ToDateTime($bios.ReleaseDate) } catch {}
        }
        if ($biosDate) {
            $ageYears = [math]::Round(((Get-Date) - $biosDate).TotalDays / 365.25, 1)
            Log-Out ("  Fecha:    {0} (hace {1} anios)" -f $biosDate.ToString('yyyy-MM-dd'), $ageYears)
            if ($ageYears -gt 3) {
                Log-Out '  [!] BIOS antigua. Actualizarla puede habilitar CPUs nuevos y corregir bugs. Revisa la web del fabricante.' 'Yellow'
            }
        }
    } catch {
        Log-Out '  No se pudo leer BIOS.' 'Red'
    }

    # ================================================================
    # EXPORT
    # ================================================================
    Section-Header 'EXPORTAR REPORTE'
    Log-Out ' [1] Guardar TXT en Escritorio'
    Log-Out ' [2] Guardar HTML en Escritorio'
    Log-Out ' [3] Salir sin guardar'
    Log-Out ''
    $opc = Read-Host ' Elige opcion'
    $base = "PartsUpgrade_$(Get-Date -Format 'yyyyMMdd_HHmm')"
    $desk = [Environment]::GetFolderPath('Desktop')
    switch ($opc) {
        '1' {
            $p = Join-Path $desk "$base.txt"
            [System.IO.File]::WriteAllText($p, $script:ReporteTexto, [System.Text.UTF8Encoding]::new($true))
            Log-Out ''
            Log-Out ("[OK] TXT guardado: {0}" -f $p) 'Green'
            try { Start-Process notepad.exe $p } catch {}
        }
        '2' {
            $p = Join-Path $desk "$base.html"
            $style = @'
<style>
body{font-family:Segoe UI,sans-serif;background:#1e1e1e;color:#e0e0e0;padding:20px}
h1{color:#0078D7;border-bottom:2px solid #0078D7;padding-bottom:5px}
h2{color:#00A8FF;margin-top:25px}
pre{background:#2d2d2d;border:1px solid #444;padding:15px;border-radius:5px;font-size:13px;white-space:pre-wrap}
.foot{color:#888;text-align:center;margin-top:30px;font-size:11px}
</style>
'@
            $escaped = [System.Web.HttpUtility]::HtmlEncode($script:ReporteTexto)
            if (-not $escaped) {
                $escaped = $script:ReporteTexto -replace '&','&amp;' -replace '<','&lt;' -replace '>','&gt;'
            }
            $html = "<html><head><meta charset='UTF-8'><title>Parts Upgrade - $env:COMPUTERNAME</title>$style</head><body><h1>Atlas PC Support - Parts Upgrade Advisor</h1><pre>$escaped</pre><div class='foot'>Generado $(Get-Date)</div></body></html>"
            [System.IO.File]::WriteAllText($p, $html, [System.Text.UTF8Encoding]::new($true))
            Log-Out ''
            Log-Out ("[OK] HTML guardado: {0}" -f $p) 'Green'
            try { Start-Process $p } catch {}
        }
        default { Log-Out 'Saliendo sin guardar.' 'DarkGray' }
    }
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
# La tool se ejecuta inline (no desde un .ps1 fisico), asi que
# $MyInvocation.MyCommand.Definition devuelve el cuerpo de la funcion.
# Buscar wallpaper.jpg en %LOCALAPPDATA%\AtlasPC (ubicacion documentada).
$ScriptPath = if ($env:LOCALAPPDATA) { Join-Path $env:LOCALAPPDATA 'AtlasPC' } else { $env:TEMP }
if (-not (Test-Path $ScriptPath)) { New-Item -ItemType Directory -Path $ScriptPath -Force | Out-Null }

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
# Optimizacion de servicios con UNDO + analisis de seguridad.
# Atlas PC Support - v2.0
# ============================================================

function Invoke-StopServices {
    [CmdletBinding()]
    param()

    try { $Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - STOP SERVICES" } catch {}
    Clear-Host

    # Directorio de backup
    $backupDir = Join-Path $env:LOCALAPPDATA 'AtlasPC'
    if (-not (Test-Path $backupDir)) {
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
    }
    $backupFile = Join-Path $backupDir 'services-backup.json'

    # ============================================================
    # LISTA DE SERVICIOS
    # Tier SAFE     : seguros en 99% de equipos (Xbox, telemetria, fax).
    # Tier MODERATE : dependen del uso (SensorService en laptops, WbioSrvc si
    #                 usas Windows Hello, etc). Se piden confirmaciones extra.
    # Cada entrada incluye 'Requires' con IDs de situaciones en las que el
    # servicio SI hace falta, para imprimir advertencias.
    # ============================================================

    $serviciosAOptimizar = @(
        # --- TIER SAFE ---
        @{ Name='DiagTrack';           Tier='SAFE'; Desc='Telemetria (Connected User Experiences)'; Note='No afecta funcionalidad.' },
        @{ Name='dmwappushservice';    Tier='SAFE'; Desc='WAP Push Message Routing';                 Note='Solo afecta SMS push en empresa.' },
        @{ Name='WerSvc';              Tier='SAFE'; Desc='Reporte de errores de Windows';           Note='Solo deja de mandar crashes a MS.' },
        @{ Name='wisvc';               Tier='SAFE'; Desc='Windows Insider';                         Note='Solo si no eres Insider.' },
        @{ Name='PcaSvc';              Tier='SAFE'; Desc='Asistente de compatibilidad programas';   Note='Solo deja de sugerir "ejecutar en modo compat".' },
        @{ Name='XblAuthManager';      Tier='SAFE'; Desc='Xbox Live Auth';                           Note='Si NO juegas a juegos Microsoft Store.' },
        @{ Name='XblGameSave';         Tier='SAFE'; Desc='Xbox Live Game Save';                      Note='Si NO juegas a juegos Microsoft Store.' },
        @{ Name='XboxNetApiSvc';       Tier='SAFE'; Desc='Xbox Live Networking';                     Note='Si NO juegas a juegos Microsoft Store.' },
        @{ Name='XboxGipSvc';          Tier='SAFE'; Desc='Xbox Game Input Protocol';                 Note='Si NO usas mando Xbox por USB/Bluetooth.' },
        @{ Name='MapsBroker';          Tier='SAFE'; Desc='Mapas offline (Windows Maps)';             Note='Solo afecta app Mapas de MS.' },
        @{ Name='WalletService';       Tier='SAFE'; Desc='Cartera (Microsoft Wallet)';               Note='App discontinuada.' },
        @{ Name='RetailDemo';          Tier='SAFE'; Desc='Modo demo de tienda';                      Note='Solo para PCs de demostracion en tiendas.' },
        @{ Name='Fax';                 Tier='SAFE'; Desc='Fax';                                       Note='Quien usa fax hoy.' },
        @{ Name='RemoteRegistry';      Tier='SAFE'; Desc='Registro remoto (vector de ataque)';      Note='Deshabilitarlo MEJORA seguridad.' },

        # --- TIER MODERATE ---
        @{ Name='TabletInputService';  Tier='MODERATE'; Desc='Entrada tactil / lapiz';               Note='ROMPE: pantallas tactiles, tablets, Surface.' },
        @{ Name='SensorService';       Tier='MODERATE'; Desc='Servicio de sensores';                 Note='ROMPE: rotacion pantalla, auto-brillo (laptops).' },
        @{ Name='SensorDataService';   Tier='MODERATE'; Desc='Datos de sensores';                    Note='Lo mismo que SensorService.' },
        @{ Name='SensrSvc';            Tier='MODERATE'; Desc='Supervision de sensores';              Note='Lo mismo que SensorService.' },
        @{ Name='WbioSrvc';            Tier='MODERATE'; Desc='Biometria (huellas / Windows Hello)'; Note='ROMPE: huella y reconocimiento facial.' },
        @{ Name='Spooler';             Tier='MODERATE'; Desc='Print Spooler';                        Note='ROMPE: impresion. Si NO imprimes, tambien cierra CVE tipo PrintNightmare.' },
        @{ Name='WSearch';             Tier='MODERATE'; Desc='Indexador de Windows Search';          Note='ROMPE: busquedas rapidas Explorer y Outlook.' },
        @{ Name='Bthserv';             Tier='MODERATE'; Desc='Bluetooth Support';                    Note='ROMPE: Bluetooth (si no usas nada BT, se puede).' }
    )

    function Show-Header {
        Clear-Host
        Write-Host ''
        Write-Host '  =================================================' -ForegroundColor DarkGray
        Write-Host '   ATLAS PC SUPPORT - OPTIMIZACION DE SERVICIOS v2' -ForegroundColor Yellow
        Write-Host '  =================================================' -ForegroundColor DarkGray
        Write-Host ''
    }

    function Check-Admin {
        $p = [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
        return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }

    function List-Services {
        param([string]$TierFilter = '')
        $out = @()
        foreach ($s in $serviciosAOptimizar) {
            if ($TierFilter -and $s.Tier -ne $TierFilter) { continue }
            $svc = Get-Service -Name $s.Name -ErrorAction SilentlyContinue
            if (-not $svc) { continue }
            try {
                $svcCim = Get-CimInstance -ClassName Win32_Service -Filter "Name='$($s.Name)'" -ErrorAction SilentlyContinue
                $startMode = if ($svcCim) { $svcCim.StartMode } else { '?' }
            } catch { $startMode = '?' }
            $out += [pscustomobject]@{
                Name      = $s.Name
                Desc      = $s.Desc
                Note      = $s.Note
                Tier      = $s.Tier
                Status    = $svc.Status
                StartMode = $startMode
            }
        }
        return $out
    }

    function Apply-Stop {
        param($Targets)
        if (-not (Check-Admin)) {
            Write-Host ''
            Write-Host '  [X] ADMIN requerido. Relanza con privilegios.' -ForegroundColor Red
            return $false
        }

        # Backup estado previo
        $backup = @()
        foreach ($t in $Targets) {
            $svc = Get-Service -Name $t.Name -ErrorAction SilentlyContinue
            if (-not $svc) { continue }
            $cim = Get-CimInstance -ClassName Win32_Service -Filter "Name='$($t.Name)'" -ErrorAction SilentlyContinue
            $backup += [pscustomobject]@{
                Name      = $t.Name
                Status    = $svc.Status.ToString()
                StartMode = if ($cim) { $cim.StartMode } else { 'Unknown' }
                Timestamp = (Get-Date).ToString('s')
            }
        }
        # Append a historial de backups (no sobrescribir para permitir multiples undos)
        $history = @()
        if (Test-Path $backupFile) {
            try { $history = @(Get-Content $backupFile -Raw | ConvertFrom-Json) } catch { $history = @() }
        }
        $entry = [pscustomobject]@{
            Timestamp = (Get-Date).ToString('s')
            Services  = $backup
        }
        $history = @($history) + @($entry)
        $history | ConvertTo-Json -Depth 5 | Out-File -FilePath $backupFile -Encoding UTF8
        Write-Host ''
        Write-Host ("  [i] Backup guardado: {0}" -f $backupFile) -ForegroundColor DarkGray
        Write-Host ''

        foreach ($t in $Targets) {
            try {
                Stop-Service -Name $t.Name -Force -ErrorAction Stop
                Set-Service  -Name $t.Name -StartupType Manual -ErrorAction Stop
                Write-Host ("  [OK]   {0,-22} detenido y marcado Manual" -f $t.Name) -ForegroundColor Green
            } catch {
                Write-Host ("  [ERR]  {0,-22} {1}" -f $t.Name, $_.Exception.Message) -ForegroundColor Red
            }
        }
        return $true
    }

    function Apply-Undo {
        if (-not (Check-Admin)) {
            Write-Host ''
            Write-Host '  [X] ADMIN requerido. Relanza con privilegios.' -ForegroundColor Red
            return
        }
        if (-not (Test-Path $backupFile)) {
            Write-Host ''
            Write-Host '  [!] No hay backup. No se ha optimizado nada desde este tool.' -ForegroundColor Yellow
            return
        }
        try {
            $history = @(Get-Content $backupFile -Raw | ConvertFrom-Json)
        } catch {
            Write-Host ''
            Write-Host '  [X] Backup corrupto.' -ForegroundColor Red
            return
        }
        if ($history.Count -eq 0) {
            Write-Host ''
            Write-Host '  [!] Backup vacio.' -ForegroundColor Yellow
            return
        }

        Write-Host ''
        Write-Host '  === PUNTOS DE RESTAURACION ===' -ForegroundColor Yellow
        Write-Host ''
        $i = 1
        foreach ($e in $history) {
            $n = @($e.Services).Count
            Write-Host ("  [{0}] {1} - {2} servicios afectados" -f $i, $e.Timestamp, $n) -ForegroundColor White
            $i++
        }
        Write-Host ''
        Write-Host '  [0] Cancelar' -ForegroundColor DarkGray
        Write-Host ''
        $sel = Read-Host '  Que backup restaurar?'
        if ($sel -match '^\d+$' -and [int]$sel -ge 1 -and [int]$sel -le $history.Count) {
            $entry = $history[[int]$sel - 1]
            foreach ($s in $entry.Services) {
                $modeMap = @{ 'Auto' = 'Automatic'; 'Automatic' = 'Automatic'; 'Manual' = 'Manual'; 'Disabled' = 'Disabled'; 'Boot' = 'Boot'; 'System' = 'System' }
                $mode = if ($modeMap.ContainsKey($s.StartMode)) { $modeMap[$s.StartMode] } else { 'Manual' }
                try {
                    Set-Service -Name $s.Name -StartupType $mode -ErrorAction Stop
                    if ($s.Status -eq 'Running') {
                        Start-Service -Name $s.Name -ErrorAction SilentlyContinue
                    }
                    Write-Host ("  [OK]   {0,-22} modo={1,-10} estado_prev={2}" -f $s.Name, $mode, $s.Status) -ForegroundColor Green
                } catch {
                    Write-Host ("  [ERR]  {0,-22} {1}" -f $s.Name, $_.Exception.Message) -ForegroundColor Red
                }
            }
            Write-Host ''
            Write-Host '  Restauracion completa.' -ForegroundColor Cyan
        } else {
            Write-Host '  Cancelado.' -ForegroundColor DarkGray
        }
    }

    function Show-ServicesTable {
        param($List)
        Write-Host ('  {0,-22} {1,-6} {2,-10} {3,-10} {4}' -f 'Servicio', 'Tier', 'Estado', 'StartMode', 'Descripcion') -ForegroundColor Cyan
        Write-Host ('  ' + ('-' * 90)) -ForegroundColor DarkGray
        foreach ($r in $List) {
            $color = if ($r.Status -eq 'Running') { 'Green' } else { 'DarkGray' }
            $flag  = if ($r.Status -eq 'Running') { 'R' } else { '-' }
            Write-Host ("  {0,-22} {1,-6} {2,-10} {3,-10} {4}" -f $r.Name, $r.Tier, $r.Status, $r.StartMode, $r.Desc) -ForegroundColor $color
            Write-Host ("  {0,22}   note: {1}" -f '', $r.Note) -ForegroundColor DarkGray
        }
    }

    # ============================================================
    # MENU PRINCIPAL
    # ============================================================
    while ($true) {
        Show-Header
        Write-Host '  [1] Ver estado actual de los servicios candidatos' -ForegroundColor White
        Write-Host '  [2] Detener servicios SEGUROS (SAFE) - recomendado' -ForegroundColor Green
        Write-Host '  [3] Detener ADEMAS servicios MODERADOS (avanzado)' -ForegroundColor Yellow
        Write-Host '  [4] UNDO - Restaurar un backup previo' -ForegroundColor Cyan
        Write-Host '  [5] Ver advertencias de cada servicio' -ForegroundColor DarkCyan
        Write-Host '  [Q] Salir'
        Write-Host ''
        $sel = Read-Host '  Seleccion'

        switch -regex ($sel) {
            '^1$' {
                Show-Header
                $list = List-Services
                if ($list.Count -eq 0) {
                    Write-Host '  No se detecto ningun servicio de la lista en este Windows.' -ForegroundColor Yellow
                } else {
                    Show-ServicesTable $list
                }
                Write-Host ''
                Read-Host '  ENTER para volver' | Out-Null
            }
            '^2$' {
                Show-Header
                Write-Host '  Detendra SOLO servicios del tier SAFE (no rompen nada en un PC normal).' -ForegroundColor Green
                Write-Host ''
                $list = List-Services -TierFilter 'SAFE' | Where-Object { $_.Status -eq 'Running' }
                if ($list.Count -eq 0) {
                    Write-Host '  No hay servicios SAFE en ejecucion. Ya esta optimizado.' -ForegroundColor Cyan
                    Read-Host '  ENTER' | Out-Null
                    continue
                }
                Show-ServicesTable $list
                Write-Host ''
                $c = Read-Host '  Proceder? [S/N]'
                if ($c -match '^[SsYy]$') {
                    Apply-Stop -Targets $list | Out-Null
                }
                Write-Host ''
                Read-Host '  ENTER' | Out-Null
            }
            '^3$' {
                Show-Header
                Write-Host '  MODO AVANZADO: se detendran ADEMAS servicios MODERADOS.' -ForegroundColor Yellow
                Write-Host '  Revisa la nota de CADA servicio antes de decir SI.' -ForegroundColor Yellow
                Write-Host ''
                $list = List-Services | Where-Object { $_.Status -eq 'Running' }
                if ($list.Count -eq 0) {
                    Write-Host '  Ya esta todo detenido.' -ForegroundColor Cyan
                    Read-Host '  ENTER' | Out-Null
                    continue
                }
                Show-ServicesTable $list
                Write-Host ''
                $c = Read-Host '  Proceder con TODOS los detectados? [S/N]'
                if ($c -match '^[SsYy]$') {
                    Apply-Stop -Targets $list | Out-Null
                }
                Write-Host ''
                Read-Host '  ENTER' | Out-Null
            }
            '^4$' {
                Show-Header
                Apply-Undo
                Write-Host ''
                Read-Host '  ENTER' | Out-Null
            }
            '^5$' {
                Show-Header
                Write-Host '  --- ADVERTENCIAS POR SERVICIO ---' -ForegroundColor Yellow
                Write-Host ''
                foreach ($s in $serviciosAOptimizar) {
                    $col = if ($s.Tier -eq 'SAFE') { 'Green' } else { 'Yellow' }
                    Write-Host ("  [{0}] {1,-22} ({2})" -f $s.Tier, $s.Name, $s.Desc) -ForegroundColor $col
                    Write-Host ("        {0}" -f $s.Note) -ForegroundColor Gray
                    Write-Host ''
                }
                Read-Host '  ENTER' | Out-Null
            }
            '^[Qq]$' { return }
            default { Write-Host '  Opcion no valida.' -ForegroundColor Red; Start-Sleep 1 }
        }
    }
}


# ============================================================
#  SOURCES CRUDOS (base64) — usados por ToolRunner
# ============================================================

$script:AtlasToolSources = @{}
$script:AtlasToolSources['Invoke-AuditoriaRouter'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtQXVkaXRvcmlhUm91dGVyCiMgTWlncmFkbyBkZTogQXVkaXRvcmlhUm91dGVyLnBzMQojIEF0bGFzIFBDIFN1cHBvcnQg4oCUIHYxLjAKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIEludm9rZS1BdWRpdG9yaWFSb3V0ZXIgewogICAgW0NtZGxldEJpbmRpbmcoKV0KICAgIHBhcmFtKAogICAgICAgICMgTW9kdWxvIE86IGxhbnphIGVsIGluZm9ybWUgY29tcGxldG8gc2luIGludGVyYWNjaW9uCiAgICAgICAgW3N3aXRjaF0kQXV0bwogICAgKQojICgjUmVxdWlyZXMgbW92aWRvIGFsIGxhdW5jaGVyIHByaW5jaXBhbCkKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIEF0bGFzIFBDIFN1cHBvcnQgLSBIZXJyYW1pZW50YXMgZGUgUmVkICB2My4wCiMgIENvbXBhdGliaWxpZGFkOiBXaW5kb3dzIDEwIC8gMTEgLyBTZXJ2ZXIgMjAxOSssIFBTIDUrCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpbY29uc29sZV06OkJhY2tncm91bmRDb2xvciA9ICJCbGFjayIKW2NvbnNvbGVdOjpGb3JlZ3JvdW5kQ29sb3IgPSAiR3JheSIKQ2xlYXItSG9zdAoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIFZBUklBQkxFUyBHTE9CQUxFUyBERSBTRVNJT04KIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiRzY3JpcHQ6SGlzdG9yaWFsU2VzaW9uID0gW1N5c3RlbS5Db2xsZWN0aW9ucy5HZW5lcmljLkxpc3Rbc3RyaW5nXV06Om5ldygpCiRzY3JpcHQ6QXJjaGl2b0VzdGFkbyAgID0gIiRlbnY6VEVNUFxBdGxhc1JlZF9VbHRpbW9Fc2NhbmVvLnR4dCIKJHNjcmlwdDpNb3N0cmFySW5mbyAgICAgPSAkdHJ1ZSAgICAgICAgIyBFbCB1c3VhcmlvIHB1ZWRlIGRlc2hhYmlsaXRhcmxvIGNvbiBYIGVuIGxhIGluZm8gY2FyZAokc2NyaXB0Ok1vZG9BdXRvICAgICAgICA9ICRBdXRvLklzUHJlc2VudAoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIFRBQkxBIE9VSSAtIFByZWZpam9zIE1BQyAoMyBvY3RldG9zKSAtPiBGYWJyaWNhbnRlCiMgIH4yMDAgZW50cmFkYXMgZGUgbG9zIGZhYnJpY2FudGVzIG1hcyBjb211bmVzIGVuIHJlZGVzIGRvbWVzdGljYXMKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiRzY3JpcHQ6T1VJID0gQHsKICAgICMgQXBwbGUKICAgICIwMC0xNy1GMiI9IkFwcGxlIjsiMDAtMUMtQkYiPSJBcHBsZSI7IjAwLTFFLTUyIj0iQXBwbGUiOyIwMC0yMy0xMiI9IkFwcGxlIgogICAgIjAwLTI2LUI5Ij0iQXBwbGUiOyIzQy0wNy01NCI9IkFwcGxlIjsiRjQtRjEtNUEiPSJBcHBsZSI7IjA0LTE1LTUyIj0iQXBwbGUiCiAgICAiMDQtMjYtNjUiPSJBcHBsZSI7IjYwLTAzLTA4Ij0iQXBwbGUiOyI2MC1DNS00NyI9IkFwcGxlIjsiNzAtRUMtRTQiPSJBcHBsZSIKICAgICI3OC1ENy01RiI9IkFwcGxlIjsiQTQtNUUtNjAiPSJBcHBsZSI7IkFDLTg3LUEzIj0iQXBwbGUiOyJCOC04RC0xMiI9IkFwcGxlIgogICAgIkM4LUJDLUM4Ij0iQXBwbGUiOyJGMC1CNC03OSI9IkFwcGxlIjsiRDgtQkItQzEiPSJBcHBsZSI7IkUwLUFDLUNCIj0iQXBwbGUiCiAgICAiMDAtRjctNkYiPSJBcHBsZSI7IjA0LTRCLUVEIj0iQXBwbGUiOyIwNC1FNS0zNiI9IkFwcGxlIjsiMDgtNzQtMDIiPSJBcHBsZSIKICAgICIwQy00RC1FOSI9IkFwcGxlIjsiMTAtNDEtN0YiPSJBcHBsZSI7IjE0LTVBLTA1Ij0iQXBwbGUiOyIxOC02NS05MCI9IkFwcGxlIgogICAgIjFDLTM2LUJCIj0iQXBwbGUiOyIyMC03OC1GMCI9IkFwcGxlIjsiMjQtQTAtNzQiPSJBcHBsZSI7IjI4LTVBLUVCIj0iQXBwbGUiCiAgICAiMzQtMTUtOUUiPSJBcHBsZSI7IjM4LUM5LTg2Ij0iQXBwbGUiOyIzQy0xNS1DMiI9IkFwcGxlIjsiNDAtMzAtMDQiPSJBcHBsZSIKICAgICI0NC0wMC0xMCI9IkFwcGxlIjsiNDgtNjAtQkMiPSJBcHBsZSI7IjRDLTU3LUNBIj0iQXBwbGUiOyI1MC1FQS1ENiI9IkFwcGxlIgogICAgIjU0LTI2LTk2Ij0iQXBwbGUiOyI1OC01NS1DQSI9IkFwcGxlIjsiNUMtOEQtNEUiPSJBcHBsZSI7IjYwLTlBLTEwIj0iQXBwbGUiCiAgICAiNjQtQTMtQ0IiPSJBcHBsZSI7IjY4LUFCLTFFIj0iQXBwbGUiOyI2Qy00MC0wOCI9IkFwcGxlIjsiNzAtMTQtQTYiPSJBcHBsZSIKICAgICI3NC1FMS1CNiI9IkFwcGxlIjsiNzgtQ0EtMzkiPSJBcHBsZSI7IjdDLTZELTYyIj0iQXBwbGUiOyI4MC04Mi0yMyI9IkFwcGxlIgogICAgIjg0LTM4LTM1Ij0iQXBwbGUiOyI4OC0xRi1BMSI9IkFwcGxlIjsiOEMtN0ItOUQiPSJBcHBsZSI7IjkwLTNDLTkyIj0iQXBwbGUiCiAgICAiOTQtRjYtQTMiPSJBcHBsZSI7Ijk4LTAxLUE3Ij0iQXBwbGUiOyI5Qy0yMC03QiI9IkFwcGxlIjsiQTAtOTktOUIiPSJBcHBsZSIKICAgICJBNC1DMy02MSI9IkFwcGxlIjsiQTgtNUItNzgiPSJBcHBsZSI7IkFDLTNDLTBCIj0iQXBwbGUiOyJCMC0zNC05NSI9IkFwcGxlIgogICAgIkI0LTE4LUQxIj0iQXBwbGUiOyJCOC0wOS04QSI9IkFwcGxlIjsiQkMtM0ItQUYiPSJBcHBsZSI7IkMwLTlGLTQyIj0iQXBwbGUiCiAgICAiQzQtMkMtMDMiPSJBcHBsZSI7IkM4LTJBLTE0Ij0iQXBwbGUiOyJDQy00NC02MyI9IkFwcGxlIjsiRDAtMDMtNEIiPSJBcHBsZSIKICAgICJENC02MS05RCI9IkFwcGxlIjsiRDgtMUQtNzIiPSJBcHBsZSI7IkRDLTJCLTJBIj0iQXBwbGUiOyJFMC01Ri00NSI9IkFwcGxlIgogICAgIkU0LUNFLThGIj0iQXBwbGUiOyJFOC04MC0yRSI9IkFwcGxlIjsiRUMtMzUtODYiPSJBcHBsZSI7IkYwLURDLUUyIj0iQXBwbGUiCiAgICAiRjQtMzEtQzMiPSJBcHBsZSI7IkY4LTFFLURGIj0iQXBwbGUiOyJGQy0yNS0zRiI9IkFwcGxlIgogICAgIyBUUC1MaW5rCiAgICAiMDAtMEEtRUIiPSJUUC1MaW5rIjsiMTQtQ0YtOTIiPSJUUC1MaW5rIjsiMTgtRDYtQzciPSJUUC1MaW5rIjsiMjAtREMtRTYiPSJUUC1MaW5rIgogICAgIjI4LTI4LTVEIj0iVFAtTGluayI7IjMwLURFLTRCIj0iVFAtTGluayI7IjUwLUM3LUJGIj0iVFAtTGluayI7IjU0LUU2LUZDIj0iVFAtTGluayIKICAgICI2MC1FMy0yNyI9IlRQLUxpbmsiOyI3MC00Ri01NyI9IlRQLUxpbmsiOyI3NC1EQS04OCI9IlRQLUxpbmsiOyI4NC0xNi1GOSI9IlRQLUxpbmsiCiAgICAiOTAtRjYtNTIiPSJUUC1MaW5rIjsiOTgtREEtQzQiPSJUUC1MaW5rIjsiQjAtNDgtN0EiPSJUUC1MaW5rIjsiQzQtNkUtMUYiPSJUUC1MaW5rIgogICAgIkM4LTNBLTM1Ij0iVFAtTGluayI7IkQ4LTA3LUI2Ij0iVFAtTGluayI7IkVDLTA4LTZCIj0iVFAtTGluayI7IkY4LTFBLTY3Ij0iVFAtTGluayIKICAgICJDNC1FOS04NCI9IlRQLUxpbmsiOyIzNC0yOS0xMiI9IlRQLUxpbmsiOyI0NC05NC1GQyI9IlRQLUxpbmsiOyI1MC0zRS1BQSI9IlRQLUxpbmsiCiAgICAiNjQtNzAtMDIiPSJUUC1MaW5rIjsiN0MtMzktNTYiPSJUUC1MaW5rIjsiODAtMzUtQzEiPSJUUC1MaW5rIjsiQUMtODQtQzYiPSJUUC1MaW5rIgogICAgIkI0LUIwLTI0Ij0iVFAtTGluayI7IkQ0LTZFLTVDIj0iVFAtTGluayI7IkY0LUVDLTM4Ij0iVFAtTGluayI7IjFDLTNCLUYzIj0iVFAtTGluayIKICAgICMgQVNVUwogICAgIjAwLTBDLTZFIj0iQVNVUyI7IjAwLTExLTJGIj0iQVNVUyI7IjAwLTEzLUQ0Ij0iQVNVUyI7IjAwLTE1LUYyIj0iQVNVUyIKICAgICIwMC0xNy0zMSI9IkFTVVMiOyIwMC0xQS05MiI9IkFTVVMiOyIwMC0xRC02MCI9IkFTVVMiOyIwMC0xRS04QyI9IkFTVVMiCiAgICAiMDAtMjQtOEMiPSJBU1VTIjsiMDAtMjYtMTgiPSJBU1VTIjsiMDQtOTItMjYiPSJBU1VTIjsiMDgtNjAtNkUiPSJBU1VTIgogICAgIjEwLUJGLTQ4Ij0iQVNVUyI7IjE0LURBLUU5Ij0iQVNVUyI7IjFDLTg3LTJDIj0iQVNVUyI7IjJDLTRELTU0Ij0iQVNVUyIKICAgICIzMC01QS0zQSI9IkFTVVMiOyIzOC1ENS00NyI9IkFTVVMiOyI1MC00Ni01RCI9IkFTVVMiOyI2MC00NS1DQiI9IkFTVVMiCiAgICAiNzQtRDAtMkIiPSJBU1VTIjsiOTAtRTYtQkEiPSJBU1VTIjsiQTAtRjMtQzEiPSJBU1VTIjsiQUMtMjItMEIiPSJBU1VTIgogICAgIkIwLTZFLUJGIj0iQVNVUyI7IkJDLUFFLUM1Ij0iQVNVUyI7IkM4LTYwLTAwIj0iQVNVUyI7IkZDLTM0LTk3Ij0iQVNVUyIKICAgICIwNC1EOS1GNSI9IkFTVVMiOyIwOC02Mi02NiI9IkFTVVMiOyIwQy05RC05MiI9IkFTVVMiOyIxMC03OC1EMiI9IkFTVVMiCiAgICA7IjE4LTMxLUJGIj0iQVNVUyI7IjIwLUNGLTMwIj0iQVNVUyI7IjI0LTRCLUZFIj0iQVNVUyIKICAgICIyQy01Ni1EQyI9IkFTVVMiOyIzQy05Ny0wRSI9IkFTVVMiOyI0MC0xNi03RSI9IkFTVVMiCiAgICAiNDQtOEEtNUIiPSJBU1VTIjsiNDgtNUItMzkiPSJBU1VTIjsiNEMtRUQtRkIiPSJBU1VTIjsiNTAtQUYtNzMiPSJBU1VTIgogICAgIjU0LTA0LUE2Ij0iQVNVUyI7IjU4LTExLTIyIj0iQVNVUyI7IjVDLUFELUNGIj0iQVNVUyI7IjYwLUE0LTRDIj0iQVNVUyIKICAgICI2NC0wMC02QSI9IkFTVVMiOyI2OC0xQy1BMiI9IkFTVVMiOyI2Qy1GRC1COSI9IkFTVVMiOyI3MC00RC03QiI9IkFTVVMiCiAgICA7Ijc4LTI0LUFGIj0iQVNVUyI7IjdDLTEwLUM5Ij0iQVNVUyI7IjgwLTFGLTAyIj0iQVNVUyIKICAgICI4NC1BOS1DNCI9IkFTVVMiOyI4OC1ENy1GNiI9IkFTVVMiOyI4Qy04RC0yOCI9IkFTVVMiOyI5MC00OC05QSI9IkFTVVMiCiAgICAiOTQtMDgtNTMiPSJBU1VTIjsiOTgtRUUtQ0IiPSJBU1VTIjsiOUMtNUMtOEUiPSJBU1VTIjsiQTgtNUUtNDUiPSJBU1VTIgogICAgIkJDLUVFLTdCIj0iQVNVUyI7IkM4LUQzLUZGIj0iQVNVUyI7IkNDLTI4LUFBIj0iQVNVUyI7IkQwLTE3LUMyIj0iQVNVUyIKICAgICMgU2Ftc3VuZwogICAgIjAwLTFELTI1Ij0iU2Ftc3VuZyI7IjAwLTIxLTE5Ij0iU2Ftc3VuZyI7IjAwLTIzLTM5Ij0iU2Ftc3VuZyI7IjAwLTI0LTU0Ij0iU2Ftc3VuZyIKICAgICIwOC0wOC1DMiI9IlNhbXN1bmciOyIxMC0xRC1DMCI9IlNhbXN1bmciOyIxNC00OS1FMCI9IlNhbXN1bmciOyIxOC0xRS1CMCI9IlNhbXN1bmciCiAgICAiMUMtNjItQjgiPSJTYW1zdW5nIjsiMjQtNEItODEiPSJTYW1zdW5nIjsiMjgtOTgtN0IiPSJTYW1zdW5nIjsiMzgtQUEtM0MiPSJTYW1zdW5nIgogICAgIjQwLTBFLTg1Ij0iU2Ftc3VuZyI7IjQ0LTc4LTNFIj0iU2Ftc3VuZyI7IjUwLTAxLUJCIj0iU2Ftc3VuZyI7IjVDLTNDLTI3Ij0iU2Ftc3VuZyIKICAgICI2MC02Qi1CRCI9IlNhbXN1bmciOyI2Qy0yRi0yQyI9IlNhbXN1bmciOyI3MC1GOS0yNyI9IlNhbXN1bmciOyI4NC0yNS1EQiI9IlNhbXN1bmciCiAgICAiOEMtNzEtRjgiPSJTYW1zdW5nIjsiOTQtNzYtQjciPSJTYW1zdW5nIjsiQTAtMDctOTgiPSJTYW1zdW5nIjsiQjQtNzktQTciPSJTYW1zdW5nIgogICAgIkNDLTA3LUFCIj0iU2Ftc3VuZyI7IkRDLUE5LTA0Ij0iU2Ftc3VuZyI7IkYwLTI1LUI3Ij0iU2Ftc3VuZyI7IkZDLUExLTNFIj0iU2Ftc3VuZyIKICAgICIyQy1BRS0yQiI9IlNhbXN1bmciOyIzNC0xNC01RiI9IlNhbXN1bmciOyI0MC1COC0zNyI9IlNhbXN1bmciOyI0OC0xMy03RSI9IlNhbXN1bmciCiAgICAiNTAtQ0MtRjgiPSJTYW1zdW5nIjsiNUMtRTgtRUIiPSJTYW1zdW5nIjsiNjgtNDgtOTgiPSJTYW1zdW5nIjsiNzgtNTktNUUiPSJTYW1zdW5nIgogICAgIjg0LTU1LUE1Ij0iU2Ftc3VuZyI7IjhDLUE5LTgyIj0iU2Ftc3VuZyI7IjkwLTE4LTdDIj0iU2Ftc3VuZyI7IjlDLTNBLUFGIj0iU2Ftc3VuZyIKICAgICJBNC1FQi1EMyI9IlNhbXN1bmciOyJCQy0yMC1BNCI9IlNhbXN1bmciOyJDMC1CRC1EMSI9IlNhbXN1bmciOyJDNC01Ny02RSI9IlNhbXN1bmciCiAgICAjIFhpYW9taQogICAgIjBDLTFELUFGIj0iWGlhb21pIjsiMTAtMkEtQjMiPSJYaWFvbWkiOyIyOC02Qy0wNyI9IlhpYW9taSI7IjM0LTgwLUIzIj0iWGlhb21pIgogICAgIjM4LUE0LUVEIj0iWGlhb21pIjsiNTAtOEYtNEMiPSJYaWFvbWkiOyI2NC0wOS04MCI9IlhpYW9taSI7Ijc0LTIzLTQ0Ij0iWGlhb21pIgogICAgIjc4LTExLURDIj0iWGlhb21pIjsiOEMtQkUtQkUiPSJYaWFvbWkiOyJBMC04Ni1DNiI9IlhpYW9taSI7IkFDLUY3LUYzIj0iWGlhb21pIgogICAgIkIwLUU0LTM1Ij0iWGlhb21pIjsiQzQtMEItQ0IiPSJYaWFvbWkiOyJENC05Ny0wQiI9IlhpYW9taSI7IkY0LThCLTMyIj0iWGlhb21pIgogICAgIkZDLTY0LUJBIj0iWGlhb21pIjsiNjQtQjQtNzMiPSJYaWFvbWkiOyIwMC05RS1DOCI9IlhpYW9taSI7IjA0LUNGLThDIj0iWGlhb21pIgogICAgIjE4LTU5LTM2Ij0iWGlhb21pIjsiMjAtODItQzAiPSJYaWFvbWkiOyIyOC1FMy0xRiI9IlhpYW9taSI7IjM0LUNFLTAwIj0iWGlhb21pIgogICAgIjQwLTMxLTNDIj0iWGlhb21pIjsiNDgtMkMtQTAiPSJYaWFvbWkiOyI1MC02NC0yQiI9IlhpYW9taSI7IjU4LTQ0LTk4Ij0iWGlhb21pIgogICAgIyBIdWF3ZWkKICAgICIwMC0wRi1FMiI9Ikh1YXdlaSI7IjAwLTE4LTgyIj0iSHVhd2VpIjsiMDAtMUUtMTAiPSJIdWF3ZWkiOyIwMC0yNS05RSI9Ikh1YXdlaSIKICAgICIwNC1CRC03MCI9Ikh1YXdlaSI7IjBDLTM3LTk2Ij0iSHVhd2VpIjsiMUMtOEUtNUMiPSJIdWF3ZWkiOyIyOC0zQy1FNCI9Ikh1YXdlaSIKICAgICIyQy1BQi0wMCI9Ikh1YXdlaSI7IjM0LTZCLUQzIj0iSHVhd2VpIjsiNDAtNEQtOEUiPSJIdWF3ZWkiOyI0OC00Ni1GQiI9Ikh1YXdlaSIKICAgICI1NC04OS05OCI9Ikh1YXdlaSI7IjVDLUMzLTA3Ij0iSHVhd2VpIjsiNjAtREUtNDQiPSJIdWF3ZWkiOyI3MC03Mi1DRiI9Ikh1YXdlaSIKICAgICI3OC0xRC1CQSI9Ikh1YXdlaSI7IjgwLTM4LUJDIj0iSHVhd2VpIjsiOTgtRTctRjQiPSJIdWF3ZWkiOyJBMC0wOC02RiI9Ikh1YXdlaSIKICAgICJDOC01MS05NSI9Ikh1YXdlaSI7IkQ0LTEyLTQzIj0iSHVhd2VpIjsiRTgtQ0QtMkQiPSJIdWF3ZWkiOyJGNC02My0xRiI9Ikh1YXdlaSIKICAgICIwNC1DMC02RiI9Ikh1YXdlaSI7IjA4LTE5LUE2Ij0iSHVhd2VpIjsiMTAtMUItNTQiPSJIdWF3ZWkiOyIxNC1COS02OCI9Ikh1YXdlaSIKICAgICIxOC1DNS04QSI9Ikh1YXdlaSI7IjIwLTA4LUVEIj0iSHVhd2VpIjsiMjQtNjktQTUiPSJIdWF3ZWkiOyIyQy1FOC03NSI9Ikh1YXdlaSIKICAgICIzMC04Ny1EOSI9Ikh1YXdlaSI7IjNDLTQ3LTExIj0iSHVhd2VpIjsiNDQtNkEtQjciPSJIdWF3ZWkiOyI0OC1EQi01MCI9Ikh1YXdlaSIKICAgICMgTkVUR0VBUgogICAgIjAwLTFBLTRCIj0iTkVUR0VBUiI7IjAwLTFCLTJGIj0iTkVUR0VBUiI7IjAwLTFFLTJBIj0iTkVUR0VBUiI7IjAwLTIyLTNGIj0iTkVUR0VBUiIKICAgICIwMC0yNC1CMiI9Ik5FVEdFQVIiOyIyMC00RS03RiI9Ik5FVEdFQVIiOyIyOC1DNi04RSI9Ik5FVEdFQVIiOyIyQy1CMC01RCI9Ik5FVEdFQVIiCiAgICAiNkMtRjAtNDkiPSJORVRHRUFSIjsiODQtMUItNUUiPSJORVRHRUFSIjsiOUMtRDMtNkQiPSJORVRHRUFSIjsiQTAtNDAtQTAiPSJORVRHRUFSIgogICAgIkMwLTNGLTBFIj0iTkVUR0VBUiI7IkUwLTkxLUY1Ij0iTkVUR0VBUiI7IkU0LUY0LUM2Ij0iTkVUR0VBUiI7IjEwLURBLTQzIj0iTkVUR0VBUiIKICAgICIzMC00Ni05QSI9Ik5FVEdFQVIiOyI2Qy1CMC1DRSI9Ik5FVEdFQVIiOyI4MC0zNy03MyI9Ik5FVEdFQVIiCiAgICAjIEQtTGluawogICAgIjAwLTBELTg4Ij0iRC1MaW5rIjsiMDAtMTEtOTUiPSJELUxpbmsiOyIwMC0xMy00NiI9IkQtTGluayI7IjAwLTE1LUU5Ij0iRC1MaW5rIgogICAgIjAwLTE3LTlBIj0iRC1MaW5rIjsiMDAtMTktNUIiPSJELUxpbmsiOyIwMC0xQi0xMSI9IkQtTGluayI7IjAwLTFDLUYwIj0iRC1MaW5rIgogICAgIjAwLTIxLTkxIj0iRC1MaW5rIjsiMDAtMjItQjAiPSJELUxpbmsiOyIwMC0yNC0wMSI9IkQtTGluayI7IjAwLTI2LTVBIj0iRC1MaW5rIgogICAgIjE0LUQ2LTREIj0iRC1MaW5rIjsiMUMtN0UtRTUiPSJELUxpbmsiOyIyOC0xMC03QiI9IkQtTGluayI7IjM0LTA4LTA0Ij0iRC1MaW5rIgogICAgIjVDLUQ5LTk4Ij0iRC1MaW5rIjsiNzgtNTQtMkUiPSJELUxpbmsiOyI5MC05NC1FNCI9IkQtTGluayI7IkI4LUEzLTg2Ij0iRC1MaW5rIgogICAgIkM4LUJFLTE5Ij0iRC1MaW5rIjsiQ0MtQjItNTUiPSJELUxpbmsiOyJGMC03RC02OCI9IkQtTGluayI7IkZDLTc1LTE2Ij0iRC1MaW5rIgogICAgIjE4LTBGLTc2Ij0iRC1MaW5rIjsiMjAtRTUtMkEiPSJELUxpbmsiOyI0MC05Qi1DRCI9IkQtTGluayIKICAgICMgSW50ZWwgKE5JQ3MgZW4gbGFwdG9wcy9QQ3MpCiAgICAiMDAtMEUtMzUiPSJJbnRlbCI7IjAwLTE2LUVBIj0iSW50ZWwiOyIwMC0xQi0yMSI9IkludGVsIjsiMDAtMUUtNjciPSJJbnRlbCIKICAgICIwMC0yMS02QSI9IkludGVsIjsiMDAtMjItRkIiPSJJbnRlbCI7IjAwLTI0LUQ3Ij0iSW50ZWwiCiAgICAiQTAtODgtQjQiPSJJbnRlbCI7IkE0LUMzLUYwIj0iSW50ZWwiOyJCOC1DQS0zQSI9IkludGVsIjsiQzQtODUtMDgiPSJJbnRlbCIKICAgICJEQy01My02MCI9IkludGVsIjsiRTgtMkEtRUEiPSJJbnRlbCI7IkY4LTM0LTQxIj0iSW50ZWwiOyI3Qy01Qy1GOCI9IkludGVsIgogICAgIjAwLTAwLUYwIj0iSW50ZWwiOyIwMC0wMi1CMyI9IkludGVsIjsiMDAtMDMtNDciPSJJbnRlbCI7IjAwLTA0LTIzIj0iSW50ZWwiCiAgICAiMDAtMDctRTkiPSJJbnRlbCI7IjAwLTBDLUYxIj0iSW50ZWwiOyIwMC0wRS0wQyI9IkludGVsIjsiMDAtMTItRjAiPSJJbnRlbCIKICAgICIwMC0xMy0wMiI9IkludGVsIjsiMDAtMTMtMjAiPSJJbnRlbCI7IjAwLTEzLUNFIj0iSW50ZWwiOyIwMC0xNS0wMCI9IkludGVsIgogICAgIjAwLTE2LTc2Ij0iSW50ZWwiOyIwMC0xOS1EMSI9IkludGVsIjsiMDAtMUMtQzAiPSJJbnRlbCI7IjAwLTFELUUwIj0iSW50ZWwiCiAgICAiMDAtMUYtM0IiPSJJbnRlbCI7IjAwLTIxLTVDIj0iSW50ZWwiOyIwMC0yMy0xNCI9IkludGVsIjsiMDAtMjMtQUUiPSJJbnRlbCIKICAgIDsiMDAtMjYtQzYiPSJJbnRlbCI7IjAwLTI3LTEwIj0iSW50ZWwiOyIwNC0wRS0zQyI9IkludGVsIgogICAgIyBDaXNjbyAvIExpbmtzeXMKICAgICIwMC0xNC1CRiI9IkNpc2NvL0xpbmtzeXMiOyIwMC0xOC1GOCI9IkNpc2NvL0xpbmtzeXMiOyIwMC0xQS03MCI9IkNpc2NvIgogICAgIjAwLTFCLTU0Ij0iQ2lzY28iOyIwMC0xQy0xMCI9IkNpc2NvIjsiMDAtMjItQkQiPSJDaXNjbyI7IjAwLTIzLUJFIj0iQ2lzY28iCiAgICAiMDAtMjUtMkUiPSJDaXNjbyI7IjBDLUQ5LTk2Ij0iQ2lzY28iOyIxQy1FNi1DNyI9IkNpc2NvIjsiNTgtQUMtNzgiPSJDaXNjbyIKICAgICI2NC05RS1GMyI9IkNpc2NvIjsiODQtNzgtQUMiPSJDaXNjbyI7Ijk4LTkwLTk2Ij0iQ2lzY28iOyJBNC02Qy0yQSI9IkNpc2NvIgogICAgIkI0LTE0LTg5Ij0iQ2lzY28iOyJDOC0wMC04NCI9IkNpc2NvIjsiREMtOEMtMzciPSJDaXNjbyI7IkYwLTI5LTI5Ij0iQ2lzY28iCiAgICAiMDAtMDItMTYiPSJDaXNjbyI7IjAwLTAzLTZCIj0iQ2lzY28iOyIwMC0wNC1ERCI9IkNpc2NvIjsiMDAtMDUtREMiPSJDaXNjbyIKICAgICIwMC0wNi0yOCI9IkNpc2NvIjsiMDAtMDctMEQiPSJDaXNjbyI7IjAwLTA4LUEzIj0iQ2lzY28iOyIwMC0wOS0xMiI9IkNpc2NvIgogICAgIjAwLTBBLThBIj0iQ2lzY28iOyIwMC0wQi1CRSI9IkNpc2NvIjsiMDAtMEMtODUiPSJDaXNjbyI7IjAwLTBELTI5Ij0iQ2lzY28iCiAgICAiMDAtMEUtRDciPSJDaXNjbyI7IjAwLTBGLThGIj0iQ2lzY28iOyIwMC0xMC0wNyI9IkNpc2NvIjsiMDAtMTAtNzkiPSJDaXNjbyIKICAgICIwMC0xMC1GNiI9IkNpc2NvIjsiMDAtMTEtMjEiPSJDaXNjbyI7IjAwLTEyLTAwIj0iQ2lzY28iOyIwMC0xMy0xOSI9IkNpc2NvIgogICAgIyBHb29nbGUgKENocm9tZWNhc3QsIE5lc3QsIFBpeGVsLCBIb21lKQogICAgIjAwLTFBLTExIj0iR29vZ2xlIjsiMDgtOUUtMDgiPSJHb29nbGUiOyIyMC1ERi1COSI9Ikdvb2dsZSI7IjNDLTVBLUI0Ij0iR29vZ2xlIgogICAgIjQ4LUQ2LUQ1Ij0iR29vZ2xlIjsiNTQtNjAtMDkiPSJHb29nbGUiOyI2Qy1BRC1GOCI9Ikdvb2dsZSI7IkE0LTc3LTMzIj0iR29vZ2xlIgogICAgIkFDLTY3LUIyIj0iR29vZ2xlIjsiRjQtRjUtRDgiPSJHb29nbGUiOyI1OC1DQi01MiI9Ikdvb2dsZSI7IkQ4LUVCLTk3Ij0iR29vZ2xlIgogICAgIjFDLUYyLTlBIj0iR29vZ2xlIjsiMzAtRkQtMzgiPSJHb29nbGUiOyIzOC04Qi01OSI9Ikdvb2dsZSI7IjRDLUJDLTk4Ij0iR29vZ2xlIgogICAgIjU0LTUyLTAwIj0iR29vZ2xlIjsiN0MtMUUtMDYiPSJHb29nbGUiOyI5Qy05RC03RSI9Ikdvb2dsZSIKICAgICMgQW1hem9uIChBbGV4YSwgRWNobywgRmlyZSBUViwgS2luZGxlKQogICAgIjAwLUJCLTNBIj0iQW1hem9uIjsiMTgtNzQtMkUiPSJBbWF6b24iOyIzNC1EMi03MCI9IkFtYXpvbiI7IjQwLUI0LUNEIj0iQW1hem9uIgogICAgIjQ0LTY1LTBEIj0iQW1hem9uIjsiNTAtREMtRTciPSJBbWF6b24iOyI2OC0zNy1FOSI9IkFtYXpvbiI7Ijc4LUUxLTAzIj0iQW1hem9uIgogICAgIjg0LUQ2LUQwIj0iQW1hem9uIjsiQTAtMDItREMiPSJBbWF6b24iOyJCNC03Qy01OSI9IkFtYXpvbiI7IkYwLTI3LTJEIj0iQW1hem9uIgogICAgIjBDLTQ3LUM5Ij0iQW1hem9uIjsiMTAtQUUtNjAiPSJBbWF6b24iOyIyOC1FRi0wMSI9IkFtYXpvbiIKICAgIDsiNDAtNEUtMzYiPSJBbWF6b24iOyI1MC1GNS1EQSI9IkFtYXpvbiIKICAgICI3NC03NS00OCI9IkFtYXpvbiI7IkZDLUExLTgzIj0iQW1hem9uIgogICAgIyBNaWNyb3NvZnQgKFN1cmZhY2UsIFhib3gsIEhvbG9MZW5zKQogICAgIjAwLTAzLUZGIj0iTWljcm9zb2Z0IjsiMDAtMTUtNUQiPSJIeXBlci1WIjsiMDAtMUQtRDgiPSJNaWNyb3NvZnQiCiAgICAiMjgtMTgtNzgiPSJNaWNyb3NvZnQiOyI0OC01MC03MyI9Ik1pY3Jvc29mdCI7IjdDLTFFLTUyIj0iTWljcm9zb2Z0IgogICAgIkRDLUI0LUM0Ij0iTWljcm9zb2Z0IjsiOTgtNUYtRDMiPSJNaWNyb3NvZnQiOyI2MC00NS1CRCI9Ik1pY3Jvc29mdCIKICAgICIwMC01MC1GMiI9Ik1pY3Jvc29mdCI7IjcwLTc3LTgxIj0iTWljcm9zb2Z0IgogICAgIyBSYXNwYmVycnkgUGkgRm91bmRhdGlvbgogICAgIjI4LUNELUMxIj0iUmFzcGJlcnJ5IFBpIjsiQjgtMjctRUIiPSJSYXNwYmVycnkgUGkiCiAgICAiREMtQTYtMzIiPSJSYXNwYmVycnkgUGkiOyJFNC01Ri0wMSI9IlJhc3BiZXJyeSBQaSIKICAgICMgVWJpcXVpdGkgKFVuaUZpLCBBbXBsaUZpLCBFZGdlUm91dGVyKQogICAgIjAwLTE1LTZEIj0iVWJpcXVpdGkiOyIwMC0yNy0yMiI9IlViaXF1aXRpIjsiMDQtMTgtRDYiPSJVYmlxdWl0aSIKICAgICIyNC1BNC0zQyI9IlViaXF1aXRpIjsiNDQtRDktRTciPSJVYmlxdWl0aSI7IjY4LTcyLTUxIj0iVWJpcXVpdGkiCiAgICAiNzQtODMtQzIiPSJVYmlxdWl0aSI7Ijc4LThBLTIwIj0iVWJpcXVpdGkiOyI4MC0yQS1BOCI9IlViaXF1aXRpIgogICAgIkRDLTlGLURCIj0iVWJpcXVpdGkiOyJGMC05Ri1DMiI9IlViaXF1aXRpIjsiMTgtRTgtMjkiPSJVYmlxdWl0aSIKICAgICMgVmlydHVhbGl6YWNpb24KICAgICIwMC0wQy0yOSI9IlZNd2FyZSI7IjAwLTUwLTU2Ij0iVk13YXJlIjsiMDAtMDUtNjkiPSJWTXdhcmUiCiAgICAiMDgtMDAtMjciPSJWaXJ0dWFsQm94IjsiNTItNTQtMDAiPSJRRU1VL0tWTSIKICAgICMgUmVhbHRlayAoY2hpcHMgZGUgcmVkIGdlbmVyaWNvcyBlbiBwbGFjYXMgYmFzZSkKICAgICIwMC1FMC00QyI9IlJlYWx0ZWsiOyIwMC0wMS02QyI9IlJlYWx0ZWsiOyI1Mi01NC1BQiI9IlJlYWx0ZWsiCiAgICAjIE90cm9zIGZhYnJpY2FudGVzIGRlIHJlZCBjb211bmVzCiAgICAiMDAtMTAtMTgiPSJCcm9hZGNvbSI7IjAwLTEwLTRBIj0iM0NvbSI7IjAwLTYwLTA4Ij0iM0NvbSI7IjAwLTAwLUY0Ij0iQWxsaWVkIFRlbGVzaXMiCiAgICAiMDAtMDAtMEMiPSJDaXNjbyI7IjAwLUFBLTAwIj0iSW50ZWwiOyIwMi0wMC00QyI9Ikh5cGVyLVYiCn0KIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIERBVE9TIERFIExBUyBQQU5UQUxMQVMgREUgSU5GT1JNQUNJT04gUE9SIE1PRFVMTwojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KJHNjcmlwdDpJbmZvID0gQHsKICAgICJBIiA9IEB7CiAgICAgICAgVGl0dWxvID0gIkF1ZGl0b3JpYSBkZSBQdWVydG9zIExBTiIKICAgICAgICBDb2xvciAgPSAiQ3lhbiIKICAgICAgICBEZXNjICAgPSBAKAogICAgICAgICAgICAiUHJ1ZWJhIGNvbmV4aW9uIFRDUCBhIGxvcyBwdWVydG9zIG1hcyByZWxldmFudGVzIGRlbCByb3V0ZXIiLAogICAgICAgICAgICAidXNhbmRvIFRjcENsaWVudCBjb24gdGltZW91dCBkZSAxIHNlZ3VuZG8gcG9yIHB1ZXJ0by4gRXMgbXVjaG8iLAogICAgICAgICAgICAibWFzIHJhcGlkbyBxdWUgVGVzdC1OZXRDb25uZWN0aW9uIHBvcnF1ZSBubyBlc3BlcmEgYWwgSUNNUC4iLAogICAgICAgICAgICAiUHVlcnRvcyBiYXNlOiAyMSwgMjIsIDIzLCA4MCwgNDQzLCA4MDgwLCA4NDQzLCA4ODg4LCA5MDkwLiIsCiAgICAgICAgICAgICJQdWVkZXMgYWdyZWdhciBwdWVydG9zIGFkaWNpb25hbGVzIGFsIGluaWNpbyBkZWwgZXNjYW5lby4iCiAgICAgICAgKQogICAgICAgIFByZWMgICA9IEAoCiAgICAgICAgICAgICJBbGd1bm9zIHJvdXRlcnMgY29uIElEUy9JUFMgcmVnaXN0cmFuIGVsIGVzY2FuZW8gZW4gc3VzIGxvZ3MuIiwKICAgICAgICAgICAgIiAgSW5vZmVuc2l2bywgcGVybyBwdWVkZSBhcGFyZWNlciBjb21vICdhY3RpdmlkYWQgc29zcGVjaG9zYScuIiwKICAgICAgICAgICAgIk5vIGVqZWN1dGFyIGNvbnRyYSB1bmEgSVAgcXVlIG5vIHNlYSB0dSBwcm9waW8gZ2F0ZXdheS4iLAogICAgICAgICAgICAiRmFsc29zIG5lZ2F0aXZvcyBwb3NpYmxlcyBzaSBlbCByb3V0ZXIgdXNhIERST1AgZW4gdmV6IGRlIFJFSkVDVC4iCiAgICAgICAgKQogICAgICAgIFJlY3MgICA9IEAoCiAgICAgICAgICAgICJFamVjdXRhIEEgYW50ZXMgZGUgQyBwYXJhIHNhYmVyIHNpIGVsIHBhbmVsIHVzYSBIVFRQIG8gSFRUUFMuIiwKICAgICAgICAgICAgIkNvbWJpbmEgY29uIGVsIG1vZHVsbyBIIHBhcmEgc2FiZXIgc2kgZXNvcyBwdWVydG9zIGVzdGFuIGVuIFdBTi4iLAogICAgICAgICAgICAiU2kgZWwgcHVlcnRvIDIzIChUZWxuZXQpIGFwYXJlY2UgYWJpZXJ0bywgY2VycmFybG8gZXMgdXJnZW50ZToiLAogICAgICAgICAgICAiICBQYW5lbCBkZWwgcm91dGVyIC0+IEFkbWluaXN0cmFjaW9uIC0+IGRlc2FjdGl2YXIgVGVsbmV0LiIKICAgICAgICApCiAgICAgICAgRWplbSAgID0gQCgKICAgICAgICAgICAgIlBhbmVsIGRlbCByb3V0ZXIgaW5hY2Nlc2libGU6IGNvbXBydWViYSBzaSA4MCBvIDQ0MyByZXNwb25kZW4uIiwKICAgICAgICAgICAgIiAgU2kgYW1ib3MgZXN0YW4gY2VycmFkb3MsIGVsIHBhbmVsIGRlIGFkbWluaXN0cmFjaW9uIGVzdGEgT0ZGLiIsCiAgICAgICAgICAgICJSb3V0ZXIgbGVudG8gc2luIHJhem9uIGFwYXJlbnRlOiBUZWxuZXQgYWJpZXJ0byBwdWVkZSBpbmRpY2FyIiwKICAgICAgICAgICAgIiAgYWNjZXNvIHJlbW90byBhY3Rpdm8gbm8gYXV0b3JpemFkbyBkcmVuYW5kbyByZWN1cnNvcy4iCiAgICAgICAgKQogICAgfQogICAgIkIiID0gQHsKICAgICAgICBUaXR1bG8gPSAiRXNjYW5lbyBkZSBEaXNwb3NpdGl2b3MgKyBEZXRlY2Npb24gZGUgSVBzIER1cGxpY2FkYXMiCiAgICAgICAgQ29sb3IgID0gIkN5YW4iCiAgICAgICAgRGVzYyAgID0gQCgKICAgICAgICAgICAgIkVudmlhIHBpbmdzIGEgdG9kYSBsYSBzdWJyZWQgKC4xIGEgLjI1NCkgeSByZWdpc3RyYSBjYWRhIiwKICAgICAgICAgICAgImRpc3Bvc2l0aXZvIHF1ZSByZXNwb25kZS4gTXVlc3RyYSBJUCwgTUFDLCBub21icmUgRE5TIHkiLAogICAgICAgICAgICAiZmFicmljYW50ZS4gRGV0ZWN0YSBjb25mbGljdG9zIGRlIElQIChtaXNtbyBNQUMsIGRpc3RpbnRhIElQKSIsCiAgICAgICAgICAgICJxdWUgcHVlZGVuIGNhdXNhciBjb3J0ZXMgYWxlYXRvcmlvcyBkZSBjb25leGlvbi4iCiAgICAgICAgKQogICAgICAgIFByZWMgICA9IEAoCiAgICAgICAgICAgICJFbCBlc2NhbmVvIGRlIDI1NCBob3N0cyBwdWVkZSB0YXJkYXIgZW50cmUgMzAgeSA5MCBzZWd1bmRvcy4iLAogICAgICAgICAgICAiRGlzcG9zaXRpdm9zIGNvbiBmaXJld2FsbCBhY3Rpdm8gcHVlZGVuIG5vIHJlc3BvbmRlciBhbCBwaW5nIiwKICAgICAgICAgICAgIiAgYXVucXVlIGVzdGVuIGNvbmVjdGFkb3MgKGZhbHNvcyBuZWdhdGl2b3MgZXNwZXJhYmxlcykuIiwKICAgICAgICAgICAgIkVsIG5vbWJyZSBETlMgcHVlZGUgcXVlZGFyIGNvbW8gJ09jdWx0bycgZW4gbXVjaG9zIGRpc3Bvc2l0aXZvcy4iCiAgICAgICAgKQogICAgICAgIFJlY3MgICA9IEAoCiAgICAgICAgICAgICJFamVjdXRhciBjdWFuZG8gZWwgY2xpZW50ZSByZXBvcnRhICdhbGd1aWVuIHNlIGNvbG8gZW4gbWkgV2lGaSciLAogICAgICAgICAgICAiICBvIGN1YW5kbyBoYXkgY29ydGVzIGFsZWF0b3Jpb3MgZGUgcmVkIHNpbiByYXpvbiBhcGFyZW50ZS4iLAogICAgICAgICAgICAiQ29tYmluYSBjb24gZWwgbW9kdWxvIE4gKGNvbXBhcmF0aXZhKSBwYXJhIHZlciBjYW1iaW9zIGVuIGVsIHRpZW1wby4iLAogICAgICAgICAgICAiVXNhIGVsIG1vZHVsbyBKIHBhcmEgdmVyIGxvcyBmYWJyaWNhbnRlcyBkZSBmb3JtYSBhZ3J1cGFkYS4iCiAgICAgICAgKQogICAgICAgIEVqZW0gICA9IEAoCiAgICAgICAgICAgICJEb3MgZGlzcG9zaXRpdm9zIGNvbiBsYSBtaXNtYSBJUCBjYXVzYW4gZGVzY29uZXhpb25lcyBhbGVhdG9yaWFzOiIsCiAgICAgICAgICAgICIgIGVsIGVzY2FuZW8gbW9zdHJhcmEgdW5hIGFsZXJ0YSBkZSBjb25mbGljdG8gZGUgSVAuIiwKICAgICAgICAgICAgIkRpc3Bvc2l0aXZvIGNvbiBNQUMgZGVzY29ub2NpZGEgZW4gbGEgbGlzdGE6IHBvZHJpYSBzZXIgdW4iLAogICAgICAgICAgICAiICBpbnRydXNvIC0gaW52ZXN0aWdhciBjb24gZWwgbW9kdWxvIEouIgogICAgICAgICkKICAgIH0KICAgICJDIiA9IEB7CiAgICAgICAgVGl0dWxvID0gIkFicmlyIFBhbmVsIGRlbCBSb3V0ZXIgKGRldGVjY2lvbiBhdXRvbWF0aWNhIEhUVFAvUykiCiAgICAgICAgQ29sb3IgID0gIkN5YW4iCiAgICAgICAgRGVzYyAgID0gQCgKICAgICAgICAgICAgIkRldGVjdGEgc2kgZWwgcm91dGVyIGFjZXB0YSBIVFRQUyAocHVlcnRvIDQ0MykgbyBIVFRQIChwdWVydG8gODApIiwKICAgICAgICAgICAgImFudGVzIGRlIGFicmlyIGVsIG5hdmVnYWRvciwgeSB1c2EgZWwgcHJvdG9jb2xvIGNvcnJlY3RvLiIsCiAgICAgICAgICAgICJFdml0YSBlbCBlcnJvciB0aXBpY28gZGUgdGVjbGVhciBodHRwOi8vIGVuIHVuIHJvdXRlciBxdWUgc29sbyIsCiAgICAgICAgICAgICJyZXNwb25kZSBlbiBodHRwczovLyBvIHZpY2V2ZXJzYS4iCiAgICAgICAgKQogICAgICAgIFByZWMgICA9IEAoCiAgICAgICAgICAgICJBbGd1bm9zIHJvdXRlcnMgY29uIHByb3RlY2Npb24gQ1NSRiBibG9xdWVhbiBhY2Nlc29zIGRlc2RlIiwKICAgICAgICAgICAgIiAgZW5sYWNlcyBkaXJlY3Rvcy4gRW4gZXNlIGNhc28sIGFicmUgZWwgbmF2ZWdhZG9yIG1hbnVhbG1lbnRlLiIsCiAgICAgICAgICAgICJMYSBhZHZlcnRlbmNpYSAnQ29uZXhpb24gbm8gc2VndXJhJyBlbiBIVFRQUyBlcyBjb21wbGV0YW1lbnRlIiwKICAgICAgICAgICAgIiAgbm9ybWFsIGVuIHJlZGVzIGxvY2FsZXMgKGNlcnRpZmljYWRvIGF1dG9maXJtYWRvKS4iCiAgICAgICAgKQogICAgICAgIFJlY3MgICA9IEAoCiAgICAgICAgICAgICJFamVjdXRhIHByaW1lcm8gZWwgbW9kdWxvIEEgcGFyYSBjb25maXJtYXIgcXVlIGFsIG1lbm9zIHVubyIsCiAgICAgICAgICAgICIgIGRlIGxvcyBwdWVydG9zICg4MCBvIDQ0MykgZXN0YSBhY3Rpdm8uIiwKICAgICAgICAgICAgIkNyZWRlbmNpYWxlcyBwb3IgZGVmZWN0byBjb211bmVzOiBhZG1pbi9hZG1pbiwgYWRtaW4vMTIzNCwiLAogICAgICAgICAgICAiICBhZG1pbi8oZW4gYmxhbmNvKS4gQ29uc3VsdGEgbGEgZXRpcXVldGEgZGViYWpvIGRlbCByb3V0ZXIuIgogICAgICAgICkKICAgICAgICBFamVtICAgPSBAKAogICAgICAgICAgICAiU29wb3J0ZSByYXBpZG86IGFjY2VzbyBhbCBwYW5lbCBzaW4gcmVjb3JkYXIgc2kgZXMgaHR0cCBvIGh0dHBzLiIsCiAgICAgICAgICAgICJSb3V0ZXIgY29uIEhUVFBTIGhhYmlsaXRhZG86IGVsIG1vZHVsbyBDIGFicmUgZGlyZWN0YW1lbnRlIiwKICAgICAgICAgICAgIiAgbGEgdmVyc2lvbiBzZWd1cmEgcGFyYSBldml0YXIgbGEgYWR2ZXJ0ZW5jaWEgZGVsIG5hdmVnYWRvci4iCiAgICAgICAgKQogICAgfQogICAgIkQiID0gQHsKICAgICAgICBUaXR1bG8gPSAiRGlhZ25vc3RpY28gZGUgTGF0ZW5jaWEgeSBFc3RhYmlsaWRhZCIKICAgICAgICBDb2xvciAgPSAiWWVsbG93IgogICAgICAgIERlc2MgICA9IEAoCiAgICAgICAgICAgICJFbnZpYSAxMCBwaW5ncyBhIHRyZXMgZGVzdGlub3M6IGVsIHJvdXRlciAoTEFOKSwgQ2xvdWRmbGFyZSIsCiAgICAgICAgICAgICIoMS4xLjEuMSkgeSBHb29nbGUgKDguOC44LjgpLiBDYWxjdWxhIG1pbmltbywgbWF4aW1vIHkgbWVkaWEuIiwKICAgICAgICAgICAgIklkZW50aWZpY2EgYXV0b21hdGljYW1lbnRlIHNpIGVsIHByb2JsZW1hIGVzdGEgZW4gbGEgcmVkIGxvY2FsIiwKICAgICAgICAgICAgIm8gZW4gZWwgcHJvdmVlZG9yIGRlIEludGVybmV0IChJU1ApLiIKICAgICAgICApCiAgICAgICAgUHJlYyAgID0gQCgKICAgICAgICAgICAgIkxvcyBwaW5ncyBhIEludGVybmV0IHB1ZWRlbiBibG9xdWVhcnNlIGNvbiBWUE4gYWN0aXZhLCIsCiAgICAgICAgICAgICIgIGRhbmRvIGZhbHNvcyBuZWdhdGl2b3MgZW4gbG9zIGRlc3Rpbm9zIFdBTi4iLAogICAgICAgICAgICAiRW4gcmVkZXMgY29ycG9yYXRpdmFzIGFsZ3Vub3MgZmlyZXdhbGxzIGJsb3F1ZWFuIElDTVAuIiwKICAgICAgICAgICAgIlVuIHNvbG8gdGVzdCBubyBlcyByZXByZXNlbnRhdGl2bzogZWplY3V0YXIgZW4gZGlzdGludG9zIG1vbWVudG9zLiIKICAgICAgICApCiAgICAgICAgUmVjcyAgID0gQCgKICAgICAgICAgICAgIkxhdGVuY2lhIGFsIHJvdXRlciA+IDIwbXMgPSBwcm9ibGVtYSBlbiBsYSByZWQgbG9jYWwgKFdpRmksIGNhYmxlKS4iLAogICAgICAgICAgICAiTGF0ZW5jaWEgYSBJbnRlcm5ldCA+IDEwMG1zID0gcHJvYmFibGUgcHJvYmxlbWEgY29uIGVsIElTUC4iLAogICAgICAgICAgICAiUGVyZGlkYSBkZSBwYXF1ZXRlcyA+IDMwJSA9IGZhbGxvIGdyYXZlIHF1ZSByZXF1aWVyZSBhdGVuY2lvbi4iLAogICAgICAgICAgICAiQ29tcGFyYXIgcmVzdWx0YWRvcyBlbiBob3JhIHB1bnRhIHZzIGhvcmEgYmFqYS4iCiAgICAgICAgKQogICAgICAgIEVqZW0gICA9IEAoCiAgICAgICAgICAgICJDbGllbnRlIHJlcG9ydGEgJ0ludGVybmV0IGxlbnRvJzogc2kgZWwgcGluZyBhbCByb3V0ZXIgZXMgYWx0byIsCiAgICAgICAgICAgICIgIGVsIHByb2JsZW1hIGVzIGxhIExBTi4gU2kgZWwgcm91dGVyIHJlc3BvbmRlIGJpZW4gcGVybyAxLjEuMS4xIiwKICAgICAgICAgICAgIiAgZmFsbGEsIGxsYW1hciBhbCBJU1AgY29uIGxvcyBkYXRvcyBkZWwgdGVzdCBjb21vIGV2aWRlbmNpYS4iLAogICAgICAgICAgICAiVmlkZW9jb25mZXJlbmNpYXMgcXVlIHNlIGNvcnRhbjogYnVzY2FyIHBlcmRpZGEgZGUgcGFxdWV0ZXMgPiA1JS4iCiAgICAgICAgKQogICAgfQogICAgIkUiID0gQHsKICAgICAgICBUaXR1bG8gPSAiSW5mb3JtYWNpb24gQ29tcGxldGEgZGVsIEFkYXB0YWRvciBkZSBSZWQiCiAgICAgICAgQ29sb3IgID0gIldoaXRlIgogICAgICAgIERlc2MgICA9IEAoCiAgICAgICAgICAgICJNdWVzdHJhIHRvZG9zIGxvcyBkYXRvcyBkZWwgYWRhcHRhZG9yIGRlIHJlZCBhY3Rpdm86IG5vbWJyZSwiLAogICAgICAgICAgICAiZGVzY3JpcGNpb24sIGVzdGFkbywgdmVsb2NpZGFkIGRlIGVubGFjZSwgTUFDIHByb3BpYSwgSVAgbG9jYWwsIiwKICAgICAgICAgICAgIm1hc2NhcmEgZGUgcmVkIChub3RhY2lvbiAvWFgpLCBwdWVydGEgZGUgZW5sYWNlIHkgc2Vydmlkb3JlcyIsCiAgICAgICAgICAgICJETlMgY29uZmlndXJhZG9zLiIKICAgICAgICApCiAgICAgICAgUHJlYyAgID0gQCgKICAgICAgICAgICAgIlNpIGhheSBtdWx0aXBsZXMgYWRhcHRhZG9yZXMgKFZQTiBhY3RpdmEgKyBhZGFwdGFkb3IgZmlzaWNvKSwiLAogICAgICAgICAgICAiICBtdWVzdHJhIGVsIGFzb2NpYWRvIGEgbGEgcnV0YSBwb3IgZGVmZWN0byBtYXMgb3B0aW1hLiIsCiAgICAgICAgICAgICJMYSB2ZWxvY2lkYWQgcHVlZGUgYXBhcmVjZXIgY29tbyBOL0EgZW4gYWRhcHRhZG9yZXMgV2lGaSB2aXJ0dWFsZXMuIgogICAgICAgICkKICAgICAgICBSZWNzICAgPSBAKAogICAgICAgICAgICAiRWplY3V0YXIgc2llbXByZSBjb21vIHByaW1lciBtb2R1bG8gZW4gY3VhbHF1aWVyIGRpYWdub3N0aWNvLiIsCiAgICAgICAgICAgICJJUCBlbiAxNjkuMjU0LngueCAoQVBJUEEpOiBlbCBESENQIG5vIGVzdGEgcmVzcG9uZGllbmRvLiIsCiAgICAgICAgICAgICJETlMgZW4gMTI3LjAuMC4xOiBoYXkgdW4gc2VydmljaW8gbG9jYWwgYWN0dWFuZG8gZGUgRE5TIiwKICAgICAgICAgICAgIiAgKFBpLWhvbGUsIFZQTiwgRE5TQ3J5cHQpLiBQdWVkZSBzZXIgaW50ZW5jaW9uYWRvIG8gbm8uIgogICAgICAgICkKICAgICAgICBFamVtICAgPSBAKAogICAgICAgICAgICAiUEMgc2luIEludGVybmV0IHBlcm8gY29uIElQIGNvcnJlY3RhOiB2ZXJpZmljYXIgc2kgZWwgZ2F0ZXdheSIsCiAgICAgICAgICAgICIgIGVzIGVsIGRlbCByb3V0ZXIgbyB1bm8gaW5jb3JyZWN0byBhc2lnbmFkbyBwb3IgZXJyb3IuIiwKICAgICAgICAgICAgIk1hcXVpbmEgY29uIHZlbG9jaWRhZCAxME1icHMgZW4gcmVkIEdpZ2FiaXQ6IGNhYmxlIG8gcHVlcnRvIiwKICAgICAgICAgICAgIiAgZGVsIHN3aXRjaCBlbiBtb2RvIGhhbGYtZHVwbGV4IG8gZGV0ZXJpb3JhZG8uIgogICAgICAgICkKICAgIH0KICAgICJGIiA9IEB7CiAgICAgICAgVGl0dWxvID0gIlRlc3QgZGUgUmVzb2x1Y2lvbiBETlMiCiAgICAgICAgQ29sb3IgID0gIldoaXRlIgogICAgICAgIERlc2MgICA9IEAoCiAgICAgICAgICAgICJSZXN1ZWx2ZSA1IGRvbWluaW9zIGNvbm9jaWRvcyAoR29vZ2xlLCBDbG91ZGZsYXJlLCBNaWNyb3NvZnQsIiwKICAgICAgICAgICAgIkFtYXpvbiwgWW91VHViZSkgbWlkaWVuZG8gZWwgdGllbXBvIGRlIHJlc3B1ZXN0YSBlbiBtcy4iLAogICAgICAgICAgICAiQWxlcnRhIHNpIGFsZ3VuIGRvbWluaW8gdGFyZGEgbWFzIGRlIDUwMG1zIG8gZmFsbGEuIiwKICAgICAgICAgICAgIkRpYWdub3N0aWNhIHNpIGVsIHByb2JsZW1hIGRlICd3ZWJzIHF1ZSBubyBhYnJlbicgZXMgRE5TLiIKICAgICAgICApCiAgICAgICAgUHJlYyAgID0gQCgKICAgICAgICAgICAgIlNpIGVsIGVxdWlwbyB1c2EgdW4gRE5TIGxvY2FsIChQaS1ob2xlLCBBZEd1YXJkKSwgbGEgbGF0ZW5jaWEiLAogICAgICAgICAgICAiICBwdWVkZSBzZXIgbWFzIGFsdGEgc2luIHF1ZSBlc28gc2VhIHVuIHByb2JsZW1hLiIsCiAgICAgICAgICAgICJGYWxsb3MgY29tcGxldG9zIGNvbiBwaW5nIGZ1bmNpb25hbCA9IEROUyBkZWwgcm91dGVyIGNhaWRvLiIKICAgICAgICApCiAgICAgICAgUmVjcyAgID0gQCgKICAgICAgICAgICAgIlNpIHRvZG9zIGxvcyBkb21pbmlvcyBmYWxsYW4gcGVybyBlbCBwaW5nIGEgOC44LjguOCBmdW5jaW9uYSwiLAogICAgICAgICAgICAiICBlbCBETlMgZXN0YSBjYWlkby4gU29sdWNpb24gcmFwaWRhOiBjYW1iaWFyIEROUyBhIDEuMS4xLjEiLAogICAgICAgICAgICAiICBlbiBsYSBjb25maWd1cmFjaW9uIGRlIHJlZCBkZWwgZXF1aXBvIG8gZGVsIHJvdXRlci4iLAogICAgICAgICAgICAiVGllbXBvcyA+IDIwMG1zIGRlIGZvcm1hIGNvbnNpc3RlbnRlOiBjYW1iaWFyIGEgRE5TIHB1YmxpY28uIgogICAgICAgICkKICAgICAgICBFamVtICAgPSBAKAogICAgICAgICAgICAiV2VicyBsZW50YXMgcGVybyBkZXNjYXJnYXMgcmFwaWRhczogZWwgRE5TIGVzdGEgdGFyZGFuZG8gbXVjaG8iLAogICAgICAgICAgICAiICBlbiByZXNvbHZlci4gQ2FtYmlvIGEgMS4xLjEuMSBzdWVsZSBzb2x1Y2lvbmFyIGVsIHByb2JsZW1hLiIsCiAgICAgICAgICAgICJBbGd1bmFzIHdlYnMgbm8gYWJyZW46IHJlc29sdWNpb24gc2VsZWN0aXZhIGZhbGxhbmRvLCIsCiAgICAgICAgICAgICIgIHBvc2libGUgbGlzdGEgZGUgYmxvcXVlbyBvIGNhY2hlIEROUyBjb3JydXB0YSBlbiBlbCByb3V0ZXIuIgogICAgICAgICkKICAgIH0KICAgICJIIiA9IEB7CiAgICAgICAgVGl0dWxvID0gIkRldGVjY2lvbiBkZSBQdWVydG9zIFBlbGlncm9zb3MgRXhwdWVzdG9zIGVuIEludGVybmV0IChXQU4pIgogICAgICAgIENvbG9yICA9ICJSZWQiCiAgICAgICAgRGVzYyAgID0gQCgKICAgICAgICAgICAgIk9idGllbmUgdHUgSVAgcHVibGljYSB2aWEgYXBpLmlwaWZ5Lm9yZyB5IGVzY2FuZWEgZGVzZGUgSW50ZXJuZXQiLAogICAgICAgICAgICAibG9zIHB1ZXJ0b3MgbWFzIHBlbGlncm9zb3M6IDIxIChGVFApLCAyMiAoU1NIKSwgMjMgKFRlbG5ldCksIiwKICAgICAgICAgICAgIjgwIChIVFRQKSwgNDQzIChIVFRQUyksIDMzODkgKFJEUCkgeSA4MDgwIChIVFRQLUFsdCkuIiwKICAgICAgICAgICAgIkRldGVjdGEgc2kgdHUgcm91dGVyIGVzdGEgZXhwdWVzdG8gYSBhdGFxdWVzIGV4dGVybm9zLiIKICAgICAgICApCiAgICAgICAgUHJlYyAgID0gQCgKICAgICAgICAgICAgIkFsZ3Vub3MgSVNQIHVzYW4gQ0ctTkFUOiBlbCByZXN1bHRhZG8gcG9kcmlhIG5vIHJlZmxlamFyIiwKICAgICAgICAgICAgIiAgbGEgZXhwb3NpY2lvbiByZWFsIGRlbCByb3V0ZXIgKElQcyBjb21wYXJ0aWRhcykuIiwKICAgICAgICAgICAgIlJlZGVzIGNvbiBoYWlycGluIE5BVCBwdWVkZW4gcmVwb3J0YXIgcHVlcnRvcyBjb21vIGNlcnJhZG9zLiIsCiAgICAgICAgICAgICJTT0xPIGVzY2FuZWFyIHR1IHByb3BpYSByZWQuIE51bmNhIHVzYXIgY29udHJhIElQcyBhamVuYXMuIgogICAgICAgICkKICAgICAgICBSZWNzICAgPSBAKAogICAgICAgICAgICAiUHVlcnRvIDIzIG8gMzM4OSBhYmllcnRvcyBkZXNkZSBJbnRlcm5ldDogVVJHRU5URSBjZXJyYXJsb3MuIiwKICAgICAgICAgICAgIiAgUGFuZWwgZGVsIHJvdXRlciAtPiBBZG1pbmlzdHJhY2lvbiByZW1vdGEgLT4gZGVzYWN0aXZhci4iLAogICAgICAgICAgICAiUHVlcnRvIDIyIGFiaWVydG86IGNhbWJpYXIgU1NIIGEgdW4gcHVlcnRvIG5vIGVzdGFuZGFyIiwKICAgICAgICAgICAgIiAgeSBoYWJpbGl0YXIgYXV0ZW50aWNhY2lvbiBwb3IgY2xhdmUsIG5vIHBvciBjb250cmFzZW5hLiIKICAgICAgICApCiAgICAgICAgRWplbSAgID0gQCgKICAgICAgICAgICAgIlJvdXRlciByZWNpYmllbmRvIGF0YXF1ZXMgZGUgZnVlcnphIGJydXRhOiBwdWVydG9zIDIyIG8gMjMiLAogICAgICAgICAgICAiICBhYmllcnRvcyBlbiBXQU4gc29uIGVsIHZlY3Rvci4gQ2VycmFybG9zIGRldGllbmUgZWwgYXRhcXVlLiIsCiAgICAgICAgICAgICJDbGllbnRlIGNvbiBJbnRlcm5ldCBsZW50byBwb3IgbGFzIG5vY2hlczogcHVlcnRvIDIzIGFiaWVydG8iLAogICAgICAgICAgICAiICBwdWVkZSBpbmRpY2FyIHF1ZSBlbCByb3V0ZXIgZXN0YSBzaWVuZG8gdXRpbGl6YWRvIGNvbW8gcHJveHkuIgogICAgICAgICkKICAgIH0KICAgICJKIiA9IEB7CiAgICAgICAgVGl0dWxvID0gIklkZW50aWZpY2FjaW9uIGRlIEZhYnJpY2FudGVzIHBvciBQcmVmaWpvIE1BQyAoT1VJKSIKICAgICAgICBDb2xvciAgPSAiV2hpdGUiCiAgICAgICAgRGVzYyAgID0gQCgKICAgICAgICAgICAgIkVzY2FuZWEgbGEgcmVkIHkgY3J1emEgY2FkYSBNQUMgY29uIHVuYSB0YWJsYSBsb2NhbCBkZSAyMDArIiwKICAgICAgICAgICAgInByZWZpam9zIE9VSSBwYXJhIGlkZW50aWZpY2FyIGVsIGZhYnJpY2FudGUgZGVsIGNoaXAgZGUgcmVkLiIsCiAgICAgICAgICAgICJNdWVzdHJhIGxvcyByZXN1bHRhZG9zIGFncnVwYWRvcyBwb3IgZmFicmljYW50ZSBwYXJhIGZhY2lsaXRhciIsCiAgICAgICAgICAgICJsYSBpZGVudGlmaWNhY2lvbiBkZSBkaXNwb3NpdGl2b3MgZGVzY29ub2NpZG9zLiIsCiAgICAgICAgICAgICJObyByZXF1aWVyZSBjb25leGlvbiBhIEludGVybmV0OiBsYSB0YWJsYSBlc3RhIGVtYmViaWRhLiIKICAgICAgICApCiAgICAgICAgUHJlYyAgID0gQCgKICAgICAgICAgICAgIkVsIE9VSSBpZGVudGlmaWNhIGFsIGZhYnJpY2FudGUgZGVsIENISVAgZGUgcmVkLCBubyBkZWwgZGlzcG9zaXRpdm8uIiwKICAgICAgICAgICAgIiAgVW4gcm91dGVyIFhpYW9taSBwdWVkZSB1c2FyIHVuIGNoaXAgSW50ZWwgbyBSZWFsdGVrLiIsCiAgICAgICAgICAgICJNQUNzIGFsZWF0b3JpemFkYXMgKEFuZHJvaWQgMTArLCBpT1MgMTQrLCBXaW5kb3dzIDEwIHJlY2llbnRlKSIsCiAgICAgICAgICAgICIgIHB1ZWRlbiBhcGFyZWNlciBjb21vICdEZXNjb25vY2lkbycgbyBjb24gZmFicmljYW50ZSBpbmNvcnJlY3RvLiIsCiAgICAgICAgICAgICJMYSB0YWJsYSBjdWJyZSBsb3MgbWFzIGNvbXVuZXMgcGVybyBubyBlcyBleGhhdXN0aXZhLiIKICAgICAgICApCiAgICAgICAgUmVjcyAgID0gQCgKICAgICAgICAgICAgIkN1YW5kbyBhcGFyZWNlIHVuIGZhYnJpY2FudGUgaW5lc3BlcmFkbyAoUmFzcGJlcnJ5IFBpLCBBbWF6b24sIiwKICAgICAgICAgICAgIiAgUUVNVSkgZW4gY2FzYSBkZSB1biBjbGllbnRlLCBpbnZlc3RpZ2FyIGVzZSBkaXNwb3NpdGl2by4iLAogICAgICAgICAgICAiU2kgdmFyaW9zIGRpc3Bvc2l0aXZvcyBtdWVzdHJhbiBlbCBtaXNtbyBmYWJyaWNhbnRlIChJbnRlbCksIiwKICAgICAgICAgICAgIiAgZXMgcHJvYmFibGUgcXVlIHNlYW4gbGFwdG9wcyBvIFBDcyBjb24gTklDIGludGVncmFkYS4iCiAgICAgICAgKQogICAgICAgIEVqZW0gICA9IEAoCiAgICAgICAgICAgICJBcGFyZWNlICdSYXNwYmVycnkgUGknIGVuIGxhIHJlZCBkZWwgY2xpZW50ZTogYWxndWllbiBpbnN0YWxvIiwKICAgICAgICAgICAgIiAgdW5hIG1pbmktUEMsIHBvc2libGVtZW50ZSB1biBzZXJ2aWRvciBvIHVuIHJlbGF5IGRlIHJlZC4iLAogICAgICAgICAgICAiQXBhcmVjZSAnQW1hem9uJzogZXMgdW4gRWNobywgRmlyZSBUViwgS2luZGxlIG8gUmluZy4iLAogICAgICAgICAgICAiQXBhcmVjZSAnVk13YXJlJy8nUUVNVSc6IGhheSB1bmEgbWFxdWluYSB2aXJ0dWFsIGVuIGxhIHJlZC4iCiAgICAgICAgKQogICAgfQogICAgIkwiID0gQHsKICAgICAgICBUaXR1bG8gPSAiRGV0ZWNjaW9uIGRlIFZlcnNpb24gZGUgRmlybXdhcmUgZGVsIFJvdXRlciIKICAgICAgICBDb2xvciAgPSAiRGFya1llbGxvdyIKICAgICAgICBEZXNjICAgPSBAKAogICAgICAgICAgICAiSW50ZW50YSBhY2NlZGVyIHNpbiBhdXRlbnRpY2FjaW9uIGEgcnV0YXMgY29ub2NpZGFzIGRlIHBhZ2luYXMiLAogICAgICAgICAgICAiZGUgaW5mb3JtYWNpb24gZGVsIGZpcm13YXJlIGVuIFRQLUxpbmssIEFTVVMsIEQtTGluaywgTW92aXN0YXIiLAogICAgICAgICAgICAieSByb3V0ZXJzIGdlbmVyaWNvcy4gRXh0cmFlIGxhIHZlcnNpb24gc2kgbGEgZW5jdWVudHJhLiIsCiAgICAgICAgICAgICJGdW5jaW9uYSBlbiBhcHJveGltYWRhbWVudGUgZWwgNjAtNzAlIGRlIGxvcyByb3V0ZXJzIGRvbWVzdGljb3MuIgogICAgICAgICkKICAgICAgICBQcmVjICAgPSBAKAogICAgICAgICAgICAiQWxndW5vcyByb3V0ZXJzIHJlcXVpZXJlbiBsb2dpbiBwYXJhIG1vc3RyYXIgbGEgdmVyc2lvbi4iLAogICAgICAgICAgICAiICBFbiBlc2UgY2FzbywgdXNhciBlbCBtb2R1bG8gQyBwYXJhIGFjY2VkZXIgYWwgcGFuZWwuIiwKICAgICAgICAgICAgIkVsIHJlc3VsdGFkbyBwdWVkZSB2YXJpYXIgc2VndW4gbGEgY29uZmlndXJhY2lvbiBkZWwgZmFicmljYW50ZS4iLAogICAgICAgICAgICAiTm8gZ2VuZXJhIG5pbmd1biBjYW1iaW8gZW4gZWwgcm91dGVyOiBlcyBzb2xvIGxlY3R1cmEuIgogICAgICAgICkKICAgICAgICBSZWNzICAgPSBAKAogICAgICAgICAgICAiU2kgZW5jdWVudHJhcyBsYSB2ZXJzaW9uLCBjb21wYXJhciBjb24gbGEgZGlzcG9uaWJsZSBlbiBsYSB3ZWIiLAogICAgICAgICAgICAiICBkZWwgZmFicmljYW50ZS4gTWFzIGRlIDEgYW5vIHNpbiBhY3R1YWxpemFyID0gcmllc2dvLiIsCiAgICAgICAgICAgICJUUC1MaW5rIHkgQVNVUyBzdWVsZW4gZXhwb25lciBsYSB2ZXJzaW9uIHNpbiBhdXRlbnRpY2FjaW9uLiIsCiAgICAgICAgICAgICJFbiBjYXNvIGRlIGR1ZGEsIGFjY2VkZXIgbWFudWFsbWVudGUgYWwgcGFuZWwgKG1vZHVsbyBDKS4iCiAgICAgICAgKQogICAgICAgIEVqZW0gICA9IEAoCiAgICAgICAgICAgICJSb3V0ZXIgY29uIGZpcm13YXJlIGRlIDIwMTkgZW4gMjAyNDogcHJvYmFibGVtZW50ZSB2dWxuZXJhYmxlIiwKICAgICAgICAgICAgIiAgYSBDVkVzIHB1YmxpY29zLiBSZWNvbWVuZGFyIGFjdHVhbGl6YWNpb24gYWwgY2xpZW50ZS4iLAogICAgICAgICAgICAiVmVyc2lvbiBubyBlbmNvbnRyYWRhOiBlbCByb3V0ZXIgcmVxdWlyZSBsb2dpbiBvIG5vIGVzIGNvbXBhdGlibGUiLAogICAgICAgICAgICAiICBjb24gbGFzIHJ1dGFzIGNvbm9jaWRhcy4gVXNhciBlbCBtb2R1bG8gQyBtYW51YWxtZW50ZS4iCiAgICAgICAgKQogICAgfQogICAgIk0iID0gQHsKICAgICAgICBUaXR1bG8gPSAiSW5mb3JtZSBDb21wbGV0byBBdXRvbWF0aWNvIChBICsgRSArIEYgKyBEKSIKICAgICAgICBDb2xvciAgPSAiR3JlZW4iCiAgICAgICAgRGVzYyAgID0gQCgKICAgICAgICAgICAgIkVqZWN1dGEgYXV0b21hdGljYW1lbnRlIGxvcyBtb2R1bG9zIEEsIEUsIEYgeSBEIGVuIHNlY3VlbmNpYSIsCiAgICAgICAgICAgICJzaW4gaW50ZXJhY2Npb24gZGVsIHVzdWFyaW8uIEFsIGZpbmFsaXphciBnZW5lcmEgdW4gdW5pY28iLAogICAgICAgICAgICAiYXJjaGl2byBUWFQgY29uc29saWRhZG8gY29uIGZlY2hhIHkgaG9yYSBlbiBlbCBFc2NyaXRvcmlvLiIsCiAgICAgICAgICAgICJJZGVhbCBwYXJhIGluaWNpbyBvIGZpbiBkZSB1bmEgdmlzaXRhIGRlIHNvcG9ydGUgdGVjbmljby4iCiAgICAgICAgKQogICAgICAgIFByZWMgICA9IEAoCiAgICAgICAgICAgICJMYSBlamVjdWNpb24gY29tcGxldGEgdGFyZGEgZW50cmUgMiB5IDUgbWludXRvcy4iLAogICAgICAgICAgICAiICBObyBjZXJyYXIgbGEgdmVudGFuYSBhIGxhIG1pdGFkIGRlbCBwcm9jZXNvLiIsCiAgICAgICAgICAgICJSZXF1aWVyZSBjb25leGlvbiBkZSByZWQgYWN0aXZhIHBhcmEgdG9kb3MgbG9zIG1vZHVsb3MuIiwKICAgICAgICAgICAgIkVsIGFyY2hpdm8gVFhUIHNlIHNvYnJlc2NyaWJlIHNpIHlhIGV4aXN0ZSB1bm8gZGVsIG1pc21vIHNlZ3VuZG8uIgogICAgICAgICkKICAgICAgICBSZWNzICAgPSBAKAogICAgICAgICAgICAiTGFuemFyIGFsIGluaWNpbyBkZSBsYSB2aXNpdGEgcGFyYSB0ZW5lciB1bmEgbGluZWEgYmFzZS4iLAogICAgICAgICAgICAiTGFuemFyIGFsIGZpbmFsIHBhcmEgZG9jdW1lbnRhciBlbCBlc3RhZG8gdHJhcyBsb3MgY2FtYmlvcy4iLAogICAgICAgICAgICAiRW52aWFyIGVsIFRYVCBhbCBjbGllbnRlIHBvciBlbWFpbCBjb21vIHJlZ2lzdHJvIGRlIGxhIHZpc2l0YS4iLAogICAgICAgICAgICAiUGFyYSBlamVjdXRhciBzaW4gaW50ZXJhY2Npb24gZGVzZGUgdW4gLmJhdDogQXVkaXRvcmlhUm91dGVyLnBzMSAtQXV0byIKICAgICAgICApCiAgICAgICAgRWplbSAgID0gQCgKICAgICAgICAgICAgIk1hbnRlbmltaWVudG8gcHJldmVudGl2byBtZW5zdWFsOiBsYW56YXIgTSwgZXNwZXJhciwgYWRqdW50YXIiLAogICAgICAgICAgICAiICBlbCBUWFQgYWwgdGlja2V0IGRlIHNvcG9ydGUgY29tbyBldmlkZW5jaWEgZGVsIGVzdGFkby4iLAogICAgICAgICAgICAiVGFyZWEgcHJvZ3JhbWFkYTogY29uZmlndXJhciBlbiBlbCBQcm9ncmFtYWRvciBkZSBUYXJlYXMgZGUiLAogICAgICAgICAgICAiICBXaW5kb3dzIGNvbiBlbCBwYXJhbWV0cm8gLUF1dG8gcGFyYSBlamVjdWNpb24gbm9jdHVybmEuIgogICAgICAgICkKICAgIH0KICAgICJOIiA9IEB7CiAgICAgICAgVGl0dWxvID0gIkNvbXBhcmF0aXZhIGRlIERpc3Bvc2l0aXZvcyAoQW50ZXMgLyBBaG9yYSkiCiAgICAgICAgQ29sb3IgID0gIk1hZ2VudGEiCiAgICAgICAgRGVzYyAgID0gQCgKICAgICAgICAgICAgIkVzY2FuZWEgbGEgcmVkIGFjdHVhbCB5IGxhIGNvbXBhcmEgY29uIGVsIHVsdGltbyBlc2NhbmVvIiwKICAgICAgICAgICAgImd1YXJkYWRvIGVuIGRpc2NvLiBNdWVzdHJhIGVuIHZlcmRlIGxvcyBkaXNwb3NpdGl2b3MgbnVldm9zIiwKICAgICAgICAgICAgInkgZW4gcm9qbyBsb3MgcXVlIGhhbiBkZXNhcGFyZWNpZG8uIExvcyBkaXNwb3NpdGl2b3Mgc2luIiwKICAgICAgICAgICAgImNhbWJpb3Mgc2UgbXVlc3RyYW4gZW4gZ3Jpcy4iCiAgICAgICAgKQogICAgICAgIFByZWMgICA9IEAoCiAgICAgICAgICAgICJFbCBlc3RhZG8gZ3VhcmRhZG8gcGVyc2lzdGUgZW50cmUgc2VzaW9uZXMgZW4gdW5hIGNhcnBldGEgdGVtcC4iLAogICAgICAgICAgICAiICBTaSBzZSBsaW1waWEgJVRFTVAlLCBlbCBoaXN0b3JpYWwgc2UgcGllcmRlLiIsCiAgICAgICAgICAgICJEaXNwb3NpdGl2b3MgYXBhZ2Fkb3MgcHVlZGVuIGFwYXJlY2VyIGNvbW8gJ2Rlc2FwYXJlY2lkb3MnIiwKICAgICAgICAgICAgIiAgYXVucXVlIHNpZ2FuIHBlcnRlbmVjaWVuZG8gYSBsYSByZWQuIgogICAgICAgICkKICAgICAgICBSZWNzICAgPSBAKAogICAgICAgICAgICAiRW4gbGEgcHJpbWVyYSB2aXNpdGEgYWwgY2xpZW50ZTogZWplY3V0YXIgcGFyYSBndWFyZGFyIGVsIGVzdGFkbyBiYXNlLiIsCiAgICAgICAgICAgICJFbiB2aXNpdGFzIHBvc3RlcmlvcmVzOiBlamVjdXRhciBwYXJhIGRldGVjdGFyIGRpc3Bvc2l0aXZvcyBudWV2b3MuIiwKICAgICAgICAgICAgIlNpIGFwYXJlY2UgdW4gZGlzcG9zaXRpdm8gbnVldm8gaW5lc3BlcmFkbzogY3J1emFyIGNvbiBtb2R1bG8gSiIsCiAgICAgICAgICAgICIgIHBhcmEgaWRlbnRpZmljYXIgZWwgZmFicmljYW50ZS4iCiAgICAgICAgKQogICAgICAgIEVqZW0gICA9IEAoCiAgICAgICAgICAgICJDbGllbnRlIGRpY2UgJ2FsZ3VpZW4gc2UgY29uZWN0byBhIG1pIFdpRmknOiBjb21wYXJhciBjb24gZWwiLAogICAgICAgICAgICAiICBlc2NhbmVvIGFudGVyaW9yIHBhcmEgdmVyIGV4YWN0YW1lbnRlIHF1ZSBkaXNwb3NpdGl2byBlcyBudWV2by4iLAogICAgICAgICAgICAiVHJhcyBjYW1iaWFyIGxhIGNvbnRyYXNlbmEgZGVsIFdpRmk6IHZlcmlmaWNhciBxdWUgbm8gcXVlZGVuIiwKICAgICAgICAgICAgIiAgZGlzcG9zaXRpdm9zIGRlbCBlc2NhbmVvIGFudGVyaW9yIHF1ZSBubyBkZWJlcmlhbiBlc3Rhci4iCiAgICAgICAgKQogICAgfQogICAgIlAiID0gQHsKICAgICAgICBUaXR1bG8gPSAiVGVzdCBkZSBWZWxvY2lkYWQgZGUgRGVzY2FyZ2EiCiAgICAgICAgQ29sb3IgID0gIlllbGxvdyIKICAgICAgICBEZXNjICAgPSBAKAogICAgICAgICAgICAiRGVzY2FyZ2EgdW4gYXJjaGl2byBkZSB+NU1CIGRlc2RlIGxvcyBzZXJ2aWRvcmVzIGRlIENsb3VkZmxhcmUiLAogICAgICAgICAgICAieSBtaWRlIGxhIHZlbG9jaWRhZCByZWFsIGRlIGRlc2NhcmdhIGVuIE1CL3MgeSBNYnBzLiIsCiAgICAgICAgICAgICJObyBkZXBlbmRlIGRlIGFwbGljYWNpb25lcyBleHRlcm5hcyBuaSBkZSBTcGVlZHRlc3QubmV0LiIsCiAgICAgICAgICAgICJQcm9wb3JjaW9uYSB1bmEgZXN0aW1hY2lvbiByYXBpZGEgeSBzaW4gaW5zdGFsYWNpb24uIgogICAgICAgICkKICAgICAgICBQcmVjICAgPSBAKAogICAgICAgICAgICAiRWwgcmVzdWx0YWRvIHB1ZWRlIHZhcmlhciBjb24gbGEgY2FyZ2EgZGVsIHNlcnZpZG9yIHkgbGEgaG9yYS4iLAogICAgICAgICAgICAiICBFamVjdXRhciB2YXJpYXMgdmVjZXMgcGFyYSBvYnRlbmVyIHVuYSBtZWRpYSByZXByZXNlbnRhdGl2YS4iLAogICAgICAgICAgICAiTWlkZSBsYSB2ZWxvY2lkYWQgZGVsIGVxdWlwbywgbm8gZGVsIHJvdXRlcjogb3Ryb3MgZGlzcG9zaXRpdm9zIiwKICAgICAgICAgICAgIiAgZW4gbGEgcmVkIGNvbnN1bWllbmRvIGFuY2hvIGRlIGJhbmRhIGFmZWN0YXJhbiBlbCByZXN1bHRhZG8uIiwKICAgICAgICAgICAgIlJlcXVpZXJlIGFjY2VzbyBhIEludGVybmV0IChjbG91ZGZsYXJlLmNvbSkuIgogICAgICAgICkKICAgICAgICBSZWNzICAgPSBAKAogICAgICAgICAgICAiQ29tcGFyYXIgZWwgcmVzdWx0YWRvIGNvbiBsYSB2ZWxvY2lkYWQgY29udHJhdGFkYSBjb24gZWwgSVNQLiIsCiAgICAgICAgICAgICIgIFJlZ2xhIHByYWN0aWNhOiBzZSBlc3BlcmEgYWwgbWVub3MgZWwgNzAlIGRlIGxhIHZlbG9jaWRhZCIsCiAgICAgICAgICAgICIgIGNvbnRyYXRhZGEgZW4gY29uZGljaW9uZXMgbm9ybWFsZXMuIiwKICAgICAgICAgICAgIkVqZWN1dGFyIHRhbnRvIGVuIFdpRmkgY29tbyBlbiBjYWJsZSBwYXJhIGNvbXBhcmFyIGRpZmVyZW5jaWFzLiIKICAgICAgICApCiAgICAgICAgRWplbSAgID0gQCgKICAgICAgICAgICAgIkNsaWVudGUgY29uIDMwMCBNYnBzIGNvbnRyYXRhZG9zIG9idGVuaWVuZG8gNSBNYnBzOiBwb3NpYmxlIiwKICAgICAgICAgICAgIiAgUW9TIG1hbCBjb25maWd1cmFkbywgdGhyb3R0bGluZyBkZWwgSVNQIG8gcm91dGVyIHNhdHVyYWRvLiIsCiAgICAgICAgICAgICJEaWZlcmVuY2lhIGdyYW5kZSBlbnRyZSBXaUZpIHkgY2FibGU6IHByb2JsZW1hIGRlIGNvYmVydHVyYSBvIiwKICAgICAgICAgICAgIiAgaW50ZXJmZXJlbmNpYXMgZW4gZWwgY2FuYWwgV2lGaS4gUmVjb21lbmRhY2lvbjogY2FtYmlhciBjYW5hbC4iCiAgICAgICAgKQogICAgfQogICAgIlEiID0gQHsKICAgICAgICBUaXR1bG8gPSAiRGV0ZWNjaW9uIGRlIFBvcnRhbCBDYXV0aXZvIgogICAgICAgIENvbG9yICA9ICJEYXJrWWVsbG93IgogICAgICAgIERlc2MgICA9IEAoCiAgICAgICAgICAgICJIYWNlIHVuYSBwZXRpY2lvbiBIVFRQIGEgY29ubmVjdGl2aXR5Y2hlY2suZ3N0YXRpYy5jb20vZ2VuZXJhdGVfMjA0LiIsCiAgICAgICAgICAgICJTaSBkZXZ1ZWx2ZSBIVFRQIDIwNDogY29uZXhpb24gbGltcGlhIGEgSW50ZXJuZXQuIiwKICAgICAgICAgICAgIlNpIGRldnVlbHZlIEhUVFAgMjAwIG8gcmVkaXJpZ2U6IGhheSB1biBwb3J0YWwgY2F1dGl2byBhY3Rpdm8iLAogICAgICAgICAgICAicXVlIHJlcXVpZXJlIGFjZXB0YWNpb24gYW50ZXMgZGUgbmF2ZWdhciAoaG90ZWxlcywgYWVyb3B1ZXJ0b3MpLiIKICAgICAgICApCiAgICAgICAgUHJlYyAgID0gQCgKICAgICAgICAgICAgIkVuIHJlZGVzIG11eSByZXN0cmljdGl2YXMgcHVlZGUgZGFyIGZhbHNvIHBvc2l0aXZvLiIsCiAgICAgICAgICAgICIgIFZlcmlmaWNhciBtYW51YWxtZW50ZSBhYnJpZW5kbyBlbCBuYXZlZ2Fkb3Igc2kgaGF5IGR1ZGEuIiwKICAgICAgICAgICAgIkFsZ3Vub3Mgc2lzdGVtYXMgZGUgY29udHJvbCBwYXJlbnRhbCBvIGZpbHRyb3MgZGUgY29udGVuaWRvIiwKICAgICAgICAgICAgIiAgcHVlZGVuIGludGVyY2VwdGFyIGxhIHBldGljaW9uIHkgZGFyIHVuIGZhbHNvIHBvc2l0aXZvLiIKICAgICAgICApCiAgICAgICAgUmVjcyAgID0gQCgKICAgICAgICAgICAgIkVqZWN1dGFyIGN1YW5kbyAnaGF5IGNvbmV4aW9uIFdpRmkgcGVybyBsYXMgd2VicyBubyBjYXJnYW4nLiIsCiAgICAgICAgICAgICIgIEVzIGVsIHNpbnRvbWEgY2xhc2ljbyBkZWwgcG9ydGFsIGNhdXRpdm8gc2luIGFjZXB0YXIuIiwKICAgICAgICAgICAgIlNvbHVjaW9uOiBhYnJpciBjdWFscXVpZXIgVVJMIEhUVFAgKHNpbiBTKSBlbiBlbCBuYXZlZ2Fkb3IuIiwKICAgICAgICAgICAgIiAgRWplbXBsbzogaHR0cDovL25ldmVyc3NsLmNvbSByZWRpcmlnZSBzaWVtcHJlIGFsIHBvcnRhbC4iCiAgICAgICAgKQogICAgICAgIEVqZW0gICA9IEAoCiAgICAgICAgICAgICJXaUZpIGRlIGhvdGVsOiBwaW5nIGZ1bmNpb25hLCBETlMgcmVzdWVsdmUsIHBlcm8gd2VicyBubyBhYnJlbi4iLAogICAgICAgICAgICAiICBQb3J0YWwgY2F1dGl2byBzaW4gYWNlcHRhciBsb3MgdGVybWlub3MuIEFicmlyIG5hdmVnYWRvci4iLAogICAgICAgICAgICAiUmVkIGNvcnBvcmF0aXZhIG51ZXZhOiBwb3J0YWwgZGUgcmVnaXN0cm8gZGUgZGlzcG9zaXRpdm9zIGFjdGl2by4iLAogICAgICAgICAgICAiICBFbCBJVCBkZWwgY2xpZW50ZSBkZWJlIGFwcm9iYXIgZWwgTUFDIGRlbCBlcXVpcG8uIgogICAgICAgICkKICAgIH0KfQoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIEZVTkNJT05FUyBVVElMSVRBUklBUyBCQVNFCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gRXNjcmliaXItQ2VudHJhZG8gewogICAgcGFyYW0oW3N0cmluZ10kVGV4dG8sIFtDb25zb2xlQ29sb3JdJENvbG9yID0gIkdyYXkiKQogICAgJFcgPSAkSG9zdC5VSS5SYXdVSS5XaW5kb3dTaXplLldpZHRoCiAgICBpZiAoJFRleHRvLkxlbmd0aCAtbHQgJFcpIHsKICAgICAgICAkRXNwID0gW01hdGhdOjpGbG9vcigoJFcgLSAkVGV4dG8uTGVuZ3RoKSAvIDIpCiAgICAgICAgV3JpdGUtSG9zdCAoIiAiICogJEVzcCArICRUZXh0bykgLUZvcmVncm91bmRDb2xvciAkQ29sb3IKICAgIH0gZWxzZSB7CiAgICAgICAgV3JpdGUtSG9zdCAkVGV4dG8gLUZvcmVncm91bmRDb2xvciAkQ29sb3IKICAgIH0KfQoKZnVuY3Rpb24gT2J0ZW5lci1Sb3V0ZXIgewogICAgJFJvdXRlcyA9IEdldC1OZXRSb3V0ZSAtRGVzdGluYXRpb25QcmVmaXggIjAuMC4wLjAvMCIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUgfAogICAgICAgICAgICAgIFNvcnQtT2JqZWN0IFJvdXRlTWV0cmljCiAgICBmb3JlYWNoICgkUiBpbiAkUm91dGVzKSB7CiAgICAgICAgJEEgPSBHZXQtTmV0QWRhcHRlciAtSW50ZXJmYWNlSW5kZXggJFIuSW50ZXJmYWNlSW5kZXggLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICAgICBpZiAoJEEgLWFuZCAkQS5JbnRlcmZhY2VEZXNjcmlwdGlvbiAtbm90bWF0Y2ggIlZQTnxUQVB8VHVubmVsfFdpcmVHdWFyZHxPcGVuVlBOfFBQUHxMb29wYmFja3xWaXJ0dWFsIikgewogICAgICAgICAgICByZXR1cm4gQHsgR2F0ZXdheSA9ICRSLk5leHRIb3A7IEludGVyZmFjZUluZGV4ID0gJFIuSW50ZXJmYWNlSW5kZXggfQogICAgICAgIH0KICAgIH0KICAgICRGID0gJFJvdXRlcyB8IFNlbGVjdC1PYmplY3QgLUZpcnN0IDEKICAgIGlmICgkRikgeyByZXR1cm4gQHsgR2F0ZXdheSA9ICRGLk5leHRIb3A7IEludGVyZmFjZUluZGV4ID0gJEYuSW50ZXJmYWNlSW5kZXggfSB9CiAgICByZXR1cm4gJG51bGwKfQoKZnVuY3Rpb24gT2J0ZW5lci1TdWJyZWRCYXNlIHsKICAgIHBhcmFtKFtzdHJpbmddJEdhdGV3YXksIFtpbnRdJEludGVyZmFjZUluZGV4KQogICAgJEMgPSBHZXQtTmV0SVBBZGRyZXNzIC1JbnRlcmZhY2VJbmRleCAkSW50ZXJmYWNlSW5kZXggLUFkZHJlc3NGYW1pbHkgSVB2NCBgCiAgICAgICAgIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlIHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgMQogICAgaWYgKCRDIC1hbmQgJEMuUHJlZml4TGVuZ3RoIC1nZSAyNCkgewogICAgICAgICRPID0gJEMuSVBBZGRyZXNzLlNwbGl0KCcuJykKICAgICAgICByZXR1cm4gIiQoJE9bMF0pLiQoJE9bMV0pLiQoJE9bMl0pIgogICAgfQogICAgcmV0dXJuICRHYXRld2F5LlN1YnN0cmluZygwLCAkR2F0ZXdheS5MYXN0SW5kZXhPZignLicpKQp9CgpmdW5jdGlvbiBUZXN0LVB1ZXJ0byB7CiAgICBwYXJhbShbc3RyaW5nXSREZXN0aW5vLCBbaW50XSRQdWVydG8sIFtpbnRdJFRpbWVvdXRNcyA9IDEwMDApCiAgICB0cnkgewogICAgICAgICR0Y3AgICA9IE5ldy1PYmplY3QgU3lzdGVtLk5ldC5Tb2NrZXRzLlRjcENsaWVudAogICAgICAgICRhc3luYyA9ICR0Y3AuQmVnaW5Db25uZWN0KCREZXN0aW5vLCAkUHVlcnRvLCAkbnVsbCwgJG51bGwpCiAgICAgICAgJG9rICAgID0gJGFzeW5jLkFzeW5jV2FpdEhhbmRsZS5XYWl0T25lKCRUaW1lb3V0TXMsICRmYWxzZSkKICAgICAgICBpZiAoJG9rIC1hbmQgJHRjcC5Db25uZWN0ZWQpIHsgJHRjcC5FbmRDb25uZWN0KCRhc3luYykgfCBPdXQtTnVsbDsgJHRjcC5DbG9zZSgpOyByZXR1cm4gJHRydWUgfQogICAgICAgICR0Y3AuQ2xvc2UoKQogICAgfSBjYXRjaCB7IH0KICAgIHJldHVybiAkZmFsc2UKfQoKZnVuY3Rpb24gR2V0LU1BQ0Rlc2RlQVJQIHsKICAgIHBhcmFtKFtzdHJpbmddJElQKQogICAgdHJ5IHsKICAgICAgICBmb3JlYWNoICgkTCBpbiAoYXJwIC1hICRJUCAyPiRudWxsKSkgewogICAgICAgICAgICBpZiAoJEwgLW1hdGNoIFtyZWdleF06OkVzY2FwZSgkSVApIC1hbmQKICAgICAgICAgICAgICAgICRMIC1tYXRjaCAnKFswLTlhLWZBLUZdezJ9Wy06XVswLTlhLWZBLUZdezJ9Wy06XVswLTlhLWZBLUZdezJ9Wy06XVswLTlhLWZBLUZdezJ9Wy06XVswLTlhLWZBLUZdezJ9Wy06XVswLTlhLWZBLUZdezJ9KScpIHsKICAgICAgICAgICAgICAgICRNID0gJE1hdGNoZXNbMV0uVG9VcHBlcigpCiAgICAgICAgICAgICAgICBpZiAoJE0gLW5lICJGRi1GRi1GRi1GRi1GRi1GRiIgLWFuZCAkTSAtbmUgIjAwLTAwLTAwLTAwLTAwLTAwIikgeyByZXR1cm4gJE0gfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfSBjYXRjaCB7IH0KICAgIHJldHVybiAiRGVzY29ub2NpZGEiCn0KCmZ1bmN0aW9uIEdldC1GYWJyaWNhbnRlIHsKICAgIHBhcmFtKFtzdHJpbmddJE1BQykKICAgIGlmICgkTUFDIC1lcSAiRGVzY29ub2NpZGEiKSB7IHJldHVybiAiRGVzY29ub2NpZG8iIH0KICAgICRQcmVmaWpvID0gKCRNQUMgLXJlcGxhY2UgIjoiLCAiLSIpLlRvVXBwZXIoKS5TdWJzdHJpbmcoMCwgOCkKICAgIGlmICgkc2NyaXB0Ok9VSS5Db250YWluc0tleSgkUHJlZmlqbykpIHsgcmV0dXJuICRzY3JpcHQ6T1VJWyRQcmVmaWpvXSB9CiAgICByZXR1cm4gIkRlc2Nvbm9jaWRvIgp9CgpmdW5jdGlvbiBFeHBvcnRhci1JbmZvcm1lIHsKICAgIHBhcmFtKFtzdHJpbmdbXV0kQ29udGVuaWRvLCBbc3RyaW5nXSROb21icmVNb2R1bG8pCiAgICAkRmVjaGEgICAgICA9IEdldC1EYXRlIC1Gb3JtYXQgInl5eXktTU0tZGRfSEgtbW0tc3MiCiAgICAkRXNjcml0b3JpbyA9IFtFbnZpcm9ubWVudF06OkdldEZvbGRlclBhdGgoIkRlc2t0b3AiKQogICAgJEFyY2hpdm8gICAgPSAiJEVzY3JpdG9yaW9cQXRsYXNSZWRfJHtOb21icmVNb2R1bG99XyR7RmVjaGF9LnR4dCIKICAgICRDb250ZW5pZG8gfCBPdXQtRmlsZSAtRmlsZVBhdGggJEFyY2hpdm8gLUVuY29kaW5nIFVURjgKICAgIFdyaXRlLUhvc3QgIiAgSW5mb3JtZSBndWFyZGFkbzogJEFyY2hpdm8iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgIHJldHVybiAkQXJjaGl2bwp9CgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyAgUEFOVEFMTEEgREUgSU5GT1JNQUNJT04gREVMIE1PRFVMTwojICBSZXRvcm5hICR0cnVlIHBhcmEgY29udGludWFyLCAkZmFsc2UgcGFyYSBjYW5jZWxhcgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KZnVuY3Rpb24gTW9zdHJhci1JbmZvTW9kdWxvIHsKICAgIHBhcmFtKFtzdHJpbmddJExldHJhKQoKICAgIGlmICgtbm90ICRzY3JpcHQ6TW9zdHJhckluZm8gLW9yICRzY3JpcHQ6TW9kb0F1dG8pIHsgcmV0dXJuICR0cnVlIH0KCiAgICAkRCA9ICRzY3JpcHQ6SW5mb1skTGV0cmFdCiAgICBpZiAoLW5vdCAkRCkgeyByZXR1cm4gJHRydWUgfQoKICAgIENsZWFyLUhvc3QKICAgICRTZXAgPSAiLSIgKiA2NAoKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgJFNlcCIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAoIiAgWyAkTGV0cmEgXSAgIiArICRELlRpdHVsby5Ub1VwcGVyKCkpIC1Gb3JlZ3JvdW5kQ29sb3IgJEQuQ29sb3IKICAgIFdyaXRlLUhvc3QgIiAgJFNlcCIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgIFdyaXRlLUhvc3QgImBuICBRVUUgSEFDRSIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgIGZvcmVhY2ggKCRMIGluICRELkRlc2MpICB7IFdyaXRlLUhvc3QgIiAgICAkTCIgLUZvcmVncm91bmRDb2xvciBHcmF5IH0KCiAgICBXcml0ZS1Ib3N0ICJgbiAgUFJFQ0FVQ0lPTkVTIiAtRm9yZWdyb3VuZENvbG9yIERhcmtZZWxsb3cKICAgIGZvcmVhY2ggKCRMIGluICRELlByZWMpICB7IFdyaXRlLUhvc3QgIiAgICAkTCIgLUZvcmVncm91bmRDb2xvciBHcmF5IH0KCiAgICBXcml0ZS1Ib3N0ICJgbiAgUkVDT01FTkRBQ0lPTkVTIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIGZvcmVhY2ggKCRMIGluICRELlJlY3MpICB7IFdyaXRlLUhvc3QgIiAgICAkTCIgLUZvcmVncm91bmRDb2xvciBHcmF5IH0KCiAgICBXcml0ZS1Ib3N0ICJgbiAgRUpFTVBMT1MgREUgVVNPIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICBmb3JlYWNoICgkTCBpbiAkRC5FamVtKSAgeyBXcml0ZS1Ib3N0ICIgICAgJEwiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JheSB9CgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICAkU2VwIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIgIFMgPSBjb250aW51YXIgICBOID0gY2FuY2VsYXIgICBYID0gbm8gbW9zdHJhciBpbmZvIGVuIGVsIGZ1dHVybyIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiICAkU2VwIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAkUiA9IFJlYWQtSG9zdCAiICBUdSBlbGVjY2lvbiIKCiAgICBpZiAoJFIuVG9VcHBlcigpIC1lcSAiWCIpIHsgJHNjcmlwdDpNb3N0cmFySW5mbyA9ICRmYWxzZTsgcmV0dXJuICR0cnVlIH0KICAgIGlmICgkUi5Ub1VwcGVyKCkgLWVxICJOIikgeyByZXR1cm4gJGZhbHNlIH0KICAgIHJldHVybiAkdHJ1ZQp9CgpmdW5jdGlvbiBFc3BlcmFyLUVudGVyIHsKICAgIHBhcmFtKFtzd2l0Y2hdJFNpbGVuY2lvc28pCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgJHNjcmlwdDpNb2RvQXV0bykgewogICAgICAgIFJlYWQtSG9zdCAiYG4gIFByZXNpb25hIEVOVEVSIHBhcmEgdm9sdmVyIGFsIG1lbnUuLi4iCiAgICB9Cn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojICBNT0RVTE8gQSAtIEFVRElUT1JJQSBERSBQVUVSVE9TIExBTgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KZnVuY3Rpb24gTW9kdWxvLUF1ZGl0b3JpYSB7CiAgICBwYXJhbShbc3dpdGNoXSRTaWxlbmNpb3NvKQogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90IChNb3N0cmFyLUluZm9Nb2R1bG8gIkEiKSkgeyByZXR1cm4gQCgpIH0KCiAgICBDbGVhci1Ib3N0CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgIFsgQSBdICBBVURJVE9SSUEgREUgUFVFUlRPUyBMQU4iIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiICAkKCItIiAqIDYwKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgICRSSSA9IE9idGVuZXItUm91dGVyCiAgICBpZiAoLW5vdCAkUkkpIHsgV3JpdGUtSG9zdCAiYG4gIE5vIHNlIHB1ZG8gZGV0ZWN0YXIgZWwgcm91dGVyLiIgLUZvcmVncm91bmRDb2xvciBSZWQ7IEVzcGVyYXItRW50ZXIgLVNpbGVuY2lvc286JFNpbGVuY2lvc287IHJldHVybiBAKCkgfQogICAgJEdXID0gJFJJLkdhdGV3YXkKICAgIFdyaXRlLUhvc3QgImBuICBSb3V0ZXIgZGV0ZWN0YWRvOiAkR1ciIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKCiAgICAkQmFzZSA9IEAoMjEsIDIyLCAyMywgODAsIDQ0MywgODA4MCwgODQ0MywgODg4OCwgOTA5MCkKICAgIFdyaXRlLUhvc3QgIiAgUHVlcnRvcyBiYXNlICAgIDogJCgkQmFzZSAtam9pbiAnLCAnKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgICRFeHRyYSA9ICIiCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgJHNjcmlwdDpNb2RvQXV0bykgewogICAgICAgICRFeHRyYSA9IFJlYWQtSG9zdCAiYG4gIFB1ZXJ0b3MgYWRpY2lvbmFsZXMgc2VwYXJhZG9zIHBvciBjb21hIChvIEVOVEVSIHBhcmEgb21pdGlyKSIKICAgIH0KCiAgICAkUHVlcnRvcyA9ICRCYXNlCiAgICBpZiAoJEV4dHJhLlRyaW0oKSAtbmUgIiIpIHsKICAgICAgICAkQWRkID0gJEV4dHJhIC1zcGxpdCAnLCcgfCBGb3JFYWNoLU9iamVjdCB7ICRfLlRyaW0oKSB9IHwKICAgICAgICAgICAgICAgV2hlcmUtT2JqZWN0IHsgJF8gLW1hdGNoICdeXGQrJCcgfSB8IEZvckVhY2gtT2JqZWN0IHsgW2ludF0kXyB9CiAgICAgICAgJFB1ZXJ0b3MgPSAoJFB1ZXJ0b3MgKyAkQWRkKSB8IFNvcnQtT2JqZWN0IC1VbmlxdWUKICAgIH0KCiAgICBXcml0ZS1Ib3N0ICJgbiAgRXNjYW5lYW5kbyAkKCRQdWVydG9zLkNvdW50KSBwdWVydG9zIGVuICRHVy4uLmBuIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgJExleWVuZGFzID0gQHsKICAgICAgICAyMSA9ICJGVFAgICAgICAgICBUcmFuc2ZlcmVuY2lhIGRlIGFyY2hpdm9zLiBJTlNFR1VSTyBzaSBleHB1ZXN0by4iCiAgICAgICAgMjIgPSAiU1NIICAgICAgICAgQWNjZXNvIENMSSBjaWZyYWRvLiBOb3JtYWwgZW4gcm91dGVycyBhZG1pbmlzdHJhYmxlcy4iCiAgICAgICAgMjMgPSAiVGVsbmV0ICAgICAgVGV4dG8gcGxhbm8sIHNpbiBjaWZyYWRvLiBNVVkgUEVMSUdST1NPIHNpIGFiaWVydG8uIgogICAgICAgIDgwID0gIkhUVFAgICAgICAgIFBhbmVsIGRlbCByb3V0ZXIgcG9yIHJlZCBsb2NhbC4iCiAgICAgICAgNDQzPSAiSFRUUFMgICAgICAgUGFuZWwgc2VndXJvIGRlbCByb3V0ZXIgcG9yIHJlZCBsb2NhbC4iCiAgICAgICAgODA4MD0iSFRUUC1BbHQgICAgUGFuZWwgc2VjdW5kYXJpbyBlbiBtdWNob3Mgcm91dGVycy4iCiAgICAgICAgODQ0Mz0iSFRUUFMtQWx0ICAgUGFuZWwgSFRUUFMgc2VjdW5kYXJpby4iCiAgICAgICAgODg4OD0iQWx0IGNvbXVuICAgUHJlc2VudGUgZW4gYWxndW5vcyByb3V0ZXJzIG1vZGVybm9zLiIKICAgICAgICA5MDkwPSJBZG1pbi1BbHQgICBQdWVydG8gZGUgYWRtaW5pc3RyYWNpb24gYWx0ZXJuYXRpdm8uIgogICAgICAgIDMzODk9IlJEUCAgICAgICAgIEVzY3JpdG9yaW8gcmVtb3RvIFdpbmRvd3MuIENSSVRJQ08gc2kgYWJpZXJ0by4iCiAgICB9CgogICAgJExvZyAgICAgID0gQCgiPT09IEFVRElUT1JJQSBERSBQVUVSVE9TIExBTiA9PT0gJChHZXQtRGF0ZSkiLCAiUm91dGVyOiAkR1ciLCAiIikKICAgICRBYmllcnRvcyA9IEAoKQoKICAgIGZvcmVhY2ggKCRQIGluICRQdWVydG9zKSB7CiAgICAgICAgJE9rID0gVGVzdC1QdWVydG8gLURlc3Rpbm8gJEdXIC1QdWVydG8gJFAgLVRpbWVvdXRNcyAxMDAwCiAgICAgICAgaWYgKCRPaykgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIFtBQklFUlRPXSAgUHVlcnRvICRQIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICAkTG9nICs9ICIgIFtBQklFUlRPXSAgUHVlcnRvICRQIgogICAgICAgICAgICAkQWJpZXJ0b3MgKz0gJFAKICAgICAgICB9IGVsc2UgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIFtjZXJyYWRvXSAgUHVlcnRvICRQIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmVlbgogICAgICAgICAgICAkTG9nICs9ICIgIFtjZXJyYWRvXSAgUHVlcnRvICRQIgogICAgICAgIH0KICAgIH0KCiAgICBXcml0ZS1Ib3N0ICJgbiAgJCgiLSIgKiA2MCkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiAgTEVZRU5EQSBERSBQVUVSVE9TIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIGZvcmVhY2ggKCRQIGluICRQdWVydG9zKSB7CiAgICAgICAgaWYgKCRMZXllbmRhcy5Db250YWluc0tleSgkUCkpIHsgV3JpdGUtSG9zdCAiICAgIFskUF0gICQoJExleWVuZGFzWyRQXSkiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JheSB9CiAgICB9CiAgICBXcml0ZS1Ib3N0ICJgbiAgTk9UQTogUHVlcnRvcyBhYmllcnRvcyBlbiBMQU4gc29uIG5vcm1hbGVzLiBFbCByaWVzZ28gcmVhbCBlcyIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiICAgICAgICBzaSBhcGFyZWNlbiBhYmllcnRvcyBkZXNkZSBJbnRlcm5ldC4gVXNhciBlbCBtb2R1bG8gSC4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKCiAgICAkc2NyaXB0Okhpc3RvcmlhbFNlc2lvbi5BZGQoIltBXSBBdWRpdG9yaWEgJEdXIHwgQWJpZXJ0b3M6ICQoaWYgKCRBYmllcnRvcy5Db3VudCkgeyAkQWJpZXJ0b3MgLWpvaW4gJywnIH0gZWxzZSB7ICdOaW5ndW5vJyB9KSIpCgogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90ICRzY3JpcHQ6TW9kb0F1dG8pIHsKICAgICAgICAkRXhwID0gUmVhZC1Ib3N0ICJgbiAgRXhwb3J0YXIgaW5mb3JtZSBhIFRYVD8gKFMvTikiCiAgICAgICAgaWYgKCRFeHAuVG9VcHBlcigpIC1lcSAiUyIpIHsgRXhwb3J0YXItSW5mb3JtZSAtQ29udGVuaWRvICRMb2cgLU5vbWJyZU1vZHVsbyAiQXVkaXRvcmlhIiB8IE91dC1OdWxsIH0KICAgIH0KCiAgICBFc3BlcmFyLUVudGVyIC1TaWxlbmNpb3NvOiRTaWxlbmNpb3NvCiAgICByZXR1cm4gJExvZwp9CgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyAgTU9EVUxPIEIgLSBFU0NBTkVPIERFIERJU1BPU0lUSVZPUyArIERFVEVDQ0lPTiBJUHMgRFVQTElDQURBUyAoSykKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmZ1bmN0aW9uIE1vZHVsby1Fc2NhbmVvIHsKICAgIHBhcmFtKFtzd2l0Y2hdJFNpbGVuY2lvc28pCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgKE1vc3RyYXItSW5mb01vZHVsbyAiQiIpKSB7IHJldHVybiBAKCkgfQoKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgWyBCIF0gIEVTQ0FORU8gREUgRElTUE9TSVRJVk9TIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIFdyaXRlLUhvc3QgIiAgJCgiLSIgKiA2MCkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKCiAgICAkUkkgPSBPYnRlbmVyLVJvdXRlcgogICAgaWYgKC1ub3QgJFJJKSB7IFdyaXRlLUhvc3QgImBuICBObyBzZSBwdWRvIGRldGVjdGFyIGVsIHJvdXRlci4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkOyBFc3BlcmFyLUVudGVyIC1TaWxlbmNpb3NvOiRTaWxlbmNpb3NvOyByZXR1cm4gQCgpIH0KICAgICRHVyAgPSAkUkkuR2F0ZXdheQogICAgJFN1YiA9IE9idGVuZXItU3VicmVkQmFzZSAtR2F0ZXdheSAkR1cgLUludGVyZmFjZUluZGV4ICRSSS5JbnRlcmZhY2VJbmRleAoKICAgIFdyaXRlLUhvc3QgImBuICBTdWJyZWQ6ICR7U3VifS4xIC0gJHtTdWJ9LjI1NCIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiICBFc3RvIHB1ZWRlIHRhcmRhciBoYXN0YSA5MCBzZWd1bmRvcy4gUG9yIGZhdm9yIGVzcGVyYS5gbiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgICRQaW5nICAgICAgICA9IE5ldy1PYmplY3QgU3lzdGVtLk5ldC5OZXR3b3JrSW5mb3JtYXRpb24uUGluZwogICAgJEVuY29udHJhZG9zID0gW1N5c3RlbS5Db2xsZWN0aW9ucy5HZW5lcmljLkxpc3RbaGFzaHRhYmxlXV06Om5ldygpCiAgICAkTUFDVmlzdG8gICAgPSBAe30KICAgICRMb2cgICAgICAgICA9IEAoIj09PSBFU0NBTkVPIERFIERJU1BPU0lUSVZPUyA9PT0gJChHZXQtRGF0ZSkiLCAiU3VicmVkOiAke1N1Yn0ueCIsICIiKQoKICAgIGZvciAoJGkgPSAxOyAkaSAtbGUgMjU0OyAkaSsrKSB7CiAgICAgICAgJElQID0gIiRTdWIuJGkiCiAgICAgICAgdHJ5IHsKICAgICAgICAgICAgaWYgKCRQaW5nLlNlbmQoJElQLCAxNTApLlN0YXR1cyAtZXEgJ1N1Y2Nlc3MnKSB7CgogICAgICAgICAgICAgICAgJEhvc3RfID0gIk9jdWx0byIKICAgICAgICAgICAgICAgIHRyeSB7ICRIID0gW1N5c3RlbS5OZXQuRG5zXTo6R2V0SG9zdEVudHJ5KCRJUCk7IGlmICgkSC5Ib3N0TmFtZSkgeyAkSG9zdF8gPSAkSC5Ib3N0TmFtZSB9IH0gY2F0Y2ggeyB9CgogICAgICAgICAgICAgICAgJG51bGwgPSBhcnAgLWEgMj4kbnVsbAogICAgICAgICAgICAgICAgU3RhcnQtU2xlZXAgLU1pbGxpc2Vjb25kcyA4MAogICAgICAgICAgICAgICAgJE1BQyAgPSBHZXQtTUFDRGVzZGVBUlAgLUlQICRJUAogICAgICAgICAgICAgICAgJEZhYiAgPSBHZXQtRmFicmljYW50ZSAtTUFDICRNQUMKCiAgICAgICAgICAgICAgICAjIE1vZHVsbyBLOiBkZXRlY2Npb24gZGUgY29uZmxpY3RvIGRlIElQCiAgICAgICAgICAgICAgICAkQ29uZmxpY3RvID0gIiIKICAgICAgICAgICAgICAgIGlmICgkTUFDIC1uZSAiRGVzY29ub2NpZGEiKSB7CiAgICAgICAgICAgICAgICAgICAgaWYgKCRNQUNWaXN0by5Db250YWluc0tleSgkTUFDKSkgewogICAgICAgICAgICAgICAgICAgICAgICAkQ29uZmxpY3RvID0gIiAgWyEhISBDT05GTElDVE86IG1pc21hIE1BQyBxdWUgJCgkTUFDVmlzdG9bJE1BQ10pXSIKICAgICAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgICAgICAkTUFDVmlzdG9bJE1BQ10gPSAkSVAKICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9CgogICAgICAgICAgICAgICAgJEVudHJhZGEgPSBAeyBJUCA9ICRJUDsgTUFDID0gJE1BQzsgSG9zdCA9ICRIb3N0XzsgRmFiID0gJEZhYiB9CiAgICAgICAgICAgICAgICAkRW5jb250cmFkb3MuQWRkKCRFbnRyYWRhKQoKICAgICAgICAgICAgICAgIGlmICgkSVAgLWVxICRHVykgewogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgW1JPVVRFUl0gICAkSVAgICRNQUMgICRGYWIiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgICAgICAkTG9nICs9ICIgIFtST1VURVJdICAgJElQIHwgJE1BQyB8ICRGYWIiCiAgICAgICAgICAgICAgICB9IGVsc2VpZiAoJENvbmZsaWN0bykgewogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgW0NPTkZMSUNUT10kSVAgICRNQUMgICRGYWIkQ29uZmxpY3RvIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICAgICAgICAgICRMb2cgKz0gIiAgW0NPTkZMSUNUT10kSVAgfCAkTUFDIHwgJEZhYiRDb25mbGljdG8iCiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgW2Rpc3BdICAgICAkSVAgICRNQUMgICRGYWIgIHwgICRIb3N0XyIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgICAgICAgICAgICAgJExvZyArPSAiICBbZGlzcF0gICAgICRJUCB8ICRNQUMgfCAkRmFiIHwgJEhvc3RfIgogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfSBjYXRjaCB7IH0KICAgIH0KCiAgICBXcml0ZS1Ib3N0ICJgbiAgJCgiLSIgKiA2MCkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiAgVG90YWwgZW5jb250cmFkb3M6ICQoJEVuY29udHJhZG9zLkNvdW50KSBkaXNwb3NpdGl2b3MiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICBpZiAoJE1BQ1Zpc3RvLkNvdW50IC1sdCAoJEVuY29udHJhZG9zIHwgV2hlcmUtT2JqZWN0IHsgJF8uTUFDIC1uZSAiRGVzY29ub2NpZGEiIH0gfCBNZWFzdXJlLU9iamVjdCkuQ291bnQpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgIEFWSVNPOiBTZSBkZXRlY3Rhcm9uIGNvbmZsaWN0b3MgZGUgSVAuIFZlciBsaW5lYXMgbWFyY2FkYXMgW0NPTkZMSUNUT10uIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgfQoKICAgICMgR3VhcmRhciBlc3RhZG8gcGFyYSBtb2R1bG8gTgogICAgdHJ5IHsKICAgICAgICAkTGluZWFzID0gJEVuY29udHJhZG9zIHwgRm9yRWFjaC1PYmplY3QgeyAiJCgkXy5JUCl8JCgkXy5NQUMpfCQoJF8uSG9zdCkiIH0KICAgICAgICAkTGluZWFzIHwgT3V0LUZpbGUgJHNjcmlwdDpBcmNoaXZvRXN0YWRvIC1FbmNvZGluZyBVVEY4IC1Gb3JjZQogICAgICAgIFdyaXRlLUhvc3QgIiAgRXN0YWRvIGd1YXJkYWRvIHBhcmEgY29tcGFyYXRpdmEgKG1vZHVsbyBOKS4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIH0gY2F0Y2ggeyB9CgogICAgJHNjcmlwdDpIaXN0b3JpYWxTZXNpb24uQWRkKCJbQl0gRXNjYW5lbyAke1N1Yn0ueCB8ICQoJEVuY29udHJhZG9zLkNvdW50KSBkaXNwb3NpdGl2b3MiKQoKICAgIGlmICgtbm90ICRTaWxlbmNpb3NvIC1hbmQgLW5vdCAkc2NyaXB0Ok1vZG9BdXRvKSB7CiAgICAgICAgJEV4cCA9IFJlYWQtSG9zdCAiYG4gIEV4cG9ydGFyIGluZm9ybWUgYSBUWFQ/IChTL04pIgogICAgICAgIGlmICgkRXhwLlRvVXBwZXIoKSAtZXEgIlMiKSB7IEV4cG9ydGFyLUluZm9ybWUgLUNvbnRlbmlkbyAkTG9nIC1Ob21icmVNb2R1bG8gIkVzY2FuZW8iIHwgT3V0LU51bGwgfQogICAgfQoKICAgIEVzcGVyYXItRW50ZXIgLVNpbGVuY2lvc286JFNpbGVuY2lvc28KICAgIHJldHVybiAkTG9nCn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojICBNT0RVTE8gQyAtIFBBTkVMIERFTCBST1VURVIKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmZ1bmN0aW9uIE1vZHVsby1QYW5lbCB7CiAgICBwYXJhbShbc3dpdGNoXSRTaWxlbmNpb3NvKQogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90IChNb3N0cmFyLUluZm9Nb2R1bG8gIkMiKSkgeyByZXR1cm4gfQoKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgWyBDIF0gIFBBTkVMIERFTCBST1VURVIiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiICAkKCItIiAqIDYwKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgICRSSSA9IE9idGVuZXItUm91dGVyCiAgICBpZiAoLW5vdCAkUkkpIHsgV3JpdGUtSG9zdCAiYG4gIE5vIHNlIHB1ZG8gZGV0ZWN0YXIgZWwgcm91dGVyLiIgLUZvcmVncm91bmRDb2xvciBSZWQ7IEVzcGVyYXItRW50ZXIgLVNpbGVuY2lvc286JFNpbGVuY2lvc287IHJldHVybiB9CiAgICAkR1cgPSAkUkkuR2F0ZXdheQoKICAgIFdyaXRlLUhvc3QgImBuICBEZXRlY3RhbmRvIHByb3RvY29sbyBlbiAkR1cuLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICRVUkwgPSAkbnVsbAogICAgaWYgKFRlc3QtUHVlcnRvIC1EZXN0aW5vICRHVyAtUHVlcnRvIDQ0MyAtVGltZW91dE1zIDE1MDApIHsKICAgICAgICAkVVJMID0gImh0dHBzOi8vJEdXIgogICAgICAgIFdyaXRlLUhvc3QgIiAgUHVlcnRvIDQ0MyBkaXNwb25pYmxlICAtPiAgdXNhbmRvIEhUVFBTIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICB9IGVsc2VpZiAoVGVzdC1QdWVydG8gLURlc3Rpbm8gJEdXIC1QdWVydG8gODAgLVRpbWVvdXRNcyAxNTAwKSB7CiAgICAgICAgJFVSTCA9ICJodHRwOi8vJEdXIgogICAgICAgIFdyaXRlLUhvc3QgIiAgUHVlcnRvIDgwIGRpc3BvbmlibGUgICAtPiAgdXNhbmRvIEhUVFAiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICB9IGVsc2UgewogICAgICAgICRVUkwgPSAiaHR0cDovLyRHVyIKICAgICAgICBXcml0ZS1Ib3N0ICIgIE5pbmd1biBwdWVydG8gY29uZmlybW8gcmVzcHVlc3RhLiBJbnRlbnRhbmRvIEhUVFAuLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIH0KCiAgICBXcml0ZS1Ib3N0ICJgbiAgQWJyaWVuZG86ICRVUkwiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiAgU2kgZWwgbmF2ZWdhZG9yIG11ZXN0cmEgJ1NpdGlvIG5vIHNlZ3VybycsIGVzIG5vcm1hbCBlbiBMQU4uIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIgIENyZWRlbmNpYWxlcyBoYWJpdHVhbGVzOiBhZG1pbiAvIGFkbWluICB8ICBhZG1pbiAvIDEyMzQgIHwgIGFkbWluIC8gKHZhY2lvKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgIHRyeSB7IFN0YXJ0LVByb2Nlc3MgJFVSTCB9IGNhdGNoIHsgV3JpdGUtSG9zdCAiICBFcnJvciBhbCBhYnJpciBlbCBuYXZlZ2Fkb3IuIiAtRm9yZWdyb3VuZENvbG9yIFJlZCB9CgogICAgJHNjcmlwdDpIaXN0b3JpYWxTZXNpb24uQWRkKCJbQ10gUGFuZWwgYWJpZXJ0bzogJFVSTCIpCiAgICBFc3BlcmFyLUVudGVyIC1TaWxlbmNpb3NvOiRTaWxlbmNpb3NvCn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojICBNT0RVTE8gRCAtIERJQUdOT1NUSUNPIERFIExBVEVOQ0lBCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpmdW5jdGlvbiBNb2R1bG8tTGF0ZW5jaWEgewogICAgcGFyYW0oW3N3aXRjaF0kU2lsZW5jaW9zbykKICAgIGlmICgtbm90ICRTaWxlbmNpb3NvIC1hbmQgLW5vdCAoTW9zdHJhci1JbmZvTW9kdWxvICJEIikpIHsgcmV0dXJuIEAoKSB9CgogICAgQ2xlYXItSG9zdAogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICBbIEQgXSAgRElBR05PU1RJQ08gREUgTEFURU5DSUEiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICBXcml0ZS1Ib3N0ICIgICQoIi0iICogNjApIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgJFJJID0gT2J0ZW5lci1Sb3V0ZXIKICAgIGlmICgtbm90ICRSSSkgeyBXcml0ZS1Ib3N0ICJgbiAgTm8gc2UgcHVkbyBkZXRlY3RhciBlbCByb3V0ZXIuIiAtRm9yZWdyb3VuZENvbG9yIFJlZDsgRXNwZXJhci1FbnRlciAtU2lsZW5jaW9zbzokU2lsZW5jaW9zbzsgcmV0dXJuIEAoKSB9CiAgICAkR1cgPSAkUkkuR2F0ZXdheQoKICAgICRPYmpldGl2b3MgPSBAKAogICAgICAgIEB7IE4gPSAiUm91dGVyICAgKExBTikgICAgIjsgSVAgPSAkR1cgICAgICAgfSwKICAgICAgICBAeyBOID0gIkNsb3VkZmxhcmUgKFdBTikgICI7IElQID0gIjEuMS4xLjEiIH0sCiAgICAgICAgQHsgTiA9ICJHb29nbGUgICAgIChXQU4pICAiOyBJUCA9ICI4LjguOC44IiB9CiAgICApCgogICAgJExvZyA9IEAoIj09PSBESUFHTk9TVElDTyBERSBMQVRFTkNJQSA9PT0gJChHZXQtRGF0ZSkiLCAiUm91dGVyOiAkR1ciLCAiIikKICAgICRQTyAgPSBOZXctT2JqZWN0IFN5c3RlbS5OZXQuTmV0d29ya0luZm9ybWF0aW9uLlBpbmcKICAgICROICAgPSAxMAoKICAgIGZvcmVhY2ggKCRPYmogaW4gJE9iamV0aXZvcykgewogICAgICAgIFdyaXRlLUhvc3QgImBuICAkKCRPYmouTi5UcmltKCkpICgkKCRPYmouSVApKSAgLSAgJE4gcGluZ3MiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgICRUID0gQCgpOyAkRiA9IDAKICAgICAgICBmb3IgKCRwID0gMTsgJHAgLWxlICROOyAkcCsrKSB7CiAgICAgICAgICAgIHRyeSB7CiAgICAgICAgICAgICAgICAkUiA9ICRQTy5TZW5kKCRPYmouSVAsIDIwMDApCiAgICAgICAgICAgICAgICBpZiAoJFIuU3RhdHVzIC1lcSAnU3VjY2VzcycpIHsKICAgICAgICAgICAgICAgICAgICAkVCArPSAkUi5Sb3VuZHRyaXBUaW1lCiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFBpbmcgJHAgOiAkKCRSLlJvdW5kdHJpcFRpbWUpIG1zIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgICAgICAgICB9IGVsc2UgeyAkRisrOyBXcml0ZS1Ib3N0ICIgICAgUGluZyAkcCA6IFRJTUVPVVQiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya1JlZCB9CiAgICAgICAgICAgIH0gY2F0Y2ggeyAkRisrOyBXcml0ZS1Ib3N0ICIgICAgUGluZyAkcCA6IEVSUk9SIiAtRm9yZWdyb3VuZENvbG9yIERhcmtSZWQgfQogICAgICAgICAgICBTdGFydC1TbGVlcCAtTWlsbGlzZWNvbmRzIDIwMAogICAgICAgIH0KICAgICAgICBpZiAoJFQuQ291bnQgLWd0IDApIHsKICAgICAgICAgICAgJE1pbiA9ICgkVCB8IE1lYXN1cmUtT2JqZWN0IC1NaW5pbXVtKS5NaW5pbXVtCiAgICAgICAgICAgICRNYXggPSAoJFQgfCBNZWFzdXJlLU9iamVjdCAtTWF4aW11bSkuTWF4aW11bQogICAgICAgICAgICAkQXZnID0gW01hdGhdOjpSb3VuZCgoJFQgfCBNZWFzdXJlLU9iamVjdCAtQXZlcmFnZSkuQXZlcmFnZSwgMSkKICAgICAgICAgICAgJFJlcyA9ICJNaW46JHtNaW59bXMgIE1heDoke01heH1tcyAgTWVkaWE6JHtBdmd9bXMgIFBlcmRpZG9zOiRGLyROIgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIFJFU1VMVEFETyAgJFJlcyIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAgICAgJExvZyArPSAiICAkKCRPYmouTi5UcmltKCkpOiAkUmVzIgogICAgICAgICAgICBpZiAoJE9iai5JUCAtZXEgJEdXICAgICAtYW5kICRBdmcgLWd0IDIwKSAgeyBXcml0ZS1Ib3N0ICIgIEFWSVNPOiBMYXRlbmNpYSBhbCByb3V0ZXIgYWx0YS4gUG9zaWJsZSBjb25nZXN0aW9uIGVuIExBTiBvIFdpRmkgZGViaWwuIiAtRm9yZWdyb3VuZENvbG9yIFJlZCB9CiAgICAgICAgICAgIGlmICgkT2JqLklQIC1uZSAkR1cgICAgIC1hbmQgJEF2ZyAtZ3QgMTAwKSB7IFdyaXRlLUhvc3QgIiAgQVZJU086IExhdGVuY2lhIGEgSW50ZXJuZXQgYWx0YS4gUG9zaWJsZSBwcm9ibGVtYSBjb24gZWwgSVNQLiIgLUZvcmVncm91bmRDb2xvciBSZWQgfQogICAgICAgICAgICBpZiAoJEYgLWd0ICgkTiAvIDIpKSAgICAgICAgICAgICAgICAgICAgICAgIHsgV3JpdGUtSG9zdCAiICBBVklTTzogTWFzIGRlIGxhIG1pdGFkIGRlIGxvcyBwaW5ncyBzZSBwZXJkaWVyb24uIEZhbGxvIGdyYXZlLiIgLUZvcmVncm91bmRDb2xvciBSZWQgfQogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgU2luIHJlc3B1ZXN0YXMuIERlc3Rpbm8gaW5hY2Nlc2libGUuIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICAkTG9nICs9ICIgICQoJE9iai5OLlRyaW0oKSk6IFNJTiBSRVNQVUVTVEEiCiAgICAgICAgfQogICAgfQoKICAgICRzY3JpcHQ6SGlzdG9yaWFsU2VzaW9uLkFkZCgiW0RdIERpYWdub3N0aWNvIGRlIGxhdGVuY2lhIGNvbXBsZXRhZG8iKQoKICAgIGlmICgtbm90ICRTaWxlbmNpb3NvIC1hbmQgLW5vdCAkc2NyaXB0Ok1vZG9BdXRvKSB7CiAgICAgICAgJEV4cCA9IFJlYWQtSG9zdCAiYG4gIEV4cG9ydGFyIGluZm9ybWUgYSBUWFQ/IChTL04pIgogICAgICAgIGlmICgkRXhwLlRvVXBwZXIoKSAtZXEgIlMiKSB7IEV4cG9ydGFyLUluZm9ybWUgLUNvbnRlbmlkbyAkTG9nIC1Ob21icmVNb2R1bG8gIkxhdGVuY2lhIiB8IE91dC1OdWxsIH0KICAgIH0KCiAgICBFc3BlcmFyLUVudGVyIC1TaWxlbmNpb3NvOiRTaWxlbmNpb3NvCiAgICByZXR1cm4gJExvZwp9CgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyAgTU9EVUxPIEUgLSBJTkZPIERFTCBBREFQVEFET1IKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmZ1bmN0aW9uIE1vZHVsby1JbmZvQWRhcHRhZG9yIHsKICAgIHBhcmFtKFtzd2l0Y2hdJFNpbGVuY2lvc28pCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgKE1vc3RyYXItSW5mb01vZHVsbyAiRSIpKSB7IHJldHVybiBAKCkgfQoKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgWyBFIF0gIElORk9STUFDSU9OIERFTCBBREFQVEFET1IgREUgUkVEIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICBXcml0ZS1Ib3N0ICIgICQoIi0iICogNjApIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgJFJJID0gT2J0ZW5lci1Sb3V0ZXIKICAgIGlmICgtbm90ICRSSSkgeyBXcml0ZS1Ib3N0ICJgbiAgTm8gc2UgcHVkbyBkZXRlY3RhciBlbCByb3V0ZXIuIiAtRm9yZWdyb3VuZENvbG9yIFJlZDsgRXNwZXJhci1FbnRlciAtU2lsZW5jaW9zbzokU2lsZW5jaW9zbzsgcmV0dXJuIEAoKSB9CiAgICAkR1cgPSAkUkkuR2F0ZXdheQogICAgJElJID0gJFJJLkludGVyZmFjZUluZGV4CgogICAgJEEgICA9IEdldC1OZXRBZGFwdGVyIC1JbnRlcmZhY2VJbmRleCAkSUkgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICRJUCAgPSBHZXQtTmV0SVBBZGRyZXNzIC1JbnRlcmZhY2VJbmRleCAkSUkgLUFkZHJlc3NGYW1pbHkgSVB2NCAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSB8IFNlbGVjdC1PYmplY3QgLUZpcnN0IDEKICAgICRETlMgPSBHZXQtRG5zQ2xpZW50U2VydmVyQWRkcmVzcyAtSW50ZXJmYWNlSW5kZXggJElJIC1BZGRyZXNzRmFtaWx5IElQdjQgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICRFQyAgPSBpZiAoJEEuU3RhdHVzIC1lcSAnVXAnKSB7ICdHcmVlbicgfSBlbHNlIHsgJ1JlZCcgfQoKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgQURBUFRBRE9SIEFDVElWTyIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICBXcml0ZS1Ib3N0ICIgIE5vbWJyZSAgICAgICAgIDogJCgkQS5OYW1lKSIKICAgIFdyaXRlLUhvc3QgIiAgRGVzY3JpcGNpb24gICAgOiAkKCRBLkludGVyZmFjZURlc2NyaXB0aW9uKSIKICAgIFdyaXRlLUhvc3QgIiAgRXN0YWRvICAgICAgICAgOiAkKCRBLlN0YXR1cykiIC1Gb3JlZ3JvdW5kQ29sb3IgJEVDCiAgICBXcml0ZS1Ib3N0ICIgIFZlbG9jaWRhZCAgICAgIDogJChpZiAoJEEuTGlua1NwZWVkKSB7ICRBLkxpbmtTcGVlZCB9IGVsc2UgeyAnTi9BJyB9KSIKICAgIFdyaXRlLUhvc3QgIiAgTUFDIHByb3BpYSAgICAgOiAkKCRBLk1hY0FkZHJlc3MpIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwoKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgQ09ORklHVVJBQ0lPTiBJUCIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAkSVBDb2xvciA9IGlmICgkSVAuSVBBZGRyZXNzIC1tYXRjaCAiXjE2OVwuMjU0IikgeyAiUmVkIiB9IGVsc2UgeyAiWWVsbG93IiB9CiAgICBXcml0ZS1Ib3N0ICIgIElQIExvY2FsICAgICAgIDogJCgkSVAuSVBBZGRyZXNzKSIgLUZvcmVncm91bmRDb2xvciAkSVBDb2xvcgogICAgaWYgKCRJUC5JUEFkZHJlc3MgLW1hdGNoICJeMTY5XC4yNTQiKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiICBBVklTTzogSVAgQVBJUEEgKDE2OS4yNTQueC54KS4gRWwgREhDUCBubyBlc3RhIHJlc3BvbmRpZW5kby4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICB9CiAgICBXcml0ZS1Ib3N0ICIgIE1hc2NhcmEgZGUgcmVkIDogLyQoJElQLlByZWZpeExlbmd0aCkiCiAgICBXcml0ZS1Ib3N0ICIgIFB1ZXJ0YSBlbmxhY2UgIDogJEdXIgoKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgU0VSVklET1JFUyBETlMiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgaWYgKCRETlMgLWFuZCAkRE5TLlNlcnZlckFkZHJlc3Nlcy5Db3VudCAtZ3QgMCkgewogICAgICAgIGZvcmVhY2ggKCRTIGluICRETlMuU2VydmVyQWRkcmVzc2VzKSB7CiAgICAgICAgICAgICRETlNDb2xvciA9ICJXaGl0ZSIKICAgICAgICAgICAgJEROU05vdGEgID0gIiIKICAgICAgICAgICAgaWYgKCRTIC1lcSAiMTI3LjAuMC4xIikgIHsgJEROU0NvbG9yID0gIlllbGxvdyI7ICRETlNOb3RhID0gIiAgKEROUyBsb2NhbCBhY3Rpdm86IFBpLWhvbGUsIFZQTiBvIEROU0NyeXB0KSIgfQogICAgICAgICAgICBpZiAoJFMgLWVxICIxLjEuMS4xIikgICAgeyAkRE5TTm90YSA9ICIgIChDbG91ZGZsYXJlKSIgfQogICAgICAgICAgICBpZiAoJFMgLWVxICI4LjguOC44IikgICAgeyAkRE5TTm90YSA9ICIgIChHb29nbGUpIiB9CiAgICAgICAgICAgIGlmICgkUyAtZXEgIjkuOS45LjkiKSAgICB7ICRETlNOb3RhID0gIiAgKFF1YWQ5KSIgfQogICAgICAgICAgICBpZiAoJFMgLWVxICIyMDguNjcuMjIyLjIyMiIpIHsgJEROU05vdGEgPSAiICAoT3BlbkROUykiIH0KICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAtPiAkUyRETlNOb3RhIiAtRm9yZWdyb3VuZENvbG9yICRETlNDb2xvcgogICAgICAgIH0KICAgIH0gZWxzZSB7IFdyaXRlLUhvc3QgIiAgTm8gc2UgZW5jb250cmFyb24gRE5TIGNvbmZpZ3VyYWRvcy4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkgfQoKICAgICRMb2cgPSBAKAogICAgICAgICI9PT0gSU5GTyBBREFQVEFET1IgPT09ICQoR2V0LURhdGUpIiwKICAgICAgICAiTm9tYnJlICAgIDogJCgkQS5OYW1lKSAgfCAgJCgkQS5JbnRlcmZhY2VEZXNjcmlwdGlvbikiLAogICAgICAgICJFc3RhZG8gICAgOiAkKCRBLlN0YXR1cykgIHwgIFZlbG9jaWRhZDogJCgkQS5MaW5rU3BlZWQpIiwKICAgICAgICAiTUFDICAgICAgIDogJCgkQS5NYWNBZGRyZXNzKSIsCiAgICAgICAgIklQICAgICAgICA6ICQoJElQLklQQWRkcmVzcykvJCgkSVAuUHJlZml4TGVuZ3RoKSIsCiAgICAgICAgIkdhdGV3YXkgICA6ICRHVyIsCiAgICAgICAgIkROUyAgICAgICA6ICQoJEROUy5TZXJ2ZXJBZGRyZXNzZXMgLWpvaW4gJywgJykiCiAgICApCgogICAgJHNjcmlwdDpIaXN0b3JpYWxTZXNpb24uQWRkKCJbRV0gQWRhcHRhZG9yOiAkKCRBLk5hbWUpIHwgSVA6ICQoJElQLklQQWRkcmVzcykgfCBHVzogJEdXIikKCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgJHNjcmlwdDpNb2RvQXV0bykgewogICAgICAgICRFeHAgPSBSZWFkLUhvc3QgImBuICBFeHBvcnRhciBpbmZvcm1lIGEgVFhUPyAoUy9OKSIKICAgICAgICBpZiAoJEV4cC5Ub1VwcGVyKCkgLWVxICJTIikgeyBFeHBvcnRhci1JbmZvcm1lIC1Db250ZW5pZG8gJExvZyAtTm9tYnJlTW9kdWxvICJBZGFwdGFkb3IiIHwgT3V0LU51bGwgfQogICAgfQoKICAgIEVzcGVyYXItRW50ZXIgLVNpbGVuY2lvc286JFNpbGVuY2lvc28KICAgIHJldHVybiAkTG9nCn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojICBNT0RVTE8gRiAtIFRFU1QgRE5TCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpmdW5jdGlvbiBNb2R1bG8tVGVzdEROUyB7CiAgICBwYXJhbShbc3dpdGNoXSRTaWxlbmNpb3NvKQogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90IChNb3N0cmFyLUluZm9Nb2R1bG8gIkYiKSkgeyByZXR1cm4gQCgpIH0KCiAgICBDbGVhci1Ib3N0CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgIFsgRiBdICBURVNUIERFIFJFU09MVUNJT04gRE5TIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICBXcml0ZS1Ib3N0ICIgICQoIi0iICogNjApIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIiCgogICAgJERvbXMgPSBAKCJnb29nbGUuY29tIiwiY2xvdWRmbGFyZS5jb20iLCJtaWNyb3NvZnQuY29tIiwiYW1hem9uLmNvbSIsInlvdXR1YmUuY29tIikKICAgICRMb2cgID0gQCgiPT09IFRFU1QgRE5TID09PSAkKEdldC1EYXRlKSIsICIiKQogICAgJEYgICAgPSAwCgogICAgZm9yZWFjaCAoJEQgaW4gJERvbXMpIHsKICAgICAgICAkVDAgPSBHZXQtRGF0ZQogICAgICAgIHRyeSB7CiAgICAgICAgICAgICRSICA9IFtTeXN0ZW0uTmV0LkRuc106OkdldEhvc3RFbnRyeSgkRCkKICAgICAgICAgICAgJE1zID0gW01hdGhdOjpSb3VuZCgoTmV3LVRpbWVTcGFuIC1TdGFydCAkVDAgLUVuZCAoR2V0LURhdGUpKS5Ub3RhbE1pbGxpc2Vjb25kcykKICAgICAgICAgICAgJElQID0gKCRSLkFkZHJlc3NMaXN0IHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgMiB8IEZvckVhY2gtT2JqZWN0IHsgJF8uSVBBZGRyZXNzVG9TdHJpbmcgfSkgLWpvaW4gIiwgIgogICAgICAgICAgICAkQyAgPSBpZiAoJE1zIC1ndCA1MDApIHsgIlllbGxvdyIgfSBlbHNlIHsgIkdyZWVuIiB9CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgW09LXSAgICAkRCIgLU5vTmV3bGluZSAtRm9yZWdyb3VuZENvbG9yICRDCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICR7TXN9bXMgIC0+ICAkSVAiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgaWYgKCRNcyAtZ3QgNTAwKSB7IFdyaXRlLUhvc3QgIiAgICAgICAgICBBVklTTzogcmVzb2x1Y2lvbiBsZW50YS4gRE5TIGRlbCByb3V0ZXIgcHVlZGUgZXN0YXIgY29uZ2VzdGlvbmFkby4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya1llbGxvdyB9CiAgICAgICAgICAgICRMb2cgKz0gIiAgW09LXSAgICAkRCA6ICR7TXN9bXMgLT4gJElQIgogICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICAkTXMgPSBbTWF0aF06OlJvdW5kKChOZXctVGltZVNwYW4gLVN0YXJ0ICRUMCAtRW5kIChHZXQtRGF0ZSkpLlRvdGFsTWlsbGlzZWNvbmRzKQogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIFtGQUxMT10gJEQgICgke01zfW1zKSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgJExvZyArPSAiICBbRkFMTE9dICREIDogJHtNc31tcyIKICAgICAgICAgICAgJEYrKwogICAgICAgIH0KICAgIH0KCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBpZiAoJEYgLWVxICREb21zLkNvdW50KSB7CiAgICAgICAgV3JpdGUtSG9zdCAiICBBVklTTzogVG9kb3MgbG9zIGRvbWluaW9zIGZhbGxhcm9uLiBTaW4gSW50ZXJuZXQgbyBETlMgY29tcGxldGFtZW50ZSBjYWlkby4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgV3JpdGUtSG9zdCAiICBTb2x1Y2lvbiByYXBpZGE6IGNhbWJpYXIgRE5TIGEgMS4xLjEuMSBlbiBsYSBjb25maWd1cmFjaW9uIGRlbCBhZGFwdGFkb3IuIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgfSBlbHNlaWYgKCRGIC1ndCAwKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiICBBVklTTzogJEYgZG9taW5pbyhzKSBmYWxsYXJvbi4gUG9zaWJsZSBmaWx0cmFjaW9uIG8gY2FjaGUgRE5TIGNvcnJ1cHRhLiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgIH0KCiAgICAkc2NyaXB0Okhpc3RvcmlhbFNlc2lvbi5BZGQoIltGXSBUZXN0IEROUzogJCgkRG9tcy5Db3VudCAtICRGKS8kKCREb21zLkNvdW50KSBkb21pbmlvcyBPSyIpCgogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90ICRzY3JpcHQ6TW9kb0F1dG8pIHsKICAgICAgICAkRXhwID0gUmVhZC1Ib3N0ICJgbiAgRXhwb3J0YXIgaW5mb3JtZSBhIFRYVD8gKFMvTikiCiAgICAgICAgaWYgKCRFeHAuVG9VcHBlcigpIC1lcSAiUyIpIHsgRXhwb3J0YXItSW5mb3JtZSAtQ29udGVuaWRvICRMb2cgLU5vbWJyZU1vZHVsbyAiRE5TIiB8IE91dC1OdWxsIH0KICAgIH0KCiAgICBFc3BlcmFyLUVudGVyIC1TaWxlbmNpb3NvOiRTaWxlbmNpb3NvCiAgICByZXR1cm4gJExvZwp9CgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyAgTU9EVUxPIEggLSBQVUVSVE9TIFdBTiBQRUxJR1JPU09TCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpmdW5jdGlvbiBNb2R1bG8tUHVlcnRvc1dBTiB7CiAgICBwYXJhbShbc3dpdGNoXSRTaWxlbmNpb3NvKQogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90IChNb3N0cmFyLUluZm9Nb2R1bG8gIkgiKSkgeyByZXR1cm4gQCgpIH0KCiAgICBDbGVhci1Ib3N0CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgIFsgSCBdICBQVUVSVE9TIFBFTElHUk9TT1MgRU4gSU5URVJORVQgKFdBTikiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICBXcml0ZS1Ib3N0ICIgICQoIi0iICogNjApIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICJgbiAgT2J0ZW5pZW5kbyBJUCBwdWJsaWNhLi4uIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgJElQUCA9ICRudWxsCiAgICBmb3JlYWNoICgkU3J2IGluIEAoImh0dHBzOi8vYXBpLmlwaWZ5Lm9yZyIsImh0dHBzOi8vYXBpLm15LWlwLmlvL2lwIiwiaHR0cHM6Ly9pZmNvbmZpZy5tZS9pcCIpKSB7CiAgICAgICAgdHJ5IHsgJElQUCA9IChJbnZva2UtUmVzdE1ldGhvZCAtVXJpICRTcnYgLVRpbWVvdXRTZWMgNSAtRXJyb3JBY3Rpb24gU3RvcCkuVHJpbSgpCiAgICAgICAgICAgICAgaWYgKCRJUFAgLW1hdGNoICdeXGR7MSwzfShcLlxkezEsM30pezN9JCcpIHsgYnJlYWsgfSBlbHNlIHsgJElQUCA9ICRudWxsIH0KICAgICAgICB9IGNhdGNoIHsgJElQUCA9ICRudWxsIH0KICAgIH0KCiAgICBpZiAoLW5vdCAkSVBQKSB7IFdyaXRlLUhvc3QgIiAgTm8gc2UgcHVkbyBvYnRlbmVyIGxhIElQIHB1YmxpY2EuIiAtRm9yZWdyb3VuZENvbG9yIFJlZDsgRXNwZXJhci1FbnRlciAtU2lsZW5jaW9zbzokU2lsZW5jaW9zbzsgcmV0dXJuIEAoKSB9CgogICAgV3JpdGUtSG9zdCAiICBJUCBQdWJsaWNhOiAkSVBQIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICBXcml0ZS1Ib3N0ICJgbiAgRXNjYW5lYW5kbyBwdWVydG9zIGNyaXRpY29zIGRlc2RlIEludGVybmV0Li4uYG4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKCiAgICAkUHVlcnRvcyA9IEAoCiAgICAgICAgQHsgUCA9IDIxOyAgIE4gPSAiRlRQIjsgICAgICBSID0gIkNSSVRJQ08iIH0KICAgICAgICBAeyBQID0gMjI7ICAgTiA9ICJTU0giOyAgICAgIFIgPSAiQUxUTyIgICAgfQogICAgICAgIEB7IFAgPSAyMzsgICBOID0gIlRlbG5ldCI7ICAgUiA9ICJDUklUSUNPIiB9CiAgICAgICAgQHsgUCA9IDgwOyAgIE4gPSAiSFRUUCI7ICAgICBSID0gIk1FRElPIiAgIH0KICAgICAgICBAeyBQID0gNDQzOyAgTiA9ICJIVFRQUyI7ICAgIFIgPSAiQkFKTyIgICAgfQogICAgICAgIEB7IFAgPSAzMzg5OyBOID0gIlJEUCI7ICAgICAgUiA9ICJDUklUSUNPIiB9CiAgICAgICAgQHsgUCA9IDgwODA7IE4gPSAiSFRUUC1BbHQiOyBSID0gIk1FRElPIiAgIH0KICAgICkKCiAgICAkTG9nICAgICA9IEAoIj09PSBQVUVSVE9TIFdBTiA9PT0gJChHZXQtRGF0ZSkiLCAiSVAgUHVibGljYTogJElQUCIsICIiKQogICAgJEFsZXJ0YXMgPSBAKCkKCiAgICBmb3JlYWNoICgkRSBpbiAkUHVlcnRvcykgewogICAgICAgICRPayA9IFRlc3QtUHVlcnRvIC1EZXN0aW5vICRJUFAgLVB1ZXJ0byAkRS5QIC1UaW1lb3V0TXMgMjAwMAogICAgICAgIGlmICgkT2spIHsKICAgICAgICAgICAgJEMgPSBzd2l0Y2ggKCRFLlIpIHsgIkNSSVRJQ08iIHsgIlJlZCIgfSAiQUxUTyIgeyAiWWVsbG93IiB9IGRlZmF1bHQgeyAiRGFya1llbGxvdyIgfSB9CiAgICAgICAgICAgIFdyaXRlLUhvc3QgKCIgIFtFWFBVRVNUT10gIFB1ZXJ0byB7MCwtNX0gKHsxLC0xMH0pIFJJRVNHTyB7Mn0iIC1mICRFLlAsICRFLk4sICRFLlIpIC1Gb3JlZ3JvdW5kQ29sb3IgJEMKICAgICAgICAgICAgJExvZyArPSAiICBbRVhQVUVTVE9dICBQdWVydG8gJCgkRS5QKSAoJCgkRS5OKSkgWyQoJEUuUildIgogICAgICAgICAgICAkQWxlcnRhcyArPSAkRS5QCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAoIiAgW09LXSAgICAgICAgUHVlcnRvIHswLC01fSAoezEsLTEwfSkgY2VycmFkby9maWx0cmFkbyIgLWYgJEUuUCwgJEUuTikgLUZvcmVncm91bmRDb2xvciBEYXJrR3JlZW4KICAgICAgICAgICAgJExvZyArPSAiICBbT0tdICAgICAgICBQdWVydG8gJCgkRS5QKSAoJCgkRS5OKSkiCiAgICAgICAgfQogICAgfQoKICAgIFdyaXRlLUhvc3QgIiIKICAgIGlmICgkQWxlcnRhcy5Db3VudCAtZ3QgMCkgewogICAgICAgIFdyaXRlLUhvc3QgIiAgQUNDSU9OIFJFQ09NRU5EQURBOiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgUGFuZWwgZGVsIHJvdXRlciAobW9kdWxvIEMpIC0+IEFkbWluaXN0cmFjaW9uIHJlbW90YSAtPiBkZXNhY3RpdmFyLiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgTyBlbiBQb3J0IEZvcndhcmRpbmc6IGVsaW1pbmFyIGxhcyByZWdsYXMgZGUgbG9zIHB1ZXJ0b3MgbWFyY2Fkb3MuIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgfSBlbHNlIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgIFNpbiBwdWVydG9zIGNyaXRpY29zIGV4cHVlc3Rvcy4gUm91dGVyIGJpZW4gY29uZmlndXJhZG8uIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICB9CgogICAgJHNjcmlwdDpIaXN0b3JpYWxTZXNpb24uQWRkKCJbSF0gV0FOICRJUFAgfCBFeHB1ZXN0b3M6ICQoaWYgKCRBbGVydGFzLkNvdW50KSB7ICRBbGVydGFzIC1qb2luICcsJyB9IGVsc2UgeyAnTmluZ3VubycgfSkiKQoKICAgIGlmICgtbm90ICRTaWxlbmNpb3NvIC1hbmQgLW5vdCAkc2NyaXB0Ok1vZG9BdXRvKSB7CiAgICAgICAgJEV4cCA9IFJlYWQtSG9zdCAiYG4gIEV4cG9ydGFyIGluZm9ybWUgYSBUWFQ/IChTL04pIgogICAgICAgIGlmICgkRXhwLlRvVXBwZXIoKSAtZXEgIlMiKSB7IEV4cG9ydGFyLUluZm9ybWUgLUNvbnRlbmlkbyAkTG9nIC1Ob21icmVNb2R1bG8gIldBTiIgfCBPdXQtTnVsbCB9CiAgICB9CgogICAgRXNwZXJhci1FbnRlciAtU2lsZW5jaW9zbzokU2lsZW5jaW9zbwogICAgcmV0dXJuICRMb2cKfQoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIE1PRFVMTyBKIC0gRkFCUklDQU5URVMgUE9SIE1BQyAoT1VJKQojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KZnVuY3Rpb24gTW9kdWxvLUZhYnJpY2FudGVzIHsKICAgIHBhcmFtKFtzd2l0Y2hdJFNpbGVuY2lvc28pCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgKE1vc3RyYXItSW5mb01vZHVsbyAiSiIpKSB7IHJldHVybiB9CgogICAgQ2xlYXItSG9zdAogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICBbIEogXSAgSURFTlRJRklDQUNJT04gREUgRkFCUklDQU5URVMgUE9SIE1BQyIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiICAkKCItIiAqIDYwKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgICRSSSA9IE9idGVuZXItUm91dGVyCiAgICBpZiAoLW5vdCAkUkkpIHsgV3JpdGUtSG9zdCAiYG4gIE5vIHNlIHB1ZG8gZGV0ZWN0YXIgZWwgcm91dGVyLiIgLUZvcmVncm91bmRDb2xvciBSZWQ7IEVzcGVyYXItRW50ZXIgLVNpbGVuY2lvc286JFNpbGVuY2lvc287IHJldHVybiB9CiAgICAkR1cgID0gJFJJLkdhdGV3YXkKICAgICRTdWIgPSBPYnRlbmVyLVN1YnJlZEJhc2UgLUdhdGV3YXkgJEdXIC1JbnRlcmZhY2VJbmRleCAkUkkuSW50ZXJmYWNlSW5kZXgKCiAgICBXcml0ZS1Ib3N0ICJgbiAgRXNjYW5lYW5kbyAke1N1Yn0uMSAtICR7U3VifS4yNTQgKHRhYmxhIE9VSSBsb2NhbCwgc2luIEludGVybmV0KS4uLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiIgoKICAgICRQaW5nICAgID0gTmV3LU9iamVjdCBTeXN0ZW0uTmV0Lk5ldHdvcmtJbmZvcm1hdGlvbi5QaW5nCiAgICAkR3J1cG9zICA9IEB7fSAgICMgRmFicmljYW50ZSAtPiBMaXN0YSBkZSBJUHMKICAgICRMb2cgICAgID0gQCgiPT09IEZBQlJJQ0FOVEVTIFBPUiBNQUMgPT09ICQoR2V0LURhdGUpIiwgIlN1YnJlZDogJHtTdWJ9LngiLCAiIikKCiAgICBmb3IgKCRpID0gMTsgJGkgLWxlIDI1NDsgJGkrKykgewogICAgICAgICRJUCA9ICIkU3ViLiRpIgogICAgICAgIHRyeSB7CiAgICAgICAgICAgIGlmICgkUGluZy5TZW5kKCRJUCwgMTUwKS5TdGF0dXMgLWVxICdTdWNjZXNzJykgewogICAgICAgICAgICAgICAgJG51bGwgPSBhcnAgLWEgMj4kbnVsbDsgU3RhcnQtU2xlZXAgLU1pbGxpc2Vjb25kcyA4MAogICAgICAgICAgICAgICAgJE1BQyA9IEdldC1NQUNEZXNkZUFSUCAtSVAgJElQCiAgICAgICAgICAgICAgICAkRmFiID0gR2V0LUZhYnJpY2FudGUgIC1NQUMgJE1BQwogICAgICAgICAgICAgICAgJFRhZyA9IGlmICgkSVAgLWVxICRHVykgeyAiIFtST1VURVJdIiB9IGVsc2UgeyAiIiB9CgogICAgICAgICAgICAgICAgaWYgKC1ub3QgJEdydXBvcy5Db250YWluc0tleSgkRmFiKSkgeyAkR3J1cG9zWyRGYWJdID0gW1N5c3RlbS5Db2xsZWN0aW9ucy5HZW5lcmljLkxpc3Rbc3RyaW5nXV06Om5ldygpIH0KICAgICAgICAgICAgICAgICRHcnVwb3NbJEZhYl0uQWRkKCIkSVAgIHwgICRNQUMkVGFnIikKICAgICAgICAgICAgfQogICAgICAgIH0gY2F0Y2ggeyB9CiAgICB9CgogICAgV3JpdGUtSG9zdCAiICAkKCItIiAqIDYwKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiICBSRVNVTFRBRE9TIEFHUlVQQURPUyBQT1IgRkFCUklDQU5URWBuIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KCiAgICAkVG90YWwgPSAwCiAgICBmb3JlYWNoICgkRmFiIGluICgkR3J1cG9zLktleXMgfCBTb3J0LU9iamVjdCkpIHsKICAgICAgICAkQWxlcnRhID0gJEZhYiAtbWF0Y2ggIlZNd2FyZXxWaXJ0dWFsQm94fFFFTVV8UmFzcGJlcnJ5IFBpfFViaXF1aXRpIgogICAgICAgICRDID0gaWYgKCRGYWIgLWVxICJEZXNjb25vY2lkbyIpIHsgIkRhcmtHcmF5IiB9IGVsc2VpZiAoJEFsZXJ0YSkgeyAiWWVsbG93IiB9IGVsc2UgeyAiV2hpdGUiIH0KICAgICAgICBXcml0ZS1Ib3N0ICIgICRGYWIgKCQoJEdydXBvc1skRmFiXS5Db3VudCkgZGlzcG9zaXRpdm8ocykpIiAtRm9yZWdyb3VuZENvbG9yICRDCiAgICAgICAgJExvZyArPSAiICAkRmFiICgkKCRHcnVwb3NbJEZhYl0uQ291bnQpKToiCiAgICAgICAgZm9yZWFjaCAoJEwgaW4gJEdydXBvc1skRmFiXSkgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgLT4gJEwiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgJExvZyArPSAiICAgIC0+ICRMIgogICAgICAgICAgICAkVG90YWwrKwogICAgICAgIH0KICAgICAgICBpZiAoJEFsZXJ0YSkgeyBXcml0ZS1Ib3N0ICIgICAgTk9UQTogRmFicmljYW50ZSBpbnVzdWFsIGVuIHJlZCBkb21lc3RpY2EuIFZlcmlmaWNhci4iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93IH0KICAgICAgICAkTG9nICs9ICIiCiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgfQoKICAgIFdyaXRlLUhvc3QgIiAgVG90YWw6ICRUb3RhbCBkaXNwb3NpdGl2b3MgZW5jb250cmFkb3MuIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgJHNjcmlwdDpIaXN0b3JpYWxTZXNpb24uQWRkKCJbSl0gRmFicmljYW50ZXMgJHtTdWJ9LnggfCAkVG90YWwgZGlzcG9zaXRpdm9zIHwgJCgkR3J1cG9zLkNvdW50KSBmYWJyaWNhbnRlcyIpCgogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90ICRzY3JpcHQ6TW9kb0F1dG8pIHsKICAgICAgICAkRXhwID0gUmVhZC1Ib3N0ICJgbiAgRXhwb3J0YXIgaW5mb3JtZSBhIFRYVD8gKFMvTikiCiAgICAgICAgaWYgKCRFeHAuVG9VcHBlcigpIC1lcSAiUyIpIHsgRXhwb3J0YXItSW5mb3JtZSAtQ29udGVuaWRvICRMb2cgLU5vbWJyZU1vZHVsbyAiRmFicmljYW50ZXMiIHwgT3V0LU51bGwgfQogICAgfQoKICAgIEVzcGVyYXItRW50ZXIgLVNpbGVuY2lvc286JFNpbGVuY2lvc28KfQoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIE1PRFVMTyBMIC0gVkVSU0lPTiBERSBGSVJNV0FSRSBERUwgUk9VVEVSCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpmdW5jdGlvbiBNb2R1bG8tRmlybXdhcmUgewogICAgcGFyYW0oW3N3aXRjaF0kU2lsZW5jaW9zbykKICAgIGlmICgtbm90ICRTaWxlbmNpb3NvIC1hbmQgLW5vdCAoTW9zdHJhci1JbmZvTW9kdWxvICJMIikpIHsgcmV0dXJuIH0KCiAgICBDbGVhci1Ib3N0CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgIFsgTCBdICBERVRFQ0NJT04gREUgRklSTVdBUkUgREVMIFJPVVRFUiIgLUZvcmVncm91bmRDb2xvciBEYXJrWWVsbG93CiAgICBXcml0ZS1Ib3N0ICIgICQoIi0iICogNjApIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgJFJJID0gT2J0ZW5lci1Sb3V0ZXIKICAgIGlmICgtbm90ICRSSSkgeyBXcml0ZS1Ib3N0ICJgbiAgTm8gc2UgcHVkbyBkZXRlY3RhciBlbCByb3V0ZXIuIiAtRm9yZWdyb3VuZENvbG9yIFJlZDsgRXNwZXJhci1FbnRlciAtU2lsZW5jaW9zbzokU2lsZW5jaW9zbzsgcmV0dXJuIH0KICAgICRHVyA9ICRSSS5HYXRld2F5CgogICAgV3JpdGUtSG9zdCAiYG4gIFByb2JhbmRvIHJ1dGFzIGNvbm9jaWRhcyBlbiAkR1cuLi5gbiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgICMgUnV0YXMgY29ub2NpZGFzIHBvciBmYWJyaWNhbnRlIChhY2Nlc2libGVzIHNpbiBhdXRlbnRpY2FjaW9uIGVuIG11Y2hvcyBtb2RlbG9zKQogICAgJFJ1dGFzID0gQCgKICAgICAgICBAeyBVUkwgPSAiaHR0cDovLyRHVy9oZWxwL2Fib3V0aW5mby5odG0iOyAgICAgICBNYXJjYSA9ICJUUC1MaW5rIChjbGFzaWNvKSIgIH0KICAgICAgICBAeyBVUkwgPSAiaHR0cDovLyRHVy91c2VyUnBtL0Fib3V0UnBtLmh0bSI7ICAgICBNYXJjYSA9ICJUUC1MaW5rIChhbHQpIiAgICAgIH0KICAgICAgICBAeyBVUkwgPSAiaHR0cDovLyRHVy9jZ2ktYmluL3N0YXR1cyI7ICAgICAgICAgICBNYXJjYSA9ICJUUC1MaW5rIChjZ2kpIiAgICAgIH0KICAgICAgICBAeyBVUkwgPSAiaHR0cDovLyRHVy9hYm91dC5odG1sIjsgICAgICAgICAgICAgICBNYXJjYSA9ICJELUxpbmsiICAgICAgICAgICAgIH0KICAgICAgICBAeyBVUkwgPSAiaHR0cDovLyRHVy9pbmZvLmh0bWwiOyAgICAgICAgICAgICAgICBNYXJjYSA9ICJELUxpbmsgKGFsdCkiICAgICAgIH0KICAgICAgICBAeyBVUkwgPSAiaHR0cDovLyRHVy9NYWluX0FuYWx5c2lzX0NvbnRlbnQuYXNwIjtNYXJjYSA9ICJBU1VTIiAgICAgICAgICAgICAgIH0KICAgICAgICBAeyBVUkwgPSAiaHR0cHM6Ly8kR1cvYXBwR2V0LmNnaT9ob29rPWdldF9zeXN0ZW1faW5mbygpIjsgTWFyY2EgPSAiQVNVUyAoSFRUUFMpIiB9CiAgICAgICAgQHsgVVJMID0gImh0dHA6Ly8kR1cvc3RhdHVzSW5mby5odG1sIjsgICAgICAgICAgTWFyY2EgPSAiSHVhd2VpL01vdmlzdGFyIiAgICB9CiAgICAgICAgQHsgVVJMID0gImh0dHA6Ly8kR1cvaHRtbC9zdGF0dXMuaHRtbCI7ICAgICAgICAgTWFyY2EgPSAiSHVhd2VpIChhbHQpIiAgICAgICB9CiAgICAgICAgQHsgVVJMID0gImh0dHA6Ly8kR1cvZmlybXdhcmUuaHRtbCI7ICAgICAgICAgICAgTWFyY2EgPSAiR2VuZXJpY28iICAgICAgICAgICB9CiAgICAgICAgQHsgVVJMID0gImh0dHA6Ly8kR1cvc3RhdHVzLmh0bWwiOyAgICAgICAgICAgICAgTWFyY2EgPSAiR2VuZXJpY28gKGFsdCkiICAgICB9CiAgICApCgogICAgJEVuY29udHJhZGEgPSAkZmFsc2UKICAgICRMb2cgPSBAKCI9PT0gRklSTVdBUkUgREVMIFJPVVRFUiA9PT0gJChHZXQtRGF0ZSkiLCAiR2F0ZXdheTogJEdXIiwgIiIpCgogICAgZm9yZWFjaCAoJFIgaW4gJFJ1dGFzKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiICBQcm9iYW5kbzogJCgkUi5NYXJjYSkuLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkgLU5vTmV3bGluZQogICAgICAgIHRyeSB7CiAgICAgICAgICAgICRSZXNwID0gSW52b2tlLVdlYlJlcXVlc3QgLVVyaSAkUi5VUkwgLVRpbWVvdXRTZWMgMyAtVXNlQmFzaWNQYXJzaW5nIGAKICAgICAgICAgICAgICAgICAgICAtRXJyb3JBY3Rpb24gU3RvcCAtV2FybmluZ0FjdGlvbiBTaWxlbnRseUNvbnRpbnVlCiAgICAgICAgICAgICRIVE1MID0gJFJlc3AuQ29udGVudAoKICAgICAgICAgICAgIyBQYXRyb25lcyBkZSB2ZXJzaW9uIGVuIGVsIEhUTUwKICAgICAgICAgICAgJFZlcnNpb24gPSAkbnVsbAogICAgICAgICAgICAkUGF0cm9uZXMgPSBAKAogICAgICAgICAgICAgICAgJ0Zpcm13YXJlW148Ol0qKD86VmVyc2lvbik/W148Ol0qOltePCJdKj8oW1xkXStcLltcZF0rW1xkXC5dKiknLAogICAgICAgICAgICAgICAgJ1NvZnR3YXJlIFZlcnNpb25bXjxdKj8oWzAtOV0rXC5bMC05XStbMC05QS1aYS16XC5fLV0qKScsCiAgICAgICAgICAgICAgICAnRlcgVmVyc2lvbltePF0qPyhbMC05XStcLlswLTldK1swLTlBLVphLXpcLl8tXSopJywKICAgICAgICAgICAgICAgICdIVyBWZXJzaW9uW148XSo/KFswLTldK1wuWzAtOV0rWzAtOUEtWmEtelwuXy1dKiknLAogICAgICAgICAgICAgICAgJ1ZlcnNpb25bXjwiXSo/KFswLTldK1wuWzAtOV0rXC5bMC05XStbMC05QS1aYS16XC5fLV0qKScsCiAgICAgICAgICAgICAgICAnImZpcm13YXJlIlteIl0qIihbXiJdKykiJywKICAgICAgICAgICAgICAgICdmaXJtd2FyZVZlcnNpb25bXiJdKiIoW14iXSspIicKICAgICAgICAgICAgKQoKICAgICAgICAgICAgZm9yZWFjaCAoJFBhdCBpbiAkUGF0cm9uZXMpIHsKICAgICAgICAgICAgICAgIGlmICgkSFRNTCAtbWF0Y2ggJFBhdCkgewogICAgICAgICAgICAgICAgICAgICRWZXJzaW9uID0gJE1hdGNoZXNbMV0uVHJpbSgpCiAgICAgICAgICAgICAgICAgICAgYnJlYWsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQoKICAgICAgICAgICAgaWYgKCRWZXJzaW9uKSB7CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIEVOQ09OVFJBRE8iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgTWFyY2EvTW9kZWxvIGRldGVjdGFkbyA6ICQoJFIuTWFyY2EpIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIFZlcnNpb24gZmlybXdhcmUgICAgICAgOiAkVmVyc2lvbiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgVVJMIGZ1ZW50ZSAgICAgICAgICAgICA6ICQoJFIuVVJMKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBSRUNPTUVOREFDSU9OOiBDb21wYXJhIGVzdGEgdmVyc2lvbiBjb24gbGEgZGlzcG9uaWJsZSBlbiBsYSB3ZWIiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBkZWwgZmFicmljYW50ZS4gU2kgdGllbmUgbWFzIGRlIDEgYW5vLCBjb25zaWRlcmEgYWN0dWFsaXphcmxhLiIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgICAgICAgICAkTG9nICs9ICIgIE1hcmNhICAgOiAkKCRSLk1hcmNhKSIKICAgICAgICAgICAgICAgICRMb2cgKz0gIiAgVmVyc2lvbiA6ICRWZXJzaW9uIgogICAgICAgICAgICAgICAgJExvZyArPSAiICBVUkwgICAgIDogJCgkUi5VUkwpIgogICAgICAgICAgICAgICAgJEVuY29udHJhZGEgPSAkdHJ1ZQogICAgICAgICAgICAgICAgYnJlYWsKICAgICAgICAgICAgfSBlbHNlaWYgKCRSZXNwLlN0YXR1c0NvZGUgLWVxIDIwMCkgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICByZXNwb25kZSAoc2luIHZlcnNpb24gcGFyc2VhYmxlKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBzaW4gYWNjZXNvIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgICAgIH0KICAgICAgICB9IGNhdGNoIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBzaW4gYWNjZXNvIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgfQogICAgfQoKICAgIGlmICgtbm90ICRFbmNvbnRyYWRhKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgTm8gc2UgZW5jb250cm8gbGEgdmVyc2lvbiBkZSBmaXJtd2FyZSBkZSBmb3JtYSBhdXRvbWF0aWNhLiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICBXcml0ZS1Ib3N0ICIgIE9wY2lvbmVzIG1hbnVhbGVzOiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIFdyaXRlLUhvc3QgIiAgICAxLiBVc2EgZWwgbW9kdWxvIEMgcGFyYSBhY2NlZGVyIGFsIHBhbmVsIGRlbCByb3V0ZXIuIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgMi4gQnVzY2EgbGEgdmVyc2lvbiBlbjogQWRtaW5pc3RyYWNpb24gPiBBY3R1YWxpemFjaW9uIGRlIGZpcm13YXJlLiIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICAgICAgV3JpdGUtSG9zdCAiICAgIDMuIFJldmlzYSBsYSBldGlxdWV0YSBmaXNpY2EgZW4gbGEgcGFydGUgaW5mZXJpb3IgZGVsIHJvdXRlci4iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JheQogICAgICAgICRMb2cgKz0gIiAgUmVzdWx0YWRvOiBObyBlbmNvbnRyYWRvIGRlIGZvcm1hIGF1dG9tYXRpY2EuIgogICAgfQoKICAgICRzY3JpcHQ6SGlzdG9yaWFsU2VzaW9uLkFkZCgiW0xdIEZpcm13YXJlICRHVyB8ICQoaWYgKCRFbmNvbnRyYWRhKSB7ICdFbmNvbnRyYWRvJyB9IGVsc2UgeyAnTm8gZW5jb250cmFkbycgfSkiKQoKICAgIGlmICgtbm90ICRTaWxlbmNpb3NvIC1hbmQgLW5vdCAkc2NyaXB0Ok1vZG9BdXRvKSB7CiAgICAgICAgJEV4cCA9IFJlYWQtSG9zdCAiYG4gIEV4cG9ydGFyIGluZm9ybWUgYSBUWFQ/IChTL04pIgogICAgICAgIGlmICgkRXhwLlRvVXBwZXIoKSAtZXEgIlMiKSB7IEV4cG9ydGFyLUluZm9ybWUgLUNvbnRlbmlkbyAkTG9nIC1Ob21icmVNb2R1bG8gIkZpcm13YXJlIiB8IE91dC1OdWxsIH0KICAgIH0KCiAgICBFc3BlcmFyLUVudGVyIC1TaWxlbmNpb3NvOiRTaWxlbmNpb3NvCn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojICBNT0RVTE8gTSAtIElORk9STUUgQ09NUExFVE8gQVVUT01BVElDTwojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KZnVuY3Rpb24gTW9kdWxvLUluZm9ybWVDb21wbGV0byB7CiAgICBwYXJhbShbc3dpdGNoXSRTaWxlbmNpb3NvKQogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90ICRzY3JpcHQ6TW9kb0F1dG8gLWFuZCAtbm90IChNb3N0cmFyLUluZm9Nb2R1bG8gIk0iKSkgeyByZXR1cm4gfQoKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgWyBNIF0gIElORk9STUUgQ09NUExFVE8gQVVUT01BVElDTyIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgV3JpdGUtSG9zdCAiICAkKCItIiAqIDYwKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiYG4gIEVqZWN1dGFuZG8gbW9kdWxvcyBBLCBFLCBGIHkgRCBlbiBzZWN1ZW5jaWEuLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiAgTm8gY2VycmFyIGVzdGEgdmVudGFuYS4gVGFyZGFyYSBlbnRyZSAyIHkgNSBtaW51dG9zLmBuIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwoKICAgICRMb2dUb3RhbCA9IEAoCiAgICAgICAgIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iCiAgICAgICAgIiAgSU5GT1JNRSBDT01QTEVUTyAtIEF0bGFzIFBDIFN1cHBvcnQgIHYzLjAiCiAgICAgICAgIiAgRmVjaGE6ICQoR2V0LURhdGUpIgogICAgICAgICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IgogICAgICAgICIiCiAgICApCgogICAgV3JpdGUtSG9zdCAiICBbMS80XSAgQXVkaXRvcmlhIGRlIFB1ZXJ0b3MuLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgJExBID0gTW9kdWxvLUF1ZGl0b3JpYSAtU2lsZW5jaW9zbwogICAgJExvZ1RvdGFsICs9IEAoIiIsICItLS0gWyBBIF0gQVVESVRPUklBIERFIFBVRVJUT1MgLS0tIikgKyAkTEEKCiAgICBXcml0ZS1Ib3N0ICJgbiAgWzIvNF0gIEluZm8gZGVsIEFkYXB0YWRvci4uLiIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAkTEUgPSBNb2R1bG8tSW5mb0FkYXB0YWRvciAtU2lsZW5jaW9zbwogICAgJExvZ1RvdGFsICs9IEAoIiIsICItLS0gWyBFIF0gSU5GTyBERUwgQURBUFRBRE9SIC0tLSIpICsgJExFCgogICAgV3JpdGUtSG9zdCAiYG4gIFszLzRdICBUZXN0IEROUy4uLiIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAkTEYgPSBNb2R1bG8tVGVzdEROUyAtU2lsZW5jaW9zbwogICAgJExvZ1RvdGFsICs9IEAoIiIsICItLS0gWyBGIF0gVEVTVCBETlMgLS0tIikgKyAkTEYKCiAgICBXcml0ZS1Ib3N0ICJgbiAgWzQvNF0gIERpYWdub3N0aWNvIGRlIExhdGVuY2lhLi4uIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgICRMRCA9IE1vZHVsby1MYXRlbmNpYSAtU2lsZW5jaW9zbwogICAgJExvZ1RvdGFsICs9IEAoIiIsICItLS0gWyBEIF0gTEFURU5DSUEgLS0tIikgKyAkTEQKCiAgICAkTG9nVG90YWwgKz0gQCgiIiwgIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iLCAiICBGaW4gZGVsIGluZm9ybWUiLCAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIpCgogICAgV3JpdGUtSG9zdCAiIgogICAgJEFyY2hpdm8gPSBFeHBvcnRhci1JbmZvcm1lIC1Db250ZW5pZG8gJExvZ1RvdGFsIC1Ob21icmVNb2R1bG8gIkluZm9ybWVDb21wbGV0byIKCiAgICAkc2NyaXB0Okhpc3RvcmlhbFNlc2lvbi5BZGQoIltNXSBJbmZvcm1lIGNvbXBsZXRvIGdlbmVyYWRvOiAkQXJjaGl2byIpCiAgICBXcml0ZS1Ib3N0ICJgbiAgSW5mb3JtZSBjb21wbGV0byBsaXN0by4iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KCiAgICBFc3BlcmFyLUVudGVyIC1TaWxlbmNpb3NvOiRTaWxlbmNpb3NvCn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojICBNT0RVTE8gTiAtIENPTVBBUkFUSVZBIERFIERJU1BPU0lUSVZPUwojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KZnVuY3Rpb24gTW9kdWxvLUNvbXBhcmF0aXZhIHsKICAgIHBhcmFtKFtzd2l0Y2hdJFNpbGVuY2lvc28pCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgKE1vc3RyYXItSW5mb01vZHVsbyAiTiIpKSB7IHJldHVybiB9CgogICAgQ2xlYXItSG9zdAogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICBbIE4gXSAgQ09NUEFSQVRJVkEgREUgRElTUE9TSVRJVk9TIiAtRm9yZWdyb3VuZENvbG9yIE1hZ2VudGEKICAgIFdyaXRlLUhvc3QgIiAgJCgiLSIgKiA2MCkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKCiAgICAjIENhcmdhciBlc3RhZG8gcHJldmlvCiAgICAkUHJldmlvID0gQHt9CiAgICBpZiAoVGVzdC1QYXRoICRzY3JpcHQ6QXJjaGl2b0VzdGFkbykgewogICAgICAgICRGZWNoYU1vZCA9IChHZXQtSXRlbSAkc2NyaXB0OkFyY2hpdm9Fc3RhZG8pLkxhc3RXcml0ZVRpbWUKICAgICAgICBXcml0ZS1Ib3N0ICJgbiAgRXN0YWRvIHByZXZpbyBlbmNvbnRyYWRvOiAkRmVjaGFNb2QiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICBmb3JlYWNoICgkTCBpbiAoR2V0LUNvbnRlbnQgJHNjcmlwdDpBcmNoaXZvRXN0YWRvKSkgewogICAgICAgICAgICAkUCA9ICRMIC1zcGxpdCAnXHwnCiAgICAgICAgICAgIGlmICgkUC5Db3VudCAtZ2UgMikgeyAkUHJldmlvWyRQWzBdXSA9IEB7IE1BQyA9ICRQWzFdOyBIb3N0ID0gaWYgKCRQLkNvdW50IC1nZSAzKSB7ICRQWzJdIH0gZWxzZSB7ICJPY3VsdG8iIH0gfSB9CiAgICAgICAgfQogICAgICAgIFdyaXRlLUhvc3QgIiAgRGlzcG9zaXRpdm9zIGVuIGVzdGFkbyBwcmV2aW86ICQoJFByZXZpby5Db3VudCkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIH0gZWxzZSB7CiAgICAgICAgV3JpdGUtSG9zdCAiYG4gIE5vIGhheSBlc3RhZG8gcHJldmlvIGd1YXJkYWRvLiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICBXcml0ZS1Ib3N0ICIgIEVqZWN1dGEgZWwgbW9kdWxvIEIgcHJpbWVybyBwYXJhIGd1YXJkYXIgdW5hIGxpbmVhIGJhc2UuIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgIEVzcGVyYXItRW50ZXIgLVNpbGVuY2lvc286JFNpbGVuY2lvc287IHJldHVybgogICAgfQoKICAgIFdyaXRlLUhvc3QgImBuICBFc2NhbmVhbmRvIGxhIHJlZCBhY3R1YWwuLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICRSSSA9IE9idGVuZXItUm91dGVyCiAgICBpZiAoLW5vdCAkUkkpIHsgV3JpdGUtSG9zdCAiICBObyBzZSBwdWRvIGRldGVjdGFyIGVsIHJvdXRlci4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkOyBFc3BlcmFyLUVudGVyIC1TaWxlbmNpb3NvOiRTaWxlbmNpb3NvOyByZXR1cm4gfQogICAgJFN1YiAgPSBPYnRlbmVyLVN1YnJlZEJhc2UgLUdhdGV3YXkgJFJJLkdhdGV3YXkgLUludGVyZmFjZUluZGV4ICRSSS5JbnRlcmZhY2VJbmRleAogICAgJFBpbmcgPSBOZXctT2JqZWN0IFN5c3RlbS5OZXQuTmV0d29ya0luZm9ybWF0aW9uLlBpbmcKCiAgICAkQWN0dWFsID0gQHt9CiAgICBmb3IgKCRpID0gMTsgJGkgLWxlIDI1NDsgJGkrKykgewogICAgICAgICRJUCA9ICIkU3ViLiRpIgogICAgICAgIHRyeSB7CiAgICAgICAgICAgIGlmICgkUGluZy5TZW5kKCRJUCwgMTUwKS5TdGF0dXMgLWVxICdTdWNjZXNzJykgewogICAgICAgICAgICAgICAgJG51bGwgPSBhcnAgLWEgMj4kbnVsbDsgU3RhcnQtU2xlZXAgLU1pbGxpc2Vjb25kcyA2MAogICAgICAgICAgICAgICAgJE1BQyAgICA9IEdldC1NQUNEZXNkZUFSUCAtSVAgJElQCiAgICAgICAgICAgICAgICAkSG9zdE4gID0gIk9jdWx0byIKICAgICAgICAgICAgICAgIHRyeSB7ICRIID0gW1N5c3RlbS5OZXQuRG5zXTo6R2V0SG9zdEVudHJ5KCRJUCk7IGlmICgkSC5Ib3N0TmFtZSkgeyAkSG9zdE4gPSAkSC5Ib3N0TmFtZSB9IH0gY2F0Y2ggeyB9CiAgICAgICAgICAgICAgICAkQWN0dWFsWyRJUF0gPSBAeyBNQUMgPSAkTUFDOyBIb3N0ID0gJEhvc3ROIH0KICAgICAgICAgICAgfQogICAgICAgIH0gY2F0Y2ggeyB9CiAgICB9CgogICAgV3JpdGUtSG9zdCAiYG4gICQoIi0iICogNjApIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIgIFJFU1VMVEFETyBERSBMQSBDT01QQVJBVElWQWBuIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KCiAgICAkTG9nID0gQCgiPT09IENPTVBBUkFUSVZBIERFIERJU1BPU0lUSVZPUyA9PT0gJChHZXQtRGF0ZSkiLCAiU3VicmVkOiAke1N1Yn0ueCIsICIiKQoKICAgICMgRGlzcG9zaXRpdm9zIG51ZXZvcwogICAgJE51ZXZvcyA9ICRBY3R1YWwuS2V5cyB8IFdoZXJlLU9iamVjdCB7IC1ub3QgJFByZXZpby5Db250YWluc0tleSgkXykgfQogICAgaWYgKCROdWV2b3MpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgIERJU1BPU0lUSVZPUyBOVUVWT1MgKG5vIGVzdGFiYW4gZW4gZWwgZXNjYW5lbyBhbnRlcmlvcikiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgJExvZyArPSAiICBOVUVWT1M6IgogICAgICAgIGZvcmVhY2ggKCRJUCBpbiAoJE51ZXZvcyB8IFNvcnQtT2JqZWN0KSkgewogICAgICAgICAgICAkRmFiID0gR2V0LUZhYnJpY2FudGUgLU1BQyAkQWN0dWFsWyRJUF0uTUFDCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgWytdICRJUCAgfCAgJCgkQWN0dWFsWyRJUF0uTUFDKSAgfCAgJEZhYiAgfCAgJCgkQWN0dWFsWyRJUF0uSG9zdCkiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgJExvZyArPSAiICBbK10gJElQIHwgJCgkQWN0dWFsWyRJUF0uTUFDKSB8ICRGYWIgfCAkKCRBY3R1YWxbJElQXS5Ib3N0KSIKICAgICAgICB9CiAgICAgICAgJExvZyArPSAiIgogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgIH0KCiAgICAjIERpc3Bvc2l0aXZvcyBkZXNhcGFyZWNpZG9zCiAgICAkSWRvcyA9ICRQcmV2aW8uS2V5cyB8IFdoZXJlLU9iamVjdCB7IC1ub3QgJEFjdHVhbC5Db250YWluc0tleSgkXykgfQogICAgaWYgKCRJZG9zKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiICBESVNQT1NJVElWT1MgREVTQVBBUkVDSURPUyAoZXN0YWJhbiBhbnRlcywgeWEgbm8gcmVzcG9uZGVuKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICRMb2cgKz0gIiAgREVTQVBBUkVDSURPUzoiCiAgICAgICAgZm9yZWFjaCAoJElQIGluICgkSWRvcyB8IFNvcnQtT2JqZWN0KSkgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIFstXSAkSVAgIHwgICQoJFByZXZpb1skSVBdLk1BQykgIHwgICQoJFByZXZpb1skSVBdLkhvc3QpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgICAgICRMb2cgKz0gIiAgWy1dICRJUCB8ICQoJFByZXZpb1skSVBdLk1BQykgfCAkKCRQcmV2aW9bJElQXS5Ib3N0KSIKICAgICAgICB9CiAgICAgICAgJExvZyArPSAiIgogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgIH0KCiAgICAjIFNpbiBjYW1iaW9zCiAgICAkSWd1YWxlcyA9ICRBY3R1YWwuS2V5cyB8IFdoZXJlLU9iamVjdCB7ICRQcmV2aW8uQ29udGFpbnNLZXkoJF8pIH0KICAgIFdyaXRlLUhvc3QgIiAgU0lOIENBTUJJT1M6ICQoJElndWFsZXMuQ291bnQpIGRpc3Bvc2l0aXZvKHMpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAkTG9nICs9ICIgIFNJTiBDQU1CSU9TOiAkKCRJZ3VhbGVzLkNvdW50KSIKCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBpZiAoLW5vdCAkTnVldm9zIC1hbmQgLW5vdCAkSWRvcykgewogICAgICAgIFdyaXRlLUhvc3QgIiAgTGEgcmVkIG5vIGhhIGNhbWJpYWRvIGRlc2RlIGVsIHVsdGltbyBlc2NhbmVvLiIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgfQoKICAgICMgR3VhcmRhciBlbCBudWV2byBlc3RhZG8gY29tbyBlbCBhY3R1YWwKICAgIHRyeSB7CiAgICAgICAgKCRBY3R1YWwuS2V5cyB8IEZvckVhY2gtT2JqZWN0IHsgIiRffCQoJEFjdHVhbFskX10uTUFDKXwkKCRBY3R1YWxbJF9dLkhvc3QpIiB9KSB8CiAgICAgICAgT3V0LUZpbGUgJHNjcmlwdDpBcmNoaXZvRXN0YWRvIC1FbmNvZGluZyBVVEY4IC1Gb3JjZQogICAgfSBjYXRjaCB7IH0KCiAgICAkc2NyaXB0Okhpc3RvcmlhbFNlc2lvbi5BZGQoIltOXSBDb21wYXJhdGl2YSB8ICskKCROdWV2b3MuQ291bnQpIG51ZXZvcyB8IC0kKCRJZG9zLkNvdW50KSBkZXNhcGFyZWNpZG9zIikKCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgJHNjcmlwdDpNb2RvQXV0bykgewogICAgICAgICRFeHAgPSBSZWFkLUhvc3QgImBuICBFeHBvcnRhciBpbmZvcm1lIGEgVFhUPyAoUy9OKSIKICAgICAgICBpZiAoJEV4cC5Ub1VwcGVyKCkgLWVxICJTIikgeyBFeHBvcnRhci1JbmZvcm1lIC1Db250ZW5pZG8gJExvZyAtTm9tYnJlTW9kdWxvICJDb21wYXJhdGl2YSIgfCBPdXQtTnVsbCB9CiAgICB9CgogICAgRXNwZXJhci1FbnRlciAtU2lsZW5jaW9zbzokU2lsZW5jaW9zbwp9CgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyAgTU9EVUxPIFAgLSBURVNUIERFIFZFTE9DSURBRCBERSBERVNDQVJHQQojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KZnVuY3Rpb24gTW9kdWxvLVZlbG9jaWRhZCB7CiAgICBwYXJhbShbc3dpdGNoXSRTaWxlbmNpb3NvKQogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90IChNb3N0cmFyLUluZm9Nb2R1bG8gIlAiKSkgeyByZXR1cm4gfQoKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgWyBQIF0gIFRFU1QgREUgVkVMT0NJREFEIERFIERFU0NBUkdBIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgV3JpdGUtSG9zdCAiICAkKCItIiAqIDYwKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiIgoKICAgICRVUkxfNU1CICA9ICJodHRwczovL3NwZWVkLmNsb3VkZmxhcmUuY29tL19fZG93bj9ieXRlcz01MjQyODgwIgogICAgJFVSTF8xME1CID0gImh0dHBzOi8vc3BlZWQuY2xvdWRmbGFyZS5jb20vX19kb3duP2J5dGVzPTEwNDg1NzYwIgoKICAgICRSZXN1bHRhZG9zID0gQCgpCiAgICAkTG9nID0gQCgiPT09IFRFU1QgREUgVkVMT0NJREFEID09PSAkKEdldC1EYXRlKSIsICJTZXJ2aWRvcjogQ2xvdWRmbGFyZSBDRE4iLCAiIikKCiAgICBmb3JlYWNoICgkUHJ1ZWJhIGluIEAoQHsgVVJMID0gJFVSTF81TUI7IFRhbSA9IDUgfSwgQHsgVVJMID0gJFVSTF8xME1COyBUYW0gPSAxMCB9KSkgewogICAgICAgIFdyaXRlLUhvc3QgIiAgRGVzY2FyZ2FuZG8gJCgkUHJ1ZWJhLlRhbSkgTUIgZGVzZGUgQ2xvdWRmbGFyZS4uLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheSAtTm9OZXdsaW5lCiAgICAgICAgdHJ5IHsKICAgICAgICAgICAgJFQwICAgPSBHZXQtRGF0ZQogICAgICAgICAgICAkbnVsbCA9IEludm9rZS1XZWJSZXF1ZXN0IC1VcmkgJFBydWViYS5VUkwgLVVzZUJhc2ljUGFyc2luZyAtVGltZW91dFNlYyA2MCAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICAgICAkU2VjcyA9IChOZXctVGltZVNwYW4gLVN0YXJ0ICRUMCAtRW5kIChHZXQtRGF0ZSkpLlRvdGFsU2Vjb25kcwogICAgICAgICAgICAkTUJzICA9IFtNYXRoXTo6Um91bmQoJFBydWViYS5UYW0gLyAkU2VjcywgMikKICAgICAgICAgICAgJE1icHMgPSBbTWF0aF06OlJvdW5kKCRNQnMgKiA4LCAxKQoKICAgICAgICAgICAgJEMgPSBpZiAoJE1icHMgLWx0IDUpIHsgIlJlZCIgfSBlbHNlaWYgKCRNYnBzIC1sdCAyNSkgeyAiWWVsbG93IiB9IGVsc2UgeyAiR3JlZW4iIH0KICAgICAgICAgICAgV3JpdGUtSG9zdCAiIE9LIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgIFdyaXRlLUhvc3QgKCIgIFJlc3VsdGFkbyAoJCgkUHJ1ZWJhLlRhbSkgTUIpOiAgezAsN30gTUIvcyAgPSAgezEsOH0gTWJwcyAgKGVuIHsyOkYxfXMpIiAtZiAkTUJzLCAkTWJwcywgJFNlY3MpIC1Gb3JlZ3JvdW5kQ29sb3IgJEMKICAgICAgICAgICAgJExvZyAgICAgKz0gIiAgVGVzdCAkKCRQcnVlYmEuVGFtKSBNQiA6ICRNQnMgTUIvcyA9ICRNYnBzIE1icHMgZW4gJChbTWF0aF06OlJvdW5kKCRTZWNzLDEpKXMiCiAgICAgICAgICAgICRSZXN1bHRhZG9zICs9ICRNYnBzCiAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiBFUlJPUiIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBObyBzZSBwdWRvIGRlc2NhcmdhciBlbCBhcmNoaXZvLiBWZXJpZmljYSBsYSBjb25leGlvbi4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgICRMb2cgKz0gIiAgVGVzdCAkKCRQcnVlYmEuVGFtKSBNQiA6IEVSUk9SIgogICAgICAgIH0KICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICB9CgogICAgaWYgKCRSZXN1bHRhZG9zLkNvdW50IC1ndCAwKSB7CiAgICAgICAgJE1lZGlhID0gW01hdGhdOjpSb3VuZCgoJFJlc3VsdGFkb3MgfCBNZWFzdXJlLU9iamVjdCAtQXZlcmFnZSkuQXZlcmFnZSwgMSkKICAgICAgICBXcml0ZS1Ib3N0ICIgIE1lZGlhIGFwcm94aW1hZGE6ICRNZWRpYSBNYnBzIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgUkVGRVJFTkNJQToiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgIFdyaXRlLUhvc3QgIiAgICA8IDUgTWJwcyAgICBNdXkgbGVudGEuIFByb2JsZW1hcyBncmF2ZXMgZGUgY29uZXhpb24uIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgIFdyaXRlLUhvc3QgIiAgICA1IC0gMjUgTWJwcyBCYXNpY2EuIE5hdmVnYWNpb24geSBzdHJlYW1pbmcgU0QuIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgIFdyaXRlLUhvc3QgIiAgICAyNSAtIDEwMCBNYnBzIEJ1ZW5hLiBTdHJlYW1pbmcgSEQgeSB2aWRlb2xsYW1hZGFzLiIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgIFdyaXRlLUhvc3QgIiAgICA+IDEwMCBNYnBzICBFeGNlbGVudGUuIEFwdGEgcGFyYSBjdWFscXVpZXIgdXNvLiIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgTk9UQTogRWplY3V0YXIgZW4gY2FibGUgeSBlbiBXaUZpIHBhcmEgY29tcGFyYXIgZGlmZXJlbmNpYXMuIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgJExvZyArPSAiICBNZWRpYTogJE1lZGlhIE1icHMiCiAgICB9CgogICAgJHNjcmlwdDpIaXN0b3JpYWxTZXNpb24uQWRkKCJbUF0gVGVzdCB2ZWxvY2lkYWQgfCBNZWRpYTogJChpZiAoJFJlc3VsdGFkb3MuQ291bnQpIHsgKCRSZXN1bHRhZG9zIHwgTWVhc3VyZS1PYmplY3QgLUF2ZXJhZ2UpLkF2ZXJhZ2UuVG9TdHJpbmcoJ0YxJykgfSBlbHNlIHsgJ0VSUk9SJyB9KSBNYnBzIikKCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgJHNjcmlwdDpNb2RvQXV0bykgewogICAgICAgICRFeHAgPSBSZWFkLUhvc3QgImBuICBFeHBvcnRhciBpbmZvcm1lIGEgVFhUPyAoUy9OKSIKICAgICAgICBpZiAoJEV4cC5Ub1VwcGVyKCkgLWVxICJTIikgeyBFeHBvcnRhci1JbmZvcm1lIC1Db250ZW5pZG8gJExvZyAtTm9tYnJlTW9kdWxvICJWZWxvY2lkYWQiIHwgT3V0LU51bGwgfQogICAgfQoKICAgIEVzcGVyYXItRW50ZXIgLVNpbGVuY2lvc286JFNpbGVuY2lvc28KfQoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIE1PRFVMTyBRIC0gREVURUNDSU9OIERFIFBPUlRBTCBDQVVUSVZPCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpmdW5jdGlvbiBNb2R1bG8tUG9ydGFsQ2F1dGl2byB7CiAgICBwYXJhbShbc3dpdGNoXSRTaWxlbmNpb3NvKQogICAgaWYgKC1ub3QgJFNpbGVuY2lvc28gLWFuZCAtbm90IChNb3N0cmFyLUluZm9Nb2R1bG8gIlEiKSkgeyByZXR1cm4gfQoKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgWyBRIF0gIERFVEVDQ0lPTiBERSBQT1JUQUwgQ0FVVElWTyIgLUZvcmVncm91bmRDb2xvciBEYXJrWWVsbG93CiAgICBXcml0ZS1Ib3N0ICIgICQoIi0iICogNjApIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICJgbiAgVmVyaWZpY2FuZG8gY29uZWN0aXZpZGFkIGxpbXBpYSBhIEludGVybmV0Li4uYG4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKCiAgICAkTG9nID0gQCgiPT09IFBPUlRBTCBDQVVUSVZPID09PSAkKEdldC1EYXRlKSIsICIiKQogICAgJFJlc3VsdGFkbyA9ICJERVNDT05PQ0lETyIKCiAgICB0cnkgewogICAgICAgICMgR29vZ2xlIGdlbmVyYV8yMDQgZXMgZWwgZXN0YW5kYXIgZGUgZGV0ZWNjaW9uIGRlIHBvcnRhbCBjYXV0aXZvCiAgICAgICAgJFIgPSBJbnZva2UtV2ViUmVxdWVzdCAtVXJpICJodHRwOi8vY29ubmVjdGl2aXR5Y2hlY2suZ3N0YXRpYy5jb20vZ2VuZXJhdGVfMjA0IiBgCiAgICAgICAgICAgICAtVXNlQmFzaWNQYXJzaW5nIC1UaW1lb3V0U2VjIDUgLU1heGltdW1SZWRpcmVjdGlvbiAwIC1FcnJvckFjdGlvbiBTdG9wCgogICAgICAgIGlmICgkUi5TdGF0dXNDb2RlIC1lcSAyMDQpIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBSRVNVTFRBRE86IENvbmV4aW9uIGxpbXBpYSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIEhUVFAgMjA0IHJlY2liaWRvIC0+IE5vIGhheSBwb3J0YWwgY2F1dGl2byBhY3Rpdm8uIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgIFdyaXRlLUhvc3QgImBuICBUdSBkaXNwb3NpdGl2byB0aWVuZSBhY2Nlc28gZGlyZWN0byBhIEludGVybmV0IHNpbiBpbnRlcmNlcGNpb24uIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgICAgICRSZXN1bHRhZG8gPSAiTElNUElBIgogICAgICAgICAgICAkTG9nICAgICAgKz0gIiAgUmVzdWx0YWRvIDogQ29uZXhpb24gbGltcGlhIChIVFRQIDIwNCkiCiAgICAgICAgfSBlbHNlaWYgKCRSLlN0YXR1c0NvZGUgLWVxIDIwMCkgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIFJFU1VMVEFETzogUG9ydGFsIGNhdXRpdm8gZGV0ZWN0YWRvIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIEhUVFAgMjAwIGVuIGx1Z2FyIGRlIDIwNCAtPiBMYSByZXNwdWVzdGEgZnVlIGludGVyY2VwdGFkYS4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgIFdyaXRlLUhvc3QgImBuICBBQ0NJT04gUkVDT01FTkRBREE6IiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgQWJyZSBlbCBuYXZlZ2Fkb3IgeSBuYXZlZ2EgYSBodHRwOi8vbmV2ZXJzc2wuY29tIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRWwgcG9ydGFsIGRlIHJlZ2lzdHJvIHNlIGFicmlyYSBhdXRvbWF0aWNhbWVudGUuIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICAkUmVzdWx0YWRvID0gIlBPUlRBTCBDQVVUSVZPIgogICAgICAgICAgICAkTG9nICAgICAgKz0gIiAgUmVzdWx0YWRvIDogUG9ydGFsIGNhdXRpdm8gZGV0ZWN0YWRvIChIVFRQIDIwMCkiCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBSRVNVTFRBRE86IFJlc3B1ZXN0YSBpbmVzcGVyYWRhIChIVFRQICQoJFIuU3RhdHVzQ29kZSkpIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICAkUmVzdWx0YWRvID0gIklORVNQRVJBRE8gKCQoJFIuU3RhdHVzQ29kZSkpIgogICAgICAgICAgICAkTG9nICAgICAgKz0gIiAgUmVzdWx0YWRvIDogUmVzcHVlc3RhIGluZXNwZXJhZGEgSFRUUCAkKCRSLlN0YXR1c0NvZGUpIgogICAgICAgIH0KICAgIH0gY2F0Y2ggewogICAgICAgICMgVW5hIHJlZGlyZWNjaW9uICgzMHgpIG5vcm1hbG1lbnRlIGVzIHBvcnRhbCBjYXV0aXZvCiAgICAgICAgJE1zZyA9ICRfLkV4Y2VwdGlvbi5NZXNzYWdlCiAgICAgICAgaWYgKCRNc2cgLW1hdGNoICJyZWRpcmVjdHwzMFswLTldfExvY2F0aW9uIikgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIFJFU1VMVEFETzogUG9ydGFsIGNhdXRpdm8gZGV0ZWN0YWRvIChyZWRpcmVjY2lvbiAzeHgpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbiAgQUNDSU9OIFJFQ09NRU5EQURBOiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIEFicmUgZWwgbmF2ZWdhZG9yIHkgbmF2ZWdhIGEgaHR0cDovL25ldmVyc3NsLmNvbSIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAgICAgJFJlc3VsdGFkbyA9ICJQT1JUQUwgQ0FVVElWTyAocmVkaXJlY2Npb24pIgogICAgICAgICAgICAkTG9nICAgICAgKz0gIiAgUmVzdWx0YWRvIDogUG9ydGFsIGNhdXRpdm8gLSByZWRpcmVjY2lvbiBkZXRlY3RhZGEiCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBSRVNVTFRBRE86IFNpbiBjb25leGlvbiBhIEludGVybmV0IiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIE5vIHNlIHB1ZG8gYWxjYW56YXIgZWwgc2Vydmlkb3IgZGUgdmVyaWZpY2FjaW9uLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbiAgQ29tcHJ1ZWJhIHF1ZSBlbCBXaUZpL2NhYmxlIGVzdGUgY29uZWN0YWRvIHkgZWplY3V0YSBlbCBtb2R1bG8gRC4iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICRSZXN1bHRhZG8gPSAiU0lOIElOVEVSTkVUIgogICAgICAgICAgICAkTG9nICAgICAgKz0gIiAgUmVzdWx0YWRvIDogU2luIGNvbmV4aW9uIGEgSW50ZXJuZXQiCiAgICAgICAgfQogICAgfQoKICAgICMgUHJ1ZWJhIGFkaWNpb25hbCBjb24gQXBwbGUKICAgIHRyeSB7CiAgICAgICAgJFIyID0gSW52b2tlLVdlYlJlcXVlc3QgLVVyaSAiaHR0cDovL2NhcHRpdmUuYXBwbGUuY29tL2hvdHNwb3QtZGV0ZWN0Lmh0bWwiIGAKICAgICAgICAgICAgICAtVXNlQmFzaWNQYXJzaW5nIC1UaW1lb3V0U2VjIDUgLU1heGltdW1SZWRpcmVjdGlvbiAwIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgJEVzUG9ydGFsMiA9ICRSMi5Db250ZW50IC1ub3RtYXRjaCAiU3VjY2VzcyIKICAgICAgICAkTG9nICs9ICIgIEFwcGxlIGNhcHRpdmUuYXBwbGUuY29tIDogJChpZiAoJEVzUG9ydGFsMikgeyAnUG9ydGFsIGRldGVjdGFkbycgfSBlbHNlIHsgJ0xpbXBpbycgfSkiCiAgICB9IGNhdGNoIHsgfQoKICAgICRzY3JpcHQ6SGlzdG9yaWFsU2VzaW9uLkFkZCgiW1FdIFBvcnRhbCBjYXV0aXZvOiAkUmVzdWx0YWRvIikKCiAgICBpZiAoLW5vdCAkU2lsZW5jaW9zbyAtYW5kIC1ub3QgJHNjcmlwdDpNb2RvQXV0bykgewogICAgICAgICRFeHAgPSBSZWFkLUhvc3QgImBuICBFeHBvcnRhciBpbmZvcm1lIGEgVFhUPyAoUy9OKSIKICAgICAgICBpZiAoJEV4cC5Ub1VwcGVyKCkgLWVxICJTIikgeyBFeHBvcnRhci1JbmZvcm1lIC1Db250ZW5pZG8gJExvZyAtTm9tYnJlTW9kdWxvICJQb3J0YWxDYXV0aXZvIiB8IE91dC1OdWxsIH0KICAgIH0KCiAgICBFc3BlcmFyLUVudGVyIC1TaWxlbmNpb3NvOiRTaWxlbmNpb3NvCn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojICBNT0RVTE8gSSAtIEhJU1RPUklBTCBERSBTRVNJT04KIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmZ1bmN0aW9uIE1vc3RyYXItSGlzdG9yaWFsIHsKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgWyBJIF0gIEhJU1RPUklBTCBERSBTRVNJT04iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiAgJCgiLSIgKiA2MCkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiIKICAgIGlmICgkc2NyaXB0Okhpc3RvcmlhbFNlc2lvbi5Db3VudCAtZXEgMCkgewogICAgICAgIFdyaXRlLUhvc3QgIiAgQXVuIG5vIGhhcyBlamVjdXRhZG8gbmluZ3VuYSBoZXJyYW1pZW50YSBlbiBlc3RhIHNlc2lvbi4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIH0gZWxzZSB7CiAgICAgICAgV3JpdGUtSG9zdCAiICBBY2Npb25lcyByZWFsaXphZGFzIGVzdGEgc2VzaW9uOmBuIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgICAgICAkbiA9IDEKICAgICAgICBmb3JlYWNoICgkRSBpbiAkc2NyaXB0Okhpc3RvcmlhbFNlc2lvbikgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICB7MCwyfS4gezF9IiAtZiAkbiwgJEUpIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICAgICAgJG4rKwogICAgICAgIH0KICAgIH0KICAgIEVzcGVyYXItRW50ZXIKfQoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIE1PRE8gQVVUTyAoLUF1dG8pOiBlamVjdXRhciBpbmZvcm1lIGNvbXBsZXRvIHkgc2FsaXIKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmlmICgkc2NyaXB0Ok1vZG9BdXRvKSB7CiAgICBNb2R1bG8tSW5mb3JtZUNvbXBsZXRvIC1TaWxlbmNpb3NvCiAgICByZXR1cm4KfQoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgIE1FTlUgUFJJTkNJUEFMCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQp3aGlsZSAoJHRydWUpIHsKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgImBuIgogICAgRXNjcmliaXItQ2VudHJhZG8gIiAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgIiAiRGFya0dyYXkiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAiICJZZWxsb3ciCiAgICBFc2NyaWJpci1DZW50cmFkbyAiICB8ICAgICAgICAgICAgICAgICAgIEFUTEFTIFBDIFNVUFBPUlQgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICIgIlllbGxvdyIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICIgIHwgICAgICAgICAgICAgICBIRVJSQU1JRU5UQVMgREUgUkVEICB2My4wICAgICAgICAgICAgICAgICAgICAgfCAgIiAiWWVsbG93IgogICAgRXNjcmliaXItQ2VudHJhZG8gIiAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIiAiWWVsbG93IgogICAgRXNjcmliaXItQ2VudHJhZG8gIiAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgIiAiRGFya0dyYXkiCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiICArLS0tIERJQUdOT1NUSUNPIEJBU0lDTyAtLS0tLS0rLS0tLSBIRVJSQU1JRU5UQVMgQVZBTlpBREFTIC0tKyAgIiAiRGFya0dyYXkiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIiAiRGFya0dyYXkiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiICB8ICBbQV0gIEF1ZGl0b3JpYSBQdWVydG9zIExBTiB8ICBbTF0gIEZpcm13YXJlIGRlbCBSb3V0ZXIgICB8ICAiICJXaGl0ZSIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICIgIHwgIFtCXSAgRXNjYW5lbyBEaXNwb3NpdGl2b3MgIHwgIFtNXSAgSW5mb3JtZSBBdXRvbWF0aWNvICAgIHwgICIgIldoaXRlIgogICAgRXNjcmliaXItQ2VudHJhZG8gIiAgfCAgW0NdICBQYW5lbCBkZWwgUm91dGVyICAgICAgfCAgW05dICBDb21wYXJhdGl2YSBSZWRlcyAgICAgfCAgIiAiQ3lhbiIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICIgIHwgIFtEXSAgTGF0ZW5jaWEgLyBFc3RhYmlsaWRhZHwgIFtQXSAgVGVzdCBkZSBWZWxvY2lkYWQgICAgIHwgICIgIldoaXRlIgogICAgRXNjcmliaXItQ2VudHJhZG8gIiAgfCAgW0VdICBJbmZvIGRlbCBBZGFwdGFkb3IgICAgfCAgW1FdICBQb3J0YWwgQ2F1dGl2byAgICAgICAgfCAgIiAiV2hpdGUiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiICB8ICBbRl0gIFRlc3QgZGUgRE5TICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIiAiV2hpdGUiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiICB8ICBbSF0gIFB1ZXJ0b3MgV0FOICAgICAgICAgICB8ICBbSl0gIEZhYnJpY2FudGVzIChNQUMvT1VJKSB8ICAiICJXaGl0ZSIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICIgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAiICJEYXJrR3JheSIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICIgICstLS0gU0VTSU9OIC0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rICAiICJEYXJrR3JheSIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICIgIHwgIFtJXSAgSGlzdG9yaWFsIGRlIFNlc2lvbiAgIHwgIFtTXSAgU2FsaXIgICAgICAgICAgICAgICAgIHwgICIgIkRhcmtHcmF5IgogICAgRXNjcmliaXItQ2VudHJhZG8gIiAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICIgIkRhcmtHcmF5IgogICAgV3JpdGUtSG9zdCAiIgogICAgaWYgKCRzY3JpcHQ6SGlzdG9yaWFsU2VzaW9uLkNvdW50IC1ndCAwKSB7CiAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIiAgQWNjaW9uZXMgZW4gZXN0YSBzZXNpb246ICQoJHNjcmlwdDpIaXN0b3JpYWxTZXNpb24uQ291bnQpICB8ICBJbmZvOiAkKGlmICgkc2NyaXB0Ok1vc3RyYXJJbmZvKSB7ICdhY3RpdmFkYScgfSBlbHNlIHsgJ2Rlc2FjdGl2YWRhJyB9KSAgIiAiRGFya0dyYXkiCiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgfQoKICAgICRPcCA9IFJlYWQtSG9zdCAiICBFbGlnZSB1bmEgb3BjaW9uIgoKICAgIHN3aXRjaCAoJE9wLlRvVXBwZXIoKSkgewogICAgICAgICJBIiB7IE1vZHVsby1BdWRpdG9yaWEgICAgIH0KICAgICAgICAiQiIgeyBNb2R1bG8tRXNjYW5lbyAgICAgICB9CiAgICAgICAgIkMiIHsgTW9kdWxvLVBhbmVsICAgICAgICAgfQogICAgICAgICJEIiB7IE1vZHVsby1MYXRlbmNpYSAgICAgIH0KICAgICAgICAiRSIgeyBNb2R1bG8tSW5mb0FkYXB0YWRvciB9CiAgICAgICAgIkYiIHsgTW9kdWxvLVRlc3RETlMgICAgICAgfQogICAgICAgICJIIiB7IE1vZHVsby1QdWVydG9zV0FOICAgIH0KICAgICAgICAiSSIgeyBNb3N0cmFyLUhpc3RvcmlhbCAgICB9CiAgICAgICAgIkoiIHsgTW9kdWxvLUZhYnJpY2FudGVzICAgfQogICAgICAgICJMIiB7IE1vZHVsby1GaXJtd2FyZSAgICAgIH0KICAgICAgICAiTSIgeyBNb2R1bG8tSW5mb3JtZUNvbXBsZXRvIH0KICAgICAgICAiTiIgeyBNb2R1bG8tQ29tcGFyYXRpdmEgICB9CiAgICAgICAgIlAiIHsgTW9kdWxvLVZlbG9jaWRhZCAgICAgfQogICAgICAgICJRIiB7IE1vZHVsby1Qb3J0YWxDYXV0aXZvIH0KICAgICAgICAiUyIgewogICAgICAgICAgICBpZiAoJHNjcmlwdDpIaXN0b3JpYWxTZXNpb24uQ291bnQgLWd0IDApIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgLS0tIFJFU1VNRU4gREUgU0VTSU9OIC0tLSIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAgICAgICAgICRuID0gMQogICAgICAgICAgICAgICAgZm9yZWFjaCAoJEUgaW4gJHNjcmlwdDpIaXN0b3JpYWxTZXNpb24pIHsKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICB7MCwyfS4gezF9IiAtZiAkbiwgJEUpIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgICAgICAgICAkbisrCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgV3JpdGUtSG9zdCAiYG4gIENlcnJhbmRvIGhlcnJhbWllbnRhcy4uLiBIYXN0YSBwcm9udG8sIEF0bGFzISIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAgICAgU3RhcnQtU2xlZXAgLVNlY29uZHMgMQogICAgICAgICAgICBbY29uc29sZV06OlJlc2V0Q29sb3IoKQogICAgICAgICAgICBDbGVhci1Ib3N0CiAgICAgICAgICAgIHJldHVybgogICAgICAgIH0KICAgICAgICBkZWZhdWx0IHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiYG4gIE9wY2lvbiBubyB2YWxpZGEuIEVsaWdlIHVuYSBsZXRyYSBkZWwgbWVudS4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgIFN0YXJ0LVNsZWVwIC1TZWNvbmRzIDEKICAgICAgICB9CiAgICB9Cn0KfQo='
$script:AtlasToolSources['Invoke-EntregaPC'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtRW50cmVnYVBDCiMgTWlncmFkbyBkZTogRW50cmVnYV9QQy5wczEKIyBBdGxhcyBQQyBTdXBwb3J0IOKAlCB2MS4wCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBJbnZva2UtRW50cmVnYVBDIHsKICAgIFtDbWRsZXRCaW5kaW5nKCldCiAgICBwYXJhbSgpCu+7vyMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBTQ1JJUFQgREUgRU5UUkVHQSBQUkVNSVVNIENFTlRSQURPIC0gQVRMQVMgU09QT1JURQojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgojIDEuIEZvcnphciBwZXJtaXNvcyBkZSBBZG1pbmlzdHJhZG9yCmlmICghKFtTZWN1cml0eS5QcmluY2lwYWwuV2luZG93c1ByaW5jaXBhbF1bU2VjdXJpdHkuUHJpbmNpcGFsLldpbmRvd3NJZGVudGl0eV06OkdldEN1cnJlbnQoKSkuSXNJblJvbGUoW1NlY3VyaXR5LlByaW5jaXBhbC5XaW5kb3dzQnVpbHRJblJvbGVdOjpBZG1pbmlzdHJhdG9yKSkgewogICAgV3JpdGUtV2FybmluZyAiQVRFTkNJw5NOOiBFc3RlIHNjcmlwdCBuZWNlc2l0YSBwZXJtaXNvcyBkZSBBZG1pbmlzdHJhZG9yLiIKICAgIFdyaXRlLVdhcm5pbmcgIkhheiBjbGljIGRlcmVjaG8gZW4gZWwgYXJjaGl2byB5IHNlbGVjY2lvbmEgJ0VqZWN1dGFyIGNvbiBQb3dlclNoZWxsJyBjb21vIGFkbWluaXN0cmFkb3IuIgogICAgUGF1c2UKICAgIHJldHVybgp9CgojIDIuIENvbmZpZ3VyYXIgbGEgaW50ZXJmYXogZGUgbGEgY29uc29sYQokSG9zdC5VSS5SYXdVSS5CYWNrZ3JvdW5kQ29sb3IgPSAiQmxhY2siCiRIb3N0LlVJLlJhd1VJLkZvcmVncm91bmRDb2xvciA9ICJXaGl0ZSIKQ2xlYXItSG9zdAoKIyAtLS0gRlVOQ0nDk046IENlbnRyYXIgVGV4dG8gTcOhZ2ljYW1lbnRlIC0tLQpmdW5jdGlvbiBFc2NyaWJpci1DZW50cmFkbyB7CiAgICBwYXJhbShbc3RyaW5nXSR0ZXh0bywgW3N0cmluZ10kY29sb3IpCiAgICAkYW5jaG9Db25zb2xhID0gJEhvc3QuVUkuUmF3VUkuV2luZG93U2l6ZS5XaWR0aAogICAgJGVzcGFjaW9zID0gIiAiICogKFttYXRoXTo6TWF4KDAsIFttYXRoXTo6Rmxvb3IoKCRhbmNob0NvbnNvbGEgLSAkdGV4dG8uTGVuZ3RoKSAvIDIpKSkKICAgIFdyaXRlLUhvc3QgKCRlc3BhY2lvcyArICR0ZXh0bykgLUZvcmVncm91bmRDb2xvciAkY29sb3IKfQoKIyAtLS0gRlVOQ0nDk046IE1vc3RyYXIgZWwgTG9nbyAtLS0KZnVuY3Rpb24gTW9zdHJhci1FbmNhYmV6YWRvIHsKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgImBuIgogICAgRXNjcmliaXItQ2VudHJhZG8gIiDilojilojilojilojilojilZcg4paI4paI4paI4paI4paI4paI4paI4paI4pWX4paI4paI4pWXICAgICAg4paI4paI4paI4paI4paI4pWXIOKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVlyIgIkRhcmtZZWxsb3ciCiAgICBFc2NyaWJpci1DZW50cmFkbyAi4paI4paI4pWU4pWQ4pWQ4paI4paI4pWX4pWa4pWQ4pWQ4paI4paI4pWU4pWQ4pWQ4pWd4paI4paI4pWRICAgICDilojilojilZTilZDilZDilojilojilZfilojilojilZTilZDilZDilZDilZDilZ0iICJEYXJrWWVsbG93IgogICAgRXNjcmliaXItQ2VudHJhZG8gIuKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVkSAgIOKWiOKWiOKVkSAgIOKWiOKWiOKVkSAgICAg4paI4paI4paI4paI4paI4paI4paI4pWR4paI4paI4paI4paI4paI4paI4paI4pWXIiAiRGFya1llbGxvdyIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICLilojilojilZTilZDilZDilojilojilZEgICDilojilojilZEgICDilojilojilZEgICAgIOKWiOKWiOKVlOKVkOKVkOKWiOKWiOKVkeKVmuKVkOKVkOKVkOKVkOKWiOKWiOKVkSIgIkRhcmtZZWxsb3ciCiAgICBFc2NyaWJpci1DZW50cmFkbyAi4paI4paI4pWRICDilojilojilZEgICDilojilojilZEgICDilojilojilojilojilojilojilojilZfilojilojilZEgIOKWiOKWiOKVkeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVkSIgIkRhcmtZZWxsb3ciCiAgICBFc2NyaWJpci1DZW50cmFkbyAi4pWa4pWQ4pWdICDilZrilZDilZ0gICDilZrilZDilZ0gICDilZrilZDilZDilZDilZDilZDilZDilZ3ilZrilZDilZ0gIOKVmuKVkOKVneKVmuKVkOKVkOKVkOKVkOKVkOKVkOKVnSIgIkRhcmtZZWxsb3ciCiAgICBFc2NyaWJpci1DZW50cmFkbyAiICAgICAgICBQIEMgICBTIFUgUCBQIE8gUiBUICAgICAgICAgICAgICAiICJEYXJrWWVsbG93IgogICAgRXNjcmliaXItQ2VudHJhZG8gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAiRGFya0dyYXkiCiAgICBXcml0ZS1Ib3N0ICJgbiIKfQoKIyAtLS0gRlVOQ0nDk046IE1vZGlmaWNhciBVc3VhcmlvIEFjdHVhbCAtLS0KZnVuY3Rpb24gTW9kaWZpY2FyLVVzdWFyaW9BY3R1YWwgewogICAgJHVzZXJOYW1lID0gJGVudjpVU0VSTkFNRQogICAgRXNjcmliaXItQ2VudHJhZG8gIi0tLSBDT05GSUdVUkFORE8gVVNVQVJJTyBBQ1RVQUw6IFskdXNlck5hbWVdIC0tLSIgIkN5YW4iCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICAoRXNjcmliYSAnMCcgZW4gY3VhbHF1aWVyIG1vbWVudG8gcGFyYSBjYW5jZWxhciB5IHZvbHZlcikiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiIKICAgIAogICAgJG5ld0Rpc3BsYXlOYW1lID0gUmVhZC1Ib3N0ICIgICAtPiBOb21icmUgeSBhcGVsbGlkbyBkZWwgY2xpZW50ZSIKICAgIGlmICgkbmV3RGlzcGxheU5hbWUgLWVxICIwIikgeyByZXR1cm4gfQogICAgCiAgICBXcml0ZS1Ib3N0ICIgICAtPiBDb250cmFzZcOxYSAoRXNjcmliYSBhIGNpZWdhcyB5IHByZXNpb25lIEVOVEVSLiBEZWplIGVuIGJsYW5jbyBwYXJhIE5PIHVzYXIgY2xhdmUpIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgJHNlY3VyZVBhc3N3b3JkID0gUmVhZC1Ib3N0ICIgICAgICBDbGF2ZSIgLUFzU2VjdXJlU3RyaW5nCgogICAgdHJ5IHsKICAgICAgICBpZiAoIVtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJG5ld0Rpc3BsYXlOYW1lKSkgewogICAgICAgICAgICBTZXQtTG9jYWxVc2VyIC1OYW1lICR1c2VyTmFtZSAtRnVsbE5hbWUgJG5ld0Rpc3BsYXlOYW1lCiAgICAgICAgICAgIFdyaXRlLUhvc3QgImBuICAgW09LXSBOb21icmUgYWN0dWFsaXphZG8gYTogJG5ld0Rpc3BsYXlOYW1lIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgfQogICAgICAgIGlmICgkc2VjdXJlUGFzc3dvcmQuTGVuZ3RoIC1ndCAwKSB7CiAgICAgICAgICAgIFNldC1Mb2NhbFVzZXIgLU5hbWUgJHVzZXJOYW1lIC1QYXNzd29yZCAkc2VjdXJlUGFzc3dvcmQKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgW09LXSBDb250cmFzZcOxYSBlc3RhYmxlY2lkYS4iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICB9IGVsc2UgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbiAgIFtPS10gRWwgdXN1YXJpbyBzZSBtYW50aWVuZSBzaW4gY29udHJhc2XDsWEuIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgfQogICAgfSBjYXRjaCB7CiAgICAgICAgV3JpdGUtSG9zdCAiYG4gICBbRVJST1JdICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgfQogICAgV3JpdGUtSG9zdCAiYG4gICBQcmVzaW9uZSBFTlRFUiBwYXJhIHZvbHZlciBhbCBtZW7DuiBwcmluY2lwYWwuLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFJlYWQtSG9zdAp9CgojIC0tLSBGVU5DScOTTjogQ3JlYXIgVXN1YXJpbyBOdWV2byAtLS0KZnVuY3Rpb24gQ3JlYXItTnVldm9Vc3VhcmlvIHsKICAgIEVzY3JpYmlyLUNlbnRyYWRvICItLS0gQ1JFQU5ETyBOVUVWTyBVU1VBUklPIC0tLSIgIkN5YW4iCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICAoRXNjcmliYSAnMCcgZW4gY3VhbHF1aWVyIG1vbWVudG8gcGFyYSBjYW5jZWxhciB5IHZvbHZlcikiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiIKICAgIAogICAgJG5ld1VzZXIgPSBSZWFkLUhvc3QgIiAgIC0+IE5vbWJyZSBpbnRlcm5vIGRlIGxhIGN1ZW50YSAoZWouIGpvcmdlLCBzaW4gZXNwYWNpb3MpIgogICAgaWYgKCRuZXdVc2VyIC1lcSAiMCIgLW9yIFtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJG5ld1VzZXIpKSB7IHJldHVybiB9CgogICAgJG5ld0Rpc3BsYXlOYW1lID0gUmVhZC1Ib3N0ICIgICAtPiBOb21icmUgY29tcGxldG8gcGFyYSBsYSBwYW50YWxsYSAoZWouIEpvcmdlIE1hcnTDrW5leikiCiAgICBpZiAoJG5ld0Rpc3BsYXlOYW1lIC1lcSAiMCIpIHsgcmV0dXJuIH0KICAgIAogICAgV3JpdGUtSG9zdCAiICAgLT4gQ29udHJhc2XDsWEgKEVzY3JpYmEgYSBjaWVnYXMgeSBwcmVzaW9uZSBFTlRFUi4gRGVqZSBlbiBibGFuY28gcGFyYSBOTyB1c2FyIGNsYXZlKSIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICRzZWN1cmVQYXNzd29yZCA9IFJlYWQtSG9zdCAiICAgICAgQ2xhdmUiIC1Bc1NlY3VyZVN0cmluZwogICAgCiAgICAkZXNBZG1pbiA9IFJlYWQtSG9zdCAiICAgLT4gwr9IYWNlciBhIGVzdGUgdXN1YXJpbyBBZG1pbmlzdHJhZG9yPyAoUy9OKSIKICAgIGlmICgkZXNBZG1pbiAtZXEgIjAiKSB7IHJldHVybiB9CgogICAgdHJ5IHsKICAgICAgICBpZiAoJHNlY3VyZVBhc3N3b3JkLkxlbmd0aCAtZ3QgMCkgewogICAgICAgICAgICBOZXctTG9jYWxVc2VyIC1OYW1lICRuZXdVc2VyIC1GdWxsTmFtZSAkbmV3RGlzcGxheU5hbWUgLVBhc3N3b3JkICRzZWN1cmVQYXNzd29yZCAtUGFzc3dvcmROZXZlckV4cGlyZXMgJHRydWUgfCBPdXQtTnVsbAogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgIE5ldy1Mb2NhbFVzZXIgLU5hbWUgJG5ld1VzZXIgLUZ1bGxOYW1lICRuZXdEaXNwbGF5TmFtZSAtTm9QYXNzd29yZCB8IE91dC1OdWxsCiAgICAgICAgfQogICAgICAgIFdyaXRlLUhvc3QgImBuICAgW09LXSBVc3VhcmlvICckbmV3VXNlcicgY3JlYWRvIGNvcnJlY3RhbWVudGUuIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCgogICAgICAgIGlmICgkZXNBZG1pbiAtbWF0Y2ggIl5bc1NdIikgewogICAgICAgICAgICAkQWRtaW5Hcm91cCA9IEdldC1Mb2NhbEdyb3VwIHwgV2hlcmUtT2JqZWN0IFNJRCAtZXEgIlMtMS01LTMyLTU0NCIKICAgICAgICAgICAgQWRkLUxvY2FsR3JvdXBNZW1iZXIgLUdyb3VwICRBZG1pbkdyb3VwIC1NZW1iZXIgJG5ld1VzZXIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgW09LXSBQZXJtaXNvcyBkZSBBZG1pbmlzdHJhZG9yIGNvbmNlZGlkb3MuIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgJFVzZXJzR3JvdXAgPSBHZXQtTG9jYWxHcm91cCB8IFdoZXJlLU9iamVjdCBTSUQgLWVxICJTLTEtNS0zMi01NDUiCiAgICAgICAgICAgIEFkZC1Mb2NhbEdyb3VwTWVtYmVyIC1Hcm91cCAkVXNlcnNHcm91cCAtTWVtYmVyICRuZXdVc2VyCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgIFtPS10gUGVybWlzb3MgZGUgVXN1YXJpbyBFc3TDoW5kYXIgY29uY2VkaWRvcy4iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICB9CiAgICB9IGNhdGNoIHsKICAgICAgICBXcml0ZS1Ib3N0ICJgbiAgIFtFUlJPUl0gJCgkXy5FeGNlcHRpb24uTWVzc2FnZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICB9CiAgICBXcml0ZS1Ib3N0ICJgbiAgIFByZXNpb25lIEVOVEVSIHBhcmEgdm9sdmVyIGFsIG1lbsO6IHByaW5jaXBhbC4uLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgUmVhZC1Ib3N0Cn0KCiMgLS0tIEZVTkNJw5NOOiBSZW5vbWJyYXIgRXF1aXBvIC0tLQpmdW5jdGlvbiBSZW5vbWJyYXItRXF1aXBvIHsKICAgIEVzY3JpYmlyLUNlbnRyYWRvICItLS0gUkVOT01CUkFSIEVRVUlQTyAtLS0iICJDeWFuIgogICAgV3JpdGUtSG9zdCAiIgogICAgJGFjdHVhbCA9ICRlbnY6Q09NUFVURVJOQU1FCiAgICBXcml0ZS1Ib3N0ICIgICBOb21icmUgYWN0dWFsOiAkYWN0dWFsIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICBXcml0ZS1Ib3N0ICIiCiAgICAkbnVldm8gPSBSZWFkLUhvc3QgIiAgIC0+IE51ZXZvIG5vbWJyZSAoMCBwYXJhIGNhbmNlbGFyKSIKICAgIGlmICgkbnVldm8gLWVxICIwIiAtb3IgW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkbnVldm8pKSB7IHJldHVybiB9CiAgICBpZiAoJG51ZXZvIC1ub3RtYXRjaCAnXltBLVphLXowLTlcLV17MSwxNX0kJykgewogICAgICAgIFdyaXRlLUhvc3QgImBuICAgW0VSUk9SXSBOb21icmUgaW52YWxpZG8uIFNvbG8gQS1aIDAtOSB5IGd1aW9uLCBtYXggMTUuIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgIFJlYWQtSG9zdCAiYG4gICBFTlRFUiBwYXJhIHZvbHZlciIKICAgICAgICByZXR1cm4KICAgIH0KICAgIHRyeSB7CiAgICAgICAgUmVuYW1lLUNvbXB1dGVyIC1OZXdOYW1lICRudWV2byAtRm9yY2UgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICBXcml0ZS1Ib3N0ICJgbiAgIFtPS10gTm9tYnJlIGNhbWJpYWRvIGE6ICRudWV2byIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgIFdyaXRlLUhvc3QgIiAgIERlYmUgcmVpbmljaWFyIGVsIGVxdWlwbyBwYXJhIGFwbGljYXIuIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgfSBjYXRjaCB7CiAgICAgICAgV3JpdGUtSG9zdCAiYG4gICBbRVJST1JdICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgfQogICAgUmVhZC1Ib3N0ICJgbiAgIEVOVEVSIHBhcmEgdm9sdmVyIgp9CgojIC0tLSBGVU5DScOTTjogR2VuZXJhciBDaGVja2xpc3QgZGUgRW50cmVnYSAocmVwb3J0ZSkgLS0tCmZ1bmN0aW9uIEdlbmVyYXItQ2hlY2tsaXN0RW50cmVnYSB7CiAgICBFc2NyaWJpci1DZW50cmFkbyAiLS0tIEdFTkVSQU5ETyBDSEVDS0xJU1QgREUgRU5UUkVHQSAtLS0iICJDeWFuIgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICAgUmVjb3BpbGFuZG8gaW5mb3JtYWNpb24gZGVsIGVxdWlwby4uLiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKCiAgICAkcmVwb3J0ID0gQCgpCiAgICAkcmVwb3J0ICs9ICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IgogICAgJHJlcG9ydCArPSAiICBBVExBUyBQQyBTVVBQT1JUIC0gQ0hFQ0tMSVNUIERFIEVOVFJFR0EiCiAgICAkcmVwb3J0ICs9ICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IgogICAgJHJlcG9ydCArPSAiICBHZW5lcmFkbzogJChHZXQtRGF0ZSAtRm9ybWF0ICd5eXl5LU1NLWRkIEhIOm1tOnNzJykiCiAgICAkcmVwb3J0ICs9ICIiCgogICAgIyBFcXVpcG8KICAgIHRyeSB7CiAgICAgICAgJGNzID0gR2V0LUNpbUluc3RhbmNlIFdpbjMyX0NvbXB1dGVyU3lzdGVtIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgJGJpb3MgPSBHZXQtQ2ltSW5zdGFuY2UgV2luMzJfQklPUyAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICRvcyA9IEdldC1DaW1JbnN0YW5jZSBXaW4zMl9PcGVyYXRpbmdTeXN0ZW0gLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAkcmVwb3J0ICs9ICJbRVFVSVBPXSIKICAgICAgICAkcmVwb3J0ICs9ICgiICBOb21icmU6ICAgICAgICB7MH0iIC1mICRlbnY6Q09NUFVURVJOQU1FKQogICAgICAgICRyZXBvcnQgKz0gKCIgIEZhYnJpY2FudGU6ICAgIHswfSIgLWYgJGNzLk1hbnVmYWN0dXJlcikKICAgICAgICAkcmVwb3J0ICs9ICgiICBNb2RlbG86ICAgICAgICB7MH0iIC1mICRjcy5Nb2RlbCkKICAgICAgICAkcmVwb3J0ICs9ICgiICBTZXJpYWwgQklPUzogICB7MH0iIC1mICRiaW9zLlNlcmlhbE51bWJlcikKICAgICAgICAkcmVwb3J0ICs9ICgiICBPUzogICAgICAgICAgICB7MH0iIC1mICRvcy5DYXB0aW9uKQogICAgICAgICRyZXBvcnQgKz0gKCIgIFZlcnNpb246ICAgICAgIHswfSIgLWYgJG9zLlZlcnNpb24pCiAgICAgICAgJHJlcG9ydCArPSAoIiAgQnVpbGQ6ICAgICAgICAgezB9IiAtZiAkb3MuQnVpbGROdW1iZXIpCiAgICAgICAgJHJlcG9ydCArPSAoIiAgQXJxdWl0ZWN0dXJhOiAgezB9IiAtZiAkb3MuT1NBcmNoaXRlY3R1cmUpCiAgICAgICAgJHJlcG9ydCArPSAoIiAgUkFNIHRvdGFsOiAgICAgezA6TjF9IEdCIiAtZiAoJGNzLlRvdGFsUGh5c2ljYWxNZW1vcnkvMUdCKSkKICAgICAgICAkcmVwb3J0ICs9ICIiCiAgICB9IGNhdGNoIHsKICAgICAgICAkcmVwb3J0ICs9ICIgIFshXSBFcnJvciBvYnRlbmllbmRvIGluZm8gZXF1aXBvOiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIKICAgIH0KCiAgICAjIEFjdGl2YWNpb24KICAgIHRyeSB7CiAgICAgICAgJGxpY0luZm8gPSBjc2NyaXB0LmV4ZSAvL05vbG9nbyAiQzpcV2luZG93c1xTeXN0ZW0zMlxzbG1nci52YnMiIC94cHIgMj4mMQogICAgICAgICRyZXBvcnQgKz0gIltBQ1RJVkFDSU9OIFdJTkRPV1NdIgogICAgICAgICRsaWNJbmZvIHwgRm9yRWFjaC1PYmplY3QgeyAkcmVwb3J0ICs9ICIgICRfIiB9CiAgICAgICAgJHJlcG9ydCArPSAiIgogICAgfSBjYXRjaCB7CiAgICAgICAgJHJlcG9ydCArPSAiICBbIV0gTm8gc2UgcHVkbyBjb25zdWx0YXIgYWN0aXZhY2lvbi4iCiAgICB9CgogICAgIyBVc3VhcmlvcwogICAgdHJ5IHsKICAgICAgICAkcmVwb3J0ICs9ICJbVVNVQVJJT1MgTE9DQUxFU10iCiAgICAgICAgR2V0LUxvY2FsVXNlciAtRXJyb3JBY3Rpb24gU3RvcCB8IFdoZXJlLU9iamVjdCB7ICRfLkVuYWJsZWQgfSB8IEZvckVhY2gtT2JqZWN0IHsKICAgICAgICAgICAgJHJlcG9ydCArPSAoIiAgLSB7MCwtMjB9IChGdWxsTmFtZTogezF9KSIgLWYgJF8uTmFtZSwgJF8uRnVsbE5hbWUpCiAgICAgICAgfQogICAgICAgICRyZXBvcnQgKz0gIiIKICAgICAgICAkcmVwb3J0ICs9ICJbQURNSU5JU1RSQURPUkVTXSIKICAgICAgICAkYWRtaW5Hcm91cCA9IEdldC1Mb2NhbEdyb3VwIHwgV2hlcmUtT2JqZWN0IFNJRCAtZXEgIlMtMS01LTMyLTU0NCIKICAgICAgICBpZiAoJGFkbWluR3JvdXApIHsKICAgICAgICAgICAgR2V0LUxvY2FsR3JvdXBNZW1iZXIgLUdyb3VwICRhZG1pbkdyb3VwIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlIHwgRm9yRWFjaC1PYmplY3QgewogICAgICAgICAgICAgICAgJHJlcG9ydCArPSAoIiAgLSB7MH0iIC1mICRfLk5hbWUpCiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgJHJlcG9ydCArPSAiIgogICAgfSBjYXRjaCB7CiAgICAgICAgJHJlcG9ydCArPSAiICBbIV0gRXJyb3IgbGlzdGFuZG8gdXN1YXJpb3M6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIgogICAgfQoKICAgICMgQml0TG9ja2VyCiAgICB0cnkgewogICAgICAgICRyZXBvcnQgKz0gIltCSVRMT0NLRVJdIgogICAgICAgICR2b2xzID0gR2V0LUJpdExvY2tlclZvbHVtZSAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgIGZvcmVhY2ggKCR2IGluICR2b2xzKSB7CiAgICAgICAgICAgICRyZXBvcnQgKz0gKCIgIHswfTogezEsLTE1fSBQcm90ZWN0aW9uOiB7MiwtNX0gRW5jOiB7M30lIiAtZiAkdi5Nb3VudFBvaW50LCAkdi5Wb2x1bWVTdGF0dXMsICR2LlByb3RlY3Rpb25TdGF0dXMsICR2LkVuY3J5cHRpb25QZXJjZW50YWdlKQogICAgICAgICAgICAkcmsgPSAkdi5LZXlQcm90ZWN0b3IgfCBXaGVyZS1PYmplY3QgeyAkXy5LZXlQcm90ZWN0b3JUeXBlIC1lcSAnUmVjb3ZlcnlQYXNzd29yZCcgfQogICAgICAgICAgICBmb3JlYWNoICgkciBpbiAkcmspIHsKICAgICAgICAgICAgICAgICRyZXBvcnQgKz0gKCIgICAgIFJlY292ZXJ5IEtleSBJRDogezB9IiAtZiAkci5LZXlQcm90ZWN0b3JJZCkKICAgICAgICAgICAgICAgICRyZXBvcnQgKz0gKCIgICAgIFJlY292ZXJ5IEtleTogICAgezB9IiAtZiAkci5SZWNvdmVyeVBhc3N3b3JkKQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgICRyZXBvcnQgKz0gIiIKICAgIH0gY2F0Y2ggewogICAgICAgICRyZXBvcnQgKz0gIiAgWyFdIEJpdExvY2tlciBubyBkaXNwb25pYmxlIG8gZXJyb3I6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIgogICAgICAgICRyZXBvcnQgKz0gIiIKICAgIH0KCiAgICAjIERpc2NvcwogICAgdHJ5IHsKICAgICAgICAkcmVwb3J0ICs9ICJbRElTQ09TIEZJU0lDT1NdIgogICAgICAgIEdldC1QaHlzaWNhbERpc2sgLUVycm9yQWN0aW9uIFN0b3AgfCBGb3JFYWNoLU9iamVjdCB7CiAgICAgICAgICAgICRyZXBvcnQgKz0gKCIgIC0gezB9IHsxfSAgezI6TjB9IEdCICBIZWFsdGg6IHszfSAgTWVkaWE6IHs0fSIgLWYgJF8uRnJpZW5kbHlOYW1lLCAkXy5TZXJpYWxOdW1iZXIsICgkXy5TaXplLzFHQiksICRfLkhlYWx0aFN0YXR1cywgJF8uTWVkaWFUeXBlKQogICAgICAgIH0KICAgICAgICAkcmVwb3J0ICs9ICIiCiAgICAgICAgJHJlcG9ydCArPSAiW1ZPTFVNRU5FU10iCiAgICAgICAgR2V0LVZvbHVtZSAtRXJyb3JBY3Rpb24gU3RvcCB8IFdoZXJlLU9iamVjdCB7ICRfLkRyaXZlTGV0dGVyIH0gfCBTb3J0LU9iamVjdCBEcml2ZUxldHRlciB8IEZvckVhY2gtT2JqZWN0IHsKICAgICAgICAgICAgJHJlcG9ydCArPSAoIiAgezB9OiB7MSwtMTV9IHsyOk4xfSBHQiBsaWJyZSBkZSB7MzpOMX0gR0IgKHs0fSkiIC1mICRfLkRyaXZlTGV0dGVyLCAkXy5GaWxlU3lzdGVtTGFiZWwsICgkXy5TaXplUmVtYWluaW5nLzFHQiksICgkXy5TaXplLzFHQiksICRfLkZpbGVTeXN0ZW0pCiAgICAgICAgfQogICAgICAgICRyZXBvcnQgKz0gIiIKICAgIH0gY2F0Y2ggewogICAgICAgICRyZXBvcnQgKz0gIiAgWyFdIEVycm9yIGRpc2NvczogJCgkXy5FeGNlcHRpb24uTWVzc2FnZSkiCiAgICB9CgogICAgIyBXaW5kb3dzIFVwZGF0ZQogICAgdHJ5IHsKICAgICAgICAkcmVwb3J0ICs9ICJbVUxUSU1BUyBBQ1RVQUxJWkFDSU9ORVMgSU5TVEFMQURBU10iCiAgICAgICAgR2V0LUhvdEZpeCAtRXJyb3JBY3Rpb24gU3RvcCB8IFNvcnQtT2JqZWN0IEluc3RhbGxlZE9uIC1EZXNjZW5kaW5nIHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgMTAgfCBGb3JFYWNoLU9iamVjdCB7CiAgICAgICAgICAgICRyZXBvcnQgKz0gKCIgIC0gezB9ICB7MX0gICh7Mn0pIiAtZiAkXy5Ib3RGaXhJRCwgJF8uSW5zdGFsbGVkT24sICRfLkRlc2NyaXB0aW9uKQogICAgICAgIH0KICAgICAgICAkcmVwb3J0ICs9ICIiCiAgICB9IGNhdGNoIHsKICAgICAgICAkcmVwb3J0ICs9ICIgIFshXSBFcnJvciBIb3RGaXg6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIgogICAgfQoKICAgICMgUmVkCiAgICB0cnkgewogICAgICAgICRyZXBvcnQgKz0gIltSRURdIgogICAgICAgIEdldC1OZXRJUEFkZHJlc3MgLUFkZHJlc3NGYW1pbHkgSVB2NCAtRXJyb3JBY3Rpb24gU3RvcCB8IFdoZXJlLU9iamVjdCB7ICRfLklQQWRkcmVzcyAtbm90bGlrZSAnMTY5LionIC1hbmQgJF8uSVBBZGRyZXNzIC1ub3RsaWtlICcxMjcuKicgfSB8IEZvckVhY2gtT2JqZWN0IHsKICAgICAgICAgICAgJHJlcG9ydCArPSAoIiAgezB9OiB7MX0vezJ9IiAtZiAkXy5JbnRlcmZhY2VBbGlhcywgJF8uSVBBZGRyZXNzLCAkXy5QcmVmaXhMZW5ndGgpCiAgICAgICAgfQogICAgICAgICRyZXBvcnQgKz0gIiIKICAgIH0gY2F0Y2gge30KCiAgICAjIERlZmVuZGVyCiAgICB0cnkgewogICAgICAgICRtcCA9IEdldC1NcENvbXB1dGVyU3RhdHVzIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgJHJlcG9ydCArPSAiW1dJTkRPV1MgREVGRU5ERVJdIgogICAgICAgICRyZXBvcnQgKz0gKCIgIEFWIEVuYWJsZWQ6ICAgICAgICAgIHswfSIgLWYgJG1wLkFudGl2aXJ1c0VuYWJsZWQpCiAgICAgICAgJHJlcG9ydCArPSAoIiAgUmVhbFRpbWUgUHJvdGVjdGlvbjogezB9IiAtZiAkbXAuUmVhbFRpbWVQcm90ZWN0aW9uRW5hYmxlZCkKICAgICAgICAkcmVwb3J0ICs9ICgiICBBViBTaWduYXR1cmU6ICAgICAgICB7MH0iIC1mICRtcC5BbnRpdmlydXNTaWduYXR1cmVMYXN0VXBkYXRlZCkKICAgICAgICAkcmVwb3J0ICs9ICIiCiAgICB9IGNhdGNoIHt9CgogICAgIyBDaGVja2xpc3QgbWFudWFsCiAgICAkcmVwb3J0ICs9ICJbQ0hFQ0tMSVNUIE1BTlVBTCBQUkUtRU5UUkVHQV0iCiAgICAkcmVwb3J0ICs9ICIgIFsgXSBIYXJkd2FyZSBwcm9iYWRvIChwYW50YWxsYSwgdGVjbGFkbywgdGFjdGlsLCBhdWRpbywgVVNCKSIKICAgICRyZXBvcnQgKz0gIiAgWyBdIEJhdGVyaWEgYWwgMTAwJSB5IGNhcmdhZG9yIGluY2x1aWRvIgogICAgJHJlcG9ydCArPSAiICBbIF0gQW50aXZpcnVzIGFjdGl2byB5IGFjdHVhbGl6YWRvIgogICAgJHJlcG9ydCArPSAiICBbIF0gQml0TG9ja2VyIGFjdGl2YWRvIHkgcmVjb3Zlcnkga2V5IGd1YXJkYWRhIgogICAgJHJlcG9ydCArPSAiICBbIF0gV2luZG93cyBVcGRhdGUgYWwgZGlhIgogICAgJHJlcG9ydCArPSAiICBbIF0gTmF2ZWdhZG9yIGxpbXBpbyAoc2luIGN1ZW50YXMgZ3VhcmRhZGFzIGRlbCB0ZWNuaWNvKSIKICAgICRyZXBvcnQgKz0gIiAgWyBdIFVzdWFyaW8gY2xpZW50ZSBjcmVhZG8gY29uIG5vbWJyZSBjb3JyZWN0byIKICAgICRyZXBvcnQgKz0gIiAgWyBdIFBhc3N3b3JkIGVudHJlZ2FkYSBmaXNpY2FtZW50ZSBvIHBvciBjYW5hbCBzZWd1cm8iCiAgICAkcmVwb3J0ICs9ICIgIFsgXSBDbGllbnRlIGluZm9ybWFkbyBzb2JyZSBnYXJhbnRpYSB5IGNvbnRhY3RvIgogICAgJHJlcG9ydCArPSAiICBbIF0gRXF1aXBvIGxpbXBpbyAocG9sdm8sIHBhbnRhbGxhLCB0ZWNsYWRvKSIKICAgICRyZXBvcnQgKz0gIiIKICAgICRyZXBvcnQgKz0gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iCiAgICAkcmVwb3J0ICs9ICIgIEZJTiBERUwgUkVQT1JURSIKICAgICRyZXBvcnQgKz0gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iCgogICAgIyBHdWFyZGFyCiAgICB0cnkgewogICAgICAgICRzdGFtcCA9IEdldC1EYXRlIC1Gb3JtYXQgJ3l5eXlNTWRkLUhIbW1zcycKICAgICAgICAkZGVza3RvcCA9IFtFbnZpcm9ubWVudF06OkdldEZvbGRlclBhdGgoJ0Rlc2t0b3AnKQogICAgICAgICRvdXQgPSBKb2luLVBhdGggJGRlc2t0b3AgImF0bGFzLWVudHJlZ2EtJCgkZW52OkNPTVBVVEVSTkFNRSktJHN0YW1wLnR4dCIKICAgICAgICBTZXQtQ29udGVudCAtUGF0aCAkb3V0IC1WYWx1ZSAkcmVwb3J0IC1FbmNvZGluZyBVVEY4CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgIFtPS10gUmVwb3J0ZSBndWFyZGFkbyBlbjoiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICBXcml0ZS1Ib3N0ICIgICAkb3V0IiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgdHJ5IHsgU3RhcnQtUHJvY2VzcyBub3RlcGFkLmV4ZSAkb3V0IH0gY2F0Y2gge30KICAgIH0gY2F0Y2ggewogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICBXcml0ZS1Ib3N0ICIgICBbRVJST1JdIE5vIHNlIHB1ZG8gZ3VhcmRhcjogJCgkXy5FeGNlcHRpb24uTWVzc2FnZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICB9CiAgICBSZWFkLUhvc3QgImBuICAgRU5URVIgcGFyYSB2b2x2ZXIiCn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBCVUNMRSBQUklOQ0lQQUwgREVMIE1FTsOaCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0Kd2hpbGUgKCR0cnVlKSB7CiAgICBNb3N0cmFyLUVuY2FiZXphZG8KCiAgICAkbDEgPSAiWyAxIF0gIEVudHJlZ2FyIGVxdWlwbyAoVXN1YXJpbyBhY3R1YWw6ICRlbnY6VVNFUk5BTUUpIgogICAgJGwyID0gIlsgMiBdICBDcmVhciB1biB1c3VhcmlvIG51ZXZvIGFkaWNpb25hbCIKICAgICRsMyA9ICJbIDMgXSAgUmVub21icmFyIGVxdWlwbyIKICAgICRsNCA9ICJbIDQgXSAgR2VuZXJhciBDSEVDS0xJU1QgREUgRU5UUkVHQSAocmVwb3J0ZSkiCiAgICAkbDUgPSAiWyA1IF0gIFNhbGlyIHkgY2VycmFyIGhlcnJhbWllbnRhIgoKICAgICRtYXhMZW4gPSBbbWF0aF06Ok1heCgkbDEuTGVuZ3RoLCBbbWF0aF06Ok1heCgkbDIuTGVuZ3RoLCBbbWF0aF06Ok1heCgkbDMuTGVuZ3RoLCBbbWF0aF06Ok1heCgkbDQuTGVuZ3RoLCAkbDUuTGVuZ3RoKSkpKQoKICAgIEVzY3JpYmlyLUNlbnRyYWRvICRsMS5QYWRSaWdodCgkbWF4TGVuKSAiV2hpdGUiCiAgICBFc2NyaWJpci1DZW50cmFkbyAkbDIuUGFkUmlnaHQoJG1heExlbikgIldoaXRlIgogICAgRXNjcmliaXItQ2VudHJhZG8gJGwzLlBhZFJpZ2h0KCRtYXhMZW4pICJXaGl0ZSIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICRsNC5QYWRSaWdodCgkbWF4TGVuKSAiR3JlZW4iCiAgICBFc2NyaWJpci1DZW50cmFkbyAkbDUuUGFkUmlnaHQoJG1heExlbikgIkRhcmtHcmF5IgogICAgV3JpdGUtSG9zdCAiIgoKICAgICR0ZXh0b1Byb21wdCA9ICJTZWxlY2Npb25lIHVuYSBvcGNpw7NuIFsxLTVdIgogICAgJGFuY2hvID0gJEhvc3QuVUkuUmF3VUkuV2luZG93U2l6ZS5XaWR0aAogICAgJGVzcGFjaW9zID0gIiAiICogKFttYXRoXTo6TWF4KDAsIFttYXRoXTo6Rmxvb3IoKCRhbmNobyAtICR0ZXh0b1Byb21wdC5MZW5ndGggLSAyKSAvIDIpKSkKICAgIFdyaXRlLUhvc3QgJGVzcGFjaW9zIC1Ob05ld2xpbmUKICAgICRvcGNpb24gPSBSZWFkLUhvc3QgJHRleHRvUHJvbXB0CgogICAgc3dpdGNoICgkb3BjaW9uKSB7CiAgICAgICAgJzEnIHsgTW9zdHJhci1FbmNhYmV6YWRvOyBNb2RpZmljYXItVXN1YXJpb0FjdHVhbCB9CiAgICAgICAgJzInIHsgTW9zdHJhci1FbmNhYmV6YWRvOyBDcmVhci1OdWV2b1VzdWFyaW8gfQogICAgICAgICczJyB7IE1vc3RyYXItRW5jYWJlemFkbzsgUmVub21icmFyLUVxdWlwbyB9CiAgICAgICAgJzQnIHsgTW9zdHJhci1FbmNhYmV6YWRvOyBHZW5lcmFyLUNoZWNrbGlzdEVudHJlZ2EgfQogICAgICAgICc1JyB7IENsZWFyLUhvc3Q7IGV4aXQgfQogICAgICAgIGRlZmF1bHQgeyBFc2NyaWJpci1DZW50cmFkbyAiT3BjacOzbiBubyB2w6FsaWRhLiIgIlJlZCI7IFN0YXJ0LVNsZWVwIC1zIDEgfQogICAgfQp9Cn0K'
$script:AtlasToolSources['Invoke-ExtraerLicencias'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtRXh0cmFlckxpY2VuY2lhcwojIE1pZ3JhZG8gZGU6IEVYVEFFUitMSUNFTkNJQVMucHMxCiMgQXRsYXMgUEMgU3VwcG9ydCDigJQgdjEuMAojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gSW52b2tlLUV4dHJhZXJMaWNlbmNpYXMgewogICAgW0NtZGxldEJpbmRpbmcoKV0KICAgIHBhcmFtKCkKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgU2NyaXB0OiBFeHRyYWN0b3IgZGUgTGljZW5jaWFzIEFUTEFTIHkgQXVkaXRvciAoRXN0YWJsZSkKIyBBcnF1aXRlY3R1cmE6IFBvd2VyU2hlbGwgKENvbXBhdGlibGUgdjIuMCspCiMgT2JqZXRpdm86IEV4dHJhY2Npw7NuIGRlIEJJT1MsIE9TIEFjdHVhbCB5IERldGVjY2nDs24gZGUgT3JpZ2luYWxpZGFkCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKPCMKLlNZTk9QU0lTCiAgICBGdWVyemEgbGEgZWxldmFjacOzbiBkZSBwcml2aWxlZ2lvcyBkZSBBZG1pbmlzdHJhZG9yIGRlIG1hbmVyYSBlc3RhYmxlLgojPgokRXJyb3JBY3Rpb25QcmVmZXJlbmNlID0gIlN0b3AiCgojIChhdXRvLWVsZXZhY2nDs24gZ2VzdGlvbmFkYSBwb3IgQXRsYXMgTGF1bmNoZXIpCgo8IwouU1lOT1BTSVMKICAgIEZ1bmNpb25lcyBkZSBpbnRlcmZheiBkZSB1c3VhcmlvIHBhcmEgYWxpbmVhY2nDs24geSBmb3JtYXRvIGVzdGFuZGFyaXphZG8uCiM+CiRIb3N0LlVJLlJhd1VJLldpbmRvd1RpdGxlID0gIkFUTEFTIFBDIFNVUFBPUlQgLSBIZXJyYW1pZW50YSBkZSBMaWNlbmNpYXMiCgpmdW5jdGlvbiBXcml0ZS1DZW50ZXJlZCB7CiAgICBwYXJhbSgKICAgICAgICBbc3RyaW5nXSRUZXh0LAogICAgICAgIFtDb25zb2xlQ29sb3JdJENvbG9yID0gJ1doaXRlJwogICAgKQogICAgJHdpbmRvd1dpZHRoID0gJEhvc3QuVUkuUmF3VUkuV2luZG93U2l6ZS5XaWR0aAogICAgaWYgKCR3aW5kb3dXaWR0aCAtZ3QgJFRleHQuTGVuZ3RoKSB7CiAgICAgICAgJHBhZGRpbmcgPSBbbWF0aF06Ok1heCgwLCBbbWF0aF06OkZsb29yKCgkd2luZG93V2lkdGggLSAkVGV4dC5MZW5ndGgpIC8gMikpCiAgICAgICAgJHNwYWNlcyA9ICIgIiAqICRwYWRkaW5nCiAgICAgICAgV3JpdGUtSG9zdCAiJHNwYWNlcyRUZXh0IiAtRm9yZWdyb3VuZENvbG9yICRDb2xvcgogICAgfSBlbHNlIHsKICAgICAgICBXcml0ZS1Ib3N0ICRUZXh0IC1Gb3JlZ3JvdW5kQ29sb3IgJENvbG9yCiAgICB9Cn0KCmZ1bmN0aW9uIFNob3ctSGVhZGVyIHsKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iIC1Db2xvciBZZWxsb3cKICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJBVExBUyBQQyBTVVBQT1JUIiAtQ29sb3IgWWVsbG93CiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgLUNvbG9yIFllbGxvdwogICAgV3JpdGUtSG9zdCAiYG4iCn0KCjwjCi5TWU5PUFNJUwogICAgT1BDScOTTiAxOiBFeHRyYWNjacOzbiBkZSBjbGF2ZSBpbnllY3RhZGEgZW4gcGxhY2EgYmFzZSAoQklPUy9VRUZJKQojPgpmdW5jdGlvbiBHZXQtQmlvc0tleSB7CiAgICBTaG93LUhlYWRlcgogICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIi0tLSBFWFRSQUNDScOTTiBERSBDTEFWRSBERSBCSU9TIChERSBGw4FCUklDQSkgLS0tIiAtQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiYG4iCiAgICAKICAgIHRyeSB7CiAgICAgICAgJHdtaVF1ZXJ5ID0gR2V0LVdtaU9iamVjdCAtUXVlcnkgJ3NlbGVjdCAqIGZyb20gU29mdHdhcmVMaWNlbnNpbmdTZXJ2aWNlJyAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICRiaW9zS2V5ID0gJHdtaVF1ZXJ5Lk9BM3hPcmlnaW5hbFByb2R1Y3RLZXkKICAgICAgICAkYmlvc0Rlc2MgPSAkd21pUXVlcnkuT0EzeE9yaWdpbmFsUHJvZHVjdEtleURlc2NyaXB0aW9uCgogICAgICAgIGlmIChbc3RyaW5nXTo6SXNOdWxsT3JXaGl0ZVNwYWNlKCRiaW9zS2V5KSkgewogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiWyFdIE5vIHNlIGVuY29udHLDsyBjbGF2ZSBPRU0gZW4gbGEgQklPUy9VRUZJLiIgLUNvbG9yIFJlZAogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiRXN0ZSBlcXVpcG8gbm8gdmlubyBjb24gV2luZG93cyBwcmVpbnN0YWxhZG8gZGUgZsOhYnJpY2EuIiAtQ29sb3IgR3JheQogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbK10gQ0xBVkUgQklPUyBFTkNPTlRSQURBOiIgLUNvbG9yIEdyZWVuCiAgICAgICAgICAgIGlmICgtbm90IFtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJGJpb3NEZXNjKSkgewogICAgICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIkVkaWNpw7NuIGRlIEbDoWJyaWNhOiAkYmlvc0Rlc2MiIC1Db2xvciBDeWFuCiAgICAgICAgICAgIH0KICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgJGJpb3NLZXkgLUNvbG9yIFllbGxvdwogICAgICAgICAgICAkYmlvc0tleSB8IGNsaXAKICAgICAgICAgICAgV3JpdGUtSG9zdCAiYG4iCiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICIoQ29waWFkYSBhbCBwb3J0YXBhcGVsZXMgZGUgbWFuZXJhIHNlZ3VyYSkiIC1Db2xvciBHcmF5CiAgICAgICAgfQogICAgfSBjYXRjaCB7CiAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIltYXSBFcnJvciBhbCBjb25zdWx0YXIgbGEgdGFibGEgQUNQSTogJCgkXy5FeGNlcHRpb24uTWVzc2FnZSkiIC1Db2xvciBSZWQKICAgIH0KICAgIAogICAgV3JpdGUtSG9zdCAiYG4iCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiUHJlc2lvbmUgRU5URVIgcGFyYSB2b2x2ZXIgYWwgbWVuw7ouLi4iIC1Db2xvciBXaGl0ZQogICAgJG51bGwgPSBSZWFkLUhvc3QKfQoKPCMKLlNZTk9QU0lTCiAgICBPUENJw5NOIDI6IEV4dHJhY2Npw7NuIGRlIGxhIGNsYXZlIGluc3RhbGFkYSBhY3R1YWxtZW50ZSAoUmVnaXN0cm8gQXZhbnphZG8gQmFzZTI0KQojPgpmdW5jdGlvbiBHZXQtQ3VycmVudEtleSB7CiAgICBTaG93LUhlYWRlcgogICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIi0tLSBFWFRSQUNDScOTTiBERSBDTEFWRSBBQ1RVQUwgKE9TIElOU1RBTEFETykgLS0tIiAtQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiYG4iCiAgICAKICAgIHRyeSB7CiAgICAgICAgIyAxLiBNb3N0cmFyIGxhIENsYXZlIGRlIGxhIEJJT1MgY29tbyByZWZlcmVuY2lhIGNydXphZGEKICAgICAgICAkc2xzID0gR2V0LVdtaU9iamVjdCAtUXVlcnkgJ3NlbGVjdCAqIGZyb20gU29mdHdhcmVMaWNlbnNpbmdTZXJ2aWNlJyAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgICAgICRiaW9zUmVmS2V5ID0gJHNscy5PQTN4T3JpZ2luYWxQcm9kdWN0S2V5CiAgICAgICAgJGJpb3NSZWZEZXNjID0gJHNscy5PQTN4T3JpZ2luYWxQcm9kdWN0S2V5RGVzY3JpcHRpb24KICAgICAgICAKICAgICAgICBpZiAoLW5vdCBbc3RyaW5nXTo6SXNOdWxsT3JXaGl0ZVNwYWNlKCRiaW9zUmVmS2V5KSkgewogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiWytdIENMQVZFIERFIEbDgUJSSUNBIChCSU9TKSBERSBSRUZFUkVOQ0lBOiIgLUNvbG9yIERhcmtDeWFuCiAgICAgICAgICAgIGlmICgtbm90IFtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJGJpb3NSZWZEZXNjKSkgewogICAgICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIkVkaWNpw7NuIGRlIEbDoWJyaWNhOiAkYmlvc1JlZkRlc2MiIC1Db2xvciBDeWFuCiAgICAgICAgICAgIH0KICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgJGJpb3NSZWZLZXkgLUNvbG9yIEdyYXkKICAgICAgICAgICAgV3JpdGUtSG9zdCAiYG4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tYG4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICB9CgogICAgICAgICMgMi4gQsO6c3F1ZWRhIGVuIGVsIFJlZ2lzdHJvIHBhcmEgZWwgT1MgQWN0dWFsCiAgICAgICAgJHJlZ1BhdGggPSAiSEtMTTpcU09GVFdBUkVcTWljcm9zb2Z0XFdpbmRvd3MgTlRcQ3VycmVudFZlcnNpb25cU29mdHdhcmVQcm90ZWN0aW9uUGxhdGZvcm0iCiAgICAgICAgJGJhY2t1cEtleSA9IChHZXQtSXRlbVByb3BlcnR5IC1QYXRoICRyZWdQYXRoIC1OYW1lIEJhY2t1cFByb2R1Y3RLZXlEZWZhdWx0IC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlKS5CYWNrdXBQcm9kdWN0S2V5RGVmYXVsdAoKICAgICAgICAkaGV4UGF0aCA9ICJIS0xNOlxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93cyBOVFxDdXJyZW50VmVyc2lvbiIKICAgICAgICAKICAgICAgICAjIENvcnJlY2Npw7NuOiBMZWVyIGVkaWNpw7NuIHJlYWwgZGVzZGUgV01JIHBhcmEgZXZpdGFyIGVsIGZhbHNvICJXaW5kb3dzIDEwIiBkZWwgcmVnaXN0cm8gZGUgV2luIDExCiAgICAgICAgJGN1cnJlbnRFZGl0aW9uID0gKEdldC1XbWlPYmplY3QgLUNsYXNzIFdpbjMyX09wZXJhdGluZ1N5c3RlbSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSkuQ2FwdGlvbiAtcmVwbGFjZSAnXk1pY3Jvc29mdFxzKycsICcnCiAgICAgICAgCiAgICAgICAgJGRpZ2l0YWxQcm9kdWN0SWQgPSAoR2V0LUl0ZW1Qcm9wZXJ0eSAtUGF0aCAkaGV4UGF0aCAtTmFtZSBEaWdpdGFsUHJvZHVjdElkIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlKS5EaWdpdGFsUHJvZHVjdElkCiAgICAgICAgCiAgICAgICAgJGRlY29kZWRLZXkgPSAkbnVsbAogICAgICAgICRpc0tNU09yRGlnaXRhbCA9ICRmYWxzZQoKICAgICAgICBpZiAoJGRpZ2l0YWxQcm9kdWN0SWQgLW5lICRudWxsIC1hbmQgJGRpZ2l0YWxQcm9kdWN0SWQuTGVuZ3RoIC1nZSA2NykgewogICAgICAgICAgICAkaXNXaW44T3IxMCA9IFttYXRoXTo6Rmxvb3IoJGRpZ2l0YWxQcm9kdWN0SWRbNjZdIC8gNikgLWJhbmQgMQogICAgICAgICAgICAkZGlnaXRhbFByb2R1Y3RJZFs2Nl0gPSAoJGRpZ2l0YWxQcm9kdWN0SWRbNjZdIC1iYW5kIDB4RjcpIC1iT3IgKCgkaXNXaW44T3IxMCAtYmFuZCAyKSAqIDQpCiAgICAgICAgICAgICRjaGFycyA9ICJCQ0RGR0hKS01QUVJUVldYWTIzNDY3ODkiCiAgICAgICAgICAgICRkZWNvZGVkS2V5U3RyID0gIiIKICAgICAgICAgICAgZm9yICgkaSA9IDI0OyAkaSAtZ2UgMDsgJGktLSkgewogICAgICAgICAgICAgICAgJGN1cnJlbnQgPSAwCiAgICAgICAgICAgICAgICBmb3IgKCRqID0gMTQ7ICRqIC1nZSAwOyAkai0tKSB7CiAgICAgICAgICAgICAgICAgICAgJGN1cnJlbnQgPSAkY3VycmVudCAqIDI1NiArICRkaWdpdGFsUHJvZHVjdElkWyRqICsgNTJdCiAgICAgICAgICAgICAgICAgICAgJGRpZ2l0YWxQcm9kdWN0SWRbJGogKyA1Ml0gPSBbbWF0aF06OkZsb29yKCRjdXJyZW50IC8gMjQpCiAgICAgICAgICAgICAgICAgICAgJGN1cnJlbnQgPSAkY3VycmVudCAlIDI0CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAkZGVjb2RlZEtleVN0ciA9ICRjaGFyc1skY3VycmVudF0gKyAkZGVjb2RlZEtleVN0cgogICAgICAgICAgICAgICAgJGxhc3QgPSAkY3VycmVudAogICAgICAgICAgICB9CiAgICAgICAgICAgIGlmICgkaXNXaW44T3IxMCAtZXEgMSkgewogICAgICAgICAgICAgICAgJGRlY29kZWRLZXlTdHIgPSAkZGVjb2RlZEtleVN0ci5TdWJzdHJpbmcoMSwgJGxhc3QpICsgIk4iICsgJGRlY29kZWRLZXlTdHIuU3Vic3RyaW5nKCRsYXN0ICsgMSkKICAgICAgICAgICAgfQogICAgICAgICAgICAkZGVjb2RlZEtleSA9ICRkZWNvZGVkS2V5U3RyLkluc2VydCg1LCAiLSIpLkluc2VydCgxMSwgIi0iKS5JbnNlcnQoMTcsICItIikuSW5zZXJ0KDIzLCAiLSIpCiAgICAgICAgICAgIAogICAgICAgICAgICBpZiAoJGRlY29kZWRLZXkgLWVxICJCQkJCQi1CQkJCQi1CQkJCQi1CQkJCQi1CQkJCQiIpIHsKICAgICAgICAgICAgICAgICRkZWNvZGVkS2V5ID0gJG51bGwKICAgICAgICAgICAgICAgICRpc0tNU09yRGlnaXRhbCA9ICR0cnVlCiAgICAgICAgICAgIH0KICAgICAgICB9CgogICAgICAgICRhY3RpdmVXbWkgPSBHZXQtV21pT2JqZWN0IC1RdWVyeSAiU0VMRUNUIFBhcnRpYWxQcm9kdWN0S2V5LCBEZXNjcmlwdGlvbiBGUk9NIFNvZnR3YXJlTGljZW5zaW5nUHJvZHVjdCBXSEVSRSBMaWNlbnNlU3RhdHVzID0gMSBBTkQgUGFydGlhbFByb2R1Y3RLZXkgSVMgTk9UIE5VTEwiIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlCgogICAgICAgIGlmICgkYWN0aXZlV21pKSB7CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbK10gRVZJREVOQ0lBIEVOIE1PVE9SIERFIEFDVElWQUNJw5NOICjDmk5JQ09TIERBVE9TIFJFQUxFUyk6IiAtQ29sb3IgQ3lhbgogICAgICAgICAgICBmb3JlYWNoICgkbGljIGluICRhY3RpdmVXbWkpIHsKICAgICAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJQYXJjaWFsOiAqKioqKiotKioqKioqLSoqKioqKi0qKioqKiotJCgkbGljLlBhcnRpYWxQcm9kdWN0S2V5KSIgLUNvbG9yIFdoaXRlCiAgICAgICAgICAgIH0KICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIH0KCiAgICAgICAgaWYgKC1ub3QgW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkY3VycmVudEVkaXRpb24pKSB7CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJFZGljacOzbiBJbnN0YWxhZGE6ICRjdXJyZW50RWRpdGlvbiIgLUNvbG9yIEN5YW4KICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIH0KCiAgICAgICAgaWYgKCRpc0tNU09yRGlnaXRhbCkgewogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiWyFdIEFMRVJUQSBUw4lDTklDQTogQ0xBVkUgT0NVTFRBIFBPUiBESVNFw5FPIiAtQ29sb3IgWWVsbG93CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJXaW5kb3dzIGhhIGJvcnJhZG8gbGEgY2xhdmUgZGVsIHJlZ2lzdHJvIHBvciBzZWd1cmlkYWQgY29ycG9yYXRpdmEuIiAtQ29sb3IgR3JheQogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiTGEgbGljZW5jaWEgZXMgTUFLIG8gRGlnaXRhbCB5IG5vIHJlc2lkZSBmw61zaWNhbWVudGUgZW4gZWwgZGlzY28uIiAtQ29sb3IgR3JheQogICAgICAgIH0gZWxzZWlmICgtbm90IFtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJGRlY29kZWRLZXkpKSB7CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbK10gQ0xBVkUgREVDT0RJRklDQURBIERFTCBSRUdJU1RSTzoiIC1Db2xvciBHcmVlbgogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAkZGVjb2RlZEtleSAtQ29sb3IgWWVsbG93CiAgICAgICAgICAgICRkZWNvZGVkS2V5IHwgY2xpcAogICAgICAgIH0KCiAgICAgICAgaWYgKC1ub3QgW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkYmFja3VwS2V5KSkgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbK10gQ0xBVkUgREUgUkVTUEFMRE8gRU5DT05UUkFEQToiIC1Db2xvciBEYXJrQ3lhbgogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAkYmFja3VwS2V5IC1Db2xvciBHcmF5CiAgICAgICAgfQoKICAgIH0gY2F0Y2ggewogICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbWF0gRXJyb3IgY3LDrXRpY28gZGUgZGVjb2RpZmljYWNpw7NuLiIgLUNvbG9yIFJlZAogICAgfQogICAgCiAgICBXcml0ZS1Ib3N0ICJgbiIKICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJQcmVzaW9uZSBFTlRFUiBwYXJhIHZvbHZlciBhbCBtZW7Dui4uLiIgLUNvbG9yIFdoaXRlCiAgICAkbnVsbCA9IFJlYWQtSG9zdAp9Cgo8IwouU1lOT1BTSVMKICAgIE9QQ0nDk04gMzogQXVkaXRvcsOtYSBuYXRpdmEgbWVkaWFudGUgU0xNR1IKIz4KZnVuY3Rpb24gSW52b2tlLU5hdGl2ZUF1ZGl0IHsKICAgIFNob3ctSGVhZGVyCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiLS0tIEFVRElUT1LDjUEgTkFUSVZBIERFTCBTSVNURU1BIChTTE1HUikgLS0tIiAtQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiYG4iCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiSW5pY2lhbmRvIGhlcnJhbWllbnRhIG9maWNpYWwgZGUgTWljcm9zb2Z0Li4uIiAtQ29sb3IgR3JheQogICAgCiAgICAjIEVqZWN1dGEgZWwgY29tYW5kbyBuYXRpdm8gZGUgV2luZG93cyBwYXJhIG1vc3RyYXIgaW5mb3JtYWNpw7NuIGRlIGxhIGxpY2VuY2lhCiAgICBjc2NyaXB0IC8vbm9sb2dvIEM6XFdpbmRvd3NcU3lzdGVtMzJcc2xtZ3IudmJzIC9kbGkKICAgIAogICAgV3JpdGUtSG9zdCAiYG4iCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiLS0tIEFOw4FMSVNJUyBERSBPUklHSU5BTElEQUQgLS0tIiAtQ29sb3IgQ3lhbgogICAgdHJ5IHsKICAgICAgICAkd21pID0gR2V0LVdtaU9iamVjdCAtUXVlcnkgIlNFTEVDVCBEZXNjcmlwdGlvbiwgTGljZW5zZVN0YXR1cyBGUk9NIFNvZnR3YXJlTGljZW5zaW5nUHJvZHVjdCBXSEVSRSBMaWNlbnNlU3RhdHVzID0gMSBBTkQgUGFydGlhbFByb2R1Y3RLZXkgSVMgTk9UIE5VTEwiCiAgICAgICAgZm9yZWFjaCAoJGl0ZW0gaW4gJHdtaSkgewogICAgICAgICAgICBpZiAoJGl0ZW0uRGVzY3JpcHRpb24gLW1hdGNoICJWT0xVTUVfS01TQ0xJRU5UIikgewogICAgICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIlshXSBERVRFQ1RBRE86IENBTkFMIEtNUyAoUG9zaWJsZSBhY3RpdmFjacOzbiBwb3IgZW11bGFkb3IpIiAtQ29sb3IgWWVsbG93CiAgICAgICAgICAgIH0gZWxzZWlmICgkaXRlbS5EZXNjcmlwdGlvbiAtbWF0Y2ggIlZPTFVNRV9NQUt8UkVUQUlMfE9FTSIpIHsKICAgICAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbK10gREVURUNUQURPOiBDQU5BTCBPUklHSU5BTCAoJCgkaXRlbS5EZXNjcmlwdGlvbiAtcmVwbGFjZSAnLiosICcsICcnKSkiIC1Db2xvciBHcmVlbgogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfSBjYXRjaCB7fQoKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIlByZXNpb25lIEVOVEVSIHBhcmEgdm9sdmVyIGFsIG1lbsO6Li4uIiAtQ29sb3IgV2hpdGUKICAgICRudWxsID0gUmVhZC1Ib3N0Cn0KCjwjCi5TWU5PUFNJUwogICAgT1BDScOTTiA0OiBJbmZvcm1hY2nDs24gZGUgU2lzdGVtYSAoSW5jbHV5ZSBDbGF2ZSBCSU9TLCBDbGF2ZSBBY3R1YWwgeSBBdWRpdG9yw61hIFZpc3VhbCkKIz4KZnVuY3Rpb24gR2V0LU9zSW5mbyB7CiAgICBTaG93LUhlYWRlcgogICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIi0tLSBJTkZPUk1BQ0nDk04gREVMIFNJU1RFTUEgT1BFUkFUSVZPIC0tLSIgLUNvbG9yIEN5YW4KICAgIFdyaXRlLUhvc3QgImBuIgogICAgCiAgICAjIFZhcmlhYmxlcyBwYXJhIGFsbWFjZW5hciBlbCByZXBvcnRlIGV4cG9ydGFibGUKICAgICRyZXBvcnRUeHQgPSAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PWByYG5BVExBUyBQQyBTVVBQT1JUIC0gUkVQT1JURSBERSBTSVNURU1BYHJgbj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT1gcmBuYHJgbiIKICAgICRyZXBvcnRIdG1sID0gIjxodG1sPjxoZWFkPjxtZXRhIGNoYXJzZXQ9J1VURi04Jz48dGl0bGU+UmVwb3J0ZSBBVExBUzwvdGl0bGU+PHN0eWxlPmJvZHl7Zm9udC1mYW1pbHk6J1NlZ29lIFVJJyxUYWhvbWEsc2Fucy1zZXJpZjtiYWNrZ3JvdW5kOiMxMjEyMTI7Y29sb3I6I2UwZTBlMDt0ZXh0LWFsaWduOmNlbnRlcn0gLmNvbnRhaW5lcnttYXgtd2lkdGg6NzAwcHg7bWFyZ2luOmF1dG87YmFja2dyb3VuZDojMWUxZTFlO3BhZGRpbmc6MjBweDtib3JkZXItcmFkaXVzOjEwcHg7Ym94LXNoYWRvdzowIDRweCA4cHggcmdiYSgwLDAsMCwwLjUpfSBoMntjb2xvcjojZjFjNDBmfSAub2t7Y29sb3I6IzJlY2M3MX0gLndhcm57Y29sb3I6I2YzOWMxMn0gLmluZm97Y29sb3I6IzM0OThkYjtmb250LXN0eWxlOml0YWxpYztmb250LXNpemU6MC45ZW07bWFyZ2luLXRvcDo1cHg7fTwvc3R5bGU+PC9oZWFkPjxib2R5PjxkaXYgY2xhc3M9J2NvbnRhaW5lcic+PGgyPkFUTEFTIFBDIFNVUFBPUlQ8YnI+PHNtYWxsPlJlcG9ydGUgZGUgTGljZW5jaWFzPC9zbWFsbD48L2gyPjxocj4iCgogICAgdHJ5IHsKICAgICAgICAjIE9idGVuZXIgZGF0b3MgZGVsIE9TCiAgICAgICAgJG9zID0gR2V0LVdtaU9iamVjdCAtQ2xhc3MgV2luMzJfT3BlcmF0aW5nU3lzdGVtCiAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIlNpc3RlbWE6ICQoJG9zLkNhcHRpb24pIiAtQ29sb3IgV2hpdGUKICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiVmVyc2nDs246ICQoJG9zLlZlcnNpb24pIiAtQ29sb3IgV2hpdGUKICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiQXJxdWl0ZWN0dXJhOiAkKCRvcy5PU0FyY2hpdGVjdHVyZSkiIC1Db2xvciBXaGl0ZQogICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJTZXJpZSBkZWwgT1M6ICQoJG9zLlNlcmlhbE51bWJlcikiIC1Db2xvciBXaGl0ZQogICAgICAgIAogICAgICAgICRyZXBvcnRUeHQgKz0gIi0tLSBTSVNURU1BIE9QRVJBVElWTyAtLS1gcmBuU2lzdGVtYTogJCgkb3MuQ2FwdGlvbilgcmBuVmVyc2nDs246ICQoJG9zLlZlcnNpb24pYHJgbkFycXVpdGVjdHVyYTogJCgkb3MuT1NBcmNoaXRlY3R1cmUpYHJgblNlcmllOiAkKCRvcy5TZXJpYWxOdW1iZXIpYHJgbmByYG4iCiAgICAgICAgJHJlcG9ydEh0bWwgKz0gIjxoMz5TSVNURU1BIE9QRVJBVElWTzwvaDM+PHA+U2lzdGVtYTogJCgkb3MuQ2FwdGlvbik8YnI+VmVyc2nDs246ICQoJG9zLlZlcnNpb24pPGJyPkFycXVpdGVjdHVyYTogJCgkb3MuT1NBcmNoaXRlY3R1cmUpPGJyPlNlcmllOiAkKCRvcy5TZXJpYWxOdW1iZXIpPC9wPjxocj4iCiAgICAgICAgCiAgICAgICAgV3JpdGUtSG9zdCAiYG4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tYG4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAKICAgICAgICAjIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogICAgICAgICMgT2J0ZW5lciBkYXRvcyBkZSBsYSBCSU9TIChQdW50byAxIGludGVncmFkbykKICAgICAgICAjIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICItLS0gQ0xBVkUgREUgRsOBQlJJQ0EgKEJJT1MvVUVGSSkgLS0tIiAtQ29sb3IgQ3lhbgogICAgICAgICRzbHMgPSBHZXQtV21pT2JqZWN0IC1RdWVyeSAnc2VsZWN0ICogZnJvbSBTb2Z0d2FyZUxpY2Vuc2luZ1NlcnZpY2UnCiAgICAgICAgJGJpb3NLZXkgPSAkc2xzLk9BM3hPcmlnaW5hbFByb2R1Y3RLZXkKICAgICAgICAkYmlvc0Rlc2MgPSAkc2xzLk9BM3hPcmlnaW5hbFByb2R1Y3RLZXlEZXNjcmlwdGlvbgogICAgICAgIAogICAgICAgICRyZXBvcnRUeHQgKz0gIi0tLSBDTEFWRSBERSBGw4FCUklDQSAoQklPUy9VRUZJKSAtLS1gcmBuIgogICAgICAgICRyZXBvcnRIdG1sICs9ICI8aDM+Q0xBVkUgREUgRsOBQlJJQ0EgKEJJT1MvVUVGSSk8L2gzPiIKCiAgICAgICAgaWYgKFtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJGJpb3NLZXkpKSB7CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJDbGF2ZSBCSU9TOiBObyBlbmNvbnRyYWRhIChFcXVpcG8gc2luIFdpbmRvd3MgZGUgZsOhYnJpY2EpIiAtQ29sb3IgR3JheQogICAgICAgICAgICAkcmVwb3J0VHh0ICs9ICJFc3RhZG86IE5vIGVuY29udHJhZGEuYHJgbmByYG4iCiAgICAgICAgICAgICRyZXBvcnRIdG1sICs9ICI8cD5Fc3RhZG86IE5vIGVuY29udHJhZGEuPC9wPjxocj4iCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgJGRlc2NUZXh0ID0gaWYgKFtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJGJpb3NEZXNjKSkgeyAiVmVyc2nDs24gRGVzY29ub2NpZGEiIH0gZWxzZSB7ICRiaW9zRGVzYyB9CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJWZXJzacOzbiBkZSBGw6FicmljYTogJGRlc2NUZXh0IiAtQ29sb3IgQ3lhbgogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiQ2xhdmUgQklPUzogJGJpb3NLZXkiIC1Db2xvciBHcmVlbgogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiW2ldIExFWUVOREE6IExhcyBjbGF2ZXMgaW55ZWN0YWRhcyBlbiBCSU9TIChPRU0pIHByb3ZpZW5lbiBkZWwiIC1Db2xvciBEYXJrQ3lhbgogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiZmFicmljYW50ZSBkZWwgZXF1aXBvIHkgc29uIGxpY2VuY2lhcyBnZW51aW5hcyBwb3IgbmF0dXJhbGV6YS4iIC1Db2xvciBEYXJrQ3lhbgoKICAgICAgICAgICAgJHJlcG9ydFR4dCArPSAiVmVyc2nDs24gZGUgRsOhYnJpY2E6ICRkZXNjVGV4dGByYG5DbGF2ZSBCSU9TOiAkYmlvc0tleWByYG5baV0gTEVZRU5EQTogTGFzIGNsYXZlcyBpbnllY3RhZGFzIGVuIEJJT1MgKE9FTSkgcHJvdmllbmVuIGRlbCBmYWJyaWNhbnRlIGRlbCBlcXVpcG8geSBzb24gbGljZW5jaWFzIGdlbnVpbmFzIHBvciBuYXR1cmFsZXphLmByYG5gcmBuIgogICAgICAgICAgICAkcmVwb3J0SHRtbCArPSAiPHA+VmVyc2nDs24gZGUgRsOhYnJpY2E6IDxzdHJvbmcgc3R5bGU9J2NvbG9yOiMzNDk4ZGInPiRkZXNjVGV4dDwvc3Ryb25nPjwvcD48cD5DbGF2ZSBCSU9TOiA8c3Ryb25nIGNsYXNzPSdvayc+JGJpb3NLZXk8L3N0cm9uZz48L3A+PHAgY2xhc3M9J2luZm8nPltpXSBMRVlFTkRBOiBMYXMgY2xhdmVzIGlueWVjdGFkYXMgZW4gQklPUyAoT0VNKSBwcm92aWVuZW4gZGVsIGZhYnJpY2FudGUgZGVsIGVxdWlwbyB5IHNvbiBsaWNlbmNpYXMgZ2VudWluYXMgcG9yIG5hdHVyYWxlemEuPC9wPjxocj4iCiAgICAgICAgfQogICAgICAgIAogICAgICAgIFdyaXRlLUhvc3QgImBuLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLWBuIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgICAgICMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAgICAgICAgIyBPYnRlbmVyIGRhdG9zIGRlIGxhIENsYXZlIEFjdHVhbCAoUHVudG8gMiBpbnRlZ3JhZG8pCiAgICAgICAgIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiLS0tIENMQVZFIEFDVFVBTCAoT1MgSU5TVEFMQURPKSAtLS0iIC1Db2xvciBDeWFuCiAgICAgICAgCiAgICAgICAgJHJlZ1BhdGggPSAiSEtMTTpcU09GVFdBUkVcTWljcm9zb2Z0XFdpbmRvd3MgTlRcQ3VycmVudFZlcnNpb25cU29mdHdhcmVQcm90ZWN0aW9uUGxhdGZvcm0iCiAgICAgICAgJGJhY2t1cEtleSA9IChHZXQtSXRlbVByb3BlcnR5IC1QYXRoICRyZWdQYXRoIC1OYW1lIEJhY2t1cFByb2R1Y3RLZXlEZWZhdWx0IC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlKS5CYWNrdXBQcm9kdWN0S2V5RGVmYXVsdAoKICAgICAgICAkaGV4UGF0aCA9ICJIS0xNOlxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93cyBOVFxDdXJyZW50VmVyc2lvbiIKICAgICAgICAKICAgICAgICAjIENvcnJlY2Npw7NuIFdNSToKICAgICAgICAkY3VycmVudEVkaXRpb24gPSAoR2V0LVdtaU9iamVjdCAtQ2xhc3MgV2luMzJfT3BlcmF0aW5nU3lzdGVtIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlKS5DYXB0aW9uIC1yZXBsYWNlICdeTWljcm9zb2Z0XHMrJywgJycKICAgICAgICAKICAgICAgICAkZGlnaXRhbFByb2R1Y3RJZCA9IChHZXQtSXRlbVByb3BlcnR5IC1QYXRoICRoZXhQYXRoIC1OYW1lIERpZ2l0YWxQcm9kdWN0SWQgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUpLkRpZ2l0YWxQcm9kdWN0SWQKICAgICAgICAKICAgICAgICAkZGVjb2RlZEtleSA9ICRudWxsCiAgICAgICAgJGlzS01TT3JEaWdpdGFsID0gJGZhbHNlCgogICAgICAgIGlmICgkZGlnaXRhbFByb2R1Y3RJZCAtbmUgJG51bGwgLWFuZCAkZGlnaXRhbFByb2R1Y3RJZC5MZW5ndGggLWdlIDY3KSB7CiAgICAgICAgICAgICRpc1dpbjhPcjEwID0gW21hdGhdOjpGbG9vcigkZGlnaXRhbFByb2R1Y3RJZFs2Nl0gLyA2KSAtYmFuZCAxCiAgICAgICAgICAgICRkaWdpdGFsUHJvZHVjdElkWzY2XSA9ICgkZGlnaXRhbFByb2R1Y3RJZFs2Nl0gLWJhbmQgMHhGNykgLWJPciAoKCRpc1dpbjhPcjEwIC1iYW5kIDIpICogNCkKICAgICAgICAgICAgJGNoYXJzID0gIkJDREZHSEpLTVBRUlRWV1hZMjM0Njc4OSIKICAgICAgICAgICAgJGRlY29kZWRLZXlTdHIgPSAiIgogICAgICAgICAgICBmb3IgKCRpID0gMjQ7ICRpIC1nZSAwOyAkaS0tKSB7CiAgICAgICAgICAgICAgICAkY3VycmVudCA9IDAKICAgICAgICAgICAgICAgIGZvciAoJGogPSAxNDsgJGogLWdlIDA7ICRqLS0pIHsKICAgICAgICAgICAgICAgICAgICAkY3VycmVudCA9ICRjdXJyZW50ICogMjU2ICsgJGRpZ2l0YWxQcm9kdWN0SWRbJGogKyA1Ml0KICAgICAgICAgICAgICAgICAgICAkZGlnaXRhbFByb2R1Y3RJZFskaiArIDUyXSA9IFttYXRoXTo6Rmxvb3IoJGN1cnJlbnQgLyAyNCkKICAgICAgICAgICAgICAgICAgICAkY3VycmVudCA9ICRjdXJyZW50ICUgMjQKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICRkZWNvZGVkS2V5U3RyID0gJGNoYXJzWyRjdXJyZW50XSArICRkZWNvZGVkS2V5U3RyCiAgICAgICAgICAgICAgICAkbGFzdCA9ICRjdXJyZW50CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKCRpc1dpbjhPcjEwIC1lcSAxKSB7CiAgICAgICAgICAgICAgICAkZGVjb2RlZEtleVN0ciA9ICRkZWNvZGVkS2V5U3RyLlN1YnN0cmluZygxLCAkbGFzdCkgKyAiTiIgKyAkZGVjb2RlZEtleVN0ci5TdWJzdHJpbmcoJGxhc3QgKyAxKQogICAgICAgICAgICB9CiAgICAgICAgICAgICRkZWNvZGVkS2V5ID0gJGRlY29kZWRLZXlTdHIuSW5zZXJ0KDUsICItIikuSW5zZXJ0KDExLCAiLSIpLkluc2VydCgxNywgIi0iKS5JbnNlcnQoMjMsICItIikKICAgICAgICAgICAgCiAgICAgICAgICAgIGlmICgkZGVjb2RlZEtleSAtZXEgIkJCQkJCLUJCQkJCLUJCQkJCLUJCQkJCLUJCQkJCIikgewogICAgICAgICAgICAgICAgJGRlY29kZWRLZXkgPSAkbnVsbAogICAgICAgICAgICAgICAgJGlzS01TT3JEaWdpdGFsID0gJHRydWUKICAgICAgICAgICAgfQogICAgICAgIH0KCiAgICAgICAgJHJlcG9ydFR4dCArPSAiLS0tIENMQVZFIEFDVFVBTCAoT1MgSU5TVEFMQURPKSAtLS1gcmBuIgogICAgICAgICRyZXBvcnRIdG1sICs9ICI8aDM+Q0xBVkUgQUNUVUFMIChPUyBJTlNUQUxBRE8pPC9oMz4iCgogICAgICAgICRlZFRleHQgPSBpZiAoW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkY3VycmVudEVkaXRpb24pKSB7ICJFZGljacOzbiBEZXNjb25vY2lkYSIgfSBlbHNlIHsgJGN1cnJlbnRFZGl0aW9uIH0KICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiRWRpY2nDs24gSW5zdGFsYWRhOiAkZWRUZXh0IiAtQ29sb3IgQ3lhbgogICAgICAgICRyZXBvcnRUeHQgKz0gIkVkaWNpw7NuIEluc3RhbGFkYTogJGVkVGV4dGByYG4iCiAgICAgICAgJHJlcG9ydEh0bWwgKz0gIjxwPkVkaWNpw7NuIEluc3RhbGFkYTogPHN0cm9uZyBzdHlsZT0nY29sb3I6IzM0OThkYic+JGVkVGV4dDwvc3Ryb25nPjwvcD4iCgogICAgICAgIGlmICgkaXNLTVNPckRpZ2l0YWwpIHsKICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIkNsYXZlIERlY29kaWZpY2FkYTogW09jdWx0YSBwb3Igc2VndXJpZGFkIGNvcnBvcmF0aXZhXSIgLUNvbG9yIFllbGxvdwogICAgICAgICAgICAkcmVwb3J0VHh0ICs9ICJFc3RhZG86IENsYXZlIGbDrXNpY2Egb2N1bHRhIChNQUsvS01TIG8gRGlnaXRhbCkuYHJgbiIKICAgICAgICAgICAgJHJlcG9ydEh0bWwgKz0gIjxwIGNsYXNzPSd3YXJuJz5Fc3RhZG86IENsYXZlIGbDrXNpY2Egb2N1bHRhIChNQUsvS01TIG8gRGlnaXRhbCkuPC9wPiIKICAgICAgICB9IGVsc2VpZiAoLW5vdCBbc3RyaW5nXTo6SXNOdWxsT3JXaGl0ZVNwYWNlKCRkZWNvZGVkS2V5KSkgewogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiQ2xhdmUgRGVjb2RpZmljYWRhOiAkZGVjb2RlZEtleSIgLUNvbG9yIEdyZWVuCiAgICAgICAgICAgICRyZXBvcnRUeHQgKz0gIkNsYXZlIERlY29kaWZpY2FkYTogJGRlY29kZWRLZXlgcmBuIgogICAgICAgICAgICAkcmVwb3J0SHRtbCArPSAiPHA+Q2xhdmUgRGVjb2RpZmljYWRhOiA8c3Ryb25nIGNsYXNzPSdvayc+JGRlY29kZWRLZXk8L3N0cm9uZz48L3A+IgogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJDbGF2ZSBEZWNvZGlmaWNhZGE6IE5vIGVuY29udHJhZGEiIC1Db2xvciBHcmF5CiAgICAgICAgICAgICRyZXBvcnRUeHQgKz0gIkNsYXZlIERlY29kaWZpY2FkYTogTm8gZW5jb250cmFkYWByYG4iCiAgICAgICAgICAgICRyZXBvcnRIdG1sICs9ICI8cD5DbGF2ZSBEZWNvZGlmaWNhZGE6IE5vIGVuY29udHJhZGE8L3A+IgogICAgICAgIH0KCiAgICAgICAgaWYgKC1ub3QgW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkYmFja3VwS2V5KSkgewogICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiQ2xhdmUgZGUgUmVzcGFsZG86ICRiYWNrdXBLZXkiIC1Db2xvciBEYXJrQ3lhbgogICAgICAgICAgICAkcmVwb3J0VHh0ICs9ICJDbGF2ZSBkZSBSZXNwYWxkbzogJGJhY2t1cEtleWByYG4iCiAgICAgICAgICAgICRyZXBvcnRIdG1sICs9ICI8cD5DbGF2ZSBkZSBSZXNwYWxkbzogPHN0cm9uZz4kYmFja3VwS2V5PC9zdHJvbmc+PC9wPiIKICAgICAgICB9CgogICAgICAgICRyZXBvcnRUeHQgKz0gImByYG4iCiAgICAgICAgJHJlcG9ydEh0bWwgKz0gIjxocj4iCiAgICAgICAgV3JpdGUtSG9zdCAiYG4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tYG4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKCiAgICAgICAgIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgICAgICAjIE9idGVuZXIgZGF0b3MgZGUgT3JpZ2luYWxpZGFkIFZpc3VhbCAoUHVudG8gMyBpbnRlZ3JhZG8pCiAgICAgICAgIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiLS0tIEFOw4FMSVNJUyBERSBPUklHSU5BTElEQUQgLS0tIiAtQ29sb3IgQ3lhbgogICAgICAgICR3bWlMaWMgPSBHZXQtV21pT2JqZWN0IC1RdWVyeSAiU0VMRUNUIERlc2NyaXB0aW9uLCBMaWNlbnNlU3RhdHVzIEZST00gU29mdHdhcmVMaWNlbnNpbmdQcm9kdWN0IFdIRVJFIExpY2Vuc2VTdGF0dXMgPSAxIEFORCBQYXJ0aWFsUHJvZHVjdEtleSBJUyBOT1QgTlVMTCIKICAgICAgICAKICAgICAgICAkcmVwb3J0VHh0ICs9ICItLS0gQU7DgUxJU0lTIERFIE9SSUdJTkFMSURBRCAtLS1gcmBuIgogICAgICAgICRyZXBvcnRIdG1sICs9ICI8aDM+QU7DgUxJU0lTIERFIE9SSUdJTkFMSURBRDwvaDM+IgoKICAgICAgICBpZiAoLW5vdCAkd21pTGljKSB7CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbIV0gTm8gc2UgZGV0ZWN0w7MgbmluZ3VuYSBsaWNlbmNpYSBhY3RpdmEgZW4gZWwgc2lzdGVtYS4iIC1Db2xvciBSZWQKICAgICAgICAgICAgJHJlcG9ydFR4dCArPSAiRXN0YWRvOiBTaW4gbGljZW5jaWEgYWN0aXZhLmByYG4iCiAgICAgICAgICAgICRyZXBvcnRIdG1sICs9ICI8cCBjbGFzcz0nd2Fybic+RXN0YWRvOiBTaW4gbGljZW5jaWEgYWN0aXZhLjwvcD4iCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgZm9yZWFjaCAoJGl0ZW0gaW4gJHdtaUxpYykgewogICAgICAgICAgICAgICAgJGNsZWFuRGVzYyA9ICRpdGVtLkRlc2NyaXB0aW9uIC1yZXBsYWNlICcuKiwgJywgJycKICAgICAgICAgICAgICAgIGlmICgkaXRlbS5EZXNjcmlwdGlvbiAtbWF0Y2ggIlZPTFVNRV9LTVNDTElFTlQiKSB7CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIlshXSBERVRFQ1RBRE86IENBTkFMIEtNUyAoJGNsZWFuRGVzYykiIC1Db2xvciBZZWxsb3cKICAgICAgICAgICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiW2ldIExFWUVOREE6IEFjdGl2YWNpw7NuIHBvciB2b2x1bWVuLiBTaSBlc3RlIGVxdWlwbyBubyBwZXJ0ZW5lY2UiIC1Db2xvciBEYXJrQ3lhbgogICAgICAgICAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJhIHVuYSBlbXByZXNhLCBlcyBtdXkgcHJvYmFibGUgcXVlIHNlIGhheWEgdXNhZG8gdW4gZW11bGFkb3IgKFBpcmF0YSkuIiAtQ29sb3IgRGFya0N5YW4KCiAgICAgICAgICAgICAgICAgICAgJHJlcG9ydFR4dCArPSAiWyFdIERFVEVDVEFETzogQ0FOQUwgS01TICgkY2xlYW5EZXNjKWByYG5baV0gTEVZRU5EQTogQWN0aXZhY2nDs24gcG9yIHZvbHVtZW4uIFNpIGVzdGUgZXF1aXBvIG5vIHBlcnRlbmVjZSBhIHVuYSBlbXByZXNhLCBlcyBtdXkgcHJvYmFibGUgcXVlIHNlIGhheWEgdXNhZG8gdW4gZW11bGFkb3IgKFBpcmF0YSkuYHJgbiIKICAgICAgICAgICAgICAgICAgICAkcmVwb3J0SHRtbCArPSAiPHAgY2xhc3M9J3dhcm4nPlshXSBERVRFQ1RBRE86IENBTkFMIEtNUyAoJGNsZWFuRGVzYyk8L3A+PHAgY2xhc3M9J2luZm8nPltpXSBMRVlFTkRBOiBBY3RpdmFjacOzbiBwb3Igdm9sdW1lbi4gU2kgZXN0ZSBlcXVpcG8gbm8gcGVydGVuZWNlIGEgdW5hIGVtcHJlc2EsIGVzIG11eSBwcm9iYWJsZSBxdWUgc2UgaGF5YSB1c2FkbyB1biBlbXVsYWRvciAoUGlyYXRhKS48L3A+IgogICAgICAgICAgICAgICAgfSBlbHNlaWYgKCRpdGVtLkRlc2NyaXB0aW9uIC1tYXRjaCAiVk9MVU1FX01BS3xSRVRBSUx8T0VNIikgewogICAgICAgICAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbK10gREVURUNUQURPOiBDQU5BTCBPUklHSU5BTCAoJGNsZWFuRGVzYykiIC1Db2xvciBHcmVlbgogICAgICAgICAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbaV0gTEVZRU5EQTogU2UgaGEgY29tcHJvYmFkbyBjb24gZWwgbW90b3IgZGUgbGljZW5jaWFzIGRlIFdpbmRvd3MiIC1Db2xvciBEYXJrQ3lhbgogICAgICAgICAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJxdWUgZWwgY2FuYWwgYWN0dWFsIGVzIG9maWNpYWwgeSBzZSBlbmN1ZW50cmEgQUNUSVZBRE8gbGVnYWxtZW50ZS4iIC1Db2xvciBEYXJrQ3lhbgoKICAgICAgICAgICAgICAgICAgICAkcmVwb3J0VHh0ICs9ICJbK10gREVURUNUQURPOiBDQU5BTCBPUklHSU5BTCAoJGNsZWFuRGVzYylgcmBuW2ldIExFWUVOREE6IFNlIGhhIGNvbXByb2JhZG8gY29uIGVsIG1vdG9yIGRlIGxpY2VuY2lhcyBkZSBXaW5kb3dzIHF1ZSBlbCBjYW5hbCBhY3R1YWwgZXMgb2ZpY2lhbCB5IHNlIGVuY3VlbnRyYSBBQ1RJVkFETyBsZWdhbG1lbnRlLmByYG4iCiAgICAgICAgICAgICAgICAgICAgJHJlcG9ydEh0bWwgKz0gIjxwIGNsYXNzPSdvayc+WytdIERFVEVDVEFETzogQ0FOQUwgT1JJR0lOQUwgKCRjbGVhbkRlc2MpPC9wPjxwIGNsYXNzPSdpbmZvJz5baV0gTEVZRU5EQTogU2UgaGEgY29tcHJvYmFkbyBjb24gZWwgbW90b3IgZGUgbGljZW5jaWFzIGRlIFdpbmRvd3MgcXVlIGVsIGNhbmFsIGFjdHVhbCBlcyBvZmljaWFsIHkgc2UgZW5jdWVudHJhIEFDVElWQURPIGxlZ2FsbWVudGUuPC9wPiIKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIls/XSBERVRFQ1RBRE86IENBTkFMIERFU0NPTk9DSURPICgkY2xlYW5EZXNjKSIgLUNvbG9yIEdyYXkKICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAkcmVwb3J0VHh0ICs9ICJbP10gREVURUNUQURPOiBDQU5BTCBERVNDT05PQ0lETyAoJGNsZWFuRGVzYylgcmBuIgogICAgICAgICAgICAgICAgICAgICRyZXBvcnRIdG1sICs9ICI8cD5bP10gREVURUNUQURPOiBDQU5BTCBERVNDT05PQ0lETyAoJGNsZWFuRGVzYyk8L3A+IgogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgICRyZXBvcnRIdG1sICs9ICI8L2Rpdj48L2JvZHk+PC9odG1sPiIKICAgICAgICAKICAgIH0gY2F0Y2ggewogICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbWF0gRXJyb3IgYWwgb2J0ZW5lciBpbmZvcm1hY2nDs24gZGVsIHNpc3RlbWEuIiAtQ29sb3IgUmVkCiAgICB9CiAgICAKICAgICMgTWVuw7ogZGUgRXhwb3J0YWNpw7NuCiAgICBXcml0ZS1Ib3N0ICJgbi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1gbiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIi0tLSBFWFBPUlRBUiBFU1RFIFJFUE9SVEUgLS0tIiAtQ29sb3IgWWVsbG93CiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiWyAxIF0gR3VhcmRhciBjb21vIERvY3VtZW50byBkZSBUZXh0byAoLnR4dCkiIC1Db2xvciBXaGl0ZQogICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIlsgMiBdIEd1YXJkYXIgY29tbyBQw6FnaW5hIFdlYiAoLmh0bWwpIiAtQ29sb3IgV2hpdGUKICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbIDAgXSBWb2x2ZXIgYWwgbWVuw7ogc2luIGd1YXJkYXIiIC1Db2xvciBSZWQKICAgIFdyaXRlLUhvc3QgImBuIgoKICAgICRleHBvcnRMb29wID0gJHRydWUKICAgIHdoaWxlICgkZXhwb3J0TG9vcCkgewogICAgICAgICRleHBTZWwgPSBSZWFkLUhvc3QgIiBTZWxlY2Npb25lIHVuYSBvcGNpw7NuIgogICAgICAgICRkZXNrdG9wUGF0aCA9IFtFbnZpcm9ubWVudF06OkdldEZvbGRlclBhdGgoIkRlc2t0b3AiKQogICAgICAgIAogICAgICAgIHN3aXRjaCAoJGV4cFNlbCkgewogICAgICAgICAgICAnMScgewogICAgICAgICAgICAgICAgJG91dFBhdGggPSAiJGRlc2t0b3BQYXRoXEFUTEFTX1JlcG9ydGVfTGljZW5jaWFzLnR4dCIKICAgICAgICAgICAgICAgIFtTeXN0ZW0uSU8uRmlsZV06OldyaXRlQWxsVGV4dCgkb3V0UGF0aCwgJHJlcG9ydFR4dCkKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgImBuIgogICAgICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIlsrXSBHdWFyZGFkbyBjb24gw6l4aXRvIGVuIHN1IEVzY3JpdG9yaW86IiAtQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJBVExBU19SZXBvcnRlX0xpY2VuY2lhcy50eHQiIC1Db2xvciBHcmF5CiAgICAgICAgICAgICAgICAkZXhwb3J0TG9vcCA9ICRmYWxzZQogICAgICAgICAgICB9CiAgICAgICAgICAgICcyJyB7CiAgICAgICAgICAgICAgICAkb3V0UGF0aCA9ICIkZGVza3RvcFBhdGhcQVRMQVNfUmVwb3J0ZV9MaWNlbmNpYXMuaHRtbCIKICAgICAgICAgICAgICAgIFtTeXN0ZW0uSU8uRmlsZV06OldyaXRlQWxsVGV4dCgkb3V0UGF0aCwgJHJlcG9ydEh0bWwsIFtTeXN0ZW0uVGV4dC5FbmNvZGluZ106OlVURjgpCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbiIKICAgICAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkIC1UZXh0ICJbK10gR3VhcmRhZG8gY29uIMOpeGl0byBlbiBzdSBFc2NyaXRvcmlvOiIgLUNvbG9yIEdyZWVuCiAgICAgICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiQVRMQVNfUmVwb3J0ZV9MaWNlbmNpYXMuaHRtbCIgLUNvbG9yIEdyYXkKICAgICAgICAgICAgICAgICRleHBvcnRMb29wID0gJGZhbHNlCiAgICAgICAgICAgIH0KICAgICAgICAgICAgJzAnIHsKICAgICAgICAgICAgICAgICRleHBvcnRMb29wID0gJGZhbHNlCiAgICAgICAgICAgIH0KICAgICAgICAgICAgZGVmYXVsdCB7CiAgICAgICAgICAgICAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiWyFdIFNlbGVjY2nDs24gaW52w6FsaWRhLiBJbnRlbnRlIG51ZXZhbWVudGUuIiAtQ29sb3IgUmVkCiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9CgogICAgV3JpdGUtSG9zdCAiYG4iCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiUHJlc2lvbmUgRU5URVIgcGFyYSB2b2x2ZXIgYWwgbWVuw7ogcHJpbmNpcGFsLi4uIiAtQ29sb3IgV2hpdGUKICAgICRudWxsID0gUmVhZC1Ib3N0Cn0KCiMgQnVjbGUgcHJpbmNpcGFsCiRtZW51TG9vcCA9ICR0cnVlCndoaWxlICgkbWVudUxvb3ApIHsKICAgIFNob3ctSGVhZGVyCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiTSBFIE4gVSAgIFAgUiBJIE4gQyBJIFAgQSBMIiAtQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiYG4iCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiWyAxIF0gRXh0cmFlciBDbGF2ZSBkZSBGw6FicmljYSAoQklPUy9VRUZJKSIgLUNvbG9yIFdoaXRlCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiWyAyIF0gRXh0cmFlciB5IERpYWdub3N0aWNhciBDbGF2ZSBBY3R1YWwgKFJlZ2lzdHJvKSIgLUNvbG9yIFdoaXRlCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiWyAzIF0gQXVkaXRvcsOtYSBOYXRpdmEgeSBPcmlnaW5hbGlkYWQgKFNMTUdSKSIgLUNvbG9yIFdoaXRlCiAgICBXcml0ZS1DZW50ZXJlZCAtVGV4dCAiWyA0IF0gUmVwb3J0ZSBDb21wbGV0byAoT1MsIEJJT1MsIEFjdHVhbCB5IE9yaWdpbmFsaWRhZCkiIC1Db2xvciBXaGl0ZQogICAgV3JpdGUtQ2VudGVyZWQgLVRleHQgIlsgMCBdIFNhbGlyIiAtQ29sb3IgUmVkCiAgICBXcml0ZS1Ib3N0ICJgbiIKICAgIAogICAgJHNlbGVjdGlvbiA9IFJlYWQtSG9zdCAiIFNlbGVjY2lvbmUgdW5hIG9wY2nDs24iCiAgICAKICAgIHN3aXRjaCAoJHNlbGVjdGlvbikgewogICAgICAgICcxJyB7IEdldC1CaW9zS2V5IH0KICAgICAgICAnMicgeyBHZXQtQ3VycmVudEtleSB9CiAgICAgICAgJzMnIHsgSW52b2tlLU5hdGl2ZUF1ZGl0IH0KICAgICAgICAnNCcgeyBHZXQtT3NJbmZvIH0KICAgICAgICAnMCcgeyAkbWVudUxvb3AgPSAkZmFsc2UgfQogICAgfQp9Cn0K'
$script:AtlasToolSources['Invoke-Fase0'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtRmFzZTAKIyBNaWdyYWRvIGRlOiBGYXNlKzAucHMxCiMgQXRsYXMgUEMgU3VwcG9ydCDigJQgdjEuMAojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gSW52b2tlLUZhc2UwIHsKICAgIFtDbWRsZXRCaW5kaW5nKCldCiAgICBwYXJhbSgpCjwjCiAgICAuU1lOT1BTSVMKICAgIEFUTEFTIFBDIFNVUFBPUlQgLSBGQVNFIDA6IElQdjYgSGFyZGVuaW5nIFRvb2wgdjQuMCAoU21hcnQgQ3VzdG9tIExvZykKIz4KCiMgLS0tIDEuIENPTkZJR1VSQUNJw5NOIElOSUNJQUwgLS0tCltDb25zb2xlXTo6T3V0cHV0RW5jb2RpbmcgPSBbU3lzdGVtLlRleHQuRW5jb2RpbmddOjpVVEY4CgokQXRsYXNPcmFuZ2UgPSAiJChbY2hhcl0weDFiKVszODsyOzI1NTsxMDI7MG0iCiRBdGxhc1doaXRlICA9ICIkKFtjaGFyXTB4MWIpWzM4OzI7MjU1OzI1NTsyNTVtIgokQXRsYXNHcmF5ICAgPSAiJChbY2hhcl0weDFiKVszODsyOzEwMDsxMDA7MTAwbSIKJEF0bGFzR3JlZW4gID0gIiQoW2NoYXJdMHgxYilbMzg7MjswOzI1NTswbSIKJEF0bGFzUmVkICAgID0gIiQoW2NoYXJdMHgxYilbMzg7MjsyNTU7NTA7NTBtIgokUmVzZXQgICAgICAgPSAiJChbY2hhcl0weDFiKVswbSIKCiRIb3N0LlVJLlJhd1VJLkJhY2tncm91bmRDb2xvciA9ICJCbGFjayIKQ2xlYXItSG9zdAoKIyBWYXJpYWJsZXMgZ2xvYmFsZXMgcGFyYSBlbCBzaXN0ZW1hIGRlIGxvZ3MKJGdsb2JhbDpJc0xvZ2dpbmcgPSAkZmFsc2UgCiRnbG9iYWw6TG9nRmlsZSA9ICIiCgojIC0tLSAyLiBBVVRPLUVMRVZBQ0nDk04gQSBBRE1JTklTVFJBRE9SIC0tLQojIChhdXRvLWVsZXZhY2nDs24gZ2VzdGlvbmFkYSBwb3IgQXRsYXMgTGF1bmNoZXIpCgojIC0tLSAzLiBGVU5DSU9ORVMgVklTVUFMRVMgLS0tCmZ1bmN0aW9uIFdyaXRlLUNlbnRlcmVkIHsKICAgIHBhcmFtKFtzdHJpbmddJFRleHQsIFtzdHJpbmddJENvbG9yID0gJEF0bGFzV2hpdGUpCiAgICAkV2luZG93V2lkdGggPSAkSG9zdC5VSS5SYXdVSS5XaW5kb3dTaXplLldpZHRoCiAgICAkUGFkZGluZyA9IFttYXRoXTo6TWF4KDAsIFtpbnRdKCgkV2luZG93V2lkdGggLSAkVGV4dC5MZW5ndGgpIC8gMikpCiAgICAkTGVmdFNwYWNlcyA9ICIgIiAqICRQYWRkaW5nCiAgICBXcml0ZS1Ib3N0ICIkTGVmdFNwYWNlcyRDb2xvciRUZXh0JFJlc2V0Igp9CgpmdW5jdGlvbiBTaG93LUhlYWRlciB7CiAgICBDbGVhci1Ib3N0CiAgICBXcml0ZS1Ib3N0ICJgbmBuYG4iCiAgICBXcml0ZS1DZW50ZXJlZCAiQVRMQVMgUEMgU1VQUE9SVCIgJEF0bGFzT3JhbmdlCiAgICBXcml0ZS1DZW50ZXJlZCAiU0VHVVJJREFEIEZBU0UgMCIgJEF0bGFzV2hpdGUKICAgIFdyaXRlLUNlbnRlcmVkICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgJEF0bGFzR3JheQogICAgCiAgICBpZiAoJGdsb2JhbDpJc0xvZ2dpbmcpIHsKICAgICAgICBXcml0ZS1DZW50ZXJlZCAiWyBSRUMgXSBCSVTDgUNPUkEgQUNUSVZBIiAkQXRsYXNSZWQKICAgIH0gZWxzZSB7CiAgICAgICAgV3JpdGUtQ2VudGVyZWQgIlsgICBdIEJJVMOBQ09SQSBJTkFDVElWQSIgJEF0bGFzR3JheQogICAgfQogICAgV3JpdGUtSG9zdCAiYG5gbiIKfQoKIyAtLS0gNC4gTU9UT1IgREUgTE9HUyBQRVJTT05BTElaQURPIC0tLQpmdW5jdGlvbiBXcml0ZS1BdGxhc0xvZyB7CiAgICBwYXJhbShbc3RyaW5nXSRNZXNzYWdlKQogICAgIyBTb2xvIGVzY3JpYmUgZW4gZWwgYXJjaGl2byBzaSBsYSBiaXTDoWNvcmEgZXN0w6EgYWN0aXZhCiAgICBpZiAoJGdsb2JhbDpJc0xvZ2dpbmcgLWFuZCAkZ2xvYmFsOkxvZ0ZpbGUpIHsKICAgICAgICAkVGltZXN0YW1wID0gR2V0LURhdGUgLUZvcm1hdCAiSEg6bW06c3MiCiAgICAgICAgIlskVGltZXN0YW1wXSAkTWVzc2FnZSIgfCBPdXQtRmlsZSAtRmlsZVBhdGggJGdsb2JhbDpMb2dGaWxlIC1BcHBlbmQgLUVuY29kaW5nIFVURjgKICAgIH0KfQoKZnVuY3Rpb24gU3RhcnQtQXRsYXNMb2cgewogICAgaWYgKCRnbG9iYWw6SXNMb2dnaW5nKSB7CiAgICAgICAgU2hvdy1IZWFkZXI7IFdyaXRlLUNlbnRlcmVkICJMYSBiaXTDoWNvcmEgeWEgZXN0w6EgaW5pY2lhZGEuIiAkQXRsYXNPcmFuZ2U7IFN0YXJ0LVNsZWVwIC1TZWNvbmRzIDI7IHJldHVybgogICAgfQoKICAgICREZXNrdG9wUGF0aCA9IFtFbnZpcm9ubWVudF06OkdldEZvbGRlclBhdGgoIkRlc2t0b3AiKQogICAgJExvZ0ZvbGRlciA9IEpvaW4tUGF0aCAtUGF0aCAkRGVza3RvcFBhdGggLUNoaWxkUGF0aCAiQVRMQVNfU1VQUE9SVCIKICAgIGlmICgtbm90IChUZXN0LVBhdGggLVBhdGggJExvZ0ZvbGRlcikpIHsgTmV3LUl0ZW0gLUl0ZW1UeXBlIERpcmVjdG9yeSAtUGF0aCAkTG9nRm9sZGVyIC1Gb3JjZSB8IE91dC1OdWxsIH0KICAgIAogICAgJFRpbWVTdHJpbmcgPSBHZXQtRGF0ZSAtRm9ybWF0ICJ5eXl5TU1kZF9ISG1tc3MiCiAgICAkZ2xvYmFsOkxvZ0ZpbGUgPSBKb2luLVBhdGggLVBhdGggJExvZ0ZvbGRlciAtQ2hpbGRQYXRoICJSZXBvcnRlX0Zhc2UwXyRUaW1lU3RyaW5nLnR4dCIKICAgICRnbG9iYWw6SXNMb2dnaW5nID0gJHRydWUKICAgIAogICAgIyBFc2NyaWJpciBlbmNhYmV6YWRvIHByb2Zlc2lvbmFsIGVuIGVsIGFyY2hpdm8gZGUgdGV4dG8KICAgICRSZXBvcnRIZWFkZXIgPSAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT1gbiIgKwogICAgICAgICAgICAgICAgICAgICIgQVRMQVMgUEMgU1VQUE9SVCAtIFJFUE9SVEUgVMOJQ05JQ09gbiIgKwogICAgICAgICAgICAgICAgICAgICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PWBuIiArCiAgICAgICAgICAgICAgICAgICAgIkZlY2hhIGRlIGluaWNpbyA6ICQoR2V0LURhdGUgLUZvcm1hdCAnZGQvTU0veXl5eSBISDptbTpzcycpYG4iICsKICAgICAgICAgICAgICAgICAgICAiRXF1aXBvIENsaWVudGUgIDogJGVudjpDT01QVVRFUk5BTUVgbiIgKwogICAgICAgICAgICAgICAgICAgICJVc3VhcmlvICAgICAgICAgOiAkZW52OlVTRVJOQU1FYG4iICsKICAgICAgICAgICAgICAgICAgICAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT1gbiIKICAgICRSZXBvcnRIZWFkZXIgfCBPdXQtRmlsZSAtRmlsZVBhdGggJGdsb2JhbDpMb2dGaWxlIC1FbmNvZGluZyBVVEY4CiAgICAKICAgIFNob3ctSGVhZGVyCiAgICBXcml0ZS1DZW50ZXJlZCAiQml0w6Fjb3JhIGluaWNpYWRhIGNvcnJlY3RhbWVudGUuIiAkQXRsYXNHcmVlbgogICAgU3RhcnQtU2xlZXAgLVNlY29uZHMgMQp9CgpmdW5jdGlvbiBTdG9wLUF0bGFzTG9nIHsKICAgIGlmICgtbm90ICRnbG9iYWw6SXNMb2dnaW5nKSB7IHJldHVybiB9CiAgICAKICAgIFdyaXRlLUF0bGFzTG9nICItLS0gQ0lFUlJFIERFIFNFU0nDk04gLS0tIgogICAgJGdsb2JhbDpJc0xvZ2dpbmcgPSAkZmFsc2UKICAgIAogICAgU2hvdy1IZWFkZXIKICAgIFdyaXRlLUNlbnRlcmVkICJSZXBvcnRlIGd1YXJkYWRvIGV4aXRvc2FtZW50ZS4iICRBdGxhc0dyZWVuCiAgICBTdGFydC1TbGVlcCAtU2Vjb25kcyAxCn0KCiMgLS0tIDUuIEZVTkNJT05FUyBERSBMw5NHSUNBIENPTiBMT0dTIC0tLQpmdW5jdGlvbiBIYXJkZW5pbmctQXBwbHkgewogICAgU2hvdy1IZWFkZXIKICAgIFdyaXRlLUNlbnRlcmVkICJbIEFQTElDQU5ETyBQUk9UT0NPTE8gREUgQkxJTkRBSkUgXSIgJEF0bGFzV2hpdGUKICAgIFdyaXRlLUhvc3QgImBuIgogICAgCiAgICBXcml0ZS1BdGxhc0xvZyAiLT4gSU5JQ0lBTkRPIFBST1RPQ09MTyBERSBCTElOREFKRSAoRkFTRSAwKSIKCiAgICBXcml0ZS1DZW50ZXJlZCAiRGVzYWN0aXZhbmRvIFRlcmVkbyBUdW5uZWxpbmcuLi4gW09LXSIgJEF0bGFzR3JlZW4KICAgIFdyaXRlLUF0bGFzTG9nICJbRUpFQ1VUQU5ET10gRGVzYWN0aXZhbmRvIFRlcmVkbyBUdW5uZWxpbmcuLi4iCiAgICAkcmVzMSA9IG5ldHNoIGludGVyZmFjZSB0ZXJlZG8gc2V0IHN0YXRlIGRpc2FibGVkCiAgICBXcml0ZS1BdGxhc0xvZyAiUmVzdWx0YWRvOiAkcmVzMSIKICAgIAogICAgV3JpdGUtQ2VudGVyZWQgIkRlc2FjdGl2YW5kbyA2dG80IEludGVyZmFjZS4uLiBbT0tdIiAkQXRsYXNHcmVlbgogICAgV3JpdGUtQXRsYXNMb2cgIltFSkVDVVRBTkRPXSBEZXNhY3RpdmFuZG8gNnRvNCBJbnRlcmZhY2UuLi4iCiAgICAkcmVzMiA9IG5ldHNoIGludGVyZmFjZSBpcHY2IDZ0bzQgc2V0IHN0YXRlIHN0YXRlPWRpc2FibGVkIHVuZG9vbnN0b3A9ZGlzYWJsZWQKICAgIFdyaXRlLUF0bGFzTG9nICJSZXN1bHRhZG86ICRyZXMyIgoKICAgIFdyaXRlLUNlbnRlcmVkICJEZXNhY3RpdmFuZG8gSVNBVEFQIFR1bm5lbGluZy4uLiBbT0tdIiAkQXRsYXNHcmVlbgogICAgV3JpdGUtQXRsYXNMb2cgIltFSkVDVVRBTkRPXSBEZXNhY3RpdmFuZG8gSVNBVEFQIFR1bm5lbGluZy4uLiIKICAgICRyZXMzID0gbmV0c2ggaW50ZXJmYWNlIGlwdjYgaXNhdGFwIHNldCBzdGF0ZSBzdGF0ZT1kaXNhYmxlZAogICAgV3JpdGUtQXRsYXNMb2cgIlJlc3VsdGFkbzogJHJlczMiCgogICAgV3JpdGUtQXRsYXNMb2cgIi0+IEZBU0UgMCBDT01QTEVUQURBIENPTiDDiVhJVE8uIgoKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgIkZBU0UgMCBDT01QTEVUQURBLiIgJEF0bGFzT3JhbmdlCiAgICBXcml0ZS1Ib3N0ICJgbiIKICAgIFdyaXRlLUNlbnRlcmVkICJbIFByZXNpb25hIGN1YWxxdWllciB0ZWNsYSBwYXJhIHZvbHZlciBdIiAkQXRsYXNHcmF5CiAgICAkbnVsbCA9ICRIb3N0LlVJLlJhd1VJLlJlYWRLZXkoIk5vRWNobyxJbmNsdWRlS2V5RG93biIpCn0KCmZ1bmN0aW9uIFJlc3RvcmUtRGVmYXVsdHMgewogICAgU2hvdy1IZWFkZXIKICAgIFdyaXRlLUNlbnRlcmVkICJbIFJFU1RBVVJBTkRPIFZBTE9SRVMgREUgRsOBQlJJQ0EgXSIgJEF0bGFzUmVkCiAgICBXcml0ZS1Ib3N0ICJgbiIKCiAgICBXcml0ZS1BdGxhc0xvZyAiLT4gUkVWSVJUSUVORE8gQ0FNQklPUyAoUkVTVEFVUkFDScOTTiBERSBGw4FCUklDQSkiCgogICAgV3JpdGUtQ2VudGVyZWQgIlJlc3RhdXJhbmRvIFRlcmVkby4uLiBbT0tdIiAkQXRsYXNXaGl0ZQogICAgJHJlczEgPSBuZXRzaCBpbnRlcmZhY2UgdGVyZWRvIHNldCBzdGF0ZSB0eXBlPWRlZmF1bHQKICAgIFdyaXRlLUF0bGFzTG9nICJbRUpFQ1VUQU5ET10gUmVzdGF1cmFuZG8gVGVyZWRvLi4uIFJlc3VsdGFkbzogJHJlczEiCgogICAgV3JpdGUtQ2VudGVyZWQgIlJlc3RhdXJhbmRvIDZ0bzQuLi4gW09LXSIgJEF0bGFzV2hpdGUKICAgICRyZXMyID0gbmV0c2ggaW50ZXJmYWNlIGlwdjYgNnRvNCBzZXQgc3RhdGUgc3RhdGU9ZW5hYmxlZAogICAgV3JpdGUtQXRsYXNMb2cgIltFSkVDVVRBTkRPXSBSZXN0YXVyYW5kbyA2dG80Li4uIFJlc3VsdGFkbzogJHJlczIiCgogICAgV3JpdGUtQ2VudGVyZWQgIlJlc3RhdXJhbmRvIElTQVRBUC4uLiBbT0tdIiAkQXRsYXNXaGl0ZQogICAgJHJlczMgPSBuZXRzaCBpbnRlcmZhY2UgaXB2NiBpc2F0YXAgc2V0IHN0YXRlIHN0YXRlPWVuYWJsZWQKICAgIFdyaXRlLUF0bGFzTG9nICJbRUpFQ1VUQU5ET10gUmVzdGF1cmFuZG8gSVNBVEFQLi4uIFJlc3VsdGFkbzogJHJlczMiCgogICAgV3JpdGUtQXRsYXNMb2cgIi0+IEFEVkVSVEVOQ0lBOiBFbCBlcXVpcG8gaGEgc2lkbyBkZXZ1ZWx0byBhIHN1IGVzdGFkbyBwcmVkZXRlcm1pbmFkby4iCgogICAgV3JpdGUtSG9zdCAiYG4iCiAgICBXcml0ZS1DZW50ZXJlZCAiV0FSTjogRWwgZXF1aXBvIGhhIHZ1ZWx0byBhIHN1IGVzdGFkbyB2dWxuZXJhYmxlLiIgJEF0bGFzV2hpdGUKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgIlsgUHJlc2lvbmEgY3VhbHF1aWVyIHRlY2xhIHBhcmEgdm9sdmVyIF0iICRBdGxhc0dyYXkKICAgICRudWxsID0gJEhvc3QuVUkuUmF3VUkuUmVhZEtleSgiTm9FY2hvLEluY2x1ZGVLZXlEb3duIikKfQoKZnVuY3Rpb24gQ2hlY2stU3RhdHVzIHsKICAgIFNob3ctSGVhZGVyCiAgICBXcml0ZS1DZW50ZXJlZCAiWyBFU1RBRE8gQUNUVUFMIERFIExBIFJFRCBdIiAkQXRsYXNXaGl0ZQogICAgV3JpdGUtSG9zdCAiYG4iCiAgICAKICAgIFdyaXRlLUF0bGFzTG9nICItPiBTT0xJQ0lUQU5ETyBFU1RBRE8gQUNUVUFMIERFIElOVEVSRkFDRVMiCgogICAgJFRlcmVkbyA9IChuZXRzaCBpbnRlcmZhY2UgdGVyZWRvIHNob3cgc3RhdGUgfCBPdXQtU3RyaW5nKS5UcmltKCkKICAgICQ2dG80ID0gKG5ldHNoIGludGVyZmFjZSBpcHY2IDZ0bzQgc2hvdyBzdGF0ZSB8IE91dC1TdHJpbmcpLlRyaW0oKQogICAgCiAgICAjIEdyYWJhbW9zIGVsIHJlc3VsdGFkbyBsaW1waW8gZW4gZWwgbG9nCiAgICBXcml0ZS1BdGxhc0xvZyAiLS0tIFJFU1VMVEFETyBURVJFRE8gLS0tYG4kVGVyZWRvIgogICAgV3JpdGUtQXRsYXNMb2cgIi0tLSBSRVNVTFRBRE8gNnRvNCAtLS1gbiQ2dG80IgoKICAgIFdyaXRlLUNlbnRlcmVkICItLS0gVEVSRURPIFNUQVRFIC0tLSIgJEF0bGFzR3JheQogICAgV3JpdGUtQ2VudGVyZWQgIiRUZXJlZG8iICRBdGxhc1doaXRlCiAgICBXcml0ZS1Ib3N0ICJgbiIKICAgIFdyaXRlLUNlbnRlcmVkICItLS0gNnRvNCBTVEFURSAtLS0iICRBdGxhc0dyYXkKICAgIFdyaXRlLUNlbnRlcmVkICIkNnRvNCIgJEF0bGFzV2hpdGUKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgIlsgUHJlc2lvbmEgY3VhbHF1aWVyIHRlY2xhIHBhcmEgdm9sdmVyIF0iICRBdGxhc0dyYXkKICAgICRudWxsID0gJEhvc3QuVUkuUmF3VUkuUmVhZEtleSgiTm9FY2hvLEluY2x1ZGVLZXlEb3duIikKfQoKIyAtLS0gNi4gTUVOw5ogUFJJTkNJUEFMIC0tLQpkbyB7CiAgICBTaG93LUhlYWRlcgogICAgCiAgICBXcml0ZS1DZW50ZXJlZCAiWzFdIEluaWNpYXIgYml0w6Fjb3JhICAgICAgICAgICAgICAgIiAkQXRsYXNHcmVlbgogICAgV3JpdGUtQ2VudGVyZWQgIlsyXSBFSkVDVVRBUiBCTElOREFKRSAoUmVjb21lbmRhZG8pIiAkQXRsYXNXaGl0ZQogICAgV3JpdGUtQ2VudGVyZWQgIlszXSBWZXJpZmljYXIgRXN0YWRvIEFjdHVhbCAgICAgICAgIiAkQXRsYXNXaGl0ZQogICAgV3JpdGUtQ2VudGVyZWQgIls0XSBSZXN0YXVyYXIgQ29uZmlndXJhY2nDs24gKFVuZG8pICIgJEF0bGFzUmVkCiAgICBXcml0ZS1DZW50ZXJlZCAiWzVdIEZpbmFsaXphciBiaXTDoWNvcmEgICAgICAgICAgICAgIiAkQXRsYXNHcmF5CiAgICBXcml0ZS1DZW50ZXJlZCAiW1FdIFNhbGlyICAgICAgICAgICAgICAgICAgICAgICAgICAiICRBdGxhc0dyYXkKICAgIAogICAgV3JpdGUtSG9zdCAiYG4gICAgICA+IEF0bGFzX0FkbWluQFRlcm1pbmFsOiAiIC1Ob05ld2xpbmUgLUZvcmVncm91bmRDb2xvciBEYXJrWWVsbG93CiAgICAkU2VsZWN0aW9uID0gUmVhZC1Ib3N0CgogICAgc3dpdGNoICgkU2VsZWN0aW9uKSB7CiAgICAgICAgJzEnIHsgU3RhcnQtQXRsYXNMb2cgfQogICAgICAgICcyJyB7IEhhcmRlbmluZy1BcHBseSB9CiAgICAgICAgJzMnIHsgQ2hlY2stU3RhdHVzIH0KICAgICAgICAnNCcgeyBSZXN0b3JlLURlZmF1bHRzIH0KICAgICAgICAnNScgeyBTdG9wLUF0bGFzTG9nIH0KICAgICAgICAncScgeyBTdG9wLUF0bGFzTG9nOyBleGl0IH0KICAgICAgICAnUScgeyBTdG9wLUF0bGFzTG9nOyBleGl0IH0KICAgIH0KfSB3aGlsZSAoJHRydWUpCn0K'
$script:AtlasToolSources['Invoke-FastCopy'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtRmFzdENvcHkKIyBNaWdyYWRvIGRlOiBGYXN0Q29weS5wczEKIyBBdGxhcyBQQyBTdXBwb3J0IOKAlCB2MS4wCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBJbnZva2UtRmFzdENvcHkgewogICAgW0NtZGxldEJpbmRpbmcoKV0KICAgIHBhcmFtKCkKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojIEFUTEFTIFBDIFNVUFBPUlQgLSBGQVNUQ09QWSBFRElUSU9OIHYzIChQb3dlclNoZWxsKQojIE11bHRpLW9yaWdlbiArIFBlcmZpbGVzICsgQ29tcGFyYXIgKyBOb3RpZmljYWNpb24KIyBNRDUgKyBTcGVlZCBhZGFwdCArIFJlc3VtZW4gZXhwb3J0YWJsZSArIEV4Y2x1c2lvbmVzCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCiRIb3N0LlVJLlJhd1VJLkJhY2tncm91bmRDb2xvciA9ICJCbGFjayIKJEhvc3QuVUkuUmF3VUkuRm9yZWdyb3VuZENvbG9yID0gIkdyYXkiCiRIb3N0LlVJLlJhd1VJLldpbmRvd1RpdGxlID0gIkFUTEFTIFBDIFNVUFBPUlQgLSBGYXN0Q29weSB2MyIKdHJ5IHsgJEhvc3QuVUkuUmF3VUkuV2luZG93U2l6ZSA9IE5ldy1PYmplY3QgU3lzdGVtLk1hbmFnZW1lbnQuQXV0b21hdGlvbi5Ib3N0LlNpemUoMTEwLCA0OCkgfSBjYXRjaCB7fQokRXJyb3JBY3Rpb25QcmVmZXJlbmNlID0gIkNvbnRpbnVlIgoKIyA9PT09PT09PT09PT09PT09PT09PSBCVVNDQVIgRkFTVENPUFkgPT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIEZpbmQtRmFzdENvcHkgewogICAgJGF0bGFzQXBwcyA9IGlmICgkZW52OkxPQ0FMQVBQREFUQSkgeyBKb2luLVBhdGggJGVudjpMT0NBTEFQUERBVEEgJ0F0bGFzUENcYXBwc1xGYXN0Q29weScgfSBlbHNlIHsgJG51bGwgfQogICAgJHNlYXJjaFBhdGhzID0gQCgKICAgICAgICAoSm9pbi1QYXRoICRQU1NjcmlwdFJvb3QgIkZhc3RDb3B5LmV4ZSIpLAogICAgICAgIChKb2luLVBhdGggJFBTU2NyaXB0Um9vdCAiZmFzdGNvcHlcRmFzdENvcHkuZXhlIiksCiAgICAgICAgKEpvaW4tUGF0aCAkUFNTY3JpcHRSb290ICIuLlxBcHBzXEZhc3RDb3B5XEZhc3RDb3B5LmV4ZSIpLAogICAgICAgIChKb2luLVBhdGggJFBTU2NyaXB0Um9vdCAiQXBwc1xGYXN0Q29weVxGYXN0Q29weS5leGUiKSwKICAgICAgICAiQzpcUHJvZ3JhbSBGaWxlc1xGYXN0Q29weVxGYXN0Q29weS5leGUiLAogICAgICAgICJDOlxQcm9ncmFtIEZpbGVzICh4ODYpXEZhc3RDb3B5XEZhc3RDb3B5LmV4ZSIsCiAgICAgICAgKEpvaW4tUGF0aCAkZW52OkxPQ0FMQVBQREFUQSAiRmFzdENvcHlcRmFzdENvcHkuZXhlIikKICAgICkKICAgIGlmICgkYXRsYXNBcHBzKSB7ICRzZWFyY2hQYXRocyArPSAoSm9pbi1QYXRoICRhdGxhc0FwcHMgJ0Zhc3RDb3B5LmV4ZScpIH0KICAgIGZvcmVhY2ggKCRwYXRoIGluICRzZWFyY2hQYXRocykgewogICAgICAgIGlmICgkcGF0aCAtYW5kIChUZXN0LVBhdGggJHBhdGgpKSB7IHJldHVybiAoUmVzb2x2ZS1QYXRoICRwYXRoKS5QYXRoIH0KICAgIH0KICAgICRpblBhdGggPSBHZXQtQ29tbWFuZCAiRmFzdENvcHkuZXhlIiAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgaWYgKCRpblBhdGgpIHsgcmV0dXJuICRpblBhdGguU291cmNlIH0KICAgIGlmICgkUFNTY3JpcHRSb290KSB7CiAgICAgICAgJGZvdW5kID0gR2V0LUNoaWxkSXRlbSAtUGF0aCAkUFNTY3JpcHRSb290IC1GaWx0ZXIgIkZhc3RDb3B5LmV4ZSIgLVJlY3Vyc2UgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUgfCBTZWxlY3QtT2JqZWN0IC1GaXJzdCAxCiAgICAgICAgaWYgKCRmb3VuZCkgeyByZXR1cm4gJGZvdW5kLkZ1bGxOYW1lIH0KICAgIH0KICAgIHJldHVybiAkbnVsbAp9CgpmdW5jdGlvbiBJbnN0YWxsLUZhc3RDb3B5QXV0byB7CiAgICAjIERlc2NhcmdhIGVsIGluc3RhbGxlciBvZmljaWFsIGRlIEZhc3RDb3B5IChmYXN0Y29weS5qcCByZWRpcmlnZSBhIEdpdEh1YiksCiAgICAjIGxvIGVqZWN1dGEgc2lsZW5jaW9zYW1lbnRlIGEgJUxPQ0FMQVBQREFUQSVcQXRsYXNQQ1xhcHBzXEZhc3RDb3B5IHkKICAgICMgZGV2dWVsdmUgbGEgcnV0YSBhbCAuZXhlLgogICAgJHRhcmdldERpciA9IEpvaW4tUGF0aCAkZW52OkxPQ0FMQVBQREFUQSAnQXRsYXNQQ1xhcHBzXEZhc3RDb3B5JwogICAgaWYgKC1ub3QgKFRlc3QtUGF0aCAkdGFyZ2V0RGlyKSkgewogICAgICAgIE5ldy1JdGVtIC1JdGVtVHlwZSBEaXJlY3RvcnkgLVBhdGggJHRhcmdldERpciAtRm9yY2UgfCBPdXQtTnVsbAogICAgfQoKICAgICMgVVJMcyBlbiBvcmRlbiBkZSBwcmVmZXJlbmNpYSAodmVyc2lvbiBtYXMgcmVjaWVudGUgcHJpbWVybykuCiAgICAjIGZhc3Rjb3B5LmpwIGhhY2UgcmVkaXJlY3QgMzAyIGEgR2l0SHViL0Zhc3RDb3B5TGFiLgogICAgJHVybHMgPSBAKAogICAgICAgICdodHRwczovL2Zhc3Rjb3B5LmpwL2FyY2hpdmUvRmFzdENvcHk1LjExLjJfaW5zdGFsbGVyLmV4ZScsCiAgICAgICAgJ2h0dHBzOi8vZ2l0aHViLmNvbS9GYXN0Q29weUxhYi9GYXN0Q29weURpc3QyL3Jhdy9tYWluL0Zhc3RDb3B5NS4xMS4yX2luc3RhbGxlci5leGUnLAogICAgICAgICdodHRwczovL2Zhc3Rjb3B5LmpwL2FyY2hpdmUvRmFzdENvcHk1LjkuMF9pbnN0YWxsZXIuZXhlJwogICAgKQoKICAgICRpbnN0YWxsZXJQYXRoID0gSm9pbi1QYXRoICRlbnY6VEVNUCAoIkZhc3RDb3B5LWluc3RhbGxlci0iICsgW2d1aWRdOjpOZXdHdWlkKCkuVG9TdHJpbmcoJ04nKS5TdWJzdHJpbmcoMCw4KSArICIuZXhlIikKICAgICRvayA9ICRmYWxzZQogICAgZm9yZWFjaCAoJHVybCBpbiAkdXJscykgewogICAgICAgIFdyaXRlLUhvc3QgIiAgICBEZXNjYXJnYW5kbzogJHVybCIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICAgICAgdHJ5IHsKICAgICAgICAgICAgJFByb2dyZXNzUHJlZmVyZW5jZSA9ICdTaWxlbnRseUNvbnRpbnVlJwogICAgICAgICAgICBJbnZva2UtV2ViUmVxdWVzdCAtVXJpICR1cmwgLU91dEZpbGUgJGluc3RhbGxlclBhdGggLVVzZUJhc2ljUGFyc2luZyAtVGltZW91dFNlYyAxMjAgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAgICAgaWYgKChHZXQtSXRlbSAkaW5zdGFsbGVyUGF0aCkuTGVuZ3RoIC1ndCAyMDBLQikgeyAkb2sgPSAkdHJ1ZTsgYnJlYWsgfQogICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRmFsbG86ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgIH0KICAgIH0KICAgIGlmICgtbm90ICRvaykgeyB0aHJvdyAiTm8gc2UgcHVkbyBkZXNjYXJnYXIgZWwgaW5zdGFsbGVyIGRlIEZhc3RDb3B5LiIgfQoKICAgICMgRWwgaW5zdGFsbGVyIG9maWNpYWwgZGUgRmFzdENvcHkgTk8gZXMgSW5ub1NldHVwOyBlcyBjdXN0b20uCiAgICAjIFN3aXRjaGVzIChzZWd1biBlbCBwcm9waW8gaW5zdGFsYWRvcik6CiAgICAjICAgL1NJTEVOVCAuLi4gc2lsZW50IGluc3RhbGwKICAgICMgICAvRElSPTxkaXI+IC4uLiB0YXJnZXQgZGlyCiAgICAjICAgL0VYVFJBQ1Q2NCAuLi4gZXh0cmFlciBzb2xvIGFyY2hpdm9zIChzaW4gaW5zdGFsYXIpCiAgICAjICAgL05PU1VCRElSIC4uLiBubyBjcmVhciBzdWJjYXJwZXRhCiAgICAjICAgL0FHUkVFX0xJQ0VOU0UgLi4uIGFjZXB0YXIgbGljZW5jaWEKICAgICMgVXNhbW9zIC9FWFRSQUNUNjQgcGFyYSBzb2xvIGRlamFyIGxvcyBhcmNoaXZvcyBlbiAkdGFyZ2V0RGlyCiAgICAjIHNpbiBtb2RpZmljYXIgbWVudSBpbmljaW8gLyBQcm9ncmFtIEZpbGVzIC8gcmVnaXN0cm8uCiAgICBXcml0ZS1Ib3N0ICIgICAgRXh0cmF5ZW5kbyBGYXN0Q29weSBhICR0YXJnZXREaXIgLi4uIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgICRwcm9jQXJncyA9IEAoJy9FWFRSQUNUNjQnLCAnL05PU1VCRElSJywgJy9BR1JFRV9MSUNFTlNFJywgKCIvRElSPWAiJHRhcmdldERpcmAiIikpCiAgICB0cnkgewogICAgICAgICRwID0gU3RhcnQtUHJvY2VzcyAtRmlsZVBhdGggJGluc3RhbGxlclBhdGggLUFyZ3VtZW50TGlzdCAkcHJvY0FyZ3MgLVdhaXQgLVBhc3NUaHJ1IC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgaWYgKCRwLkV4aXRDb2RlIC1uZSAwKSB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAvRVhUUkFDVDY0IHRlcm1pbm8gY29uIGNvZGlnbyAkKCRwLkV4aXRDb2RlKS4gUHJvYmFuZG8gL1NJTEVOVCBpbnN0YWxsLi4uIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICAkcDIgPSBTdGFydC1Qcm9jZXNzIC1GaWxlUGF0aCAkaW5zdGFsbGVyUGF0aCAtQXJndW1lbnRMaXN0IEAoJy9TSUxFTlQnLCAnL0FHUkVFX0xJQ0VOU0UnLCAoIi9ESVI9YCIkdGFyZ2V0RGlyYCIiKSkgLVdhaXQgLVBhc3NUaHJ1IC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgIGlmICgkcDIuRXhpdENvZGUgLW5lIDApIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAvU0lMRU5UIHRhbWJpZW4gZmFsbG8uIEVqZWN1dGFuZG8gZW4gbW9kbyBpbnRlcmFjdGl2by4uLiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAgICAgICAgIFN0YXJ0LVByb2Nlc3MgLUZpbGVQYXRoICRpbnN0YWxsZXJQYXRoIC1XYWl0CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9IGNhdGNoIHsKICAgICAgICB0aHJvdyAiRmFsbG8gZWplY3V0YW5kbyBlbCBpbnN0YWxhZG9yOiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIKICAgIH0gZmluYWxseSB7CiAgICAgICAgUmVtb3ZlLUl0ZW0gJGluc3RhbGxlclBhdGggLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgIH0KCiAgICAjIEJ1c2NhciBlbCAuZXhlIGVuIHRhcmdldCAoZWwgaW5zdGFsbGVyIHB1ZWRlIHBvbmVyIEZhc3RDb3B5LmV4ZSBkaXJlY3RvIG8gZW4gc3ViY2FycGV0YSkuCiAgICAkZXhlID0gR2V0LUNoaWxkSXRlbSAtUGF0aCAkdGFyZ2V0RGlyIC1GaWx0ZXIgJ0Zhc3RDb3B5LmV4ZScgLVJlY3Vyc2UgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUgfCBTZWxlY3QtT2JqZWN0IC1GaXJzdCAxCiAgICBpZiAoLW5vdCAkZXhlKSB7CiAgICAgICAgIyBTaSBlbCB1c3VhcmlvIGVsaWdpbyBlbCBkZWZhdWx0IChQcm9ncmFtIEZpbGVzKSwgYnVzY2FyIGFoaS4KICAgICAgICAkZmFsbGJhY2tzID0gQCgKICAgICAgICAgICAgIiRlbnY6UHJvZ3JhbUZpbGVzXEZhc3RDb3B5XEZhc3RDb3B5LmV4ZSIsCiAgICAgICAgICAgICIke2VudjpQcm9ncmFtRmlsZXMoeDg2KX1cRmFzdENvcHlcRmFzdENvcHkuZXhlIgogICAgICAgICkKICAgICAgICBmb3JlYWNoICgkZmIgaW4gJGZhbGxiYWNrcykgewogICAgICAgICAgICBpZiAoVGVzdC1QYXRoICRmYikgeyAkZXhlID0gR2V0LUl0ZW0gJGZiOyBicmVhayB9CiAgICAgICAgfQogICAgfQogICAgaWYgKC1ub3QgJGV4ZSkgeyB0aHJvdyAiRmFzdENvcHkuZXhlIG5vIGVuY29udHJhZG8gdHJhcyBsYSBpbnN0YWxhY2lvbi4iIH0KICAgIHJldHVybiAkZXhlLkZ1bGxOYW1lCn0KCiMgPT09PT09PT09PT09PT09PT09PT0gRlVOQ0lPTkVTIEJBU0UgPT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIFdyaXRlLUNlbnRlcmVkIHsKICAgIHBhcmFtIChbc3RyaW5nXSRUZXh0LCBbc3RyaW5nXSRDb2xvciA9ICJXaGl0ZSIpCiAgICAkVyA9IHRyeSB7ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUuV2lkdGggfSBjYXRjaCB7IDgwIH0KICAgICRQYWQgPSBbbWF0aF06Ok1heCgwLCBbbWF0aF06OkZsb29yKCgkVyAtICRUZXh0Lkxlbmd0aCkgLyAyKSkKICAgIFdyaXRlLUhvc3QgKCIgIiAqICRQYWQgKyAkVGV4dCkgLUZvcmVncm91bmRDb2xvciAkQ29sb3IKfQoKZnVuY3Rpb24gQ2xlYW4tUGF0aCB7CiAgICBwYXJhbShbc3RyaW5nXSRSYXdQYXRoKQogICAgcmV0dXJuICRSYXdQYXRoLlRyaW0oKS5UcmltKCciJykuVHJpbSgiJyIpLlRyaW1FbmQoJ1wnKQp9CgpmdW5jdGlvbiBGb3JtYXQtU2l6ZSB7CiAgICBwYXJhbShbbG9uZ10kQnl0ZXMpCiAgICBpZiAoJEJ5dGVzIC1nZSAxR0IpIHsgcmV0dXJuICJ7MDpOMn0gR0IiIC1mICgkQnl0ZXMgLyAxR0IpIH0KICAgIGlmICgkQnl0ZXMgLWdlIDFNQikgeyByZXR1cm4gInswOk4xfSBNQiIgLWYgKCRCeXRlcyAvIDFNQikgfQogICAgaWYgKCRCeXRlcyAtZ2UgMUtCKSB7IHJldHVybiAiezA6TjB9IEtCIiAtZiAoJEJ5dGVzIC8gMUtCKSB9CiAgICByZXR1cm4gIiRCeXRlcyBCIgp9CgpmdW5jdGlvbiBGb3JtYXQtRHVyYXRpb24gewogICAgcGFyYW0oW1RpbWVTcGFuXSREdXJhdGlvbikKICAgIGlmICgkRHVyYXRpb24uVG90YWxIb3VycyAtZ2UgMSkgeyByZXR1cm4gInswfWggezF9bSB7Mn1zIiAtZiBbaW50XSREdXJhdGlvbi5Ub3RhbEhvdXJzLCAkRHVyYXRpb24uTWludXRlcywgJER1cmF0aW9uLlNlY29uZHMgfQogICAgaWYgKCREdXJhdGlvbi5Ub3RhbE1pbnV0ZXMgLWdlIDEpIHsgcmV0dXJuICJ7MH1tIHsxfXMiIC1mIFtpbnRdJER1cmF0aW9uLlRvdGFsTWludXRlcywgJER1cmF0aW9uLlNlY29uZHMgfQogICAgcmV0dXJuICJ7MDpOMX1zIiAtZiAkRHVyYXRpb24uVG90YWxTZWNvbmRzCn0KCmZ1bmN0aW9uIEdldC1Gb2xkZXJTdGF0cyB7CiAgICBwYXJhbShbc3RyaW5nXSRQYXRoKQogICAgJGl0ZW1zID0gR2V0LUNoaWxkSXRlbSAtUGF0aCAkUGF0aCAtUmVjdXJzZSAtRmlsZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgJHRvdGFsU2l6ZSA9ICgkaXRlbXMgfCBNZWFzdXJlLU9iamVjdCBMZW5ndGggLVN1bSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSkuU3VtCiAgICBpZiAoLW5vdCAkdG90YWxTaXplKSB7ICR0b3RhbFNpemUgPSAwIH0KICAgIHJldHVybiBAeyBGaWxlcyA9ICRpdGVtcy5Db3VudDsgU2l6ZSA9ICR0b3RhbFNpemU7IFNpemVNQiA9IFttYXRoXTo6Um91bmQoJHRvdGFsU2l6ZSAvIDFNQiwgMSkgfQp9CgpmdW5jdGlvbiBEZXRlY3QtRHJpdmVUeXBlIHsKICAgIHBhcmFtKFtzdHJpbmddJERyaXZlTGV0dGVyKQogICAgJGxldHRlciA9ICREcml2ZUxldHRlci5UcmltRW5kKCc6JywgJ1wnKQogICAgdHJ5IHsKICAgICAgICAkdm9sID0gR2V0LVZvbHVtZSAtRHJpdmVMZXR0ZXIgJGxldHRlciAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgIGlmICgkdm9sLkRyaXZlVHlwZSAtZXEgJ1JlbW92YWJsZScpIHsKICAgICAgICAgICAgcmV0dXJuIEB7IFR5cGUgPSAiVVNCIjsgU3BlZWQgPSAiYXV0b3Nsb3ciOyBEZXNjID0gIlVTQiBSZW1vdmlibGUiOyBDb2xvciA9ICJZZWxsb3ciOyBMYWJlbCA9ICR2b2wuRmlsZVN5c3RlbUxhYmVsOyBGcmVlQnl0ZXMgPSAkdm9sLlNpemVSZW1haW5pbmcgfQogICAgICAgIH0KICAgICAgICAkcGFydCA9IEdldC1QYXJ0aXRpb24gLURyaXZlTGV0dGVyICRsZXR0ZXIgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAkZGlzayA9IEdldC1EaXNrIC1OdW1iZXIgJHBhcnQuRGlza051bWJlciAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICRwaHlzID0gR2V0LVBoeXNpY2FsRGlzayAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSB8IFdoZXJlLU9iamVjdCB7ICRfLkRldmljZUlkIC1lcSAkZGlzay5OdW1iZXIuVG9TdHJpbmcoKSB9CiAgICAgICAgaWYgKCRkaXNrLkJ1c1R5cGUgLWVxICdVU0InKSB7CiAgICAgICAgICAgIHJldHVybiBAeyBUeXBlID0gIlVTQiI7IFNwZWVkID0gImF1dG9zbG93IjsgRGVzYyA9ICJVU0IgRXh0ZXJubyI7IENvbG9yID0gIlllbGxvdyI7IExhYmVsID0gJHZvbC5GaWxlU3lzdGVtTGFiZWw7IEZyZWVCeXRlcyA9ICR2b2wuU2l6ZVJlbWFpbmluZyB9CiAgICAgICAgfQogICAgICAgIGlmICgkZGlzay5CdXNUeXBlIC1lcSAnTlZNZScgLW9yICgkcGh5cyAtYW5kICRwaHlzLk1lZGlhVHlwZSAtbWF0Y2ggJ1NTRCcpKSB7CiAgICAgICAgICAgIHJldHVybiBAeyBUeXBlID0gIlNTRCI7IFNwZWVkID0gImZ1bGwiOyBEZXNjID0gIlNTRC9OVk1lIjsgQ29sb3IgPSAiR3JlZW4iOyBMYWJlbCA9ICR2b2wuRmlsZVN5c3RlbUxhYmVsOyBGcmVlQnl0ZXMgPSAkdm9sLlNpemVSZW1haW5pbmcgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gQHsgVHlwZSA9ICJIREQiOyBTcGVlZCA9ICJmdWxsIjsgRGVzYyA9ICJIREQgTWVjYW5pY28iOyBDb2xvciA9ICJDeWFuIjsgTGFiZWwgPSAkdm9sLkZpbGVTeXN0ZW1MYWJlbDsgRnJlZUJ5dGVzID0gJHZvbC5TaXplUmVtYWluaW5nIH0KICAgIH0gY2F0Y2ggewogICAgICAgIHJldHVybiBAeyBUeXBlID0gIlVOS05PV04iOyBTcGVlZCA9ICJhdXRvc2xvdyI7IERlc2MgPSAiTm8gZGV0ZWN0YWRvIjsgQ29sb3IgPSAiR3JheSI7IExhYmVsID0gIiI7IEZyZWVCeXRlcyA9IDAgfQogICAgfQp9CgojID09PT09PT09PT09PT09PT09PT09IEVYUExPUkFET1IgREUgQVJDSElWT1MgPT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIFNlbGVjdC1Gb2xkZXJEaWFsb2cgewogICAgcGFyYW0oW3N0cmluZ10kRGVzY3JpcHRpb24gPSAiU2VsZWNjaW9uYSB1bmEgY2FycGV0YSIpCiAgICBBZGQtVHlwZSAtQXNzZW1ibHlOYW1lIFN5c3RlbS5XaW5kb3dzLkZvcm1zIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlCiAgICAkZGlhbG9nID0gTmV3LU9iamVjdCBTeXN0ZW0uV2luZG93cy5Gb3Jtcy5Gb2xkZXJCcm93c2VyRGlhbG9nCiAgICAkZGlhbG9nLkRlc2NyaXB0aW9uID0gJERlc2NyaXB0aW9uCiAgICAkZGlhbG9nLlNob3dOZXdGb2xkZXJCdXR0b24gPSAkdHJ1ZQogICAgaWYgKCRkaWFsb2cuU2hvd0RpYWxvZygpIC1lcSBbU3lzdGVtLldpbmRvd3MuRm9ybXMuRGlhbG9nUmVzdWx0XTo6T0spIHsgcmV0dXJuICRkaWFsb2cuU2VsZWN0ZWRQYXRoIH0KICAgIHJldHVybiAkbnVsbAp9CgpmdW5jdGlvbiBTZWxlY3QtRmlsZURpYWxvZyB7CiAgICBwYXJhbShbc3RyaW5nXSRUaXRsZSA9ICJTZWxlY2Npb25hIHVuIGFyY2hpdm8iKQogICAgQWRkLVR5cGUgLUFzc2VtYmx5TmFtZSBTeXN0ZW0uV2luZG93cy5Gb3JtcyAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgJGRpYWxvZyA9IE5ldy1PYmplY3QgU3lzdGVtLldpbmRvd3MuRm9ybXMuT3BlbkZpbGVEaWFsb2cKICAgICRkaWFsb2cuVGl0bGUgPSAkVGl0bGUKICAgICRkaWFsb2cuRmlsdGVyID0gIlRvZG9zIGxvcyBhcmNoaXZvcyAoKi4qKXwqLioiCiAgICBpZiAoJGRpYWxvZy5TaG93RGlhbG9nKCkgLWVxIFtTeXN0ZW0uV2luZG93cy5Gb3Jtcy5EaWFsb2dSZXN1bHRdOjpPSykgeyByZXR1cm4gJGRpYWxvZy5GaWxlTmFtZSB9CiAgICByZXR1cm4gJG51bGwKfQoKZnVuY3Rpb24gR2V0LVBhdGhGcm9tVXNlciB7CiAgICBwYXJhbShbc3RyaW5nXSRQcm9tcHQgPSAiUlVUQSIsIFtzdHJpbmddJE1vZGUgPSAiYW55IikKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgQVJSQVNUUkEsIGVzY3JpYmUgcnV0YSwgbyB1c2EgZWwgZXhwbG9yYWRvcjoiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiAgICAgIFtFXSBBYnJpciBleHBsb3JhZG9yIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIFdyaXRlLUhvc3QgIiAgICAgIFtCXSBWb2x2ZXIgIFtTXSBTYWxpciIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiIgogICAgJHVzZXJJbnB1dCA9IFJlYWQtSG9zdCAiICAgICAgJHtQcm9tcHR9IgogICAgaWYgKCR1c2VySW5wdXQgLWVxICJTIiAtb3IgJHVzZXJJbnB1dCAtZXEgInMiKSB7IHJldHVybiAiRVhJVCIgfQogICAgaWYgKCR1c2VySW5wdXQgLWVxICJCIiAtb3IgJHVzZXJJbnB1dCAtZXEgImIiKSB7IHJldHVybiAiQkFDSyIgfQogICAgaWYgKCR1c2VySW5wdXQgLWVxICJFIiAtb3IgJHVzZXJJbnB1dCAtZXEgImUiKSB7CiAgICAgICAgaWYgKCRNb2RlIC1lcSAiZm9sZGVyIikgewogICAgICAgICAgICAkcGF0aCA9IFNlbGVjdC1Gb2xkZXJEaWFsb2cgLURlc2NyaXB0aW9uICJTZWxlY2Npb25hIGNhcnBldGEiCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgWzFdIENhcnBldGEgIFsyXSBBcmNoaXZvIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgICAgICR0aXBvID0gUmVhZC1Ib3N0ICIgICAgICA+IgogICAgICAgICAgICBpZiAoJHRpcG8gLWVxICIyIikgeyAkcGF0aCA9IFNlbGVjdC1GaWxlRGlhbG9nIH0gZWxzZSB7ICRwYXRoID0gU2VsZWN0LUZvbGRlckRpYWxvZyB9CiAgICAgICAgfQogICAgICAgIGlmICgtbm90ICRwYXRoKSB7IHJldHVybiAiQkFDSyIgfQogICAgICAgIHJldHVybiAkcGF0aAogICAgfQogICAgcmV0dXJuIENsZWFuLVBhdGggJHVzZXJJbnB1dAp9CgojID09PT09PT09PT09PT09PT09PT09IFBFUkZJTEVTIERFIFJFU1BBTERPID09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBHZXQtVXNlclByb2ZpbGUgewogICAgJHVzZXJSb290ID0gW0Vudmlyb25tZW50XTo6R2V0Rm9sZGVyUGF0aCgiVXNlclByb2ZpbGUiKQogICAgCiAgICAkcHJvZmlsZXMgPSBAewogICAgICAgICIxIiA9IEB7CiAgICAgICAgICAgIE5hbWUgPSAiUkVTUEFMRE8gQ09NUExFVE8gREUgVVNVQVJJTyIKICAgICAgICAgICAgRGVzYyA9ICJEZXNrdG9wICsgRG9jdW1lbnRvcyArIEZvdG9zICsgVmlkZW9zICsgRGVzY2FyZ2FzICsgRmF2b3JpdG9zIgogICAgICAgICAgICBQYXRocyA9IEAoCiAgICAgICAgICAgICAgICAoSm9pbi1QYXRoICR1c2VyUm9vdCAiRGVza3RvcCIpLAogICAgICAgICAgICAgICAgKEpvaW4tUGF0aCAkdXNlclJvb3QgIkRvY3VtZW50cyIpLAogICAgICAgICAgICAgICAgKEpvaW4tUGF0aCAkdXNlclJvb3QgIlBpY3R1cmVzIiksCiAgICAgICAgICAgICAgICAoSm9pbi1QYXRoICR1c2VyUm9vdCAiVmlkZW9zIiksCiAgICAgICAgICAgICAgICAoSm9pbi1QYXRoICR1c2VyUm9vdCAiRG93bmxvYWRzIiksCiAgICAgICAgICAgICAgICAoSm9pbi1QYXRoICR1c2VyUm9vdCAiRmF2b3JpdGVzIikKICAgICAgICAgICAgKQogICAgICAgIH0KICAgICAgICAiMiIgPSBAewogICAgICAgICAgICBOYW1lID0gIlNPTE8gRE9DVU1FTlRPUyBZIEVTQ1JJVE9SSU8iCiAgICAgICAgICAgIERlc2MgPSAiRGVza3RvcCArIERvY3VtZW50b3MgKGxvIG1hcyBjcml0aWNvKSIKICAgICAgICAgICAgUGF0aHMgPSBAKAogICAgICAgICAgICAgICAgKEpvaW4tUGF0aCAkdXNlclJvb3QgIkRlc2t0b3AiKSwKICAgICAgICAgICAgICAgIChKb2luLVBhdGggJHVzZXJSb290ICJEb2N1bWVudHMiKQogICAgICAgICAgICApCiAgICAgICAgfQogICAgICAgICIzIiA9IEB7CiAgICAgICAgICAgIE5hbWUgPSAiRk9UT1MgWSBWSURFT1MiCiAgICAgICAgICAgIERlc2MgPSAiUGljdHVyZXMgKyBWaWRlb3MiCiAgICAgICAgICAgIFBhdGhzID0gQCgKICAgICAgICAgICAgICAgIChKb2luLVBhdGggJHVzZXJSb290ICJQaWN0dXJlcyIpLAogICAgICAgICAgICAgICAgKEpvaW4tUGF0aCAkdXNlclJvb3QgIlZpZGVvcyIpCiAgICAgICAgICAgICkKICAgICAgICB9CiAgICAgICAgIjQiID0gQHsKICAgICAgICAgICAgTmFtZSA9ICJPVVRMT09LICsgQ09SUkVPIgogICAgICAgICAgICBEZXNjID0gIlBTVC9PU1QgZGUgT3V0bG9vayArIFNpZ25hdHVyZXMiCiAgICAgICAgICAgIFBhdGhzID0gQCgKICAgICAgICAgICAgICAgIChKb2luLVBhdGggJHVzZXJSb290ICJEb2N1bWVudHNcT3V0bG9vayBGaWxlcyIpLAogICAgICAgICAgICAgICAgKEpvaW4tUGF0aCAkZW52OkxPQ0FMQVBQREFUQSAiTWljcm9zb2Z0XE91dGxvb2siKSwKICAgICAgICAgICAgICAgIChKb2luLVBhdGggJGVudjpBUFBEQVRBICJNaWNyb3NvZnRcU2lnbmF0dXJlcyIpCiAgICAgICAgICAgICkKICAgICAgICB9CiAgICAgICAgIjUiID0gQHsKICAgICAgICAgICAgTmFtZSA9ICJOQVZFR0FET1JFUyAoRmF2b3JpdG9zL0Jvb2ttYXJrcykiCiAgICAgICAgICAgIERlc2MgPSAiQ2hyb21lICsgRWRnZSArIEZpcmVmb3ggYm9va21hcmtzIgogICAgICAgICAgICBQYXRocyA9IEAoCiAgICAgICAgICAgICAgICAoSm9pbi1QYXRoICRlbnY6TE9DQUxBUFBEQVRBICJHb29nbGVcQ2hyb21lXFVzZXIgRGF0YVxEZWZhdWx0IiksCiAgICAgICAgICAgICAgICAoSm9pbi1QYXRoICRlbnY6TE9DQUxBUFBEQVRBICJNaWNyb3NvZnRcRWRnZVxVc2VyIERhdGFcRGVmYXVsdCIpLAogICAgICAgICAgICAgICAgKEpvaW4tUGF0aCAkZW52OkFQUERBVEEgIk1vemlsbGFcRmlyZWZveFxQcm9maWxlcyIpCiAgICAgICAgICAgICkKICAgICAgICB9CiAgICB9CiAgICByZXR1cm4gJHByb2ZpbGVzCn0KCmZ1bmN0aW9uIFNob3ctUHJvZmlsZU1lbnUgewogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtQ2VudGVyZWQgIj09PSBQRVJGSUxFUyBERSBSRVNQQUxETyBSQVBJRE8gPT09IiAiRGFya1llbGxvdyIKICAgIFdyaXRlLUhvc3QgIiIKICAgIAogICAgJHByb2ZpbGVzID0gR2V0LVVzZXJQcm9maWxlCiAgICBmb3JlYWNoICgka2V5IGluICgkcHJvZmlsZXMuS2V5cyB8IFNvcnQtT2JqZWN0KSkgewogICAgICAgICRwID0gJHByb2ZpbGVzWyRrZXldCiAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgWyR7a2V5fV0gJCgkcC5OYW1lKSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgIFdyaXRlLUhvc3QgIiAgICAgICAgICAkKCRwLkRlc2MpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgCiAgICAgICAgIyBDb250YXIgY2FycGV0YXMgcXVlIGV4aXN0ZW4KICAgICAgICAkZXhpc3RDb3VudCA9ICgkcC5QYXRocyB8IFdoZXJlLU9iamVjdCB7IFRlc3QtUGF0aCAkXyB9KS5Db3VudAogICAgICAgICR0b3RhbENvdW50ID0gJHAuUGF0aHMuQ291bnQKICAgICAgICAkZXhpc3RDb2xvciA9IGlmICgkZXhpc3RDb3VudCAtZXEgJHRvdGFsQ291bnQpIHsgIkdyZWVuIiB9IGVsc2VpZiAoJGV4aXN0Q291bnQgLWd0IDApIHsgIlllbGxvdyIgfSBlbHNlIHsgIlJlZCIgfQogICAgICAgIFdyaXRlLUhvc3QgIiAgICAgICAgICBDYXJwZXRhczogJHtleGlzdENvdW50fS8ke3RvdGFsQ291bnR9IGVuY29udHJhZGFzIiAtRm9yZWdyb3VuZENvbG9yICRleGlzdENvbG9yCiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgfQogICAgCiAgICBXcml0ZS1Ib3N0ICIgICAgICBbQl0gVm9sdmVyIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIiCiAgICAkc2VsID0gUmVhZC1Ib3N0ICIgICAgICA+IgogICAgCiAgICBpZiAoJHNlbCAtZXEgIkIiIC1vciAkc2VsIC1lcSAiYiIpIHsgcmV0dXJuICRudWxsIH0KICAgIGlmICgkcHJvZmlsZXMuQ29udGFpbnNLZXkoJHNlbCkpIHsKICAgICAgICAkc2VsZWN0ZWQgPSAkcHJvZmlsZXNbJHNlbF0KICAgICAgICAkdmFsaWRQYXRocyA9IEAoJHNlbGVjdGVkLlBhdGhzIHwgV2hlcmUtT2JqZWN0IHsgVGVzdC1QYXRoICRfIH0pCiAgICAgICAgaWYgKCR2YWxpZFBhdGhzLkNvdW50IC1lcSAwKSB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtFUlJPUl0gTmluZ3VuYSBjYXJwZXRhIGRlbCBwZXJmaWwgZXhpc3RlLiIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgcmV0dXJuICRudWxsCiAgICAgICAgfQogICAgICAgIHJldHVybiBAeyBOYW1lID0gJHNlbGVjdGVkLk5hbWU7IFBhdGhzID0gJHZhbGlkUGF0aHMgfQogICAgfQogICAgV3JpdGUtSG9zdCAiICAgICAgT3BjaW9uIG5vIHZhbGlkYS4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICByZXR1cm4gJG51bGwKfQoKIyA9PT09PT09PT09PT09PT09PT09PSBNVUxUSS1PUklHRU4gPT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIEdldC1NdWx0aXBsZU9yaWdpbnMgewogICAgJG9yaWdpbnMgPSBAKCkKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUNlbnRlcmVkICI9PT0gTVVMVEktT1JJR0VOID09PSIgIkRhcmtZZWxsb3ciCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICAgICBBZ3JlZ2EgY2FycGV0YXMvYXJjaGl2b3MgdW5vIHBvciB1bm8uIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgICBFc2NyaWJlIFtPS10gY3VhbmRvIHRlcm1pbmVzLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgCiAgICB3aGlsZSAoJHRydWUpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgT3JpZ2VuZXMgYWdyZWdhZG9zOiAkKCRvcmlnaW5zLkNvdW50KSIgLUZvcmVncm91bmRDb2xvciAkKGlmICgkb3JpZ2lucy5Db3VudCAtZ3QgMCkgeyAiR3JlZW4iIH0gZWxzZSB7ICJHcmF5IiB9KQogICAgICAgIGlmICgkb3JpZ2lucy5Db3VudCAtZ3QgMCkgewogICAgICAgICAgICBmb3JlYWNoICgkbyBpbiAkb3JpZ2lucykgewogICAgICAgICAgICAgICAgJG9OYW1lID0gU3BsaXQtUGF0aCAkbyAtTGVhZgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgICAtPiAke29OYW1lfSIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgCiAgICAgICAgJHBhdGhSZXN1bHQgPSBHZXQtUGF0aEZyb21Vc2VyIC1Qcm9tcHQgIkFHUkVHQVIgKG8gW09LXSBwYXJhIGNvbnRpbnVhcikiIC1Nb2RlICJhbnkiCiAgICAgICAgCiAgICAgICAgaWYgKCRwYXRoUmVzdWx0IC1lcSAiRVhJVCIpIHsgcmV0dXJuICJFWElUIiB9CiAgICAgICAgaWYgKCRwYXRoUmVzdWx0IC1lcSAiQkFDSyIpIHsKICAgICAgICAgICAgaWYgKCRvcmlnaW5zLkNvdW50IC1ndCAwKSB7IHJldHVybiAkb3JpZ2lucyB9CiAgICAgICAgICAgIHJldHVybiAiQkFDSyIKICAgICAgICB9CiAgICAgICAgaWYgKCRwYXRoUmVzdWx0IC1lcSAiT0siIC1vciAkcGF0aFJlc3VsdCAtZXEgIm9rIikgewogICAgICAgICAgICBpZiAoJG9yaWdpbnMuQ291bnQgLWVxIDApIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtFUlJPUl0gQWdyZWdhIGFsIG1lbm9zIHVuIG9yaWdlbi4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgICAgICBjb250aW51ZQogICAgICAgICAgICB9CiAgICAgICAgICAgIHJldHVybiAkb3JpZ2lucwogICAgICAgIH0KICAgICAgICAKICAgICAgICBpZiAoLW5vdCAoVGVzdC1QYXRoICRwYXRoUmVzdWx0KSkgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbRVJST1JdIE5vIGV4aXN0ZTogJHtwYXRoUmVzdWx0fSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgY29udGludWUKICAgICAgICB9CiAgICAgICAgCiAgICAgICAgaWYgKCRvcmlnaW5zIC1jb250YWlucyAkcGF0aFJlc3VsdCkgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbIV0gWWEgZXN0YSBlbiBsYSBsaXN0YS4iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgIGNvbnRpbnVlCiAgICAgICAgfQogICAgICAgIAogICAgICAgICRvcmlnaW5zICs9ICRwYXRoUmVzdWx0CiAgICAgICAgJGl0ZW1OYW1lID0gU3BsaXQtUGF0aCAkcGF0aFJlc3VsdCAtTGVhZgogICAgICAgICRpdGVtVHlwZSA9IGlmIChUZXN0LVBhdGggJHBhdGhSZXN1bHQgLVBhdGhUeXBlIENvbnRhaW5lcikgeyAiQ0FSUEVUQSIgfSBlbHNlIHsgIkFSQ0hJVk8iIH0KICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbK10gJHtpdGVtVHlwZX06ICR7aXRlbU5hbWV9IiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICB9Cn0KCiMgPT09PT09PT09PT09PT09PT09PT0gQ09NUEFSQVIgQU5URVMgREUgQ09QSUFSID09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBDb21wYXJlLUJlZm9yZUNvcHkgewogICAgcGFyYW0oW3N0cmluZ1tdXSRPcmlnaW5zLCBbc3RyaW5nXSREZXN0aW5vKQogICAgCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1DZW50ZXJlZCAiQU5BTElaQU5ETyBESUZFUkVOQ0lBUy4uLiIgIlllbGxvdyIKICAgIFdyaXRlLUhvc3QgIiIKICAgIAogICAgJHRvdGFsTmV3ID0gMDsgJHRvdGFsTW9kaWZpZWQgPSAwOyAkdG90YWxFcXVhbCA9IDA7ICR0b3RhbFNpemVOZXcgPSAwOyAkdG90YWxTaXplTW9kID0gMAogICAgCiAgICBmb3JlYWNoICgkb3JpZ2VuIGluICRPcmlnaW5zKSB7CiAgICAgICAgJHNyY05hbWUgPSBTcGxpdC1QYXRoICRvcmlnZW4gLUxlYWYKICAgICAgICAkaXNGaWxlID0gLW5vdCAoVGVzdC1QYXRoICRvcmlnZW4gLVBhdGhUeXBlIENvbnRhaW5lcikKICAgICAgICAKICAgICAgICBpZiAoJGlzRmlsZSkgewogICAgICAgICAgICAkc3JjRmlsZSA9IEdldC1JdGVtICRvcmlnZW4KICAgICAgICAgICAgJGRzdEZpbGUgPSBKb2luLVBhdGggJERlc3Rpbm8gJHNyY0ZpbGUuTmFtZQogICAgICAgICAgICBpZiAoLW5vdCAoVGVzdC1QYXRoICRkc3RGaWxlKSkgewogICAgICAgICAgICAgICAgJHRvdGFsTmV3Kys7ICR0b3RhbFNpemVOZXcgKz0gJHNyY0ZpbGUuTGVuZ3RoCiAgICAgICAgICAgIH0gZWxzZWlmICgkc3JjRmlsZS5MYXN0V3JpdGVUaW1lIC1ndCAoR2V0LUl0ZW0gJGRzdEZpbGUpLkxhc3RXcml0ZVRpbWUpIHsKICAgICAgICAgICAgICAgICR0b3RhbE1vZGlmaWVkKys7ICR0b3RhbFNpemVNb2QgKz0gJHNyY0ZpbGUuTGVuZ3RoCiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAkdG90YWxFcXVhbCsrCiAgICAgICAgICAgIH0KICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAkZHN0U3ViRm9sZGVyID0gSm9pbi1QYXRoICREZXN0aW5vICRzcmNOYW1lCiAgICAgICAgICAgICRzcmNGaWxlcyA9IEdldC1DaGlsZEl0ZW0gLVBhdGggJG9yaWdlbiAtUmVjdXJzZSAtRmlsZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgICAgICAgICAKICAgICAgICAgICAgZm9yZWFjaCAoJHNmIGluICRzcmNGaWxlcykgewogICAgICAgICAgICAgICAgJHJlbFBhdGggPSAkc2YuRnVsbE5hbWUuU3Vic3RyaW5nKCRvcmlnZW4uTGVuZ3RoKS5UcmltU3RhcnQoJ1wnKQogICAgICAgICAgICAgICAgJGRmID0gSm9pbi1QYXRoICRkc3RTdWJGb2xkZXIgJHJlbFBhdGgKICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgaWYgKC1ub3QgKFRlc3QtUGF0aCAkZGYpKSB7CiAgICAgICAgICAgICAgICAgICAgJHRvdGFsTmV3Kys7ICR0b3RhbFNpemVOZXcgKz0gJHNmLkxlbmd0aAogICAgICAgICAgICAgICAgfSBlbHNlaWYgKCRzZi5MYXN0V3JpdGVUaW1lIC1ndCAoR2V0LUl0ZW0gJGRmIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlKS5MYXN0V3JpdGVUaW1lKSB7CiAgICAgICAgICAgICAgICAgICAgJHRvdGFsTW9kaWZpZWQrKzsgJHRvdGFsU2l6ZU1vZCArPSAkc2YuTGVuZ3RoCiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgICR0b3RhbEVxdWFsKysKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KICAgIAogICAgJHRvdGFsVHJhbnNmZXIgPSAkdG90YWxTaXplTmV3ICsgJHRvdGFsU2l6ZU1vZAogICAgCiAgICBXcml0ZS1Ib3N0ICIgICAgTlVFVk9TOiAgICAgICR7dG90YWxOZXd9IGFyY2hpdm9zICgkKEZvcm1hdC1TaXplICR0b3RhbFNpemVOZXcpKSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgV3JpdGUtSG9zdCAiICAgIE1PRElGSUNBRE9TOiAke3RvdGFsTW9kaWZpZWR9IGFyY2hpdm9zICgkKEZvcm1hdC1TaXplICR0b3RhbFNpemVNb2QpKSIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgIFdyaXRlLUhvc3QgIiAgICBJR1VBTEVTOiAgICAgJHt0b3RhbEVxdWFsfSBhcmNoaXZvcyAoc2luIGNhbWJpb3MpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICAgVFJBTlNGRVJJUjogICQoJHRvdGFsTmV3ICsgJHRvdGFsTW9kaWZpZWQpIGFyY2hpdm9zICgkKEZvcm1hdC1TaXplICR0b3RhbFRyYW5zZmVyKSkiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgCiAgICByZXR1cm4gQHsKICAgICAgICBOZXcgPSAkdG90YWxOZXc7IE1vZGlmaWVkID0gJHRvdGFsTW9kaWZpZWQ7IEVxdWFsID0gJHRvdGFsRXF1YWwKICAgICAgICBTaXplTmV3ID0gJHRvdGFsU2l6ZU5ldzsgU2l6ZU1vZGlmaWVkID0gJHRvdGFsU2l6ZU1vZDsgU2l6ZVRvdGFsID0gJHRvdGFsVHJhbnNmZXIKICAgIH0KfQoKIyA9PT09PT09PT09PT09PT09PT09PSBFWENMVVNJT05FUyA9PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gR2V0LUV4Y2x1c2lvbnMgewogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICBbP10gRVhDTFVTSU9ORVM6IiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIFdyaXRlLUhvc3QgIiAgICAgIFsxXSBOaW5ndW5hIChjb3BpYXIgdG9kbykiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiAgICAgIFsyXSBUZW1wb3JhbGVzICgudG1wLCAubG9nLCAuYmFrLCBjYWNoZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiAgICAgIFszXSBJU09zIHkgVk1zICguaXNvLCAudmhkLCAud2ltKSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiICAgICAgWzRdIFBlcnNvbmFsaXphZG8gKGVzY3JpYmlyIGV4dGVuc2lvbmVzKSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiICAgICAgW0JdIFZvbHZlciIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiIgogICAgJHNlbCA9IFJlYWQtSG9zdCAiICAgICAgPiIKICAgIAogICAgc3dpdGNoICgkc2VsKSB7CiAgICAgICAgIjIiIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW09LXSBFeGNsdXllbmRvIHRlbXBvcmFsZXMgeSBjYWNoZSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgICAgICByZXR1cm4gQHsgCiAgICAgICAgICAgICAgICBGaWxlcyA9IEAoIioudG1wIiwgIioubG9nIiwgIiouYmFrIiwgIiouY2FjaGUiLCAiKi50ZW1wIiwgIn4qIikKICAgICAgICAgICAgICAgIERpcnMgPSBAKCJUZW1wIiwgInRtcCIsICJDYWNoZSIsICJfX3B5Y2FjaGVfXyIsICJub2RlX21vZHVsZXMiLCAiLmdpdCIpCiAgICAgICAgICAgICAgICBMYWJlbCA9ICJUZW1wb3JhbGVzL0NhY2hlIgogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgICIzIiB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtPS10gRXhjbHV5ZW5kbyBJU09zIHkgVk1zIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgIHJldHVybiBAewogICAgICAgICAgICAgICAgRmlsZXMgPSBAKCIqLmlzbyIsICIqLnZoZCIsICIqLnZoZHgiLCAiKi53aW0iLCAiKi5lc2QiLCAiKi52bWRrIikKICAgICAgICAgICAgICAgIERpcnMgPSBAKCkKICAgICAgICAgICAgICAgIExhYmVsID0gIklTT3MvVk1zIgogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgICI0IiB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIEV4dGVuc2lvbmVzIHNlcGFyYWRhcyBwb3IgY29tYSAoZWo6IC5tcDQsLmF2aSwubWt2KToiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICAgICAgJGN1c3RvbSA9IFJlYWQtSG9zdCAiICAgICAgPiIKICAgICAgICAgICAgaWYgKC1ub3QgW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkY3VzdG9tKSkgewogICAgICAgICAgICAgICAgJGV4dHMgPSAoJGN1c3RvbSAtc3BsaXQgJywnKSB8IEZvckVhY2gtT2JqZWN0IHsKICAgICAgICAgICAgICAgICAgICAkZSA9ICRfLlRyaW0oKQogICAgICAgICAgICAgICAgICAgIGlmICgkZSAtbm90bWF0Y2ggJ15cKicpIHsgJGUgPSAiKiR7ZX0iIH0KICAgICAgICAgICAgICAgICAgICAkZQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW09LXSBFeGNsdXllbmRvOiAkKCRleHRzIC1qb2luICcsICcpIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgICAgICByZXR1cm4gQHsgRmlsZXMgPSAkZXh0czsgRGlycyA9IEAoKTsgTGFiZWwgPSAiUGVyc29uYWxpemFkbyIgfQogICAgICAgICAgICB9CiAgICAgICAgICAgIHJldHVybiBAeyBGaWxlcyA9IEAoKTsgRGlycyA9IEAoKTsgTGFiZWwgPSAiTmluZ3VuYSIgfQogICAgICAgIH0KICAgICAgICAiQiIgeyByZXR1cm4gIkJBQ0siIH0KICAgICAgICBkZWZhdWx0IHsgcmV0dXJuIEB7IEZpbGVzID0gQCgpOyBEaXJzID0gQCgpOyBMYWJlbCA9ICJOaW5ndW5hIiB9IH0KICAgIH0KfQoKIyA9PT09PT09PT09PT09PT09PT09PSBOT1RJRklDQUNJT04gPT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIFNlbmQtTm90aWZpY2F0aW9uIHsKICAgIHBhcmFtKFtzdHJpbmddJFRpdGxlLCBbc3RyaW5nXSRNZXNzYWdlLCBbYm9vbF0kU3VjY2VzcyA9ICR0cnVlKQogICAgCiAgICAjIFNvbmlkbwogICAgaWYgKCRTdWNjZXNzKSB7CiAgICAgICAgW0NvbnNvbGVdOjpCZWVwKDgwMCwgMjAwKTsgW0NvbnNvbGVdOjpCZWVwKDEwMDAsIDIwMCk7IFtDb25zb2xlXTo6QmVlcCgxMjAwLCAzMDApCiAgICB9IGVsc2UgewogICAgICAgIFtDb25zb2xlXTo6QmVlcCg0MDAsIDUwMCk7IFtDb25zb2xlXTo6QmVlcCgzMDAsIDUwMCkKICAgIH0KICAgIAogICAgIyBUb2FzdCBub3RpZmljYXRpb24gZGUgV2luZG93cwogICAgdHJ5IHsKICAgICAgICBBZGQtVHlwZSAtQXNzZW1ibHlOYW1lIFN5c3RlbS5XaW5kb3dzLkZvcm1zIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgJG5vdGlmeSA9IE5ldy1PYmplY3QgU3lzdGVtLldpbmRvd3MuRm9ybXMuTm90aWZ5SWNvbgogICAgICAgICRub3RpZnkuSWNvbiA9IFtTeXN0ZW0uRHJhd2luZy5TeXN0ZW1JY29uc106OkluZm9ybWF0aW9uCiAgICAgICAgJG5vdGlmeS5CYWxsb29uVGlwVGl0bGUgPSAkVGl0bGUKICAgICAgICAkbm90aWZ5LkJhbGxvb25UaXBUZXh0ID0gJE1lc3NhZ2UKICAgICAgICAkbm90aWZ5LkJhbGxvb25UaXBJY29uID0gaWYgKCRTdWNjZXNzKSB7ICJJbmZvIiB9IGVsc2UgeyAiRXJyb3IiIH0KICAgICAgICAkbm90aWZ5LlZpc2libGUgPSAkdHJ1ZQogICAgICAgICRub3RpZnkuU2hvd0JhbGxvb25UaXAoNTAwMCkKICAgICAgICAKICAgICAgICBTdGFydC1TbGVlcCAtU2Vjb25kcyA2CiAgICAgICAgJG5vdGlmeS5EaXNwb3NlKCkKICAgIH0gY2F0Y2gge30KfQoKIyA9PT09PT09PT09PT09PT09PT09PSBSRVNVTUVOIEVYUE9SVEFCTEUgPT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIEV4cG9ydC1Db3B5UmVwb3J0IHsKICAgIHBhcmFtKAogICAgICAgIFtzdHJpbmdbXV0kT3JpZ2lucywgW3N0cmluZ10kRGVzdGlubywgW3N0cmluZ10kTW9kZSwgW3N0cmluZ10kRGlza1R5cGUsCiAgICAgICAgW2hhc2h0YWJsZV0kUmVzdWx0LCBbaGFzaHRhYmxlXSRJbnRlZ3JpdHksIFtoYXNodGFibGVdJENvbXBhcmlzb24sCiAgICAgICAgW3N0cmluZ10kRXhjbHVzaW9uTGFiZWwsIFtzdHJpbmddJENsaWVudGUKICAgICkKICAgIAogICAgJHJlcG9ydEZpbGUgPSBKb2luLVBhdGggKFtFbnZpcm9ubWVudF06OkdldEZvbGRlclBhdGgoIkRlc2t0b3AiKSkgIlJlc3VtZW5fQXRsYXNfJHtDbGllbnRlfV8kKEdldC1EYXRlIC1Gb3JtYXQgJ3l5eXktTU0tZGRfSEhtbScpLnR4dCIKICAgIAogICAgJHIgPSBAKCkKICAgICRyICs9ICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IgogICAgJHIgKz0gIiAgQVRMQVMgUEMgU1VQUE9SVCAtIFJFU1VNRU4gREUgQ09QSUEiCiAgICAkciArPSAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIKICAgICRyICs9ICIiCiAgICAkciArPSAiRkVDSEE6ICAgICAgICQoR2V0LURhdGUgLUZvcm1hdCAnZGQvTU0veXl5eSBISDptbTpzcycpIgogICAgJHIgKz0gIkVRVUlQTzogICAgICAkZW52OkNPTVBVVEVSTkFNRSIKICAgICRyICs9ICJVU1VBUklPOiAgICAgJGVudjpVU0VSTkFNRSIKICAgICRyICs9ICJQUk9ZRUNUTzogICAgJHtDbGllbnRlfSIKICAgICRyICs9ICIiCiAgICAkciArPSAiLS0tIENPTkZJR1VSQUNJT04gLS0tIgogICAgJHIgKz0gIk1PVE9SOiAgICAgICBGYXN0Q29weSIKICAgICRyICs9ICJNT0RPOiAgICAgICAgJHtNb2RlfSIKICAgICRyICs9ICJESVNDTzogICAgICAgJHtEaXNrVHlwZX0iCiAgICAkciArPSAiRVhDTFVTSU9ORVM6ICR7RXhjbHVzaW9uTGFiZWx9IgogICAgJHIgKz0gIiIKICAgICRyICs9ICItLS0gT1JJR0VORVMgLS0tIgogICAgZm9yZWFjaCAoJG8gaW4gJE9yaWdpbnMpIHsgJHIgKz0gIiAgLT4gJHtvfSIgfQogICAgJHIgKz0gIiIKICAgICRyICs9ICItLS0gREVTVElOTyAtLS0iCiAgICAkciArPSAiICAtPiAke0Rlc3Rpbm99IgogICAgJHIgKz0gIiIKICAgICRyICs9ICItLS0gUkVTVUxUQURPIC0tLSIKICAgICRyICs9ICJFU1RBRE86ICAgICAgJChpZiAoJFJlc3VsdC5PSykgeyAnRVhJVE9TTycgfSBlbHNlIHsgJ0NPTiBFUlJPUkVTJyB9KSIKICAgICRyICs9ICJUSUVNUE86ICAgICAgJChGb3JtYXQtRHVyYXRpb24gJFJlc3VsdC5FbGFwc2VkKSIKICAgICRyICs9ICJDT1BJQURPOiAgICAgJChGb3JtYXQtU2l6ZSAkUmVzdWx0LkJ5dGVzQ29waWVkKSIKICAgICRyICs9ICJWRUxPQ0lEQUQ6ICAgJCgkUmVzdWx0LlNwZWVkTUJwcykgTUIvcyIKICAgIAogICAgaWYgKCRDb21wYXJpc29uKSB7CiAgICAgICAgJHIgKz0gIiIKICAgICAgICAkciArPSAiLS0tIEFOQUxJU0lTIFBSRS1DT1BJQSAtLS0iCiAgICAgICAgJHIgKz0gIk5VRVZPUzogICAgICAkKCRDb21wYXJpc29uLk5ldykgYXJjaGl2b3MiCiAgICAgICAgJHIgKz0gIk1PRElGSUNBRE9TOiAkKCRDb21wYXJpc29uLk1vZGlmaWVkKSBhcmNoaXZvcyIKICAgICAgICAkciArPSAiSUdVQUxFUzogICAgICQoJENvbXBhcmlzb24uRXF1YWwpIGFyY2hpdm9zIgogICAgfQogICAgCiAgICBpZiAoJEludGVncml0eSkgewogICAgICAgICRyICs9ICIiCiAgICAgICAgJHIgKz0gIi0tLSBWRVJJRklDQUNJT04gTUQ1IC0tLSIKICAgICAgICAkciArPSAiVkVSSUZJQ0FET1M6ICQoJEludGVncml0eS5DaGVja2VkKSBhcmNoaXZvcyIKICAgICAgICAkciArPSAiT0s6ICAgICAgICAgICQoJEludGVncml0eS5QYXNzZWQpIgogICAgICAgICRyICs9ICJGQUxMT1M6ICAgICAgJCgkSW50ZWdyaXR5LkZhaWxlZCkiCiAgICAgICAgJHIgKz0gIkZBTFRBTlRFUzogICAkKCRJbnRlZ3JpdHkuTWlzc2luZykiCiAgICAgICAgJHIgKz0gIlJFU1VMVEFETzogICAkKGlmICgkSW50ZWdyaXR5Lk9LKSB7ICdJTlRFR1JJREFEIFZFUklGSUNBREEnIH0gZWxzZSB7ICdQUk9CTEVNQVMgREVURUNUQURPUycgfSkiCiAgICB9CiAgICAKICAgICRyICs9ICIiCiAgICAkciArPSAiLS0tIExPRyAtLS0iCiAgICAkciArPSAiQVJDSElWTzogICAgICQoaWYgKCRSZXN1bHQuTG9nRmlsZSkgeyAkUmVzdWx0LkxvZ0ZpbGUgfSBlbHNlIHsgJ04vQScgfSkiCiAgICAkciArPSAiIgogICAgJHIgKz0gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iCiAgICAkciArPSAiICBHZW5lcmFkbyBwb3IgQVRMQVMgUEMgU1VQUE9SVCAtIEZhc3RDb3B5IHYzIgogICAgJHIgKz0gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iCiAgICAKICAgICgkciAtam9pbiAiYHJgbiIpIHwgT3V0LUZpbGUgLUZpbGVQYXRoICRyZXBvcnRGaWxlIC1FbmNvZGluZyBVVEY4CiAgICByZXR1cm4gJHJlcG9ydEZpbGUKfQoKIyA9PT09PT09PT09PT09PT09PT09PSBWRVJJRklDQUNJw5NOIE1ENSA9PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gVGVzdC1Db3B5SW50ZWdyaXR5IHsKICAgIHBhcmFtKFtzdHJpbmddJE9yaWdlbiwgW3N0cmluZ10kRGVzdGlubywgW2ludF0kU2FtcGxlU2l6ZSA9IDE1KQogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtQ2VudGVyZWQgIlZFUklGSUNBTkRPIElOVEVHUklEQUQgTUQ1Li4uIiAiWWVsbG93IgogICAgV3JpdGUtSG9zdCAiIgoKICAgICRzcmNTdGF0cyA9IEdldC1Gb2xkZXJTdGF0cyAkT3JpZ2VuCiAgICAkZHN0U3RhdHMgPSBHZXQtRm9sZGVyU3RhdHMgJERlc3Rpbm8KICAgIFdyaXRlLUhvc3QgIiAgICBBcmNoaXZvcyAtIE9yaWdlbjogJCgkc3JjU3RhdHMuRmlsZXMpIHwgRGVzdGlubzogJCgkZHN0U3RhdHMuRmlsZXMpIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgIFdyaXRlLUhvc3QgIiAgICBUYW1hbm8gICAtIE9yaWdlbjogJChGb3JtYXQtU2l6ZSAkc3JjU3RhdHMuU2l6ZSkgfCBEZXN0aW5vOiAkKEZvcm1hdC1TaXplICRkc3RTdGF0cy5TaXplKSIgLUZvcmVncm91bmRDb2xvciBHcmF5CgogICAgJGNvdW50TWF0Y2ggPSAoJHNyY1N0YXRzLkZpbGVzIC1lcSAkZHN0U3RhdHMuRmlsZXMpCiAgICBXcml0ZS1Ib3N0ICIgICAgQ29udGVvOiAgJChpZiAoJGNvdW50TWF0Y2gpIHsgJ0NPSU5DSURFJyB9IGVsc2UgeyAnRElGRVJFTlRFIChwdWVkZSBzZXIgbm9ybWFsKScgfSkiIC1Gb3JlZ3JvdW5kQ29sb3IgJChpZiAoJGNvdW50TWF0Y2gpIHsgIkdyZWVuIiB9IGVsc2UgeyAiWWVsbG93IiB9KQoKICAgICRzcmNGaWxlcyA9IEdldC1DaGlsZEl0ZW0gLVBhdGggJE9yaWdlbiAtUmVjdXJzZSAtRmlsZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgaWYgKC1ub3QgJHNyY0ZpbGVzIC1vciAkc3JjRmlsZXMuQ291bnQgLWVxIDApIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgU2luIGFyY2hpdm9zLiIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICAgICAgcmV0dXJuIEB7IE9LID0gJHRydWU7IENoZWNrZWQgPSAwOyBQYXNzZWQgPSAwOyBGYWlsZWQgPSAwOyBNaXNzaW5nID0gMCB9CiAgICB9CgogICAgV3JpdGUtSG9zdCAiIjsgV3JpdGUtSG9zdCAiICAgIEhhc2ggTUQ1IChtdWVzdHJhIGRlICR7U2FtcGxlU2l6ZX0pLi4uIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgJGJ5U2l6ZSA9ICRzcmNGaWxlcyB8IFNvcnQtT2JqZWN0IExlbmd0aCAtRGVzY2VuZGluZyB8IFNlbGVjdC1PYmplY3QgLUZpcnN0IDUKICAgICRieURhdGUgPSAkc3JjRmlsZXMgfCBTb3J0LU9iamVjdCBMYXN0V3JpdGVUaW1lIC1EZXNjZW5kaW5nIHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgNQogICAgJHJhbmRvbUNvdW50ID0gW21hdGhdOjpNaW4oW21hdGhdOjpNYXgoMSwgJFNhbXBsZVNpemUgLSAxMCksICRzcmNGaWxlcy5Db3VudCkKICAgICRyYW5kb20gPSAkc3JjRmlsZXMgfCBHZXQtUmFuZG9tIC1Db3VudCAkcmFuZG9tQ291bnQKICAgICRzYW1wbGUgPSBAKCRieVNpemUpICsgQCgkYnlEYXRlKSArIEAoJHJhbmRvbSkgfCBTb3J0LU9iamVjdCBGdWxsTmFtZSAtVW5pcXVlIHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgJFNhbXBsZVNpemUKCiAgICAkY2hlY2tlZCA9IDA7ICRwYXNzZWQgPSAwOyAkZmFpbGVkID0gMDsgJG1pc3NpbmcgPSAwOyAkZmFpbGVkRmlsZXMgPSBAKCkKCiAgICBmb3JlYWNoICgkc2YgaW4gJHNhbXBsZSkgewogICAgICAgICRjaGVja2VkKysKICAgICAgICAkcmVsUGF0aCA9ICRzZi5GdWxsTmFtZS5TdWJzdHJpbmcoJE9yaWdlbi5MZW5ndGgpLlRyaW1TdGFydCgnXCcpCiAgICAgICAgJGRzdEZpbGUgPSBKb2luLVBhdGggJERlc3Rpbm8gJHJlbFBhdGgKICAgICAgICAkcGN0ID0gW21hdGhdOjpSb3VuZCgoJGNoZWNrZWQgLyAkc2FtcGxlLkNvdW50KSAqIDEwMCwgMCkKICAgICAgICBXcml0ZS1Ib3N0ICJgciAgICBbJHtwY3R9JV0gJHtjaGVja2VkfS8kKCRzYW1wbGUuQ291bnQpLi4uIiAtTm9OZXdsaW5lIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKCiAgICAgICAgaWYgKC1ub3QgKFRlc3QtUGF0aCAkZHN0RmlsZSkpIHsgJG1pc3NpbmcrKzsgJGZhaWxlZEZpbGVzICs9ICJGQUxUQTogJHtyZWxQYXRofSI7IGNvbnRpbnVlIH0KICAgICAgICB0cnkgewogICAgICAgICAgICAkaDEgPSAoR2V0LUZpbGVIYXNoICRzZi5GdWxsTmFtZSAtQWxnb3JpdGhtIE1ENSAtRXJyb3JBY3Rpb24gU3RvcCkuSGFzaAogICAgICAgICAgICAkaDIgPSAoR2V0LUZpbGVIYXNoICRkc3RGaWxlIC1BbGdvcml0aG0gTUQ1IC1FcnJvckFjdGlvbiBTdG9wKS5IYXNoCiAgICAgICAgICAgIGlmICgkaDEgLWVxICRoMikgeyAkcGFzc2VkKysgfSBlbHNlIHsgJGZhaWxlZCsrOyAkZmFpbGVkRmlsZXMgKz0gIkNPUlJVUFRPOiAke3JlbFBhdGh9IiB9CiAgICAgICAgfSBjYXRjaCB7ICRmYWlsZWQrKzsgJGZhaWxlZEZpbGVzICs9ICJFUlJPUjogJHtyZWxQYXRofSIgfQogICAgfQoKICAgIFdyaXRlLUhvc3QgIiI7IFdyaXRlLUhvc3QgIiIKICAgIGlmICgkZmFpbGVkIC1lcSAwIC1hbmQgJG1pc3NpbmcgLWVxIDApIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW09LXSBJTlRFR1JJREFEOiAke3Bhc3NlZH0vJHtjaGVja2VkfSB2ZXJpZmljYWRvcyIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgfSBlbHNlIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgWyEhXSBPSz0ke3Bhc3NlZH0gfCBGQUxMT1M9JHtmYWlsZWR9IHwgRkFMVEFOVEVTPSR7bWlzc2luZ30iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgZm9yZWFjaCAoJGYgaW4gJGZhaWxlZEZpbGVzKSB7IFdyaXRlLUhvc3QgIiAgICAgICAgICRmIiAtRm9yZWdyb3VuZENvbG9yIFJlZCB9CiAgICB9CiAgICByZXR1cm4gQHsgT0sgPSAoJGZhaWxlZCAtZXEgMCAtYW5kICRtaXNzaW5nIC1lcSAwKTsgQ2hlY2tlZCA9ICRjaGVja2VkOyBQYXNzZWQgPSAkcGFzc2VkOyBGYWlsZWQgPSAkZmFpbGVkOyBNaXNzaW5nID0gJG1pc3NpbmcgfQp9CgojID09PT09PT09PT09PT09PT09PT09IEVKRUNVVEFSIEZBU1RDT1BZID09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBTdGFydC1GYXN0Q29weSB7CiAgICBwYXJhbSgKICAgICAgICBbc3RyaW5nXSRGYXN0Q29weUV4ZSwgW3N0cmluZ1tdXSRPcmlnaW5zLCBbc3RyaW5nXSREZXN0aW5vLAogICAgICAgIFtzdHJpbmddJE1vZGUsIFtzdHJpbmddJFNwZWVkTW9kZSwgW3N0cmluZ10kRGlza1R5cGUsCiAgICAgICAgW2FycmF5XSRFeGNsdWRlRmlsZXMsIFthcnJheV0kRXhjbHVkZURpcnMKICAgICkKCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1DZW50ZXJlZCAiRUpFQ1VUQU5ETyBGQVNUQ09QWSAoJHtEaXNrVHlwZX0gfCAke01vZGV9IHwgc3BlZWQ9JHtTcGVlZE1vZGV9KSIgIlllbGxvdyIKICAgIFdyaXRlLUhvc3QgIiIKCiAgICAkc3cgPSBbU3lzdGVtLkRpYWdub3N0aWNzLlN0b3B3YXRjaF06OlN0YXJ0TmV3KCkKICAgICRhbGxSZXN1bHRzID0gQCgpCiAgICAkdG90YWxCeXRlc0NvcGllZCA9IDAKICAgICRhbGxPSyA9ICR0cnVlCiAgICAkbG9nRmlsZSA9IEpvaW4tUGF0aCAoW0Vudmlyb25tZW50XTo6R2V0Rm9sZGVyUGF0aCgiRGVza3RvcCIpKSAiTG9nX0Zhc3RDb3B5XyQoR2V0LURhdGUgLUZvcm1hdCAneXl5eS1NTS1kZF9ISG1tJykubG9nIgoKICAgIGZvcmVhY2ggKCRvcmlnZW4gaW4gJE9yaWdpbnMpIHsKICAgICAgICAkc3JjTmFtZSA9IFNwbGl0LVBhdGggJG9yaWdlbiAtTGVhZgogICAgICAgIFdyaXRlLUhvc3QgIiAgICBDb3BpYW5kbzogJHtzcmNOYW1lfS4uLiIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgCiAgICAgICAgJGZjQXJncyA9IEAoKQogICAgICAgIHN3aXRjaCAoJE1vZGUpIHsKICAgICAgICAgICAgIkNPTVBMRVRBIiAgICB7ICRmY0FyZ3MgKz0gIi9jbWQ9Zm9yY2VfY29weSIgfQogICAgICAgICAgICAiSU5DUkVNRU5UQUwiIHsgJGZjQXJncyArPSAiL2NtZD1kaWZmIiB9CiAgICAgICAgICAgICJNT1ZFUiIgICAgICAgeyAkZmNBcmdzICs9ICIvY21kPW1vdmUiIH0KICAgICAgICAgICAgIlNJTkNST05JWkFSIiB7ICRmY0FyZ3MgKz0gIi9jbWQ9c3luYyIgfQogICAgICAgICAgICBkZWZhdWx0ICAgICAgIHsgJGZjQXJncyArPSAiL2NtZD1mb3JjZV9jb3B5IiB9CiAgICAgICAgfQoKICAgICAgICAkZmNBcmdzICs9ICIvc3BlZWQ9JHtTcGVlZE1vZGV9IgogICAgICAgICRmY0FyZ3MgKz0gIi9lc3RpbWF0ZSIKICAgICAgICAkZmNBcmdzICs9ICIvYXV0b19jbG9zZSIKICAgICAgICAkZmNBcmdzICs9ICIvZXJyb3Jfc3RvcD1GQUxTRSIKICAgICAgICAkZmNBcmdzICs9ICIvbG9nIgogICAgICAgICRmY0FyZ3MgKz0gIi9sb2dmaWxlPWAiJHtsb2dGaWxlfWAiIgoKICAgICAgICBpZiAoLW5vdCAoVGVzdC1QYXRoICREZXN0aW5vKSkgewogICAgICAgICAgICBOZXctSXRlbSAtSXRlbVR5cGUgRGlyZWN0b3J5IC1QYXRoICREZXN0aW5vIC1Gb3JjZSB8IE91dC1OdWxsCiAgICAgICAgfQoKICAgICAgICAjIEV4Y2x1c2lvbmVzCiAgICAgICAgaWYgKCRFeGNsdWRlRmlsZXMgLWFuZCAkRXhjbHVkZUZpbGVzLkNvdW50IC1ndCAwKSB7CiAgICAgICAgICAgICRleGNsU3RyID0gKCRFeGNsdWRlRmlsZXMgLWpvaW4gIjsiKQogICAgICAgICAgICAkZmNBcmdzICs9ICIvZXhjbHVkZT1gIiR7ZXhjbFN0cn1gIiIKICAgICAgICB9CgogICAgICAgICRmY0FyZ3MgKz0gImAiJHtvcmlnZW59YCIiCiAgICAgICAgJGZjQXJncyArPSAiL3RvPWAiJHtEZXN0aW5vfVxgIiIKCiAgICAgICAgJGFyZ1N0cmluZyA9ICRmY0FyZ3MgLWpvaW4gIiAiCgogICAgICAgICRwcmVTaXplID0gMAogICAgICAgIGlmIChUZXN0LVBhdGggJERlc3Rpbm8pIHsKICAgICAgICAgICAgdHJ5IHsgJHByZVNpemUgPSAoR2V0LUNoaWxkSXRlbSAkRGVzdGlubyAtUmVjdXJzZSAtRmlsZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSB8IE1lYXN1cmUtT2JqZWN0IExlbmd0aCAtU3VtKS5TdW0gfSBjYXRjaCB7fQogICAgICAgICAgICBpZiAoLW5vdCAkcHJlU2l6ZSkgeyAkcHJlU2l6ZSA9IDAgfQogICAgICAgIH0KCiAgICAgICAgJHByb2Nlc3MgPSBTdGFydC1Qcm9jZXNzIC1GaWxlUGF0aCAkRmFzdENvcHlFeGUgLUFyZ3VtZW50TGlzdCAkYXJnU3RyaW5nIC1QYXNzVGhydSAtV2FpdAogICAgICAgICRleGl0Q29kZSA9ICRwcm9jZXNzLkV4aXRDb2RlCgogICAgICAgICRwb3N0U2l6ZSA9IDAKICAgICAgICBpZiAoVGVzdC1QYXRoICREZXN0aW5vKSB7CiAgICAgICAgICAgIHRyeSB7ICRwb3N0U2l6ZSA9IChHZXQtQ2hpbGRJdGVtICREZXN0aW5vIC1SZWN1cnNlIC1GaWxlIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlIHwgTWVhc3VyZS1PYmplY3QgTGVuZ3RoIC1TdW0pLlN1bSB9IGNhdGNoIHt9CiAgICAgICAgICAgIGlmICgtbm90ICRwb3N0U2l6ZSkgeyAkcG9zdFNpemUgPSAwIH0KICAgICAgICB9CiAgICAgICAgJGNvcGllZCA9IFttYXRoXTo6TWF4KDAsICRwb3N0U2l6ZSAtICRwcmVTaXplKQogICAgICAgICR0b3RhbEJ5dGVzQ29waWVkICs9ICRjb3BpZWQKCiAgICAgICAgaWYgKCRleGl0Q29kZSAtbmUgMCkgeyAkYWxsT0sgPSAkZmFsc2UgfQoKICAgICAgICAkc3RhdHVzSWNvbiA9IGlmICgkZXhpdENvZGUgLWVxIDApIHsgIltPS10iIH0gZWxzZSB7ICJbISFdIiB9CiAgICAgICAgJHN0YXR1c0NvbG9yID0gaWYgKCRleGl0Q29kZSAtZXEgMCkgeyAiR3JlZW4iIH0gZWxzZSB7ICJSZWQiIH0KICAgICAgICBXcml0ZS1Ib3N0ICIgICAgJHtzdGF0dXNJY29ufSAke3NyY05hbWV9IC0gJChGb3JtYXQtU2l6ZSAkY29waWVkKSIgLUZvcmVncm91bmRDb2xvciAkc3RhdHVzQ29sb3IKICAgIH0KCiAgICAkc3cuU3RvcCgpOyAkZWxhcHNlZCA9ICRzdy5FbGFwc2VkCiAgICAkc3BlZWRNQnBzID0gaWYgKCRlbGFwc2VkLlRvdGFsU2Vjb25kcyAtZ3QgMCkgeyBbbWF0aF06OlJvdW5kKCgkdG90YWxCeXRlc0NvcGllZCAvIDFNQikgLyAkZWxhcHNlZC5Ub3RhbFNlY29uZHMsIDEpIH0gZWxzZSB7IDAgfQoKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgJHJlc3VsdENvbG9yID0gaWYgKCRhbGxPSykgeyAiR3JlZW4iIH0gZWxzZSB7ICJSZWQiIH0KICAgICRyZXN1bHRNc2cgPSBpZiAoJGFsbE9LKSB7ICJDT01QTEVUQURPIEVYSVRPU0FNRU5URSIgfSBlbHNlIHsgIkNPTVBMRVRBRE8gQ09OIEVSUk9SRVMgLSByZXZpc2EgZWwgbG9nIiB9CiAgICBXcml0ZS1Ib3N0ICIgICAgUkVTVUxUQURPOiAke3Jlc3VsdE1zZ30iIC1Gb3JlZ3JvdW5kQ29sb3IgJHJlc3VsdENvbG9yCiAgICBXcml0ZS1Ib3N0ICIgICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgICBPcmlnZW5lczogICQoJE9yaWdpbnMuQ291bnQpIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgIFdyaXRlLUhvc3QgIiAgICBUaWVtcG86ICAgICQoRm9ybWF0LUR1cmF0aW9uICRlbGFwc2VkKSIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgQ29waWFkbzogICAkKEZvcm1hdC1TaXplICR0b3RhbEJ5dGVzQ29waWVkKSIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgVmVsb2NpZGFkOiAke3NwZWVkTUJwc30gTUIvcyIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgTG9nOiAgICAgICAkKFNwbGl0LVBhdGggJGxvZ0ZpbGUgLUxlYWYpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgcmV0dXJuIEB7CiAgICAgICAgRXhpdENvZGUgPSAkKGlmICgkYWxsT0spIHsgMCB9IGVsc2UgeyAxIH0pOyBPSyA9ICRhbGxPSzsgRWxhcHNlZCA9ICRlbGFwc2VkCiAgICAgICAgQnl0ZXNDb3BpZWQgPSAkdG90YWxCeXRlc0NvcGllZDsgU3BlZWRNQnBzID0gJHNwZWVkTUJwczsgTG9nRmlsZSA9ICRsb2dGaWxlCiAgICB9Cn0KCiMgPT09PT09PT09PT09PT09PT09PT0gSU5JQ0lPID09PT09PT09PT09PT09PT09PT09CgpDbGVhci1Ib3N0CgokZmFzdENvcHlFeGUgPSBGaW5kLUZhc3RDb3B5CgppZiAoLW5vdCAkZmFzdENvcHlFeGUpIHsKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUNlbnRlcmVkICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgIlJlZCIKICAgIFdyaXRlLUNlbnRlcmVkICJGQVNUQ09QWSBOTyBFTkNPTlRSQURPIiAiUmVkIgogICAgV3JpdGUtQ2VudGVyZWQgIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAiUmVkIgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICAgIEJ1c2NhZG8gZW46IiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgLSBDYXJwZXRhIGRlbCBzY3JpcHQgKCRQU1NjcmlwdFJvb3QpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgLSBQcm9ncmFtIEZpbGVzIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgLSBQQVRIIGRlbCBzaXN0ZW1hIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgLSAkZW52OkxPQ0FMQVBQREFUQVxBdGxhc1BDXGFwcHNcRmFzdENvcHkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgICBPcGNpb25lczoiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICBXcml0ZS1Ib3N0ICIgICAgICBbRF0gRGVzY2FyZ2FyIGF1dG9tYXRpY2FtZW50ZSBkZSBmYXN0Y29weS5qcCAocmVjb21lbmRhZG8pIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICBXcml0ZS1Ib3N0ICIgICAgICBbU10gU2FsaXIgZSBpbnN0YWxhcmxvIG1hbnVhbG1lbnRlIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICBXcml0ZS1Ib3N0ICIiCiAgICAkY2hvaWNlID0gUmVhZC1Ib3N0ICIgICAgU2VsZWNjaW9uIFtEL1NdIgoKICAgIGlmICgkY2hvaWNlIC1tYXRjaCAnXltEZF0kJykgewogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRGVzY2FyZ2FuZG8gRmFzdENvcHkuLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgIHRyeSB7CiAgICAgICAgICAgICRmYXN0Q29weUV4ZSA9IEluc3RhbGwtRmFzdENvcHlBdXRvCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIEZhc3RDb3B5IGluc3RhbGFkbzogJGZhc3RDb3B5RXhlIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgIFN0YXJ0LVNsZWVwIC1TZWNvbmRzIDEKICAgICAgICB9IGNhdGNoIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRVJST1IgZW4gbGEgZGVzY2FyZ2E6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRGVzY2FyZ2EgbWFudWFsOiBodHRwczovL2Zhc3Rjb3B5LmpwIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICBSZWFkLUhvc3QgIiAgICBFTlRFUiBwYXJhIHNhbGlyIgogICAgICAgICAgICByZXR1cm4KICAgICAgICB9CiAgICB9IGVsc2UgewogICAgICAgIFdyaXRlLUhvc3QgIiAgICBBYnJlIGh0dHBzOi8vZmFzdGNvcHkuanAgeSBjb2xvY2EgRmFzdENvcHkuZXhlIGVuOiIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgJGVudjpMT0NBTEFQUERBVEFcQXRsYXNQQ1xhcHBzXEZhc3RDb3B5XCIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICAgICAgUmVhZC1Ib3N0ICIgICAgRU5URVIgcGFyYSBzYWxpciIKICAgICAgICByZXR1cm4KICAgIH0KfQoKIyA9PT09PT09PT09PT09PT09PT09PSBCVUNMRSBQUklOQ0lQQUwgPT09PT09PT09PT09PT09PT09PT0KCmRvIHsKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iICJDeWFuIgogICAgV3JpdGUtQ2VudGVyZWQgInwgICAgICAgQVRMQVMgUEMgU1VQUE9SVCAtIEZBU1RDT1BZIEVESVRJT04gdjMgICAgICAgICAgIHwiICJZZWxsb3ciCiAgICBXcml0ZS1DZW50ZXJlZCAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgIkN5YW4iCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICAgTW90b3I6ICQoU3BsaXQtUGF0aCAkZmFzdENvcHlFeGUgLUxlYWYpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1DZW50ZXJlZCAiWyAxIF0gQ29waWEgbm9ybWFsICh1biBvcmlnZW4pIiAiV2hpdGUiCiAgICBXcml0ZS1DZW50ZXJlZCAiWyAyIF0gTXVsdGktb3JpZ2VuICh2YXJpYXMgY2FycGV0YXMpIiAiV2hpdGUiCiAgICBXcml0ZS1DZW50ZXJlZCAiWyAzIF0gUGVyZmlsIHJhcGlkbyAocmVzcGFsZG8gZGUgdXN1YXJpbykiICJDeWFuIgogICAgV3JpdGUtQ2VudGVyZWQgIlsgUyBdIFNhbGlyIiAiRGFya0dyYXkiCiAgICBXcml0ZS1Ib3N0ICIiCiAgICAKICAgICRtZW51U2VsID0gUmVhZC1Ib3N0ICIgICAgICA+IgogICAgaWYgKCRtZW51U2VsIC1lcSAiUyIgLW9yICRtZW51U2VsIC1lcSAicyIpIHsgZXhpdCB9CgogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICMgT0JURU5FUiBPUklHRU5FUwogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICRvcmlnZW5lcyA9IEAoKQogICAgJGlzTXVsdGkgPSAkZmFsc2UKICAgICRpc1Byb2ZpbGUgPSAkZmFsc2UKICAgICRwcm9maWxlTmFtZSA9ICIiCgogICAgc3dpdGNoICgkbWVudVNlbCkgewogICAgICAgICIxIiB7CiAgICAgICAgICAgICMgVW4gc29sbyBvcmlnZW4KICAgICAgICAgICAgOmFza1NpbmdsZSB3aGlsZSAoJHRydWUpIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgWzFdIE9SSUdFTjoiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICAgICAgICAgICRwYXRoUmVzdWx0ID0gR2V0LVBhdGhGcm9tVXNlciAtUHJvbXB0ICJPUklHRU4iIC1Nb2RlICJhbnkiCiAgICAgICAgICAgICAgICBpZiAoJHBhdGhSZXN1bHQgLWVxICJFWElUIikgeyBleGl0IH0KICAgICAgICAgICAgICAgIGlmICgkcGF0aFJlc3VsdCAtZXEgIkJBQ0siKSB7IGJyZWFrIH0KICAgICAgICAgICAgICAgIGlmICgtbm90IChUZXN0LVBhdGggJHBhdGhSZXN1bHQpKSB7CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW0VSUk9SXSBObyBleGlzdGU6ICR7cGF0aFJlc3VsdH0iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgICAgICAgICAgY29udGludWUKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICRvcmlnZW5lcyA9IEAoJHBhdGhSZXN1bHQpCiAgICAgICAgICAgICAgICBicmVhawogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgICIyIiB7CiAgICAgICAgICAgICRtdWx0aVJlc3VsdCA9IEdldC1NdWx0aXBsZU9yaWdpbnMKICAgICAgICAgICAgaWYgKCRtdWx0aVJlc3VsdCAtZXEgIkVYSVQiKSB7IGV4aXQgfQogICAgICAgICAgICBpZiAoJG11bHRpUmVzdWx0IC1lcSAiQkFDSyIpIHsgY29udGludWUgfQogICAgICAgICAgICAkb3JpZ2VuZXMgPSBAKCRtdWx0aVJlc3VsdCkKICAgICAgICAgICAgJGlzTXVsdGkgPSAkdHJ1ZQogICAgICAgIH0KICAgICAgICAiMyIgewogICAgICAgICAgICAkcHJvZmlsZSA9IFNob3ctUHJvZmlsZU1lbnUKICAgICAgICAgICAgaWYgKC1ub3QgJHByb2ZpbGUpIHsgY29udGludWUgfQogICAgICAgICAgICAkb3JpZ2VuZXMgPSBAKCRwcm9maWxlLlBhdGhzKQogICAgICAgICAgICAkaXNQcm9maWxlID0gJHRydWUKICAgICAgICAgICAgJHByb2ZpbGVOYW1lID0gJHByb2ZpbGUuTmFtZQogICAgICAgIH0KICAgICAgICBkZWZhdWx0IHsgY29udGludWUgfQogICAgfQoKICAgIGlmICgkb3JpZ2VuZXMuQ291bnQgLWVxIDApIHsgY29udGludWUgfQoKICAgICMgTW9zdHJhciBvcmlnZW5lcyBzZWxlY2Npb25hZG9zCiAgICBXcml0ZS1Ib3N0ICIiCiAgICAkdG90YWxTaXplID0gMDsgJHRvdGFsRmlsZXMgPSAwCiAgICBmb3JlYWNoICgkbyBpbiAkb3JpZ2VuZXMpIHsKICAgICAgICAkb05hbWUgPSBTcGxpdC1QYXRoICRvIC1MZWFmCiAgICAgICAgaWYgKFRlc3QtUGF0aCAkbyAtUGF0aFR5cGUgQ29udGFpbmVyKSB7CiAgICAgICAgICAgICRzdGF0cyA9IEdldC1Gb2xkZXJTdGF0cyAkbwogICAgICAgICAgICAkdG90YWxTaXplICs9ICRzdGF0cy5TaXplOyAkdG90YWxGaWxlcyArPSAkc3RhdHMuRmlsZXMKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW09LXSAke29OYW1lfSAoJCgkc3RhdHMuRmlsZXMpIGFyY2hpdm9zLCAkKEZvcm1hdC1TaXplICRzdGF0cy5TaXplKSkiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAkZmkgPSBHZXQtSXRlbSAkbwogICAgICAgICAgICAkdG90YWxTaXplICs9ICRmaS5MZW5ndGg7ICR0b3RhbEZpbGVzKysKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW09LXSAke29OYW1lfSAoJChGb3JtYXQtU2l6ZSAkZmkuTGVuZ3RoKSkiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICB9CiAgICB9CiAgICAkc3JjU3RhdHMgPSBAeyBGaWxlcyA9ICR0b3RhbEZpbGVzOyBTaXplID0gJHRvdGFsU2l6ZTsgU2l6ZU1CID0gW21hdGhdOjpSb3VuZCgkdG90YWxTaXplIC8gMU1CLCAxKSB9CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICAgICBUT1RBTDogJHt0b3RhbEZpbGVzfSBhcmNoaXZvcyB8ICQoRm9ybWF0LVNpemUgJHRvdGFsU2l6ZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBERVNUSU5PCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgJGRlc3Rpbm8gPSAkbnVsbDsgJGRyaXZlSW5mbyA9ICRudWxsCgogICAgOmFza0Rlc3Qgd2hpbGUgKCR0cnVlKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgWzJdIERFU1RJTk86IiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgJHBhdGhSZXN1bHQgPSBHZXQtUGF0aEZyb21Vc2VyIC1Qcm9tcHQgIkRFU1RJTk8iIC1Nb2RlICJmb2xkZXIiCiAgICAgICAgaWYgKCRwYXRoUmVzdWx0IC1lcSAiRVhJVCIpIHsgZXhpdCB9CiAgICAgICAgaWYgKCRwYXRoUmVzdWx0IC1lcSAiQkFDSyIpIHsgYnJlYWsgfQogICAgICAgIGlmICgtbm90IChUZXN0LVBhdGggJHBhdGhSZXN1bHQpKSB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtFUlJPUl0gTm8gYWNjZXNpYmxlOiAke3BhdGhSZXN1bHR9IiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICBjb250aW51ZQogICAgICAgIH0KCiAgICAgICAgIyBWYWxpZGFyIHF1ZSBuaW5ndW4gb3JpZ2VuIHNlYSBlbCBkZXN0aW5vCiAgICAgICAgJGNvbmZsaWN0ID0gJGZhbHNlCiAgICAgICAgZm9yZWFjaCAoJG8gaW4gJG9yaWdlbmVzKSB7CiAgICAgICAgICAgIHRyeSB7CiAgICAgICAgICAgICAgICAkZk8gPSAoUmVzb2x2ZS1QYXRoICRvKS5QYXRoOyAkZkQgPSAoUmVzb2x2ZS1QYXRoICRwYXRoUmVzdWx0KS5QYXRoCiAgICAgICAgICAgICAgICBpZiAoJGZPIC1lcSAkZkQpIHsgV3JpdGUtSG9zdCAiICAgICAgW0VSUk9SXSBPcmlnZW4gPSBEZXN0aW5vOiAkbyIgLUZvcmVncm91bmRDb2xvciBSZWQ7ICRjb25mbGljdCA9ICR0cnVlOyBicmVhayB9CiAgICAgICAgICAgIH0gY2F0Y2gge30KICAgICAgICB9CiAgICAgICAgaWYgKCRjb25mbGljdCkgeyBjb250aW51ZSB9CgogICAgICAgICRkZXN0RHJpdmVMZXR0ZXIgPSAkcGF0aFJlc3VsdC5TdWJzdHJpbmcoMCwgMSkKICAgICAgICAkZHJpdmVJbmZvID0gRGV0ZWN0LURyaXZlVHlwZSAkZGVzdERyaXZlTGV0dGVyCiAgICAgICAgJGxhYmVsRGlzcGxheSA9IGlmICgkZHJpdmVJbmZvLkxhYmVsKSB7ICIgKCQoJGRyaXZlSW5mby5MYWJlbCkpIiB9IGVsc2UgeyAiIiB9CiAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW09LXSBEaXNjbzogJCgkZHJpdmVJbmZvLkRlc2MpJHtsYWJlbERpc3BsYXl9IiAtRm9yZWdyb3VuZENvbG9yICRkcml2ZUluZm8uQ29sb3IKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBMaWJyZTogJChGb3JtYXQtU2l6ZSAkZHJpdmVJbmZvLkZyZWVCeXRlcykiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JheQoKICAgICAgICBpZiAoJGRyaXZlSW5mby5GcmVlQnl0ZXMgLWd0IDAgLWFuZCAkdG90YWxTaXplIC1ndCAkZHJpdmVJbmZvLkZyZWVCeXRlcykgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbISEhXSBFU1BBQ0lPIElOU1VGSUNJRU5URSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgTmVjZXNpdGFzOiAkKEZvcm1hdC1TaXplICR0b3RhbFNpemUpIHwgRGlzcG9uaWJsZTogJChGb3JtYXQtU2l6ZSAkZHJpdmVJbmZvLkZyZWVCeXRlcykiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtGXSBGb3J6YXIgIFtCXSBWb2x2ZXIiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICRlc3BPcCA9IFJlYWQtSG9zdCAiICAgICAgPiIKICAgICAgICAgICAgaWYgKCRlc3BPcCAtbmUgIkYiIC1hbmQgJGVzcE9wIC1uZSAiZiIpIHsgY29udGludWUgfQogICAgICAgIH0KICAgICAgICAkZGVzdGlubyA9ICRwYXRoUmVzdWx0OyBicmVhawogICAgfQogICAgaWYgKC1ub3QgJGRlc3Rpbm8pIHsgY29udGludWUgfQoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAjIE5PTUJSRQogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgWzNdIE5vbWJyZSBkZWwgcHJveWVjdG8gKEVOVEVSID0gUmVzcGFsZG8pOiIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgJGNsaWVudGUgPSBSZWFkLUhvc3QgIiAgICAgIE5PTUJSRSIKICAgIGlmIChbc3RyaW5nXTo6SXNOdWxsT3JXaGl0ZVNwYWNlKCRjbGllbnRlKSkgewogICAgICAgIGlmICgkaXNQcm9maWxlKSB7ICRjbGllbnRlID0gJHByb2ZpbGVOYW1lIC1yZXBsYWNlICdccysnLCAnXycgfQogICAgICAgIGVsc2UgeyAkY2xpZW50ZSA9ICJSZXNwYWxkbyIgfQogICAgfQogICAgJGNsaWVudGUgPSAkY2xpZW50ZSAtcmVwbGFjZSAnW1xcLzoqPyI8PnxdJywgJ18nCiAgICAkZmVjaGFIb3kgPSBHZXQtRGF0ZSAtRm9ybWF0ICd5eXl5LU1NLWRkJwogICAgJHJ1dGFGaW5hbCA9IEpvaW4tUGF0aCAkZGVzdGlubyAiJHtjbGllbnRlfV8ke2ZlY2hhSG95fSIKCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBNT0RPCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICBbNF0gTU9ETyBERSBDT1BJQToiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiICAgICAgWzFdIENPTVBMRVRBICAgICAtIENvcGlhIHRvZG8iIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiAgICAgIFsyXSBJTkNSRU1FTlRBTCAgLSBTb2xvIG51ZXZvcy9tb2RpZmljYWRvcyIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiICAgICAgWzNdIFNJTkNST05JWkFSICAtIEVzcGVqbyBleGFjdG8iIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiAgICAgIFs0XSBNT1ZFUiAgICAgICAgLSBNdWV2ZSAoYm9ycmEgb3JpZ2VuKSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgIFdyaXRlLUhvc3QgIiAgICAgIFtCXSBWb2x2ZXIiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiIKICAgICRtb2RvU2VsID0gUmVhZC1Ib3N0ICIgICAgICA+IgogICAgaWYgKCRtb2RvU2VsIC1lcSAiQiIgLW9yICRtb2RvU2VsIC1lcSAiYiIpIHsgY29udGludWUgfQogICAgJG1vZG8gPSBzd2l0Y2ggKCRtb2RvU2VsKSB7CiAgICAgICAgIjIiIHsgIklOQ1JFTUVOVEFMIiB9CiAgICAgICAgIjMiIHsgIlNJTkNST05JWkFSIiB9CiAgICAgICAgIjQiIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgWyEhIV0gRWxpbWluYXJhIGFyY2hpdm9zIGRlbCBPUklHRU4uIFNlZ3Vybz8gW1MvTl0iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgICRtYyA9IFJlYWQtSG9zdCAiICAgICAgPiIKICAgICAgICAgICAgaWYgKCRtYyAtZXEgIlMiIC1vciAkbWMgLWVxICJzIikgeyAiTU9WRVIiIH0gZWxzZSB7ICJTS0lQIiB9CiAgICAgICAgfQogICAgICAgIGRlZmF1bHQgeyAiQ09NUExFVEEiIH0KICAgIH0KICAgIGlmICgkbW9kbyAtZXEgIlNLSVAiKSB7IGNvbnRpbnVlIH0KCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBFWENMVVNJT05FUwogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICRleGNsdXNpb25zID0gQHsgRmlsZXMgPSBAKCk7IERpcnMgPSBAKCk7IExhYmVsID0gIk5pbmd1bmEiIH0KICAgIGlmICgkb3JpZ2VuZXMuQ291bnQgLWdlIDEpIHsKICAgICAgICAkZXhjbFJlc3VsdCA9IEdldC1FeGNsdXNpb25zCiAgICAgICAgaWYgKCRleGNsUmVzdWx0IC1lcSAiQkFDSyIpIHsgY29udGludWUgfQogICAgICAgIGlmICgkZXhjbFJlc3VsdCkgeyAkZXhjbHVzaW9ucyA9ICRleGNsUmVzdWx0IH0KICAgIH0KCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBDT01QQVJBUiAoc29sbyBpbmNyZW1lbnRhbCBvIHNpIGhheSBkZXN0aW5vIHByZXZpbykKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAkY29tcGFyaXNvbiA9ICRudWxsCiAgICBpZiAoVGVzdC1QYXRoICRydXRhRmluYWwpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgRGVzdGlubyB5YSBleGlzdGUuIEFuYWxpemFyIGRpZmVyZW5jaWFzPyBbUy9OXSIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAkY29tcFNlbCA9IFJlYWQtSG9zdCAiICAgICAgPiIKICAgICAgICBpZiAoJGNvbXBTZWwgLWVxICJTIiAtb3IgJGNvbXBTZWwgLWVxICJzIikgewogICAgICAgICAgICAkY29tcGFyaXNvbiA9IENvbXBhcmUtQmVmb3JlQ29weSAtT3JpZ2lucyAkb3JpZ2VuZXMgLURlc3Rpbm8gJHJ1dGFGaW5hbAogICAgICAgIH0KICAgIH0KCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBQUkVWSUVXCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgQ2xlYXItSG9zdAogICAgV3JpdGUtSG9zdCAiYG4iCiAgICBXcml0ZS1DZW50ZXJlZCAiPT09PT09PT09PT09PT09PT09PT0gUFJFVklFVyA9PT09PT09PT09PT09PT09PT09PSIgIldoaXRlIgogICAgV3JpdGUtSG9zdCAiIgogICAgCiAgICBpZiAoJGlzUHJvZmlsZSkgewogICAgICAgIFdyaXRlLUhvc3QgIiAgICBQRVJGSUw6ICAgICR7cHJvZmlsZU5hbWV9IiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIH0KICAgIFdyaXRlLUhvc3QgIiAgICBPUklHRU5FUzogICQoJG9yaWdlbmVzLkNvdW50KSIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICBmb3JlYWNoICgkbyBpbiAkb3JpZ2VuZXMpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICAgICAgICAgICAkKFNwbGl0LVBhdGggJG8gLUxlYWYpIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICB9CiAgICBXcml0ZS1Ib3N0ICIgICAgVE9UQUw6ICAgICAke3RvdGFsRmlsZXN9IGFyY2hpdm9zIHwgJChGb3JtYXQtU2l6ZSAkdG90YWxTaXplKSIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICAgREVTVElOTzogICAke3J1dGFGaW5hbH0iIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiAgICBESVNDTzogICAgICQoJGRyaXZlSW5mby5EZXNjKSIgLUZvcmVncm91bmRDb2xvciAkZHJpdmVJbmZvLkNvbG9yCiAgICBXcml0ZS1Ib3N0ICIgICAgTU9ETzogICAgICAke21vZG99IiAtRm9yZWdyb3VuZENvbG9yICQoaWYgKCRtb2RvIC1lcSAiTU9WRVIiKSB7ICJSZWQiIH0gZWxzZWlmICgkbW9kbyAtZXEgIlNJTkNST05JWkFSIikgeyAiWWVsbG93IiB9IGVsc2UgeyAiQ3lhbiIgfSkKICAgIFdyaXRlLUhvc3QgIiAgICBTUEVFRDogICAgICQoJGRyaXZlSW5mby5TcGVlZCkgKGF1dG8pIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgIFdyaXRlLUhvc3QgIiAgICBFWENMVUlSOiAgICQoJGV4Y2x1c2lvbnMuTGFiZWwpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgaWYgKCRjb21wYXJpc29uKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgICBBTkFMSVNJUzogICQoJGNvbXBhcmlzb24uTmV3KSBudWV2b3MsICQoJGNvbXBhcmlzb24uTW9kaWZpZWQpIG1vZGlmaWNhZG9zLCAkKCRjb21wYXJpc29uLkVxdWFsKSBpZ3VhbGVzIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgICAgICBXcml0ZS1Ib3N0ICIgICAgVFJBTlNGRVJJUjogJChGb3JtYXQtU2l6ZSAkY29tcGFyaXNvbi5TaXplVG90YWwpIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIH0KCiAgICAkYXZnU3BlZWQgPSBzd2l0Y2ggKCRkcml2ZUluZm8uVHlwZSkgeyAiVVNCIiB7IDMwIH0gIkhERCIgeyAxMDAgfSAiU1NEIiB7IDQwMCB9IGRlZmF1bHQgeyA1MCB9IH0KICAgICRlc3RTaXplID0gaWYgKCRjb21wYXJpc29uKSB7ICRjb21wYXJpc29uLlNpemVUb3RhbCB9IGVsc2UgeyAkdG90YWxTaXplIH0KICAgIGlmICgkZXN0U2l6ZSAtZ3QgMCkgewogICAgICAgICRldGFTZWMgPSAoJGVzdFNpemUgLyAxTUIpIC8gJGF2Z1NwZWVkCiAgICAgICAgJGV0YVNwYW4gPSBbVGltZVNwYW5dOjpGcm9tU2Vjb25kcygkZXRhU2VjKQogICAgICAgIFdyaXRlLUhvc3QgIiAgICBFVEE6ICAgICAgIH4kKEZvcm1hdC1EdXJhdGlvbiAkZXRhU3BhbikiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIH0KCiAgICBpZiAoJG1vZG8gLWVxICJNT1ZFUiIpIHsgV3JpdGUtSG9zdCAiIjsgV3JpdGUtSG9zdCAiICAgIFshISFdIEFSQ0hJVk9TIFNFIEVMSU1JTkFSQU4gREVMIE9SSUdFTiIgLUZvcmVncm91bmRDb2xvciBSZWQgfQogICAgaWYgKCRtb2RvIC1lcSAiU0lOQ1JPTklaQVIiKSB7IFdyaXRlLUhvc3QgIiI7IFdyaXRlLUhvc3QgIiAgICBbIV0gRXh0cmFzIGVuIGRlc3Rpbm8gc2VyYW4gRUxJTUlOQURPUyIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cgfQoKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUNlbnRlcmVkICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAiV2hpdGUiCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICAgW1NdIElOSUNJQVIgIFtCXSBWb2x2ZXIgIFtOXSBDYW5jZWxhciIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiIgogICAgJGNvbmZpcm1hciA9IFJlYWQtSG9zdCAiICAgID4iCiAgICBpZiAoJGNvbmZpcm1hciAtbmUgIlMiIC1hbmQgJGNvbmZpcm1hciAtbmUgInMiKSB7IGNvbnRpbnVlIH0KCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBFSkVDVVRBUgogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgImBuIgoKICAgICRyZXN1bHQgPSBTdGFydC1GYXN0Q29weSAtRmFzdENvcHlFeGUgJGZhc3RDb3B5RXhlIC1PcmlnaW5zICRvcmlnZW5lcyAtRGVzdGlubyAkcnV0YUZpbmFsIGAKICAgICAgICAtTW9kZSAkbW9kbyAtU3BlZWRNb2RlICRkcml2ZUluZm8uU3BlZWQgLURpc2tUeXBlICRkcml2ZUluZm8uVHlwZSBgCiAgICAgICAgLUV4Y2x1ZGVGaWxlcyAkZXhjbHVzaW9ucy5GaWxlcyAtRXhjbHVkZURpcnMgJGV4Y2x1c2lvbnMuRGlycwoKICAgICMgTk9USUZJQ0FDSU9OCiAgICAkbm90aWZNc2cgPSAiJChGb3JtYXQtU2l6ZSAkcmVzdWx0LkJ5dGVzQ29waWVkKSBlbiAkKEZvcm1hdC1EdXJhdGlvbiAkcmVzdWx0LkVsYXBzZWQpIGEgJCgkcmVzdWx0LlNwZWVkTUJwcykgTUIvcyIKICAgIGlmICgkcmVzdWx0Lk9LKSB7CiAgICAgICAgU2VuZC1Ob3RpZmljYXRpb24gLVRpdGxlICJBdGxhcyAtIENvcGlhIENvbXBsZXRhZGEiIC1NZXNzYWdlICRub3RpZk1zZyAtU3VjY2VzcyAkdHJ1ZQogICAgfSBlbHNlIHsKICAgICAgICBTZW5kLU5vdGlmaWNhdGlvbiAtVGl0bGUgIkF0bGFzIC0gQ29waWEgY29uIEVycm9yZXMiIC1NZXNzYWdlICJSZXZpc2EgZWwgbG9nIiAtU3VjY2VzcyAkZmFsc2UKICAgIH0KCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBWRVJJRklDQUNJT04gTUQ1CiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgJGludGVncml0eSA9ICRudWxsCiAgICBpZiAoJHJlc3VsdC5PSyAtYW5kICRtb2RvIC1uZSAiTU9WRVIiKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgICBWZXJpZmljYXIgaW50ZWdyaWRhZCBNRDU/IFtTL05dIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgJHZlclNlbCA9IFJlYWQtSG9zdCAiICAgID4iCiAgICAgICAgaWYgKCR2ZXJTZWwgLWVxICJTIiAtb3IgJHZlclNlbCAtZXEgInMiKSB7CiAgICAgICAgICAgICMgVmVyaWZpY2FyIGVsIHByaW1lciBvcmlnZW4gKGVsIG3DoXMgaW1wb3J0YW50ZSkKICAgICAgICAgICAgJGludGVncml0eSA9IFRlc3QtQ29weUludGVncml0eSAtT3JpZ2VuICRvcmlnZW5lc1swXSAtRGVzdGlubyAkcnV0YUZpbmFsCiAgICAgICAgfQogICAgfQoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAjIFBPU1QtQ09QSUEKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICA6cG9zdE1lbnUgd2hpbGUgKCR0cnVlKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIFdyaXRlLUhvc3QgIiAgICBbQV0gQWJyaXIgY2FycGV0YSBkZXN0aW5vIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW1JdIFJFUEVUSVIgY29uIG90cm8gZGVzdGlubyIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgIFdyaXRlLUhvc3QgIiAgICBbWF0gRXhwb3J0YXIgcmVzdW1lbiBwYXJhIHRpY2tldCIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW05dIE51ZXZhIGNvcGlhIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtMXSBWZXIgbG9nIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtTXSBTYWxpciIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIFdyaXRlLUhvc3QgIiAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAkcG9zdE9wID0gUmVhZC1Ib3N0ICIgICAgPiIKCiAgICAgICAgc3dpdGNoICgkcG9zdE9wLlRvVXBwZXIoKSkgewogICAgICAgICAgICAiQSIgewogICAgICAgICAgICAgICAgaWYgKFRlc3QtUGF0aCAkcnV0YUZpbmFsKSB7IEludm9rZS1JdGVtICRydXRhRmluYWwgfQogICAgICAgICAgICAgICAgZWxzZSB7IFdyaXRlLUhvc3QgIiAgICBObyBlbmNvbnRyYWRhLiIgLUZvcmVncm91bmRDb2xvciBSZWQgfQogICAgICAgICAgICB9CiAgICAgICAgICAgICJSIiB7CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICAkbmV3UGF0aCA9IEdldC1QYXRoRnJvbVVzZXIgLVByb21wdCAiREVTVElOTyIgLU1vZGUgImZvbGRlciIKICAgICAgICAgICAgICAgIGlmICgkbmV3UGF0aCAtZXEgIkJBQ0siIC1vciAkbmV3UGF0aCAtZXEgIkVYSVQiIC1vciAtbm90ICRuZXdQYXRoKSB7IGNvbnRpbnVlIH0KICAgICAgICAgICAgICAgIGlmICgtbm90IChUZXN0LVBhdGggJG5ld1BhdGgpKSB7IFdyaXRlLUhvc3QgIiAgICBObyBhY2Nlc2libGUuIiAtRm9yZWdyb3VuZENvbG9yIFJlZDsgY29udGludWUgfQoKICAgICAgICAgICAgICAgICRuZXdEcml2ZUluZm8gPSBEZXRlY3QtRHJpdmVUeXBlICgkbmV3UGF0aC5TdWJzdHJpbmcoMCwgMSkpCiAgICAgICAgICAgICAgICAkbmV3UnV0YUZpbmFsID0gSm9pbi1QYXRoICRuZXdQYXRoICIke2NsaWVudGV9XyR7ZmVjaGFIb3l9IgogICAgICAgICAgICAgICAgJG5ld0xhYmVsID0gaWYgKCRuZXdEcml2ZUluZm8uTGFiZWwpIHsgIiAoJCgkbmV3RHJpdmVJbmZvLkxhYmVsKSkiIH0gZWxzZSB7ICIiIH0KICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBEaXNjbzogJCgkbmV3RHJpdmVJbmZvLkRlc2MpJHtuZXdMYWJlbH0iIC1Gb3JlZ3JvdW5kQ29sb3IgJG5ld0RyaXZlSW5mby5Db2xvcgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIERlc3Rpbm86ICR7bmV3UnV0YUZpbmFsfSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtTXSBDb3BpYXIgIFtOXSBDYW5jZWxhciIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgICAgICAgICAgJHJjID0gUmVhZC1Ib3N0ICIgICAgPiIKCiAgICAgICAgICAgICAgICBpZiAoJHJjIC1lcSAiUyIgLW9yICRyYyAtZXEgInMiKSB7CiAgICAgICAgICAgICAgICAgICAgQ2xlYXItSG9zdDsgV3JpdGUtSG9zdCAiYG4iCiAgICAgICAgICAgICAgICAgICAgJHIyID0gU3RhcnQtRmFzdENvcHkgLUZhc3RDb3B5RXhlICRmYXN0Q29weUV4ZSAtT3JpZ2lucyAkb3JpZ2VuZXMgLURlc3Rpbm8gJG5ld1J1dGFGaW5hbCBgCiAgICAgICAgICAgICAgICAgICAgICAgIC1Nb2RlICRtb2RvIC1TcGVlZE1vZGUgJG5ld0RyaXZlSW5mby5TcGVlZCAtRGlza1R5cGUgJG5ld0RyaXZlSW5mby5UeXBlIGAKICAgICAgICAgICAgICAgICAgICAgICAgLUV4Y2x1ZGVGaWxlcyAkZXhjbHVzaW9ucy5GaWxlcyAtRXhjbHVkZURpcnMgJGV4Y2x1c2lvbnMuRGlycwogICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICRuMk1zZyA9ICIkKEZvcm1hdC1TaXplICRyMi5CeXRlc0NvcGllZCkgZW4gJChGb3JtYXQtRHVyYXRpb24gJHIyLkVsYXBzZWQpIgogICAgICAgICAgICAgICAgICAgIFNlbmQtTm90aWZpY2F0aW9uIC1UaXRsZSAiQXRsYXMgLSBDb3BpYSAkKGlmICgkcjIuT0spIHsnT0snfSBlbHNlIHsnRXJyb3InfSkiIC1NZXNzYWdlICRuMk1zZyAtU3VjY2VzcyAkcjIuT0sKCiAgICAgICAgICAgICAgICAgICAgaWYgKCRyMi5PSyAtYW5kICRtb2RvIC1uZSAiTU9WRVIiKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBWZXJpZmljYXIgTUQ1PyBbUy9OXSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICAgICAgICAgICAgICAkdjIgPSBSZWFkLUhvc3QgIiAgICA+IgogICAgICAgICAgICAgICAgICAgICAgICBpZiAoJHYyIC1lcSAiUyIgLW9yICR2MiAtZXEgInMiKSB7IFRlc3QtQ29weUludGVncml0eSAtT3JpZ2VuICRvcmlnZW5lc1swXSAtRGVzdGlubyAkbmV3UnV0YUZpbmFsIHwgT3V0LU51bGwgfQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgICAgICAiWCIgewogICAgICAgICAgICAgICAgJHJlcG9ydEZpbGUgPSBFeHBvcnQtQ29weVJlcG9ydCAtT3JpZ2lucyAkb3JpZ2VuZXMgLURlc3Rpbm8gJHJ1dGFGaW5hbCAtTW9kZSAkbW9kbyBgCiAgICAgICAgICAgICAgICAgICAgLURpc2tUeXBlICRkcml2ZUluZm8uVHlwZSAtUmVzdWx0ICRyZXN1bHQgLUludGVncml0eSAkaW50ZWdyaXR5IGAKICAgICAgICAgICAgICAgICAgICAtQ29tcGFyaXNvbiAkY29tcGFyaXNvbiAtRXhjbHVzaW9uTGFiZWwgJGV4Y2x1c2lvbnMuTGFiZWwgLUNsaWVudGUgJGNsaWVudGUKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBbT0tdIFJlc3VtZW46ICQoU3BsaXQtUGF0aCAkcmVwb3J0RmlsZSAtTGVhZikiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBMaXN0byBwYXJhIGFkanVudGFyIGFsIHRpY2tldC4iIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgQWJyaXI/IFtTL05dIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgICAgICAgICAkb3BlblJlcG9ydCA9IFJlYWQtSG9zdCAiICAgID4iCiAgICAgICAgICAgICAgICBpZiAoJG9wZW5SZXBvcnQgLWVxICJTIiAtb3IgJG9wZW5SZXBvcnQgLWVxICJzIikgeyBTdGFydC1Qcm9jZXNzIG5vdGVwYWQgJHJlcG9ydEZpbGUgfQogICAgICAgICAgICB9CiAgICAgICAgICAgICJOIiB7IGJyZWFrIH0KICAgICAgICAgICAgIkwiIHsKICAgICAgICAgICAgICAgIGlmICgkcmVzdWx0LkxvZ0ZpbGUgLWFuZCAoVGVzdC1QYXRoICRyZXN1bHQuTG9nRmlsZSkpIHsgU3RhcnQtUHJvY2VzcyBub3RlcGFkICRyZXN1bHQuTG9nRmlsZSB9CiAgICAgICAgICAgICAgICBlbHNlIHsgV3JpdGUtSG9zdCAiICAgIExvZyBubyBlbmNvbnRyYWRvLiIgLUZvcmVncm91bmRDb2xvciBSZWQgfQogICAgICAgICAgICB9CiAgICAgICAgICAgICJTIiB7IGV4aXQgfQogICAgICAgIH0KICAgICAgICBpZiAoJHBvc3RPcCAtZXEgIk4iIC1vciAkcG9zdE9wIC1lcSAibiIpIHsgYnJlYWsgfQogICAgfQoKfSB3aGlsZSAoJHRydWUpCn0K'
$script:AtlasToolSources['Invoke-GestorBitLocker'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtR2VzdG9yQml0TG9ja2VyCiMgTWlncmFkbyBkZTogR2VzdG9yQml0TG9ja2VyLnBzMQojIEF0bGFzIFBDIFN1cHBvcnQg4oCUIHYxLjAKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIEludm9rZS1HZXN0b3JCaXRMb2NrZXIgewogICAgW0NtZGxldEJpbmRpbmcoKV0KICAgIHBhcmFtKAogICAgICAgIFtWYWxpZGF0ZVNldCgiRXh0cmFjdCIsIlN0YXR1cyIsIiIpXQogICAgICAgIFtzdHJpbmddJEFjdGlvbiA9ICIiLAogICAgICAgIFtzdHJpbmddJE91dHB1dCA9ICIiLAogICAgICAgIFtzdHJpbmddJE1vdW50UG9pbnQgPSAiIgogICAgKQojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBHZXN0b3IgZGUgQml0TG9ja2VyIHYzIC0gQXRsYXMgUEMgU3VwcG9ydAojIFRQTSArIFByb2dyZXNvICsgQmFja3VwIFVTQiArIFFSICsgSGVhbHRoIENoZWNrICsgTG9nCiMgQUQvQXp1cmUgYmFja3VwICsgQ0xJIG1vZGUgKyBBbGVydGEgZGlzY29zIHNpbiBwcm90ZWdlcgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCiMgKGF1dG8tZWxldmFjacOzbiBnZXN0aW9uYWRhIHBvciBBdGxhcyBMYXVuY2hlcikKCgpbY29uc29sZV06OkJhY2tncm91bmRDb2xvciA9ICJCbGFjayIKW2NvbnNvbGVdOjpGb3JlZ3JvdW5kQ29sb3IgPSAiR3JheSIKJEhvc3QuVUkuUmF3VUkuV2luZG93VGl0bGUgPSAiQVRMQVMgUEMgU1VQUE9SVCAtIEdlc3RvciBCaXRMb2NrZXIgdjMiCnRyeSB7ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUgPSBOZXctT2JqZWN0IFN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uSG9zdC5TaXplKDEwNSwgNDgpIH0gY2F0Y2gge30KCiMgTG9nIGZpbGUKJGxvZ0ZpbGUgPSBKb2luLVBhdGggJFBTU2NyaXB0Um9vdCAiQVRMQVNfYml0bG9ja2VyLmxvZyIKCiMgPT09PT09PT09PT09PT09PT09PT0gRlVOQ0lPTkVTIEJBU0UgPT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIFdyaXRlLUxvZyB7CiAgICBwYXJhbShbc3RyaW5nXSRNZXNzYWdlLCBbc3RyaW5nXSRMZXZlbCA9ICJJTkZPIikKICAgICR0aW1lc3RhbXAgPSBHZXQtRGF0ZSAtRm9ybWF0ICd5eXl5LU1NLWRkIEhIOm1tOnNzJwogICAgJHVzZXIgPSAiJGVudjpVU0VSRE9NQUlOXCRlbnY6VVNFUk5BTUUiCiAgICAkcGMgPSAkZW52OkNPTVBVVEVSTkFNRQogICAgJGVudHJ5ID0gIiR7dGltZXN0YW1wfSB8ICR7TGV2ZWx9IHwgJHtwY30gfCAke3VzZXJ9IHwgJHtNZXNzYWdlfSIKICAgIHRyeSB7ICRlbnRyeSB8IE91dC1GaWxlIC1GaWxlUGF0aCAkc2NyaXB0OmxvZ0ZpbGUgLUFwcGVuZCAtRW5jb2RpbmcgVVRGOCB9IGNhdGNoIHt9Cn0KCmZ1bmN0aW9uIEVzY3JpYmlyLUNlbnRyYWRvIHsKICAgIHBhcmFtKFtzdHJpbmddJFRleHRvLCBbQ29uc29sZUNvbG9yXSRDb2xvciA9ICJHcmF5IikKICAgICRBbmNob1ZlbnRhbmEgPSAkSG9zdC5VSS5SYXdVSS5XaW5kb3dTaXplLldpZHRoCiAgICBpZiAoJFRleHRvLkxlbmd0aCAtbHQgJEFuY2hvVmVudGFuYSkgewogICAgICAgICRFc3BhY2lvcyA9IFtNYXRoXTo6Rmxvb3IoKCRBbmNob1ZlbnRhbmEgLSAkVGV4dG8uTGVuZ3RoKSAvIDIpCiAgICAgICAgV3JpdGUtSG9zdCAoIiAiICogJEVzcGFjaW9zICsgJFRleHRvKSAtRm9yZWdyb3VuZENvbG9yICRDb2xvcgogICAgfSBlbHNlIHsKICAgICAgICBXcml0ZS1Ib3N0ICRUZXh0byAtRm9yZWdyb3VuZENvbG9yICRDb2xvcgogICAgfQp9CgpmdW5jdGlvbiBTaG93LURpc2tUYWJsZSB7CiAgICBwYXJhbShbc3dpdGNoXSRPbmx5RW5jcnlwdGVkLCBbc3dpdGNoXSRTaWxlbnQpCiAgICAKICAgICR2b2x1bWVzID0gR2V0LUJpdExvY2tlclZvbHVtZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgaWYgKC1ub3QgJHZvbHVtZXMpIHsKICAgICAgICBpZiAoLW5vdCAkU2lsZW50KSB7IFdyaXRlLUhvc3QgIiAgICBObyBzZSBwdWRvIGFjY2VkZXIgYSBCaXRMb2NrZXIuIiAtRm9yZWdyb3VuZENvbG9yIFJlZCB9CiAgICAgICAgcmV0dXJuICRudWxsCiAgICB9CiAgICAKICAgIGlmICgkT25seUVuY3J5cHRlZCkgewogICAgICAgICR2b2x1bWVzID0gJHZvbHVtZXMgfCBXaGVyZS1PYmplY3QgeyAkXy5Wb2x1bWVTdGF0dXMgLW5lICdGdWxseURlY3J5cHRlZCcgfQogICAgICAgIGlmICgtbm90ICR2b2x1bWVzKSB7CiAgICAgICAgICAgIGlmICgtbm90ICRTaWxlbnQpIHsgV3JpdGUtSG9zdCAiICAgIE5vIGhheSBkaXNjb3MgY29uIEJpdExvY2tlciBhY3Rpdm8uIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdyB9CiAgICAgICAgICAgIHJldHVybiAkbnVsbAogICAgICAgIH0KICAgIH0KICAgIAogICAgaWYgKC1ub3QgJFNpbGVudCkgewogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRElTQ08gICBFU1RBRE8gICAgICAgICAgICAgICAgICBFTkNSSVBUQURPICAgVEFNQU5PICAgIE1FVE9ETyIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIFdyaXRlLUhvc3QgIiAgICAtLS0tLSAgIC0tLS0tLSAgICAgICAgICAgICAgICAgIC0tLS0tLS0tLS0gICAtLS0tLS0gICAgLS0tLS0tIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgCiAgICAgICAgZm9yZWFjaCAoJHYgaW4gJHZvbHVtZXMpIHsKICAgICAgICAgICAgJG1vdW50ID0gJHYuTW91bnRQb2ludAogICAgICAgICAgICAkc3RhdHVzID0gJHYuVm9sdW1lU3RhdHVzLlRvU3RyaW5nKCkKICAgICAgICAgICAgJHBjdCA9ICIkKCR2LkVuY3J5cHRpb25QZXJjZW50YWdlKSUiCiAgICAgICAgICAgICRjYXBHQiA9IGlmICgkdi5DYXBhY2l0eUdCKSB7ICJ7MDpOMX0gR0IiIC1mICR2LkNhcGFjaXR5R0IgfSBlbHNlIHsgIk4vQSIgfQogICAgICAgICAgICAkbWV0aG9kID0gaWYgKCR2LkVuY3J5cHRpb25NZXRob2QpIHsgJHYuRW5jcnlwdGlvbk1ldGhvZC5Ub1N0cmluZygpIH0gZWxzZSB7ICItIiB9CiAgICAgICAgICAgIAogICAgICAgICAgICAkc3RhdHVzQ29sb3IgPSBzd2l0Y2ggKCRzdGF0dXMpIHsKICAgICAgICAgICAgICAgICJGdWxseUVuY3J5cHRlZCIgeyAiR3JlZW4iIH0KICAgICAgICAgICAgICAgICJGdWxseURlY3J5cHRlZCIgeyAiR3JheSIgfQogICAgICAgICAgICAgICAgIkVuY3J5cHRpb25JblByb2dyZXNzIiB7ICJZZWxsb3ciIH0KICAgICAgICAgICAgICAgICJEZWNyeXB0aW9uSW5Qcm9ncmVzcyIgeyAiWWVsbG93IiB9CiAgICAgICAgICAgICAgICBkZWZhdWx0IHsgIldoaXRlIiB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgJHN0YXR1c0xhYmVsID0gc3dpdGNoICgkc3RhdHVzKSB7CiAgICAgICAgICAgICAgICAiRnVsbHlFbmNyeXB0ZWQiIHsgIkVOQ1JJUFRBRE8iIH0KICAgICAgICAgICAgICAgICJGdWxseURlY3J5cHRlZCIgeyAiTElCUkUiIH0KICAgICAgICAgICAgICAgICJFbmNyeXB0aW9uSW5Qcm9ncmVzcyIgeyAiRU5DUklQVEFORE8uLi4iIH0KICAgICAgICAgICAgICAgICJEZWNyeXB0aW9uSW5Qcm9ncmVzcyIgeyAiREVTRU5DUklQVEFORE8uLi4iIH0KICAgICAgICAgICAgICAgIGRlZmF1bHQgeyAkc3RhdHVzIH0KICAgICAgICAgICAgfQogICAgICAgICAgICAkaWNvbiA9IHN3aXRjaCAoJHN0YXR1cykgewogICAgICAgICAgICAgICAgIkZ1bGx5RW5jcnlwdGVkIiB7ICJbWF0iIH0KICAgICAgICAgICAgICAgICJGdWxseURlY3J5cHRlZCIgeyAiWyBdIiB9CiAgICAgICAgICAgICAgICAiRW5jcnlwdGlvbkluUHJvZ3Jlc3MiIHsgIlt+XSIgfQogICAgICAgICAgICAgICAgIkRlY3J5cHRpb25JblByb2dyZXNzIiB7ICJbfl0iIH0KICAgICAgICAgICAgICAgIGRlZmF1bHQgeyAiWz9dIiB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAke2ljb259ICR7bW91bnR9IiAtTm9OZXdsaW5lIC1Gb3JlZ3JvdW5kQ29sb3IgJHN0YXR1c0NvbG9yCiAgICAgICAgICAgIFdyaXRlLUhvc3QgKCIgICAiICsgJHN0YXR1c0xhYmVsLlBhZFJpZ2h0KDI0KSkgLU5vTmV3bGluZSAtRm9yZWdyb3VuZENvbG9yICRzdGF0dXNDb2xvcgogICAgICAgICAgICBXcml0ZS1Ib3N0ICgkcGN0LlBhZFJpZ2h0KDEzKSkgLU5vTmV3bGluZSAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgICAgIFdyaXRlLUhvc3QgKCRjYXBHQi5QYWRSaWdodCgxMCkpIC1Ob05ld2xpbmUgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICAgICAgICAgIFdyaXRlLUhvc3QgJG1ldGhvZCAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgfQogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgIH0KICAgIHJldHVybiAkdm9sdW1lcwp9CgpmdW5jdGlvbiBWYWxpZGF0ZS1Ecml2ZUxldHRlciB7CiAgICBwYXJhbShbc3RyaW5nXSRJbnB1dCwgW2FycmF5XSRWYWxpZFZvbHVtZXMpCiAgICBpZiAoW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkSW5wdXQpKSB7IHJldHVybiAkbnVsbCB9CiAgICAkY2xlYW4gPSAkSW5wdXQuVHJpbSgpLlRvVXBwZXIoKS5SZXBsYWNlKCI6IiwgIiIpCiAgICBpZiAoJGNsZWFuLkxlbmd0aCAtbmUgMSAtb3IgJGNsZWFuIC1ub3RtYXRjaCAiXltBLVpdJCIpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgTGV0cmEgaW52YWxpZGEuIFVzYSB1bmEgc29sYSBsZXRyYSAoZWo6IEMsIEQsIEUpLiIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICByZXR1cm4gJG51bGwKICAgIH0KICAgICRkaXNjbyA9ICIke2NsZWFufToiCiAgICAkZm91bmQgPSAkVmFsaWRWb2x1bWVzIHwgV2hlcmUtT2JqZWN0IHsgJF8uTW91bnRQb2ludCAtZXEgJGRpc2NvIH0KICAgIGlmICgtbm90ICRmb3VuZCkgewogICAgICAgIFdyaXRlLUhvc3QgIiAgICBFbCBkaXNjbyAke2Rpc2NvfSBubyBleGlzdGUuIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgIHJldHVybiAkbnVsbAogICAgfQogICAgcmV0dXJuIEB7IExldHRlciA9ICRkaXNjbzsgVm9sdW1lID0gJGZvdW5kIH0KfQoKZnVuY3Rpb24gR2V0LVRQTVN0YXR1cyB7CiAgICAkcmVzdWx0ID0gQHsgSGFzVFBNID0gJGZhbHNlOyBJc1JlYWR5ID0gJGZhbHNlOyBWZXJzaW9uID0gIk4vQSI7IFN1bW1hcnkgPSAiIiB9CiAgICB0cnkgewogICAgICAgICR0cG0gPSBHZXQtVHBtIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgJHJlc3VsdC5IYXNUUE0gPSAkdHBtLlRwbVByZXNlbnQKICAgICAgICAkcmVzdWx0LklzUmVhZHkgPSAkdHBtLlRwbVJlYWR5CiAgICAgICAgdHJ5IHsKICAgICAgICAgICAgJHRwbVdNSSA9IEdldC1DaW1JbnN0YW5jZSAtTmFtZXNwYWNlICJyb290XGNpbXYyXFNlY3VyaXR5XE1pY3Jvc29mdFRwbSIgLUNsYXNzTmFtZSBXaW4zMl9UcG0gLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAgICAgaWYgKCR0cG1XTUkuU3BlY1ZlcnNpb24pIHsgJHJlc3VsdC5WZXJzaW9uID0gKCR0cG1XTUkuU3BlY1ZlcnNpb24gLXNwbGl0ICcsJylbMF0uVHJpbSgpIH0KICAgICAgICB9IGNhdGNoIHsgfQogICAgICAgIGlmICgkcmVzdWx0Lkhhc1RQTSAtYW5kICRyZXN1bHQuSXNSZWFkeSkgeyAkcmVzdWx0LlN1bW1hcnkgPSAiVFBNICQoJHJlc3VsdC5WZXJzaW9uKSBwcmVzZW50ZSB5IGxpc3RvIiB9CiAgICAgICAgZWxzZWlmICgkcmVzdWx0Lkhhc1RQTSkgeyAkcmVzdWx0LlN1bW1hcnkgPSAiVFBNIHByZXNlbnRlIHBlcm8gTk8gbGlzdG8iIH0KICAgICAgICBlbHNlIHsgJHJlc3VsdC5TdW1tYXJ5ID0gIlNpbiBUUE0gZGV0ZWN0YWRvIiB9CiAgICB9IGNhdGNoIHsgJHJlc3VsdC5TdW1tYXJ5ID0gIk5vIHNlIHB1ZG8gY29uc3VsdGFyIFRQTSIgfQogICAgcmV0dXJuICRyZXN1bHQKfQoKZnVuY3Rpb24gU2hvdy1FbmNyeXB0aW9uUHJvZ3Jlc3MgewogICAgcGFyYW0oW3N0cmluZ10kTW91bnRQb2ludCwgW3N0cmluZ10kTW9kZSA9ICJFbmNyeXB0aW5nIikKICAgICRsYWJlbCA9IGlmICgkTW9kZSAtZXEgIkVuY3J5cHRpbmciKSB7ICJFTkNSSVBUQU5ETyIgfSBlbHNlIHsgIkRFU0VOQ1JJUFRBTkRPIiB9CiAgICAkY29sb3IgPSBpZiAoJE1vZGUgLWVxICJFbmNyeXB0aW5nIikgeyAiQ3lhbiIgfSBlbHNlIHsgIk1hZ2VudGEiIH0KICAgIFdyaXRlLUhvc3QgIiIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICJNb25pdG9yZWFuZG8gKENUUkwrQyBwYXJhIGRlamFyIGVuIHNlZ3VuZG8gcGxhbm8pLi4uIiAiRGFya0dyYXkiCiAgICBXcml0ZS1Ib3N0ICIiCiAgICAkbGFzdFBjdCA9IC0xCiAgICB0cnkgewogICAgICAgIHdoaWxlICgkdHJ1ZSkgewogICAgICAgICAgICAkdm9sID0gR2V0LUJpdExvY2tlclZvbHVtZSAtTW91bnRQb2ludCAkTW91bnRQb2ludCAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgICAgICAgICBpZiAoLW5vdCAkdm9sKSB7IGJyZWFrIH0KICAgICAgICAgICAgJHBjdCA9ICR2b2wuRW5jcnlwdGlvblBlcmNlbnRhZ2U7ICRzdGF0dXMgPSAkdm9sLlZvbHVtZVN0YXR1cy5Ub1N0cmluZygpCiAgICAgICAgICAgIGlmICgkcGN0IC1uZSAkbGFzdFBjdCkgewogICAgICAgICAgICAgICAgJGJhcldpZHRoID0gNDA7ICRmaWxsZWQgPSBbbWF0aF06OkZsb29yKCRwY3QgLyAxMDAgKiAkYmFyV2lkdGgpOyAkZW1wdHkgPSAkYmFyV2lkdGggLSAkZmlsbGVkCiAgICAgICAgICAgICAgICAkYmFyID0gKCIjIiAqICRmaWxsZWQpICsgKCItIiAqICRlbXB0eSkKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgImByICAgICR7bGFiZWx9ICR7TW91bnRQb2ludH06IFske2Jhcn1dICR7cGN0fSUgICAiIC1Ob05ld2xpbmUgLUZvcmVncm91bmRDb2xvciAkY29sb3IKICAgICAgICAgICAgICAgICRsYXN0UGN0ID0gJHBjdAogICAgICAgICAgICB9CiAgICAgICAgICAgIGlmICgkc3RhdHVzIC1lcSAiRnVsbHlFbmNyeXB0ZWQiIC1vciAkc3RhdHVzIC1lcSAiRnVsbHlEZWNyeXB0ZWQiKSB7CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiOyBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICAkZG9uZU1zZyA9IGlmICgkTW9kZSAtZXEgIkVuY3J5cHRpbmciKSB7ICJFbmNyaXB0YWNpb24gY29tcGxldGFkYS4iIH0gZWxzZSB7ICJEZXNlbmNyaXB0YWNpb24gY29tcGxldGFkYS4iIH0KICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICRkb25lTXNnICJHcmVlbiIKICAgICAgICAgICAgICAgIFdyaXRlLUxvZyAiJHtkb25lTXNnfSBEaXNjbzogJHtNb3VudFBvaW50fSIKICAgICAgICAgICAgICAgIGJyZWFrCiAgICAgICAgICAgIH0KICAgICAgICAgICAgU3RhcnQtU2xlZXAgLVNlY29uZHMgMwogICAgICAgIH0KICAgIH0gY2F0Y2ggeyBXcml0ZS1Ib3N0ICIiOyBXcml0ZS1Ib3N0ICIiOyBFc2NyaWJpci1DZW50cmFkbyAiTW9uaXRvcmVvIGRldGVuaWRvLiBDb250aW51YSBlbiBzZWd1bmRvIHBsYW5vLiIgIlllbGxvdyIgfQp9CgojID09PT09PT09PT09PT09PT09PT09IEhFQUxUSCBDSEVDSyBQUkUtRU5DUklQVEFDSU9OID09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBUZXN0LVByZUVuY3J5cHRpb25IZWFsdGggewogICAgcGFyYW0oW3N0cmluZ10kTW91bnRQb2ludCkKICAgIAogICAgJGlzc3VlcyA9IEAoKTsgJHdhcm5pbmdzID0gQCgpOyAkY2FuUHJvY2VlZCA9ICR0cnVlCiAgICAkZHJpdmVMZXR0ZXIgPSAkTW91bnRQb2ludC5UcmltRW5kKCc6JykKICAgIAogICAgV3JpdGUtSG9zdCAiIgogICAgRXNjcmliaXItQ2VudHJhZG8gIkhFQUxUSCBDSEVDSyBQUkUtRU5DUklQVEFDSU9OIiAiWWVsbG93IgogICAgV3JpdGUtSG9zdCAiIgogICAgCiAgICAjIDEuIEJBVEVSSUEgKGNyaXRpY28gZW4gbGFwdG9wcykKICAgIFdyaXRlLUhvc3QgIiAgICBbMS81XSBCYXRlcmlhLi4uIiAtTm9OZXdsaW5lIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICRiYXR0ZXJ5ID0gR2V0LUNpbUluc3RhbmNlIFdpbjMyX0JhdHRlcnkgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgIGlmICgkYmF0dGVyeSkgewogICAgICAgICRjaGFyZ2UgPSAkYmF0dGVyeS5Fc3RpbWF0ZWRDaGFyZ2VSZW1haW5pbmcKICAgICAgICAkcGx1Z2dlZCA9ICRiYXR0ZXJ5LkJhdHRlcnlTdGF0dXMgLWVxIDIKICAgICAgICBpZiAoJGNoYXJnZSAtbHQgMzAgLWFuZCAtbm90ICRwbHVnZ2VkKSB7CiAgICAgICAgICAgICRpc3N1ZXMgKz0gIkJBVEVSSUEgQ1JJVElDQTogJHtjaGFyZ2V9JSBzaW4gY2FyZ2Fkb3IuIENvbmVjdGEgZWwgY2FyZ2Fkb3IgYW50ZXMgZGUgZW5jcmlwdGFyLiIKICAgICAgICAgICAgJGNhblByb2NlZWQgPSAkZmFsc2UKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIEZBTExPICgke2NoYXJnZX0lKSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICB9IGVsc2VpZiAoJGNoYXJnZSAtbHQgNTAgLWFuZCAtbm90ICRwbHVnZ2VkKSB7CiAgICAgICAgICAgICR3YXJuaW5ncyArPSAiQmF0ZXJpYSBhbCAke2NoYXJnZX0lLiBTZSByZWNvbWllbmRhIGNvbmVjdGFyIGVsIGNhcmdhZG9yLiIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIEFWSVNPICgke2NoYXJnZX0lKSIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICB9IGVsc2VpZiAoJHBsdWdnZWQpIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIE9LICgke2NoYXJnZX0lLCBjYXJnYWRvciBjb25lY3RhZG8pIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIE9LICgke2NoYXJnZX0lKSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgIH0KICAgIH0gZWxzZSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIE4vQSAoZXNjcml0b3JpbykiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JheQogICAgfQogICAgCiAgICAjIDIuIEVTUEFDSU8gRU4gRElTQ08KICAgIFdyaXRlLUhvc3QgIiAgICBbMi81XSBFc3BhY2lvIGVuIGRpc2NvLi4uIiAtTm9OZXdsaW5lIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICRsb2dEaXNrID0gR2V0LUNpbUluc3RhbmNlIFdpbjMyX0xvZ2ljYWxEaXNrIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlIHwgV2hlcmUtT2JqZWN0IHsgJF8uRGV2aWNlSUQgLWVxICRNb3VudFBvaW50IH0KICAgIGlmICgkbG9nRGlzaykgewogICAgICAgICRmcmVlR0IgPSBbbWF0aF06OlJvdW5kKCRsb2dEaXNrLkZyZWVTcGFjZSAvIDFHQiwgMSkKICAgICAgICAkdG90YWxHQiA9IFttYXRoXTo6Um91bmQoJGxvZ0Rpc2suU2l6ZSAvIDFHQiwgMSkKICAgICAgICAkdXNlZFBjdCA9IFttYXRoXTo6Um91bmQoKCgkbG9nRGlzay5TaXplIC0gJGxvZ0Rpc2suRnJlZVNwYWNlKSAvICRsb2dEaXNrLlNpemUpICogMTAwLCAwKQogICAgICAgIGlmICgkZnJlZUdCIC1sdCAxKSB7CiAgICAgICAgICAgICRpc3N1ZXMgKz0gIkRJU0NPIENBU0kgTExFTk86IFNvbG8gJHtmcmVlR0J9R0IgbGlicmUuIEJpdExvY2tlciBuZWNlc2l0YSBlc3BhY2lvIHBhcmEgbWV0YWRhdG9zLiIKICAgICAgICAgICAgJGNhblByb2NlZWQgPSAkZmFsc2UKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIEZBTExPICgke2ZyZWVHQn1HQiBsaWJyZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgfSBlbHNlaWYgKCR1c2VkUGN0IC1ndCA5NSkgewogICAgICAgICAgICAkd2FybmluZ3MgKz0gIkRpc2NvIGFsICR7dXNlZFBjdH0lIGRlIGNhcGFjaWRhZC4gUmVjb21lbmRhZG8gbGliZXJhciBlc3BhY2lvLiIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIEFWSVNPICgke3VzZWRQY3R9JSkiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIE9LICgke2ZyZWVHQn1HQiBsaWJyZSBkZSAke3RvdGFsR0J9R0IpIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgfQogICAgfSBlbHNlIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgTi9BIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgIH0KICAgIAogICAgIyAzLiBFU1RBRE8gU01BUlQgREVMIERJU0NPCiAgICBXcml0ZS1Ib3N0ICIgICAgWzMvNV0gU2FsdWQgZGVsIGRpc2NvIChTTUFSVCkuLi4iIC1Ob05ld2xpbmUgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgdHJ5IHsKICAgICAgICAkcGFydGl0aW9uID0gR2V0LVBhcnRpdGlvbiAtRHJpdmVMZXR0ZXIgJGRyaXZlTGV0dGVyIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgJHBoeXNEaXNrID0gR2V0LVBoeXNpY2FsRGlzayAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSB8IFdoZXJlLU9iamVjdCB7ICRfLkRldmljZUlkIC1lcSAkcGFydGl0aW9uLkRpc2tOdW1iZXIuVG9TdHJpbmcoKSB9CiAgICAgICAgaWYgKC1ub3QgJHBoeXNEaXNrKSB7CiAgICAgICAgICAgICRwaHlzRGlzayA9IEdldC1QaHlzaWNhbERpc2sgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUgfCBTZWxlY3QtT2JqZWN0IC1GaXJzdCAxCiAgICAgICAgfQogICAgICAgIGlmICgkcGh5c0Rpc2spIHsKICAgICAgICAgICAgJGhlYWx0aCA9ICRwaHlzRGlzay5IZWFsdGhTdGF0dXMuVG9TdHJpbmcoKQogICAgICAgICAgICBpZiAoJGhlYWx0aCAtbmUgIkhlYWx0aHkiKSB7CiAgICAgICAgICAgICAgICAkaXNzdWVzICs9ICJESVNDTyBDT04gUFJPQkxFTUFTOiBFc3RhZG8gU01BUlQgPSAke2hlYWx0aH0uIEVuY3JpcHRhciB1biBkaXNjbyBkYW5hZG8gcHVlZGUgY2F1c2FyIHBlcmRpZGEgdG90YWwuIgogICAgICAgICAgICAgICAgJGNhblByb2NlZWQgPSAkZmFsc2UKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiBGQUxMTyAoJHtoZWFsdGh9KSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgICRvcFN0YXR1cyA9IGlmICgkcGh5c0Rpc2suT3BlcmF0aW9uYWxTdGF0dXMpIHsgJHBoeXNEaXNrLk9wZXJhdGlvbmFsU3RhdHVzLlRvU3RyaW5nKCkgfSBlbHNlIHsgIk9LIiB9CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgT0sgKCR7aGVhbHRofSwgJHtvcFN0YXR1c30pIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgIH0KICAgICAgICB9IGVsc2UgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgTm8gdmVyaWZpY2FibGUiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgfQogICAgfSBjYXRjaCB7CiAgICAgICAgV3JpdGUtSG9zdCAiIE5vIHZlcmlmaWNhYmxlIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgfQogICAgCiAgICAjIDQuIFNJU1RFTUEgREUgQVJDSElWT1MKICAgIFdyaXRlLUhvc3QgIiAgICBbNC81XSBTaXN0ZW1hIGRlIGFyY2hpdm9zLi4uIiAtTm9OZXdsaW5lIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIHRyeSB7CiAgICAgICAgJHZvbCA9IEdldC1Wb2x1bWUgLURyaXZlTGV0dGVyICRkcml2ZUxldHRlciAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICRmcyA9IGlmICgkdm9sLkZpbGVTeXN0ZW0pIHsgJHZvbC5GaWxlU3lzdGVtIH0gZWxzZSB7ICJEZXNjb25vY2lkbyIgfQogICAgICAgIGlmICgkZnMgLW5lICJOVEZTIiAtYW5kICRmcyAtbmUgIlJlRlMiKSB7CiAgICAgICAgICAgICRpc3N1ZXMgKz0gIlNJU1RFTUEgREUgQVJDSElWT1MgSU5DT01QQVRJQkxFOiAke2ZzfS4gQml0TG9ja2VyIHJlcXVpZXJlIE5URlMgbyBSZUZTLiIKICAgICAgICAgICAgJGNhblByb2NlZWQgPSAkZmFsc2UKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIEZBTExPICgke2ZzfSkiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIE9LICgke2ZzfSkiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICB9CiAgICB9IGNhdGNoIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgTm8gdmVyaWZpY2FibGUiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICB9CiAgICAKICAgICMgNS4gUFJPQ0VTT1MgQ1JJVElDT1MKICAgIFdyaXRlLUhvc3QgIiAgICBbNS81XSBQcm9jZXNvcyBjcml0aWNvcy4uLiIgLU5vTmV3bGluZSAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAkY2hrZHNrID0gR2V0LVByb2Nlc3MgLU5hbWUgImNoa2RzayIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICRkZWZyYWcgPSBHZXQtUHJvY2VzcyAtTmFtZSAiZGVmcmFnIiAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgaWYgKCRjaGtkc2sgLW9yICRkZWZyYWcpIHsKICAgICAgICAkcHJvY05hbWUgPSBpZiAoJGNoa2RzaykgeyAiY2hrZHNrIiB9IGVsc2UgeyAiZGVmcmFnIiB9CiAgICAgICAgJHdhcm5pbmdzICs9ICIke3Byb2NOYW1lfSBlbiBlamVjdWNpb24uIEVzcGVyYSBhIHF1ZSB0ZXJtaW5lIGFudGVzIGRlIGVuY3JpcHRhci4iCiAgICAgICAgV3JpdGUtSG9zdCAiIEFWSVNPICgke3Byb2NOYW1lfSBhY3Rpdm8pIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgfSBlbHNlIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgT0siIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgIH0KICAgIAogICAgIyBSRVNVTUVOCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBpZiAoJGlzc3Vlcy5Db3VudCAtZ3QgMCkgewogICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJQUk9CTEVNQVMgQ1JJVElDT1MgKG5vIHNlIHJlY29taWVuZGEgY29udGludWFyKToiICJSZWQiCiAgICAgICAgZm9yZWFjaCAoJGlzc3VlIGluICRpc3N1ZXMpIHsgV3JpdGUtSG9zdCAiICAgIFtYXSAke2lzc3VlfSIgLUZvcmVncm91bmRDb2xvciBSZWQgfQogICAgfQogICAgaWYgKCR3YXJuaW5ncy5Db3VudCAtZ3QgMCkgewogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiQVZJU09TOiIgIlllbGxvdyIKICAgICAgICBmb3JlYWNoICgkd2FybiBpbiAkd2FybmluZ3MpIHsgV3JpdGUtSG9zdCAiICAgIFshXSAke3dhcm59IiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdyB9CiAgICB9CiAgICBpZiAoJGlzc3Vlcy5Db3VudCAtZXEgMCAtYW5kICR3YXJuaW5ncy5Db3VudCAtZXEgMCkgewogICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJUT0RPUyBMT1MgQ0hFUVVFT1MgUEFTQVJPTiIgIkdyZWVuIgogICAgfQogICAgCiAgICBXcml0ZS1Mb2cgIkhlYWx0aENoZWNrICR7TW91bnRQb2ludH06IElzc3Vlcz0ke2lzc3Vlcy5Db3VudH0sIFdhcm5pbmdzPSR7d2FybmluZ3MuQ291bnR9LCBDYW5Qcm9jZWVkPSR7Y2FuUHJvY2VlZH0iCiAgICAKICAgIHJldHVybiBAeyBDYW5Qcm9jZWVkID0gJGNhblByb2NlZWQ7IElzc3VlcyA9ICRpc3N1ZXM7IFdhcm5pbmdzID0gJHdhcm5pbmdzIH0KfQoKIyA9PT09PT09PT09PT09PT09PT09PSBBTEVSVEEgRElTQ09TIFNJTiBQUk9URUdFUiA9PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gU2hvdy1VbnByb3RlY3RlZEFsZXJ0IHsKICAgICRhbGxWb2xzID0gR2V0LUJpdExvY2tlclZvbHVtZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgaWYgKC1ub3QgJGFsbFZvbHMpIHsgcmV0dXJuIH0KICAgIAogICAgJHVucHJvdGVjdGVkID0gQCgpCiAgICBmb3JlYWNoICgkdiBpbiAkYWxsVm9scykgewogICAgICAgICMgU29sbyBhbGVydGFyIGRpc2NvcyBkZWwgc2lzdGVtYSB5IGRhdG9zIChubyByZW1vdmlibGVzKQogICAgICAgICRkcml2ZUxldHRlciA9ICR2Lk1vdW50UG9pbnQuVHJpbUVuZCgnOicpCiAgICAgICAgdHJ5IHsKICAgICAgICAgICAgJHZvbEluZm8gPSBHZXQtVm9sdW1lIC1Ecml2ZUxldHRlciAkZHJpdmVMZXR0ZXIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICAgICAgICAgaWYgKCR2b2xJbmZvIC1hbmQgJHZvbEluZm8uRHJpdmVUeXBlIC1lcSAnRml4ZWQnIC1hbmQgJHYuVm9sdW1lU3RhdHVzIC1lcSAnRnVsbHlEZWNyeXB0ZWQnKSB7CiAgICAgICAgICAgICAgICAkY2FwR0IgPSBpZiAoJHYuQ2FwYWNpdHlHQikgeyAiezA6TjB9IiAtZiAkdi5DYXBhY2l0eUdCIH0gZWxzZSB7ICI/IiB9CiAgICAgICAgICAgICAgICAkdW5wcm90ZWN0ZWQgKz0gIiR7ZHJpdmVMZXR0ZXJ9OiAoJHtjYXBHQn1HQikiCiAgICAgICAgICAgIH0KICAgICAgICB9IGNhdGNoIHsgfQogICAgfQogICAgCiAgICBpZiAoJHVucHJvdGVjdGVkLkNvdW50IC1ndCAwKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICRhbGVydExpbmUgPSAiQUxFUlRBOiAkKCR1bnByb3RlY3RlZC5Db3VudCkgZGlzY28ocykgZmlqbyhzKSBTSU4gUFJPVEVDQ0lPTjogJCgkdW5wcm90ZWN0ZWQgLWpvaW4gJywgJykiCiAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gJGFsZXJ0TGluZSAiUmVkIgogICAgfQp9CgojID09PT09PT09PT09PT09PT09PT09IEdFTkVSQVIgUVIgPT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIEdlbmVyYXRlLVFSQ29kZSB7CiAgICBwYXJhbShbc3RyaW5nXSREYXRhLCBbc3RyaW5nXSRPdXRwdXRQYXRoLCBbc3RyaW5nXSRMYWJlbCA9ICIiKQogICAgCiAgICAjIEdlbmVyYXIgUVIgY29tbyBIVE1MIGNvbiB0YWJsYSAoZnVuY2lvbmEgc2luIGRlcGVuZGVuY2lhcyBleHRlcm5hcykKICAgICMgVXNhIHVuYSByZXByZXNlbnRhY2nDs24gc2ltcGxlIHF1ZSBzZSBwdWVkZSBpbXByaW1pcgogICAgCiAgICAkcXJTaXplID0gMjEgICMgUVIgVmVyc2lvbiAxCiAgICAKICAgICMgTcOpdG9kbyBhbHRlcm5hdGl2bzogZ2VuZXJhciBpbWFnZW4gQk1QIHVzYW5kbyAuTkVUCiAgICB0cnkgewogICAgICAgIEFkZC1UeXBlIC1Bc3NlbWJseU5hbWUgU3lzdGVtLkRyYXdpbmcgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAKICAgICAgICAkY2VsbFNpemUgPSAxMAogICAgICAgICRtYXJnaW4gPSA0MAogICAgICAgICR0ZXh0SGVpZ2h0ID0gaWYgKCRMYWJlbCkgeyA2MCB9IGVsc2UgeyAwIH0KICAgICAgICAKICAgICAgICAjIEdlbmVyYXIgcGF0csOzbiBRUiBzaW1wbGlmaWNhZG8gKGVuY29kZSBjb21vIHRleHRvIGxlZ2libGUgZW4gaW1hZ2VuKQogICAgICAgICRsaW5lcyA9IEAoKQogICAgICAgICRsaW5lcyArPSAiQVRMQVMgUEMgU1VQUE9SVCIKICAgICAgICAkbGluZXMgKz0gIkJJVExPQ0tFUiBSRUNPVkVSWSBLRVkiCiAgICAgICAgJGxpbmVzICs9ICIiCiAgICAgICAgaWYgKCRMYWJlbCkgeyAkbGluZXMgKz0gJExhYmVsOyAkbGluZXMgKz0gIiIgfQogICAgICAgIAogICAgICAgICMgRGl2aWRpciBsYSBjbGF2ZSBlbiBncnVwb3MgbGVnaWJsZXMKICAgICAgICAkbGluZXMgKz0gIkNMQVZFOiIKICAgICAgICBpZiAoJERhdGEuTGVuZ3RoIC1ndCAyMCkgewogICAgICAgICAgICAkY2h1bmtzID0gW3JlZ2V4XTo6TWF0Y2hlcygkRGF0YSwgJy57MSwxMn0nKSB8IEZvckVhY2gtT2JqZWN0IHsgJF8uVmFsdWUgfQogICAgICAgICAgICBmb3JlYWNoICgkY2h1bmsgaW4gJGNodW5rcykgeyAkbGluZXMgKz0gIiAgJGNodW5rIiB9CiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgJGxpbmVzICs9ICIgICREYXRhIgogICAgICAgIH0KICAgICAgICAkbGluZXMgKz0gIiIKICAgICAgICAkbGluZXMgKz0gIkZlY2hhOiAkKEdldC1EYXRlIC1Gb3JtYXQgJ2RkL01NL3l5eXknKSIKICAgICAgICAkbGluZXMgKz0gIlBDOiAkZW52OkNPTVBVVEVSTkFNRSIKICAgICAgICAKICAgICAgICAjIENyZWFyIGltYWdlbgogICAgICAgICRpbWdXaWR0aCA9IDUwMAogICAgICAgICRsaW5lSGVpZ2h0ID0gMjIKICAgICAgICAkaW1nSGVpZ2h0ID0gKCRsaW5lcy5Db3VudCAqICRsaW5lSGVpZ2h0KSArIDgwCiAgICAgICAgCiAgICAgICAgJGJtcCA9IE5ldy1PYmplY3QgU3lzdGVtLkRyYXdpbmcuQml0bWFwKCRpbWdXaWR0aCwgJGltZ0hlaWdodCkKICAgICAgICAkZ2Z4ID0gW1N5c3RlbS5EcmF3aW5nLkdyYXBoaWNzXTo6RnJvbUltYWdlKCRibXApCiAgICAgICAgJGdmeC5DbGVhcihbU3lzdGVtLkRyYXdpbmcuQ29sb3JdOjpXaGl0ZSkKICAgICAgICAKICAgICAgICAjIEJvcmRlCiAgICAgICAgJHBlbiA9IE5ldy1PYmplY3QgU3lzdGVtLkRyYXdpbmcuUGVuKFtTeXN0ZW0uRHJhd2luZy5Db2xvcl06OkJsYWNrLCAyKQogICAgICAgICRnZnguRHJhd1JlY3RhbmdsZSgkcGVuLCA1LCA1LCAkaW1nV2lkdGggLSAxMCwgJGltZ0hlaWdodCAtIDEwKQogICAgICAgIAogICAgICAgICMgVGV4dG8KICAgICAgICAkZm9udFRpdGxlID0gTmV3LU9iamVjdCBTeXN0ZW0uRHJhd2luZy5Gb250KCJDb25zb2xhcyIsIDE0LCBbU3lzdGVtLkRyYXdpbmcuRm9udFN0eWxlXTo6Qm9sZCkKICAgICAgICAkZm9udE5vcm1hbCA9IE5ldy1PYmplY3QgU3lzdGVtLkRyYXdpbmcuRm9udCgiQ29uc29sYXMiLCAxMikKICAgICAgICAkZm9udEtleSA9IE5ldy1PYmplY3QgU3lzdGVtLkRyYXdpbmcuRm9udCgiQ29uc29sYXMiLCAxMywgW1N5c3RlbS5EcmF3aW5nLkZvbnRTdHlsZV06OkJvbGQpCiAgICAgICAgJGJydXNoID0gW1N5c3RlbS5EcmF3aW5nLkJydXNoZXNdOjpCbGFjawogICAgICAgICRicnVzaFJlZCA9IFtTeXN0ZW0uRHJhd2luZy5CcnVzaGVzXTo6RGFya1JlZAogICAgICAgIAogICAgICAgICR5ID0gMjAKICAgICAgICBmb3JlYWNoICgkbGluZSBpbiAkbGluZXMpIHsKICAgICAgICAgICAgJGZvbnQgPSAkZm9udE5vcm1hbAogICAgICAgICAgICAkYiA9ICRicnVzaAogICAgICAgICAgICBpZiAoJGxpbmUgLW1hdGNoICJeQVRMQVN8XkJJVExPQ0tFUiIpIHsgJGZvbnQgPSAkZm9udFRpdGxlIH0KICAgICAgICAgICAgaWYgKCRsaW5lIC1tYXRjaCAiXlxzezJ9XGQiIC1vciAkbGluZSAtbWF0Y2ggIl5cc3syfVtBLUYwLTldIikgeyAkZm9udCA9ICRmb250S2V5OyAkYiA9ICRicnVzaFJlZCB9CiAgICAgICAgICAgICRnZnguRHJhd1N0cmluZygkbGluZSwgJGZvbnQsICRiLCAyMCwgJHkpCiAgICAgICAgICAgICR5ICs9ICRsaW5lSGVpZ2h0CiAgICAgICAgfQogICAgICAgIAogICAgICAgICRnZnguRGlzcG9zZSgpCiAgICAgICAgJGJtcC5TYXZlKCRPdXRwdXRQYXRoLCBbU3lzdGVtLkRyYXdpbmcuSW1hZ2luZy5JbWFnZUZvcm1hdF06OlBuZykKICAgICAgICAkYm1wLkRpc3Bvc2UoKQogICAgICAgIAogICAgICAgIHJldHVybiAkdHJ1ZQogICAgfSBjYXRjaCB7CiAgICAgICAgIyBGYWxsYmFjazogZ3VhcmRhciBjb21vIHRleHRvIGZvcm1hdGVhZG8gcGFyYSBpbXByaW1pcgogICAgICAgICR0eHRQYXRoID0gJE91dHB1dFBhdGggLXJlcGxhY2UgJ1wucG5nJCcsICcudHh0JwogICAgICAgICRib3JkZXIgPSAiKyIgKyAoIi0iICogNDgpICsgIisiCiAgICAgICAgJGNvbnRlbnQgPSBAKCkKICAgICAgICAkY29udGVudCArPSAkYm9yZGVyCiAgICAgICAgJGNvbnRlbnQgKz0gInwgIEFUTEFTIFBDIFNVUFBPUlQgLSBCSVRMT0NLRVIgUkVDT1ZFUlkgS0VZICAgIHwiCiAgICAgICAgJGNvbnRlbnQgKz0gJGJvcmRlcgogICAgICAgIGlmICgkTGFiZWwpIHsgJGNvbnRlbnQgKz0gInwgICR7TGFiZWx9Ii5QYWRSaWdodCg0OSkgKyAifCIgfQogICAgICAgICRjb250ZW50ICs9ICJ8ICBDTEFWRToiLlBhZFJpZ2h0KDQ5KSArICJ8IgogICAgICAgICRjb250ZW50ICs9ICJ8ICAke0RhdGF9Ii5QYWRSaWdodCg0OSkgKyAifCIKICAgICAgICAkY29udGVudCArPSAifCAgUEM6ICRlbnY6Q09NUFVURVJOQU1FIHwgJChHZXQtRGF0ZSAtRm9ybWF0ICdkZC9NTS95eXl5JykiLlBhZFJpZ2h0KDQ5KSArICJ8IgogICAgICAgICRjb250ZW50ICs9ICRib3JkZXIKICAgICAgICAkY29udGVudCArPSAiICBSZWNvcnRhciB5IHBlZ2FyIGVuIGxhIGNhcmNhc2EgZGVsIGVxdWlwby4iCiAgICAgICAgCiAgICAgICAgJGNvbnRlbnQgLWpvaW4gImByYG4iIHwgT3V0LUZpbGUgLUZpbGVQYXRoICR0eHRQYXRoIC1FbmNvZGluZyBVVEY4CiAgICAgICAgcmV0dXJuICR0eHRQYXRoCiAgICB9Cn0KCiMgPT09PT09PT09PT09PT09PT09PT0gQkFDS1VQIEEgQUQgLyBBWlVSRSA9PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gQmFja3VwLUtleVRvQUQgewogICAgcGFyYW0oW3N0cmluZ10kTW91bnRQb2ludCkKICAgIAogICAgJHZvbCA9IEdldC1CaXRMb2NrZXJWb2x1bWUgLU1vdW50UG9pbnQgJE1vdW50UG9pbnQgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgIGlmICgtbm90ICR2b2wpIHsgcmV0dXJuICRmYWxzZSB9CiAgICAKICAgICRyZWNvdmVyeUtleXMgPSAkdm9sLktleVByb3RlY3RvciB8IFdoZXJlLU9iamVjdCB7ICRfLktleVByb3RlY3RvclR5cGUgLWVxICdSZWNvdmVyeVBhc3N3b3JkJyB9CiAgICBpZiAoLW5vdCAkcmVjb3ZlcnlLZXlzKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiICAgIE5vIGhheSBjbGF2ZXMgZGUgcmVjdXBlcmFjaW9uIHBhcmEgcmVzcGFsZGFyLiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICByZXR1cm4gJGZhbHNlCiAgICB9CiAgICAKICAgICRzdWNjZXNzID0gJGZhbHNlCiAgICAKICAgIGZvcmVhY2ggKCRrZXkgaW4gJHJlY292ZXJ5S2V5cykgewogICAgICAgICRrZXlJZCA9ICRrZXkuS2V5UHJvdGVjdG9ySWQKICAgICAgICAKICAgICAgICAjIEludGVudGFyIEFEIE9uLVByZW1pc2UKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgSW50ZW50YW5kbyBiYWNrdXAgYSBBY3RpdmUgRGlyZWN0b3J5Li4uIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgdHJ5IHsKICAgICAgICAgICAgQmFja3VwLUJpdExvY2tlcktleVByb3RlY3RvciAtTW91bnRQb2ludCAkTW91bnRQb2ludCAtS2V5UHJvdGVjdG9ySWQgJGtleUlkIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBbT0tdIENsYXZlIHJlc3BhbGRhZGEgZW4gQWN0aXZlIERpcmVjdG9yeS4iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgV3JpdGUtTG9nICJBRCBCYWNrdXAgT0s6ICR7TW91bnRQb2ludH0gS2V5SUQ6ICR7a2V5SWR9IgogICAgICAgICAgICAkc3VjY2VzcyA9ICR0cnVlCiAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgICRhZEVycm9yID0gJF8uRXhjZXB0aW9uLk1lc3NhZ2UKICAgICAgICAgICAgaWYgKCRhZEVycm9yIC1tYXRjaCAibm90IGpvaW5lZHxkb21haW58ZGlyZWN0b3J5IikgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFstLV0gRXF1aXBvIG5vIGVzdGEgZW4gZG9taW5pbyBBRC4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBbLS1dIEFEIG5vIGRpc3BvbmlibGU6ICRhZEVycm9yIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgCiAgICAgICAgIyBJbnRlbnRhciBBenVyZSBBRAogICAgICAgIFdyaXRlLUhvc3QgIiAgICBJbnRlbnRhbmRvIGJhY2t1cCBhIEF6dXJlIEFEIC8gRW50cmEgSUQuLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICB0cnkgewogICAgICAgICAgICAkZHNyZWdTdGF0dXMgPSBkc3JlZ2NtZCAvc3RhdHVzIDI+JjEKICAgICAgICAgICAgJGlzQXp1cmVKb2luZWQgPSAoJGRzcmVnU3RhdHVzIHwgU2VsZWN0LVN0cmluZyAiQXp1cmVBZEpvaW5lZFxzKjpccypZRVMiIC1RdWlldCkKICAgICAgICAgICAgCiAgICAgICAgICAgIGlmICgkaXNBenVyZUpvaW5lZCkgewogICAgICAgICAgICAgICAgQmFja3VwVG9BQUQtQml0TG9ja2VyS2V5UHJvdGVjdG9yIC1Nb3VudFBvaW50ICRNb3VudFBvaW50IC1LZXlQcm90ZWN0b3JJZCAka2V5SWQgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBbT0tdIENsYXZlIHJlc3BhbGRhZGEgZW4gQXp1cmUgQUQgLyBFbnRyYSBJRC4iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgIFdyaXRlLUxvZyAiQXp1cmUgQUQgQmFja3VwIE9LOiAke01vdW50UG9pbnR9IEtleUlEOiAke2tleUlkfSIKICAgICAgICAgICAgICAgICRzdWNjZXNzID0gJHRydWUKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBbLS1dIEVxdWlwbyBubyBlc3RhIHVuaWRvIGEgQXp1cmUgQUQuIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgICAgIH0KICAgICAgICB9IGNhdGNoIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFstLV0gQXp1cmUgQUQgbm8gZGlzcG9uaWJsZS4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICB9CiAgICB9CiAgICAKICAgIHJldHVybiAkc3VjY2Vzcwp9CgojID09PT09PT09PT09PT09PT09PT09IE1PRE8gQ0xJID09PT09PT09PT09PT09PT09PT09CgppZiAoJEFjdGlvbiAtbmUgIiIpIHsKICAgIHN3aXRjaCAoJEFjdGlvbikgewogICAgICAgICJFeHRyYWN0IiB7CiAgICAgICAgICAgICRWb2x1bWVuZXNCTCA9IEdldC1CaXRMb2NrZXJWb2x1bWUgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUgfCBXaGVyZS1PYmplY3QgeyAkXy5Wb2x1bWVTdGF0dXMgLW5lICdGdWxseURlY3J5cHRlZCcgfQogICAgICAgICAgICBpZiAoLW5vdCAkVm9sdW1lbmVzQkwpIHsgV3JpdGUtSG9zdCAiU2luIGRpc2NvcyBwcm90ZWdpZG9zLiI7IGV4aXQgMSB9CiAgICAgICAgICAgIAogICAgICAgICAgICAkb3V0cHV0UGF0aCA9IGlmICgkT3V0cHV0KSB7ICRPdXRwdXQgfSBlbHNlIHsgSm9pbi1QYXRoIChbRW52aXJvbm1lbnRdOjpHZXRGb2xkZXJQYXRoKCJEZXNrdG9wIikpICJCTF8kZW52OkNPTVBVVEVSTkFNRV8kKEdldC1EYXRlIC1Gb3JtYXQgJ3l5eXlNTWRkX0hIbW0nKS50eHQiIH0KICAgICAgICAgICAgCiAgICAgICAgICAgICRjb250ZW50ID0gIkFUTEFTIFBDIFNVUFBPUlQgLSBCSVRMT0NLRVIgS0VZU2ByYG5QQzogJGVudjpDT01QVVRFUk5BTUVgcmBuRmVjaGE6ICQoR2V0LURhdGUpYHJgbi0tLWByYG4iCiAgICAgICAgICAgIGZvcmVhY2ggKCRWb2wgaW4gJFZvbHVtZW5lc0JMKSB7CiAgICAgICAgICAgICAgICAka2V5cyA9ICRWb2wuS2V5UHJvdGVjdG9yIHwgV2hlcmUtT2JqZWN0IHsgJF8uS2V5UHJvdGVjdG9yVHlwZSAtZXEgJ1JlY292ZXJ5UGFzc3dvcmQnIH0KICAgICAgICAgICAgICAgIGZvcmVhY2ggKCRrIGluICRrZXlzKSB7CiAgICAgICAgICAgICAgICAgICAgJGNvbnRlbnQgKz0gIiQoJFZvbC5Nb3VudFBvaW50KSAtPiAkKCRrLlJlY292ZXJ5UGFzc3dvcmQpYHJgbiIKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIkKCRWb2wuTW91bnRQb2ludCkgLT4gJCgkay5SZWNvdmVyeVBhc3N3b3JkKSIKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgICAgICAkY29udGVudCB8IE91dC1GaWxlIC1GaWxlUGF0aCAkb3V0cHV0UGF0aCAtRW5jb2RpbmcgVVRGOAogICAgICAgICAgICBXcml0ZS1Ib3N0ICJHdWFyZGFkbyBlbjogJHtvdXRwdXRQYXRofSIKICAgICAgICAgICAgV3JpdGUtTG9nICJDTEkgRXh0cmFjdDogJHtvdXRwdXRQYXRofSIKICAgICAgICAgICAgcmV0dXJuCiAgICAgICAgfQogICAgICAgICJTdGF0dXMiIHsKICAgICAgICAgICAgJHZvbHMgPSBHZXQtQml0TG9ja2VyVm9sdW1lIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlCiAgICAgICAgICAgIGZvcmVhY2ggKCR2IGluICR2b2xzKSB7CiAgICAgICAgICAgICAgICAkc3RhdHVzID0gJHYuVm9sdW1lU3RhdHVzLlRvU3RyaW5nKCkKICAgICAgICAgICAgICAgICRwY3QgPSAkdi5FbmNyeXB0aW9uUGVyY2VudGFnZQogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiJCgkdi5Nb3VudFBvaW50KSB8ICR7c3RhdHVzfSB8ICR7cGN0fSUiCiAgICAgICAgICAgIH0KICAgICAgICAgICAgcmV0dXJuCiAgICAgICAgfQogICAgfQp9CgojID09PT09PT09PT09PT09PT09PT09IE1FTlUgUFJJTkNJUEFMID09PT09PT09PT09PT09PT09PT09CgpDbGVhci1Ib3N0Cgp3aGlsZSAoJHRydWUpIHsKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgImBuIgogICAgRXNjcmliaXItQ2VudHJhZG8gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgIkRhcmtHcmF5IgogICAgRXNjcmliaXItQ2VudHJhZG8gInwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCIgIkRhcmtZZWxsb3ciCiAgICBFc2NyaWJpci1DZW50cmFkbyAifCAgICAgICAgICAgICAgIEFUTEFTIFBDIFNVUFBPUlQgICAgICAgICAgICAgICAgICB8IiAiRGFya1llbGxvdyIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICJ8ICAgICAgICAgICAgIEdFU1RPUiBCSVRMT0NLRVIgdjMgICAgICAgICAgICAgICAgICB8IiAiRGFya1llbGxvdyIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICJ8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwiICJEYXJrWWVsbG93IgogICAgRXNjcmliaXItQ2VudHJhZG8gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgIkRhcmtHcmF5IgogICAgCiAgICAjIFRQTSBzdGF0dXMKICAgIFdyaXRlLUhvc3QgIiIKICAgICR0cG1JbmZvID0gR2V0LVRQTVN0YXR1cwogICAgJHRwbUNvbG9yID0gaWYgKCR0cG1JbmZvLkhhc1RQTSAtYW5kICR0cG1JbmZvLklzUmVhZHkpIHsgIkdyZWVuIiB9IGVsc2VpZiAoJHRwbUluZm8uSGFzVFBNKSB7ICJZZWxsb3ciIH0gZWxzZSB7ICJSZWQiIH0KICAgIEVzY3JpYmlyLUNlbnRyYWRvICJUUE06ICQoJHRwbUluZm8uU3VtbWFyeSkiICR0cG1Db2xvcgogICAgCiAgICAjIERpc2NvcyBwcm90ZWdpZG9zCiAgICAkYmxWb2x1bWVzID0gR2V0LUJpdExvY2tlclZvbHVtZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSB8IFdoZXJlLU9iamVjdCB7ICRfLlZvbHVtZVN0YXR1cyAtbmUgJ0Z1bGx5RGVjcnlwdGVkJyB9CiAgICAkYmxDb3VudCA9IGlmICgkYmxWb2x1bWVzKSB7IEAoJGJsVm9sdW1lcykuQ291bnQgfSBlbHNlIHsgMCB9CiAgICBFc2NyaWJpci1DZW50cmFkbyAiRGlzY29zIHByb3RlZ2lkb3M6ICR7YmxDb3VudH0iICQoaWYgKCRibENvdW50IC1ndCAwKSB7ICJDeWFuIiB9IGVsc2UgeyAiRGFya0dyYXkiIH0pCiAgICAKICAgICMgQUxFUlRBIERJU0NPUyBTSU4gUFJPVEVHRVIKICAgIFNob3ctVW5wcm90ZWN0ZWRBbGVydAogICAgCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiWyAxIF0gRXNjYW5lYXIgeSBHdWFyZGFyIENsYXZlcyIgIldoaXRlIgogICAgRXNjcmliaXItQ2VudHJhZG8gIlsgMiBdIEFjdGl2YXIgQml0TG9ja2VyIiAiV2hpdGUiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiWyAzIF0gRGVzYWN0aXZhciBCaXRMb2NrZXIiICJXaGl0ZSIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICJbIDQgXSBWZXIgRXN0YWRvIENvbXBsZXRvIiAiV2hpdGUiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiWyA1IF0gVmVyIEhpc3RvcmlhbCBkZSBPcGVyYWNpb25lcyIgIldoaXRlIgogICAgRXNjcmliaXItQ2VudHJhZG8gIlsgUyBdIFNhbGlyIiAiRGFya0dyYXkiCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAiRGFya0dyYXkiCiAgICBXcml0ZS1Ib3N0ICIiCiAgICAKICAgICRPcGNpb24gPSBSZWFkLUhvc3QgIiAgT3BjaW9uIgoKICAgIHN3aXRjaCAoJE9wY2lvbi5Ub1VwcGVyKCkpIHsKICAgICAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgICAgICMgMS4gRVhUUkFFUiBDTEFWRVMgKCsgVVNCICsgUVIgKyBBRCArIENsaXBib2FyZCkKICAgICAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgICAgICIxIiB7CiAgICAgICAgICAgIENsZWFyLUhvc3QKICAgICAgICAgICAgV3JpdGUtSG9zdCAiYG4iCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICI9PT0gRVhUUkFDQ0lPTiBERSBDTEFWRVMgQklUTE9DS0VSID09PSIgIkRhcmtZZWxsb3ciCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgCiAgICAgICAgICAgICROb21icmVFcXVpcG8gPSAkZW52OkNPTVBVVEVSTkFNRQogICAgICAgICAgICAkVXN1YXJpb0FjdHVhbCA9ICRlbnY6VVNFUk5BTUUKICAgICAgICAgICAgJEZlY2hhSG9yYSA9IEdldC1EYXRlIC1Gb3JtYXQgJ2RkLU1NLXl5eXlfSEhtbScKICAgICAgICAgICAgJE5vbWJyZUFyY2hpdm8gPSAiQkxfJHtOb21icmVFcXVpcG99XyR7RmVjaGFIb3JhfS50eHQiCiAgICAgICAgICAgIAogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRXNjYW5lYW5kbyBkaXNjb3MgcHJvdGVnaWRvcy4uLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICAkVm9sdW1lbmVzQkwgPSBHZXQtQml0TG9ja2VyVm9sdW1lIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlIHwgV2hlcmUtT2JqZWN0IHsgJF8uVm9sdW1lU3RhdHVzIC1uZSAnRnVsbHlEZWNyeXB0ZWQnIH0KICAgICAgICAgICAgCiAgICAgICAgICAgIGlmICgtbm90ICRWb2x1bWVuZXNCTCkgewogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIk5vIHNlIGVuY29udHJhcm9uIGRpc2NvcyBjb24gQml0TG9ja2VyIGFjdGl2by4iICJSZWQiCiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAkQ29udGVuaWRvID0gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PWByYG4iCiAgICAgICAgICAgICAgICAkQ29udGVuaWRvICs9ICIgICAgICBBVExBUyBQQyBTVVBQT1JUIC0gUkVTUEFMRE8gREUgQklUTE9DS0VSYHJgbiIKICAgICAgICAgICAgICAgICRDb250ZW5pZG8gKz0gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PWByYG4iCiAgICAgICAgICAgICAgICAkQ29udGVuaWRvICs9ICJGZWNoYSAgICAgICAgICAgICAgIDogJChHZXQtRGF0ZSAtRm9ybWF0ICdkZC9NTS95eXl5IEhIOm1tOnNzJylgcmBuIgogICAgICAgICAgICAgICAgJENvbnRlbmlkbyArPSAiTm9tYnJlIGRlbCBFcXVpcG8gICA6ICR7Tm9tYnJlRXF1aXBvfWByYG4iCiAgICAgICAgICAgICAgICAkQ29udGVuaWRvICs9ICJVc3VhcmlvIEFjdGl2byAgICAgIDogJHtVc3VhcmlvQWN0dWFsfWByYG4iCiAgICAgICAgICAgICAgICAkQ29udGVuaWRvICs9ICItLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1gcmBuYHJgbiIKICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgJENsYXZlc0VuY29udHJhZGFzID0gMAogICAgICAgICAgICAgICAgJGNsYXZlc1BhcmFDbGlwYm9hcmQgPSBAKCkKICAgICAgICAgICAgICAgICRjbGF2ZXNQYXJhUVIgPSBAKCkKICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgZm9yZWFjaCAoJFZvbCBpbiAkVm9sdW1lbmVzQkwpIHsKICAgICAgICAgICAgICAgICAgICAkQ2xhdmVzID0gJFZvbC5LZXlQcm90ZWN0b3IgfCBXaGVyZS1PYmplY3QgeyAkXy5LZXlQcm90ZWN0b3JUeXBlIC1lcSAnUmVjb3ZlcnlQYXNzd29yZCcgfQogICAgICAgICAgICAgICAgICAgIGlmICgkQ2xhdmVzKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIGZvcmVhY2ggKCRDbGF2ZSBpbiAkQ2xhdmVzKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAkbW91bnQgPSAkVm9sLk1vdW50UG9pbnQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICRrZXkgPSAkQ2xhdmUuUmVjb3ZlcnlQYXNzd29yZAogICAgICAgICAgICAgICAgICAgICAgICAgICAgJGtleUlkID0gJENsYXZlLktleVByb3RlY3RvcklkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICRDb250ZW5pZG8gKz0gIlVOSURBRDogJHttb3VudH1gcmBuIgogICAgICAgICAgICAgICAgICAgICAgICAgICAgJENvbnRlbmlkbyArPSAiSUQ6ICAgICAke2tleUlkfWByYG4iCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAkQ29udGVuaWRvICs9ICJDTEFWRTogICR7a2V5fWByYG5gcmBuIgogICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAkY2xhdmVzUGFyYUNsaXBib2FyZCArPSAiJHttb3VudH0gLT4gJHtrZXl9IgogICAgICAgICAgICAgICAgICAgICAgICAgICAgJGNsYXZlc1BhcmFRUiArPSBAeyBNb3VudCA9ICRtb3VudDsgS2V5ID0gJGtleTsgS2V5SWQgPSAka2V5SWQgfQogICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW09LXSAke21vdW50fSAtPiAke2tleX0iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICRDbGF2ZXNFbmNvbnRyYWRhcysrCiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgIGlmICgkQ2xhdmVzRW5jb250cmFkYXMgLWVxIDApIHsKICAgICAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiTm8gc2UgZW5jb250cmFyb24gY2xhdmVzIGRlIHJlY3VwZXJhY2lvbi4iICJSZWQiCiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgICRDb250ZW5pZG8gKz0gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PWByYG4iCiAgICAgICAgICAgICAgICAgICAgJENvbnRlbmlkbyArPSAiVE9UQUw6ICR7Q2xhdmVzRW5jb250cmFkYXN9IGNsYXZlKHMpYHJgbiIKICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIiR7Q2xhdmVzRW5jb250cmFkYXN9IGNsYXZlKHMpIGVuY29udHJhZGEocykiICJHcmVlbiIKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Mb2cgIkV4dHJhY2Npb246ICR7Q2xhdmVzRW5jb250cmFkYXN9IGNsYXZlcyBkZSAke05vbWJyZUVxdWlwb30iCiAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgJHJ1dGFzR3VhcmRhZGFzID0gQCgpCiAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgIyBHdWFyZGFyIGVuIGVzY3JpdG9yaW8KICAgICAgICAgICAgICAgICAgICAkUnV0YUVzY3JpdG9yaW8gPSBbRW52aXJvbm1lbnRdOjpHZXRGb2xkZXJQYXRoKCJEZXNrdG9wIikKICAgICAgICAgICAgICAgICAgICAkUnV0YUNvbXBsZXRhID0gSm9pbi1QYXRoICRSdXRhRXNjcml0b3JpbyAkTm9tYnJlQXJjaGl2bwogICAgICAgICAgICAgICAgICAgIHRyeSB7CiAgICAgICAgICAgICAgICAgICAgICAgICRDb250ZW5pZG8gfCBPdXQtRmlsZSAtRmlsZVBhdGggJFJ1dGFDb21wbGV0YSAtRW5jb2RpbmcgVVRGOAogICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW09LXSBFc2NyaXRvcmlvOiAke05vbWJyZUFyY2hpdm99IiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgICAgICAgICAgICAgICAgICAgICAgJHJ1dGFzR3VhcmRhZGFzICs9ICRSdXRhQ29tcGxldGEKICAgICAgICAgICAgICAgICAgICB9IGNhdGNoIHsgV3JpdGUtSG9zdCAiICAgIFtFUlJPUl0gTm8gc2UgZ3VhcmRvIGVuIGVzY3JpdG9yaW8uIiAtRm9yZWdyb3VuZENvbG9yIFJlZCB9CiAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgIyBVU0IKICAgICAgICAgICAgICAgICAgICAkdXNicyA9IEdldC1Wb2x1bWUgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUgfCBXaGVyZS1PYmplY3QgeyAkXy5Ecml2ZVR5cGUgLWVxICdSZW1vdmFibGUnIC1hbmQgJF8uRHJpdmVMZXR0ZXIgLWFuZCAkXy5TaXplIC1ndCAwIH0KICAgICAgICAgICAgICAgICAgICBpZiAoJHVzYnMpIHsKICAgICAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgVVNCIGRldGVjdGFkbyhzKS4gR3VhcmRhciBjb3BpYT8gW1MvTl0iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICAgICAgICAgICR1c2JTZWwgPSBSZWFkLUhvc3QgIiAgICA+IgogICAgICAgICAgICAgICAgICAgICAgICBpZiAoJHVzYlNlbCAtZXEgIlMiIC1vciAkdXNiU2VsIC1lcSAicyIpIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvcmVhY2ggKCR1IGluICR1c2JzKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJHVzYlBhdGggPSBKb2luLVBhdGggKCR1LkRyaXZlTGV0dGVyICsgIjpcIikgJE5vbWJyZUFyY2hpdm8KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJENvbnRlbmlkbyB8IE91dC1GaWxlIC1GaWxlUGF0aCAkdXNiUGF0aCAtRW5jb2RpbmcgVVRGOAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW09LXSBVU0IgJCgkdS5Ecml2ZUxldHRlcik6ICR7Tm9tYnJlQXJjaGl2b30iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJHJ1dGFzR3VhcmRhZGFzICs9ICR1c2JQYXRoCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfSBjYXRjaCB7IFdyaXRlLUhvc3QgIiAgICBbRVJST1JdIFVTQiAkKCR1LkRyaXZlTGV0dGVyKTogJCgkXy5FeGNlcHRpb24uTWVzc2FnZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkIH0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAjIFFSIC8gSW1hZ2VuIGltcHJpbWlibGUKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIEdlbmVyYXIgaW1hZ2VuIGltcHJpbWlibGUgZGUgbGFzIGNsYXZlcz8gW1MvTl0iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICAgICAgJHFyU2VsID0gUmVhZC1Ib3N0ICIgICAgPiIKICAgICAgICAgICAgICAgICAgICBpZiAoJHFyU2VsIC1lcSAiUyIgLW9yICRxclNlbCAtZXEgInMiKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIGZvcmVhY2ggKCRrSW5mbyBpbiAkY2xhdmVzUGFyYVFSKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAkcXJGaWxlTmFtZSA9ICJCTF9LRVlfJHtOb21icmVFcXVpcG99XyQoJGtJbmZvLk1vdW50LlRyaW1FbmQoJzonKSlfJHtGZWNoYUhvcmF9LnBuZyIKICAgICAgICAgICAgICAgICAgICAgICAgICAgICRxclBhdGggPSBKb2luLVBhdGggJFJ1dGFFc2NyaXRvcmlvICRxckZpbGVOYW1lCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAkbGFiZWwgPSAiRGlzY286ICQoJGtJbmZvLk1vdW50KSB8IFBDOiAke05vbWJyZUVxdWlwb30iCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAkcXJSZXN1bHQgPSBHZW5lcmF0ZS1RUkNvZGUgLURhdGEgJGtJbmZvLktleSAtT3V0cHV0UGF0aCAkcXJQYXRoIC1MYWJlbCAkbGFiZWwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICgkcXJSZXN1bHQgLWVxICR0cnVlKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtPS10gSW1hZ2VuOiAke3FyRmlsZU5hbWV9IiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJHJ1dGFzR3VhcmRhZGFzICs9ICRxclBhdGgKICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZWlmICgkcXJSZXN1bHQpIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW09LXSBUZXh0byBpbXByaW1pYmxlOiAkKFNwbGl0LVBhdGggJHFyUmVzdWx0IC1MZWFmKSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICRydXRhc0d1YXJkYWRhcyArPSAkcXJSZXN1bHQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtFUlJPUl0gTm8gc2UgZ2VuZXJvIGltYWdlbi4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiSW1wcmltZSBsYSBpbWFnZW4geSBwZWdhbGEgZW4gbGEgY2FyY2FzYSBkZWwgZXF1aXBvLiIgIkN5YW4iCiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICMgQUQgLyBBenVyZSBBRCBiYWNrdXAKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIEludGVudGFyIGJhY2t1cCBhIEFjdGl2ZSBEaXJlY3RvcnkgLyBBenVyZSBBRD8gW1MvTl0iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICAgICAgJGFkU2VsID0gUmVhZC1Ib3N0ICIgICAgPiIKICAgICAgICAgICAgICAgICAgICBpZiAoJGFkU2VsIC1lcSAiUyIgLW9yICRhZFNlbCAtZXEgInMiKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIGZvcmVhY2ggKCRWb2wgaW4gJFZvbHVtZW5lc0JMKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAkYWRPayA9IEJhY2t1cC1LZXlUb0FEIC1Nb3VudFBvaW50ICRWb2wuTW91bnRQb2ludAogICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICMgQ2xpcGJvYXJkCiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBDb3BpYXIgY2xhdmVzIGFsIHBvcnRhcGFwZWxlcz8gW1MvTl0iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgICAgICAgICAkY2xpcFNlbCA9IFJlYWQtSG9zdCAiICAgID4iCiAgICAgICAgICAgICAgICAgICAgaWYgKCRjbGlwU2VsIC1lcSAiUyIgLW9yICRjbGlwU2VsIC1lcSAicyIpIHsKICAgICAgICAgICAgICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICgkY2xhdmVzUGFyYUNsaXBib2FyZCAtam9pbiAiYHJgbiIpIHwgU2V0LUNsaXBib2FyZAogICAgICAgICAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtPS10gQ29waWFkbyBhbCBwb3J0YXBhcGVsZXMuIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgICAgICAgICAgICAgIH0gY2F0Y2ggeyBXcml0ZS1Ib3N0ICIgICAgW0VSUk9SXSBDbGlwYm9hcmQgbm8gZGlzcG9uaWJsZS4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkIH0KICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgIyBSZXN1bWVuCiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJSRVNVTUVOIERFIEJBQ0tVUFM6IiAiV2hpdGUiCiAgICAgICAgICAgICAgICAgICAgZm9yZWFjaCAoJHJ1dGEgaW4gJHJ1dGFzR3VhcmRhZGFzKSB7IFdyaXRlLUhvc3QgIiAgICAtPiAke3J1dGF9IiAtRm9yZWdyb3VuZENvbG9yIEdyYXkgfQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgICAgIFdyaXRlLUhvc3QgImBuIjsgUmVhZC1Ib3N0ICIgICAgRU5URVIgcGFyYSB2b2x2ZXIuLi4iCiAgICAgICAgfQoKICAgICAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgICAgICMgMi4gQUNUSVZBUiBCSVRMT0NLRVIgKGNvbiBIZWFsdGggQ2hlY2spCiAgICAgICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICAgICAiMiIgewogICAgICAgICAgICBDbGVhci1Ib3N0CiAgICAgICAgICAgIFdyaXRlLUhvc3QgImBuIgogICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiPT09IEFDVElWQVIgQklUTE9DS0VSID09PSIgIkRhcmtZZWxsb3ciCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgCiAgICAgICAgICAgICMgVFBNIGNoZWNrCiAgICAgICAgICAgICR0cG0gPSBHZXQtVFBNU3RhdHVzCiAgICAgICAgICAgICR0cG1Db2xvciA9IGlmICgkdHBtLkhhc1RQTSAtYW5kICR0cG0uSXNSZWFkeSkgeyAiR3JlZW4iIH0gZWxzZWlmICgkdHBtLkhhc1RQTSkgeyAiWWVsbG93IiB9IGVsc2UgeyAiUmVkIiB9CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBUUE06ICQoJHRwbS5TdW1tYXJ5KSIgLUZvcmVncm91bmRDb2xvciAkdHBtQ29sb3IKICAgICAgICAgICAgCiAgICAgICAgICAgIGlmICgtbm90ICR0cG0uSGFzVFBNKSB7CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgU2luIFRQTSA9IGNvbnRyYXNlbmEgcmVxdWVyaWRhIGVuIGNhZGEgYXJyYW5xdWUuIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtDXSBDb250aW51YXIgY29uIGNvbnRyYXNlbmEgIFtCXSBWb2x2ZXIiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICAgICAgICAgICR0cG1DaG9pY2UgPSBSZWFkLUhvc3QgIiAgICA+IgogICAgICAgICAgICAgICAgaWYgKCR0cG1DaG9pY2UgLW5lICJDIiAtYW5kICR0cG1DaG9pY2UgLW5lICJjIikgeyBjb250aW51ZSB9CiAgICAgICAgICAgIH0gZWxzZWlmICgtbm90ICR0cG0uSXNSZWFkeSkgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFB1ZWRlIHJlcXVlcmlyIGFjdGl2YWNpb24gZW4gQklPUy4iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgIH0KICAgICAgICAgICAgCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgJGFsbFZvbHVtZXMgPSBTaG93LURpc2tUYWJsZQogICAgICAgICAgICBpZiAoLW5vdCAkYWxsVm9sdW1lcykgeyBSZWFkLUhvc3QgIiAgICBFTlRFUiBwYXJhIHZvbHZlci4uLiI7IGNvbnRpbnVlIH0KICAgICAgICAgICAgCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBEaXNjbyBhIGVuY3JpcHRhciAobyBbQl0gcGFyYSB2b2x2ZXIpOiIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgICAgICAkaW5wdXQgPSBSZWFkLUhvc3QgIiAgICA+IgogICAgICAgICAgICBpZiAoJGlucHV0IC1lcSAiQiIgLW9yICRpbnB1dCAtZXEgImIiKSB7IGNvbnRpbnVlIH0KICAgICAgICAgICAgCiAgICAgICAgICAgICR2YWxpZGF0ZWQgPSBWYWxpZGF0ZS1Ecml2ZUxldHRlciAtSW5wdXQgJGlucHV0IC1WYWxpZFZvbHVtZXMgJGFsbFZvbHVtZXMKICAgICAgICAgICAgaWYgKC1ub3QgJHZhbGlkYXRlZCkgeyBSZWFkLUhvc3QgIiAgICBFTlRFUiBwYXJhIHZvbHZlci4uLiI7IGNvbnRpbnVlIH0KICAgICAgICAgICAgCiAgICAgICAgICAgICRkaXNjbyA9ICR2YWxpZGF0ZWQuTGV0dGVyOyAkdm9sID0gJHZhbGlkYXRlZC5Wb2x1bWUKICAgICAgICAgICAgCiAgICAgICAgICAgIGlmICgkdm9sLlZvbHVtZVN0YXR1cyAtZXEgJ0Z1bGx5RW5jcnlwdGVkJykgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICR7ZGlzY299IFlBIGVzdGEgZW5jcmlwdGFkby4iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICBSZWFkLUhvc3QgIiAgICBFTlRFUiBwYXJhIHZvbHZlci4uLiI7IGNvbnRpbnVlCiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKCR2b2wuVm9sdW1lU3RhdHVzIC1lcSAnRW5jcnlwdGlvbkluUHJvZ3Jlc3MnKSB7CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgJHtkaXNjb30geWEgc2UgZXN0YSBlbmNyaXB0YW5kby4iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICBTaG93LUVuY3J5cHRpb25Qcm9ncmVzcyAtTW91bnRQb2ludCAkZGlzY28gLU1vZGUgIkVuY3J5cHRpbmciCiAgICAgICAgICAgICAgICBSZWFkLUhvc3QgIiAgICBFTlRFUiBwYXJhIHZvbHZlci4uLiI7IGNvbnRpbnVlCiAgICAgICAgICAgIH0KICAgICAgICAgICAgCiAgICAgICAgICAgICMgSEVBTFRIIENIRUNLCiAgICAgICAgICAgICRoZWFsdGggPSBUZXN0LVByZUVuY3J5cHRpb25IZWFsdGggLU1vdW50UG9pbnQgJGRpc2NvCiAgICAgICAgICAgIAogICAgICAgICAgICBpZiAoLW5vdCAkaGVhbHRoLkNhblByb2NlZWQpIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJOTyBTRSBSRUNPTUlFTkRBIEVOQ1JJUFRBUiBFTiBFU1RFIEVTVEFETy4iICJSZWQiCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW0ZdIEZvcnphciBkZSB0b2RvcyBtb2RvcyAgW0JdIFZvbHZlciAocmVjb21lbmRhZG8pIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICAgICAgJGZvcmNlQ2hvaWNlID0gUmVhZC1Ib3N0ICIgICAgPiIKICAgICAgICAgICAgICAgIGlmICgkZm9yY2VDaG9pY2UgLW5lICJGIiAtYW5kICRmb3JjZUNob2ljZSAtbmUgImYiKSB7CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtTG9nICJFbmNyaXB0YWNpb24gY2FuY2VsYWRhIHBvciBIZWFsdGhDaGVjazogJHtkaXNjb30iCiAgICAgICAgICAgICAgICAgICAgY29udGludWUKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIFdyaXRlLUxvZyAiSGVhbHRoQ2hlY2sgRk9SWkFETyBwb3IgdXN1YXJpbzogJHtkaXNjb30iCiAgICAgICAgICAgIH0KICAgICAgICAgICAgCiAgICAgICAgICAgICMgQ29uZmlybWFjacOzbgogICAgICAgICAgICAkY2FwR0IgPSBpZiAoJHZvbC5DYXBhY2l0eUdCKSB7ICJ7MDpOMX0iIC1mICR2b2wuQ2FwYWNpdHlHQiB9IGVsc2UgeyAiPyIgfQogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJDT05GSVJNQVI6IEFjdGl2YXIgQml0TG9ja2VyIGVuICR7ZGlzY299ICgke2NhcEdCfSBHQik/IiAiWWVsbG93IgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW1NdIEVuY3JpcHRhciAgW05dIENhbmNlbGFyIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgICAgICRjb25maXJtID0gUmVhZC1Ib3N0ICIgICAgPiIKICAgICAgICAgICAgaWYgKCRjb25maXJtIC1uZSAiUyIgLWFuZCAkY29uZmlybSAtbmUgInMiKSB7IGNvbnRpbnVlIH0KICAgICAgICAgICAgCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIEFjdGl2YW5kbyBCaXRMb2NrZXIgZW4gJHtkaXNjb30uLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgIAogICAgICAgICAgICB0cnkgewogICAgICAgICAgICAgICAgaWYgKCR0cG0uSGFzVFBNIC1hbmQgJHRwbS5Jc1JlYWR5KSB7CiAgICAgICAgICAgICAgICAgICAgRW5hYmxlLUJpdExvY2tlciAtTW91bnRQb2ludCAkZGlzY28gLUVuY3J5cHRpb25NZXRob2QgWHRzQWVzMjU2IC1SZWNvdmVyeVBhc3N3b3JkUHJvdGVjdG9yIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBJbmdyZXNhIGNvbnRyYXNlbmEgcGFyYSBhcnJhbnF1ZToiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgICAgICAgICAgICAgICRzZWNQd2QgPSBSZWFkLUhvc3QgIiAgICBDb250cmFzZW5hIiAtQXNTZWN1cmVTdHJpbmcKICAgICAgICAgICAgICAgICAgICBFbmFibGUtQml0TG9ja2VyIC1Nb3VudFBvaW50ICRkaXNjbyAtRW5jcnlwdGlvbk1ldGhvZCBYdHNBZXMyNTYgLVBhc3N3b3JkUHJvdGVjdG9yIC1QYXNzd29yZCAkc2VjUHdkIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgICAgICAgICAgQWRkLUJpdExvY2tlcktleVByb3RlY3RvciAtTW91bnRQb2ludCAkZGlzY28gLVJlY292ZXJ5UGFzc3dvcmRQcm90ZWN0b3IgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIkJpdExvY2tlciBBQ1RJVkFETyBlbiAke2Rpc2NvfSIgIkdyZWVuIgogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIlVTQSBPUENJT04gWzFdIFBBUkEgR1VBUkRBUiBMQSBDTEFWRSEiICJDeWFuIgogICAgICAgICAgICAgICAgV3JpdGUtTG9nICJCaXRMb2NrZXIgQUNUSVZBRE86ICR7ZGlzY299IChYdHNBZXMyNTYpIgogICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAjIEFEIGJhY2t1cCBhdXRvbWF0aWNvCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICBCYWNrdXAtS2V5VG9BRCAtTW91bnRQb2ludCAkZGlzY28KICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtNXSBNb25pdG9yZWFyIHByb2dyZXNvICBbRU5URVJdIFZvbHZlciIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICAgICAgJG1vblNlbCA9IFJlYWQtSG9zdCAiICAgID4iCiAgICAgICAgICAgICAgICBpZiAoJG1vblNlbCAtZXEgIk0iIC1vciAkbW9uU2VsIC1lcSAibSIpIHsKICAgICAgICAgICAgICAgICAgICBTaG93LUVuY3J5cHRpb25Qcm9ncmVzcyAtTW91bnRQb2ludCAkZGlzY28gLU1vZGUgIkVuY3J5cHRpbmciCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtFUlJPUl0gJCgkXy5FeGNlcHRpb24uTWVzc2FnZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgICAgICBXcml0ZS1Mb2cgIkVSUk9SIGFjdGl2YW5kbyBCaXRMb2NrZXIgJHtkaXNjb306ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAiRVJST1IiCiAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICRtc2cgPSAkXy5FeGNlcHRpb24uTWVzc2FnZQogICAgICAgICAgICAgICAgaWYgKCRtc2cgLW1hdGNoICJUUE0iKSB7CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFNVR0VSRU5DSUE6IEFjdGl2YSBUUE0gZW4gQklPUy4iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAoJG1zZyAtbWF0Y2ggInBvbGljeXxHcm91cCBQb2xpY3kiKSB7CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFNVR0VSRU5DSUE6IGdwZWRpdC5tc2MgPiBDb21wdXRlciBDb25maWcgPiBBZG1pbiBUZW1wbGF0ZXMgPiBCaXRMb2NrZXIiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgV3JpdGUtSG9zdCAiIjsgUmVhZC1Ib3N0ICIgICAgRU5URVIgcGFyYSB2b2x2ZXIuLi4iCiAgICAgICAgfQoKICAgICAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgICAgICMgMy4gREVTQUNUSVZBUiBCSVRMT0NLRVIKICAgICAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgICAgICIzIiB7CiAgICAgICAgICAgIENsZWFyLUhvc3QKICAgICAgICAgICAgV3JpdGUtSG9zdCAiYG4iCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICI9PT0gREVTQUNUSVZBUiBCSVRMT0NLRVIgPT09IiAiRGFya1llbGxvdyIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAKICAgICAgICAgICAgJGVuY1ZvbHVtZXMgPSBTaG93LURpc2tUYWJsZSAtT25seUVuY3J5cHRlZAogICAgICAgICAgICBpZiAoLW5vdCAkZW5jVm9sdW1lcykgeyBSZWFkLUhvc3QgIiAgICBFTlRFUiBwYXJhIHZvbHZlci4uLiI7IGNvbnRpbnVlIH0KICAgICAgICAgICAgCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBEaXNjbyBhIGRlc2VuY3JpcHRhciAobyBbQl0pOiIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgICAgICAkaW5wdXQgPSBSZWFkLUhvc3QgIiAgICA+IgogICAgICAgICAgICBpZiAoJGlucHV0IC1lcSAiQiIgLW9yICRpbnB1dCAtZXEgImIiKSB7IGNvbnRpbnVlIH0KICAgICAgICAgICAgCiAgICAgICAgICAgICR2YWxpZGF0ZWQgPSBWYWxpZGF0ZS1Ecml2ZUxldHRlciAtSW5wdXQgJGlucHV0IC1WYWxpZFZvbHVtZXMgJGVuY1ZvbHVtZXMKICAgICAgICAgICAgaWYgKC1ub3QgJHZhbGlkYXRlZCkgeyBSZWFkLUhvc3QgIiAgICBFTlRFUiBwYXJhIHZvbHZlci4uLiI7IGNvbnRpbnVlIH0KICAgICAgICAgICAgCiAgICAgICAgICAgICRkaXNjbyA9ICR2YWxpZGF0ZWQuTGV0dGVyOyAkdm9sID0gJHZhbGlkYXRlZC5Wb2x1bWUKICAgICAgICAgICAgCiAgICAgICAgICAgIGlmICgkdm9sLlZvbHVtZVN0YXR1cyAtZXEgJ0RlY3J5cHRpb25JblByb2dyZXNzJykgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFlhIHNlIGVzdGEgZGVzZW5jcmlwdGFuZG8uIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICAgICAgU2hvdy1FbmNyeXB0aW9uUHJvZ3Jlc3MgLU1vdW50UG9pbnQgJGRpc2NvIC1Nb2RlICJEZWNyeXB0aW5nIgogICAgICAgICAgICAgICAgUmVhZC1Ib3N0ICIgICAgRU5URVIgcGFyYSB2b2x2ZXIuLi4iOyBjb250aW51ZQogICAgICAgICAgICB9CiAgICAgICAgICAgIAogICAgICAgICAgICAkY2FwR0IgPSBpZiAoJHZvbC5DYXBhY2l0eUdCKSB7ICJ7MDpOMX0iIC1mICR2b2wuQ2FwYWNpdHlHQiB9IGVsc2UgeyAiPyIgfQogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJDT05GSVJNQVI6IERlc2FjdGl2YXIgQml0TG9ja2VyIGVuICR7ZGlzY299ICgke2NhcEdCfSBHQik/IiAiUmVkIgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgQURWRVJURU5DSUE6IExvcyBkYXRvcyBxdWVkYXJhbiBzaW4gcHJvdGVjY2lvbi4iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBbU10gRGVzZW5jcmlwdGFyICBbTl0gQ2FuY2VsYXIiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICAgICAgJGNvbmZpcm0gPSBSZWFkLUhvc3QgIiAgICA+IgogICAgICAgICAgICBpZiAoJGNvbmZpcm0gLW5lICJTIiAtYW5kICRjb25maXJtIC1uZSAicyIpIHsgY29udGludWUgfQogICAgICAgICAgICAKICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgIERpc2FibGUtQml0TG9ja2VyIC1Nb3VudFBvaW50ICRkaXNjbyAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIkRlc2VuY3JpcHRhY2lvbiBpbmljaWFkYSBlbiAke2Rpc2NvfS4iICJHcmVlbiIKICAgICAgICAgICAgICAgIFdyaXRlLUxvZyAiQml0TG9ja2VyIERFU0FDVElWQURPOiAke2Rpc2NvfSIKICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtNXSBNb25pdG9yZWFyICBbRU5URVJdIFZvbHZlciIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICAgICAgJG1vblNlbCA9IFJlYWQtSG9zdCAiICAgID4iCiAgICAgICAgICAgICAgICBpZiAoJG1vblNlbCAtZXEgIk0iIC1vciAkbW9uU2VsIC1lcSAibSIpIHsKICAgICAgICAgICAgICAgICAgICBTaG93LUVuY3J5cHRpb25Qcm9ncmVzcyAtTW91bnRQb2ludCAkZGlzY28gLU1vZGUgIkRlY3J5cHRpbmciCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtFUlJPUl0gJCgkXy5FeGNlcHRpb24uTWVzc2FnZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgICAgICBXcml0ZS1Mb2cgIkVSUk9SIGRlc2FjdGl2YW5kbyAke2Rpc2NvfTogJCgkXy5FeGNlcHRpb24uTWVzc2FnZSkiICJFUlJPUiIKICAgICAgICAgICAgfQogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiOyBSZWFkLUhvc3QgIiAgICBFTlRFUiBwYXJhIHZvbHZlci4uLiIKICAgICAgICB9CgogICAgICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAgICAgIyA0LiBFU1RBRE8gQ09NUExFVE8KICAgICAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgICAgICI0IiB7CiAgICAgICAgICAgIENsZWFyLUhvc3QKICAgICAgICAgICAgV3JpdGUtSG9zdCAiYG4iCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICI9PT0gRVNUQURPIENPTVBMRVRPID09PSIgIkRhcmtZZWxsb3ciCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgCiAgICAgICAgICAgICR0cG0gPSBHZXQtVFBNU3RhdHVzCiAgICAgICAgICAgICR0cG1Db2xvciA9IGlmICgkdHBtLkhhc1RQTSAtYW5kICR0cG0uSXNSZWFkeSkgeyAiR3JlZW4iIH0gZWxzZWlmICgkdHBtLkhhc1RQTSkgeyAiWWVsbG93IiB9IGVsc2UgeyAiUmVkIiB9CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBUUE06ICQoJHRwbS5TdW1tYXJ5KSIgLUZvcmVncm91bmRDb2xvciAkdHBtQ29sb3IKICAgICAgICAgICAgCiAgICAgICAgICAgIFNob3ctRGlza1RhYmxlIHwgT3V0LU51bGwKICAgICAgICAgICAgCiAgICAgICAgICAgICMgQWxlcnRhCiAgICAgICAgICAgIFNob3ctVW5wcm90ZWN0ZWRBbGVydAogICAgICAgICAgICAKICAgICAgICAgICAgIyBQcm90ZWN0b3JlcwogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBQUk9URUNUT1JFUyBBQ1RJVk9TOiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgJGFsbFZvbHMgPSBHZXQtQml0TG9ja2VyVm9sdW1lIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlCiAgICAgICAgICAgICRoYXNQcm90ZWN0b3JzID0gJGZhbHNlCiAgICAgICAgICAgIGZvcmVhY2ggKCR2IGluICRhbGxWb2xzKSB7CiAgICAgICAgICAgICAgICBpZiAoJHYuVm9sdW1lU3RhdHVzIC1uZSAnRnVsbHlEZWNyeXB0ZWQnIC1hbmQgJHYuS2V5UHJvdGVjdG9yKSB7CiAgICAgICAgICAgICAgICAgICAgZm9yZWFjaCAoJGtwIGluICR2LktleVByb3RlY3RvcikgewogICAgICAgICAgICAgICAgICAgICAgICAka3BUeXBlID0gJGtwLktleVByb3RlY3RvclR5cGUuVG9TdHJpbmcoKQogICAgICAgICAgICAgICAgICAgICAgICAka3BJZCA9IGlmICgka3AuS2V5UHJvdGVjdG9ySWQpIHsgJGtwLktleVByb3RlY3RvcklkLlN1YnN0cmluZygwLCBbbWF0aF06Ok1pbigyMCwgJGtwLktleVByb3RlY3RvcklkLkxlbmd0aCkpICsgIi4uLiIgfSBlbHNlIHsgIiIgfQogICAgICAgICAgICAgICAgICAgICAgICAkdHlwZUxhYmVsID0gc3dpdGNoICgka3BUeXBlKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiUmVjb3ZlcnlQYXNzd29yZCIgeyAiQ2xhdmUgUmVjdXBlcmFjaW9uIiB9CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiVHBtIiB7ICJUUE0iIH0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICJUcG1QaW4iIHsgIlRQTSArIFBJTiIgfQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIlBhc3N3b3JkIiB7ICJDb250cmFzZW5hIiB9CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRXh0ZXJuYWxLZXkiIHsgIkxsYXZlIEV4dGVybmEiIH0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlZmF1bHQgeyAka3BUeXBlIH0KICAgICAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgJCgkdi5Nb3VudFBvaW50KSAtPiAke3R5cGVMYWJlbH0gJHtrcElkfSIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICAgICAgICAgICAgICAgICAgICAgICRoYXNQcm90ZWN0b3JzID0gJHRydWUKICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKC1ub3QgJGhhc1Byb3RlY3RvcnMpIHsgV3JpdGUtSG9zdCAiICAgIChuaW5ndW5vKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheSB9CiAgICAgICAgICAgIAogICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbiI7IFJlYWQtSG9zdCAiICAgIEVOVEVSIHBhcmEgdm9sdmVyLi4uIgogICAgICAgIH0KCiAgICAgICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICAgICAjIDUuIEhJU1RPUklBTAogICAgICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAgICAgIjUiIHsKICAgICAgICAgICAgQ2xlYXItSG9zdAogICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbiIKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIj09PSBISVNUT1JJQUwgREUgT1BFUkFDSU9ORVMgPT09IiAiRGFya1llbGxvdyIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAKICAgICAgICAgICAgaWYgKFRlc3QtUGF0aCAkbG9nRmlsZSkgewogICAgICAgICAgICAgICAgJGxvZ0NvbnRlbnQgPSBHZXQtQ29udGVudCAkbG9nRmlsZSAtVGFpbCA1MCAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgICAgICAgICAgICAgaWYgKCRsb2dDb250ZW50KSB7CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFVsdGltYXMgb3BlcmFjaW9uZXMgKG1heCA1MCk6IiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICIgKyAoIi0iICogODApIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICAgICAgZm9yZWFjaCAoJGxpbmUgaW4gJGxvZ0NvbnRlbnQpIHsKICAgICAgICAgICAgICAgICAgICAgICAgJGxpbmVDb2xvciA9ICJHcmF5IgogICAgICAgICAgICAgICAgICAgICAgICBpZiAoJGxpbmUgLW1hdGNoICJFUlJPUiIpIHsgJGxpbmVDb2xvciA9ICJSZWQiIH0KICAgICAgICAgICAgICAgICAgICAgICAgZWxzZWlmICgkbGluZSAtbWF0Y2ggIkFDVElWQURPIikgeyAkbGluZUNvbG9yID0gIkdyZWVuIiB9CiAgICAgICAgICAgICAgICAgICAgICAgIGVsc2VpZiAoJGxpbmUgLW1hdGNoICJERVNBQ1RJVkFETyIpIHsgJGxpbmVDb2xvciA9ICJZZWxsb3ciIH0KICAgICAgICAgICAgICAgICAgICAgICAgZWxzZWlmICgkbGluZSAtbWF0Y2ggIkV4dHJhY2Npb258RXh0cmFjdCIpIHsgJGxpbmVDb2xvciA9ICJDeWFuIiB9CiAgICAgICAgICAgICAgICAgICAgICAgIGVsc2VpZiAoJGxpbmUgLW1hdGNoICJGT1JaQURPIikgeyAkbGluZUNvbG9yID0gIlJlZCIgfQogICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgJHtsaW5lfSIgLUZvcmVncm91bmRDb2xvciAkbGluZUNvbG9yCiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgTG9nIHZhY2lvLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIE5vIGhheSBoaXN0b3JpYWwgYXVuLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFNlIGNyZWFyYSBhdXRvbWF0aWNhbWVudGUgY29uIGNhZGEgb3BlcmFjaW9uLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICB9CiAgICAgICAgICAgIAogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBBcmNoaXZvOiAke2xvZ0ZpbGV9IiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtMXSBMaW1waWFyIGhpc3RvcmlhbCAgW0VOVEVSXSBWb2x2ZXIiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgJGxvZ0FjdGlvbiA9IFJlYWQtSG9zdCAiICAgID4iCiAgICAgICAgICAgIGlmICgkbG9nQWN0aW9uIC1lcSAiTCIgLW9yICRsb2dBY3Rpb24gLWVxICJsIikgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFNlZ3Vybz8gW1MvTl0iIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICAkbG9nQ29uZmlybSA9IFJlYWQtSG9zdCAiICAgID4iCiAgICAgICAgICAgICAgICBpZiAoJGxvZ0NvbmZpcm0gLWVxICJTIiAtb3IgJGxvZ0NvbmZpcm0gLWVxICJzIikgewogICAgICAgICAgICAgICAgICAgIFJlbW92ZS1JdGVtICRsb2dGaWxlIC1Gb3JjZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICBIaXN0b3JpYWwgbGltcGlhZG8uIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgICAgICAgICAgU3RhcnQtU2xlZXAgMQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQoKICAgICAgICAiUyIgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJDZXJyYW5kby4uLiIgIkRhcmtZZWxsb3ciCiAgICAgICAgICAgIFdyaXRlLUxvZyAiU2VzaW9uIGNlcnJhZGEiCiAgICAgICAgICAgIFN0YXJ0LVNsZWVwIC1TZWNvbmRzIDEKICAgICAgICAgICAgW2NvbnNvbGVdOjpSZXNldENvbG9yKCkKICAgICAgICAgICAgQ2xlYXItSG9zdAogICAgICAgICAgICByZXR1cm4KICAgICAgICB9CgogICAgICAgIGRlZmF1bHQgewogICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiT3BjaW9uIG5vIHZhbGlkYS4iICJSZWQiCiAgICAgICAgICAgIFN0YXJ0LVNsZWVwIC1TZWNvbmRzIDEKICAgICAgICB9CiAgICB9Cn0KfQo='
$script:AtlasToolSources['Invoke-HostsManager'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtSG9zdHNNYW5hZ2VyCiMgRWRpdG9yIGludGVyYWN0aXZvIGRlbCBhcmNoaXZvIGhvc3RzIGRlIFdpbmRvd3MgY29uIGJhY2t1cHMuCiMgQXRsYXMgUEMgU3VwcG9ydCAtIHYxLjAKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIEludm9rZS1Ib3N0c01hbmFnZXIgewogICAgW0NtZGxldEJpbmRpbmcoKV0KICAgIHBhcmFtKCkKCiAgICAkaG9zdHNQYXRoID0gSm9pbi1QYXRoICRlbnY6U3lzdGVtUm9vdCAnU3lzdGVtMzJcZHJpdmVyc1xldGNcaG9zdHMnCgogICAgdHJ5IHsgJEhvc3QuVUkuUmF3VUkuV2luZG93VGl0bGUgPSAiQVRMQVMgUEMgU1VQUE9SVCAtIEdFU1RPUiBIT1NUUyIgfSBjYXRjaCB7fQoKICAgICRwcmluY2lwYWwgPSBbU2VjdXJpdHkuUHJpbmNpcGFsLldpbmRvd3NQcmluY2lwYWxdOjpuZXcoW1NlY3VyaXR5LlByaW5jaXBhbC5XaW5kb3dzSWRlbnRpdHldOjpHZXRDdXJyZW50KCkpCiAgICAkaXNBZG1pbiAgID0gJHByaW5jaXBhbC5Jc0luUm9sZShbU2VjdXJpdHkuUHJpbmNpcGFsLldpbmRvd3NCdWlsdEluUm9sZV06OkFkbWluaXN0cmF0b3IpCgogICAgZG8gewogICAgICAgIENsZWFyLUhvc3QKICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgV3JpdGUtSG9zdCAiICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgV3JpdGUtSG9zdCAiICAgQVRMQVMgUEMgU1VQUE9SVCAtIEdFU1RPUiBERUwgQVJDSElWTyBIT1NUUyIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICBXcml0ZS1Ib3N0ICIgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICBXcml0ZS1Ib3N0ICIgIFJ1dGE6ICAkaG9zdHNQYXRoIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgICAgICBXcml0ZS1Ib3N0ICIgIEFkbWluOiAkKGlmICgkaXNBZG1pbikgeyAnU0knIH0gZWxzZSB7ICdOTyAobGFzIGVzY3JpdHVyYXMgZmFsbGFyYW4pJyB9KSIgLUZvcmVncm91bmRDb2xvciAkKGlmICgkaXNBZG1pbikgeyAnR3JlZW4nIH0gZWxzZSB7ICdZZWxsb3cnIH0pCiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgT3BjaW9uZXM6IiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgICAgICBXcml0ZS1Ib3N0ICIgICAgWzFdIFZlciBjb250ZW5pZG8gYWN0dWFsIgogICAgICAgIFdyaXRlLUhvc3QgIiAgICBbMl0gSGFjZXIgYmFja3VwIGNvbiB0aW1lc3RhbXAiCiAgICAgICAgV3JpdGUtSG9zdCAiICAgIFszXSBBZ3JlZ2FyIGVudHJhZGEgKElQICsgbm9tYnJlKSIKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgWzRdIEVsaW1pbmFyIGxpbmVhcyBxdWUgY29udGVuZ2FuIHVuIG5vbWJyZSIKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgWzVdIEFicmlyIGVuIE5vdGVwYWQgKGFkbWluKSIKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgWzZdIFJlc3RhdXJhciBkZWZhdWx0IChiYWNrdXAgYXV0b21hdGljbyBwcmV2aW8pIgogICAgICAgIFdyaXRlLUhvc3QgIiAgICBbUV0gU2FsaXIiCiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICRzZWwgPSBSZWFkLUhvc3QgIiAgU2VsZWNjaW9uIgoKICAgICAgICBzd2l0Y2ggKCRzZWwpIHsKICAgICAgICAgICAgJzEnIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgICAgIGlmIChUZXN0LVBhdGggJGhvc3RzUGF0aCkgewogICAgICAgICAgICAgICAgICAgIEdldC1Db250ZW50ICRob3N0c1BhdGggfCBGb3JFYWNoLU9iamVjdCB7IFdyaXRlLUhvc3QgIiAgICAkXyIgLUZvcmVncm91bmRDb2xvciBHcmF5IH0KICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAobm8gZXhpc3RlKSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiICBFbnRlciBwYXJhIGNvbnRpbnVhciIgfCBPdXQtTnVsbAogICAgICAgICAgICB9CiAgICAgICAgICAgICcyJyB7CiAgICAgICAgICAgICAgICB0cnkgewogICAgICAgICAgICAgICAgICAgICRzdGFtcCAgPSBHZXQtRGF0ZSAtRm9ybWF0ICd5eXl5TU1kZC1ISG1tc3MnCiAgICAgICAgICAgICAgICAgICAgJGJhY2t1cCA9IEpvaW4tUGF0aCAoU3BsaXQtUGF0aCAkaG9zdHNQYXRoKSAiaG9zdHMuYmFja3VwLiRzdGFtcCIKICAgICAgICAgICAgICAgICAgICBDb3B5LUl0ZW0gJGhvc3RzUGF0aCAkYmFja3VwIC1Gb3JjZQogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIEJhY2t1cCBjcmVhZG86ICRiYWNrdXAiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgRXJyb3I6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgUmVhZC1Ib3N0ICIgIEVudGVyIHBhcmEgY29udGludWFyIiB8IE91dC1OdWxsCiAgICAgICAgICAgIH0KICAgICAgICAgICAgJzMnIHsKICAgICAgICAgICAgICAgICRpcCAgID0gUmVhZC1Ib3N0ICIgIElQIgogICAgICAgICAgICAgICAgJG5hbWUgPSBSZWFkLUhvc3QgIiAgTm9tYnJlIGhvc3QiCiAgICAgICAgICAgICAgICBpZiAoJGlwIC1hbmQgJG5hbWUpIHsKICAgICAgICAgICAgICAgICAgICB0cnkgewogICAgICAgICAgICAgICAgICAgICAgICAkbGluZSA9ICJ7MH1gdHsxfWB0IyBBdGxhcy1hZGRlZCB7Mn0iIC1mICRpcCwgJG5hbWUsIChHZXQtRGF0ZSAtRm9ybWF0ICd5eXl5LU1NLWRkJykKICAgICAgICAgICAgICAgICAgICAgICAgQWRkLUNvbnRlbnQgLVBhdGggJGhvc3RzUGF0aCAtVmFsdWUgImByYG4kbGluZSIgLUVuY29kaW5nIFVURjgKICAgICAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBBZ3JlZ2FkYTogJGlwICAkbmFtZSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgICAgICAgICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIEVycm9yIChuZWNlc2l0YSBhZG1pbj8pOiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgQ2FuY2VsYWRvIChJUCBvIG5vbWJyZSB2YWNpb3MpLiIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiICBFbnRlciBwYXJhIGNvbnRpbnVhciIgfCBPdXQtTnVsbAogICAgICAgICAgICB9CiAgICAgICAgICAgICc0JyB7CiAgICAgICAgICAgICAgICAkbmFtZSA9IFJlYWQtSG9zdCAiICBOb21icmUgYSBlbGltaW5hciAobGluZWFzIHF1ZSBsbyBjb250ZW5nYW4pIgogICAgICAgICAgICAgICAgaWYgKCRuYW1lKSB7CiAgICAgICAgICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgICAgICAgICAgJHBhdHRlcm4gPSBbcmVnZXhdOjpFc2NhcGUoJG5hbWUpCiAgICAgICAgICAgICAgICAgICAgICAgICRjb250ZW50ID0gR2V0LUNvbnRlbnQgJGhvc3RzUGF0aAogICAgICAgICAgICAgICAgICAgICAgICAka2VwdCAgICA9ICRjb250ZW50IHwgV2hlcmUtT2JqZWN0IHsgJF8gLW5vdG1hdGNoICRwYXR0ZXJuIH0KICAgICAgICAgICAgICAgICAgICAgICAgJGRlbGV0ZWQgPSAkY29udGVudC5Db3VudCAtICRrZXB0LkNvdW50CiAgICAgICAgICAgICAgICAgICAgICAgIFNldC1Db250ZW50IC1QYXRoICRob3N0c1BhdGggLVZhbHVlICRrZXB0IC1FbmNvZGluZyBVVEY4CiAgICAgICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgRWxpbWluYWRhcyAkZGVsZXRlZCBsaW5lYShzKSBxdWUgY29udGVuaWFuICckbmFtZScuIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgICAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgRXJyb3IgKG5lY2VzaXRhIGFkbWluPyk6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiICBFbnRlciBwYXJhIGNvbnRpbnVhciIgfCBPdXQtTnVsbAogICAgICAgICAgICB9CiAgICAgICAgICAgICc1JyB7CiAgICAgICAgICAgICAgICB0cnkgewogICAgICAgICAgICAgICAgICAgIFN0YXJ0LVByb2Nlc3Mgbm90ZXBhZC5leGUgLUFyZ3VtZW50TGlzdCAkaG9zdHNQYXRoIC1WZXJiIFJ1bkFzCiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBOb3RlcGFkIGFiaWVydG8gKGVuIG51ZXZhIHZlbnRhbmEgZWxldmFkYSkuIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgICAgICB9IGNhdGNoIHsKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIEVycm9yOiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiICBFbnRlciBwYXJhIGNvbnRpbnVhciIgfCBPdXQtTnVsbAogICAgICAgICAgICB9CiAgICAgICAgICAgICc2JyB7CiAgICAgICAgICAgICAgICAkb2sgPSBSZWFkLUhvc3QgIiAgRXN0byBTT0JSRUVTQ1JJQkUgaG9zdHMuIENvbmZpcm1hcj8gW3MvTl0iCiAgICAgICAgICAgICAgICBpZiAoJG9rIC1tYXRjaCAnXltzU3lZXSQnKSB7CiAgICAgICAgICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgICAgICAgICAgJHN0YW1wID0gR2V0LURhdGUgLUZvcm1hdCAneXl5eU1NZGQtSEhtbXNzJwogICAgICAgICAgICAgICAgICAgICAgICAkYmVmb3JlID0gSm9pbi1QYXRoIChTcGxpdC1QYXRoICRob3N0c1BhdGgpICJob3N0cy5iZWZvcmUtcmVzZXQuJHN0YW1wIgogICAgICAgICAgICAgICAgICAgICAgICBDb3B5LUl0ZW0gJGhvc3RzUGF0aCAkYmVmb3JlIC1Gb3JjZQogICAgICAgICAgICAgICAgICAgICAgICAkZGVmYXVsdCA9IEAiCiMgQ29weXJpZ2h0IChjKSAxOTkzLTIwMDkgTWljcm9zb2Z0IENvcnAuCiMKIyBUaGlzIGlzIGEgc2FtcGxlIEhPU1RTIGZpbGUgdXNlZCBieSBNaWNyb3NvZnQgVENQL0lQIGZvciBXaW5kb3dzLgojCiMgTG9jYWxob3N0IG5hbWUgcmVzb2x1dGlvbiBpcyBoYW5kbGVkIHdpdGhpbiBETlMgaXRzZWxmLgojYHQxMjcuMC4wLjFgdGxvY2FsaG9zdAojYHQ6OjFgdGxvY2FsaG9zdAoiQAogICAgICAgICAgICAgICAgICAgICAgICBTZXQtQ29udGVudCAtUGF0aCAkaG9zdHNQYXRoIC1WYWx1ZSAkZGVmYXVsdCAtRW5jb2RpbmcgVVRGOAogICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgIGhvc3RzIHJlc3RhdXJhZG8uIEJhY2t1cCBwcmV2aW8gZW46ICRiZWZvcmUiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgICAgICB9IGNhdGNoIHsKICAgICAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBFcnJvciAobmVjZXNpdGEgYWRtaW4pOiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBSZWFkLUhvc3QgIiAgRW50ZXIgcGFyYSBjb250aW51YXIiIHwgT3V0LU51bGwKICAgICAgICAgICAgfQogICAgICAgICAgICB7ICRfIC1tYXRjaCAnXltxUV0kJyB9IHsgcmV0dXJuIH0KICAgICAgICB9CiAgICB9IHdoaWxlICgkdHJ1ZSkKfQo='
$script:AtlasToolSources['Invoke-MenorPrivilegio'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtTWVub3JQcml2aWxlZ2lvCiMgTWlncmFkbyBkZTogUHJpbmNpcGlvX01lbm9yX1ByaXZpbGVnaW8ucHMxCiMgQXRsYXMgUEMgU3VwcG9ydCDigJQgdjEuMAojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gSW52b2tlLU1lbm9yUHJpdmlsZWdpbyB7CiAgICBbQ21kbGV0QmluZGluZygpXQogICAgcGFyYW0oKQrvu78jIEFUTEFTIFBDIFNVUFBPUlQgLSBTRUNVUklUWSBTVUlURSB2My4wCiMgSGVycmFtaWVudGE6IFByaW5jaXBpbyBkZSBNZW5vciBQcml2aWxlZ2lvICsgSGFyZGVuaW5nIFVBQwojIEZpeGVzOiBCU1RSIGxlYWssIFNlY3VyZVN0cmluZyBjaGVjaywgd21pYyBkZXByZWNhdGVkLCBzaHV0ZG93biAvbCwgRXJyb3JBY3Rpb25QcmVmZXJlbmNlCiMgVXBzY2FsZTogQXVkaXRvcmlhLCBEZXNoYWJpbGl0YXIgY3VlbnRhLCBQb2xpdGljYSBkZSBjb250cmFzZcOxYXMsIFVBQyBlbiBoZWFkZXIsIGluZm9ybWUgLnR4dAoKJEVycm9yQWN0aW9uUHJlZmVyZW5jZSA9ICJTdG9wIgoKIyAtLS0gMC4gQVVUTy1FTEVWQUNJT04gLS0tCiMgKGF1dG8tZWxldmFjacOzbiBnZXN0aW9uYWRhIHBvciBBdGxhcyBMYXVuY2hlcikKCiMgLS0tIDEuIENPTkZJR1VSQUNJT04gVklTVUFMIC0tLQokSG9zdC5VSS5SYXdVSS5XaW5kb3dUaXRsZSA9ICJBVExBUyBQQyBTVVBQT1JUIHwgU2VjdXJpdHkgU3VpdGUgdjMuMCIKJEhvc3QuVUkuUmF3VUkuQmFja2dyb3VuZENvbG9yID0gIkJsYWNrIgokSG9zdC5VSS5SYXdVSS5Gb3JlZ3JvdW5kQ29sb3IgPSAiR3JheSIKdHJ5IHsgJEhvc3QuVUkuUmF3VUkuV2luZG93U2l6ZSA9IE5ldy1PYmplY3QgU3lzdGVtLk1hbmFnZW1lbnQuQXV0b21hdGlvbi5Ib3N0LlNpemUoOTAsIDQ4KSB9IGNhdGNoIHt9CkNsZWFyLUhvc3QKdHJ5IHsgW0NvbnNvbGVdOjpDdXJzb3JWaXNpYmxlID0gJHRydWUgfSBjYXRjaCB7fQoKIyAtLS0gMi4gREVURUNDSU9OIE1VTFRJLUlESU9NQSAoU0lEcykgLS0tCnRyeSB7CiAgICAkb2JqU0lEQWRtaW4gPSBOZXctT2JqZWN0IFN5c3RlbS5TZWN1cml0eS5QcmluY2lwYWwuU2VjdXJpdHlJZGVudGlmaWVyKCJTLTEtNS0zMi01NDQiKQogICAgJGFkbWluR3JvdXBOYW1lID0gJG9ialNJREFkbWluLlRyYW5zbGF0ZShbU3lzdGVtLlNlY3VyaXR5LlByaW5jaXBhbC5OVEFjY291bnRdKS5WYWx1ZS5TcGxpdCgiXCIpWy0xXQoKICAgICRvYmpTSURVc2VyID0gTmV3LU9iamVjdCBTeXN0ZW0uU2VjdXJpdHkuUHJpbmNpcGFsLlNlY3VyaXR5SWRlbnRpZmllcigiUy0xLTUtMzItNTQ1IikKICAgICRzdGRHcm91cE5hbWUgPSAkb2JqU0lEVXNlci5UcmFuc2xhdGUoW1N5c3RlbS5TZWN1cml0eS5QcmluY2lwYWwuTlRBY2NvdW50XSkuVmFsdWUuU3BsaXQoIlwiKVstMV0KfSBjYXRjaCB7CiAgICAkYWRtaW5Hcm91cE5hbWUgPSAiQWRtaW5pc3RyYWRvcmVzIgogICAgJHN0ZEdyb3VwTmFtZSA9ICJVc3VhcmlvcyIKfQoKIyAtLS0gMy4gSEVMUEVSUyAtLS0KCmZ1bmN0aW9uIEVzY3JpYmlyLUNlbnRyYWRvIHsKICAgIHBhcmFtKFtzdHJpbmddJFRleHRvLCBbQ29uc29sZUNvbG9yXSRDb2xvciA9ICJXaGl0ZSIsIFtib29sZWFuXSROZXdMaW5lID0gJHRydWUpCiAgICB0cnkgewogICAgICAgICRBbmNobyA9ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUuV2lkdGgKICAgICAgICAkUGFkTGVmdCA9IFttYXRoXTo6TWF4KDAsIFttYXRoXTo6Rmxvb3IoKCRBbmNobyAtICRUZXh0by5MZW5ndGgpIC8gMikpCiAgICAgICAgV3JpdGUtSG9zdCAoIiAiICogJFBhZExlZnQpIC1Ob05ld2xpbmUKICAgICAgICBpZiAoJE5ld0xpbmUpIHsgV3JpdGUtSG9zdCAkVGV4dG8gLUZvcmVncm91bmRDb2xvciAkQ29sb3IgfQogICAgICAgIGVsc2UgeyBXcml0ZS1Ib3N0ICRUZXh0byAtRm9yZWdyb3VuZENvbG9yICRDb2xvciAtTm9OZXdsaW5lIH0KICAgIH0gY2F0Y2ggeyBXcml0ZS1Ib3N0ICRUZXh0byAtRm9yZWdyb3VuZENvbG9yICRDb2xvciB9Cn0KCmZ1bmN0aW9uIE9idGVuZXItRXN0YWRvVUFDIHsKICAgIHRyeSB7CiAgICAgICAgJHJlZ1BhdGggPSAiSEtMTTpcU09GVFdBUkVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cUG9saWNpZXNcU3lzdGVtIgogICAgICAgICRsdWEgID0gKEdldC1JdGVtUHJvcGVydHkgLVBhdGggJHJlZ1BhdGggLU5hbWUgIkVuYWJsZUxVQSIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUpLkVuYWJsZUxVQQogICAgICAgICRzZHQgID0gKEdldC1JdGVtUHJvcGVydHkgLVBhdGggJHJlZ1BhdGggLU5hbWUgIlByb21wdE9uU2VjdXJlRGVza3RvcCIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUpLlByb21wdE9uU2VjdXJlRGVza3RvcAogICAgICAgICR1c3IgID0gKEdldC1JdGVtUHJvcGVydHkgLVBhdGggJHJlZ1BhdGggLU5hbWUgIkNvbnNlbnRQcm9tcHRCZWhhdmlvclVzZXIiIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlKS5Db25zZW50UHJvbXB0QmVoYXZpb3JVc2VyCiAgICAgICAgJGFkbSAgPSAoR2V0LUl0ZW1Qcm9wZXJ0eSAtUGF0aCAkcmVnUGF0aCAtTmFtZSAiQ29uc2VudFByb21wdEJlaGF2aW9yQWRtaW4iIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlKS5Db25zZW50UHJvbXB0QmVoYXZpb3JBZG1pbgogICAgICAgIGlmICgkbHVhIC1lcSAxIC1hbmQgJHNkdCAtZXEgMSAtYW5kICR1c3IgLWVxIDEgLWFuZCAkYWRtIC1lcSAyKSB7IHJldHVybiBAeyBUZXh0byA9ICJVQUM6IE1BWElNTyBbT0tdIjsgQ29sb3IgPSAiR3JlZW4iIH0gfQogICAgICAgIGVsc2VpZiAoJGx1YSAtZXEgMCkgeyByZXR1cm4gQHsgVGV4dG8gPSAiVUFDOiBERVNBQ1RJVkFETyBbUklFU0dPXSI7IENvbG9yID0gIlJlZCIgfSB9CiAgICAgICAgZWxzZSB7IHJldHVybiBAeyBUZXh0byA9ICJVQUM6IFBBUkNJQUwgW1JFVklTQVJdIjsgQ29sb3IgPSAiWWVsbG93IiB9IH0KICAgIH0gY2F0Y2ggeyByZXR1cm4gQHsgVGV4dG8gPSAiVUFDOiBERVNDT05PQ0lETyI7IENvbG9yID0gIkRhcmtHcmF5IiB9IH0KfQoKZnVuY3Rpb24gT2J0ZW5lci1Sb2xVc3VhcmlvIHsKICAgIHBhcmFtKFtzdHJpbmddJE5vbWJyZVVzdWFyaW8pCiAgICB0cnkgewogICAgICAgICRtaWVtYnJvcyA9IEdldC1Mb2NhbEdyb3VwTWVtYmVyIC1TSUQgIlMtMS01LTMyLTU0NCIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUgfCBGb3JFYWNoLU9iamVjdCB7ICRfLk5hbWUuU3BsaXQoIlwiKVstMV0gfQogICAgICAgIGlmICgkbWllbWJyb3MgLWNvbnRhaW5zICROb21icmVVc3VhcmlvKSB7IHJldHVybiAiQWRtaW5pc3RyYWRvciIgfSBlbHNlIHsgcmV0dXJuICJFc3RhbmRhciIgfQogICAgfSBjYXRjaCB7IHJldHVybiAiRGVzY29ub2NpZG8iIH0KfQoKZnVuY3Rpb24gRGlidWphci1IZWFkZXIgewogICAgQ2xlYXItSG9zdAogICAgV3JpdGUtSG9zdCAiYG4iCiAgICAkdWFjID0gT2J0ZW5lci1Fc3RhZG9VQUMKICAgICRyb2wgPSBPYnRlbmVyLVJvbFVzdWFyaW8gJGVudjpVU0VSTkFNRQogICAgJHJvbENvbG9yID0gaWYgKCRyb2wgLWVxICJBZG1pbmlzdHJhZG9yIikgeyAiQ3lhbiIgfSBlbHNlIHsgIkdyZWVuIiB9CgogICAgRXNjcmliaXItQ2VudHJhZG8gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iICJEYXJrR3JheSIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICJBIFQgTCBBIFMgICBQIEMgICBTIFUgUCBQIE8gUiBUIiAiQ3lhbiIKICAgIEVzY3JpYmlyLUNlbnRyYWRvICJTZWN1cml0eSBTdWl0ZSB2My4wIiAiRGFya0dyYXkiCiAgICBFc2NyaWJpci1DZW50cmFkbyAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgIkRhcmtHcmF5IgogICAgV3JpdGUtSG9zdCAiIgogICAgRXNjcmliaXItQ2VudHJhZG8gIlVzdWFyaW86ICRlbnY6VVNFUk5BTUUgIHwgIFJvbDogJHJvbCIgJHJvbENvbG9yCiAgICBFc2NyaWJpci1DZW50cmFkbyAkdWFjLlRleHRvICR1YWMuQ29sb3IKICAgIEVzY3JpYmlyLUNlbnRyYWRvICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAiRGFya0dyYXkiCiAgICBXcml0ZS1Ib3N0ICIiCn0KCmZ1bmN0aW9uIFZhbGlkYXItQ29udHJhc2VuYSB7CiAgICBwYXJhbShbU3lzdGVtLlNlY3VyaXR5LlNlY3VyZVN0cmluZ10kUGFzcykKICAgIGlmICgkUGFzcy5MZW5ndGggLWx0IDgpIHsgcmV0dXJuICJMYSBjb250cmFzZW5hIGRlYmUgdGVuZXIgYWwgbWVub3MgOCBjYXJhY3RlcmVzLiIgfQogICAgJEJTVFIgPSBbU3lzdGVtLlJ1bnRpbWUuSW50ZXJvcFNlcnZpY2VzLk1hcnNoYWxdOjpTZWN1cmVTdHJpbmdUb0JTVFIoJFBhc3MpCiAgICB0cnkgewogICAgICAgICRwbGFpbiA9IFtTeXN0ZW0uUnVudGltZS5JbnRlcm9wU2VydmljZXMuTWFyc2hhbF06OlB0clRvU3RyaW5nQXV0bygkQlNUUikKICAgICAgICBpZiAoJHBsYWluIC1ub3RtYXRjaCAnWzAtOV0nKSAgICAgICAgIHsgcmV0dXJuICJEZWJlIGNvbnRlbmVyIGFsIG1lbm9zIHVuIG51bWVyby4iIH0KICAgICAgICBpZiAoJHBsYWluIC1ub3RtYXRjaCAnW0EtWl0nKSAgICAgICAgIHsgcmV0dXJuICJEZWJlIGNvbnRlbmVyIGFsIG1lbm9zIHVuYSBtYXl1c2N1bGEuIiB9CiAgICAgICAgaWYgKCRwbGFpbiAtbm90bWF0Y2ggJ1teYS16QS1aMC05XScpIHsgcmV0dXJuICJEZWJlIGNvbnRlbmVyIGFsIG1lbm9zIHVuIGNhcmFjdGVyIGVzcGVjaWFsLiIgfQogICAgICAgIHJldHVybiAkbnVsbAogICAgfSBmaW5hbGx5IHsKICAgICAgICBbU3lzdGVtLlJ1bnRpbWUuSW50ZXJvcFNlcnZpY2VzLk1hcnNoYWxdOjpaZXJvRnJlZUJTVFIoJEJTVFIpCiAgICB9Cn0KCgpmdW5jdGlvbiBFc2NyaWJpci1EZXNjcmlwY2lvbiB7CiAgICBwYXJhbSgKICAgICAgICBbc3RyaW5nXSRRdWUsCiAgICAgICAgW3N0cmluZ10kUmVjb21lbmRhY2lvbiwKICAgICAgICBbc3RyaW5nXSRQcmVjYXVjaW9uCiAgICApCiAgICAkdyA9ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUuV2lkdGgKICAgICRzZXAgPSAiLSIgKiA1NAogICAgJHBhZCA9IFttYXRoXTo6TWF4KDAsIFttYXRoXTo6Rmxvb3IoKCR3IC0gNTYpIC8gMikpCiAgICAkcyA9ICIgIiAqICRwYWQKICAgIFdyaXRlLUhvc3QgIiRzKyRzZXArIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIkc3wgICIgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAoIlFVRSBIQUNFOiIuUGFkUmlnaHQoNTMpKSAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5IC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgInwiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICMgV3JhcCBRdWUKICAgICR3b3JkcyA9ICRRdWUgLXNwbGl0ICcgJzsgJGxpbmUgPSAiICAiOyBmb3JlYWNoICgkd29yZCBpbiAkd29yZHMpIHsgaWYgKCgkbGluZSArICR3b3JkKS5MZW5ndGggLWd0IDUxKSB7IFdyaXRlLUhvc3QgIiRzfCAgIiAtTm9OZXdsaW5lOyBXcml0ZS1Ib3N0ICgkbGluZS5QYWRSaWdodCg1MykpIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAifCIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheTsgJGxpbmUgPSAiICAkd29yZCAiIH0gZWxzZSB7ICRsaW5lICs9ICIkd29yZCAiIH0gfTsgaWYgKCRsaW5lLlRyaW0oKSkgeyBXcml0ZS1Ib3N0ICIkc3wgICIgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAoJGxpbmUuUGFkUmlnaHQoNTMpKSAtRm9yZWdyb3VuZENvbG9yIFdoaXRlIC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgInwiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkgfQogICAgV3JpdGUtSG9zdCAiJHN8ICAiIC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgKCIiLlBhZFJpZ2h0KDUzKSkgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheSAtTm9OZXdsaW5lOyBXcml0ZS1Ib3N0ICJ8IiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIkc3wgICIgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAoIlJFQ09NRU5EQUNJT046Ii5QYWRSaWdodCg1MykpIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAifCIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgJHdvcmRzID0gJFJlY29tZW5kYWNpb24gLXNwbGl0ICcgJzsgJGxpbmUgPSAiICAiOyBmb3JlYWNoICgkd29yZCBpbiAkd29yZHMpIHsgaWYgKCgkbGluZSArICR3b3JkKS5MZW5ndGggLWd0IDUxKSB7IFdyaXRlLUhvc3QgIiRzfCAgIiAtTm9OZXdsaW5lOyBXcml0ZS1Ib3N0ICgkbGluZS5QYWRSaWdodCg1MykpIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbiAtTm9OZXdsaW5lOyBXcml0ZS1Ib3N0ICJ8IiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5OyAkbGluZSA9ICIgICR3b3JkICIgfSBlbHNlIHsgJGxpbmUgKz0gIiR3b3JkICIgfSB9OyBpZiAoJGxpbmUuVHJpbSgpKSB7IFdyaXRlLUhvc3QgIiRzfCAgIiAtTm9OZXdsaW5lOyBXcml0ZS1Ib3N0ICgkbGluZS5QYWRSaWdodCg1MykpIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbiAtTm9OZXdsaW5lOyBXcml0ZS1Ib3N0ICJ8IiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5IH0KICAgIFdyaXRlLUhvc3QgIiRzfCAgIiAtTm9OZXdsaW5lOyBXcml0ZS1Ib3N0ICgiIi5QYWRSaWdodCg1MykpIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAifCIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiJHN8ICAiIC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgKCJQUkVDQVVDSU9OOiIuUGFkUmlnaHQoNTMpKSAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5IC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgInwiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICR3b3JkcyA9ICRQcmVjYXVjaW9uIC1zcGxpdCAnICc7ICRsaW5lID0gIiAgIjsgZm9yZWFjaCAoJHdvcmQgaW4gJHdvcmRzKSB7IGlmICgoJGxpbmUgKyAkd29yZCkuTGVuZ3RoIC1ndCA1MSkgeyBXcml0ZS1Ib3N0ICIkc3wgICIgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAoJGxpbmUuUGFkUmlnaHQoNTMpKSAtRm9yZWdyb3VuZENvbG9yIFllbGxvdyAtTm9OZXdsaW5lOyBXcml0ZS1Ib3N0ICJ8IiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5OyAkbGluZSA9ICIgICR3b3JkICIgfSBlbHNlIHsgJGxpbmUgKz0gIiR3b3JkICIgfSB9OyBpZiAoJGxpbmUuVHJpbSgpKSB7IFdyaXRlLUhvc3QgIiRzfCAgIiAtTm9OZXdsaW5lOyBXcml0ZS1Ib3N0ICgkbGluZS5QYWRSaWdodCg1MykpIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93IC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgInwiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkgfQogICAgV3JpdGUtSG9zdCAiJHMrJHNlcCsiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiIKfQoKCmZ1bmN0aW9uIEVzY3JpYmlyLURlc2NyaXBjaW9uIHsKICAgIHBhcmFtKFtzdHJpbmddJFF1ZSwgW3N0cmluZ10kUmVjb21lbmRhY2lvbiwgW3N0cmluZ10kUHJlY2F1Y2lvbikKICAgICR3ICAgPSAkSG9zdC5VSS5SYXdVSS5XaW5kb3dTaXplLldpZHRoCiAgICAkc2VwID0gIi0iICogNTQKICAgICRwYWQgPSBbbWF0aF06Ok1heCgwLCBbbWF0aF06OkZsb29yKCgkdyAtIDU4KSAvIDIpKQogICAgJHMgICA9ICIgIiAqICRwYWQKICAgIGZ1bmN0aW9uIFdyYXBMaW5lKCR0eHQsICRjb2wpIHsKICAgICAgICAkd29yZHMgPSAkdHh0IC1zcGxpdCAnICc7ICRsaW5lID0gIiAgIgogICAgICAgIGZvcmVhY2ggKCR3b3JkIGluICR3b3JkcykgewogICAgICAgICAgICBpZiAoKCRsaW5lICsgJHdvcmQpLkxlbmd0aCAtZ3QgNTEpIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiRzfCAgIiAtTm9OZXdsaW5lCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICgkbGluZS5QYWRSaWdodCg1MykpIC1Gb3JlZ3JvdW5kQ29sb3IgJGNvbCAtTm9OZXdsaW5lCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICJ8IiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgICAgICAgICAkbGluZSA9ICIgICR3b3JkICIKICAgICAgICAgICAgfSBlbHNlIHsgJGxpbmUgKz0gIiR3b3JkICIgfQogICAgICAgIH0KICAgICAgICBpZiAoJGxpbmUuVHJpbSgpKSB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiRzfCAgIiAtTm9OZXdsaW5lCiAgICAgICAgICAgIFdyaXRlLUhvc3QgKCRsaW5lLlBhZFJpZ2h0KDUzKSkgLUZvcmVncm91bmRDb2xvciAkY29sIC1Ob05ld2xpbmUKICAgICAgICAgICAgV3JpdGUtSG9zdCAifCIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIH0KICAgIH0KICAgIGZ1bmN0aW9uIExhYmVsTGluZSgkbGJsKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiJHN8ICAiIC1Ob05ld2xpbmUKICAgICAgICBXcml0ZS1Ib3N0ICgkbGJsLlBhZFJpZ2h0KDUzKSkgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheSAtTm9OZXdsaW5lCiAgICAgICAgV3JpdGUtSG9zdCAifCIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgfQogICAgZnVuY3Rpb24gQmxhbmtMaW5lIHsKICAgICAgICBXcml0ZS1Ib3N0ICIkc3wgICIgLU5vTmV3bGluZQogICAgICAgIFdyaXRlLUhvc3QgKCIiLlBhZFJpZ2h0KDUzKSkgLU5vTmV3bGluZQogICAgICAgIFdyaXRlLUhvc3QgInwiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIH0KICAgIFdyaXRlLUhvc3QgIiRzKyRzZXArIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBMYWJlbExpbmUgIiAgUVVFIEhBQ0U6IgogICAgV3JhcExpbmUgJFF1ZSAiV2hpdGUiCiAgICBCbGFua0xpbmUKICAgIExhYmVsTGluZSAiICBSRUNPTUVOREFDSU9OOiIKICAgIFdyYXBMaW5lICRSZWNvbWVuZGFjaW9uICJDeWFuIgogICAgQmxhbmtMaW5lCiAgICBMYWJlbExpbmUgIiAgUFJFQ0FVQ0lPTjoiCiAgICBXcmFwTGluZSAkUHJlY2F1Y2lvbiAiWWVsbG93IgogICAgV3JpdGUtSG9zdCAiJHMrJHNlcCsiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiIKfQoKZnVuY3Rpb24gRGVzZW5jcmlwdGFyLVBhc3MgewogICAgcGFyYW0oW1N5c3RlbS5TZWN1cml0eS5TZWN1cmVTdHJpbmddJFBhc3MpCiAgICAkQlNUUiA9IFtTeXN0ZW0uUnVudGltZS5JbnRlcm9wU2VydmljZXMuTWFyc2hhbF06OlNlY3VyZVN0cmluZ1RvQlNUUigkUGFzcykKICAgIHRyeSB7IHJldHVybiBbU3lzdGVtLlJ1bnRpbWUuSW50ZXJvcFNlcnZpY2VzLk1hcnNoYWxdOjpQdHJUb1N0cmluZ0F1dG8oJEJTVFIpIH0KICAgIGZpbmFsbHkgeyBbU3lzdGVtLlJ1bnRpbWUuSW50ZXJvcFNlcnZpY2VzLk1hcnNoYWxdOjpaZXJvRnJlZUJTVFIoJEJTVFIpIH0KfQoKIyAtLS0gNC4gTE9HSUNBIERFTCBNRU5VIC0tLQoKZG8gewogICAgRGlidWphci1IZWFkZXIKCiAgICAkYW5jaG9QYW50YWxsYSA9ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUuV2lkdGgKICAgICR0ZXh0b1JlZmVyZW5jaWEgPSAiNS4gRGVzaGFiaWxpdGFyIC8gSGFiaWxpdGFyIEN1ZW50YSBkZSBVc3VhcmlvIgogICAgJHBhZEJsb3F1ZSA9IFttYXRoXTo6TWF4KDAsIFttYXRoXTo6Rmxvb3IoKCRhbmNob1BhbnRhbGxhIC0gJHRleHRvUmVmZXJlbmNpYS5MZW5ndGgpIC8gMikpCiAgICAkZXNwYWNpbyA9ICIgIiAqICRwYWRCbG9xdWUKICAgICRwYWRJbnB1dCA9IFttYXRoXTo6TWF4KDAsIFttYXRoXTo6Rmxvb3IoKCRhbmNob1BhbnRhbGxhIC0gMTApIC8gMikpCgogICAgV3JpdGUtSG9zdCAiJGVzcGFjaW8iIC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgIjEuIENyZWFyIE5VRVZPIEFkbWluaXN0cmFkb3IgKFJlc3BhbGRvKSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiJGVzcGFjaW8iIC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgIjIuIENvbnZlcnRpciBVc3VhcmlvIEFjdHVhbCBhIEVTVEFOREFSIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICBXcml0ZS1Ib3N0ICIkZXNwYWNpbyIgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAiMy4gQ29uZmlndXJhY2lvbiBkZWwgVUFDIC0gU2VndXJpZGFkIE1heGltYSIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICBXcml0ZS1Ib3N0ICIkZXNwYWNpbyIgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAiNC4gQXVkaXRvcmlhIGRlIFVzdWFyaW9zIGRlbCBTaXN0ZW1hIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgV3JpdGUtSG9zdCAiJGVzcGFjaW8iIC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgIjUuIERlc2hhYmlsaXRhciAvIEhhYmlsaXRhciBDdWVudGEgZGUgVXN1YXJpbyIgLUZvcmVncm91bmRDb2xvciBNYWdlbnRhCiAgICBXcml0ZS1Ib3N0ICIkZXNwYWNpbyIgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAiNi4gQ29uZmlndXJhciBQb2xpdGljYSBkZSBDb250cmFzZW5hcyIgLUZvcmVncm91bmRDb2xvciBEYXJrQ3lhbgogICAgV3JpdGUtSG9zdCAiJGVzcGFjaW8iIC1Ob05ld2xpbmU7IFdyaXRlLUhvc3QgIjcuIEV4cG9ydGFyIEluZm9ybWUgZGUgU2VndXJpZGFkICgudHh0KSIgLUZvcmVncm91bmRDb2xvciBEYXJrWWVsbG93CiAgICBXcml0ZS1Ib3N0ICIkZXNwYWNpbyIgLU5vTmV3bGluZTsgV3JpdGUtSG9zdCAiOC4gU2FsaXIiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiIKCiAgICBXcml0ZS1Ib3N0ICgiICIgKiAkcGFkSW5wdXQpIC1Ob05ld2xpbmUKICAgICRzZWxlY2Npb24gPSBSZWFkLUhvc3QgIk9wY2lvbiIKCiAgICBzd2l0Y2ggKCRzZWxlY2Npb24pIHsKCiAgICAgICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICAgICAiMSIgewogICAgICAgICAgICBEaWJ1amFyLUhlYWRlcgogICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiPj4+IENSRUFSIE5VRVZPIEFETUlOSVNUUkFET1IgPDw8IiAiR3JlZW4iCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgRXNjcmliaXItRGVzY3JpcGNpb24gYAogICAgICAgICAgICAgICAgLVF1ZSAiQ3JlYSB1bmEgY3VlbnRhIGRlIEFkbWluaXN0cmFkb3IgbG9jYWwgbnVldmEgY29uIGNvbnRyYXNlbmEgc2VndXJhIHkgc2luIGNhZHVjaWRhZC4gU2lydmUgY29tbyBjdWVudGEgZGUgcmVzcGFsZG8gcGFyYSByZWN1cGVyYXIgZWwgc2lzdGVtYSBzaSBsYSBjdWVudGEgcHJpbmNpcGFsIGZhbGxhLiIgYAogICAgICAgICAgICAgICAgLVJlY29tZW5kYWNpb24gIlVzYSB1biBub21icmUgZGlzY3JldG8gKG5vIGFkbWluIG5pIGJhY2t1cCkuIEd1YXJkYSBsYXMgY3JlZGVuY2lhbGVzIGVuIHVuIGdlc3RvciBzZWd1cm8gY29tbyBCaXR3YXJkZW4uIENyZWEgc29sbyB1bmEgY3VlbnRhIGRlIHJlc3BhbGRvIHBvciBlcXVpcG8uIiBgCiAgICAgICAgICAgICAgICAtUHJlY2F1Y2lvbiAiVGVuZXIgZG9zIGN1ZW50YXMgQWRtaW4gYWN0aXZhcyBhbXBsaWEgbGEgc3VwZXJmaWNpZSBkZSBhdGFxdWUuIENyZWEgZXN0YSBjdWVudGEsIHZlcmlmaWNhIHF1ZSBmdW5jaW9uYSB5IGx1ZWdvIGFwbGljYSBsYSBvcGNpb24gMiBhbCB1c3VhcmlvIHByaW5jaXBhbC4iCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICIoTm9tYnJlIGVuIGJsYW5jbyA9IHZvbHZlcikiICJEYXJrR3JheSIKICAgICAgICAgICAgV3JpdGUtSG9zdCAoIiAiICogKCRwYWRJbnB1dCAtIDUpKSAtTm9OZXdsaW5lCiAgICAgICAgICAgICRuZXdBZG1pblVzZXIgPSBSZWFkLUhvc3QgIk5vbWJyZSBBZG1pbiIKICAgICAgICAgICAgaWYgKFtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJG5ld0FkbWluVXNlcikpIHsgYnJlYWsgfQoKICAgICAgICAgICAgIyBDb21wcm9iYXIgc2kgeWEgZXhpc3RlCiAgICAgICAgICAgICRleGlzdGUgPSBHZXQtTG9jYWxVc2VyIC1OYW1lICRuZXdBZG1pblVzZXIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICAgICAgICAgaWYgKCRleGlzdGUpIHsKICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJFUlJPUjogWWEgZXhpc3RlIHVuYSBjdWVudGEgY29uIGVzZSBub21icmUuIiAiUmVkIgogICAgICAgICAgICAgICAgUmVhZC1Ib3N0ICJgblByZXNpb25lIEVudGVyIHBhcmEgY29udGludWFyLi4uIgogICAgICAgICAgICAgICAgYnJlYWsKICAgICAgICAgICAgfQoKICAgICAgICAgICAgV3JpdGUtSG9zdCAoIiAiICogKCRwYWRJbnB1dCAtIDUpKSAtTm9OZXdsaW5lCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIkNvbnRyYXNlbmEgKG1pbiA4IGNhci4sIDEgbnVtLiwgMSBNQVkuLCAxIGVzcGVjaWFsKTogIiAtTm9OZXdsaW5lIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICRwYXNzU2VjdXJlID0gUmVhZC1Ib3N0IC1Bc1NlY3VyZVN0cmluZwoKICAgICAgICAgICAgaWYgKCRwYXNzU2VjdXJlLkxlbmd0aCAtZXEgMCkgewogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIkVSUk9SOiBMYSBjb250cmFzZW5hIG5vIHB1ZWRlIGVzdGFyIHZhY2lhLiIgIlJlZCIKICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICAgICAgICAgIGJyZWFrCiAgICAgICAgICAgIH0KCiAgICAgICAgICAgICRlcnJQYXNzID0gVmFsaWRhci1Db250cmFzZW5hICRwYXNzU2VjdXJlCiAgICAgICAgICAgIGlmICgkZXJyUGFzcykgewogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIkVSUk9SOiAkZXJyUGFzcyIgIlJlZCIKICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICAgICAgICAgIGJyZWFrCiAgICAgICAgICAgIH0KCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIlByb2Nlc2FuZG8uLi4iICJDeWFuIgoKICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgIE5ldy1Mb2NhbFVzZXIgLU5hbWUgJG5ld0FkbWluVXNlciAtUGFzc3dvcmQgJHBhc3NTZWN1cmUgLVBhc3N3b3JkTmV2ZXJFeHBpcmVzICR0cnVlIC1FcnJvckFjdGlvbiBTdG9wIHwgT3V0LU51bGwKICAgICAgICAgICAgICAgIEFkZC1Mb2NhbEdyb3VwTWVtYmVyIC1TSUQgIlMtMS01LTMyLTU0NCIgLU1lbWJlciAkbmV3QWRtaW5Vc2VyIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiRVhJVE86IEFkbWluaXN0cmFkb3IgJyRuZXdBZG1pblVzZXInIGNyZWFkby4iICJHcmVlbiIKICAgICAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiRVJST1I6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAiUmVkIgogICAgICAgICAgICB9CiAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICB9CgogICAgICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAgICAgIjIiIHsKICAgICAgICAgICAgRGlidWphci1IZWFkZXIKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIj4+PiBDT05WRVJUSVIgQSBFU1RBTkRBUiA8PDwiICJZZWxsb3ciCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgRXNjcmliaXItRGVzY3JpcGNpb24gYAogICAgICAgICAgICAgICAgLVF1ZSAiUXVpdGEgbG9zIHByaXZpbGVnaW9zIGRlIEFkbWluaXN0cmFkb3IgYWwgdXN1YXJpbyBhY3R1YWwgeSBsbyBjb252aWVydGUgZW4gdXN1YXJpbyBFc3RhbmRhci4gQXBsaWNhIGVsIHByaW5jaXBpbyBkZSBtZW5vciBwcml2aWxlZ2lvIHBhcmEgZWwgdXNvIGRpYXJpbyBkZWwgY2xpZW50ZS4iIGAKICAgICAgICAgICAgICAgIC1SZWNvbWVuZGFjaW9uICJFc3RhIGVzIGxhIGNvbmZpZ3VyYWNpb24gaWRlYWwgcGFyYSBlbCBkaWEgYSBkaWEuIFJlZHVjZSBkcmFzdGljYW1lbnRlIGVsIHJpZXNnbyBkZSBpbmZlY2Npb25lcyBwb3IgbWFsd2FyZSB5IGNhbWJpb3MgYWNjaWRlbnRhbGVzIGVuIGVsIHNpc3RlbWEuIiBgCiAgICAgICAgICAgICAgICAtUHJlY2F1Y2lvbiAiSVJSRVZFUlNJQkxFIHNpbiBvdHJvIEFkbWluIGFjdGl2by4gRWwgc2NyaXB0IGxvIHZlcmlmaWNhIGF1dG9tYXRpY2FtZW50ZSwgcGVybyBhc2VndXJhdGUgZGUgcXVlIGxhIGN1ZW50YSBkZSByZXNwYWxkbyAob3BjaW9uIDEpIHlhIGV4aXN0ZSB5IGZ1bmNpb25hIGFudGVzIGRlIGNvbnRpbnVhci4iCgogICAgICAgICAgICAjIFZlcmlmaWNhciBxdWUgZXhpc3RhIG90cm8gYWRtaW4gYW50ZXMgZGUgcHJvY2VkZXIKICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgICR0b2Rvc0FkbWlucyA9IEAoR2V0LUxvY2FsR3JvdXBNZW1iZXIgLVNJRCAiUy0xLTUtMzItNTQ0IiAtRXJyb3JBY3Rpb24gU3RvcCB8IEZvckVhY2gtT2JqZWN0IHsgJF8uTmFtZS5TcGxpdCgiXCIpWy0xXSB9KQogICAgICAgICAgICAgICAgJG90cm9zQWRtaW5zID0gJHRvZG9zQWRtaW5zIHwgV2hlcmUtT2JqZWN0IHsgJF8gLW5lICRlbnY6VVNFUk5BTUUgfQogICAgICAgICAgICAgICAgaWYgKCRvdHJvc0FkbWlucy5Db3VudCAtZXEgMCkgewogICAgICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJCTE9RVUVBRE86IE5vIGV4aXN0ZSBvdHJvIEFkbWluaXN0cmFkb3IgYWN0aXZvLiIgIlJlZCIKICAgICAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiQ3JlYSB1bm8gcHJpbWVybyBjb24gbGEgb3BjaW9uIDEuIiAiWWVsbG93IgogICAgICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICAgICAgICAgICAgICBicmVhawogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9IGNhdGNoIHsKICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJFUlJPUiBhbCB2ZXJpZmljYXIgYWRtaW5zOiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIgIlJlZCIKICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICAgICAgICAgIGJyZWFrCiAgICAgICAgICAgIH0KCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJBVEVOQ0lPTjogRXN0YSBhY2Npb24gcXVpdGFyYSB0dXMgcGVybWlzb3MgZGUgQWRtaW4uIiAiUmVkIgogICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiT3RybyBhZG1pbmlzdHJhZG9yIGRldGVjdGFkbzogT0siICJHcmVlbiIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiKEVzY3JpYmUgJ1NJJyBwYXJhIGNvbmZpcm1hciwgbyBFbnRlciBwYXJhIHZvbHZlcikiICJHcmF5IgogICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICIgKiAoJHBhZElucHV0IC0gMTApKSAtTm9OZXdsaW5lCiAgICAgICAgICAgICRjb25maXJtID0gUmVhZC1Ib3N0ICJDb25maXJtYXIiCiAgICAgICAgICAgIGlmICgkY29uZmlybSAtbmUgIlNJIikgeyBicmVhayB9CgogICAgICAgICAgICAkdGFyZ2V0VXNlciA9ICRlbnY6VVNFUk5BTUUKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIlByb2Nlc2FuZG8uLi4iICJDeWFuIgoKICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgIEFkZC1Mb2NhbEdyb3VwTWVtYmVyIC1TSUQgIlMtMS01LTMyLTU0NSIgLU1lbWJlciAkdGFyZ2V0VXNlciAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgICAgICAgICAgICAgUmVtb3ZlLUxvY2FsR3JvdXBNZW1iZXIgLVNJRCAiUy0xLTUtMzItNTQ0IiAtTWVtYmVyICR0YXJnZXRVc2VyIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiUEVSTUlTT1MgQUNUVUFMSVpBRE9TLiBBaG9yYSBlcmVzIHVzdWFyaW8gRXN0YW5kYXIuIiAiR3JlZW4iCiAgICAgICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIkVSUk9SOiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIgIlJlZCIKICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICAgICAgICAgIGJyZWFrCiAgICAgICAgICAgIH0KCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgV3JpdGUtSG9zdCAoIiAiICogKCRwYWRJbnB1dCAtIDEwKSkgLU5vTmV3bGluZQogICAgICAgICAgICAkbG9nb2ZmID0gUmVhZC1Ib3N0ICJDZXJyYXIgc2VzaW9uIGFob3JhIHBhcmEgYXBsaWNhciBjYW1iaW9zPyAoUy9OKSIKICAgICAgICAgICAgaWYgKCRsb2dvZmYgLWVxICJTIiAtb3IgJGxvZ29mZiAtZXEgInMiKSB7CiAgICAgICAgICAgICAgICBTdGFydC1Qcm9jZXNzICJzaHV0ZG93bi5leGUiIC1Bcmd1bWVudExpc3QgIi9sIgogICAgICAgICAgICAgICAgcmV0dXJuCiAgICAgICAgICAgIH0KICAgICAgICB9CgogICAgICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAgICAgIjMiIHsKICAgICAgICAgICAgRGlidWphci1IZWFkZXIKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIj4+PiBCTElOREFKRSBERSBTRUdVUklEQUQgKFVBQykgPDw8IiAiQ3lhbiIKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICBFc2NyaWJpci1EZXNjcmlwY2lvbiBgCiAgICAgICAgICAgICAgICAtUXVlICJBY3RpdmEgZWwgQ29udHJvbCBkZSBDdWVudGFzIGRlIFVzdWFyaW8gKFVBQykgYWwgbml2ZWwgbWF4aW1vLiBPYmxpZ2EgYSBpbnRyb2R1Y2lyIGNyZWRlbmNpYWxlcyBkZSBBZG1pbiBwYXJhIGluc3RhbGFyIHNvZnR3YXJlIG8gY2FtYmlhciBjb25maWd1cmFjaW9uZXMgY3JpdGljYXMgZGVsIHNpc3RlbWEuIiBgCiAgICAgICAgICAgICAgICAtUmVjb21lbmRhY2lvbiAiRWplY3V0YXIgc2llbXByZSBkZXNwdWVzIGRlIGNvbnZlcnRpciBhbCB1c3VhcmlvIGEgRXN0YW5kYXIgKG9wY2lvbiAyKS4gRXMgbGEgc2VndW5kYSBjYXBhIGRlIGRlZmVuc2EgbWFzIGltcG9ydGFudGUuIEFwbGljYSBlbiBjYWRhIGVudHJlZ2EgZGUgZXF1aXBvLiIgYAogICAgICAgICAgICAgICAgLVByZWNhdWNpb24gIkVsIGNsaWVudGUgdmVyYSBtYXMgdmVudGFuYXMgZGUgY29uZmlybWFjaW9uLiBJbmZvcm1hIHF1ZSBlcyBwb3Igc2VndXJpZGFkLiBQdWVkZSBpbnRlcnJ1bXBpciBmbHVqb3MgZGUgdHJhYmFqbyBkZSB1c3VhcmlvcyBhY29zdHVtYnJhZG9zIGEgdHJhYmFqYXIgc2luIFVBQyBhY3Rpdm8uIgogICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiU2UgYXBsaWNhcmFuIGVzdGFzIDQgcmVnbGFzIGRlIHJlZ2lzdHJvOiIgIldoaXRlIgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICIgIFsxXSBFbmFibGVMVUEgPSAxICAgICAgICAgICAgICAoVUFDIGFjdGl2bykiICJHcmF5IgogICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiICBbMl0gUHJvbXB0T25TZWN1cmVEZXNrdG9wID0gMSAgKEVzY3JpdG9yaW8gc2VndXJvKSIgIkdyYXkiCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICIgIFszXSBDb25zZW50UHJvbXB0QmVoYXZpb3JVc2VyID0gMSAgKENyZWRlbmNpYWxlcyBwYXJhIGVzdGFuZGFyKSIgIkdyYXkiCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICIgIFs0XSBDb25zZW50UHJvbXB0QmVoYXZpb3JBZG1pbiA9IDIgKENyZWRlbmNpYWxlcyBwYXJhIGFkbWlucykiICJHcmF5IgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICIoRW50ZXIgcGFyYSBhcGxpY2FyLCAnTicgcGFyYSBjYW5jZWxhcikiICJHcmF5IgogICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICIgKiAkcGFkSW5wdXQpIC1Ob05ld2xpbmUKICAgICAgICAgICAgJHVhY0NvbmYgPSBSZWFkLUhvc3QgIiIKICAgICAgICAgICAgaWYgKCR1YWNDb25mIC1lcSAiTiIgLW9yICR1YWNDb25mIC1lcSAibiIpIHsgYnJlYWsgfQoKICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgICRyZWdQYXRoID0gIkhLTE06XFNPRlRXQVJFXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXFBvbGljaWVzXFN5c3RlbSIKICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJBcGxpY2FuZG8gcmVnbGFzIGRlIHJlZ2lzdHJvLi4uIiAiRGFya0dyYXkiCgogICAgICAgICAgICAgICAgU2V0LUl0ZW1Qcm9wZXJ0eSAtUGF0aCAkcmVnUGF0aCAtTmFtZSAiRW5hYmxlTFVBIiAgICAgICAgICAgICAgICAgICAgLVZhbHVlIDEgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAgICAgICAgIFNldC1JdGVtUHJvcGVydHkgLVBhdGggJHJlZ1BhdGggLU5hbWUgIlByb21wdE9uU2VjdXJlRGVza3RvcCIgICAgICAgIC1WYWx1ZSAxIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgICAgICBTZXQtSXRlbVByb3BlcnR5IC1QYXRoICRyZWdQYXRoIC1OYW1lICJDb25zZW50UHJvbXB0QmVoYXZpb3JVc2VyIiAgICAtVmFsdWUgMSAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICAgICAgICAgU2V0LUl0ZW1Qcm9wZXJ0eSAtUGF0aCAkcmVnUGF0aCAtTmFtZSAiQ29uc2VudFByb21wdEJlaGF2aW9yQWRtaW4iICAgLVZhbHVlIDIgLUVycm9yQWN0aW9uIFN0b3AKCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiQ09ORklHVVJBQ0lPTiBBUExJQ0FEQS4iICJHcmVlbiIKICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJXaW5kb3dzIHBlZGlyYSBjcmVkZW5jaWFsZXMgcGFyYSBpbnN0YWxhciBzb2Z0d2FyZS4iICJHcmF5IgogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIlNlIHJlcXVpZXJlIHJlaW5pY2lvIHBhcmEgYXBsaWNhciBjb21wbGV0YW1lbnRlLiIgIlllbGxvdyIKICAgICAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiRVJST1I6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAiUmVkIgogICAgICAgICAgICB9CiAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICB9CgogICAgICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAgICAgIjQiIHsKICAgICAgICAgICAgRGlidWphci1IZWFkZXIKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIj4+PiBBVURJVE9SSUEgREUgVVNVQVJJT1MgREVMIFNJU1RFTUEgPDw8IiAiWWVsbG93IgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIEVzY3JpYmlyLURlc2NyaXBjaW9uIGAKICAgICAgICAgICAgICAgIC1RdWUgIkxpc3RhIHRvZGFzIGxhcyBjdWVudGFzIGxvY2FsZXMgZGVsIGVxdWlwbyBtb3N0cmFuZG8gbm9tYnJlLCByb2wgKEFkbWluL0VzdGFuZGFyKSwgZXN0YWRvIChhY3RpdmEvZGVzYWN0aXZhZGEpIHkgc2kgdGllbmVuIGNvbnRyYXNlbmEgcmVxdWVyaWRhLiIgYAogICAgICAgICAgICAgICAgLVJlY29tZW5kYWNpb24gIkVqZWN1dGEgYW50ZXMgeSBkZXNwdWVzIGRlIGN1YWxxdWllciBjYW1iaW8gcGFyYSB2ZXJpZmljYXIgZWwgZXN0YWRvIHJlYWwuIElkZWFsIHBhcmEgZG9jdW1lbnRhciBsYSBjb25maWd1cmFjaW9uIGFsIGluaWNpbyB5IGFsIGZpbmFsIGRlIHVuYSBpbnRlcnZlbmNpb24gdGVjbmljYS4iIGAKICAgICAgICAgICAgICAgIC1QcmVjYXVjaW9uICJTb2xvIGxlY3R1cmEsIG5vIHJlYWxpemEgbmluZ3VuIGNhbWJpby4gU2kgdmVzIGN1ZW50YXMgQWRtaW4gZGVzY29ub2NpZGFzIG8gY3VlbnRhcyBhY3RpdmFzIHNpbiBjb250cmFzZW5hLCBpbnZlc3RpZ2EgYW50ZXMgZGUgY29udGludWFyIGNvbiBvdHJhcyBvcGNpb25lcy4iCgogICAgICAgICAgICB0cnkgewogICAgICAgICAgICAgICAgJHVzdWFyaW9zID0gR2V0LUxvY2FsVXNlciAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICAgICAgICAgJGFkbWlucyAgID0gQChHZXQtTG9jYWxHcm91cE1lbWJlciAtU0lEICJTLTEtNS0zMi01NDQiIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlIHwgRm9yRWFjaC1PYmplY3QgeyAkXy5OYW1lLlNwbGl0KCJcIilbLTFdIH0pCgogICAgICAgICAgICAgICAgJGFuY2hvUGFudGFsbGEyID0gJEhvc3QuVUkuUmF3VUkuV2luZG93U2l6ZS5XaWR0aAogICAgICAgICAgICAgICAgJGxpbmVhRW5jYWJlemFkbyA9ICJ7MCwtMjJ9IHsxLC0xNH0gezIsLTEyfSB7MywtMTB9IiAtZiAiVVNVQVJJTyIsIlJPTCIsIkVTVEFETyIsIkNMQVZFIgogICAgICAgICAgICAgICAgJHBhZEF1ZGl0ID0gW21hdGhdOjpNYXgoMCwgW21hdGhdOjpGbG9vcigoJGFuY2hvUGFudGFsbGEyIC0gJGxpbmVhRW5jYWJlemFkby5MZW5ndGgpIC8gMikpCiAgICAgICAgICAgICAgICAkc3BjID0gIiAiICogJHBhZEF1ZGl0CgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiJHNwYyRsaW5lYUVuY2FiZXphZG8iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiRzcGMkKCItIiAqICRsaW5lYUVuY2FiZXphZG8uTGVuZ3RoKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgICAgICAgICAgICAgIGZvcmVhY2ggKCR1IGluICR1c3VhcmlvcykgewogICAgICAgICAgICAgICAgICAgICRyb2wgICAgPSBpZiAoJGFkbWlucyAtY29udGFpbnMgJHUuTmFtZSkgeyAiQWRtaW4iIH0gZWxzZSB7ICJFc3RhbmRhciIgfQogICAgICAgICAgICAgICAgICAgICRlc3RhZG8gPSBpZiAoJHUuRW5hYmxlZCkgeyAiQWN0aXZhIiB9IGVsc2UgeyAiRGVzYWN0aXZhZGEiIH0KICAgICAgICAgICAgICAgICAgICAkY2xhdmUgID0gaWYgKCR1LlBhc3N3b3JkUmVxdWlyZWQpIHsgIlJlcXVlcmlkYSIgfSBlbHNlIHsgIk5vIHJlcS4iIH0KICAgICAgICAgICAgICAgICAgICAkbGluZWEgID0gInswLC0yMn0gezEsLTE0fSB7MiwtMTJ9IHszLC0xMH0iIC1mICR1Lk5hbWUsICRyb2wsICRlc3RhZG8sICRjbGF2ZQoKICAgICAgICAgICAgICAgICAgICAkY29sb3IgPSBpZiAoISR1LkVuYWJsZWQpIHsgIkRhcmtHcmF5IiB9CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZWlmICgkcm9sIC1lcSAiQWRtaW4iKSB7ICJDeWFuIiB9CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSB7ICJXaGl0ZSIgfQogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiRzcGMkbGluZWEiIC1Gb3JlZ3JvdW5kQ29sb3IgJGNvbG9yCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiVG90YWw6ICQoJHVzdWFyaW9zLkNvdW50KSBjdWVudGEocykgfCBBZG1pbnM6ICQoJGFkbWlucy5Db3VudCkiICJEYXJrR3JheSIKICAgICAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiRVJST1I6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAiUmVkIgogICAgICAgICAgICB9CiAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICB9CgogICAgICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAgICAgIjUiIHsKICAgICAgICAgICAgRGlidWphci1IZWFkZXIKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIj4+PiBERVNIQUJJTElUQVIgLyBIQUJJTElUQVIgQ1VFTlRBIDw8PCIgIk1hZ2VudGEiCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgRXNjcmliaXItRGVzY3JpcGNpb24gYAogICAgICAgICAgICAgICAgLVF1ZSAiRGVzYWN0aXZhIG8gcmVhY3RpdmEgdW5hIGN1ZW50YSBsb2NhbCBzaW4gZWxpbWluYXJsYS4gVW5hIGN1ZW50YSBkZXNhY3RpdmFkYSBubyBwdWVkZSBpbmljaWFyIHNlc2lvbiBwZXJvIGNvbnNlcnZhIHRvZG9zIHN1cyBkYXRvcyB5IGNvbmZpZ3VyYWNpb24gaW50YWN0b3MuIiBgCiAgICAgICAgICAgICAgICAtUmVjb21lbmRhY2lvbiAiUHJlZmllcmUgZGVzaGFiaWxpdGFyIHNvYnJlIGVsaW1pbmFyLiBTaSBlbiBlbCBmdXR1cm8gbmVjZXNpdGFzIHJlY3VwZXJhciBhY2Nlc28gYSBlc2EgY3VlbnRhLCBwb2RyYXMgcmVhY3RpdmFybGEgc2luIHBlcmRlciBkYXRvcyBuaSBjb25maWd1cmFjaW9uIGRlbCBwZXJmaWwuIiBgCiAgICAgICAgICAgICAgICAtUHJlY2F1Y2lvbiAiTm8gcHVlZGVzIGRlc2hhYmlsaXRhciB0dSBwcm9waWEgY3VlbnRhIGFjdGl2YS4gTm8gZGVzaGFiaWxpdGVzIGxhIHVuaWNhIGN1ZW50YSBBZG1pbiBkZWwgc2lzdGVtYSBvIGVsIGVxdWlwbyBxdWVkYXJhIGluYWNjZXNpYmxlIHNpbiByZWluc3RhbGFyIFdpbmRvd3MuIgoKICAgICAgICAgICAgdHJ5IHsKICAgICAgICAgICAgICAgICR1c3VhcmlvcyA9IEdldC1Mb2NhbFVzZXIgLUVycm9yQWN0aW9uIFN0b3AgfCBXaGVyZS1PYmplY3QgeyAkXy5OYW1lIC1uZSAkZW52OlVTRVJOQU1FIH0KICAgICAgICAgICAgICAgIGlmICgkdXN1YXJpb3MuQ291bnQgLWVxIDApIHsKICAgICAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiTm8gaGF5IG90cmFzIGN1ZW50YXMgZGlzcG9uaWJsZXMuIiAiWWVsbG93IgogICAgICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICAgICAgICAgICAgICBicmVhawogICAgICAgICAgICAgICAgfQoKICAgICAgICAgICAgICAgICRhbmNob1BhbnRhbGxhMyA9ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUuV2lkdGgKICAgICAgICAgICAgICAgICRpID0gMQogICAgICAgICAgICAgICAgZm9yZWFjaCAoJHUgaW4gJHVzdWFyaW9zKSB7CiAgICAgICAgICAgICAgICAgICAgJGVzdGFkbyA9IGlmICgkdS5FbmFibGVkKSB7ICJbQUNUSVZBXSIgfSBlbHNlIHsgIltERVNBQ1RJVkFEQV0iIH0KICAgICAgICAgICAgICAgICAgICAkY29sb3IgID0gaWYgKCR1LkVuYWJsZWQpIHsgIldoaXRlIiB9IGVsc2UgeyAiRGFya0dyYXkiIH0KICAgICAgICAgICAgICAgICAgICAkbGluZWEgID0gIiAgJGkuICQoJHUuTmFtZSkgJGVzdGFkbyIKICAgICAgICAgICAgICAgICAgICAkcGFkMyAgID0gW21hdGhdOjpNYXgoMCwgW21hdGhdOjpGbG9vcigoJGFuY2hvUGFudGFsbGEzIC0gJGxpbmVhLkxlbmd0aCkgLyAyKSkKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICIgKiAkcGFkMyArICRsaW5lYSkgLUZvcmVncm91bmRDb2xvciAkY29sb3IKICAgICAgICAgICAgICAgICAgICAkaSsrCiAgICAgICAgICAgICAgICB9CgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIihOdW1lcm8gZGUgY3VlbnRhLCBvIEVudGVyIHBhcmEgdm9sdmVyKSIgIkRhcmtHcmF5IgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAoIiAiICogJHBhZElucHV0KSAtTm9OZXdsaW5lCiAgICAgICAgICAgICAgICAkbnVtU3RyID0gUmVhZC1Ib3N0ICJDdWVudGEiCiAgICAgICAgICAgICAgICBpZiAoW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkbnVtU3RyKSkgeyBicmVhayB9CgogICAgICAgICAgICAgICAgJG51bSA9IDAKICAgICAgICAgICAgICAgIGlmICghW2ludF06OlRyeVBhcnNlKCRudW1TdHIsIFtyZWZdJG51bSkgLW9yICRudW0gLWx0IDEgLW9yICRudW0gLWd0ICR1c3Vhcmlvcy5Db3VudCkgewogICAgICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJOdW1lcm8gaW52YWxpZG8uIiAiUmVkIgogICAgICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICAgICAgICAgICAgICBicmVhawogICAgICAgICAgICAgICAgfQoKICAgICAgICAgICAgICAgICRjdWVudGFFbGVnaWRhID0gQCgkdXN1YXJpb3MpWyRudW0gLSAxXQogICAgICAgICAgICAgICAgaWYgKCRjdWVudGFFbGVnaWRhLkVuYWJsZWQpIHsKICAgICAgICAgICAgICAgICAgICBEaXNhYmxlLUxvY2FsVXNlciAtTmFtZSAkY3VlbnRhRWxlZ2lkYS5OYW1lIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIkN1ZW50YSAnJCgkY3VlbnRhRWxlZ2lkYS5OYW1lKScgREVTSEFCSUxJVEFEQS4iICJZZWxsb3ciCiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIEVuYWJsZS1Mb2NhbFVzZXIgLU5hbWUgJGN1ZW50YUVsZWdpZGEuTmFtZSAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJDdWVudGEgJyQoJGN1ZW50YUVsZWdpZGEuTmFtZSknIEhBQklMSVRBREEuIiAiR3JlZW4iCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIkVSUk9SOiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIgIlJlZCIKICAgICAgICAgICAgfQogICAgICAgICAgICBSZWFkLUhvc3QgImBuUHJlc2lvbmUgRW50ZXIgcGFyYSBjb250aW51YXIuLi4iCiAgICAgICAgfQoKICAgICAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgICAgICI2IiB7CiAgICAgICAgICAgIERpYnVqYXItSGVhZGVyCiAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICI+Pj4gUE9MSVRJQ0EgREUgQ09OVFJBU0VOQVMgPDw8IiAiRGFya0N5YW4iCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgRXNjcmliaXItRGVzY3JpcGNpb24gYAogICAgICAgICAgICAgICAgLVF1ZSAiQ29uZmlndXJhIGxhcyByZWdsYXMgZ2xvYmFsZXMgZGUgY29udHJhc2VuYXMgZGVsIHNpc3RlbWE6IGxvbmdpdHVkIG1pbmltYSwgZGlhcyBoYXN0YSBjYWR1Y2lkYWQgeSBudW1lcm8gZGUgaW50ZW50b3MgZmFsbGlkb3MgYW50ZXMgZGUgYmxvcXVlYXIgbGEgY3VlbnRhLiIgYAogICAgICAgICAgICAgICAgLVJlY29tZW5kYWNpb24gIlZhbG9yZXMgcmVjb21lbmRhZG9zOiBsb25naXR1ZCBtaW5pbWEgMTAsIGV4cGlyYWNpb24gOTAgZGlhcywgYmxvcXVlbyB0cmFzIDUgaW50ZW50b3MuIFBhcmEgdXNvIGRvbWVzdGljbyBwdWVkZXMgcG9uZXIgZXhwaXJhY2lvbiAwIChudW5jYSBjYWR1Y2EpLiIgYAogICAgICAgICAgICAgICAgLVByZWNhdWNpb24gIkVzdG9zIGNhbWJpb3MgYWZlY3RhbiBhIFRPREFTIGxhcyBjdWVudGFzIGRlbCBlcXVpcG8uIFVuIGxvY2tvdXQgbXV5IGFncmVzaXZvICgzIGludGVudG9zKSBwdWVkZSBibG9xdWVhciBhbCBjbGllbnRlIHNpIG9sdmlkYSBzdSBjb250cmFzZW5hIGNvbiBmcmVjdWVuY2lhLiIKCiAgICAgICAgICAgIHRyeSB7CiAgICAgICAgICAgICAgICAkcG9saXRpY2FBY3R1YWwgPSBuZXQgYWNjb3VudHMgMj4kbnVsbCB8IFNlbGVjdC1TdHJpbmcgIk1pbmltdW18TWF4aW11bXxMb2Nrb3V0IiB8IEZvckVhY2gtT2JqZWN0IHsgIiAgIiArICRfLkxpbmUuVHJpbSgpIH0KICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICJQb2xpdGljYSBhY3R1YWw6IiAiRGFya0dyYXkiCiAgICAgICAgICAgICAgICAkcG9saXRpY2FBY3R1YWwgfCBGb3JFYWNoLU9iamVjdCB7IEVzY3JpYmlyLUNlbnRyYWRvICRfICJHcmF5IiB9CiAgICAgICAgICAgIH0gY2F0Y2gge30KCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIi0tLSBDb25maWd1cmFyIG51ZXZhIHBvbGl0aWNhIC0tLSIgIkRhcmtDeWFuIgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCgogICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICIgKiAoJHBhZElucHV0IC0gOCkpIC1Ob05ld2xpbmUKICAgICAgICAgICAgJG1pbkxlbiA9IFJlYWQtSG9zdCAiTG9uZ2l0dWQgbWluaW1hIChFbnRlciA9IG5vIGNhbWJpYXIpIgoKICAgICAgICAgICAgV3JpdGUtSG9zdCAoIiAiICogKCRwYWRJbnB1dCAtIDgpKSAtTm9OZXdsaW5lCiAgICAgICAgICAgICRtYXhBZ2UgPSBSZWFkLUhvc3QgIkRpYXMgaGFzdGEgZXhwaXJhY2lvbiAoRW50ZXIgPSBubyBjYW1iaWFyLCAwID0gbnVuY2EpIgoKICAgICAgICAgICAgV3JpdGUtSG9zdCAoIiAiICogKCRwYWRJbnB1dCAtIDgpKSAtTm9OZXdsaW5lCiAgICAgICAgICAgICRsb2Nrb3V0ID0gUmVhZC1Ib3N0ICJJbnRlbnRvcyBhbnRlcyBkZSBibG9xdWVhciAoRW50ZXIgPSBubyBjYW1iaWFyKSIKCiAgICAgICAgICAgICRjYW1iaW9zID0gMAogICAgICAgICAgICB0cnkgewogICAgICAgICAgICAgICAgaWYgKCFbc3RyaW5nXTo6SXNOdWxsT3JXaGl0ZVNwYWNlKCRtaW5MZW4pIC1hbmQgJG1pbkxlbiAtbWF0Y2ggJ15cZCskJykgewogICAgICAgICAgICAgICAgICAgIG5ldCBhY2NvdW50cyAvbWlucHdsZW46JG1pbkxlbiB8IE91dC1OdWxsOyAkY2FtYmlvcysrCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAoIVtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJG1heEFnZSkgLWFuZCAkbWF4QWdlIC1tYXRjaCAnXlxkKyQnKSB7CiAgICAgICAgICAgICAgICAgICAgbmV0IGFjY291bnRzIC9tYXhwd2FnZTokbWF4QWdlIHwgT3V0LU51bGw7ICRjYW1iaW9zKysKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGlmICghW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkbG9ja291dCkgLWFuZCAkbG9ja291dCAtbWF0Y2ggJ15cZCskJykgewogICAgICAgICAgICAgICAgICAgIG5ldCBhY2NvdW50cyAvbG9ja291dHRocmVzaG9sZDokbG9ja291dCB8IE91dC1OdWxsOyAkY2FtYmlvcysrCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAoJGNhbWJpb3MgLWd0IDApIHsgRXNjcmliaXItQ2VudHJhZG8gIiRjYW1iaW9zIGNhbWJpbyhzKSBhcGxpY2Fkb3MuIiAiR3JlZW4iIH0KICAgICAgICAgICAgICAgIGVsc2UgeyBFc2NyaWJpci1DZW50cmFkbyAiU2luIGNhbWJpb3MuIiAiRGFya0dyYXkiIH0KICAgICAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiRVJST1I6ICQoJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIiAiUmVkIgogICAgICAgICAgICB9CiAgICAgICAgICAgIFJlYWQtSG9zdCAiYG5QcmVzaW9uZSBFbnRlciBwYXJhIGNvbnRpbnVhci4uLiIKICAgICAgICB9CgogICAgICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAgICAgIjciIHsKICAgICAgICAgICAgRGlidWphci1IZWFkZXIKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIj4+PiBFWFBPUlRBUiBJTkZPUk1FIERFIFNFR1VSSURBRCA8PDwiICJEYXJrWWVsbG93IgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIEVzY3JpYmlyLURlc2NyaXBjaW9uIGAKICAgICAgICAgICAgICAgIC1RdWUgIkdlbmVyYSB1biBhcmNoaXZvIC50eHQgZW4gZWwgZXNjcml0b3JpbyBjb24gZWwgZXN0YWRvIGNvbXBsZXRvIGRlIHNlZ3VyaWRhZDogbml2ZWwgVUFDLCBsaXN0YSBkZSB1c3VhcmlvcyBjb24gcm9sZXMgeSBlc3RhZG9zLCB5IHBvbGl0aWNhIGRlIGNvbnRyYXNlbmFzIHZpZ2VudGUuIiBgCiAgICAgICAgICAgICAgICAtUmVjb21lbmRhY2lvbiAiR2VuZXJhIGVsIGluZm9ybWUgYWwgaW5pY2lvIHkgYWwgZmluYWwgZGUgY2FkYSBpbnRlcnZlbmNpb24uIEd1YXJkYWxvIGVuIGxhIGZpY2hhIGRlbCBjbGllbnRlIGNvbW8gZXZpZGVuY2lhIGRlbCB0cmFiYWpvIHJlYWxpemFkbyB5IGVzdGFkbyBkZWwgZXF1aXBvLiIgYAogICAgICAgICAgICAgICAgLVByZWNhdWNpb24gIkVsIGluZm9ybWUgY29udGllbmUgaW5mb3JtYWNpb24gc2Vuc2libGUgKG5vbWJyZXMgZGUgY3VlbnRhcywgY29uZmlndXJhY2lvbikuIE5vIGxvIGRlamVzIGVuIGVsIGVzY3JpdG9yaW8gZGVsIGNsaWVudGU6IGd1YXJkYWxvIGVuIHR1IHNpc3RlbWEgeSBlbGltaW5hIGxhIGNvcGlhIGxvY2FsLiIKICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIkdlbmVyYW5kbyBpbmZvcm1lLi4uIiAiQ3lhbiIKCiAgICAgICAgICAgIHRyeSB7CiAgICAgICAgICAgICAgICAkdWFjICAgICAgPSBPYnRlbmVyLUVzdGFkb1VBQwogICAgICAgICAgICAgICAgJHVzdWFyaW9zID0gR2V0LUxvY2FsVXNlciAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICAgICAgICAgJGFkbWlucyAgID0gQChHZXQtTG9jYWxHcm91cE1lbWJlciAtU0lEICJTLTEtNS0zMi01NDQiIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlIHwgRm9yRWFjaC1PYmplY3QgeyAkXy5OYW1lLlNwbGl0KCJcIilbLTFdIH0pCiAgICAgICAgICAgICAgICAkcG9saXRpY2EgPSBuZXQgYWNjb3VudHMgMj4kbnVsbAoKICAgICAgICAgICAgICAgICRsaW5lYXMgPSBAKCkKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iCiAgICAgICAgICAgICAgICAkbGluZWFzICs9ICIgIEFUTEFTIFBDIFNVUFBPUlQgLSBJTkZPUk1FIERFIFNFR1VSSURBRCIKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIiAgRmVjaGEgICAgOiAkKEdldC1EYXRlIC1Gb3JtYXQgJ3l5eXktTU0tZGQgSEg6bW06c3MnKSIKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIiAgRXF1aXBvICAgOiAkZW52OkNPTVBVVEVSTkFNRSIKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIiAgVXN1YXJpbyAgOiAkZW52OlVTRVJOQU1FIgogICAgICAgICAgICAgICAgJGxpbmVhcyArPSAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIiIKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIi0tLSBFU1RBRE8gVUFDIC0tLSIKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIiAgIiArICR1YWMuVGV4dG8KICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIiIKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIi0tLSBVU1VBUklPUyBMT0NBTEVTIC0tLSIKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIiAgezAsLTIyfSB7MSwtMTR9IHsyLC0xMn0gezN9IiAtZiAiTk9NQlJFIiwiUk9MIiwiRVNUQURPIiwiQ0xBVkUiCiAgICAgICAgICAgICAgICAkbGluZWFzICs9ICIgICIgKyAoIi0iICogNjApCiAgICAgICAgICAgICAgICBmb3JlYWNoICgkdSBpbiAkdXN1YXJpb3MpIHsKICAgICAgICAgICAgICAgICAgICAkcm9sICAgID0gaWYgKCRhZG1pbnMgLWNvbnRhaW5zICR1Lk5hbWUpIHsgIkFkbWluIiB9IGVsc2UgeyAiRXN0YW5kYXIiIH0KICAgICAgICAgICAgICAgICAgICAkZXN0YWRvID0gaWYgKCR1LkVuYWJsZWQpIHsgIkFjdGl2YSIgfSBlbHNlIHsgIkRlc2FjdGl2YWRhIiB9CiAgICAgICAgICAgICAgICAgICAgJGNsYXZlICA9IGlmICgkdS5QYXNzd29yZFJlcXVpcmVkKSB7ICJSZXF1ZXJpZGEiIH0gZWxzZSB7ICJObyByZXEuIiB9CiAgICAgICAgICAgICAgICAgICAgJGxpbmVhcyArPSAiICB7MCwtMjJ9IHsxLC0xNH0gezIsLTEyfSB7M30iIC1mICR1Lk5hbWUsICRyb2wsICRlc3RhZG8sICRjbGF2ZQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgJGxpbmVhcyArPSAiIgogICAgICAgICAgICAgICAgJGxpbmVhcyArPSAiLS0tIFBPTElUSUNBIERFIENPTlRSQVNFTkFTIC0tLSIKICAgICAgICAgICAgICAgICRwb2xpdGljYSB8IEZvckVhY2gtT2JqZWN0IHsgJGxpbmVhcyArPSAiICAkXyIgfQogICAgICAgICAgICAgICAgJGxpbmVhcyArPSAiIgogICAgICAgICAgICAgICAgJGxpbmVhcyArPSAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIKICAgICAgICAgICAgICAgICRsaW5lYXMgKz0gIiAgSW5mb3JtZSBnZW5lcmFkbyBwb3IgQXRsYXMgUEMgU3VwcG9ydCBTZWN1cml0eSBTdWl0ZSB2My4wIgogICAgICAgICAgICAgICAgJGxpbmVhcyArPSAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIKCiAgICAgICAgICAgICAgICAkcnV0YUluZm9ybWUgPSAiJGVudjpVU0VSUFJPRklMRVxEZXNrdG9wXEluZm9ybWVfU2VndXJpZGFkXyQoR2V0LURhdGUgLUZvcm1hdCAneXl5eU1NZGRfSEhtbScpLnR4dCIKICAgICAgICAgICAgICAgICRsaW5lYXMgfCBPdXQtRmlsZSAtRmlsZVBhdGggJHJ1dGFJbmZvcm1lIC1FbmNvZGluZyBVVEY4CiAgICAgICAgICAgICAgICBFc2NyaWJpci1DZW50cmFkbyAiSW5mb3JtZSBndWFyZGFkbyBlbjoiICJHcmVlbiIKICAgICAgICAgICAgICAgIEVzY3JpYmlyLUNlbnRyYWRvICRydXRhSW5mb3JtZSAiV2hpdGUiCiAgICAgICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICAgICAgRXNjcmliaXItQ2VudHJhZG8gIkVSUk9SOiAkKCRfLkV4Y2VwdGlvbi5NZXNzYWdlKSIgIlJlZCIKICAgICAgICAgICAgfQogICAgICAgICAgICBSZWFkLUhvc3QgImBuUHJlc2lvbmUgRW50ZXIgcGFyYSBjb250aW51YXIuLi4iCiAgICAgICAgfQoKICAgICAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgICAgICI4IiB7IEV4aXQgfQogICAgfQoKfSB3aGlsZSAoJHRydWUpCn0K'
$script:AtlasToolSources['Invoke-PartsUpgrade'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtUGFydHNVcGdyYWRlCiMgUGFydHMgVXBncmFkZSBBZHZpc29yOiBSQU0gKyBDUFUgKyBBbG1hY2VuYW1pZW50bwojIEF0bGFzIFBDIFN1cHBvcnQg4oCUIHYxLjAKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIEludm9rZS1QYXJ0c1VwZ3JhZGUgewogICAgW0NtZGxldEJpbmRpbmcoKV0KICAgIHBhcmFtKCkKCiAgICAkRXJyb3JBY3Rpb25QcmVmZXJlbmNlID0gJ0NvbnRpbnVlJwogICAgJEhvc3QuVUkuUmF3VUkuV2luZG93VGl0bGUgPSAnQVRMQVMgUEMgU1VQUE9SVCAtIFBhcnRzIFVwZ3JhZGUgQWR2aXNvcicKICAgIHRyeSB7ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUgPSBOZXctT2JqZWN0IFN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uSG9zdC5TaXplKDExMCwgNTApIH0gY2F0Y2gge30KICAgIENsZWFyLUhvc3QKCiAgICAkc2NyaXB0OlJlcG9ydGVUZXh0byA9ICcnCiAgICAkc2NyaXB0Okh0bWxTZWN0aW9ucyA9IEAoKQoKICAgIGZ1bmN0aW9uIExvZy1PdXQgeyBwYXJhbShbc3RyaW5nXSRNc2csIFtzdHJpbmddJENvbG9yPSdXaGl0ZScsIFtzd2l0Y2hdJE5vTmV3TGluZSkKICAgICAgICBpZiAoJE5vTmV3TGluZSkgeyBXcml0ZS1Ib3N0ICRNc2cgLUZvcmVncm91bmRDb2xvciAkQ29sb3IgLU5vTmV3bGluZSB9CiAgICAgICAgZWxzZSB7IFdyaXRlLUhvc3QgJE1zZyAtRm9yZWdyb3VuZENvbG9yICRDb2xvciB9CiAgICAgICAgJHNjcmlwdDpSZXBvcnRlVGV4dG8gKz0gJE1zZwogICAgICAgIGlmICgtbm90ICROb05ld0xpbmUpIHsgJHNjcmlwdDpSZXBvcnRlVGV4dG8gKz0gImByYG4iIH0KICAgIH0KCiAgICBmdW5jdGlvbiBTZWN0aW9uLUhlYWRlciB7IHBhcmFtKFtzdHJpbmddJFRpdGxlKQogICAgICAgIExvZy1PdXQgJycKICAgICAgICBMb2ctT3V0ICgnPScgKiA3MCkgJ0N5YW4nCiAgICAgICAgTG9nLU91dCAiICAkVGl0bGUiICdZZWxsb3cnCiAgICAgICAgTG9nLU91dCAoJz0nICogNzApICdDeWFuJwogICAgfQoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBJTkZPIEdFTkVSQUwKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgU2VjdGlvbi1IZWFkZXIgJ0FUTEFTIFBBUlRTIFVQR1JBREUgQURWSVNPUicKICAgIExvZy1PdXQgKCJGZWNoYTogezB9IiAtZiAoR2V0LURhdGUgLUZvcm1hdCAneXl5eS1NTS1kZCBISDptbScpKSAnR3JheScKICAgIExvZy1PdXQgKCJFcXVpcG86IHswfSIgLWYgJGVudjpDT01QVVRFUk5BTUUpICdHcmF5JwoKICAgICRjcyA9IEdldC1DaW1JbnN0YW5jZSBXaW4zMl9Db21wdXRlclN5c3RlbSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgJGNzcCA9IEdldC1DaW1JbnN0YW5jZSBXaW4zMl9Db21wdXRlclN5c3RlbVByb2R1Y3QgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICRiYiA9IEdldC1DaW1JbnN0YW5jZSBXaW4zMl9CYXNlQm9hcmQgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICRjaGFzc2lzID0gR2V0LUNpbUluc3RhbmNlIFdpbjMyX1N5c3RlbUVuY2xvc3VyZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgJGlzTGFwdG9wID0gJGZhbHNlCiAgICBpZiAoJGNoYXNzaXMpIHsgZm9yZWFjaCAoJGN0IGluICRjaGFzc2lzLkNoYXNzaXNUeXBlcykgeyBpZiAoJGN0IC1pbiBAKDksMTAsMTQsMzEsMzIpKSB7ICRpc0xhcHRvcCA9ICR0cnVlOyBicmVhayB9IH0gfQoKICAgIGlmICgkY3MpIHsgTG9nLU91dCAoIkZhYnJpY2FudGU6ICAgezB9IiAtZiAkY3MuTWFudWZhY3R1cmVyKSB9CiAgICBpZiAoJGNzKSB7IExvZy1PdXQgKCJNb2RlbG86ICAgICAgIHswfSIgLWYgJGNzLk1vZGVsKSB9CiAgICBpZiAoJGNzcCAtYW5kICRjc3AuTmFtZSkgeyBMb2ctT3V0ICgiTW9kZWxvIGV4YWN0bzogezB9IiAtZiAkY3NwLk5hbWUpIH0KICAgIGlmICgkYmIpIHsgTG9nLU91dCAoIlBsYWNhIGJhc2U6ICAgezB9IHsxfSIgLWYgJGJiLk1hbnVmYWN0dXJlciwgJGJiLlByb2R1Y3QpIH0KICAgIExvZy1PdXQgKCJGb3JtIGZhY3RvcjogIHswfSIgLWYgJChpZiAoJGlzTGFwdG9wKSB7J0xhcHRvcCd9IGVsc2UgeydEZXNrdG9wL090cm8nfSkpCgogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAjIFJBTQogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICBTZWN0aW9uLUhlYWRlciAnMS4gTUVNT1JJQSBSQU0nCgogICAgdHJ5IHsKICAgICAgICAkcGxhY2EgPSBHZXQtQ2ltSW5zdGFuY2UgV2luMzJfUGh5c2ljYWxNZW1vcnlBcnJheSAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICRtb2R1bG9zID0gQChHZXQtQ2ltSW5zdGFuY2UgV2luMzJfUGh5c2ljYWxNZW1vcnkgLUVycm9yQWN0aW9uIFN0b3ApCiAgICB9IGNhdGNoIHsKICAgICAgICBMb2ctT3V0ICdbRVJST1JdIE5vIHNlIHB1ZG8gY29uc3VsdGFyIGxhIFJBTS4gRWplY3V0YSBjb21vIGFkbWluaXN0cmFkb3IuJyAnUmVkJwogICAgICAgICRwbGFjYSA9ICRudWxsOyAkbW9kdWxvcyA9IEAoKQogICAgfQoKICAgICRtYXhHQiA9ICRudWxsCiAgICBpZiAoJHBsYWNhIC1hbmQgJHBsYWNhLk1heENhcGFjaXR5IC1ndCAwKSB7CiAgICAgICAgJG1heEdCID0gW21hdGhdOjpSb3VuZCgoJHBsYWNhLk1heENhcGFjaXR5IC8gMTAyNCAvIDEwMjQpLCAwKQogICAgfQogICAgJHNsb3RzVG90YWxlcyA9IGlmICgkcGxhY2EpIHsgJHBsYWNhLk1lbW9yeURldmljZXMgfSBlbHNlIHsgMCB9CiAgICAkc2xvdHNVc2Fkb3MgPSAkbW9kdWxvcy5Db3VudAogICAgJHNsb3RzTGlicmVzID0gW01hdGhdOjpNYXgoMCwgW2ludF0kc2xvdHNUb3RhbGVzIC0gW2ludF0kc2xvdHNVc2Fkb3MpCiAgICAkcmFtVG90YWxHQiA9IGlmICgkbW9kdWxvcykgeyBbbWF0aF06OlJvdW5kKCgoJG1vZHVsb3MgfCBNZWFzdXJlLU9iamVjdCBDYXBhY2l0eSAtU3VtKS5TdW0gLyAxR0IpLCAyKSB9IGVsc2UgeyAwIH0KCiAgICBMb2ctT3V0ICgiU2xvdHMgdG90YWxlczogIHswfSIgLWYgJHNsb3RzVG90YWxlcykKICAgIExvZy1PdXQgKCJTbG90cyBvY3VwYWRvczogezB9IiAtZiAkc2xvdHNVc2Fkb3MpCiAgICBMb2ctT3V0ICgiU2xvdHMgbGlicmVzOiAgIHswfSIgLWYgJHNsb3RzTGlicmVzKQogICAgTG9nLU91dCAoIlJBTSB0b3RhbDogICAgICB7MH0gR0IiIC1mICRyYW1Ub3RhbEdCKSAnR3JlZW4nCiAgICBpZiAoJG1heEdCKSB7IExvZy1PdXQgKCJNYXhpbW8gc2VndW4gQklPUzogezB9IEdCIiAtZiAkbWF4R0IpICdHcmVlbicgfQoKICAgICRyYW1UeXBlcyA9IEB7fQogICAgTG9nLU91dCAnJwogICAgTG9nLU91dCAnLS0tIE1vZHVsb3MgaW5zdGFsYWRvcyAtLS0nICdZZWxsb3cnCiAgICBmb3JlYWNoICgkcmFtIGluICRtb2R1bG9zKSB7CiAgICAgICAgJGNhcEdCID0gW21hdGhdOjpSb3VuZCgkcmFtLkNhcGFjaXR5IC8gMUdCLCAwKQogICAgICAgICRyYW1UeXBlQ29kZSA9IFtpbnRdJHJhbS5TTUJJT1NNZW1vcnlUeXBlCiAgICAgICAgJHJhbVR5cGVNYXAgPSBAewogICAgICAgICAgICAyMD0nRERSJzsgMjE9J0REUjInOyAyND0nRERSMyc7IDI2PSdERFI0JzsgMzQ9J0REUjUnCiAgICAgICAgfQogICAgICAgICRyYW1UeXBlTmFtZSA9IGlmICgkcmFtVHlwZU1hcC5Db250YWluc0tleSgkcmFtVHlwZUNvZGUpKSB7ICRyYW1UeXBlTWFwWyRyYW1UeXBlQ29kZV0gfSBlbHNlIHsgIlRpcG8gJHJhbVR5cGVDb2RlIiB9CiAgICAgICAgJHJhbVR5cGVzWyRyYW1UeXBlTmFtZV0gPSAkdHJ1ZQogICAgICAgICRuYXQgPSAkcmFtLlNwZWVkCiAgICAgICAgJGNmZyA9ICRyYW0uQ29uZmlndXJlZENsb2NrU3BlZWQKICAgICAgICAkeG1wRmxhZyA9IGlmICgkY2ZnIC1sdCAkbmF0KSB7ICcgIFtYTVAgQVBBR0FET10nIH0gZWxzZSB7ICcnIH0KICAgICAgICBMb2ctT3V0ICgiICBbezB9XSB7MX0gR0IgezJ9IEAgezN9L3s0fSBNSHogIHs1fSAgUE46IHs2fXs3fSIgLWYgYAogICAgICAgICAgICAkcmFtLkRldmljZUxvY2F0b3IsICRjYXBHQiwgJHJhbVR5cGVOYW1lLCAkY2ZnLCAkbmF0LCAkcmFtLk1hbnVmYWN0dXJlciwgJHJhbS5QYXJ0TnVtYmVyLCAkeG1wRmxhZykKICAgIH0KCiAgICAjIFJlY29tZW5kYWNpb25lcyBSQU0KICAgIExvZy1PdXQgJycKICAgIExvZy1PdXQgJy0tLSBSZWNvbWVuZGFjaW9uZXMgUkFNIC0tLScgJ01hZ2VudGEnCiAgICAkcmFtVHlwZXNMaXN0ID0gQCgkcmFtVHlwZXMuS2V5cykgLWpvaW4gJywgJwogICAgaWYgKCRzbG90c0xpYnJlcyAtZ3QgMCkgewogICAgICAgIExvZy1PdXQgKCJbT0tdIFRpZW5lcyB7MH0gc2xvdChzKSBsaWJyZShzKS4gUHVlZGVzIGFtcGxpYXIuIiAtZiAkc2xvdHNMaWJyZXMpICdHcmVlbicKICAgICAgICBMb2ctT3V0ICgiICAgICBDb21wcmEgbW9kdWxvcyBkZWwgTUlTTU8gdGlwbyAoezB9KSB5IE1JU01BIHZlbG9jaWRhZCAoezF9IE1IeikgcGFyYSBtb2RvIGR1YWwtY2hhbm5lbC4iIC1mICRyYW1UeXBlc0xpc3QsICgkbW9kdWxvc1swXS5TcGVlZCkpCiAgICB9IGVsc2UgewogICAgICAgIExvZy1PdXQgJ1shXSBUb2RvcyBsb3Mgc2xvdHMgZXN0YW4gb2N1cGFkb3MuIFBhcmEgYW1wbGlhciBoYWJyYSBxdWUgcmVlbXBsYXphciBtb2R1bG9zIHBvciB1bm9zIGRlIG1heW9yIGNhcGFjaWRhZC4nICdZZWxsb3cnCiAgICB9CiAgICBpZiAoJHJhbVRvdGFsR0IgLWx0IDgpIHsKICAgICAgICBMb2ctT3V0ICdbIV0gUkFNIHRvdGFsIDwgOCBHQi4gUmVjb21lbmRhZG86IG1pbmltbyA4IEdCICh1c28gZ2VuZXJhbCksIDE2IEdCIChwcm9kdWN0aXZpZGFkKSwgMzIgR0IrIChnYW1pbmcvcHJvKS4nICdZZWxsb3cnCiAgICB9IGVsc2VpZiAoJHJhbVRvdGFsR0IgLWx0IDE2KSB7CiAgICAgICAgTG9nLU91dCAnW2ldIDggR0IgZXMgYWNlcHRhYmxlIHBhcmEgdXNvIGJhc2ljbywgcGVybyAxNiBHQiBlcyBsbyBvcHRpbW8gaG95LicgJ1doaXRlJwogICAgfSBlbHNlIHsKICAgICAgICBMb2ctT3V0ICgiW09LXSB7MH0gR0IgZGUgUkFNIGVzIHN1ZmljaWVudGUgcGFyYSBsYSBtYXlvcmlhIGRlIHVzb3MuIiAtZiAkcmFtVG90YWxHQikgJ0dyZWVuJwogICAgfQogICAgTG9nLU91dCAnJwogICAgTG9nLU91dCAnLS0tIFByZWNhdWNpb25lcyBhbCBjb21wcmFyIFJBTSAtLS0nICdDeWFuJwogICAgTG9nLU91dCAnICAqIE1pc21vIHRpcG8gKEREUjQgY29uIEREUjQsIEREUjUgY29uIEREUjUsIG51bmNhIG1lemNsYXIpLicKICAgIExvZy1PdXQgJyAgKiBNaXNtbyBmb3JtIGZhY3RvcjogRElNTSAoZXNjcml0b3JpbykgbyBTTy1ESU1NIChsYXB0b3ApLicKICAgIExvZy1PdXQgJyAgKiBWZWxvY2lkYWQgSUdVQUwgbyBTVVBFUklPUiBhbCBtb2R1bG8gZXhpc3RlbnRlIChzaSBwb25lcyBtZW5vciwgZWwgQ1BVIGxhIGJhamFyYSkuJwogICAgTG9nLU91dCAnICAqIFZvbHRhamUgSUdVQUwuIE1lemNsYXIgMS4zNVYgY29uIDEuMlYgZGEgaW5lc3RhYmlsaWRhZC4nCiAgICBMb2ctT3V0ICcgICogTWFyY2EvbGF0ZW5jaWFzIHBhcmVjaWRhcyBwYXJhIGR1YWwtY2hhbm5lbCBsaW1waW8uJwogICAgTG9nLU91dCAnICAqIFZlcmlmaWNhIGNvbiBDUFUtWiBsYSBSQU0gYWN0dWFsIGFudGVzIGRlIGNvbXByYXIuJwoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBDUFUKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgU2VjdGlvbi1IZWFkZXIgJzIuIENQVSAoUHJvY2VzYWRvciknCgogICAgJHByb2MgPSBHZXQtQ2ltSW5zdGFuY2UgV2luMzJfUHJvY2Vzc29yIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlIHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgMQogICAgaWYgKC1ub3QgJHByb2MpIHsKICAgICAgICBMb2ctT3V0ICdbRVJST1JdIE5vIHNlIHB1ZG8gY29uc3VsdGFyIGVsIENQVS4nICdSZWQnCiAgICB9IGVsc2UgewogICAgICAgICRjcHVOYW1lID0gaWYgKCRwcm9jLk5hbWUpIHsgJHByb2MuTmFtZS5UcmltKCkgfSBlbHNlIHsgJ0Rlc2Nvbm9jaWRvJyB9CiAgICAgICAgJGNvcmVzID0gJHByb2MuTnVtYmVyT2ZDb3JlcwogICAgICAgICR0aHJlYWRzID0gJHByb2MuTnVtYmVyT2ZMb2dpY2FsUHJvY2Vzc29ycwogICAgICAgICRzb2NrZXROYW1lID0gaWYgKCRwcm9jLlNvY2tldERlc2lnbmF0aW9uKSB7ICRwcm9jLlNvY2tldERlc2lnbmF0aW9uIH0gZWxzZSB7ICdObyByZXBvcnRhZG8nIH0KICAgICAgICAkdXBncmFkZUNvZGUgPSBpZiAoJHByb2MuVXBncmFkZU1ldGhvZCkgeyBbaW50XSRwcm9jLlVwZ3JhZGVNZXRob2QgfSBlbHNlIHsgMiB9CgogICAgICAgICR1cGdyYWRlTWV0aG9kTmFtZXMgPSBAewogICAgICAgICAgICAxPSdPdHJvJzsgMj0nRGVzY29ub2NpZG8nOyAzPSdEYXVnaHRlciBCb2FyZCc7IDQ9J1pJRiBTb2NrZXQnOyA1PSdSZWVtcGxhemFibGUnCiAgICAgICAgICAgIDY9J05pbmd1bm8gKEJHQS9Tb2xkYWRvKSc7IDc9J0xJRiBTb2NrZXQnOyA4PSdTbG90IDEnOyA5PSdTbG90IDInCiAgICAgICAgICAgIDEwPSczNzAtcGluJzsgMTE9J1Nsb3QgQSc7IDEyPSdTbG90IE0nOyAxMz0nU29ja2V0IDQyMyc7IDE0PSdTb2NrZXQgQSAoNDYyKScKICAgICAgICAgICAgMTU9J1NvY2tldCA0NzgnOyAxNj0nU29ja2V0IDc1NCc7IDE3PSdTb2NrZXQgOTQwJzsgMTg9J1NvY2tldCA5MzknCiAgICAgICAgICAgIDE5PSdtUEdBNjA0JzsgMjA9J0xHQTc3MSc7IDIxPSdMR0E3NzUnOyAyMj0nUzEnOyAyMz0nQU0yJzsgMjQ9J0YgKDEyMDcpJwogICAgICAgICAgICAyNT0nTEdBMTM2Nic7IDI2PSdHMzQnOyAyNz0nQU0zJzsgMjg9J0MzMic7IDI5PSdMR0ExMTU2JzsgMzA9J0xHQTE1NjcnCiAgICAgICAgICAgIDMxPSdQR0E5ODhBJzsgMzI9J0JHQTEyODgnOyAzMz0nclBHQTk4OEInOyAzND0nQkdBMTAyMyc7IDM1PSdCR0ExMjI0JwogICAgICAgICAgICAzNj0nTEdBMTE1NSc7IDM3PSdMR0ExMzU2JzsgMzg9J0xHQTIwMTEnOyAzOT0nRlMxJzsgNDA9J0ZTMic7IDQxPSdGTTEnCiAgICAgICAgICAgIDQyPSdGTTInOyA0Mz0nTEdBMjAxMS0zJzsgNDQ9J0xHQTEzNTYtMyc7IDQ1PSdMR0ExMTUwJzsgNDY9J0JHQTExNjgnCiAgICAgICAgICAgIDQ3PSdCR0ExMjM0JzsgNDg9J0JHQTEzNjQnOyA0OT0nQU00JzsgNTA9J0xHQTExNTEnOyA1MT0nQkdBMTM1NicKICAgICAgICAgICAgNTI9J0JHQTE0NDAnOyA1Mz0nQkdBMTUxNSc7IDU0PSdMR0EzNjQ3LTEnOyA1NT0nU1AzJzsgNTY9J1NQM3IyJwogICAgICAgICAgICA1Nz0nTEdBMjA2Nic7IDU4PSdCR0ExMzkyJzsgNTk9J0JHQTE1MTAnOyA2MD0nQkdBMTUyOCc7IDYxPSdMR0E0MTg5JwogICAgICAgICAgICA2Mj0nTEdBMTIwMCc7IDYzPSdMR0E0Njc3JzsgNjQ9J0xHQTE3MDAnOyA2NT0nQkdBMTc0NCc7IDY2PSdCR0ExNzgxJwogICAgICAgICAgICA2Nz0nQkdBMTIxMSc7IDY4PSdCR0EyNDIyJzsgNjk9J0xHQTEyMTEnOyA3MD0nTEdBMjA4NSc7IDcxPSdMR0E0NzEwJwogICAgICAgIH0KICAgICAgICAkdXBncmFkZU1ldGhvZE5hbWUgPSBpZiAoJHVwZ3JhZGVNZXRob2ROYW1lcy5Db250YWluc0tleSgkdXBncmFkZUNvZGUpKSB7ICR1cGdyYWRlTWV0aG9kTmFtZXNbJHVwZ3JhZGVDb2RlXSB9IGVsc2UgeyAiQ29kaWdvICR1cGdyYWRlQ29kZSIgfQoKICAgICAgICAjIEdlbmVyYWNpb24KICAgICAgICAkZ2VuID0gMDsgJGdlbkxhYmVsID0gJycKICAgICAgICBpZiAoJGNwdU5hbWUgLW1hdGNoICdpWzM1NzldLShcZHsxLDJ9KShcZHsyLDN9KScpIHsgJGdlbiA9IFtpbnRdJG1hdGNoZXNbMV07ICRnZW5MYWJlbCA9ICJJbnRlbCBHZW4gJGdlbiIgfQogICAgICAgIGVsc2VpZiAoJGNwdU5hbWUgLW1hdGNoICdDb3JlXHMqVWx0cmEnKSB7ICRnZW4gPSAxNDsgJGdlbkxhYmVsID0gJ0ludGVsIENvcmUgVWx0cmEgKEdlbiAxNCspJyB9CiAgICAgICAgZWxzZWlmICgkY3B1TmFtZSAtbWF0Y2ggJ1J5emVuXHMrWzM1NzldXHMrKFxkKShcZHsyLDR9KScpIHsgJGdlbiA9IFtpbnRdJG1hdGNoZXNbMV07ICRnZW5MYWJlbCA9ICJBTUQgUnl6ZW4gR2VuICRnZW4iIH0KICAgICAgICBlbHNlaWYgKCRjcHVOYW1lIC1tYXRjaCAnQXRobG9ufEFbNDZdLXxBWzQ2XVxzfEVbMTJdLXxGWC0nKSB7ICRnZW4gPSAxOyAkZ2VuTGFiZWwgPSAnQU1EIExlZ2FjeScgfQoKICAgICAgICBMb2ctT3V0ICgiUHJvY2VzYWRvcjogezB9IiAtZiAkY3B1TmFtZSkgJ0dyZWVuJwogICAgICAgIExvZy1PdXQgKCJOdWNsZW9zL0hpbG9zOiB7MH1DIC8gezF9VCIgLWYgJGNvcmVzLCAkdGhyZWFkcykKICAgICAgICBMb2ctT3V0ICgiU29ja2V0IHJlcG9ydGFkbzogezB9IiAtZiAkc29ja2V0TmFtZSkKICAgICAgICBMb2ctT3V0ICgiVXBncmFkZSBtZXRob2Q6IHswfSIgLWYgJHVwZ3JhZGVNZXRob2ROYW1lKQogICAgICAgIGlmICgkZ2VuTGFiZWwpIHsgTG9nLU91dCAoIkdlbmVyYWNpb246IHswfSIgLWYgJGdlbkxhYmVsKSB9CgogICAgICAgICMgRGV0ZWNjaW9uIEJHQS9zb2xkYWRvCiAgICAgICAgJGJnYVNpZ25hbHMgPSAwOyAkYmdhUmVhc29ucyA9IEAoKQogICAgICAgIGlmICgkdXBncmFkZUNvZGUgLWVxIDYpIHsgJGJnYVNpZ25hbHMgKz0gMzsgJGJnYVJlYXNvbnMgKz0gJ1VwZ3JhZGVNZXRob2QgPSBOb25lL0JHQScgfQogICAgICAgIGVsc2VpZiAoJHVwZ3JhZGVNZXRob2ROYW1lIC1tYXRjaCAnQkdBJykgeyAkYmdhU2lnbmFscyArPSAzOyAkYmdhUmVhc29ucyArPSAiU29ja2V0IEJHQSAoJHVwZ3JhZGVNZXRob2ROYW1lKSIgfQogICAgICAgIGlmICgkc29ja2V0TmFtZSAtbWF0Y2ggJ0JHQScpIHsgJGJnYVNpZ25hbHMgKz0gMjsgJGJnYVJlYXNvbnMgKz0gJ1NvY2tldCBkZXNpZ25hZG8gQkdBJyB9CiAgICAgICAgaWYgKCRjcHVOYW1lIC1tYXRjaCAnWy1cc10oXGR7NCw1fSlbVVlIUEddXGInKSB7ICRiZ2FTaWduYWxzICs9IDE7ICRiZ2FSZWFzb25zICs9ICdTdWZpam8gbW9iaWxlIChVL1kvSC9QL0cpJyB9CiAgICAgICAgaWYgKCRpc0xhcHRvcCAtYW5kICRiZ2FTaWduYWxzIC1nZSAxKSB7ICRiZ2FTaWduYWxzICs9IDE7ICRiZ2FSZWFzb25zICs9ICdFcXVpcG8gbGFwdG9wJyB9CgogICAgICAgIExvZy1PdXQgJycKICAgICAgICBMb2ctT3V0ICctLS0gUmVlbXBsYXphYmxlPyAtLS0nICdNYWdlbnRhJwogICAgICAgIGlmICgkYmdhU2lnbmFscyAtZ2UgMykgewogICAgICAgICAgICBMb2ctT3V0ICdbWF0gQ1BVIFNPTERBRE8gQSBMQSBQTEFDQSAoQkdBKS4gTk8gZXMgcmVlbXBsYXphYmxlLicgJ1JlZCcKICAgICAgICAgICAgTG9nLU91dCAnICAgIEFjdHVhbGl6YWNpb246IGltcG9zaWJsZSBzYWx2byByZWVtcGxhem8gY29tcGxldG8gZGUgcGxhY2EgYmFzZSAoeSBjb24gZXNvLCBlbCBQQyBlbnRlcm8pLicKICAgICAgICB9IGVsc2VpZiAoJGJnYVNpZ25hbHMgLWdlIDEpIHsKICAgICAgICAgICAgTG9nLU91dCAnWz9dIENQVSBQUk9CQUJMRU1FTlRFIFNPTERBRE8uIFZlcmlmaWNhIGNvbiBlbCBmYWJyaWNhbnRlIGFudGVzIGRlIGNvbXByYXIgbmFkYS4nICdZZWxsb3cnCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgTG9nLU91dCAoIltPS10gQ1BVIGVuIFNPQ0tFVCAoezB9KSAtIFJlZW1wbGF6YWJsZS4iIC1mICRzb2NrZXROYW1lKSAnR3JlZW4nCiAgICAgICAgICAgIExvZy1PdXQgJyAgICBQdWVkZXMgY2FtYmlhcmxvIHBvciBvdHJvIENQVSBjb21wYXRpYmxlIGNvbiBlc3RlIHNvY2tldCB5IGNoaXBzZXQuJwogICAgICAgIH0KICAgICAgICBpZiAoJGJnYVJlYXNvbnMuQ291bnQgLWd0IDApIHsgTG9nLU91dCAoIiAgICBTZW5hbGVzIGRldGVjdGFkYXM6IHswfSIgLWYgKCRiZ2FSZWFzb25zIC1qb2luICcgfCAnKSkgJ0RhcmtHcmF5JyB9CgogICAgICAgICMgUmVjb21lbmRhY2lvbmVzIENQVQogICAgICAgIExvZy1PdXQgJycKICAgICAgICBMb2ctT3V0ICctLS0gUmVjb21lbmRhY2lvbmVzIENQVSAtLS0nICdNYWdlbnRhJwogICAgICAgIGlmICgkYmdhU2lnbmFscyAtZ2UgMykgewogICAgICAgICAgICBMb2ctT3V0ICcgIE5vIGhheSB1cGdyYWRlIHBvc2libGUuIFNpIHF1aWVyZXMgbWFzIHJlbmRpbWllbnRvLCBjb25zaWRlcmEgdW4gZXF1aXBvIG51ZXZvIG8gU1NEK1JBTSBwYXJhIGV4dGVuZGVyIHZpZGEgdXRpbC4nCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgTG9nLU91dCAoIiAgMSkgQW5vdGEgZWwgc29ja2V0OiB7MH0iIC1mICRzb2NrZXROYW1lKQogICAgICAgICAgICBMb2ctT3V0ICIgIDIpIEJ1c2NhIGVsIG1vZGVsbyBleGFjdG8gZGUgbGEgcGxhY2EgYmFzZSAoYXJyaWJhKSB5IGRlc2NhcmdhIHN1ICdDUFUgU3VwcG9ydCBMaXN0JyBvZmljaWFsLiIKICAgICAgICAgICAgTG9nLU91dCAnICAzKSBSZXZpc2EgcmVxdWlzaXRvIGRlIEJJT1M6IG11Y2hvcyBjaGlwc2V0cyBJbnRlbC9BTUQgcmVxdWllcmVuIGFjdHVhbGl6YXIgQklPUyBhbnRlcyBkZSBwb25lciBDUFUgbWFzIG51ZXZvLicKICAgICAgICAgICAgTG9nLU91dCAnICA0KSBDb21wYXJhIFREUDogdW4gQ1BVIGNvbiBURFAgc3VwZXJpb3IgYWwgZGVsIGRpc2lwYWRvciBhY3R1YWwgcG9kcmEgcGVybyB0ZXJtaWNhbWVudGUgY2FzdGlnYWRvLiBDYW1iaWEgZGlzaXBhZG9yIHNpIHN1YmVzIGRlIDY1VyBhIDk1VysuJwogICAgICAgICAgICBMb2ctT3V0ICcgIDUpIFZlcmlmaWNhIGdlbmVyYWNpb24gY29tcGF0aWJsZTogbm8gdG9kb3MgbG9zIHNvY2tldHMgYWRtaXRlbiB0b2RhcyBsYXMgZ2VucyAoZWo6IExHQTEyMDAgYWRtaXRlIDEwdGgvMTF0aCBnZW4gc29sbykuJwogICAgICAgIH0KICAgICAgICBMb2ctT3V0ICcnCiAgICAgICAgTG9nLU91dCAnLS0tIFByZWNhdWNpb25lcyBhbCBjb21wcmFyIENQVSAtLS0nICdDeWFuJwogICAgICAgIExvZy1PdXQgJyAgKiBTb2NrZXQgeSBjaGlwc2V0IGNvbXBhdGlibGVzIChubyBzb2xvIGVsIHNvY2tldCBmaXNpY28pLicKICAgICAgICBMb2ctT3V0ICcgICogQklPUyBhY3R1YWxpemFkYSBhIHZlcnNpb24gcXVlIHNvcG9ydGUgZWwgQ1BVIG9iamV0aXZvLicKICAgICAgICBMb2ctT3V0ICcgICogVERQIGNvbXBhdGlibGUgY29uIGVsIGRpc2lwYWRvci9mdWVudGUuIFNpIHN1YmVzIFREUCwgY2FtYmlhIHBhc3RhIHRlcm1pY2EgbWluaW1vLicKICAgICAgICBMb2ctT3V0ICcgICogRW4gbGFwdG9wczogY2FzaSBTSUVNUFJFIHNvbGRhZG8uIEFob3JyYXRlIHRpZW1wbywgbm8gaGF5IHVwZ3JhZGUuJwogICAgICAgIExvZy1PdXQgJyAgKiBTaSBlbCBDUFUgdmllbmUgc2luIGZhbiAodGlwbyAidHJheSIgbyAiT0VNIiksIGNvbXByYSB1bm8gYXBhcnRlLicKICAgIH0KCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICMgQUxNQUNFTkFNSUVOVE8KICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgU2VjdGlvbi1IZWFkZXIgJzMuIEFMTUFDRU5BTUlFTlRPIChEaXNjb3MgeSBzbG90cyknCgogICAgJHBoeXNEaXNrcyA9IEAoR2V0LVBoeXNpY2FsRGlzayAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSkKICAgICRudm1lQ291bnQgPSAwOyAkc2F0YVNzZENvdW50ID0gMDsgJGhkZENvdW50ID0gMDsgJHVzYkNvdW50ID0gMAoKICAgIGlmICgkcGh5c0Rpc2tzLkNvdW50IC1lcSAwKSB7CiAgICAgICAgTG9nLU91dCAnW0VSUk9SXSBObyBzZSBwdWRpZXJvbiBlbnVtZXJhciBkaXNjb3MuJyAnUmVkJwogICAgfSBlbHNlIHsKICAgICAgICBMb2ctT3V0ICctLS0gRGlzY29zIGluc3RhbGFkb3MgLS0tJyAnWWVsbG93JwogICAgICAgIGZvcmVhY2ggKCRwZCBpbiAkcGh5c0Rpc2tzKSB7CiAgICAgICAgICAgICRuYW1lID0gaWYgKCRwZC5GcmllbmRseU5hbWUpIHsgJHBkLkZyaWVuZGx5TmFtZSB9IGVsc2UgeyAnRGlzY28nIH0KICAgICAgICAgICAgJGJ1cyA9IGlmICgkcGQuQnVzVHlwZSkgeyAkcGQuQnVzVHlwZS5Ub1N0cmluZygpIH0gZWxzZSB7ICc/JyB9CiAgICAgICAgICAgICRtZWRpYSA9IGlmICgkcGQuTWVkaWFUeXBlKSB7ICRwZC5NZWRpYVR5cGUuVG9TdHJpbmcoKSB9IGVsc2UgeyAnPycgfQogICAgICAgICAgICAkc2l6ZUdCID0gaWYgKCRwZC5TaXplKSB7IFttYXRoXTo6Um91bmQoJHBkLlNpemUgLyAxR0IsIDApIH0gZWxzZSB7IDAgfQogICAgICAgICAgICAkaGVhbHRoID0gaWYgKCRwZC5IZWFsdGhTdGF0dXMpIHsgJHBkLkhlYWx0aFN0YXR1cy5Ub1N0cmluZygpIH0gZWxzZSB7ICc/JyB9CgogICAgICAgICAgICAka2luZCA9ICdPdHJvJwogICAgICAgICAgICBpZiAoJGJ1cyAtbWF0Y2ggJ05WTWUnKSB7ICRraW5kID0gJ05WTWUgKE0uMiknOyAkbnZtZUNvdW50KysgfQogICAgICAgICAgICBlbHNlaWYgKCRidXMgLW1hdGNoICdVU0InKSB7ICRraW5kID0gJ1VTQiBleHRlcm5vJzsgJHVzYkNvdW50KysgfQogICAgICAgICAgICBlbHNlaWYgKCRtZWRpYSAtbWF0Y2ggJ0hERCcpIHsgJGtpbmQgPSAnSEREIG1lY2FuaWNvJzsgJGhkZENvdW50KysgfQogICAgICAgICAgICBlbHNlaWYgKCRtZWRpYSAtbWF0Y2ggJ1NTRCcgLWFuZCAkYnVzIC1tYXRjaCAnU0FUQXxBVEEnKSB7ICRraW5kID0gJ1NTRCBTQVRBJzsgJHNhdGFTc2RDb3VudCsrIH0KICAgICAgICAgICAgZWxzZWlmICgkYnVzIC1tYXRjaCAnU0FUQXxBVEEnKSB7CiAgICAgICAgICAgICAgICBpZiAoJHNpemVHQiAtbHQgMzAwKSB7ICRraW5kID0gJ1NTRCBTQVRBIChpbmZlcmlkbyknOyAkc2F0YVNzZENvdW50KysgfQogICAgICAgICAgICAgICAgZWxzZSB7ICRraW5kID0gJ0hERCAoaW5mZXJpZG8pJzsgJGhkZENvdW50KysgfQogICAgICAgICAgICB9CgogICAgICAgICAgICBMb2ctT3V0ICgiICB7MH0gIFt7MX1dICBidXM9ezJ9ICBtZWRpYT17M30gIHRhbT17NH0gR0IgIHNhbHVkPXs1fSIgLWYgJGtpbmQsICRuYW1lLCAkYnVzLCAkbWVkaWEsICRzaXplR0IsICRoZWFsdGgpCiAgICAgICAgfQogICAgfQoKICAgIExvZy1PdXQgJycKICAgIExvZy1PdXQgJy0tLSBSZXN1bWVuIGFsbWFjZW5hbWllbnRvIC0tLScgJ1llbGxvdycKICAgIExvZy1PdXQgKCIgIE5WTWUgKE0uMik6ICAgIHswfSIgLWYgJG52bWVDb3VudCkKICAgIExvZy1PdXQgKCIgIFNTRCBTQVRBOiAgICAgIHswfSIgLWYgJHNhdGFTc2RDb3VudCkKICAgIExvZy1PdXQgKCIgIEhERCBtZWNhbmljbzogIHswfSIgLWYgJGhkZENvdW50KQogICAgTG9nLU91dCAoIiAgVVNCIGV4dGVybm86ICAgezB9IiAtZiAkdXNiQ291bnQpCgogICAgIyBTbG90cyBkaXNwb25pYmxlcyAtIGluZmVyZW5jaWEKICAgIExvZy1PdXQgJycKICAgIExvZy1PdXQgJy0tLSBTbG90cyBmaXNpY29zIGRpc3BvbmlibGVzIChpbmZlcmVuY2lhKSAtLS0nICdNYWdlbnRhJwogICAgTG9nLU91dCAnV2luZG93cyBOTyBleHBvbmUgZGlyZWN0YW1lbnRlICJzbG90cyBNLjIgbGlicmVzIi4gU2UgaW5maWVyZSBkZWwgbW9kZWxvIGRlIHBsYWNhIGJhc2UuJwogICAgaWYgKCRiYikgewogICAgICAgIExvZy1PdXQgKCJQbGFjYSBiYXNlIGRldGVjdGFkYTogezB9IHsxfSIgLWYgJGJiLk1hbnVmYWN0dXJlciwgJGJiLlByb2R1Y3QpICdDeWFuJwogICAgICAgIExvZy1PdXQgJ1BhcmEgc2FiZXIgc2xvdHMgcmVhbGVzOicKICAgICAgICAkc2VhcmNoUXVlcnkgPSBbdXJpXTo6RXNjYXBlRGF0YVN0cmluZygoInswfSB7MX0gc3BlY2lmaWNhdGlvbnMgTS4yIFNBVEEgc2xvdHMiIC1mICRiYi5NYW51ZmFjdHVyZXIsICRiYi5Qcm9kdWN0KSkKICAgICAgICBMb2ctT3V0ICgiICAxKSBCdXNjYSBlbiBHb29nbGU6IHswfSBzcGVjaWZpY2F0aW9ucyBNLjIgU0FUQSBzbG90cyIgLWYgIiQoJGJiLk1hbnVmYWN0dXJlcikgJCgkYmIuUHJvZHVjdCkiKQogICAgICAgIExvZy1PdXQgKCIgIDIpIFVSTCBkaXJlY3RhOiBodHRwczovL3d3dy5nb29nbGUuY29tL3NlYXJjaD9xPXswfSIgLWYgJHNlYXJjaFF1ZXJ5KQogICAgfSBlbHNlIHsKICAgICAgICBMb2ctT3V0ICdObyBzZSBwdWRvIGRldGVjdGFyIG1vZGVsbyBkZSBwbGFjYSBiYXNlLiBDb25zdWx0YSBldGlxdWV0YSBmaXNpY2EgbyBDUFUtWiAtPiBNYWluYm9hcmQuJwogICAgfQogICAgTG9nLU91dCAnJwogICAgaWYgKCRpc0xhcHRvcCkgewogICAgICAgIExvZy1PdXQgJ0VuIGxhcHRvcHMgdGlwaWNvczonCiAgICAgICAgTG9nLU91dCAnICAtIDEgc2xvdCBNLjIgTlZNZSAoYSB2ZWNlcyAyIGVuIGdhbWluZykuJwogICAgICAgIExvZy1PdXQgJyAgLSBBIHZlY2VzIDEgYmFoaWEgMi41IiBTQVRBIChjYWRhIHZleiBtZW5vcyBjb211bikuJwogICAgICAgIExvZy1PdXQgJyAgLSBSYXJhIHZleiBzZSBwdWVkZSBhbmFkaXIgZGlzY28gc2luIGRlc21vbnRhci4nCiAgICB9IGVsc2UgewogICAgICAgIExvZy1PdXQgJ0VuIGRlc2t0b3AgdGlwaWNvIChBVFggbWlkLXJhbmdlKTonCiAgICAgICAgTG9nLU91dCAnICAtIDEtMyBzbG90cyBNLjIgKHVubyBzdWVsZSBzZXIgUENJZSA0LjAgbyBzdXBlcmlvciwgb3Ryb3MgUENJZSAzLjApLicKICAgICAgICBMb2ctT3V0ICcgIC0gMi02IHB1ZXJ0b3MgU0FUQSAocGFyYSBTU0QgMi41IiBvIEhERCAzLjUiKS4nCiAgICAgICAgTG9nLU91dCAnICAtIFZlcmlmaWNhIE0uMjogYWxndW5vcyBzbG90cyBzb24gTS4yIFNBVEEsIG90cm9zIE0uMiBOVk1lLCBvdHJvcyBhbWJvcyAoImNvbWJvIikuJwogICAgfQoKICAgICMgUmVjb21lbmRhY2lvbmVzIHN0b3JhZ2UKICAgIExvZy1PdXQgJycKICAgIExvZy1PdXQgJy0tLSBSZWNvbWVuZGFjaW9uZXMgYWxtYWNlbmFtaWVudG8gLS0tJyAnTWFnZW50YScKICAgIGlmICgkaGRkQ291bnQgLWd0IDAgLWFuZCAkbnZtZUNvdW50IC1lcSAwIC1hbmQgJHNhdGFTc2RDb3VudCAtZXEgMCkgewogICAgICAgIExvZy1PdXQgJ1shIV0gRWwgU0lTVEVNQSBhcnJhbmNhIGRlIEhERC4gTWlncmFyIGEgU1NEIGRhIDUtMTB4IG1lam9yYSBwZXJjaWJpZGEuIFByaW9yaWRhZCBNQVhJTUEuJyAnUmVkJwogICAgfSBlbHNlaWYgKCRoZGRDb3VudCAtZ3QgMCkgewogICAgICAgIExvZy1PdXQgJ1tpXSBUaWVuZXMgSEREIHByZXNlbnRlLiBVdGlsIHBhcmEgZGF0b3MvYmFja3VwLiBTaXN0ZW1hIGRlYmVyaWEgZXN0YXIgZW4gU1NEICh5YSBwYXJlY2Ugc2VybG8pLicKICAgIH0KICAgIGlmICgkbnZtZUNvdW50IC1lcSAwIC1hbmQgLW5vdCAkaXNMYXB0b3ApIHsKICAgICAgICBMb2ctT3V0ICdbaV0gU2luIE5WTWUuIENvbnNpZGVyYSBtaWdyYXIgYSBNLjIgTlZNZSBwYXJhIGxlY3R1cmEgc2VjdWVuY2lhbCA+MyBHQi9zIChTQVRBIFNTRCB0b3BlIGVzIDU1MCBNQi9zKS4nCiAgICB9CiAgICBMb2ctT3V0ICcnCiAgICBMb2ctT3V0ICctLS0gUHJlY2F1Y2lvbmVzIGFsIGNvbXByYXIgYWxtYWNlbmFtaWVudG8gLS0tJyAnQ3lhbicKICAgIExvZy1PdXQgJyAgKiBNLjIgTlZNZSB2cyBNLjIgU0FUQTogTk8gc29uIGludGVyY2FtYmlhYmxlcy4gVmVyaWZpY2EgY3VhbCBhZG1pdGUgdHUgc2xvdC4nCiAgICBMb2ctT3V0ICcgICogUENJZSA0LjAgdnMgMy4wOiB1biBTU0QgUENJZSA0LjAgZnVuY2lvbmEgZW4gc2xvdCBQQ0llIDMuMCBwZXJvIGxpbWl0YWRvIGEgbGEgdmVsb2NpZGFkIGRlbCBzbG90LicKICAgIExvZy1PdXQgJyAgKiBUYW1hbm8gTS4yOiAyMjgwIGVzIGVsIGVzdGFuZGFyICg4MCBtbSkuIDIyMzAvMjI0MiBleGlzdGVuIGVuIGxhcHRvcHMgdWx0cmFzbGltLicKICAgIExvZy1PdXQgJyAgKiBEUkFNIGNhY2hlOiBTU0RzIHNpbiBEUkFNIChRTEMgbG93LWVuZCkgc2UgZGVncmFkYW4gcmFwaWRvIGNvbiBjYXJnYXMgc29zdGVuaWRhcy4nCiAgICBMb2ctT3V0ICcgICogVEJXICh0ZXJhYnl0ZXMgd3JpdGVzKTogcmV2aXNhIGVuZHVyYW5jZSBhbnRlcyBkZSBjb21wcmFyIHBhcmEgc2Vydmlkb3IvZWRpdG9yIGRlIHZpZGVvLicKICAgIExvZy1PdXQgJyAgKiBDb21wcmEgU1NEID49IDUwMCBHQiAoZWwgY29zdGUgR0IgZXMgY2FzaSBpZ3VhbCB5IHJlbmRpbWllbnRvIG1lam9yYSkuJwogICAgTG9nLU91dCAnICAqIENsb25hIGNvbiBoZXJyYW1pZW50YSBkZWwgZmFicmljYW50ZSAoU2Ftc3VuZyBNYWdpY2lhbiwgQ3J1Y2lhbCBTdG9yYWdlIEV4ZWN1dGl2ZSwgZXRjKSBvIE1hY3JpdW0gUmVmbGVjdC4nCgogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAjIE9UUk9TIENPTVBPTkVOVEVTIChjb21wbGVtZW50b3MpCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgIFNlY3Rpb24tSGVhZGVyICc0LiBPVFJPUyBDT01QT05FTlRFUycKCiAgICAjIEdQVQogICAgJGdwdXMgPSBAKEdldC1DaW1JbnN0YW5jZSBXaW4zMl9WaWRlb0NvbnRyb2xsZXIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUgfCBXaGVyZS1PYmplY3QgeyAkXy5OYW1lIC1ub3RtYXRjaCAnTWljcm9zb2Z0IEJhc2ljfFJlbW90ZScgfSkKICAgIGlmICgkZ3B1cy5Db3VudCAtZ3QgMCkgewogICAgICAgIExvZy1PdXQgJy0tLSBHUFUgLS0tJyAnWWVsbG93JwogICAgICAgIGZvcmVhY2ggKCRnIGluICRncHVzKSB7CiAgICAgICAgICAgICR2cmFtID0gaWYgKCRnLkFkYXB0ZXJSQU0gLWd0IDApIHsgW21hdGhdOjpSb3VuZCgkZy5BZGFwdGVyUkFNIC8gMU1CLCAwKSB9IGVsc2UgeyAwIH0KICAgICAgICAgICAgTG9nLU91dCAoIiAgezB9ICh7MX0gTUIgVlJBTSByZXBvcnRhZG8pIiAtZiAkZy5OYW1lLCAkdnJhbSkKICAgICAgICB9CiAgICAgICAgaWYgKCRpc0xhcHRvcCkgewogICAgICAgICAgICBMb2ctT3V0ICcgIFtpXSBHUFUgZW4gbGFwdG9wcyBOTyBlcyB1cGdyYWRlYWJsZSAoc29sZGFkYSBhbCBtYWluYm9hcmQgbyBlbiBNWE0gcmFybykuJyAnWWVsbG93JwogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgIExvZy1PdXQgJyAgW2ldIEdQVSBlbiBkZXNrdG9wOiB1cGdyYWRlYWJsZSBzaSB0aWVuZXMgUENJZSBsaWJyZSB5IGZ1ZW50ZSBzdWZpY2llbnRlIChXKS4nICdHcmVlbicKICAgICAgICAgICAgTG9nLU91dCAnICBbIV0gQWwgY29tcHJhciBHUFUgdmVyaWZpY2E6IGNvbmVjdG9yICg4LzYvMTJWSFBXUiksIGxhcmdvIGZpc2ljbyAoY2FqYSksIFREUCB2cyBmdWVudGUsIHNsb3QgUENJZS4nICdDeWFuJwogICAgICAgIH0KICAgIH0KCiAgICAjIFBTVSAtIGxpbWl0YWRvIGVuIGluZm8KICAgIExvZy1PdXQgJycKICAgIExvZy1PdXQgJy0tLSBGdWVudGUgZGUgcG9kZXIgKFBTVSkgLS0tJyAnWWVsbG93JwogICAgTG9nLU91dCAnICBXaW5kb3dzIE5PIGV4cG9uZSBsYSBtYXJjYS93YXR0YWdlIGRlIGxhIFBTVS4gUmV2aXNhIGxhIGV0aXF1ZXRhIGZpc2ljYSBkZW50cm8gZGUgbGEgY2FqYS4nCiAgICBMb2ctT3V0ICcgIFBhcmEgdXBncmFkZSBkZSBHUFUgbyBDUFUgcG90ZW50ZTogdmVyaWZpY2EgcXVlIGxhIGZ1ZW50ZSBzZWEgODArIEJyb256ZSBvIHN1cGVyaW9yIHkgY29uIHdhdHRhZ2Ugc3VmaWNpZW50ZS4nCgogICAgIyBCSU9TCiAgICBMb2ctT3V0ICcnCiAgICBMb2ctT3V0ICctLS0gQklPUyAvIFVFRkkgLS0tJyAnWWVsbG93JwogICAgdHJ5IHsKICAgICAgICAkYmlvcyA9IEdldC1DaW1JbnN0YW5jZSBXaW4zMl9CSU9TIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgTG9nLU91dCAoIiAgVmVyc2lvbjogIHswfSIgLWYgJGJpb3MuU01CSU9TQklPU1ZlcnNpb24pCiAgICAgICAgJGJpb3NEYXRlID0gJG51bGwKICAgICAgICBpZiAoJGJpb3MuUmVsZWFzZURhdGUpIHsKICAgICAgICAgICAgdHJ5IHsgJGJpb3NEYXRlID0gW01hbmFnZW1lbnQuTWFuYWdlbWVudERhdGVUaW1lQ29udmVydGVyXTo6VG9EYXRlVGltZSgkYmlvcy5SZWxlYXNlRGF0ZSkgfSBjYXRjaCB7fQogICAgICAgIH0KICAgICAgICBpZiAoJGJpb3NEYXRlKSB7CiAgICAgICAgICAgICRhZ2VZZWFycyA9IFttYXRoXTo6Um91bmQoKChHZXQtRGF0ZSkgLSAkYmlvc0RhdGUpLlRvdGFsRGF5cyAvIDM2NS4yNSwgMSkKICAgICAgICAgICAgTG9nLU91dCAoIiAgRmVjaGE6ICAgIHswfSAoaGFjZSB7MX0gYW5pb3MpIiAtZiAkYmlvc0RhdGUuVG9TdHJpbmcoJ3l5eXktTU0tZGQnKSwgJGFnZVllYXJzKQogICAgICAgICAgICBpZiAoJGFnZVllYXJzIC1ndCAzKSB7CiAgICAgICAgICAgICAgICBMb2ctT3V0ICcgIFshXSBCSU9TIGFudGlndWEuIEFjdHVhbGl6YXJsYSBwdWVkZSBoYWJpbGl0YXIgQ1BVcyBudWV2b3MgeSBjb3JyZWdpciBidWdzLiBSZXZpc2EgbGEgd2ViIGRlbCBmYWJyaWNhbnRlLicgJ1llbGxvdycKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0gY2F0Y2ggewogICAgICAgIExvZy1PdXQgJyAgTm8gc2UgcHVkbyBsZWVyIEJJT1MuJyAnUmVkJwogICAgfQoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBFWFBPUlQKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgU2VjdGlvbi1IZWFkZXIgJ0VYUE9SVEFSIFJFUE9SVEUnCiAgICBMb2ctT3V0ICcgWzFdIEd1YXJkYXIgVFhUIGVuIEVzY3JpdG9yaW8nCiAgICBMb2ctT3V0ICcgWzJdIEd1YXJkYXIgSFRNTCBlbiBFc2NyaXRvcmlvJwogICAgTG9nLU91dCAnIFszXSBTYWxpciBzaW4gZ3VhcmRhcicKICAgIExvZy1PdXQgJycKICAgICRvcGMgPSBSZWFkLUhvc3QgJyBFbGlnZSBvcGNpb24nCiAgICAkYmFzZSA9ICJQYXJ0c1VwZ3JhZGVfJChHZXQtRGF0ZSAtRm9ybWF0ICd5eXl5TU1kZF9ISG1tJykiCiAgICAkZGVzayA9IFtFbnZpcm9ubWVudF06OkdldEZvbGRlclBhdGgoJ0Rlc2t0b3AnKQogICAgc3dpdGNoICgkb3BjKSB7CiAgICAgICAgJzEnIHsKICAgICAgICAgICAgJHAgPSBKb2luLVBhdGggJGRlc2sgIiRiYXNlLnR4dCIKICAgICAgICAgICAgW1N5c3RlbS5JTy5GaWxlXTo6V3JpdGVBbGxUZXh0KCRwLCAkc2NyaXB0OlJlcG9ydGVUZXh0bywgW1N5c3RlbS5UZXh0LlVURjhFbmNvZGluZ106Om5ldygkdHJ1ZSkpCiAgICAgICAgICAgIExvZy1PdXQgJycKICAgICAgICAgICAgTG9nLU91dCAoIltPS10gVFhUIGd1YXJkYWRvOiB7MH0iIC1mICRwKSAnR3JlZW4nCiAgICAgICAgICAgIHRyeSB7IFN0YXJ0LVByb2Nlc3Mgbm90ZXBhZC5leGUgJHAgfSBjYXRjaCB7fQogICAgICAgIH0KICAgICAgICAnMicgewogICAgICAgICAgICAkcCA9IEpvaW4tUGF0aCAkZGVzayAiJGJhc2UuaHRtbCIKICAgICAgICAgICAgJHN0eWxlID0gQCcKPHN0eWxlPgpib2R5e2ZvbnQtZmFtaWx5OlNlZ29lIFVJLHNhbnMtc2VyaWY7YmFja2dyb3VuZDojMWUxZTFlO2NvbG9yOiNlMGUwZTA7cGFkZGluZzoyMHB4fQpoMXtjb2xvcjojMDA3OEQ3O2JvcmRlci1ib3R0b206MnB4IHNvbGlkICMwMDc4RDc7cGFkZGluZy1ib3R0b206NXB4fQpoMntjb2xvcjojMDBBOEZGO21hcmdpbi10b3A6MjVweH0KcHJle2JhY2tncm91bmQ6IzJkMmQyZDtib3JkZXI6MXB4IHNvbGlkICM0NDQ7cGFkZGluZzoxNXB4O2JvcmRlci1yYWRpdXM6NXB4O2ZvbnQtc2l6ZToxM3B4O3doaXRlLXNwYWNlOnByZS13cmFwfQouZm9vdHtjb2xvcjojODg4O3RleHQtYWxpZ246Y2VudGVyO21hcmdpbi10b3A6MzBweDtmb250LXNpemU6MTFweH0KPC9zdHlsZT4KJ0AKICAgICAgICAgICAgJGVzY2FwZWQgPSBbU3lzdGVtLldlYi5IdHRwVXRpbGl0eV06Okh0bWxFbmNvZGUoJHNjcmlwdDpSZXBvcnRlVGV4dG8pCiAgICAgICAgICAgIGlmICgtbm90ICRlc2NhcGVkKSB7CiAgICAgICAgICAgICAgICAkZXNjYXBlZCA9ICRzY3JpcHQ6UmVwb3J0ZVRleHRvIC1yZXBsYWNlICcmJywnJmFtcDsnIC1yZXBsYWNlICc8JywnJmx0OycgLXJlcGxhY2UgJz4nLCcmZ3Q7JwogICAgICAgICAgICB9CiAgICAgICAgICAgICRodG1sID0gIjxodG1sPjxoZWFkPjxtZXRhIGNoYXJzZXQ9J1VURi04Jz48dGl0bGU+UGFydHMgVXBncmFkZSAtICRlbnY6Q09NUFVURVJOQU1FPC90aXRsZT4kc3R5bGU8L2hlYWQ+PGJvZHk+PGgxPkF0bGFzIFBDIFN1cHBvcnQgLSBQYXJ0cyBVcGdyYWRlIEFkdmlzb3I8L2gxPjxwcmU+JGVzY2FwZWQ8L3ByZT48ZGl2IGNsYXNzPSdmb290Jz5HZW5lcmFkbyAkKEdldC1EYXRlKTwvZGl2PjwvYm9keT48L2h0bWw+IgogICAgICAgICAgICBbU3lzdGVtLklPLkZpbGVdOjpXcml0ZUFsbFRleHQoJHAsICRodG1sLCBbU3lzdGVtLlRleHQuVVRGOEVuY29kaW5nXTo6bmV3KCR0cnVlKSkKICAgICAgICAgICAgTG9nLU91dCAnJwogICAgICAgICAgICBMb2ctT3V0ICgiW09LXSBIVE1MIGd1YXJkYWRvOiB7MH0iIC1mICRwKSAnR3JlZW4nCiAgICAgICAgICAgIHRyeSB7IFN0YXJ0LVByb2Nlc3MgJHAgfSBjYXRjaCB7fQogICAgICAgIH0KICAgICAgICBkZWZhdWx0IHsgTG9nLU91dCAnU2FsaWVuZG8gc2luIGd1YXJkYXIuJyAnRGFya0dyYXknIH0KICAgIH0KfQo='
$script:AtlasToolSources['Invoke-Personalizacion'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtUGVyc29uYWxpemFjaW9uCiMgTWlncmFkbyBkZTogTU9ELnBzMQojIEF0bGFzIFBDIFN1cHBvcnQg4oCUIHYxLjAKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCmZ1bmN0aW9uIEludm9rZS1QZXJzb25hbGl6YWNpb24gewogICAgW0NtZGxldEJpbmRpbmcoKV0KICAgIHBhcmFtKCkKPCMKICAgIC5TWU5PUFNJUwogICAgQVRMQVMgUEMgU1VQUE9SVCAtIENPUkUgTE9HSUMKICAgIC5ERVNDUklQVElPTgogICAgSW1wbGVtZW50YWNpw7NuIHTDqWNuaWNhIGRlIHBlcnNvbmFsaXphY2nDs24gdsOtYSBSZWdpc3RybyB5IEFQSSBXaW4zMi4KIz4KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgQ09ORklHVVJBQ0lPTiBJTklDSUFMIFkgQVBJCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiRIb3N0LlVJLlJhd1VJLldpbmRvd1RpdGxlID0gIkFUTEFTIFBDIFNVUFBPUlQgLSBQRVJTT05BTElaQUNJT04gQVZBTlpBREEiCiRIb3N0LlVJLlJhd1VJLkJhY2tncm91bmRDb2xvciA9ICJCbGFjayIKJEhvc3QuVUkuUmF3VUkuRm9yZWdyb3VuZENvbG9yID0gIldoaXRlIgpDbGVhci1Ib3N0CgojIERlZmluaWNpw7NuIEMjIHBhcmEgbGxhbWFyIGEgU3lzdGVtUGFyYW1ldGVyc0luZm8gKEVMIFRSVUNPIHBhcmEgZWwgV2FsbHBhcGVyKQokY29kZSA9IEAnCnVzaW5nIFN5c3RlbTsKdXNpbmcgU3lzdGVtLlJ1bnRpbWUuSW50ZXJvcFNlcnZpY2VzOwpwdWJsaWMgY2xhc3MgV2FsbHBhcGVyIHsKICAgIHB1YmxpYyBjb25zdCBpbnQgU1BJX1NFVERFU0tXQUxMUEFQRVIgPSAweDAwMTQ7CiAgICBwdWJsaWMgY29uc3QgaW50IFNQSUZfVVBEQVRFSU5JRklMRSA9IDB4MDE7CiAgICBwdWJsaWMgY29uc3QgaW50IFNQSUZfU0VORFdJTklOSUNIQU5HRSA9IDB4MDI7CgogICAgW0RsbEltcG9ydCgidXNlcjMyLmRsbCIsIENoYXJTZXQgPSBDaGFyU2V0LkF1dG8pXQogICAgcHVibGljIHN0YXRpYyBleHRlcm4gaW50IFN5c3RlbVBhcmFtZXRlcnNJbmZvKGludCB1QWN0aW9uLCBpbnQgdVBhcmFtLCBzdHJpbmcgbHB2UGFyYW0sIGludCBmdVdpbkluaSk7Cn0KJ0AKQWRkLVR5cGUgLVR5cGVEZWZpbml0aW9uICRjb2RlCgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojIEZVTkNJT05FUyBERSBJTlRFUkZBWiAoVUkpCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmZ1bmN0aW9uIFdyaXRlLUNlbnRlcmVkIHsKICAgIHBhcmFtKFtzdHJpbmddJFRleHQsIFtDb25zb2xlQ29sb3JdJENvbG9yID0gIldoaXRlIikKICAgICRXaW5kb3dXaWR0aCA9ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUuV2lkdGgKICAgICRQYWRkaW5nID0gW21hdGhdOjpNYXgoMCwgW2ludF0oKCRXaW5kb3dXaWR0aCAtICRUZXh0Lkxlbmd0aCkgLyAyKSkKICAgIFdyaXRlLUhvc3QgKCIgIiAqICRQYWRkaW5nKSAtTm9OZXdsaW5lCiAgICBXcml0ZS1Ib3N0ICRUZXh0IC1Gb3JlZ3JvdW5kQ29sb3IgJENvbG9yCn0KCmZ1bmN0aW9uIFNob3ctSGVhZGVyIHsKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgIlllbGxvdyIKICAgIFdyaXRlLUNlbnRlcmVkICIgICAgICAgICAgQVRMQVMgUEMgU1VQUE9SVCAgICAgICAgICAgICAgICAiICJZZWxsb3ciCiAgICBXcml0ZS1DZW50ZXJlZCAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAiWWVsbG93IgogICAgV3JpdGUtSG9zdCAiYG4iCn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgRlVOQ0lPTkVTIExPR0lDQVMgKEVMIENFUkVCUk8pCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgojIDEuIEZvbmRvIGRlIFBhbnRhbGxhIChBUEkgU3lzdGVtUGFyYW1ldGVyc0luZm8pCmZ1bmN0aW9uIFNldC1BdGxhc1dhbGxwYXBlciB7CiAgICBwYXJhbShbc3RyaW5nXSRQYXRoSW1hZ2VuKQogICAgaWYgKFRlc3QtUGF0aCAkUGF0aEltYWdlbikgewogICAgICAgIHRyeSB7CiAgICAgICAgICAgIFtXYWxscGFwZXJdOjpTeXN0ZW1QYXJhbWV0ZXJzSW5mbygweDAwMTQsIDAsICRQYXRoSW1hZ2VuLCAweDAxIC1ib3IgMHgwMikKICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgIkZvbmRvIGFwbGljYWRvIGNvcnJlY3RhbWVudGUgKEFQSSBXaW4zMikuIiAiR3JlZW4iCiAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgIFdyaXRlLUNlbnRlcmVkICJFcnJvciBhbCBsbGFtYXIgYSBsYSBBUEkuIiAiUmVkIgogICAgICAgIH0KICAgIH0gZWxzZSB7CiAgICAgICAgV3JpdGUtQ2VudGVyZWQgIkVycm9yOiBObyBzZSBlbmN1ZW50cmEgbGEgaW1hZ2VuIGVuOiAkUGF0aEltYWdlbiIgIlJlZCIKICAgIH0KfQoKIyAyLiBUZW1hIE9zY3VybyAoUmVnaXN0cm8pCmZ1bmN0aW9uIFNldC1EYXJrVGhlbWUgewogICAgdHJ5IHsKICAgICAgICAkUmVnUGF0aCA9ICJIS0NVOlxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxUaGVtZXNcUGVyc29uYWxpemUiCiAgICAgICAgU2V0LUl0ZW1Qcm9wZXJ0eSAtUGF0aCAkUmVnUGF0aCAtTmFtZSAiQXBwc1VzZUxpZ2h0VGhlbWUiIC1WYWx1ZSAwIC1Gb3JjZQogICAgICAgIFNldC1JdGVtUHJvcGVydHkgLVBhdGggJFJlZ1BhdGggLU5hbWUgIlN5c3RlbVVzZXNMaWdodFRoZW1lIiAtVmFsdWUgMCAtRm9yY2UKICAgICAgICBXcml0ZS1DZW50ZXJlZCAiVGVtYSBPc2N1cm8gYXBsaWNhZG8uIiAiR3JlZW4iCiAgICB9IGNhdGNoIHsgV3JpdGUtQ2VudGVyZWQgIkVycm9yIGFsIGFwbGljYXIgdGVtYS4iICJSZWQiIH0KfQoKIyA0LiBDb2xvciBkZSBBY2VudG8gKFJlZ2lzdHJvIERXTSkKZnVuY3Rpb24gU2V0LUFjY2VudENvbG9yIHsKICAgICMgRXN0YWJsZWNlIHVuIGNvbG9yIENpYW4vVHVycXVlc2EgZXN0aWxvIEF0bGFzIChGb3JtYXRvIEFCR1IgRGVjaW1hbCBvIEhleCkKICAgIHRyeSB7CiAgICAgICAgJFJlZ1BhdGggPSAiSEtDVTpcU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3NcRFdNIgogICAgICAgICMgMHhmZmQ3MDAgZXMgZG9yYWRvIGVuIGZvcm1hdG8gRFdPUkQgKGVqZW1wbG8pCiAgICAgICAgU2V0LUl0ZW1Qcm9wZXJ0eSAtUGF0aCAkUmVnUGF0aCAtTmFtZSAiQWNjZW50Q29sb3IiIC1WYWx1ZSAweGZmZDcwMCAtRm9yY2UgCiAgICAgICAgU2V0LUl0ZW1Qcm9wZXJ0eSAtUGF0aCAkUmVnUGF0aCAtTmFtZSAiQ29sb3JQcmV2YWxlbmNlIiAtVmFsdWUgMSAtRm9yY2UKICAgICAgICBXcml0ZS1DZW50ZXJlZCAiQ29sb3IgZGUgYWNlbnRvIG1vZGlmaWNhZG8uIiAiR3JlZW4iCiAgICB9IGNhdGNoIHsgV3JpdGUtQ2VudGVyZWQgIkVycm9yIGVuIERXTS4iICJSZWQiIH0KfQoKIyA1LiBCYXJyYSBkZSBUYXJlYXMgKFJlZ2lzdHJvIEV4cGxvcmVyKQpmdW5jdGlvbiBPcHRpbWl6ZS1UYXNrYmFyIHsKICAgIHRyeSB7CiAgICAgICAgJFJlZ1BhdGggPSAiSEtDVTpcU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cRXhwbG9yZXJcQWR2YW5jZWQiCiAgICAgICAgIyBUYXNrYmFyQWw6IDAgPSBJenF1aWVyZGEsIDEgPSBDZW50cm8gKFdpbmRvd3MgMTEpCiAgICAgICAgU2V0LUl0ZW1Qcm9wZXJ0eSAtUGF0aCAkUmVnUGF0aCAtTmFtZSAiVGFza2JhckFsIiAtVmFsdWUgMCAtRm9yY2UKICAgICAgICAjIE9jdWx0YXIgaWNvbm9zIGRlIGJ1c3F1ZWRhIHBhcmEgbGltcGlhcgogICAgICAgIFNldC1JdGVtUHJvcGVydHkgLVBhdGggJFJlZ1BhdGggLU5hbWUgIlNlYXJjaGJveFRhc2tiYXJNb2RlIiAtVmFsdWUgMCAtRm9yY2UKICAgICAgICBXcml0ZS1DZW50ZXJlZCAiQ29uZmlndXJhY2lvbiBkZSBiYXJyYSBkZSB0YXJlYXMgYXBsaWNhZGEuIiAiR3JlZW4iCiAgICAgICAgV3JpdGUtQ2VudGVyZWQgIlJlaW5pY2lhbmRvIEV4cGxvcmVyLi4uIiAiWWVsbG93IgogICAgICAgIFN0b3AtUHJvY2VzcyAtTmFtZSAiZXhwbG9yZXIiIC1Gb3JjZQogICAgfSBjYXRjaCB7IFdyaXRlLUNlbnRlcmVkICJFcnJvciBlbiBUYXNrYmFyLiIgIlJlZCIgfQp9CgojIDYuIE1hcmNhIGRlIEFndWEgKFJlZ2lzdHJvIFNlZ3VybykKZnVuY3Rpb24gVG9nZ2xlLVdhdGVybWFyayB7CiAgICB0cnkgewogICAgICAgICRSZWdQYXRoID0gIkhLQ1U6XENvbnRyb2wgUGFuZWxcRGVza3RvcCIKICAgICAgICAjIFBhaW50RGVza3RvcFZlcnNpb246IDEgPSBNb3N0cmFyIHZlcnNpw7NuLCAwID0gT2N1bHRhcgogICAgICAgIFNldC1JdGVtUHJvcGVydHkgLVBhdGggJFJlZ1BhdGggLU5hbWUgIlBhaW50RGVza3RvcFZlcnNpb24iIC1WYWx1ZSAwIC1Gb3JjZQogICAgICAgIFdyaXRlLUNlbnRlcmVkICJNYXJjYSBkZSBhZ3VhIGRlc2hhYmlsaXRhZGEgKFJlcXVpZXJlIHJlaW5pY2lvKS4iICJHcmVlbiIKICAgIH0gY2F0Y2ggeyBXcml0ZS1DZW50ZXJlZCAiRXJyb3IgZW4gcmVnaXN0cm8uIiAiUmVkIiB9Cn0KCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgQlVDTEUgUFJJTkNJUEFMCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiRlamVjdXRhciA9ICR0cnVlCiMgTGEgdG9vbCBzZSBlamVjdXRhIGlubGluZSAobm8gZGVzZGUgdW4gLnBzMSBmaXNpY28pLCBhc2kgcXVlCiMgJE15SW52b2NhdGlvbi5NeUNvbW1hbmQuRGVmaW5pdGlvbiBkZXZ1ZWx2ZSBlbCBjdWVycG8gZGUgbGEgZnVuY2lvbi4KIyBCdXNjYXIgd2FsbHBhcGVyLmpwZyBlbiAlTE9DQUxBUFBEQVRBJVxBdGxhc1BDICh1YmljYWNpb24gZG9jdW1lbnRhZGEpLgokU2NyaXB0UGF0aCA9IGlmICgkZW52OkxPQ0FMQVBQREFUQSkgeyBKb2luLVBhdGggJGVudjpMT0NBTEFQUERBVEEgJ0F0bGFzUEMnIH0gZWxzZSB7ICRlbnY6VEVNUCB9CmlmICgtbm90IChUZXN0LVBhdGggJFNjcmlwdFBhdGgpKSB7IE5ldy1JdGVtIC1JdGVtVHlwZSBEaXJlY3RvcnkgLVBhdGggJFNjcmlwdFBhdGggLUZvcmNlIHwgT3V0LU51bGwgfQoKd2hpbGUgKCRlamVjdXRhcikgewogICAgU2hvdy1IZWFkZXIKICAgIFdyaXRlLUNlbnRlcmVkICJNRU5VIEFWQU5aQURPIERFIFBFUlNPTkFMSVpBQ0lPTiIgIkN5YW4iCiAgICBXcml0ZS1Ib3N0ICJgbiIKCiAgICAkTSA9ICIgIiAqIChbaW50XSgoJEhvc3QuVUkuUmF3VUkuV2luZG93U2l6ZS5XaWR0aCAvIDIpIC0gMjApKQogICAgCiAgICBXcml0ZS1Ib3N0ICIkTSBbMV0gQ2FtYmlhciBGb25kbyAoV2FsbHBhcGVyLmpwZyBsb2NhbCkiCiAgICBXcml0ZS1Ib3N0ICIkTSBbMl0gRm9yemFyIFRlbWEgT3NjdXJvIChBcHBzICYgU2lzdGVtYSkiCiAgICBXcml0ZS1Ib3N0ICIkTSBbM10gQXBsaWNhciBDb2xvciBBY2VudG8gQVRMQVMgKERvcmFkbykiCiAgICBXcml0ZS1Ib3N0ICIkTSBbNF0gQWxpbmVhciBCYXJyYSBUYXJlYXMgYSBsYSBJenF1aWVyZGEiCiAgICBXcml0ZS1Ib3N0ICIkTSBbNV0gT2N1bHRhciBNYXJjYSBkZSBBZ3VhIChQYWludERlc2t0b3ApIgogICAgV3JpdGUtSG9zdCAiJE0gWzZdIENvbmZpZ3VyYXIgTWVudSBJbmljaW8gKExpbXBpZXphKSIKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtSG9zdCAiJE0gWzBdIFZvbHZlciAvIFNhbGlyIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgIlNlbGVjY2lvbmUgb3BjaW9uOiIgIkdyYXkiCgogICAgJHNlbCA9IFJlYWQtSG9zdAoKICAgIHN3aXRjaCAoJHNlbCkgewogICAgICAgICcxJyB7IAogICAgICAgICAgICAjIEJ1c2NhIHVuYSBpbWFnZW4gbGxhbWFkYSAnd2FsbHBhcGVyLmpwZycgZW4gbGEgbWlzbWEgY2FycGV0YSBkZWwgc2NyaXB0CiAgICAgICAgICAgIFNldC1BdGxhc1dhbGxwYXBlciAtUGF0aEltYWdlbiAiJFNjcmlwdFBhdGhcd2FsbHBhcGVyLmpwZyIgCiAgICAgICAgICAgIFN0YXJ0LVNsZWVwIDIKICAgICAgICB9CiAgICAgICAgJzInIHsgU2V0LURhcmtUaGVtZTsgU3RhcnQtU2xlZXAgMSB9CiAgICAgICAgJzMnIHsgU2V0LUFjY2VudENvbG9yOyBTdGFydC1TbGVlcCAxIH0KICAgICAgICAnNCcgeyBPcHRpbWl6ZS1UYXNrYmFyOyBTdGFydC1TbGVlcCAyIH0KICAgICAgICAnNScgeyBUb2dnbGUtV2F0ZXJtYXJrOyBTdGFydC1TbGVlcCAxIH0KICAgICAgICAnNicgewogICAgICAgICAgICAgIyBFamVtcGxvIHNpbXBsZSBwYXJhIE1lbnUgSW5pY2lvCiAgICAgICAgICAgICBTZXQtSXRlbVByb3BlcnR5IC1QYXRoICJIS0NVOlxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxBZHZhbmNlZCIgLU5hbWUgIlN0YXJ0X1RyYWNrUHJvZ3MiIC1WYWx1ZSAwIC1Gb3JjZQogICAgICAgICAgICAgV3JpdGUtQ2VudGVyZWQgIlN1Z2VyZW5jaWFzIGRlIGluaWNpbyBkZXNoYWJpbGl0YWRhcy4iICJHcmVlbiIKICAgICAgICAgICAgIFN0YXJ0LVNsZWVwIDEKICAgICAgICB9CiAgICAgICAgJzAnIHsgJGVqZWN1dGFyID0gJGZhbHNlIH0KICAgIH0KfQp9Cg=='
$script:AtlasToolSources['Invoke-Robocopy'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtUm9ib2NvcHkKIyBNaWdyYWRvIGRlOiBSb2JvY29weS5wczEKIyBBdGxhcyBQQyBTdXBwb3J0IOKAlCB2MS4wCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBJbnZva2UtUm9ib2NvcHkgewogICAgW0NtZGxldEJpbmRpbmcoKV0KICAgIHBhcmFtKCkKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojIEFUTEFTIFBDIFNVUFBPUlQgLSBDT1BJQSBJTlRFTElHRU5URSB2OCAoUG93ZXJTaGVsbCkKIyBBdXRvLWRldGVjdCArIE1ENSArIFNwZWVkICsgRVRBICsgRXhjbHVzaW9uZXMgKyBNb2RvcwojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgojIFNJTiBhdXRvLWVsZXZhY2nDs246IHJvYm9jb3B5IG5vIG5lY2VzaXRhIGFkbWluCiMgeSBsYSBlbGV2YWNpw7NuIEJMT1FVRUEgZWwgZHJhZy1hbmQtZHJvcCBkZSBXaW5kb3dzCgokSG9zdC5VSS5SYXdVSS5CYWNrZ3JvdW5kQ29sb3IgPSAiQmxhY2siCiRIb3N0LlVJLlJhd1VJLkZvcmVncm91bmRDb2xvciA9ICJHcmF5IgokSG9zdC5VSS5SYXdVSS5XaW5kb3dUaXRsZSA9ICJBVExBUyBQQyBTVVBQT1JUIC0gQ29waWEgSW50ZWxpZ2VudGUgdjgiCnRyeSB7ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUgPSBOZXctT2JqZWN0IFN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uSG9zdC5TaXplKDExMCwgNDUpIH0gY2F0Y2gge30KJEVycm9yQWN0aW9uUHJlZmVyZW5jZSA9ICJDb250aW51ZSIKCiMgPT09PT09PT09PT09PT09PT09PT0gRlVOQ0lPTkVTID09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBXcml0ZS1DZW50ZXJlZCB7CiAgICBwYXJhbSAoW3N0cmluZ10kVGV4dCwgW3N0cmluZ10kQ29sb3IgPSAiV2hpdGUiKQogICAgJFcgPSB0cnkgeyAkSG9zdC5VSS5SYXdVSS5XaW5kb3dTaXplLldpZHRoIH0gY2F0Y2ggeyA4MCB9CiAgICAkUGFkID0gW21hdGhdOjpNYXgoMCwgW21hdGhdOjpGbG9vcigoJFcgLSAkVGV4dC5MZW5ndGgpIC8gMikpCiAgICBXcml0ZS1Ib3N0ICgiICIgKiAkUGFkICsgJFRleHQpIC1Gb3JlZ3JvdW5kQ29sb3IgJENvbG9yCn0KCmZ1bmN0aW9uIENsZWFuLVBhdGggewogICAgcGFyYW0oW3N0cmluZ10kUmF3UGF0aCkKICAgIHJldHVybiAkUmF3UGF0aC5UcmltKCkuVHJpbSgnIicpLlRyaW0oIiciKS5UcmltRW5kKCdcJykKfQoKZnVuY3Rpb24gRm9ybWF0LVNpemUgewogICAgcGFyYW0oW2xvbmddJEJ5dGVzKQogICAgaWYgKCRCeXRlcyAtZ2UgMUdCKSB7IHJldHVybiAiezA6TjJ9IEdCIiAtZiAoJEJ5dGVzIC8gMUdCKSB9CiAgICBpZiAoJEJ5dGVzIC1nZSAxTUIpIHsgcmV0dXJuICJ7MDpOMX0gTUIiIC1mICgkQnl0ZXMgLyAxTUIpIH0KICAgIGlmICgkQnl0ZXMgLWdlIDFLQikgeyByZXR1cm4gInswOk4wfSBLQiIgLWYgKCRCeXRlcyAvIDFLQikgfQogICAgcmV0dXJuICIkQnl0ZXMgQiIKfQoKZnVuY3Rpb24gRm9ybWF0LUR1cmF0aW9uIHsKICAgIHBhcmFtKFtUaW1lU3Bhbl0kRHVyYXRpb24pCiAgICBpZiAoJER1cmF0aW9uLlRvdGFsSG91cnMgLWdlIDEpIHsgcmV0dXJuICJ7MH1oIHsxfW0gezJ9cyIgLWYgW2ludF0kRHVyYXRpb24uVG90YWxIb3VycywgJER1cmF0aW9uLk1pbnV0ZXMsICREdXJhdGlvbi5TZWNvbmRzIH0KICAgIGlmICgkRHVyYXRpb24uVG90YWxNaW51dGVzIC1nZSAxKSB7IHJldHVybiAiezB9bSB7MX1zIiAtZiBbaW50XSREdXJhdGlvbi5Ub3RhbE1pbnV0ZXMsICREdXJhdGlvbi5TZWNvbmRzIH0KICAgIHJldHVybiAiezA6TjF9cyIgLWYgJER1cmF0aW9uLlRvdGFsU2Vjb25kcwp9CgpmdW5jdGlvbiBHZXQtRm9sZGVyU3RhdHMgewogICAgcGFyYW0oW3N0cmluZ10kUGF0aCkKICAgICRpdGVtcyA9IEdldC1DaGlsZEl0ZW0gLVBhdGggJFBhdGggLVJlY3Vyc2UgLUZpbGUgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICR0b3RhbFNpemUgPSAoJGl0ZW1zIHwgTWVhc3VyZS1PYmplY3QgTGVuZ3RoIC1TdW0gLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUpLlN1bQogICAgaWYgKC1ub3QgJHRvdGFsU2l6ZSkgeyAkdG90YWxTaXplID0gMCB9CiAgICByZXR1cm4gQHsgRmlsZXMgPSAkaXRlbXMuQ291bnQ7IFNpemUgPSAkdG90YWxTaXplOyBTaXplTUIgPSBbbWF0aF06OlJvdW5kKCR0b3RhbFNpemUgLyAxTUIsIDEpIH0KfQoKZnVuY3Rpb24gRGV0ZWN0LURyaXZlVHlwZSB7CiAgICBwYXJhbShbc3RyaW5nXSREcml2ZUxldHRlcikKICAgICRsZXR0ZXIgPSAkRHJpdmVMZXR0ZXIuVHJpbUVuZCgnOicsICdcJykKICAgIHRyeSB7CiAgICAgICAgJHZvbCA9IEdldC1Wb2x1bWUgLURyaXZlTGV0dGVyICRsZXR0ZXIgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICBpZiAoJHZvbC5Ecml2ZVR5cGUgLWVxICdSZW1vdmFibGUnKSB7CiAgICAgICAgICAgIHJldHVybiBAeyBUeXBlID0gIlVTQiI7IE1UID0gMjsgRGVzYyA9ICJVU0IgUmVtb3ZpYmxlIjsgQ29sb3IgPSAiWWVsbG93IjsgTGFiZWwgPSAkdm9sLkZpbGVTeXN0ZW1MYWJlbDsgRnJlZUJ5dGVzID0gJHZvbC5TaXplUmVtYWluaW5nIH0KICAgICAgICB9CiAgICAgICAgJHBhcnQgPSBHZXQtUGFydGl0aW9uIC1Ecml2ZUxldHRlciAkbGV0dGVyIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgJGRpc2sgPSBHZXQtRGlzayAtTnVtYmVyICRwYXJ0LkRpc2tOdW1iZXIgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAkcGh5cyA9IEdldC1QaHlzaWNhbERpc2sgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUgfCBXaGVyZS1PYmplY3QgeyAkXy5EZXZpY2VJZCAtZXEgJGRpc2suTnVtYmVyLlRvU3RyaW5nKCkgfQoKICAgICAgICBpZiAoJGRpc2suQnVzVHlwZSAtZXEgJ1VTQicpIHsKICAgICAgICAgICAgcmV0dXJuIEB7IFR5cGUgPSAiVVNCIjsgTVQgPSAyOyBEZXNjID0gIlVTQiBFeHRlcm5vIjsgQ29sb3IgPSAiWWVsbG93IjsgTGFiZWwgPSAkdm9sLkZpbGVTeXN0ZW1MYWJlbDsgRnJlZUJ5dGVzID0gJHZvbC5TaXplUmVtYWluaW5nIH0KICAgICAgICB9CiAgICAgICAgaWYgKCRkaXNrLkJ1c1R5cGUgLWVxICdOVk1lJyAtb3IgKCRwaHlzIC1hbmQgJHBoeXMuTWVkaWFUeXBlIC1tYXRjaCAnU1NEJykpIHsKICAgICAgICAgICAgcmV0dXJuIEB7IFR5cGUgPSAiU1NEIjsgTVQgPSAzMjsgRGVzYyA9ICJTU0QvTlZNZSI7IENvbG9yID0gIkdyZWVuIjsgTGFiZWwgPSAkdm9sLkZpbGVTeXN0ZW1MYWJlbDsgRnJlZUJ5dGVzID0gJHZvbC5TaXplUmVtYWluaW5nIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIEB7IFR5cGUgPSAiSEREIjsgTVQgPSA4OyBEZXNjID0gIkhERCBNZWNhbmljbyI7IENvbG9yID0gIkN5YW4iOyBMYWJlbCA9ICR2b2wuRmlsZVN5c3RlbUxhYmVsOyBGcmVlQnl0ZXMgPSAkdm9sLlNpemVSZW1haW5pbmcgfQogICAgfSBjYXRjaCB7CiAgICAgICAgcmV0dXJuIEB7IFR5cGUgPSAiVU5LTk9XTiI7IE1UID0gODsgRGVzYyA9ICJObyBkZXRlY3RhZG8iOyBDb2xvciA9ICJHcmF5IjsgTGFiZWwgPSAiIjsgRnJlZUJ5dGVzID0gMCB9CiAgICB9Cn0KCiMgPT09PT09PT09PT09PT09PT09PT0gRVhQTE9SQURPUiBERSBBUkNISVZPUyAoYWx0ZXJuYXRpdmEgYSBkcmFnLWRyb3ApID09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBTZWxlY3QtRm9sZGVyRGlhbG9nIHsKICAgIHBhcmFtKFtzdHJpbmddJERlc2NyaXB0aW9uID0gIlNlbGVjY2lvbmEgdW5hIGNhcnBldGEiKQogICAgQWRkLVR5cGUgLUFzc2VtYmx5TmFtZSBTeXN0ZW0uV2luZG93cy5Gb3JtcyAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgJGRpYWxvZyA9IE5ldy1PYmplY3QgU3lzdGVtLldpbmRvd3MuRm9ybXMuRm9sZGVyQnJvd3NlckRpYWxvZwogICAgJGRpYWxvZy5EZXNjcmlwdGlvbiA9ICREZXNjcmlwdGlvbgogICAgJGRpYWxvZy5TaG93TmV3Rm9sZGVyQnV0dG9uID0gJHRydWUKICAgICRyZXN1bHQgPSAkZGlhbG9nLlNob3dEaWFsb2coKQogICAgaWYgKCRyZXN1bHQgLWVxIFtTeXN0ZW0uV2luZG93cy5Gb3Jtcy5EaWFsb2dSZXN1bHRdOjpPSykgewogICAgICAgIHJldHVybiAkZGlhbG9nLlNlbGVjdGVkUGF0aAogICAgfQogICAgcmV0dXJuICRudWxsCn0KCmZ1bmN0aW9uIFNlbGVjdC1GaWxlRGlhbG9nIHsKICAgIHBhcmFtKFtzdHJpbmddJFRpdGxlID0gIlNlbGVjY2lvbmEgdW4gYXJjaGl2byIpCiAgICBBZGQtVHlwZSAtQXNzZW1ibHlOYW1lIFN5c3RlbS5XaW5kb3dzLkZvcm1zIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlCiAgICAkZGlhbG9nID0gTmV3LU9iamVjdCBTeXN0ZW0uV2luZG93cy5Gb3Jtcy5PcGVuRmlsZURpYWxvZwogICAgJGRpYWxvZy5UaXRsZSA9ICRUaXRsZQogICAgJGRpYWxvZy5GaWx0ZXIgPSAiVG9kb3MgbG9zIGFyY2hpdm9zICgqLiopfCouKiIKICAgICRkaWFsb2cuTXVsdGlzZWxlY3QgPSAkZmFsc2UKICAgICRyZXN1bHQgPSAkZGlhbG9nLlNob3dEaWFsb2coKQogICAgaWYgKCRyZXN1bHQgLWVxIFtTeXN0ZW0uV2luZG93cy5Gb3Jtcy5EaWFsb2dSZXN1bHRdOjpPSykgewogICAgICAgIHJldHVybiAkZGlhbG9nLkZpbGVOYW1lCiAgICB9CiAgICByZXR1cm4gJG51bGwKfQoKZnVuY3Rpb24gR2V0LVBhdGhGcm9tVXNlciB7CiAgICBwYXJhbShbc3RyaW5nXSRQcm9tcHQgPSAiT1JJR0VOIiwgW3N0cmluZ10kTW9kZSA9ICJhbnkiKQogICAgCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgIEFSUkFTVFJBIGFxdWksIGVzY3JpYmUgbGEgcnV0YSwgbyB1c2EgZWwgZXhwbG9yYWRvcjoiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiAgICAgIFtFXSBBYnJpciBleHBsb3JhZG9yIGRlIGFyY2hpdm9zIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIFdyaXRlLUhvc3QgIiAgICAgIFtCXSBWb2x2ZXIgIFtTXSBTYWxpciIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgV3JpdGUtSG9zdCAiIgogICAgJGlucHV0ID0gUmVhZC1Ib3N0ICIgICAgICAke1Byb21wdH0iCiAgICAKICAgIGlmICgkaW5wdXQgLWVxICJTIiAtb3IgJGlucHV0IC1lcSAicyIpIHsgcmV0dXJuICJFWElUIiB9CiAgICBpZiAoJGlucHV0IC1lcSAiQiIgLW9yICRpbnB1dCAtZXEgImIiKSB7IHJldHVybiAiQkFDSyIgfQogICAgCiAgICBpZiAoJGlucHV0IC1lcSAiRSIgLW9yICRpbnB1dCAtZXEgImUiKSB7CiAgICAgICAgaWYgKCRNb2RlIC1lcSAiZm9sZGVyIikgewogICAgICAgICAgICAkcGF0aCA9IFNlbGVjdC1Gb2xkZXJEaWFsb2cgLURlc2NyaXB0aW9uICJTZWxlY2Npb25hIGNhcnBldGEgZGUgJHtQcm9tcHR9IgogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICMgUHJlZ3VudGFyIHNpIGNhcnBldGEgbyBhcmNoaXZvCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFsxXSBDYXJwZXRhICBbMl0gQXJjaGl2byIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgICAgICAkdGlwbyA9IFJlYWQtSG9zdCAiICAgICAgPiIKICAgICAgICAgICAgaWYgKCR0aXBvIC1lcSAiMiIpIHsKICAgICAgICAgICAgICAgICRwYXRoID0gU2VsZWN0LUZpbGVEaWFsb2cgLVRpdGxlICJTZWxlY2Npb25hIGFyY2hpdm8iCiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAkcGF0aCA9IFNlbGVjdC1Gb2xkZXJEaWFsb2cgLURlc2NyaXB0aW9uICJTZWxlY2Npb25hIGNhcnBldGEiCiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgaWYgKC1ub3QgJHBhdGgpIHsgcmV0dXJuICJCQUNLIiB9CiAgICAgICAgcmV0dXJuICRwYXRoCiAgICB9CiAgICAKICAgIHJldHVybiBDbGVhbi1QYXRoICRpbnB1dAp9CgojID09PT09PT09PT09PT09PT09PT09IFZFUklGSUNBQ0nDk04gTUQ1ID09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBUZXN0LUNvcHlJbnRlZ3JpdHkgewogICAgcGFyYW0oW3N0cmluZ10kT3JpZ2VuLCBbc3RyaW5nXSREZXN0aW5vLCBbaW50XSRTYW1wbGVTaXplID0gMTUpCgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtQ2VudGVyZWQgIlZFUklGSUNBTkRPIElOVEVHUklEQUQuLi4iICJZZWxsb3ciCiAgICBXcml0ZS1Ib3N0ICIiCgogICAgJHNyY1N0YXRzID0gR2V0LUZvbGRlclN0YXRzICRPcmlnZW4KICAgICRkc3RTdGF0cyA9IEdldC1Gb2xkZXJTdGF0cyAkRGVzdGlubwoKICAgIFdyaXRlLUhvc3QgIiAgICBBcmNoaXZvcyAtIE9yaWdlbjogJCgkc3JjU3RhdHMuRmlsZXMpIHwgRGVzdGlubzogJCgkZHN0U3RhdHMuRmlsZXMpIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgIFdyaXRlLUhvc3QgIiAgICBUYW1hbm8gICAtIE9yaWdlbjogJChGb3JtYXQtU2l6ZSAkc3JjU3RhdHMuU2l6ZSkgfCBEZXN0aW5vOiAkKEZvcm1hdC1TaXplICRkc3RTdGF0cy5TaXplKSIgLUZvcmVncm91bmRDb2xvciBHcmF5CgogICAgJGNvdW50TWF0Y2ggPSAoJHNyY1N0YXRzLkZpbGVzIC1lcSAkZHN0U3RhdHMuRmlsZXMpCiAgICAkY291bnRDb2xvciA9IGlmICgkY291bnRNYXRjaCkgeyAiR3JlZW4iIH0gZWxzZSB7ICJZZWxsb3ciIH0KICAgIFdyaXRlLUhvc3QgIiAgICBDb250ZW86ICAkKGlmICgkY291bnRNYXRjaCkgeyAnQ09JTkNJREUnIH0gZWxzZSB7ICdESUZFUkVOVEUgKG5vcm1hbCBzaSBzZSBleGNsdXllcm9uIGFyY2hpdm9zKScgfSkiIC1Gb3JlZ3JvdW5kQ29sb3IgJGNvdW50Q29sb3IKCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICAgVmVyaWZpY2FjaW9uIE1ENSAobXVlc3RyYSBkZSAke1NhbXBsZVNpemV9KS4uLiIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgICRzcmNGaWxlcyA9IEdldC1DaGlsZEl0ZW0gLVBhdGggJE9yaWdlbiAtUmVjdXJzZSAtRmlsZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgaWYgKC1ub3QgJHNyY0ZpbGVzIC1vciAkc3JjRmlsZXMuQ291bnQgLWVxIDApIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgU2luIGFyY2hpdm9zIHBhcmEgdmVyaWZpY2FyLiIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICAgICAgcmV0dXJuIEB7IE9LID0gJHRydWU7IENoZWNrZWQgPSAwOyBQYXNzZWQgPSAwOyBGYWlsZWQgPSAwOyBNaXNzaW5nID0gMCB9CiAgICB9CgogICAgJGJ5U2l6ZSA9ICRzcmNGaWxlcyB8IFNvcnQtT2JqZWN0IExlbmd0aCAtRGVzY2VuZGluZyB8IFNlbGVjdC1PYmplY3QgLUZpcnN0IDUKICAgICRieURhdGUgPSAkc3JjRmlsZXMgfCBTb3J0LU9iamVjdCBMYXN0V3JpdGVUaW1lIC1EZXNjZW5kaW5nIHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgNQogICAgJHJhbmRvbUNvdW50ID0gW21hdGhdOjpNaW4oW21hdGhdOjpNYXgoMSwgJFNhbXBsZVNpemUgLSAxMCksICRzcmNGaWxlcy5Db3VudCkKICAgICRyYW5kb20gPSAkc3JjRmlsZXMgfCBHZXQtUmFuZG9tIC1Db3VudCAkcmFuZG9tQ291bnQKICAgICRzYW1wbGUgPSBAKCRieVNpemUpICsgQCgkYnlEYXRlKSArIEAoJHJhbmRvbSkgfCBTb3J0LU9iamVjdCBGdWxsTmFtZSAtVW5pcXVlIHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgJFNhbXBsZVNpemUKCiAgICAkY2hlY2tlZCA9IDA7ICRwYXNzZWQgPSAwOyAkZmFpbGVkID0gMDsgJG1pc3NpbmcgPSAwOyAkZmFpbGVkRmlsZXMgPSBAKCkKCiAgICBmb3JlYWNoICgkc3JjRmlsZSBpbiAkc2FtcGxlKSB7CiAgICAgICAgJGNoZWNrZWQrKwogICAgICAgICRyZWxQYXRoID0gJHNyY0ZpbGUuRnVsbE5hbWUuU3Vic3RyaW5nKCRPcmlnZW4uTGVuZ3RoKS5UcmltU3RhcnQoJ1wnKQogICAgICAgICRkc3RGaWxlID0gSm9pbi1QYXRoICREZXN0aW5vICRyZWxQYXRoCgogICAgICAgICRwY3QgPSBbbWF0aF06OlJvdW5kKCgkY2hlY2tlZCAvICRzYW1wbGUuQ291bnQpICogMTAwLCAwKQogICAgICAgIFdyaXRlLUhvc3QgImByICAgIFske3BjdH0lXSBWZXJpZmljYW5kbyAke2NoZWNrZWR9LyQoJHNhbXBsZS5Db3VudCkuLi4iIC1Ob05ld2xpbmUgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQoKICAgICAgICBpZiAoLW5vdCAoVGVzdC1QYXRoICRkc3RGaWxlKSkgewogICAgICAgICAgICAkbWlzc2luZysrOyAkZmFpbGVkRmlsZXMgKz0gIkZBTFRBOiAke3JlbFBhdGh9IjsgY29udGludWUKICAgICAgICB9CiAgICAgICAgdHJ5IHsKICAgICAgICAgICAgJGhhc2hTcmMgPSAoR2V0LUZpbGVIYXNoIC1QYXRoICRzcmNGaWxlLkZ1bGxOYW1lIC1BbGdvcml0aG0gTUQ1IC1FcnJvckFjdGlvbiBTdG9wKS5IYXNoCiAgICAgICAgICAgICRoYXNoRHN0ID0gKEdldC1GaWxlSGFzaCAtUGF0aCAkZHN0RmlsZSAtQWxnb3JpdGhtIE1ENSAtRXJyb3JBY3Rpb24gU3RvcCkuSGFzaAogICAgICAgICAgICBpZiAoJGhhc2hTcmMgLWVxICRoYXNoRHN0KSB7ICRwYXNzZWQrKyB9CiAgICAgICAgICAgIGVsc2UgeyAkZmFpbGVkKys7ICRmYWlsZWRGaWxlcyArPSAiQ09SUlVQVE86ICR7cmVsUGF0aH0iIH0KICAgICAgICB9IGNhdGNoIHsgJGZhaWxlZCsrOyAkZmFpbGVkRmlsZXMgKz0gIkVSUk9SOiAke3JlbFBhdGh9IiB9CiAgICB9CgogICAgV3JpdGUtSG9zdCAiIjsgV3JpdGUtSG9zdCAiIgoKICAgIGlmICgkZmFpbGVkIC1lcSAwIC1hbmQgJG1pc3NpbmcgLWVxIDApIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW09LXSBJTlRFR1JJREFEIE1ENTogJHtwYXNzZWR9LyR7Y2hlY2tlZH0gYXJjaGl2b3MgdmVyaWZpY2Fkb3MiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgIH0gZWxzZSB7CiAgICAgICAgV3JpdGUtSG9zdCAiICAgIFshIV0gUFJPQkxFTUFTOiBPSz0ke3Bhc3NlZH0gfCBGQUxMT1M9JHtmYWlsZWR9IHwgRkFMVEFOVEVTPSR7bWlzc2luZ30iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgZm9yZWFjaCAoJGYgaW4gJGZhaWxlZEZpbGVzKSB7IFdyaXRlLUhvc3QgIiAgICAgICAgICRmIiAtRm9yZWdyb3VuZENvbG9yIFJlZCB9CiAgICB9CgogICAgcmV0dXJuIEB7IE9LID0gKCRmYWlsZWQgLWVxIDAgLWFuZCAkbWlzc2luZyAtZXEgMCk7IENoZWNrZWQgPSAkY2hlY2tlZDsgUGFzc2VkID0gJHBhc3NlZDsgRmFpbGVkID0gJGZhaWxlZDsgTWlzc2luZyA9ICRtaXNzaW5nIH0KfQoKIyA9PT09PT09PT09PT09PT09PT09PSBDT1BJQSBDT04gTU9OSVRPUkVPID09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBTdGFydC1TbWFydENvcHkgewogICAgcGFyYW0oCiAgICAgICAgW3N0cmluZ10kT3JpZ2VuLCBbc3RyaW5nXSREZXN0aW5vLCBbYm9vbF0kSXNGaWxlLCBbc3RyaW5nXSRGaWxlTmFtZSwKICAgICAgICBbaW50XSRNVCwgW3N0cmluZ10kRGlza1R5cGUsIFtzdHJpbmddJE1vZGUsCiAgICAgICAgW2FycmF5XSRFeGNsdWRlRGlycywgW2FycmF5XSRFeGNsdWRlRmlsZXMKICAgICkKCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1DZW50ZXJlZCAiQ09QSUFORE8uLi4gKCR7RGlza1R5cGV9IHwgTVQ6JHtNVH0gfCAke01vZGV9KSIgIlllbGxvdyIKICAgIFdyaXRlLUhvc3QgIiIKCiAgICAkc3cgPSBbU3lzdGVtLkRpYWdub3N0aWNzLlN0b3B3YXRjaF06OlN0YXJ0TmV3KCkKCiAgICAkcm9ib0FyZ3MgPSBAKCkKICAgIGlmICgkSXNGaWxlKSB7CiAgICAgICAgJHNyY0RpciA9IFNwbGl0LVBhdGggJE9yaWdlbiAtUGFyZW50CiAgICAgICAgJHJvYm9BcmdzICs9ICJgIiR7c3JjRGlyfWAiIgogICAgICAgICRyb2JvQXJncyArPSAiYCIke0Rlc3Rpbm99YCIiCiAgICAgICAgJHJvYm9BcmdzICs9ICJgIiR7RmlsZU5hbWV9YCIiCiAgICB9IGVsc2UgewogICAgICAgICRyb2JvQXJncyArPSAiYCIke09yaWdlbn1gIiIKICAgICAgICAkcm9ib0FyZ3MgKz0gImAiJHtEZXN0aW5vfWAiIgogICAgICAgICRyb2JvQXJncyArPSAiL0UiCiAgICB9CgogICAgJHJvYm9BcmdzICs9ICIvSiI7ICRyb2JvQXJncyArPSAiL01UOiR7TVR9IjsgJHJvYm9BcmdzICs9ICIvUjoyIjsgJHJvYm9BcmdzICs9ICIvVzoyIgogICAgJHJvYm9BcmdzICs9ICIvRkZUIjsgJHJvYm9BcmdzICs9ICIvRVRBIjsgJHJvYm9BcmdzICs9ICIvTlAiOyAkcm9ib0FyZ3MgKz0gIi9URUUiOyAkcm9ib0FyZ3MgKz0gIi9EQ09QWTpEQVQiCgogICAgaWYgKC1ub3QgJElzRmlsZSkgewogICAgICAgICRyb2JvQXJncyArPSAiL1hKIgogICAgICAgIGlmICgkTW9kZSAtZXEgIklOQ1JFTUVOVEFMIikgeyAkcm9ib0FyZ3MgKz0gIi9YTyIgfQogICAgfQoKICAgICRsb2dGaWxlID0gSm9pbi1QYXRoIChbRW52aXJvbm1lbnRdOjpHZXRGb2xkZXJQYXRoKCJEZXNrdG9wIikpICJMb2dfQXRsYXNfJChHZXQtRGF0ZSAtRm9ybWF0ICd5eXl5LU1NLWRkX0hIbW0nKS50eHQiCiAgICAkcm9ib0FyZ3MgKz0gIi9MT0crOmAiJHtsb2dGaWxlfWAiIgoKICAgICRkZWZhdWx0WEQgPSBAKCJTeXN0ZW0gVm9sdW1lIEluZm9ybWF0aW9uIiwgImAkUkVDWUNMRS5CSU4iLCAiUmVjb3ZlcnkiKQogICAgJGFsbFhEID0gJGRlZmF1bHRYRCArICRFeGNsdWRlRGlycwogICAgaWYgKCRhbGxYRC5Db3VudCAtZ3QgMCAtYW5kIC1ub3QgJElzRmlsZSkgewogICAgICAgICRyb2JvQXJncyArPSAiL1hEIgogICAgICAgIGZvcmVhY2ggKCR4ZCBpbiAkYWxsWEQpIHsgJHJvYm9BcmdzICs9ICJgIiR7eGR9YCIiIH0KICAgIH0KCiAgICAkZGVmYXVsdFhGID0gQCgiUGFnZWZpbGUuc3lzIiwgIkhpYmVyZmlsLnN5cyIsICJzd2FwZmlsZS5zeXMiLCAiVGh1bWJzLmRiIikKICAgICRhbGxYRiA9ICRkZWZhdWx0WEYgKyAkRXhjbHVkZUZpbGVzCiAgICBpZiAoJGFsbFhGLkNvdW50IC1ndCAwIC1hbmQgLW5vdCAkSXNGaWxlKSB7CiAgICAgICAgJHJvYm9BcmdzICs9ICIvWEYiCiAgICAgICAgZm9yZWFjaCAoJHhmIGluICRhbGxYRikgeyAkcm9ib0FyZ3MgKz0gImAiJHt4Zn1gIiIgfQogICAgfQoKICAgICRhcmdTdHJpbmcgPSAkcm9ib0FyZ3MgLWpvaW4gIiAiCgogICAgJHByZVNpemUgPSAwCiAgICBpZiAoVGVzdC1QYXRoICREZXN0aW5vKSB7CiAgICAgICAgdHJ5IHsgJHByZVNpemUgPSAoR2V0LUNoaWxkSXRlbSAkRGVzdGlubyAtUmVjdXJzZSAtRmlsZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSB8IE1lYXN1cmUtT2JqZWN0IExlbmd0aCAtU3VtKS5TdW0gfSBjYXRjaCB7fQogICAgICAgIGlmICgtbm90ICRwcmVTaXplKSB7ICRwcmVTaXplID0gMCB9CiAgICB9CgogICAgJHByb2Nlc3MgPSBTdGFydC1Qcm9jZXNzIC1GaWxlUGF0aCAicm9ib2NvcHkiIC1Bcmd1bWVudExpc3QgJGFyZ1N0cmluZyAtTm9OZXdXaW5kb3cgLVBhc3NUaHJ1IC1XYWl0CiAgICAkZXhpdENvZGUgPSAkcHJvY2Vzcy5FeGl0Q29kZQogICAgJHN3LlN0b3AoKTsgJGVsYXBzZWQgPSAkc3cuRWxhcHNlZAoKICAgICRwb3N0U2l6ZSA9IDAKICAgIGlmIChUZXN0LVBhdGggJERlc3Rpbm8pIHsKICAgICAgICB0cnkgeyAkcG9zdFNpemUgPSAoR2V0LUNoaWxkSXRlbSAkRGVzdGlubyAtUmVjdXJzZSAtRmlsZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSB8IE1lYXN1cmUtT2JqZWN0IExlbmd0aCAtU3VtKS5TdW0gfSBjYXRjaCB7fQogICAgICAgIGlmICgtbm90ICRwb3N0U2l6ZSkgeyAkcG9zdFNpemUgPSAwIH0KICAgIH0KICAgICRieXRlc0NvcGllZCA9IFttYXRoXTo6TWF4KDAsICRwb3N0U2l6ZSAtICRwcmVTaXplKQogICAgJHNwZWVkTUJwcyA9IGlmICgkZWxhcHNlZC5Ub3RhbFNlY29uZHMgLWd0IDApIHsgW21hdGhdOjpSb3VuZCgoJGJ5dGVzQ29waWVkIC8gMU1CKSAvICRlbGFwc2VkLlRvdGFsU2Vjb25kcywgMSkgfSBlbHNlIHsgMCB9CgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICAgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAkcmVzdWx0TXNnID0gc3dpdGNoICgkZXhpdENvZGUpIHsKICAgICAgICAwIHsgIlNJTiBDQU1CSU9TIC0gVG9kbyB5YSBlc3RhYmEgY29waWFkbyIgfQogICAgICAgIDEgeyAiQ09QSUFETyBFWElUT1NBTUVOVEUiIH0KICAgICAgICAyIHsgIkFyY2hpdm9zIGV4dHJhcyBlbiBkZXN0aW5vIiB9CiAgICAgICAgMyB7ICJDb3BpYWRvICsgZXh0cmFzIGVuIGRlc3Rpbm8iIH0KICAgICAgICA0IHsgIkFsZ3Vub3MgYXJjaGl2b3Mgbm8gY29pbmNpZGVuIiB9CiAgICAgICAgNSB7ICJDb3BpYWRvICsgbm8gY29pbmNpZGVuY2lhcyIgfQogICAgICAgIGRlZmF1bHQgeyBpZiAoJGV4aXRDb2RlIC1sZSA3KSB7ICJDb21wbGV0YWRvIChjb2RpZ28gJHtleGl0Q29kZX0pIiB9IGVsc2UgeyAiRVJST1IgKGNvZGlnbyAke2V4aXRDb2RlfSkiIH0gfQogICAgfQogICAgJHJlc3VsdENvbG9yID0gaWYgKCRleGl0Q29kZSAtbGUgMykgeyAiR3JlZW4iIH0gZWxzZWlmICgkZXhpdENvZGUgLWxlIDcpIHsgIlllbGxvdyIgfSBlbHNlIHsgIlJlZCIgfQoKICAgIFdyaXRlLUhvc3QgIiAgICBSRVNVTFRBRE86ICR7cmVzdWx0TXNnfSIgLUZvcmVncm91bmRDb2xvciAkcmVzdWx0Q29sb3IKICAgIFdyaXRlLUhvc3QgIiAgICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICAgIFRpZW1wbzogICAgJChGb3JtYXQtRHVyYXRpb24gJGVsYXBzZWQpIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgIFdyaXRlLUhvc3QgIiAgICBDb3BpYWRvOiAgICQoRm9ybWF0LVNpemUgJGJ5dGVzQ29waWVkKSIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgVmVsb2NpZGFkOiAke3NwZWVkTUJwc30gTUIvcyIgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICAgTG9nOiAgICAgICAkKFNwbGl0LVBhdGggJGxvZ0ZpbGUgLUxlYWYpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CgogICAgcmV0dXJuIEB7CiAgICAgICAgRXhpdENvZGUgPSAkZXhpdENvZGU7IE9LID0gKCRleGl0Q29kZSAtbGUgNyk7IEVsYXBzZWQgPSAkZWxhcHNlZAogICAgICAgIEJ5dGVzQ29waWVkID0gJGJ5dGVzQ29waWVkOyBTcGVlZE1CcHMgPSAkc3BlZWRNQnBzOyBMb2dGaWxlID0gJGxvZ0ZpbGUKICAgIH0KfQoKIyA9PT09PT09PT09PT09PT09PT09PSBCVUNMRSBQUklOQ0lQQUwgPT09PT09PT09PT09PT09PT09PT0KCmRvIHsKICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iICJDeWFuIgogICAgV3JpdGUtQ2VudGVyZWQgInwgICAgIEFUTEFTIFBDIFNVUFBPUlQgLSBDT1BJQSBJTlRFTElHRU5URSB2OCAgICAgICAgICAgIHwiICJZZWxsb3ciCiAgICBXcml0ZS1DZW50ZXJlZCAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgIkN5YW4iCiAgICBXcml0ZS1Ib3N0ICIiCgogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICMgUEFTTyAxOiBPUklHRU4KICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAkb3JpZ2VuID0gJG51bGw7ICRpc0ZpbGUgPSAkZmFsc2U7ICRzcmNOYW1lID0gIiI7ICRzcmNTdGF0cyA9ICRudWxsCgogICAgOmFza1NvdXJjZSB3aGlsZSAoJHRydWUpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgV3JpdGUtSG9zdCAiICBbMV0gT1JJR0VOIChhcnJhc3RyYSwgZXNjcmliZSBydXRhLCBvIGV4cGxvcmFkb3IpOiIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgIAogICAgICAgICRwYXRoUmVzdWx0ID0gR2V0LVBhdGhGcm9tVXNlciAtUHJvbXB0ICJPUklHRU4iIC1Nb2RlICJhbnkiCiAgICAgICAgCiAgICAgICAgaWYgKCRwYXRoUmVzdWx0IC1lcSAiRVhJVCIpIHsgZXhpdCB9CiAgICAgICAgaWYgKCRwYXRoUmVzdWx0IC1lcSAiQkFDSyIpIHsgYnJlYWsgfQogICAgICAgIAogICAgICAgIGlmICgtbm90IChUZXN0LVBhdGggJHBhdGhSZXN1bHQpKSB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtFUlJPUl0gTm8gZXhpc3RlOiAke3BhdGhSZXN1bHR9IiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICBjb250aW51ZQogICAgICAgIH0KCiAgICAgICAgJG9yaWdlbiA9ICRwYXRoUmVzdWx0CiAgICAgICAgJGlzRmlsZSA9IC1ub3QgKFRlc3QtUGF0aCAkb3JpZ2VuIC1QYXRoVHlwZSBDb250YWluZXIpCgogICAgICAgIGlmICgkaXNGaWxlKSB7CiAgICAgICAgICAgICRzcmNGaWxlT2JqID0gR2V0LUl0ZW0gJG9yaWdlbgogICAgICAgICAgICAkc3JjTmFtZSA9ICRzcmNGaWxlT2JqLk5hbWUKICAgICAgICAgICAgJHNyY1N0YXRzID0gQHsgRmlsZXMgPSAxOyBTaXplID0gJHNyY0ZpbGVPYmouTGVuZ3RoOyBTaXplTUIgPSBbbWF0aF06OlJvdW5kKCRzcmNGaWxlT2JqLkxlbmd0aCAvIDFNQiwgMSkgfQogICAgICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtPS10gQVJDSElWTzogJHtzcmNOYW1lfSAoJChGb3JtYXQtU2l6ZSAkc3JjRmlsZU9iai5MZW5ndGgpKSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICRzcmNOYW1lID0gU3BsaXQtUGF0aCAkb3JpZ2VuIC1MZWFmCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIEVzY2FuZWFuZG8uLi4iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgJHNyY1N0YXRzID0gR2V0LUZvbGRlclN0YXRzICRvcmlnZW4KICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW09LXSBDQVJQRVRBOiAke3NyY05hbWV9IiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgICQoJHNyY1N0YXRzLkZpbGVzKSBhcmNoaXZvcyB8ICQoRm9ybWF0LVNpemUgJHNyY1N0YXRzLlNpemUpIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgICAgICB9CiAgICAgICAgYnJlYWsKICAgIH0KCiAgICBpZiAoLW5vdCAkb3JpZ2VuKSB7IGNvbnRpbnVlIH0KCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBQQVNPIDI6IERFU1RJTk8KICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAkZGVzdGlubyA9ICRudWxsOyAkZHJpdmVJbmZvID0gJG51bGwKCiAgICA6YXNrRGVzdCB3aGlsZSAoJHRydWUpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIiCiAgICAgICAgV3JpdGUtSG9zdCAiICBbMl0gREVTVElOTzoiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICAKICAgICAgICAkcGF0aFJlc3VsdCA9IEdldC1QYXRoRnJvbVVzZXIgLVByb21wdCAiREVTVElOTyIgLU1vZGUgImZvbGRlciIKICAgICAgICAKICAgICAgICBpZiAoJHBhdGhSZXN1bHQgLWVxICJFWElUIikgeyBleGl0IH0KICAgICAgICBpZiAoJHBhdGhSZXN1bHQgLWVxICJCQUNLIikgeyBicmVhayB9CiAgICAgICAgCiAgICAgICAgJGRlc3RCYXNlID0gJHBhdGhSZXN1bHQKICAgICAgICBpZiAoLW5vdCAoVGVzdC1QYXRoICRkZXN0QmFzZSkpIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW0VSUk9SXSBObyBhY2Nlc2libGU6ICR7ZGVzdEJhc2V9IiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICBjb250aW51ZQogICAgICAgIH0KCiAgICAgICAgdHJ5IHsKICAgICAgICAgICAgJGZ1bGxPcmlnZW4gPSAoUmVzb2x2ZS1QYXRoICRvcmlnZW4pLlBhdGgKICAgICAgICAgICAgJGZ1bGxEZXN0ID0gKFJlc29sdmUtUGF0aCAkZGVzdEJhc2UpLlBhdGgKICAgICAgICAgICAgaWYgKCRmdWxsT3JpZ2VuIC1lcSAkZnVsbERlc3QpIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtFUlJPUl0gT3JpZ2VuIHkgZGVzdGlubyBzb24gaWd1YWxlcyEiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgICAgICBjb250aW51ZQogICAgICAgICAgICB9CiAgICAgICAgICAgIGlmICgkZnVsbERlc3QuU3RhcnRzV2l0aCgkZnVsbE9yaWdlbiArICJcIikpIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtFUlJPUl0gRGVzdGlubyBkZW50cm8gZGVsIG9yaWdlbiA9IHJlY3Vyc2lvbiEiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgICAgICBjb250aW51ZQogICAgICAgICAgICB9CiAgICAgICAgfSBjYXRjaCB7fQoKICAgICAgICAkZGVzdERyaXZlTGV0dGVyID0gJGRlc3RCYXNlLlN1YnN0cmluZygwLCAxKQogICAgICAgICRkcml2ZUluZm8gPSBEZXRlY3QtRHJpdmVUeXBlICRkZXN0RHJpdmVMZXR0ZXIKCiAgICAgICAgJGxhYmVsRGlzcGxheSA9IGlmICgkZHJpdmVJbmZvLkxhYmVsKSB7ICIgKCQoJGRyaXZlSW5mby5MYWJlbCkpIiB9IGVsc2UgeyAiIiB9CiAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW09LXSBEaXNjbzogJCgkZHJpdmVJbmZvLkRlc2MpJHtsYWJlbERpc3BsYXl9IiAtRm9yZWdyb3VuZENvbG9yICRkcml2ZUluZm8uQ29sb3IKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBMaWJyZTogJChGb3JtYXQtU2l6ZSAkZHJpdmVJbmZvLkZyZWVCeXRlcykiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JheQoKICAgICAgICBpZiAoJGRyaXZlSW5mby5GcmVlQnl0ZXMgLWd0IDAgLWFuZCAkc3JjU3RhdHMuU2l6ZSAtZ3QgJGRyaXZlSW5mby5GcmVlQnl0ZXMpIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbISEhXSBFU1BBQ0lPIElOU1VGSUNJRU5URSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgTmVjZXNpdGFzOiAkKEZvcm1hdC1TaXplICRzcmNTdGF0cy5TaXplKSB8IERpc3BvbmlibGU6ICQoRm9ybWF0LVNpemUgJGRyaXZlSW5mby5GcmVlQnl0ZXMpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbRl0gRm9yemFyICBbQl0gVm9sdmVyIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICAkZXNwT3AgPSBSZWFkLUhvc3QgIiAgICAgID4iCiAgICAgICAgICAgIGlmICgkZXNwT3AgLW5lICJGIiAtYW5kICRlc3BPcCAtbmUgImYiKSB7IGNvbnRpbnVlIH0KICAgICAgICB9CgogICAgICAgICRkZXN0aW5vID0gJGRlc3RCYXNlCiAgICAgICAgYnJlYWsKICAgIH0KCiAgICBpZiAoLW5vdCAkZGVzdGlubykgeyBjb250aW51ZSB9CgogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICMgUEFTTyAzOiBOT01CUkUKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgIFszXSBOb21icmUgZGVsIHByb3llY3RvIChFTlRFUiA9IFJlc3BhbGRvKToiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICRjbGllbnRlID0gUmVhZC1Ib3N0ICIgICAgICBOT01CUkUiCiAgICBpZiAoW3N0cmluZ106OklzTnVsbE9yV2hpdGVTcGFjZSgkY2xpZW50ZSkpIHsgJGNsaWVudGUgPSAiUmVzcGFsZG8iIH0KICAgICRjbGllbnRlID0gJGNsaWVudGUgLXJlcGxhY2UgJ1tcXC86Kj8iPD58XScsICdfJwoKICAgICRmZWNoYUhveSA9IEdldC1EYXRlIC1Gb3JtYXQgJ3l5eXktTU0tZGQnCiAgICAkcnV0YUZpbmFsID0gSm9pbi1QYXRoICRkZXN0aW5vICIke2NsaWVudGV9XyR7ZmVjaGFIb3l9IgoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAjIFBBU08gNDogTU9ETwogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgWzRdIE1PRE8gREUgQ09QSUE6IiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIFdyaXRlLUhvc3QgIiAgICAgIFsxXSBDT01QTEVUQSAtIENvcGlhIHRvZG8gKHByaW1lcmEgdmV6KSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiICAgICAgWzJdIElOQ1JFTUVOVEFMIC0gU29sbyBudWV2b3MvbW9kaWZpY2Fkb3MiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgIFdyaXRlLUhvc3QgIiAgICAgIFtCXSBWb2x2ZXIiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgIiIKICAgICRtb2RvU2VsID0gUmVhZC1Ib3N0ICIgICAgICA+IgogICAgaWYgKCRtb2RvU2VsIC1lcSAiQiIgLW9yICRtb2RvU2VsIC1lcSAiYiIpIHsgY29udGludWUgfQogICAgJG1vZG8gPSBpZiAoJG1vZG9TZWwgLWVxICIyIikgeyAiSU5DUkVNRU5UQUwiIH0gZWxzZSB7ICJDT01QTEVUQSIgfQoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAjIFBBU08gNTogRVhDTFVTSU9ORVMKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAkZXh0cmFYRCA9IEAoKTsgJGV4dHJhWEYgPSBAKCkKCiAgICBpZiAoLW5vdCAkaXNGaWxlKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgWzVdIEVYQ0xVU0lPTkVTOiIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgWzFdIE5pbmd1bmEgKGNvcGlhciB0b2RvKSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFsyXSBUZW1wb3JhbGVzICgudG1wLCAubG9nLCAuYmFrLCBjYWNoZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbM10gSVNPcyB5IFZNcyAoLmlzbywgLnZoZCwgLndpbSkiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbNF0gUGVyc29uYWxpemFkbyAoZXNjcmliaXIgZXh0ZW5zaW9uZXMpIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgW0JdIFZvbHZlciIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICAkZXhjbFNlbCA9IFJlYWQtSG9zdCAiICAgICAgPiIKICAgICAgICBpZiAoJGV4Y2xTZWwgLWVxICJCIiAtb3IgJGV4Y2xTZWwgLWVxICJiIikgeyBjb250aW51ZSB9CgogICAgICAgIHN3aXRjaCAoJGV4Y2xTZWwpIHsKICAgICAgICAgICAgIjIiIHsKICAgICAgICAgICAgICAgICRleHRyYVhGID0gQCgiKi50bXAiLCAiKi5sb2ciLCAiKi5iYWsiLCAiKi5jYWNoZSIsICIqLnRlbXAiLCAifioiKQogICAgICAgICAgICAgICAgJGV4dHJhWEQgPSBAKCJUZW1wIiwgInRtcCIsICJDYWNoZSIsICJfX3B5Y2FjaGVfXyIsICJub2RlX21vZHVsZXMiLCAiLmdpdCIpCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbT0tdIEV4Y2x1eWVuZG8gdGVtcG9yYWxlcyB5IGNhY2hlIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgIH0KICAgICAgICAgICAgIjMiIHsKICAgICAgICAgICAgICAgICRleHRyYVhGID0gQCgiKi5pc28iLCAiKi52aGQiLCAiKi52aGR4IiwgIioud2ltIiwgIiouZXNkIiwgIioudm1kayIpCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBbT0tdIEV4Y2x1eWVuZG8gSVNPcyB5IFZNcyIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgICAgICB9CiAgICAgICAgICAgICI0IiB7CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgICBFeHRlbnNpb25lcyBzZXBhcmFkYXMgcG9yIGNvbWEgKGVqOiAubXA0LC5hdmksLm1rdik6IiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgICAgICAgICAkY3VzdG9tRXhjbCA9IFJlYWQtSG9zdCAiICAgICAgPiIKICAgICAgICAgICAgICAgIGlmICgtbm90IFtzdHJpbmddOjpJc051bGxPcldoaXRlU3BhY2UoJGN1c3RvbUV4Y2wpKSB7CiAgICAgICAgICAgICAgICAgICAgJGV4dHJhWEYgPSAoJGN1c3RvbUV4Y2wgLXNwbGl0ICcsJykgfCBGb3JFYWNoLU9iamVjdCB7CiAgICAgICAgICAgICAgICAgICAgICAgICRleHQgPSAkXy5UcmltKCkKICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCRleHQgLW5vdG1hdGNoICdeXConKSB7ICRleHQgPSAiKiR7ZXh0fSIgfQogICAgICAgICAgICAgICAgICAgICAgICAkZXh0CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgICAgIFtPS10gRXhjbHV5ZW5kbzogJCgkZXh0cmFYRiAtam9pbiAnLCAnKSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfQoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAjIFBBU08gNjogUFJFVklFVwogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgIENsZWFyLUhvc3QKICAgIFdyaXRlLUhvc3QgImBuIgogICAgV3JpdGUtQ2VudGVyZWQgIj09PT09PT09PT09PT09PT09PT09IFBSRVZJRVcgPT09PT09PT09PT09PT09PT09PT0iICJXaGl0ZSIKICAgIFdyaXRlLUhvc3QgIiIKCiAgICBpZiAoJGlzRmlsZSkgewogICAgICAgIFdyaXRlLUhvc3QgIiAgICBUSVBPOiAgICAgIEFyY2hpdm8gc3VlbHRvIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgQVJDSElWTzogICAke3NyY05hbWV9IiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgV3JpdGUtSG9zdCAiICAgIFRBTUFOTzogICAgJChGb3JtYXQtU2l6ZSAkc3JjU3RhdHMuU2l6ZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JheQogICAgfSBlbHNlIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgVElQTzogICAgICBDYXJwZXRhIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgT1JJR0VOOiAgICAke3NyY05hbWV9IiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgV3JpdGUtSG9zdCAiICAgIEFSQ0hJVk9TOiAgJCgkc3JjU3RhdHMuRmlsZXMpIHwgJChGb3JtYXQtU2l6ZSAkc3JjU3RhdHMuU2l6ZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JheQogICAgfQoKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgICBERVNUSU5POiAgICR7cnV0YUZpbmFsfSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgV3JpdGUtSG9zdCAiICAgIERJU0NPOiAgICAgJCgkZHJpdmVJbmZvLkRlc2MpIiAtRm9yZWdyb3VuZENvbG9yICRkcml2ZUluZm8uQ29sb3IKICAgIFdyaXRlLUhvc3QgIiAgICBISUxPUzogICAgIE1UOiQoJGRyaXZlSW5mby5NVCkgKGF1dG8pIiAtRm9yZWdyb3VuZENvbG9yIEdyYXkKICAgIFdyaXRlLUhvc3QgIiAgICBNT0RPOiAgICAgICR7bW9kb30iIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgoKICAgIGlmICgkZXh0cmFYRi5Db3VudCAtZ3QgMCAtb3IgJGV4dHJhWEQuQ291bnQgLWd0IDApIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRVhDTFVJUjogICAkKCRleHRyYVhGLkNvdW50KSB0aXBvKHMpIGFyY2hpdm8gKyAkKCRleHRyYVhELkNvdW50KSBjYXJwZXRhKHMpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICB9CgogICAgJGF2Z1NwZWVkID0gc3dpdGNoICgkZHJpdmVJbmZvLlR5cGUpIHsgIlVTQiIgeyAyNSB9ICJIREQiIHsgODAgfSAiU1NEIiB7IDMwMCB9IGRlZmF1bHQgeyA1MCB9IH0KICAgIGlmICgkc3JjU3RhdHMuU2l6ZU1CIC1ndCAwKSB7CiAgICAgICAgJGV0YVNlYyA9ICRzcmNTdGF0cy5TaXplTUIgLyAkYXZnU3BlZWQKICAgICAgICAkZXRhU3BhbiA9IFtUaW1lU3Bhbl06OkZyb21TZWNvbmRzKCRldGFTZWMpCiAgICAgICAgV3JpdGUtSG9zdCAiICAgIEVUQTogICAgICAgfiQoRm9ybWF0LUR1cmF0aW9uICRldGFTcGFuKSAoZXN0aW1hZG8gcGFyYSAkKCRkcml2ZUluZm8uVHlwZSkpIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICB9CgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtQ2VudGVyZWQgIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iICJXaGl0ZSIKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgICBbU10gSU5JQ0lBUiBDT1BJQSAgW0JdIFZvbHZlciAgW05dIENhbmNlbGFyIiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICBXcml0ZS1Ib3N0ICIiCiAgICAkY29uZmlybWFyID0gUmVhZC1Ib3N0ICIgICAgPiIKICAgIGlmICgkY29uZmlybWFyIC1uZSAiUyIgLWFuZCAkY29uZmlybWFyIC1uZSAicyIpIHsgY29udGludWUgfQoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAjIFBBU08gNzogRUpFQ1VUQVIKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICBDbGVhci1Ib3N0CiAgICBXcml0ZS1Ib3N0ICJgbiIKCiAgICAkZmlsZU5hbWUgPSBpZiAoJGlzRmlsZSkgeyAkc3JjTmFtZSB9IGVsc2UgeyAiIiB9CgogICAgJHJlc3VsdCA9IFN0YXJ0LVNtYXJ0Q29weSAtT3JpZ2VuICRvcmlnZW4gLURlc3Rpbm8gJHJ1dGFGaW5hbCAtSXNGaWxlICRpc0ZpbGUgLUZpbGVOYW1lICRmaWxlTmFtZSBgCiAgICAgICAgLU1UICRkcml2ZUluZm8uTVQgLURpc2tUeXBlICRkcml2ZUluZm8uVHlwZSAtTW9kZSAkbW9kbyBgCiAgICAgICAgLUV4Y2x1ZGVEaXJzICRleHRyYVhEIC1FeGNsdWRlRmlsZXMgJGV4dHJhWEYKCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBQQVNPIDg6IFZFUklGSUNBQ0lPTgogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgIGlmICgkcmVzdWx0Lk9LIC1hbmQgLW5vdCAkaXNGaWxlKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgICBWZXJpZmljYXIgaW50ZWdyaWRhZCBNRDU/IFtTL05dIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgJHZlclNlbCA9IFJlYWQtSG9zdCAiICAgID4iCiAgICAgICAgaWYgKCR2ZXJTZWwgLWVxICJTIiAtb3IgJHZlclNlbCAtZXEgInMiKSB7CiAgICAgICAgICAgICRpbnRlZ3JpdHkgPSBUZXN0LUNvcHlJbnRlZ3JpdHkgLU9yaWdlbiAkb3JpZ2VuIC1EZXN0aW5vICRydXRhRmluYWwKICAgICAgICB9CiAgICB9CgogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICMgUEFTTyA5OiBQT1NULUNPUElBCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgOnBvc3RNZW51IHdoaWxlICgkdHJ1ZSkgewogICAgICAgIFdyaXRlLUhvc3QgIiIKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0iIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW0FdIEFicmlyIGNhcnBldGEgZGVzdGlubyIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtSXSBSRVBFVElSIGNvbiBPVFJPIGRlc3Rpbm8gKG1pc21vIG9yaWdlbikiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW05dIE51ZXZhIGNvcGlhIChvdHJvIG9yaWdlbikiIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW0xdIFZlciBsb2ciIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgW1NdIFNhbGlyIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgV3JpdGUtSG9zdCAiICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICRwb3N0T3AgPSBSZWFkLUhvc3QgIiAgICA+IgoKICAgICAgICBzd2l0Y2ggKCRwb3N0T3AuVG9VcHBlcigpKSB7CiAgICAgICAgICAgICJBIiB7CiAgICAgICAgICAgICAgICBpZiAoVGVzdC1QYXRoICRydXRhRmluYWwpIHsgSW52b2tlLUl0ZW0gJHJ1dGFGaW5hbCB9CiAgICAgICAgICAgICAgICBlbHNlIHsgV3JpdGUtSG9zdCAiICAgIENhcnBldGEgbm8gZW5jb250cmFkYS4iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkIH0KICAgICAgICAgICAgfQogICAgICAgICAgICAiUiIgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIE51ZXZvIERFU1RJTk86IiAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICRuZXdQYXRoID0gR2V0LVBhdGhGcm9tVXNlciAtUHJvbXB0ICJERVNUSU5PIiAtTW9kZSAiZm9sZGVyIgogICAgICAgICAgICAgICAgaWYgKCRuZXdQYXRoIC1lcSAiQkFDSyIgLW9yICRuZXdQYXRoIC1lcSAiRVhJVCIgLW9yIC1ub3QgJG5ld1BhdGgpIHsgY29udGludWUgfQogICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAkbmV3RGVzdEJhc2UgPSAkbmV3UGF0aAogICAgICAgICAgICAgICAgaWYgKC1ub3QgKFRlc3QtUGF0aCAkbmV3RGVzdEJhc2UpKSB7CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFJ1dGEgbm8gYWNjZXNpYmxlLiIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgICAgICAgICBjb250aW51ZQogICAgICAgICAgICAgICAgfQoKICAgICAgICAgICAgICAgICRuZXdEcml2ZUluZm8gPSBEZXRlY3QtRHJpdmVUeXBlICgkbmV3RGVzdEJhc2UuU3Vic3RyaW5nKDAsIDEpKQogICAgICAgICAgICAgICAgJG5ld1J1dGFGaW5hbCA9IEpvaW4tUGF0aCAkbmV3RGVzdEJhc2UgIiR7Y2xpZW50ZX1fJHtmZWNoYUhveX0iCgogICAgICAgICAgICAgICAgJG5ld0xhYmVsRGlzcGxheSA9IGlmICgkbmV3RHJpdmVJbmZvLkxhYmVsKSB7ICIgKCQoJG5ld0RyaXZlSW5mby5MYWJlbCkpIiB9IGVsc2UgeyAiIiB9CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRGlzY286ICQoJG5ld0RyaXZlSW5mby5EZXNjKSR7bmV3TGFiZWxEaXNwbGF5fSB8IE1UOiQoJG5ld0RyaXZlSW5mby5NVCkiIC1Gb3JlZ3JvdW5kQ29sb3IgJG5ld0RyaXZlSW5mby5Db2xvcgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIERlc3Rpbm86ICR7bmV3UnV0YUZpbmFsfSIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIFtTXSBDb3BpYXIgIFtOXSBDYW5jZWxhciIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgICAgICAgICAgJHJlcENvbmYgPSBSZWFkLUhvc3QgIiAgICA+IgoKICAgICAgICAgICAgICAgIGlmICgkcmVwQ29uZiAtZXEgIlMiIC1vciAkcmVwQ29uZiAtZXEgInMiKSB7CiAgICAgICAgICAgICAgICAgICAgQ2xlYXItSG9zdDsgV3JpdGUtSG9zdCAiYG4iCiAgICAgICAgICAgICAgICAgICAgJHJlc3VsdDIgPSBTdGFydC1TbWFydENvcHkgLU9yaWdlbiAkb3JpZ2VuIC1EZXN0aW5vICRuZXdSdXRhRmluYWwgLUlzRmlsZSAkaXNGaWxlIC1GaWxlTmFtZSAkZmlsZU5hbWUgYAogICAgICAgICAgICAgICAgICAgICAgICAtTVQgJG5ld0RyaXZlSW5mby5NVCAtRGlza1R5cGUgJG5ld0RyaXZlSW5mby5UeXBlIC1Nb2RlICRtb2RvIGAKICAgICAgICAgICAgICAgICAgICAgICAgLUV4Y2x1ZGVEaXJzICRleHRyYVhEIC1FeGNsdWRlRmlsZXMgJGV4dHJhWEYKCiAgICAgICAgICAgICAgICAgICAgaWYgKCRyZXN1bHQyLk9LIC1hbmQgLW5vdCAkaXNGaWxlKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiI7IFdyaXRlLUhvc3QgIiAgICBWZXJpZmljYXIgTUQ1PyBbUy9OXSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgICAgICAgICAgICAgICAgICAkdjIgPSBSZWFkLUhvc3QgIiAgICA+IgogICAgICAgICAgICAgICAgICAgICAgICBpZiAoJHYyIC1lcSAiUyIgLW9yICR2MiAtZXEgInMiKSB7IFRlc3QtQ29weUludGVncml0eSAtT3JpZ2VuICRvcmlnZW4gLURlc3Rpbm8gJG5ld1J1dGFGaW5hbCB8IE91dC1OdWxsIH0KICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgIk4iIHsgYnJlYWsgfQogICAgICAgICAgICAiTCIgewogICAgICAgICAgICAgICAgaWYgKFRlc3QtUGF0aCAkcmVzdWx0LkxvZ0ZpbGUpIHsgU3RhcnQtUHJvY2VzcyBub3RlcGFkICRyZXN1bHQuTG9nRmlsZSB9CiAgICAgICAgICAgICAgICBlbHNlIHsgV3JpdGUtSG9zdCAiICAgIExvZyBubyBlbmNvbnRyYWRvLiIgLUZvcmVncm91bmRDb2xvciBSZWQgfQogICAgICAgICAgICB9CiAgICAgICAgICAgICJTIiB7IGV4aXQgfQogICAgICAgIH0KCiAgICAgICAgaWYgKCRwb3N0T3AgLWVxICJOIiAtb3IgJHBvc3RPcCAtZXEgIm4iKSB7IGJyZWFrIH0KICAgIH0KCn0gd2hpbGUgKCR0cnVlKQp9Cg=='
$script:AtlasToolSources['Invoke-SelectorDNS'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtU2VsZWN0b3JETlMKIyBNaWdyYWRvIGRlOiBTZWxlY3RvckROUy5wczEKIyBBdGxhcyBQQyBTdXBwb3J0IOKAlCB2MS4wCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpmdW5jdGlvbiBJbnZva2UtU2VsZWN0b3JETlMgewogICAgW0NtZGxldEJpbmRpbmcoKV0KICAgIHBhcmFtKCkKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBBdGxhcyBQQyBTdXBwb3J0IC0gQWR2YW5jZWQgRE5TIFNlbGVjdG9yIHYyLjAKIyBCaWxpbmd1ZSwgTmF2ZWdhYmxlLCBGdWxsLUZlYXR1cmVkCiMgRml4ZXM6IFRyeVBhcnNlIGd1YXJkLCBSZWFkS2V5LCBXcml0ZS1DZW50ZXJlZCBmdWVyYSBkZWwgbG9vcCwKIyAgICAgICAgQmFja2dyb3VuZENvbG9yICsgQ2xlYXItSG9zdCBpbm1lZGlhdG8sIGhlYWRlciBib3ggYWxpbmVhZG8sCiMgICAgICAgIG51bGwtc2FmZSBhZGFwdGVyIGNoZWNrLgojIFVwc2NhbGVzOiBETlMgc3RhdHVzLCBsYXRlbmN5IHRlc3QsIGN1c3RvbSBETlMsIHBlci1hZGFwdGVyLCBiYWNrdXAvcmVzdG9yZSwKIyAgICAgICAgICAgbW9yZSBwcm92aWRlcnMsIERvSCB0b2dnbGUsIHN0YXJ0dXAgdGFzaywgYWN0aXZpdHkgbG9nLCBVSSBwb2xpc2guCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgojcmVnaW9uIOKUgOKUgCBJbmljaWFsaXphY2lvbiDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAKW2NvbnNvbGVdOjpCYWNrZ3JvdW5kQ29sb3IgPSAiQmxhY2siCltjb25zb2xlXTo6Rm9yZWdyb3VuZENvbG9yID0gIldoaXRlIgpDbGVhci1Ib3N0ICAjIEZJWDogQ2xlYXIgaW5tZWRpYXRvIHBhcmEgcXVlIGVsIEJhY2tncm91bmRDb2xvciBhcGxpcXVlIGRlIHVuYSB2ZXoKCiRzeXNMYW5nID0gKEdldC1VSUN1bHR1cmUpLlR3b0xldHRlcklTT0xhbmd1YWdlTmFtZQokZXMgICAgICA9ICgkc3lzTGFuZyAtZXEgJ2VzJykKCiRsb2dGaWxlICAgID0gSm9pbi1QYXRoICRQU1NjcmlwdFJvb3QgImRuc19sb2cudHh0IgokYmFja3VwRmlsZSA9IEpvaW4tUGF0aCAkUFNTY3JpcHRSb290ICJkbnNfYmFja3VwLmpzb24iCgojcmVnaW9uIGFnZW50IGxvZwokc2NyaXB0OkFnZW50RGVidWdMb2dQYXRocyA9IEAoCiAgICAoSm9pbi1QYXRoICRlbnY6VVNFUlBST0ZJTEUgImRlYnVnLWFlYTEwNy5sb2ciKQogICAgKEpvaW4tUGF0aCAkUFNTY3JpcHRSb290ICAgImRlYnVnLWFlYTEwNy5sb2ciKQopIHwgU2VsZWN0LU9iamVjdCAtVW5pcXVlCmZ1bmN0aW9uIFdyaXRlLUFnZW50RGJnIHsKICAgIHBhcmFtKFtzdHJpbmddJGh5cG90aGVzaXNJZCwgW3N0cmluZ10kbG9jYXRpb24sIFtzdHJpbmddJG1lc3NhZ2UsIFtoYXNodGFibGVdJGRhdGEgPSBAe30pCiAgICB0cnkgewogICAgICAgICRwYXlsb2FkID0gW29yZGVyZWRdQHsKICAgICAgICAgICAgc2Vzc2lvbklkICAgID0gImFlYTEwNyIKICAgICAgICAgICAgaHlwb3RoZXNpc0lkID0gJGh5cG90aGVzaXNJZAogICAgICAgICAgICBsb2NhdGlvbiAgICAgPSAkbG9jYXRpb24KICAgICAgICAgICAgbWVzc2FnZSAgICAgID0gJG1lc3NhZ2UKICAgICAgICAgICAgZGF0YSAgICAgICAgID0gJGRhdGEKICAgICAgICAgICAgdGltZXN0YW1wICAgID0gW0RhdGVUaW1lT2Zmc2V0XTo6VXRjTm93LlRvVW5peFRpbWVNaWxsaXNlY29uZHMoKQogICAgICAgIH0KICAgICAgICAkbGluZSA9ICRwYXlsb2FkIHwgQ29udmVydFRvLUpzb24gLUNvbXByZXNzIC1EZXB0aCA4CiAgICAgICAgZm9yZWFjaCAoJHAgaW4gJHNjcmlwdDpBZ2VudERlYnVnTG9nUGF0aHMpIHsKICAgICAgICAgICAgdHJ5IHsgQWRkLUNvbnRlbnQgLVBhdGggJHAgLVZhbHVlICRsaW5lIC1FbmNvZGluZyBVVEY4IC1FcnJvckFjdGlvbiBTdG9wIH0gY2F0Y2ggeyB9CiAgICAgICAgfQogICAgfSBjYXRjaCB7IH0KfQpXcml0ZS1BZ2VudERiZyAtaHlwb3RoZXNpc0lkICJJTklUIiAtbG9jYXRpb24gIlNlbGVjdG9yRE5TLnBzMTpwb3N0LXZhcnMiIC1tZXNzYWdlICJzY3JpcHRfc3RhcnQiIC1kYXRhIEB7CiAgICBIb3N0TmFtZSA9ICRIb3N0Lk5hbWUKICAgIFBTVmVyICAgID0gJFBTVmVyc2lvblRhYmxlLlBTVmVyc2lvbi5Ub1N0cmluZygpCiAgICBQU0VkICAgICA9ICRQU1ZlcnNpb25UYWJsZS5QU0VkaXRpb24KICAgIFJvb3QgICAgID0gJFBTU2NyaXB0Um9vdAogICAgTG9nUGF0aHMgPSBAKCRzY3JpcHQ6QWdlbnREZWJ1Z0xvZ1BhdGhzKQp9CiNlbmRyZWdpb24KI2VuZHJlZ2lvbgoKI3JlZ2lvbiDilIDilIAgRGljY2lvbmFyaW8gQmlsaW5ndWUg4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACiR0eHQgPSBAewogICAgIyBFbmNhYmV6YWRvCiAgICBWZXJTdHIgICAgICAgPSAidjIuMCIKICAgICMgT3BjaW9uZXMgRE5TCiAgICBPcHQxICAgICAgICAgPSBpZiAoJGVzKSB7ICIgMS4gRE5TIEF1dG9tYXRpY28gICAgICAgIChXaW5kb3dzIHBvciBkZWZlY3RvKSIgfSAgICAgICBlbHNlIHsgIiAxLiBBdXRvbWF0aWMgRE5TICAgICAgICAgKFdpbmRvd3MgZGVmYXVsdCkiIH0KICAgIEhlYWRlckNGICAgICA9ICItLS0gQ0xPVURGTEFSRSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKICAgIE9wdDIgICAgICAgICA9ICIgMi4gQmFzaWNvICAgICAgICAgICAgICAgKDEuMS4xLjEgIHwgTWF4IFNwZWVkKSIKICAgIE9wdDMgICAgICAgICA9ICIgMy4gQXZhbnphZG8gICAgICAgICAgICAgKDEuMS4xLjIgIHwgTWFsd2FyZSBCbG9jaykiCiAgICBPcHQ0ICAgICAgICAgPSAiIDQuIEZhbWlsaWFyICAgICAgICAgICAgICgxLjEuMS4zICB8IE1hbHdhcmUgKyBBZHVsdCkiCiAgICBIZWFkZXJHRyAgICAgPSAiLS0tIEdPT0dMRSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0iCiAgICBPcHQ1ICAgICAgICAgPSAiIDUuIEdvb2dsZSBETlMgICAgICAgICAgICg4LjguOC44ICB8IEdlbmVyYWwgUHVycG9zZSkiCiAgICBIZWFkZXJROSAgICAgPSAiLS0tIFFVQUQ5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0iCiAgICBPcHQ2ICAgICAgICAgPSAiIDYuIFF1YWQ5ICAgICAgICAgICAgICAgICg5LjkuOS45ICB8IE1hbHdhcmUgKyBQcml2YWN5KSIKICAgIEhlYWRlck9EICAgICA9ICItLS0gT1BFTkROUyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKICAgIE9wdDcgICAgICAgICA9ICIgNy4gT3BlbkROUyBIb21lICAgICAgICAgKDIwOC42Ny4yMjIuMjIyIHwgR2VuZXJhbCkiCiAgICBPcHQ4ICAgICAgICAgPSAiIDguIE9wZW5ETlMgRmFtaWx5U2hpZWxkICgyMDguNjcuMjIyLjEyMyB8IEFkdWx0IEJsb2NrKSIKICAgIEhlYWRlck1WICAgICA9ICItLS0gTVVMTFZBRCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKICAgIE9wdDkgICAgICAgICA9ICIgOS4gTXVsbHZhZCAxICAgICAgICAgICAgKDE5NC4yNDIuMi4yIHwgU29sbyBETlMgUmVzb2x2ZXIpIgogICAgT3B0MTAgICAgICAgID0gIjEwLiBNdWxsdmFkIDIgICAgICAgICAgICAoMTk0LjI0Mi4yLjMgfCBBZEJsb2NrKSIKICAgIE9wdDExICAgICAgICA9ICIxMS4gTXVsbHZhZCAzICAgICAgICAgICAgKDE5NC4yNDIuMi40IHwgQWRzK1RyYWNrZXJzK0Fkd2FyZSkiCiAgICBPcHQxMiAgICAgICAgPSAiMTIuIE11bGx2YWQgNCAgICAgICAgICAgICgxOTQuMjQyLjIuNSB8IFNvY2lhbCBNZWRpYStNb2xlc3QuKSIKICAgIE9wdDEzICAgICAgICA9ICIxMy4gTXVsbHZhZCA1ICAgICAgICAgICAgKDE5NC4yNDIuMi42IHwgQWR1bHQrR2FtYmxpbmcpIgogICAgT3B0MTQgICAgICAgID0gIjE0LiBNdWxsdmFkIDYgICAgICAgICAgICAoMTk0LjI0Mi4yLjkgfCBFeHRyZW1lKSIKICAgIEhlYWRlck5EICAgICA9ICItLS0gTkVYVEROUyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKICAgIE9wdDE1ICAgICAgICA9ICIxNS4gTmV4dEROUyAgICAgICAgICAgICAgKDQ1LjkwLjI4LjAgIHwgQ29uZmlndXJhYmxlKSIKICAgIEhlYWRlckNVICAgICA9ICItLS0gUEVSU09OQUxJWkFETyAvIENVU1RPTSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKICAgIE9wdDE2ICAgICAgICA9IGlmICgkZXMpIHsgIjE2LiBETlMgUGVyc29uYWxpemFkbyAgICAoSW5ncmVzYSB0dXMgcHJvcGlhcyBJUHMpIiB9ICAgICBlbHNlIHsgIjE2LiBDdXN0b20gRE5TICAgICAgICAgICAoRW50ZXIgeW91ciBvd24gSVBzKSIgfQogICAgIyBIZXJyYW1pZW50YXMKICAgIEhlYWRlclRvb2xzICA9IGlmICgkZXMpIHsgIj09PT09IEhFUlJBTUlFTlRBUyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiB9IGVsc2UgeyAiPT09PT0gVE9PTFMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iIH0KICAgIE9wdDE3ICAgICAgICA9IGlmICgkZXMpIHsgIjE3LiBUZXN0IGRlIExhdGVuY2lhIEROUyAgICAoUGluZyBhIHRvZG9zIGxvcyBzZXJ2ZXJzKSIgfSBlbHNlIHsgIjE3LiBETlMgTGF0ZW5jeSBUZXN0ICAgICAgICAoUGluZyBhbGwgc2VydmVycykiIH0KICAgIE9wdDE4ICAgICAgICA9IGlmICgkZXMpIHsgIjE4LiBCYWNrdXAgRE5TIGFjdHVhbCAgICAgICAoR3VhcmRhciBjb25maWcgYWN0dWFsKSIgfSAgICAgZWxzZSB7ICIxOC4gQmFja3VwIGN1cnJlbnQgRE5TICAgICAgKFNhdmUgY3VycmVudCBjb25maWcpIiB9CiAgICBPcHQxOSAgICAgICAgPSBpZiAoJGVzKSB7ICIxOS4gUmVzdGF1cmFyIGRlc2RlIEJhY2t1cCAgKFJldmVydGlyIGNhbWJpb3MpIiB9ICAgICAgICAgIGVsc2UgeyAiMTkuIFJlc3RvcmUgZnJvbSBCYWNrdXAgICAgIChSZXZlcnQgY2hhbmdlcykiIH0KICAgIE9wdDIwICAgICAgICA9IGlmICgkZXMpIHsgIjIwLiBUb2dnbGUgRE5TLW92ZXItSFRUUFMgICAoRG9IIE9uL09mZikiIH0gICAgICAgICAgICAgICAgZWxzZSB7ICIyMC4gVG9nZ2xlIEROUy1vdmVyLUhUVFBTICAgKERvSCBPbi9PZmYpIiB9CiAgICBPcHQyMSAgICAgICAgPSBpZiAoJGVzKSB7ICIyMS4gUGVyc2lzdGVuY2lhIGFsIEluaWNpbyAgKFRhcmVhIFByb2dyYW1hZGEpIiB9ICAgICAgICAgIGVsc2UgeyAiMjEuIFN0YXJ0dXAgUGVyc2lzdGVuY2UgICAgIChTY2hlZHVsZWQgVGFzaykiIH0KICAgIE9wdDIyICAgICAgICA9IGlmICgkZXMpIHsgIjIyLiBWZXIgUmVnaXN0cm8gICAgICAgICAgICAoVWx0aW1hcyAzMCBlbnRyYWRhcykiIH0gICAgICAgZWxzZSB7ICIyMi4gVmlldyBBY3Rpdml0eSBMb2cgICAgICAgKExhc3QgMzAgZW50cmllcykiIH0KICAgIE9wdDIzICAgICAgICA9IGlmICgkZXMpIHsgIjIzLiBTZWxlY2Npb24gcG9yIEFkYXB0YWRvciAoRWxlZ2lyIE5JQyBlc3BlY2lmaWNhKSIgfSAgICAgZWxzZSB7ICIyMy4gUGVyLUFkYXB0ZXIgU2VsZWN0aW9uICAgKENob29zZSBzcGVjaWZpYyBOSUMpIiB9CiAgICBPcHQyNCAgICAgICAgPSBpZiAoJGVzKSB7ICIyNC4gVGVzdCBTZWd1cmlkYWQgRE5TICAgICAgKENsb3VkZmxhcmUgRVNOSSBicm93c2VyKSIgfSAgIGVsc2UgeyAiMjQuIEROUyBTZWN1cml0eSBUZXN0ICAgICAgIChDbG91ZGZsYXJlIEVTTkkgYnJvd3NlcikiIH0KICAgIE9wdDAgICAgICAgICA9IGlmICgkZXMpIHsgIiAwLiBTYWxpciIgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSB7ICIgMC4gRXhpdCIgfQogICAgIyBQcm9tcHRzIHkgbWVuc2FqZXMKICAgIFByb21wdCAgICAgICA9IGlmICgkZXMpIHsgIkVsaWdlIHVuYSBvcGNpb24gKDAtMjQpIiB9ICAgICAgICAgICAgICBlbHNlIHsgIkNob29zZSBhbiBvcHRpb24gKDAtMjQpIiB9CiAgICBQcm9tcHRETlNPcHQgPSBpZiAoJGVzKSB7ICJQZXJmaWwgRE5TIGEgYXBsaWNhciAoMS0xNSk6ICIgfSAgICAgICAgZWxzZSB7ICJETlMgcHJvZmlsZSB0byBhcHBseSAoMS0xNSk6ICIgfQogICAgRXJyTm9BZGFwICAgID0gaWYgKCRlcykgeyAiW0VSUk9SXSBObyBzZSBlbmNvbnRyYXJvbiBhZGFwdGFkb3Jlcy4iIH0gZWxzZSB7ICJbRVJST1JdIE5vIGFkYXB0ZXJzIGZvdW5kLiIgfQogICAgQXBwbHlpbmcgICAgID0gaWYgKCRlcykgeyAiQXBsaWNhbmRvIGNvbmZpZ3VyYWNpb24uLi4iIH0gICAgICAgICAgICBlbHNlIHsgIkFwcGx5aW5nIGNvbmZpZ3VyYXRpb24uLi4iIH0KICAgIE9wZW5pbmcgICAgICA9IGlmICgkZXMpIHsgIkFicmllbmRvIG5hdmVnYWRvci4uLiIgfSAgICAgICAgICAgICAgICAgZWxzZSB7ICJPcGVuaW5nIGJyb3dzZXIuLi4iIH0KICAgIE9rQXV0byAgICAgICA9IGlmICgkZXMpIHsgIi0+IEROUyBBdXRvbWF0aWNvIiB9ICAgICAgICAgICAgICAgICAgICAgZWxzZSB7ICItPiBBdXRvbWF0aWMgRE5TIiB9CiAgICBPa0ROUyAgICAgICAgPSBpZiAoJGVzKSB7ICItPiBVc2FuZG8iIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgeyAiLT4gVXNpbmciIH0KICAgIEVyckludiAgICAgICA9IGlmICgkZXMpIHsgIltFUlJPUl0gT3BjaW9uIG5vIHZhbGlkYS4iIH0gICAgICAgICAgICAgZWxzZSB7ICJbRVJST1JdIEludmFsaWQgb3B0aW9uLiIgfQogICAgRXJyQmxhbmsgICAgID0gaWYgKCRlcykgeyAiW0VSUk9SXSBEZWJlcyBpbmdyZXNhciB1biBudW1lcm8gKDAtMjQpLiIgfSBlbHNlIHsgIltFUlJPUl0gRW50ZXIgYSBudW1iZXIgKDAtMjQpLiIgfQogICAgRmx1c2hETlMgICAgID0gaWYgKCRlcykgeyAiTGltcGlhbmRvIGNhY2hlIEROUy4uLiIgfSAgICAgICAgICAgICAgICBlbHNlIHsgIkZsdXNoaW5nIEROUyBjYWNoZS4uLiIgfQogICAgRG9uZSAgICAgICAgID0gaWYgKCRlcykgeyAiSGVjaG8hIFByb2Nlc28gdGVybWluYWRvIGV4aXRvc2FtZW50ZS4iIH0gZWxzZSB7ICJEb25lISBQcm9jZXNzIGZpbmlzaGVkIHN1Y2Nlc3NmdWxseS4iIH0KICAgIE5leHQgICAgICAgICA9IGlmICgkZXMpIHsgIiBQcmVzaW9uYSBjdWFscXVpZXIgdGVjbGEgcGFyYSB2b2x2ZXIgYWwgbWVudS4uLiIgfSBlbHNlIHsgIiBQcmVzcyBhbnkga2V5IHRvIHJldHVybiB0byBtZW51Li4uIiB9CiAgICBDdXJyZW50RE5TICAgPSBpZiAoJGVzKSB7ICJETlMgQUNUSVZPIiB9ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgeyAiQUNUSVZFIEROUyIgfQogICAgQXV0byAgICAgICAgID0gaWYgKCRlcykgeyAiQXV0b21hdGljbyIgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlIHsgIkF1dG9tYXRpYyIgfQogICAgIyBDdXN0b20gRE5TCiAgICBDdXN0b21QcmltICAgPSBpZiAoJGVzKSB7ICIgIEROUyBQcmltYXJpbyAgIChlajogOC44LjguOCkgIDogIiB9ICAgZWxzZSB7ICIgIFByaW1hcnkgRE5TICAgIChlLmcuIDguOC44LjgpIDogIiB9CiAgICBDdXN0b21TZWMgICAgPSBpZiAoJGVzKSB7ICIgIEROUyBTZWN1bmRhcmlvIChlajogOC44LjQuNCkgIDogIiB9ICAgZWxzZSB7ICIgIFNlY29uZGFyeSBETlMgIChlLmcuIDguOC40LjQpIDogIiB9CiAgICBDdXN0b21BcHBseSAgPSBpZiAoJGVzKSB7ICJBcGxpY2FyIGEgdG9kb3MgbG9zIGFkYXB0YWRvcmVzPyAocy9uKSBbbiA9IGVsZWdpcl06ICIgfSBlbHNlIHsgIkFwcGx5IHRvIGFsbCBhZGFwdGVycz8gKHkvbikgW24gPSBjaG9vc2VdOiAiIH0KICAgICMgQmFja3VwIC8gUmVzdG9yZQogICAgQmFja3VwT2sgICAgID0gaWYgKCRlcykgeyAiW09LXSBCYWNrdXAgZ3VhcmRhZG8gZW46IiB9ICAgICAgICAgICAgICBlbHNlIHsgIltPS10gQmFja3VwIHNhdmVkIHRvOiIgfQogICAgQmFja3VwTm9uZSAgID0gaWYgKCRlcykgeyAiW0VSUk9SXSBObyBzZSBlbmNvbnRybyBhcmNoaXZvIGRlIGJhY2t1cCBlbjoiIH0gZWxzZSB7ICJbRVJST1JdIE5vIGJhY2t1cCBmaWxlIGZvdW5kIGF0OiIgfQogICAgUmVzdG9yZU9rICAgID0gaWYgKCRlcykgeyAiW09LXSBETlMgcmVzdGF1cmFkbyBkZXNkZSBiYWNrdXAuIiB9ICAgICBlbHNlIHsgIltPS10gRE5TIHJlc3RvcmVkIGZyb20gYmFja3VwLiIgfQogICAgIyBMYXRlbmNpYQogICAgUGluZ1Rlc3RpbmcgID0gaWYgKCRlcykgeyAiUHJvYmFuZG8gbGF0ZW5jaWEgKDMgcGluZ3MgcG9yIHNlcnZpZG9yKS4uLiIgfSBlbHNlIHsgIlRlc3RpbmcgbGF0ZW5jeSAoMyBwaW5ncyBwZXIgc2VydmVyKS4uLiIgfQogICAgRmFzdGVzdCAgICAgID0gaWYgKCRlcykgeyAiTWFzIHJhcGlkbyIgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlIHsgIkZhc3Rlc3QiIH0KICAgIE5vUmVzcCAgICAgICA9IGlmICgkZXMpIHsgIlNpbiByZXNwdWVzdGEiIH0gICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSB7ICJObyByZXNwb25zZSIgfQogICAgIyBEb0gKICAgIERvSFN0YXR1cyAgICA9IGlmICgkZXMpIHsgIkVzdGFkbyBEb0ggYWN0dWFsOiIgfSAgICAgICAgICAgICAgICAgICAgZWxzZSB7ICJDdXJyZW50IERvSCBzdGF0dXM6IiB9CiAgICBEb0hPbiAgICAgICAgPSBpZiAoJGVzKSB7ICJBQ1RJVkFETyIgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgeyAiRU5BQkxFRCIgfQogICAgRG9IT2ZmICAgICAgID0gaWYgKCRlcykgeyAiREVTQUNUSVZBRE8iIH0gICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgeyAiRElTQUJMRUQiIH0KICAgIERvSENob29zZSAgICA9IGlmICgkZXMpIHsgIiAgWzFdIEFjdGl2YXIgRG9IICAgWzJdIERlc2FjdGl2YXIgRG9IICAgWzBdIENhbmNlbGFyOiAiIH0gZWxzZSB7ICIgIFsxXSBFbmFibGUgRG9IICAgWzJdIERpc2FibGUgRG9IICAgWzBdIENhbmNlbDogIiB9CiAgICBEb0hOb3RlICAgICAgPSBpZiAoJGVzKSB7ICIoUmVxdWllcmUgcmVpbmljaW8gcGFyYSBhcGxpY2Fyc2UgY29tcGxldGFtZW50ZSkiIH0gZWxzZSB7ICIoUmVzdGFydCByZXF1aXJlZCBmb3IgZnVsbCBlZmZlY3QpIiB9CiAgICAjIFRhcmVhIHByb2dyYW1hZGEKICAgIFRhc2tFeGlzdHMgICA9IGlmICgkZXMpIHsgIllhIGV4aXN0ZSBsYSB0YXJlYSAnQXRsYXNETlMnLiBFbGltaW5hcmxhPyAocy9uKTogIiB9IGVsc2UgeyAiVGFzayAnQXRsYXNETlMnIGFscmVhZHkgZXhpc3RzLiBSZW1vdmUgaXQ/ICh5L24pOiAiIH0KICAgIFRhc2tDcmVhdGVkICA9IGlmICgkZXMpIHsgIltPS10gVGFyZWEgY3JlYWRhLiBFbCBETlMgc2UgcmUtYXBsaWNhcmEgYWwgaW5pY2lhciBzZXNpb24uIiB9IGVsc2UgeyAiW09LXSBUYXNrIGNyZWF0ZWQuIEROUyB3aWxsIHJlLWFwcGx5IG9uIGxvZ29uLiIgfQogICAgVGFza1JlbW92ZWQgID0gaWYgKCRlcykgeyAiW09LXSBUYXJlYSBwcm9ncmFtYWRhIGVsaW1pbmFkYS4iIH0gICAgICBlbHNlIHsgIltPS10gU2NoZWR1bGVkIHRhc2sgcmVtb3ZlZC4iIH0KICAgIFRhc2tOb25lICAgICA9IGlmICgkZXMpIHsgIihObyBoYXkgdGFyZWEgYWN0aXZhIGFjdHVhbG1lbnRlKSIgfSAgICAgZWxzZSB7ICIoTm8gYWN0aXZlIHRhc2sgY3VycmVudGx5KSIgfQogICAgIyBMb2cKICAgIExvZ0VtcHR5ICAgICA9IGlmICgkZXMpIHsgIihFbCByZWdpc3RybyBlc3RhIHZhY2lvKSIgfSAgICAgICAgICAgICAgZWxzZSB7ICIoVGhlIGxvZyBpcyBlbXB0eSkiIH0KICAgIExvZ1BhdGggICAgICA9IGlmICgkZXMpIHsgIkFyY2hpdm86ICIgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSB7ICJGaWxlOiAiIH0KICAgICMgUGVyLWFkYXB0ZXIKICAgIEFkYXBIZWFkZXIgICA9IGlmICgkZXMpIHsgIkFkYXB0YWRvcmVzIGRpc3BvbmlibGVzOiIgfSAgICAgICAgICAgICAgZWxzZSB7ICJBdmFpbGFibGUgYWRhcHRlcnM6IiB9CiAgICBBZGFwUHJvbXB0ICAgPSBpZiAoJGVzKSB7ICIgIE51bWVybyBkZSBhZGFwdGFkb3IgbyBbVF1vZG9zOiAiIH0gICAgZWxzZSB7ICIgIEFkYXB0ZXIgbnVtYmVyIG9yIFtBXWxsOiAiIH0KICAgIEFkYXBBbGwgICAgICA9IGlmICgkZXMpIHsgIlRvZG9zIGxvcyBhZGFwdGFkb3JlcyIgfSAgICAgICAgICAgICAgICAgZWxzZSB7ICJBbGwgYWRhcHRlcnMiIH0KfQojZW5kcmVnaW9uCgojcmVnaW9uIOKUgOKUgCBQZXJmaWxlcyBETlMg4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACiRkbnNQcm9maWxlcyA9IFtvcmRlcmVkXUB7CiAgICAnMScgID0gQHsgTGFiZWwgPSAiQXV0b21hdGljIjsgICAgICAgICAgICAgICBBZGRyID0gQCgpIH0KICAgICcyJyAgPSBAeyBMYWJlbCA9ICJDbG91ZGZsYXJlIEJhc2ljIjsgICAgICAgICBBZGRyID0gQCgiMS4xLjEuMSIsIjEuMC4wLjEiLCIyNjA2OjQ3MDA6NDcwMDo6MTExMSIsIjI2MDY6NDcwMDo0NzAwOjoxMDAxIikgfQogICAgJzMnICA9IEB7IExhYmVsID0gIkNsb3VkZmxhcmUgQWR2YW5jZWQiOyAgICAgIEFkZHIgPSBAKCIxLjEuMS4yIiwiMS4wLjAuMiIsIjI2MDY6NDcwMDo0NzAwOjoxMTEyIiwiMjYwNjo0NzAwOjQ3MDA6OjEwMDIiKSB9CiAgICAnNCcgID0gQHsgTGFiZWwgPSAiQ2xvdWRmbGFyZSBGYW1pbHkiOyAgICAgICAgQWRkciA9IEAoIjEuMS4xLjMiLCIxLjAuMC4zIiwiMjYwNjo0NzAwOjQ3MDA6OjExMTMiLCIyNjA2OjQ3MDA6NDcwMDo6MTAwMyIpIH0KICAgICc1JyAgPSBAeyBMYWJlbCA9ICJHb29nbGUgRE5TIjsgICAgICAgICAgICAgICBBZGRyID0gQCgiOC44LjguOCIsIjguOC40LjQiLCIyMDAxOjQ4NjA6NDg2MDo6ODg4OCIsIjIwMDE6NDg2MDo0ODYwOjo4ODQ0IikgfQogICAgJzYnICA9IEB7IExhYmVsID0gIlF1YWQ5IjsgICAgICAgICAgICAgICAgICAgIEFkZHIgPSBAKCI5LjkuOS45IiwiMTQ5LjExMi4xMTIuMTEyIiwiMjYyMDpmZTo6ZmUiLCIyNjIwOmZlOjo5IikgfQogICAgJzcnICA9IEB7IExhYmVsID0gIk9wZW5ETlMgSG9tZSI7ICAgICAgICAgICAgIEFkZHIgPSBAKCIyMDguNjcuMjIyLjIyMiIsIjIwOC42Ny4yMjAuMjIwIikgfQogICAgJzgnICA9IEB7IExhYmVsID0gIk9wZW5ETlMgRmFtaWx5U2hpZWxkIjsgICAgIEFkZHIgPSBAKCIyMDguNjcuMjIyLjEyMyIsIjIwOC42Ny4yMjAuMTIzIikgfQogICAgJzknICA9IEB7IExhYmVsID0gIk11bGx2YWQgMSAoUmVzb2x2ZXIpIjsgICAgIEFkZHIgPSBAKCIxOTQuMjQyLjIuMiIsIjJhMDc6ZTM0MDo6MiIpIH0KICAgICcxMCcgPSBAeyBMYWJlbCA9ICJNdWxsdmFkIDIgKEFkQmxvY2spIjsgICAgICBBZGRyID0gQCgiMTk0LjI0Mi4yLjMiLCIyYTA3OmUzNDA6OjMiKSB9CiAgICAnMTEnID0gQHsgTGFiZWwgPSAiTXVsbHZhZCAzIChUcmFja2VyKSI7ICAgICAgQWRkciA9IEAoIjE5NC4yNDIuMi40IiwiMmEwNzplMzQwOjo0IikgfQogICAgJzEyJyA9IEB7IExhYmVsID0gIk11bGx2YWQgNCAoU29jaWFsKSI7ICAgICAgIEFkZHIgPSBAKCIxOTQuMjQyLjIuNSIsIjJhMDc6ZTM0MDo6NSIpIH0KICAgICcxMycgPSBAeyBMYWJlbCA9ICJNdWxsdmFkIDUgKEFkdWx0KSI7ICAgICAgICBBZGRyID0gQCgiMTk0LjI0Mi4yLjYiLCIyYTA3OmUzNDA6OjYiKSB9CiAgICAnMTQnID0gQHsgTGFiZWwgPSAiTXVsbHZhZCA2IChFeHRyZW1lKSI7ICAgICAgQWRkciA9IEAoIjE5NC4yNDIuMi45IiwiMmEwNzplMzQwOjo5IikgfQogICAgJzE1JyA9IEB7IExhYmVsID0gIk5leHRETlMiOyAgICAgICAgICAgICAgICAgIEFkZHIgPSBAKCI0NS45MC4yOC4wIiwiNDUuOTAuMzAuMCIsIjJhMDc6YThjMDo6IiwiMmEwNzphOGMxOjoiKSB9Cn0KCiMgVGVtcGxhdGVzIERvSCBwb3IgSVAKJGRvaFRlbXBsYXRlcyA9IEB7CiAgICAiMS4xLjEuMSIgICAgICAgICAgICAgID0gImh0dHBzOi8vY2xvdWRmbGFyZS1kbnMuY29tL2Rucy1xdWVyeSIKICAgICIxLjAuMC4xIiAgICAgICAgICAgICAgPSAiaHR0cHM6Ly9jbG91ZGZsYXJlLWRucy5jb20vZG5zLXF1ZXJ5IgogICAgIjI2MDY6NDcwMDo0NzAwOjoxMTExIiA9ICJodHRwczovL2Nsb3VkZmxhcmUtZG5zLmNvbS9kbnMtcXVlcnkiCiAgICAiMjYwNjo0NzAwOjQ3MDA6OjEwMDEiID0gImh0dHBzOi8vY2xvdWRmbGFyZS1kbnMuY29tL2Rucy1xdWVyeSIKICAgICIxLjEuMS4yIiAgICAgICAgICAgICAgPSAiaHR0cHM6Ly9zZWN1cml0eS5jbG91ZGZsYXJlLWRucy5jb20vZG5zLXF1ZXJ5IgogICAgIjEuMC4wLjIiICAgICAgICAgICAgICA9ICJodHRwczovL3NlY3VyaXR5LmNsb3VkZmxhcmUtZG5zLmNvbS9kbnMtcXVlcnkiCiAgICAiMjYwNjo0NzAwOjQ3MDA6OjExMTIiID0gImh0dHBzOi8vc2VjdXJpdHkuY2xvdWRmbGFyZS1kbnMuY29tL2Rucy1xdWVyeSIKICAgICIyNjA2OjQ3MDA6NDcwMDo6MTAwMiIgPSAiaHR0cHM6Ly9zZWN1cml0eS5jbG91ZGZsYXJlLWRucy5jb20vZG5zLXF1ZXJ5IgogICAgIjEuMS4xLjMiICAgICAgICAgICAgICA9ICJodHRwczovL2ZhbWlseS5jbG91ZGZsYXJlLWRucy5jb20vZG5zLXF1ZXJ5IgogICAgIjEuMC4wLjMiICAgICAgICAgICAgICA9ICJodHRwczovL2ZhbWlseS5jbG91ZGZsYXJlLWRucy5jb20vZG5zLXF1ZXJ5IgogICAgIjI2MDY6NDcwMDo0NzAwOjoxMTEzIiA9ICJodHRwczovL2ZhbWlseS5jbG91ZGZsYXJlLWRucy5jb20vZG5zLXF1ZXJ5IgogICAgIjI2MDY6NDcwMDo0NzAwOjoxMDAzIiA9ICJodHRwczovL2ZhbWlseS5jbG91ZGZsYXJlLWRucy5jb20vZG5zLXF1ZXJ5IgogICAgIjguOC44LjgiICAgICAgICAgICAgICA9ICJodHRwczovL2Rucy5nb29nbGUvZG5zLXF1ZXJ5IgogICAgIjguOC40LjQiICAgICAgICAgICAgICA9ICJodHRwczovL2Rucy5nb29nbGUvZG5zLXF1ZXJ5IgogICAgIjIwMDE6NDg2MDo0ODYwOjo4ODg4IiA9ICJodHRwczovL2Rucy5nb29nbGUvZG5zLXF1ZXJ5IgogICAgIjIwMDE6NDg2MDo0ODYwOjo4ODQ0IiA9ICJodHRwczovL2Rucy5nb29nbGUvZG5zLXF1ZXJ5IgogICAgIjkuOS45LjkiICAgICAgICAgICAgICA9ICJodHRwczovL2Rucy5xdWFkOS5uZXQvZG5zLXF1ZXJ5IgogICAgIjE0OS4xMTIuMTEyLjExMiIgICAgICA9ICJodHRwczovL2Rucy5xdWFkOS5uZXQvZG5zLXF1ZXJ5IgogICAgIjI2MjA6ZmU6OmZlIiAgICAgICAgICA9ICJodHRwczovL2Rucy5xdWFkOS5uZXQvZG5zLXF1ZXJ5IgogICAgIjI2MjA6ZmU6OjkiICAgICAgICAgICA9ICJodHRwczovL2Rucy5xdWFkOS5uZXQvZG5zLXF1ZXJ5IgogICAgIjE5NC4yNDIuMi4yIiAgICAgICAgICA9ICJodHRwczovL2RvaC5tdWxsdmFkLm5ldC9kbnMtcXVlcnkiCiAgICAiMmEwNzplMzQwOjoyIiAgICAgICAgID0gImh0dHBzOi8vZG9oLm11bGx2YWQubmV0L2Rucy1xdWVyeSIKICAgICIxOTQuMjQyLjIuMyIgICAgICAgICAgPSAiaHR0cHM6Ly9hZGJsb2NrLmRvaC5tdWxsdmFkLm5ldC9kbnMtcXVlcnkiCiAgICAiMmEwNzplMzQwOjozIiAgICAgICAgID0gImh0dHBzOi8vYWRibG9jay5kb2gubXVsbHZhZC5uZXQvZG5zLXF1ZXJ5IgogICAgIjE5NC4yNDIuMi40IiAgICAgICAgICA9ICJodHRwczovL2FkYmxvY2suZG9oLm11bGx2YWQubmV0L2Rucy1xdWVyeSIKICAgICIyYTA3OmUzNDA6OjQiICAgICAgICAgPSAiaHR0cHM6Ly9hZGJsb2NrLmRvaC5tdWxsdmFkLm5ldC9kbnMtcXVlcnkiCiAgICAiMTk0LjI0Mi4yLjUiICAgICAgICAgID0gImh0dHBzOi8vYWRibG9jay5kb2gubXVsbHZhZC5uZXQvZG5zLXF1ZXJ5IgogICAgIjJhMDc6ZTM0MDo6NSIgICAgICAgICA9ICJodHRwczovL2FkYmxvY2suZG9oLm11bGx2YWQubmV0L2Rucy1xdWVyeSIKICAgICIxOTQuMjQyLjIuNiIgICAgICAgICAgPSAiaHR0cHM6Ly9hZGJsb2NrLmRvaC5tdWxsdmFkLm5ldC9kbnMtcXVlcnkiCiAgICAiMmEwNzplMzQwOjo2IiAgICAgICAgID0gImh0dHBzOi8vYWRibG9jay5kb2gubXVsbHZhZC5uZXQvZG5zLXF1ZXJ5IgogICAgIjE5NC4yNDIuMi45IiAgICAgICAgICA9ICJodHRwczovL2FkYmxvY2suZG9oLm11bGx2YWQubmV0L2Rucy1xdWVyeSIKICAgICIyYTA3OmUzNDA6OjkiICAgICAgICAgPSAiaHR0cHM6Ly9hZGJsb2NrLmRvaC5tdWxsdmFkLm5ldC9kbnMtcXVlcnkiCiAgICAiNDUuOTAuMjguMCIgICAgICAgICAgID0gImh0dHBzOi8vZG5zLm5leHRkbnMuaW8vZG5zLXF1ZXJ5IgogICAgIjQ1LjkwLjMwLjAiICAgICAgICAgICA9ICJodHRwczovL2Rucy5uZXh0ZG5zLmlvL2Rucy1xdWVyeSIKICAgICIyYTA3OmE4YzA6OiIgICAgICAgICAgPSAiaHR0cHM6Ly9kbnMubmV4dGRucy5pby9kbnMtcXVlcnkiCiAgICAiMmEwNzphOGMxOjoiICAgICAgICAgID0gImh0dHBzOi8vZG5zLm5leHRkbnMuaW8vZG5zLXF1ZXJ5Igp9CgojIElQcyBkZSByZWZlcmVuY2lhIHBhcmEgZWwgdGVzdCBkZSBsYXRlbmNpYQokbGF0ZW5jeVRhcmdldHMgPSBbb3JkZXJlZF1AewogICAgIkNsb3VkZmxhcmUgQmFzaWMiICAgICAgPSAiMS4xLjEuMSIKICAgICJDbG91ZGZsYXJlIEFkdmFuY2VkIiAgID0gIjEuMS4xLjIiCiAgICAiQ2xvdWRmbGFyZSBGYW1pbHkiICAgICA9ICIxLjEuMS4zIgogICAgIkdvb2dsZSBETlMiICAgICAgICAgICAgPSAiOC44LjguOCIKICAgICJRdWFkOSIgICAgICAgICAgICAgICAgID0gIjkuOS45LjkiCiAgICAiT3BlbkROUyBIb21lIiAgICAgICAgICA9ICIyMDguNjcuMjIyLjIyMiIKICAgICJPcGVuRE5TIEZhbWlseVNoaWVsZCIgID0gIjIwOC42Ny4yMjIuMTIzIgogICAgIk11bGx2YWQgMSIgICAgICAgICAgICAgPSAiMTk0LjI0Mi4yLjIiCiAgICAiTXVsbHZhZCAyIiAgICAgICAgICAgICA9ICIxOTQuMjQyLjIuMyIKICAgICJNdWxsdmFkIDMiICAgICAgICAgICAgID0gIjE5NC4yNDIuMi40IgogICAgIk11bGx2YWQgNiAoRXh0cmVtZSkiICAgPSAiMTk0LjI0Mi4yLjkiCiAgICAiTmV4dEROUyIgICAgICAgICAgICAgICA9ICI0NS45MC4yOC4wIgp9CiNlbmRyZWdpb24KCiNyZWdpb24g4pSA4pSAIEZ1bmNpb25lcyBIZWxwZXIg4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACgpmdW5jdGlvbiBXcml0ZS1DZW50ZXJlZCB7CiAgICBwYXJhbShbc3RyaW5nXSRUZXh0LCBbQ29uc29sZUNvbG9yXSRDb2xvciA9ICJXaGl0ZSIpCiAgICAkd1Byb2JlID0gJG51bGwKICAgICRwcm9iZUVyciA9ICRudWxsCiAgICB0cnkgeyAkd1Byb2JlID0gJEhvc3QuVUkuUmF3VUkuV2luZG93U2l6ZS5XaWR0aCB9IGNhdGNoIHsgJHByb2JlRXJyID0gJF8uRXhjZXB0aW9uLk1lc3NhZ2UgfQogICAgI3JlZ2lvbiBhZ2VudCBsb2cKICAgIFdyaXRlLUFnZW50RGJnIC1oeXBvdGhlc2lzSWQgIkIiIC1sb2NhdGlvbiAiV3JpdGUtQ2VudGVyZWQiIC1tZXNzYWdlICJsYXlvdXQiIC1kYXRhIEB7IHdQcm9iZSA9ICR3UHJvYmU7IHRleHRMZW4gPSAkVGV4dC5MZW5ndGg7IHByb2JlRXJyID0gJHByb2JlRXJyIH0KICAgICNlbmRyZWdpb24KICAgICR3ICAgPSAkSG9zdC5VSS5SYXdVSS5XaW5kb3dTaXplLldpZHRoCiAgICAkcGFkID0gW21hdGhdOjpNYXgoMCwgW21hdGhdOjpGbG9vcigoJHcgLSAkVGV4dC5MZW5ndGgpIC8gMikpCiAgICBXcml0ZS1Ib3N0ICgoIiAiICogJHBhZCkgKyAkVGV4dCkgLUZvcmVncm91bmRDb2xvciAkQ29sb3IKfQoKZnVuY3Rpb24gUHJlc3MtQW55S2V5IHsKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgJHR4dC5OZXh0IC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICNyZWdpb24gYWdlbnQgbG9nCiAgICB0cnkgewogICAgICAgICRudWxsID0gJEhvc3QuVUkuUmF3VUkuUmVhZEtleSgiTm9FY2hvLEluY2x1ZGVLZXlEb3duIikKICAgICAgICBXcml0ZS1BZ2VudERiZyAtaHlwb3RoZXNpc0lkICJBIiAtbG9jYXRpb24gIlByZXNzLUFueUtleSIgLW1lc3NhZ2UgInJlYWRrZXlfb2siIC1kYXRhIEB7IGhvc3QgPSAkSG9zdC5OYW1lIH0KICAgIH0gY2F0Y2ggewogICAgICAgIFdyaXRlLUFnZW50RGJnIC1oeXBvdGhlc2lzSWQgIkEiIC1sb2NhdGlvbiAiUHJlc3MtQW55S2V5IiAtbWVzc2FnZSAicmVhZGtleV9mYWlsIiAtZGF0YSBAeyBob3N0ID0gJEhvc3QuTmFtZTsgZXggPSAkXy5FeGNlcHRpb24uTWVzc2FnZTsgdHlwZSA9ICRfLkV4Y2VwdGlvbi5HZXRUeXBlKCkuRnVsbE5hbWUgfQogICAgICAgIHRocm93CiAgICB9CiAgICAjZW5kcmVnaW9uCn0KCmZ1bmN0aW9uIFdyaXRlLUxvZyB7CiAgICBwYXJhbShbc3RyaW5nXSRNc2cpCiAgICAkdHMgPSBHZXQtRGF0ZSAtRm9ybWF0ICJ5eXl5LU1NLWRkIEhIOm1tOnNzIgogICAgIiR0cyB8ICRNc2ciIHwgT3V0LUZpbGUgLUZpbGVQYXRoICRsb2dGaWxlIC1BcHBlbmQgLUVuY29kaW5nIFVURjgKfQoKZnVuY3Rpb24gR2V0LVBoeXNpY2FsQWRhcHRlcnMgewogICAgcmV0dXJuIEdldC1OZXRBZGFwdGVyIC1QaHlzaWNhbCB8IFdoZXJlLU9iamVjdCB7CiAgICAgICAgJF8uSW50ZXJmYWNlRGVzY3JpcHRpb24gLW5vdG1hdGNoICJCbHVldG9vdGgiIC1hbmQgJF8uU3RhdHVzIC1uZSAiTm90IFByZXNlbnQiCiAgICB9Cn0KCmZ1bmN0aW9uIEdldC1ETlNTdGF0dXNMaW5lcyB7CiAgICAkYWRhcHRlcnMgPSBHZXQtUGh5c2ljYWxBZGFwdGVycwogICAgaWYgKC1ub3QgJGFkYXB0ZXJzKSB7IHJldHVybiBAKCIgIChubyBhZGFwdGVycykiKSB9CiAgICAkbGluZXMgPSBAKCkKICAgIGZvcmVhY2ggKCRhIGluICRhZGFwdGVycykgewogICAgICAgICRpcHY0ZG5zID0gKEdldC1EbnNDbGllbnRTZXJ2ZXJBZGRyZXNzIC1JbnRlcmZhY2VBbGlhcyAkYS5OYW1lIC1BZGRyZXNzRmFtaWx5IElQdjQgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUpLlNlcnZlckFkZHJlc3NlcwogICAgICAgICRkbnNTdHIgID0gaWYgKCRpcHY0ZG5zKSB7ICgkaXB2NGRucyB8IFNlbGVjdC1PYmplY3QgLUZpcnN0IDIpIC1qb2luICIgIHwgICIgfSBlbHNlIHsgJHR4dC5BdXRvIH0KICAgICAgICAkc3RhdHVzICA9IGlmICgkYS5TdGF0dXMgLWVxICJVcCIpIHsgIltVUF0gIiB9IGVsc2UgeyAiWy0tXSAiIH0KICAgICAgICAkY29sb3IgICA9IGlmICgkYS5TdGF0dXMgLWVxICJVcCIpIHsgIkdyZWVuIiB9IGVsc2UgeyAiRGFya0dyYXkiIH0KICAgICAgICAkbGluZXMgICs9IEB7IFRleHQgPSAiICAkc3RhdHVzJCgkYS5OYW1lLlBhZFJpZ2h0KDIwKSkgJGRuc1N0ciI7IENvbG9yID0gJGNvbG9yIH0KICAgIH0KICAgIHJldHVybiAkbGluZXMKfQoKZnVuY3Rpb24gUmVnaXN0ZXItRG9IVGVtcGxhdGVzIHsKICAgICMgUkFJWiBERUwgQlVHIEFOVEVSSU9SOiBQb3dlclNoZWxsIHJlZ2lzdHJ5IHByb3ZpZGVyIGludGVycHJldGEgJzI2MDY6JyBjb21vCiAgICAjIFBTRHJpdmUgYWwgcGFyc2VhciBydXRhcyBjb24gSVB2NiAoZWo6IFxEb0hBZGRyZXNzZXNcMjYwNjo0NzAwOjoxKS4KICAgICMgRml4OiByZWcuZXhlIGxsYW1hIGRpcmVjdGFtZW50ZSBhIGxhIFdpbjMyIEFQSSDigJQgc2luIGVzZSBwYXJzaW5nIGRlIHJ1dGFzLAogICAgIyBzb3BvcnRhICc6OicgZW4gbm9tYnJlcyBkZSBjbGF2ZSBkZSByZWdpc3RybyBzaW4gbmluZ3VuIHByb2JsZW1hLgogICAgcGFyYW0oW3N0cmluZ1tdXSRBZGRyZXNzZXMpCiAgICAkYmFzZSA9ICJIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxTZXJ2aWNlc1xEbnNjYWNoZVxQYXJhbWV0ZXJzXERvSEFkZHJlc3NlcyIKCiAgICBmb3JlYWNoICgkaXAgaW4gJEFkZHJlc3NlcykgewogICAgICAgIGlmICgtbm90ICRkb2hUZW1wbGF0ZXMuQ29udGFpbnNLZXkoJGlwKSkgeyBjb250aW51ZSB9CiAgICAgICAgJHRtcGwgPSAkZG9oVGVtcGxhdGVzWyRpcF0KICAgICAgICAmIHJlZyBhZGQgIiRiYXNlXCRpcCIgL3YgRG9oVGVtcGxhdGUgICAgICAgL3QgUkVHX1NaICAgIC9kICR0bXBsIC9mIDI+JjEgfCBPdXQtTnVsbAogICAgICAgICYgcmVnIGFkZCAiJGJhc2VcJGlwIiAvdiBBdXRvVXBncmFkZSAgICAgICAgL3QgUkVHX0RXT1JEIC9kIDEgICAgIC9mIDI+JjEgfCBPdXQtTnVsbAogICAgICAgICYgcmVnIGFkZCAiJGJhc2VcJGlwIiAvdiBBbGxvd0ZhbGxiYWNrVG9VZHAgL3QgUkVHX0RXT1JEIC9kIDAgICAgIC9mIDI+JjEgfCBPdXQtTnVsbAogICAgICAgICRvayA9ICgkTEFTVEVYSVRDT0RFIC1lcSAwKQogICAgICAgIFdyaXRlLUhvc3QgIiAgICBEb0ggZ2xvYmFsIFskaXBdICQoaWYgKCRvaykgeyAnW09LXScgfSBlbHNlIHsgJ1tGQUlMXScgfSkiIGAKICAgICAgICAgICAgLUZvcmVncm91bmRDb2xvciAkKGlmICgkb2spIHsgJ0RhcmtHcmF5JyB9IGVsc2UgeyAnUmVkJyB9KQogICAgfQp9CgpmdW5jdGlvbiBTZXQtSW50ZXJmYWNlRG9IIHsKICAgICMgVXNhIHJlZy5leGUgKFdpbjMyIEFQSSkgcGFyYSBldml0YXIgZWwgYnVnIGRlIHBhcnNpbmcgZGUgJzo6JyBkZSBQb3dlclNoZWxsLgogICAgIyBFc2NyaWJlIGVuIERPUyBwYXRoczogR1VJRCB5IEluZGV4LCBwb3Igc2kgV2luZG93cyB1c2EgdW5vIHUgb3RybyBzZWd1biBidWlsZC4KICAgIHBhcmFtKFtzdHJpbmddJEFkYXB0ZXJOYW1lLCBbc3RyaW5nW11dJEFkZHJlc3NlcykKICAgIHRyeSB7CiAgICAgICAgJGFkYXB0ZXIgPSBHZXQtTmV0QWRhcHRlciAtTmFtZSAkQWRhcHRlck5hbWUgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAkZ3VpZCAgICA9ICRhZGFwdGVyLkludGVyZmFjZUd1aWQgICAgIyB7eHh4eHh4eHgteHh4eC14eHh4LXh4eHgteHh4eHh4eHh4eHh4fQogICAgICAgICRpZHggICAgID0gJGFkYXB0ZXIuSW50ZXJmYWNlSW5kZXggICAjIG51bWVybyAoZWo6IDUsIDEyKQogICAgICAgICRpc2NCYXNlID0gIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XFNlcnZpY2VzXERuc2NhY2hlXEludGVyZmFjZVNwZWNpZmljUGFyYW1ldGVycyIKCiAgICAgICAgZm9yZWFjaCAoJGlwIGluICRBZGRyZXNzZXMpIHsKICAgICAgICAgICAgaWYgKC1ub3QgJGRvaFRlbXBsYXRlcy5Db250YWluc0tleSgkaXApKSB7IGNvbnRpbnVlIH0KICAgICAgICAgICAgJHRtcGwgPSAkZG9oVGVtcGxhdGVzWyRpcF0KICAgICAgICAgICAgIyBJbnRlbnRhciBjb24gR1VJRCB5IGNvbiBJbmRleCDigJQgV2luZG93cyB1c2EgdW5vIHNlZ3VuIHZlcnNpb24vYnVpbGQKICAgICAgICAgICAgZm9yZWFjaCAoJGlkIGluIEAoJGd1aWQsICIkaWR4IikpIHsKICAgICAgICAgICAgICAgICRwID0gIiRpc2NCYXNlXCRpZFxEb2hJbnRlcmZhY2VTZXR0aW5nc1wkaXAiCiAgICAgICAgICAgICAgICAmIHJlZyBhZGQgJHAgL3YgRG9oVGVtcGxhdGUgICAgICAgL3QgUkVHX1NaICAgIC9kICR0bXBsIC9mIDI+JjEgfCBPdXQtTnVsbAogICAgICAgICAgICAgICAgJiByZWcgYWRkICRwIC92IEF1dG9VcGdyYWRlICAgICAgICAvdCBSRUdfRFdPUkQgL2QgMSAgICAgL2YgMj4mMSB8IE91dC1OdWxsCiAgICAgICAgICAgICAgICAmIHJlZyBhZGQgJHAgL3YgQWxsb3dGYWxsYmFja1RvVWRwIC90IFJFR19EV09SRCAvZCAwICAgICAvZiAyPiYxIHwgT3V0LU51bGwKICAgICAgICAgICAgfQogICAgICAgICAgICAkb2sgPSAoJExBU1RFWElUQ09ERSAtZXEgMCkKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAgIERvSCBpZmFjZSBbJEFkYXB0ZXJOYW1lXVskaXBdICQoaWYgKCRvaykgeyAnW09LXScgfSBlbHNlIHsgJ1tGQUlMXScgfSkiIGAKICAgICAgICAgICAgICAgIC1Gb3JlZ3JvdW5kQ29sb3IgJChpZiAoJG9rKSB7ICdEYXJrR3JheScgfSBlbHNlIHsgJ1JlZCcgfSkKICAgICAgICB9CiAgICB9IGNhdGNoIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICAgRG9IIGlmYWNlIFskQWRhcHRlck5hbWVdIFtGQUlMXSAkXyIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgIH0KfQoKZnVuY3Rpb24gQXBwbHktRE5TIHsKICAgIHBhcmFtKAogICAgICAgIFtzdHJpbmdbXV0kQWRhcHRlck5hbWVzLAogICAgICAgIFtzdHJpbmdbXV0kQWRkcmVzc2VzLAogICAgICAgIFtzdHJpbmddJExhYmVsCiAgICApCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICQoJHR4dC5BcHBseWluZykiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgoKICAgICMgUEFTTyAxIOKAlCByZWdpc3RyYXIgdGVtcGxhdGVzIERvSCBnbG9iYWxtZW50ZSB2aWEgcmVnaXN0cm8gKElQdjQgKyBJUHY2KQogICAgaWYgKCRBZGRyZXNzZXMuQ291bnQgLWd0IDApIHsKICAgICAgICBSZWdpc3Rlci1Eb0hUZW1wbGF0ZXMgLUFkZHJlc3NlcyAkQWRkcmVzc2VzCiAgICAgICAgIyBBY3RpdmFyIERvSCBhdXRvbWF0aWNvOiBXaW5kb3dzIHVzYSBsb3MgdGVtcGxhdGVzIHBhcmEgdG9kb3MgbG9zIGFkYXB0YWRvcmVzCiAgICAgICAgJGRvaFJlZyA9ICJIS0xNOlxTWVNURU1cQ3VycmVudENvbnRyb2xTZXRcU2VydmljZXNcRG5zY2FjaGVcUGFyYW1ldGVycyIKICAgICAgICBTZXQtSXRlbVByb3BlcnR5IC1QYXRoICRkb2hSZWcgLU5hbWUgIkVuYWJsZUF1dG9Eb2giIC1WYWx1ZSAyIC1UeXBlIERXb3JkIGAKICAgICAgICAgICAgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgIH0KCiAgICBmb3JlYWNoICgkbiBpbiAkQWRhcHRlck5hbWVzKSB7CiAgICAgICAgdHJ5IHsKICAgICAgICAgICAgaWYgKCRBZGRyZXNzZXMuQ291bnQgLWVxIDApIHsKICAgICAgICAgICAgICAgIFNldC1EbnNDbGllbnRTZXJ2ZXJBZGRyZXNzIC1JbnRlcmZhY2VBbGlhcyAkbiAtUmVzZXRTZXJ2ZXJBZGRyZXNzZXMgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgW09LXSAkKCRuLlBhZFJpZ2h0KDIyKSkgJCgkdHh0Lk9rQXV0bykiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgIFdyaXRlLUxvZyAiU0VUIHwgJG4gfCBBdXRvbWF0aWMiCiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAjIFBBU08gMiDigJQgYXNpZ25hciBJUHMgKC1BZGRyZXNzRmFtaWx5IG5vIGV4aXN0ZSBlbiBXaW5QUyA1LjEpCiAgICAgICAgICAgICAgICBTZXQtRG5zQ2xpZW50U2VydmVyQWRkcmVzcyAtSW50ZXJmYWNlQWxpYXMgJG4gLVNlcnZlckFkZHJlc3NlcyAkQWRkcmVzc2VzIGAKICAgICAgICAgICAgICAgICAgICAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBbT0tdICQoJG4uUGFkUmlnaHQoMjIpKSAkKCR0eHQuT2tETlMpICRMYWJlbCIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgICAgICAgICAgV3JpdGUtTG9nICJTRVQgfCAkbiB8ICRMYWJlbCB8ICQoJEFkZHJlc3NlcyAtam9pbiAnLCAnKSIKCiAgICAgICAgICAgICAgICAjIFBBU08gMyDigJQgZXNjcmliaXIgY29uZmlnIERvSCBwb3IgaW50ZXJmYXogdmlhIHJlZ2lzdHJvIChHVUlELCBubyBub21icmUpCiAgICAgICAgICAgICAgICBTZXQtSW50ZXJmYWNlRG9IIC1BZGFwdGVyTmFtZSAkbiAtQWRkcmVzc2VzICRBZGRyZXNzZXMKICAgICAgICAgICAgfQogICAgICAgIH0gY2F0Y2ggewogICAgICAgICAgICAjcmVnaW9uIGFnZW50IGxvZwogICAgICAgICAgICBXcml0ZS1BZ2VudERiZyAtaHlwb3RoZXNpc0lkICJFIiAtbG9jYXRpb24gIkFwcGx5LUROUzpjYXRjaCIgLW1lc3NhZ2UgInNldF9kbnNfZmFpbCIgLWRhdGEgQHsgYWRhcHRlciA9ICRuOyBsYWJlbCA9ICRMYWJlbDsgZXggPSAkXy5FeGNlcHRpb24uTWVzc2FnZSB9CiAgICAgICAgICAgICNlbmRyZWdpb24KICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBbRkFJTF0gJG4gLT4gJF8iIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICAgICAgICAgIFdyaXRlLUxvZyAiRkFJTCB8ICRuIHwgJExhYmVsIHwgJF8iCiAgICAgICAgfQogICAgfQoKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgJCgkdHh0LkZsdXNoRE5TKSIgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgQ2xlYXItRG5zQ2xpZW50Q2FjaGUKICAgIFdyaXRlLUhvc3QgIiAgJCgkdHh0LkRvbmUpIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCn0KCmZ1bmN0aW9uIFNlbGVjdC1BZGFwdGVyTmFtZXMgewogICAgJGFsbCA9IEdldC1QaHlzaWNhbEFkYXB0ZXJzCiAgICBpZiAoLW5vdCAkYWxsKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiYG4gICQoJHR4dC5FcnJOb0FkYXApIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgIHJldHVybiAkbnVsbAogICAgfQogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICAkKCR0eHQuQWRhcEhlYWRlcikiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgZm9yICgkaSA9IDA7ICRpIC1sdCAkYWxsLkNvdW50OyAkaSsrKSB7CiAgICAgICAgJHN0ICAgID0gaWYgKCRhbGxbJGldLlN0YXR1cyAtZXEgIlVwIikgeyAiW1VQXSIgfSBlbHNlIHsgIlstLV0iIH0KICAgICAgICAkY29sICAgPSBpZiAoJGFsbFskaV0uU3RhdHVzIC1lcSAiVXAiKSB7ICJXaGl0ZSIgfSBlbHNlIHsgIkRhcmtHcmF5IiB9CiAgICAgICAgV3JpdGUtSG9zdCAiICBbJCgkaSsxKV0gJHN0ICQoJGFsbFskaV0uTmFtZS5QYWRSaWdodCgyMCkpICQoJGFsbFskaV0uSW50ZXJmYWNlRGVzY3JpcHRpb24pIiAtRm9yZWdyb3VuZENvbG9yICRjb2wKICAgIH0KICAgICRhbGxLZXkgPSBpZiAoJGVzKSB7ICJUIiB9IGVsc2UgeyAiQSIgfQogICAgV3JpdGUtSG9zdCAiICBbJGFsbEtleV0gJCgkdHh0LkFkYXBBbGwpIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAtTm9OZXdsaW5lICR0eHQuQWRhcFByb21wdCAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgJHNlbCA9IChSZWFkLUhvc3QpLlRyaW0oKQogICAgI3JlZ2lvbiBhZ2VudCBsb2cKICAgICRpZHhUcnkgPSAwCiAgICAkdHBPayA9IFtpbnRdOjpUcnlQYXJzZSgkc2VsLCBbcmVmXSRpZHhUcnkpCiAgICBXcml0ZS1BZ2VudERiZyAtaHlwb3RoZXNpc0lkICJEIiAtbG9jYXRpb24gIlNlbGVjdC1BZGFwdGVyTmFtZXMiIC1tZXNzYWdlICJhZGFwdGVyX3BpY2siIC1kYXRhIEB7IHNlbCA9ICRzZWw7IHRyeVBhcnNlID0gJHRwT2s7IGlkeCA9ICRpZHhUcnk7IGFkYXB0ZXJDb3VudCA9ICRhbGwuQ291bnQgfQogICAgI2VuZHJlZ2lvbgogICAgaWYgKCRzZWwgLW1hdGNoICJeW1R0QWFdJCIpIHsKICAgICAgICByZXR1cm4gJGFsbC5OYW1lCiAgICB9CiAgICAkaWR4ID0gMAogICAgaWYgKFtpbnRdOjpUcnlQYXJzZSgkc2VsLCBbcmVmXSRpZHgpIC1hbmQgJGlkeCAtZ2UgMSAtYW5kICRpZHggLWxlICRhbGwuQ291bnQpIHsKICAgICAgICByZXR1cm4gQCgkYWxsWyRpZHggLSAxXS5OYW1lKQogICAgfQogICAgV3JpdGUtSG9zdCAiYG4gICQoJHR4dC5FcnJJbnYpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgcmV0dXJuICRudWxsCn0KCmZ1bmN0aW9uIEludm9rZS1MYXRlbmN5VGVzdCB7CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICQoJHR4dC5QaW5nVGVzdGluZykiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAoIiAgIiArICgiLSIgKiA1OCkpIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgKCIgICIgKyAiU0VSVkVSIi5QYWRSaWdodCgyNikgKyAiSVAiLlBhZFJpZ2h0KDE4KSArICJBVkcgTEFURU5DWSIpIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgIFdyaXRlLUhvc3QgKCIgICIgKyAoIi0iICogNTgpKSAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAkcmVzdWx0cyA9IEAoKQogICAgZm9yZWFjaCAoJGVudHJ5IGluICRsYXRlbmN5VGFyZ2V0cy5HZXRFbnVtZXJhdG9yKCkpIHsKICAgICAgICBXcml0ZS1Ib3N0IC1Ob05ld2xpbmUgIiAgJCgkZW50cnkuS2V5LlBhZFJpZ2h0KDI2KSkkKCRlbnRyeS5WYWx1ZS5QYWRSaWdodCgxOCkpIgogICAgICAgIHRyeSB7CiAgICAgICAgICAgICRwaW5ncyA9IFRlc3QtQ29ubmVjdGlvbiAtQ29tcHV0ZXJOYW1lICRlbnRyeS5WYWx1ZSAtQ291bnQgMyAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgICAgICAkYXZnICAgPSBbbWF0aF06OlJvdW5kKCgkcGluZ3MgfCBNZWFzdXJlLU9iamVjdCAtUHJvcGVydHkgUmVzcG9uc2VUaW1lIC1BdmVyYWdlKS5BdmVyYWdlLCAxKQogICAgICAgICAgICAkYmFyICAgPSBpZiAoJGF2ZyAtbHQgMjApICB7ICJHcmVlbiIgfQogICAgICAgICAgICAgICAgICAgICBlbHNlaWYgKCRhdmcgLWx0IDYwKSB7ICJZZWxsb3ciIH0KICAgICAgICAgICAgICAgICAgICAgZWxzZSB7ICJSZWQiIH0KICAgICAgICAgICAgJGJsb2NrID0gaWYgKCRhdmcgLWx0IDIwKSAgeyAiW0ZBU1RdICAiIH0KICAgICAgICAgICAgICAgICAgICAgZWxzZWlmICgkYXZnIC1sdCA2MCkgeyAiW09LXSAgICAiIH0KICAgICAgICAgICAgICAgICAgICAgZWxzZSB7ICJbU0xPV10gICIgfQogICAgICAgICAgICBXcml0ZS1Ib3N0ICIkYmxvY2skYXZnIG1zIiAtRm9yZWdyb3VuZENvbG9yICRiYXIKICAgICAgICAgICAgJHJlc3VsdHMgKz0gW1BTQ3VzdG9tT2JqZWN0XUB7IE5hbWU9JGVudHJ5LktleTsgSVA9JGVudHJ5LlZhbHVlOyBBdmc9JGF2ZyB9CiAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgJHR4dC5Ob1Jlc3AgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgJHJlc3VsdHMgKz0gW1BTQ3VzdG9tT2JqZWN0XUB7IE5hbWU9JGVudHJ5LktleTsgSVA9JGVudHJ5LlZhbHVlOyBBdmc9OTk5OTkgfQogICAgICAgIH0KICAgIH0KICAgIFdyaXRlLUhvc3QgKCIgICIgKyAoIi0iICogNTgpKSAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICAkYmVzdCA9ICRyZXN1bHRzIHwgV2hlcmUtT2JqZWN0IHsgJF8uQXZnIC1sdCA5OTk5OSB9IHwgU29ydC1PYmplY3QgQXZnIHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgMQogICAgaWYgKCRiZXN0KSB7CiAgICAgICAgV3JpdGUtSG9zdCAiYG4gICQoJHR4dC5GYXN0ZXN0KTogIiAtTm9OZXdsaW5lIC1Gb3JlZ3JvdW5kQ29sb3IgV2hpdGUKICAgICAgICBXcml0ZS1Ib3N0ICIkKCRiZXN0Lk5hbWUpIFskKCRiZXN0LklQKV0gLSAkKCRiZXN0LkF2ZykgbXMiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICBXcml0ZS1Mb2cgIkxBVEVOQ1kgVEVTVCB8IEZhc3Rlc3Q6ICQoJGJlc3QuTmFtZSkgWyQoJGJlc3QuSVApXSAtICQoJGJlc3QuQXZnKSBtcyIKICAgIH0KfQoKZnVuY3Rpb24gSW52b2tlLUJhY2t1cCB7CiAgICAkYWRhcHRlcnMgPSBHZXQtUGh5c2ljYWxBZGFwdGVycwogICAgaWYgKC1ub3QgJGFkYXB0ZXJzKSB7IFdyaXRlLUhvc3QgImBuICAkKCR0eHQuRXJyTm9BZGFwKSIgLUZvcmVncm91bmRDb2xvciBSZWQ7IHJldHVybiB9CiAgICAkYmFja3VwID0gQHt9CiAgICBmb3JlYWNoICgkYSBpbiAkYWRhcHRlcnMpIHsKICAgICAgICAkdjQgPSAoR2V0LURuc0NsaWVudFNlcnZlckFkZHJlc3MgLUludGVyZmFjZUFsaWFzICRhLk5hbWUgLUFkZHJlc3NGYW1pbHkgSVB2NCAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSkuU2VydmVyQWRkcmVzc2VzCiAgICAgICAgJHY2ID0gKEdldC1EbnNDbGllbnRTZXJ2ZXJBZGRyZXNzIC1JbnRlcmZhY2VBbGlhcyAkYS5OYW1lIC1BZGRyZXNzRmFtaWx5IElQdjYgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUpLlNlcnZlckFkZHJlc3NlcwogICAgICAgICRiYWNrdXBbJGEuTmFtZV0gPSBAeyBJUHY0ID0gJHY0OyBJUHY2ID0gJHY2IH0KICAgIH0KICAgICRiYWNrdXAgfCBDb252ZXJ0VG8tSnNvbiAtRGVwdGggNSB8IE91dC1GaWxlIC1GaWxlUGF0aCAkYmFja3VwRmlsZSAtRW5jb2RpbmcgVVRGOAogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICAkKCR0eHQuQmFja3VwT2spIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICBXcml0ZS1Ib3N0ICIgICRiYWNrdXBGaWxlIiAgICAgICAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIFdyaXRlLUxvZyAiQkFDS1VQIFNBVkVEIHwgJGJhY2t1cEZpbGUiCn0KCmZ1bmN0aW9uIEludm9rZS1SZXN0b3JlIHsKICAgIGlmICgtbm90IChUZXN0LVBhdGggJGJhY2t1cEZpbGUpKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiIgogICAgICAgIFdyaXRlLUhvc3QgIiAgJCgkdHh0LkJhY2t1cE5vbmUpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgIFdyaXRlLUhvc3QgIiAgJGJhY2t1cEZpbGUiICAgICAgICAgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIHJldHVybgogICAgfQogICAgJGJhY2t1cCA9IEdldC1Db250ZW50ICRiYWNrdXBGaWxlIC1SYXcgfCBDb252ZXJ0RnJvbS1Kc29uCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICQoJHR4dC5BcHBseWluZykiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgZm9yZWFjaCAoJGFkYXB0ZXJOYW1lIGluICRiYWNrdXAuUFNPYmplY3QuUHJvcGVydGllcy5OYW1lKSB7CiAgICAgICAgJHY0ID0gJGJhY2t1cC4kYWRhcHRlck5hbWUuSVB2NAogICAgICAgIHRyeSB7CiAgICAgICAgICAgIGlmICgkdjQpIHsKICAgICAgICAgICAgICAgIFNldC1EbnNDbGllbnRTZXJ2ZXJBZGRyZXNzIC1JbnRlcmZhY2VBbGlhcyAkYWRhcHRlck5hbWUgLVNlcnZlckFkZHJlc3NlcyAkdjQgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIFNldC1EbnNDbGllbnRTZXJ2ZXJBZGRyZXNzIC1JbnRlcmZhY2VBbGlhcyAkYWRhcHRlck5hbWUgLVJlc2V0U2VydmVyQWRkcmVzc2VzIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgIH0KICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBbT0tdICRhZGFwdGVyTmFtZSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgICAgICBXcml0ZS1Mb2cgIlJFU1RPUkUgfCAkYWRhcHRlck5hbWUgfCBJUHY0OiAkKCR2NCAtam9pbiAnLCAnKSIKICAgICAgICB9IGNhdGNoIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICBbRkFJTF0gJGFkYXB0ZXJOYW1lIC0+ICRfIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgIH0KICAgIH0KICAgIENsZWFyLURuc0NsaWVudENhY2hlCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgICQoJHR4dC5SZXN0b3JlT2spIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCn0KCmZ1bmN0aW9uIEludm9rZS1Eb0hUb2dnbGUgewogICAgJHJlZ1BhdGggPSAiSEtMTTpcU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XFNlcnZpY2VzXERuc2NhY2hlXFBhcmFtZXRlcnMiCiAgICAkY3VycmVudCA9IChHZXQtSXRlbVByb3BlcnR5IC1QYXRoICRyZWdQYXRoIC1OYW1lICJFbmFibGVBdXRvRG9oIiAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSkuRW5hYmxlQXV0b0RvaAogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiICAkKCR0eHQuRG9IU3RhdHVzKSAiIC1Ob05ld2xpbmUgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgaWYgKCRjdXJyZW50IC1lcSAyKSB7IFdyaXRlLUhvc3QgJHR4dC5Eb0hPbiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuIH0KICAgIGVsc2UgICAgICAgICAgICAgICAgIHsgV3JpdGUtSG9zdCAkdHh0LkRvSE9mZiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdyB9CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIgIFsxXSAkKCR0eHQuRG9IT24pIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICBXcml0ZS1Ib3N0ICIgIFsyXSAkKCR0eHQuRG9IT2ZmKSIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgLU5vTmV3bGluZSAkdHh0LkRvSENob29zZSAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgJGFucyA9IChSZWFkLUhvc3QpLlRyaW0oKQoKICAgIGlmICgkYW5zIC1lcSAnMScpIHsKICAgICAgICAjIOKAlCByZWNvbGVjdGFyIHRvZGFzIGxhcyBJUHMgYWN0aXZhcyBlbiBjYWRhIGFkYXB0YWRvcgogICAgICAgICRhZGFwdGVycyAgID0gR2V0LVBoeXNpY2FsQWRhcHRlcnMKICAgICAgICAkYWRhcHRlckROUyA9IEB7fQogICAgICAgIGlmICgkYWRhcHRlcnMpIHsKICAgICAgICAgICAgZm9yZWFjaCAoJGEgaW4gJGFkYXB0ZXJzKSB7CiAgICAgICAgICAgICAgICAkdjQgPSAoR2V0LURuc0NsaWVudFNlcnZlckFkZHJlc3MgLUludGVyZmFjZUFsaWFzICRhLk5hbWUgLUFkZHJlc3NGYW1pbHkgSVB2NCAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSkuU2VydmVyQWRkcmVzc2VzCiAgICAgICAgICAgICAgICAkdjYgPSAoR2V0LURuc0NsaWVudFNlcnZlckFkZHJlc3MgLUludGVyZmFjZUFsaWFzICRhLk5hbWUgLUFkZHJlc3NGYW1pbHkgSVB2NiAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZSkuU2VydmVyQWRkcmVzc2VzCiAgICAgICAgICAgICAgICAkYWxsID0gQCgpCiAgICAgICAgICAgICAgICBpZiAoJHY0KSB7ICRhbGwgKz0gJHY0IH0KICAgICAgICAgICAgICAgIGlmICgkdjYpIHsgJGFsbCArPSAkdjYgfQogICAgICAgICAgICAgICAgaWYgKCRhbGwuQ291bnQgLWd0IDApIHsgJGFkYXB0ZXJETlNbJGEuTmFtZV0gPSAkYWxsIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICAjIOKAlCByZWdpc3RyYXIgdGVtcGxhdGVzIGdsb2JhbG1lbnRlIHZpYSByZWdpc3RybyAoSVB2NCArIElQdjYpCiAgICAgICAgJGFsbElQcyA9ICgkYWRhcHRlckROUy5WYWx1ZXMgfCBGb3JFYWNoLU9iamVjdCB7ICRfIH0gfCBTZWxlY3QtT2JqZWN0IC1VbmlxdWUpCiAgICAgICAgaWYgKCRhbGxJUHMpIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAoUmVnaXN0cmFuZG8gdGVtcGxhdGVzIERvSC4uLikiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICAgICAgUmVnaXN0ZXItRG9IVGVtcGxhdGVzIC1BZGRyZXNzZXMgJGFsbElQcwogICAgICAgIH0KICAgICAgICAjIOKAlCBFbmFibGVBdXRvRG9oID0gMgogICAgICAgIFNldC1JdGVtUHJvcGVydHkgLVBhdGggJHJlZ1BhdGggLU5hbWUgIkVuYWJsZUF1dG9Eb2giIC1WYWx1ZSAyIC1UeXBlIERXb3JkCiAgICAgICAgIyDigJQgY29uZmlnIERvSCBwb3IgaW50ZXJmYXogdmlhIHJlZ2lzdHJvIChHVUlEKQogICAgICAgIGZvcmVhY2ggKCRhZE5hbWUgaW4gJGFkYXB0ZXJETlMuS2V5cykgewogICAgICAgICAgICBTZXQtSW50ZXJmYWNlRG9IIC1BZGFwdGVyTmFtZSAkYWROYW1lIC1BZGRyZXNzZXMgJGFkYXB0ZXJETlNbJGFkTmFtZV0KICAgICAgICB9CiAgICAgICAgV3JpdGUtSG9zdCAiICAtPiAkKCR0eHQuRG9IT24pIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgV3JpdGUtTG9nICJEb0ggRU5BQkxFRCIKCiAgICB9IGVsc2VpZiAoJGFucyAtZXEgJzInKSB7CiAgICAgICAgU2V0LUl0ZW1Qcm9wZXJ0eSAtUGF0aCAkcmVnUGF0aCAtTmFtZSAiRW5hYmxlQXV0b0RvaCIgLVZhbHVlIDAgLVR5cGUgRFdvcmQKICAgICAgICBXcml0ZS1Ib3N0ICIgIC0+ICQoJHR4dC5Eb0hPZmYpIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgIFdyaXRlLUxvZyAiRG9IIERJU0FCTEVEIgoKICAgIH0gZWxzZSB7CiAgICAgICAgV3JpdGUtSG9zdCAiYG4gICQoJHR4dC5FcnJJbnYpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgIHJldHVybgogICAgfQogICAgV3JpdGUtSG9zdCAiICAkKCR0eHQuRG9ITm90ZSkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKfQoKZnVuY3Rpb24gSW52b2tlLVN0YXJ0dXBUYXNrIHsKICAgICR0YXNrTmFtZSAgICAgPSAiQXRsYXNETlNTZWxlY3RvciIKICAgICRleGlzdGluZ1Rhc2sgPSBHZXQtU2NoZWR1bGVkVGFzayAtVGFza05hbWUgJHRhc2tOYW1lIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBpZiAoJGV4aXN0aW5nVGFzaykgewogICAgICAgIFdyaXRlLUhvc3QgIiAgIiAtTm9OZXdsaW5lCiAgICAgICAgV3JpdGUtSG9zdCAtTm9OZXdsaW5lICR0eHQuVGFza0V4aXN0cyAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICRhbnMgPSAoUmVhZC1Ib3N0KS5UcmltKCkKICAgICAgICBpZiAoJGFucyAtbWF0Y2ggIl5bU3NZeV0kIikgewogICAgICAgICAgICBVbnJlZ2lzdGVyLVNjaGVkdWxlZFRhc2sgLVRhc2tOYW1lICR0YXNrTmFtZSAtQ29uZmlybTokZmFsc2UgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICAgICAgICAgV3JpdGUtSG9zdCAiICAkKCR0eHQuVGFza1JlbW92ZWQpIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICBXcml0ZS1Mb2cgIlNUQVJUVVAgVEFTSyBSRU1PVkVEIgogICAgICAgIH0KICAgIH0gZWxzZSB7CiAgICAgICAgJHNjcmlwdFBhdGggPSAkUFNDb21tYW5kUGF0aAogICAgICAgICRhY3Rpb24gICAgID0gTmV3LVNjaGVkdWxlZFRhc2tBY3Rpb24gLUV4ZWN1dGUgInBvd2Vyc2hlbGwuZXhlIiBgCiAgICAgICAgICAgICAgICAgICAgICAgICAgLUFyZ3VtZW50ICItTm9Qcm9maWxlIC1FeGVjdXRpb25Qb2xpY3kgQnlwYXNzIC1XaW5kb3dTdHlsZSBIaWRkZW4gLUZpbGUgYCIkc2NyaXB0UGF0aGAiIgogICAgICAgICR0cmlnZ2VyICAgID0gTmV3LVNjaGVkdWxlZFRhc2tUcmlnZ2VyIC1BdExvZ09uCiAgICAgICAgJHNldHRpbmdzICAgPSBOZXctU2NoZWR1bGVkVGFza1NldHRpbmdzU2V0IC1FeGVjdXRpb25UaW1lTGltaXQgKE5ldy1UaW1lU3BhbiAtTWludXRlcyA1KSAtTXVsdGlwbGVJbnN0YW5jZXMgSWdub3JlTmV3CiAgICAgICAgJHByaW5jaXBhbCAgPSBOZXctU2NoZWR1bGVkVGFza1ByaW5jaXBhbCAtUnVuTGV2ZWwgSGlnaGVzdCAtTG9nb25UeXBlIEludGVyYWN0aXZlCgogICAgICAgIFJlZ2lzdGVyLVNjaGVkdWxlZFRhc2sgLVRhc2tOYW1lICR0YXNrTmFtZSBgCiAgICAgICAgICAgIC1BY3Rpb24gJGFjdGlvbiAtVHJpZ2dlciAkdHJpZ2dlciAtU2V0dGluZ3MgJHNldHRpbmdzIC1QcmluY2lwYWwgJHByaW5jaXBhbCBgCiAgICAgICAgICAgIC1EZXNjcmlwdGlvbiAiQXRsYXMgUEMgU3VwcG9ydCAtIEROUyBTZWxlY3RvciBhdXRvLWFwcGx5IG9uIGxvZ29uIiB8IE91dC1OdWxsCgogICAgICAgIFdyaXRlLUhvc3QgIiAgJCgkdHh0LlRhc2tDcmVhdGVkKSIgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgIFdyaXRlLUxvZyAiU1RBUlRVUCBUQVNLIENSRUFURUQgfCAkc2NyaXB0UGF0aCIKICAgIH0KfQoKZnVuY3Rpb24gU2hvdy1Mb2cgewogICAgV3JpdGUtSG9zdCAiIgogICAgaWYgKC1ub3QgKFRlc3QtUGF0aCAkbG9nRmlsZSkpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICQoJHR4dC5Mb2dFbXB0eSkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICByZXR1cm4KICAgIH0KICAgICRsaW5lcyA9IEdldC1Db250ZW50ICRsb2dGaWxlIC1UYWlsIDMwCiAgICBpZiAoLW5vdCAkbGluZXMpIHsKICAgICAgICBXcml0ZS1Ib3N0ICIgICQoJHR4dC5Mb2dFbXB0eSkiIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICByZXR1cm4KICAgIH0KICAgIFdyaXRlLUhvc3QgKCIgICIgKyAoIi0iICogNjQpKSAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBmb3JlYWNoICgkbGluZSBpbiAkbGluZXMpIHsKICAgICAgICAkY29sID0gc3dpdGNoIC1SZWdleCAoJGxpbmUpIHsKICAgICAgICAgICAgIkZBSUwiICAgIHsgIlJlZCIgfQogICAgICAgICAgICAiQkFDS1VQfFJFU1RPUkUiIHsgIkN5YW4iIH0KICAgICAgICAgICAgIkRvSCIgICAgIHsgIk1hZ2VudGEiIH0KICAgICAgICAgICAgIkxBVEVOQ1kiIHsgIlllbGxvdyIgfQogICAgICAgICAgICAiVEFTSyIgICAgeyAiQmx1ZSIgfQogICAgICAgICAgICBkZWZhdWx0ICAgeyAiR3JheSIgfQogICAgICAgIH0KICAgICAgICBXcml0ZS1Ib3N0ICIgICRsaW5lIiAtRm9yZWdyb3VuZENvbG9yICRjb2wKICAgIH0KICAgIFdyaXRlLUhvc3QgKCIgICIgKyAoIi0iICogNjQpKSAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5CiAgICBXcml0ZS1Ib3N0ICIgICQoJHR4dC5Mb2dQYXRoKSRsb2dGaWxlIiAtRm9yZWdyb3VuZENvbG9yIERhcmtHcmF5Cn0KCmZ1bmN0aW9uIEludm9rZS1DdXN0b21ETlMgewogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAtTm9OZXdsaW5lICR0eHQuQ3VzdG9tUHJpbSAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgJHByaW0gPSAoUmVhZC1Ib3N0KS5UcmltKCkKICAgIGlmICgtbm90ICRwcmltKSB7IFdyaXRlLUhvc3QgIiAgJCgkdHh0LkVyckludikiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkOyByZXR1cm4gfQogICAgV3JpdGUtSG9zdCAtTm9OZXdsaW5lICR0eHQuQ3VzdG9tU2VjIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAkc2VjID0gKFJlYWQtSG9zdCkuVHJpbSgpCiAgICAkYWRkcmVzc2VzID0gaWYgKCRzZWMpIHsgQCgkcHJpbSwgJHNlYykgfSBlbHNlIHsgQCgkcHJpbSkgfQogICAgJGxhYmVsICAgICA9ICJDdXN0b20gKCQoJGFkZHJlc3NlcyAtam9pbiAnIC8gJykpIgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAtTm9OZXdsaW5lICIgICQoJHR4dC5DdXN0b21BcHBseSkiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAkYW5zID0gKFJlYWQtSG9zdCkuVHJpbSgpCiAgICBpZiAoJGFucyAtbWF0Y2ggIl5bU3NZeV0kIikgewogICAgICAgICRhZGFwdGVycyA9IEdldC1QaHlzaWNhbEFkYXB0ZXJzCiAgICAgICAgaWYgKC1ub3QgJGFkYXB0ZXJzKSB7IFdyaXRlLUhvc3QgIiAgJCgkdHh0LkVyck5vQWRhcCkiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkOyByZXR1cm4gfQogICAgICAgIEFwcGx5LUROUyAtQWRhcHRlck5hbWVzICRhZGFwdGVycy5OYW1lIC1BZGRyZXNzZXMgJGFkZHJlc3NlcyAtTGFiZWwgJGxhYmVsCiAgICB9IGVsc2UgewogICAgICAgICRzZWxlY3RlZCA9IFNlbGVjdC1BZGFwdGVyTmFtZXMKICAgICAgICBpZiAoJHNlbGVjdGVkKSB7IEFwcGx5LUROUyAtQWRhcHRlck5hbWVzICRzZWxlY3RlZCAtQWRkcmVzc2VzICRhZGRyZXNzZXMgLUxhYmVsICRsYWJlbCB9CiAgICB9Cn0KCmZ1bmN0aW9uIEludm9rZS1QZXJBZGFwdGVyRE5TIHsKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiAgJCgkdHh0LlByb21wdEROU09wdCkiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgZm9yZWFjaCAoJGsgaW4gJGRuc1Byb2ZpbGVzLktleXMpIHsKICAgICAgICAkbGFiZWwgPSAkZG5zUHJvZmlsZXNbJGtdLkxhYmVsCiAgICAgICAgV3JpdGUtSG9zdCAiICBbJGtdICRsYWJlbCIgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgfQogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAtTm9OZXdsaW5lICIgID4+ICIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICRkbnNPcHQgPSAoUmVhZC1Ib3N0KS5UcmltKCkKICAgIGlmICgkZG5zUHJvZmlsZXMuS2V5cyAtY29udGFpbnMgJGRuc09wdCkgewogICAgICAgICRwcm9maWxlICA9ICRkbnNQcm9maWxlc1skZG5zT3B0XQogICAgICAgICRzZWxlY3RlZCA9IFNlbGVjdC1BZGFwdGVyTmFtZXMKICAgICAgICBpZiAoJHNlbGVjdGVkKSB7CiAgICAgICAgICAgIEFwcGx5LUROUyAtQWRhcHRlck5hbWVzICRzZWxlY3RlZCAtQWRkcmVzc2VzICRwcm9maWxlLkFkZHIgLUxhYmVsICRwcm9maWxlLkxhYmVsCiAgICAgICAgfQogICAgfSBlbHNlaWYgKCRkbnNPcHQgLWVxICcxNicpIHsKICAgICAgICBJbnZva2UtQ3VzdG9tRE5TCiAgICB9IGVsc2UgewogICAgICAgIFdyaXRlLUhvc3QgImBuICAkKCR0eHQuRXJySW52KSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgIH0KfQoKI2VuZHJlZ2lvbgoKI3JlZ2lvbiDilIDilIAgTG9vcCBQcmluY2lwYWwg4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA77+977+94pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACmRvIHsKICAgIENsZWFyLUhvc3QKICAgICRzd1Byb2JlID0gJG51bGwKICAgICRzd0VyciA9ICRudWxsCiAgICB0cnkgeyAkc3dQcm9iZSA9ICRIb3N0LlVJLlJhd1VJLldpbmRvd1NpemUuV2lkdGggfSBjYXRjaCB7ICRzd0VyciA9ICRfLkV4Y2VwdGlvbi5NZXNzYWdlIH0KICAgICNyZWdpb24gYWdlbnQgbG9nCiAgICBXcml0ZS1BZ2VudERiZyAtaHlwb3RoZXNpc0lkICJCIiAtbG9jYXRpb24gIm1haW46bG9vcCIgLW1lc3NhZ2UgIm1lbnVfd2luZG93c2l6ZSIgLWRhdGEgQHsgc3dQcm9iZSA9ICRzd1Byb2JlOyBzd0VyciA9ICRzd0VycjsgaG9zdCA9ICRIb3N0Lk5hbWUgfQogICAgI2VuZHJlZ2lvbgogICAgJHNjcmVlblcgID0gJEhvc3QuVUkuUmF3VUkuV2luZG93U2l6ZS5XaWR0aAogICAgJG1lbnVXICAgID0gNjQKICAgICRsbSAgICAgICA9ICIgIiAqIFttYXRoXTo6TWF4KDAsIFttYXRoXTo6Rmxvb3IoKCRzY3JlZW5XIC0gJG1lbnVXKSAvIDIpKQogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtQ2VudGVyZWQgIiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMiICJZZWxsb3ciCiAgICBXcml0ZS1DZW50ZXJlZCAiIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyIgIlllbGxvdyIKICAgIFdyaXRlLUNlbnRlcmVkICIjICAgICAgICAgICBBIFQgTCBBIFMgICBQIEMgICBTIFUgUCBQIE8gUiBUICAgICAgICAgICAgICAgICAgIyIgIlllbGxvdyIKICAgIFdyaXRlLUNlbnRlcmVkICIjICAgICAgICAgICAgICBETlMgU2VsZWN0b3IgIHYyLjAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMiICJZZWxsb3ciCiAgICBXcml0ZS1DZW50ZXJlZCAiIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyIgIlllbGxvdyIKICAgIFdyaXRlLUNlbnRlcmVkICIjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIiAiWWVsbG93IgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiJGxtWyAkKCR0eHQuQ3VycmVudEROUykgXSIgLUZvcmVncm91bmRDb2xvciBEYXJrQ3lhbgogICAgJHN0YXR1c0xpbmVzID0gR2V0LUROU1N0YXR1c0xpbmVzCiAgICBmb3JlYWNoICgkc2wgaW4gJHN0YXR1c0xpbmVzKSB7CiAgICAgICAgV3JpdGUtSG9zdCAiJGxtJCgkc2wuVGV4dCkiIC1Gb3JlZ3JvdW5kQ29sb3IgJHNsLkNvbG9yCiAgICB9CiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIkbG0kKCR0eHQuT3B0MSkiIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5IZWFkZXJDRikiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDIpIgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDMpIgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDQpIgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0LkhlYWRlckdHKSIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICBXcml0ZS1Ib3N0ICIkbG0kKCR0eHQuT3B0NSkiCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIkbG0kKCR0eHQuSGVhZGVyUTkpIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5PcHQ2KSIKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5IZWFkZXJPRCkiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDcpIgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDgpIgogICAgV3JpdGUtSG9zdCAiIgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0LkhlYWRlck1WKSIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICBXcml0ZS1Ib3N0ICIkbG0kKCR0eHQuT3B0OSkiCiAgICBXcml0ZS1Ib3N0ICIkbG0kKCR0eHQuT3B0MTApIgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDExKSIKICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5PcHQxMikiCiAgICBXcml0ZS1Ib3N0ICIkbG0kKCR0eHQuT3B0MTMpIgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDE0KSIKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5IZWFkZXJORCkiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDE1KSIKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5IZWFkZXJDVSkiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDE2KSIKICAgIFdyaXRlLUhvc3QgIiIKICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5IZWFkZXJUb29scykiIC1Gb3JlZ3JvdW5kQ29sb3IgTWFnZW50YQogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDE3KSIKICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5PcHQxOCkiCiAgICBXcml0ZS1Ib3N0ICIkbG0kKCR0eHQuT3B0MTkpIgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDIwKSIKICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5PcHQyMSkiCiAgICBXcml0ZS1Ib3N0ICIkbG0kKCR0eHQuT3B0MjIpIgogICAgV3JpdGUtSG9zdCAiJGxtJCgkdHh0Lk9wdDIzKSIKICAgIFdyaXRlLUhvc3QgIiRsbSQoJHR4dC5PcHQyNCkiCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0ICIkbG0kKCR0eHQuT3B0MCkiIC1Gb3JlZ3JvdW5kQ29sb3IgUmVkCiAgICBXcml0ZS1Ib3N0ICIiCiAgICBXcml0ZS1Ib3N0IC1Ob05ld2xpbmUgIiRsbSQoJHR4dC5Qcm9tcHQpOiAiIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAkcmF3TWVudSA9IFJlYWQtSG9zdAogICAgaWYgKCRudWxsIC1lcSAkcmF3TWVudSkgeyAkcmF3TWVudSA9ICIiIH0KICAgICRvcGNpb24gPSAkcmF3TWVudS5UcmltKCkKICAgICRwYXJzZWQgPSAwCiAgICAkaXNOdW0gID0gW2ludF06OlRyeVBhcnNlKCRvcGNpb24sIFtyZWZdJHBhcnNlZCkKICAgICNyZWdpb24gYWdlbnQgbG9nCiAgICAkaW5Qcm9maWxlID0gJGRuc1Byb2ZpbGVzLktleXMgLWNvbnRhaW5zICRvcGNpb24KICAgICRvcGNMZW4gPSBpZiAoJG51bGwgLW5lICRvcGNpb24pIHsgJG9wY2lvbi5MZW5ndGggfSBlbHNlIHsgLTEgfQogICAgV3JpdGUtQWdlbnREYmcgLWh5cG90aGVzaXNJZCAiQyIgLWxvY2F0aW9uICJtYWluOm1lbnUiIC1tZXNzYWdlICJvcHRpb25fcmVhZCIgLWRhdGEgQHsKICAgICAgICBvcGNpb24gICAgID0gJChpZiAoJG51bGwgLWVxICRvcGNpb24pIHsgIjxudWxsPiIgfSBlbHNlaWYgKCRvcGNpb24gLWVxICIiKSB7ICI8ZW1wdHk+IiB9IGVsc2UgeyAkb3BjaW9uIH0pCiAgICAgICAgb3BjTGVuICAgICA9ICRvcGNMZW4KICAgICAgICBpc051bSAgICAgID0gJGlzTnVtCiAgICAgICAgcGFyc2VkICAgICA9ICRwYXJzZWQKICAgICAgICBpblByb2ZpbGUgID0gJGluUHJvZmlsZQogICAgICAgIHJ1bklkICAgICAgPSAicG9zdC1maXgiCiAgICB9CiAgICAjZW5kcmVnaW9uCiAgICBpZiAoJG9wY2lvbiAtZXEgJzAnKSB7IGJyZWFrIH0KICAgIGlmIChbc3RyaW5nXTo6SXNOdWxsT3JXaGl0ZVNwYWNlKCRvcGNpb24pKSB7CiAgICAgICAgI3JlZ2lvbiBhZ2VudCBsb2cKICAgICAgICBXcml0ZS1BZ2VudERiZyAtaHlwb3RoZXNpc0lkICJDIiAtbG9jYXRpb24gIm1haW46bWVudSIgLW1lc3NhZ2UgImJsYW5rX2lucHV0X3Nob3dfZXJyIiAtZGF0YSBAeyBydW5JZCA9ICJwb3N0LWZpeCIgfQogICAgICAgICNlbmRyZWdpb24KICAgICAgICBXcml0ZS1Ib3N0ICJgbiAgJCgkdHh0LkVyckJsYW5rKSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICBQcmVzcy1BbnlLZXkKICAgICAgICBjb250aW51ZQogICAgfQogICAgc3dpdGNoICgkb3BjaW9uKSB7CiAgICAgICAgeyAkZG5zUHJvZmlsZXMuS2V5cyAtY29udGFpbnMgJF8gfSB7CiAgICAgICAgICAgICRwcm9maWxlICA9ICRkbnNQcm9maWxlc1skb3BjaW9uXQogICAgICAgICAgICAkYWRhcHRlcnMgPSBHZXQtUGh5c2ljYWxBZGFwdGVycwogICAgICAgICAgICBpZiAoLW5vdCAkYWRhcHRlcnMpIHsKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgImBuICAkKCR0eHQuRXJyTm9BZGFwKSIgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIEFwcGx5LUROUyAtQWRhcHRlck5hbWVzICRhZGFwdGVycy5OYW1lIC1BZGRyZXNzZXMgJHByb2ZpbGUuQWRkciAtTGFiZWwgJHByb2ZpbGUuTGFiZWwKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICAnMTYnIHsgSW52b2tlLUN1c3RvbUROUyB9CiAgICAgICAgJzE3JyB7IEludm9rZS1MYXRlbmN5VGVzdCB9CiAgICAgICAgJzE4JyB7IEludm9rZS1CYWNrdXAgfQogICAgICAgICcxOScgeyBJbnZva2UtUmVzdG9yZSB9CiAgICAgICAgJzIwJyB7IEludm9rZS1Eb0hUb2dnbGUgfQogICAgICAgICcyMScgeyBJbnZva2UtU3RhcnR1cFRhc2sgfQogICAgICAgICcyMicgeyBTaG93LUxvZyB9CiAgICAgICAgJzIzJyB7IEludm9rZS1QZXJBZGFwdGVyRE5TIH0KICAgICAgICAnMjQnIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAiYG4gICQoJHR4dC5PcGVuaW5nKSIgLUZvcmVncm91bmRDb2xvciBNYWdlbnRhCiAgICAgICAgICAgIFN0YXJ0LVByb2Nlc3MgImh0dHBzOi8vd3d3LmNsb3VkZmxhcmUuY29tL3NzbC9lbmNyeXB0ZWQtc25pLyIKICAgICAgICB9CiAgICAgICAgZGVmYXVsdCB7CiAgICAgICAgICAgIGlmICgkb3BjaW9uIC1uZSAnJykgewogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiYG4gICQoJHR4dC5FcnJJbnYpIiAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfQogICAgUHJlc3MtQW55S2V5Cn0gd2hpbGUgKCR0cnVlKQpXcml0ZS1Ib3N0ICIiCldyaXRlLUNlbnRlcmVkICIkKGlmICgkZXMpIHsgJ0dyYWNpYXMgcG9yIHVzYXIgQXRsYXMgUEMgU3VwcG9ydC4gSGFzdGEgbHVlZ28hJyB9IGVsc2UgeyAnVGhhbmsgeW91IGZvciB1c2luZyBBdGxhcyBQQyBTdXBwb3J0LiBHb29kYnllIScgfSkiICJZZWxsb3ciCldyaXRlLUhvc3QgIiIKI2VuZHJlZ2lvbgp9Cg=='
$script:AtlasToolSources['Invoke-SoftwareInstaller'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtU29mdHdhcmVJbnN0YWxsZXIKIyBNaWdyYWRvIGRlOiBTb2Z0d2FyZV9JbnN0YWxsZXIucHMxCiMgQXRsYXMgUEMgU3VwcG9ydCDigJQgdjEuMAojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gSW52b2tlLVNvZnR3YXJlSW5zdGFsbGVyIHsKICAgIFtDbWRsZXRCaW5kaW5nKCldCiAgICBwYXJhbSgpCiYgewogICAgJEhvc3QuVUkuUmF3VUkuV2luZG93VGl0bGUgPSAiQXRsYXMgUEMgU3VwcG9ydCAtIFBhbmVsIE1hZXN0cm8gdjIuMSIKICAgIAogICAgIyAtLS0gRElDQ0lPTkFSSU8gREUgUFJPR1JBTUFTIC0tLQogICAgJHByb2dyYW1hcyA9IEAoCiAgICAgICAgW3BzY3VzdG9tb2JqZWN0XUB7IElEID0gMTsgQ2F0ID0gIk5hdmVnYWRvcmVzIjsgTm9tYnJlID0gIkNocm9tZSI7IFdpbmdldElEID0gIkdvb2dsZS5DaHJvbWUiIH0KICAgICAgICBbcHNjdXN0b21vYmplY3RdQHsgSUQgPSAyOyBDYXQgPSAiTmF2ZWdhZG9yZXMiOyBOb21icmUgPSAiRmlyZWZveCI7IFdpbmdldElEID0gIk1vemlsbGEuRmlyZWZveCIgfQogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDM7IENhdCA9ICJOYXZlZ2Fkb3JlcyI7IE5vbWJyZSA9ICJCcmF2ZSI7IFdpbmdldElEID0gIkJyYXZlLkJyYXZlIiB9CiAgICAgICAgW3BzY3VzdG9tb2JqZWN0XUB7IElEID0gNDsgQ2F0ID0gIk5hdmVnYWRvcmVzIjsgTm9tYnJlID0gIk9wZXJhIjsgV2luZ2V0SUQgPSAiT3BlcmEuT3BlcmEiIH0KICAgICAgICBbcHNjdXN0b21vYmplY3RdQHsgSUQgPSA1OyBDYXQgPSAiTmF2ZWdhZG9yZXMiOyBOb21icmUgPSAiRHVja0R1Y2tHbyI7IFdpbmdldElEID0gIkR1Y2tEdWNrR28uRGVza3RvcEJyb3dzZXIiIH0KICAgICAgICBbcHNjdXN0b21vYmplY3RdQHsgSUQgPSA2OyBDYXQgPSAiTmF2ZWdhZG9yZXMiOyBOb21icmUgPSAiVml2YWxkaSI7IFdpbmdldElEID0gIlZpdmFsZGlUZWNobm9sb2dpZXMuVml2YWxkaSIgfQogICAgICAgIAogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDc7IENhdCA9ICJVdGlsaWRhZGVzIjsgTm9tYnJlID0gIldpblJBUiI7IFdpbmdldElEID0gIlJBUkxhYi5XaW5SQVIiIH0KICAgICAgICBbcHNjdXN0b21vYmplY3RdQHsgSUQgPSA4OyBDYXQgPSAiVXRpbGlkYWRlcyI7IE5vbWJyZSA9ICI3LVppcCI7IFdpbmdldElEID0gIjd6aXAuN3ppcCIgfQogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDk7IENhdCA9ICJVdGlsaWRhZGVzIjsgTm9tYnJlID0gIkFkb2JlIFBERiI7IFdpbmdldElEID0gIkFkb2JlLkFjcm9iYXQuUmVhZGVyLjY0LWJpdCIgfQogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDEwOyBDYXQgPSAiVXRpbGlkYWRlcyI7IE5vbWJyZSA9ICJQREYyNCI7IFdpbmdldElEID0gImdlZWtzb2Z0d2FyZUdtYkguUERGMjRDcmVhdG9yIiB9CiAgICAgICAgW3BzY3VzdG9tb2JqZWN0XUB7IElEID0gMTE7IENhdCA9ICJVdGlsaWRhZGVzIjsgTm9tYnJlID0gIkFueURlc2siOyBXaW5nZXRJRCA9ICJBbnlEZXNrU29mdHdhcmUuQW55RGVzayIgfQogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDEyOyBDYXQgPSAiVXRpbGlkYWRlcyI7IE5vbWJyZSA9ICJSdXN0RGVzayI7IFdpbmdldElEID0gIlJ1c3REZXNrLlJ1c3REZXNrIiB9CiAgICAgICAgCiAgICAgICAgW3BzY3VzdG9tb2JqZWN0XUB7IElEID0gMTM7IENhdCA9ICJTb2NpYWwiOyBOb21icmUgPSAiV2hhdHNBcHAiOyBXaW5nZXRJRCA9ICI5TktTUUdQN0YyTkgiOyBTb3VyY2UgPSAibXNzdG9yZSIgfQogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDE0OyBDYXQgPSAiU29jaWFsIjsgTm9tYnJlID0gIlRlbGVncmFtIjsgV2luZ2V0SUQgPSAiVGVsZWdyYW0uVGVsZWdyYW1EZXNrdG9wIiB9CiAgICAgICAgW3BzY3VzdG9tb2JqZWN0XUB7IElEID0gMTU7IENhdCA9ICJTb2NpYWwiOyBOb21icmUgPSAiWm9vbSI7IFdpbmdldElEID0gIlpvb20uWm9vbSIgfQogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDE2OyBDYXQgPSAiU29jaWFsIjsgTm9tYnJlID0gIlRlYW1zIjsgV2luZ2V0SUQgPSAiTWljcm9zb2Z0LlRlYW1zIiB9CgogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDE3OyBDYXQgPSAiTXVsdGltZWRpYSI7IE5vbWJyZSA9ICJWTEMgUGxheWVyIjsgV2luZ2V0SUQgPSAiVmlkZW9MQU4uVkxDIiB9CiAgICAgICAgW3BzY3VzdG9tb2JqZWN0XUB7IElEID0gMTg7IENhdCA9ICJNdWx0aW1lZGlhIjsgTm9tYnJlID0gIlNwb3RpZnkiOyBXaW5nZXRJRCA9ICJTcG90aWZ5LlNwb3RpZnkiIH0KCiAgICAgICAgW3BzY3VzdG9tb2JqZWN0XUB7IElEID0gMTk7IENhdCA9ICJHYW1pbmciOyBOb21icmUgPSAiU3RlYW0iOyBXaW5nZXRJRCA9ICJWYWx2ZS5TdGVhbSIgfQogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDIwOyBDYXQgPSAiR2FtaW5nIjsgTm9tYnJlID0gIkVwaWMgR2FtZXMiOyBXaW5nZXRJRCA9ICJFcGljR2FtZXMuRXBpY0dhbWVzTGF1bmNoZXIiIH0KICAgICAgICBbcHNjdXN0b21vYmplY3RdQHsgSUQgPSAyMTsgQ2F0ID0gIkdhbWluZyI7IE5vbWJyZSA9ICJEaXNjb3JkIjsgV2luZ2V0SUQgPSAiRGlzY29yZC5EaXNjb3JkIiB9CgogICAgICAgIFtwc2N1c3RvbW9iamVjdF1AeyBJRCA9IDIyOyBDYXQgPSAiTWFudGVuaW1pZW50byI7IE5vbWJyZSA9ICJMaW1waWFyIFRlbXAiOyBXaW5nZXRJRCA9ICJDTEVBTlVQIiB9CiAgICAgICAgW3BzY3VzdG9tb2JqZWN0XUB7IElEID0gMjM7IENhdCA9ICJNYW50ZW5pbWllbnRvIjsgTm9tYnJlID0gIkFjdHVhbGl6YXIgQXBwcyI7IFdpbmdldElEID0gIlVQR1JBREUiIH0KICAgICkKCiAgICAkc2lsZW5jaW9zbyA9IEAoIi0tYWNjZXB0LXBhY2thZ2UtYWdyZWVtZW50cyIsICItLWFjY2VwdC1zb3VyY2UtYWdyZWVtZW50cyIsICItZSIsICItLXNpbGVudCIpCgogICAgIyAtLS0gSU5JQ0lPIERFTCBCVUNMRSAtLS0KICAgIGRvIHsKICAgICAgICBDbGVhci1Ib3N0CiAgICAgICAgV3JpdGUtSG9zdCAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgV3JpdGUtSG9zdCAiICAgICAgICAgICAgICAgIEFUTEFTIFBDIFNVUFBPUlQgLSBQQU5FTCBERSBDT05UUk9MICAgICAgICAgICAgICAgICAgICIgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICBXcml0ZS1Ib3N0ICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KCiAgICAgICAgIyBSZW5kZXJpemFkbyBkZWwgbWVuw7ogY29uIGNhdGVnb3LDrWFzCiAgICAgICAgJGNhdHMgPSAkcHJvZ3JhbWFzIHwgU2VsZWN0LU9iamVjdCAtRXhwYW5kUHJvcGVydHkgQ2F0IC1VbmlxdWUKICAgICAgICBmb3JlYWNoICgkYyBpbiAkY2F0cykgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbi0tLSAkKCRjLlRvVXBwZXIoKSkgLS0tIiAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgICAgICAkYXBwc0NhdCA9ICRwcm9ncmFtYXMgfCBXaGVyZS1PYmplY3QgeyAkXy5DYXQgLWVxICRjIH0KICAgICAgICAgICAgZm9yICgkaSA9IDA7ICRpIC1sdCAkYXBwc0NhdC5Db3VudDsgJGkgKz0gMykgewogICAgICAgICAgICAgICAgJGxpbmVhID0gIiIKICAgICAgICAgICAgICAgIGZvciAoJGogPSAwOyAkaiAtbHQgMzsgJGorKykgewogICAgICAgICAgICAgICAgICAgIGlmICgoJGkgKyAkaikgLWx0ICRhcHBzQ2F0LkNvdW50KSB7CiAgICAgICAgICAgICAgICAgICAgICAgICRwID0gJGFwcHNDYXRbJGkgKyAkal0KICAgICAgICAgICAgICAgICAgICAgICAgJHRleHRvID0gIlskKCRwLklEKV0gJCgkcC5Ob21icmUpIgogICAgICAgICAgICAgICAgICAgICAgICAkbGluZWEgKz0gJHRleHRvLlBhZFJpZ2h0KDIzKQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgIiAgJGxpbmVhIgogICAgICAgICAgICB9CiAgICAgICAgfQoKICAgICAgICBXcml0ZS1Ib3N0ICJgbj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgIFdyaXRlLUhvc3QgIiAgW1NdIEJVU0NBRE9SIE1BTlVBTCAgIFtRXSBTQUxJUiIgLUZvcmVncm91bmRDb2xvciBNYWdlbnRhCiAgICAgICAgV3JpdGUtSG9zdCAiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIgLUZvcmVncm91bmRDb2xvciBDeWFuCgogICAgICAgICRzZWxlY2Npb24gPSBSZWFkLUhvc3QgImBuRXNjcmliZSBsb3MgbsO6bWVyb3MgKGNvbWFzKSBvIGxldHJhIgogICAgICAgIAogICAgICAgIGlmICgkc2VsZWNjaW9uLlRyaW0oKS5Ub1VwcGVyKCkgLWVxICdRJykgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbkNlcnJhbmRvIGhlcnJhbWllbnRhcyBBdGxhcy4uLiDCoUJ1ZW4gdHJhYmFqbyEiIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgICAgICBicmVhawogICAgICAgIH0gZWxzZWlmICgkc2VsZWNjaW9uLlRyaW0oKS5Ub1VwcGVyKCkgLWVxICdTJykgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbltCVVNDQURPUiBNQU5VQUxdIiAtRm9yZWdyb3VuZENvbG9yIE1hZ2VudGEKICAgICAgICAgICAgJGJ1c3F1ZWRhID0gUmVhZC1Ib3N0ICJOb21icmUgZGVsIHByb2dyYW1hIgogICAgICAgICAgICB3aW5nZXQgc2VhcmNoICRidXNxdWVkYQogICAgICAgICAgICAkaWRfbWFudWFsID0gUmVhZC1Ib3N0ICJgbklEIHBhcmEgaW5zdGFsYXIgKEVudGVyIHBhcmEgdm9sdmVyKSIKICAgICAgICAgICAgaWYgKCRpZF9tYW51YWwpIHsgCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICJgbkluc3RhbGFuZG8gJGlkX21hbnVhbC4uLiIgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgICAgICAgICB3aW5nZXQgaW5zdGFsbCAtLWlkICRpZF9tYW51YWwgJHNpbGVuY2lvc28gCiAgICAgICAgICAgICAgICBSZWFkLUhvc3QgImBuSW5zdGFsYWNpw7NuIGZpbmFsaXphZGEuIFByZXNpb25hIEVudGVyIHBhcmEgdm9sdmVyIGFsIG1lbsO6LiIKICAgICAgICAgICAgfQogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICRpZHNFbGVnaWRvcyA9ICRzZWxlY2Npb24gLXNwbGl0ICcsJyB8IEZvckVhY2gtT2JqZWN0IHsgJF8uVHJpbSgpIH0KICAgICAgICAgICAgZm9yZWFjaCAoJGlkIGluICRpZHNFbGVnaWRvcykgewogICAgICAgICAgICAgICAgJGFwcCA9ICRwcm9ncmFtYXMgfCBXaGVyZS1PYmplY3QgeyBbc3RyaW5nXSRfLklEIC1lcSAkaWQgfQogICAgICAgICAgICAgICAgaWYgKCRhcHApIHsKICAgICAgICAgICAgICAgICAgICBpZiAoJGFwcC5XaW5nZXRJRCAtZXEgIkNMRUFOVVAiKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgImBuWytdIExpbXBpYW5kbyB0ZW1wb3JhbGVzLi4uIiAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgICAgICAgICAgICAgIFJlbW92ZS1JdGVtIC1QYXRoICRlbnY6VEVNUFwqIC1SZWN1cnNlIC1Gb3JjZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICJbT0tdIFRlbXBvcmFsZXMgbGltcGlvcy4iCiAgICAgICAgICAgICAgICAgICAgfSBlbHNlaWYgKCRhcHAuV2luZ2V0SUQgLWVxICJVUEdSQURFIikgewogICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICJgblsrXSBBY3R1YWxpemFuZG8gYXBsaWNhY2lvbmVzLi4uIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgICAgICAgICAgICAgICAgICAgICAgd2luZ2V0IHVwZ3JhZGUgLS1hbGwgJHNpbGVuY2lvc28KICAgICAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICJgblsrXSBJbnN0YWxhbmRvICQoJGFwcC5Ob21icmUpLi4uIiAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCRhcHAuU291cmNlIC1lcSAibXNzdG9yZSIpIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdpbmdldCBpbnN0YWxsIC0taWQgJCgkYXBwLldpbmdldElEKSAtLXNvdXJjZSBtc3N0b3JlIC0tYWNjZXB0LXBhY2thZ2UtYWdyZWVtZW50cyAtLWFjY2VwdC1zb3VyY2UtYWdyZWVtZW50cyAtZQogICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgd2luZ2V0IGluc3RhbGwgLS1pZCAkKCRhcHAuV2luZ2V0SUQpICRzaWxlbmNpb3NvCiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAiW09LXSAkKCRhcHAuTm9tYnJlKSBsaXN0by4iIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKCRzZWxlY2Npb24gLW5lICIiKSB7CiAgICAgICAgICAgICAgICBSZWFkLUhvc3QgImBuVGFyZWEgZmluYWxpemFkYS4gUHJlc2lvbmEgRW50ZXIgcGFyYSB2b2x2ZXIgYWwgbWVuw7ogcHJpbmNpcGFsLiIKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0gd2hpbGUgKCR0cnVlKQp9Cn0K'
$script:AtlasToolSources['Invoke-StopServices'] = 'IyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBJbnZva2UtU3RvcFNlcnZpY2VzCiMgT3B0aW1pemFjaW9uIGRlIHNlcnZpY2lvcyBjb24gVU5ETyArIGFuYWxpc2lzIGRlIHNlZ3VyaWRhZC4KIyBBdGxhcyBQQyBTdXBwb3J0IC0gdjIuMAojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKZnVuY3Rpb24gSW52b2tlLVN0b3BTZXJ2aWNlcyB7CiAgICBbQ21kbGV0QmluZGluZygpXQogICAgcGFyYW0oKQoKICAgIHRyeSB7ICRIb3N0LlVJLlJhd1VJLldpbmRvd1RpdGxlID0gIkFUTEFTIFBDIFNVUFBPUlQgLSBTVE9QIFNFUlZJQ0VTIiB9IGNhdGNoIHt9CiAgICBDbGVhci1Ib3N0CgogICAgIyBEaXJlY3RvcmlvIGRlIGJhY2t1cAogICAgJGJhY2t1cERpciA9IEpvaW4tUGF0aCAkZW52OkxPQ0FMQVBQREFUQSAnQXRsYXNQQycKICAgIGlmICgtbm90IChUZXN0LVBhdGggJGJhY2t1cERpcikpIHsKICAgICAgICBOZXctSXRlbSAtSXRlbVR5cGUgRGlyZWN0b3J5IC1QYXRoICRiYWNrdXBEaXIgLUZvcmNlIHwgT3V0LU51bGwKICAgIH0KICAgICRiYWNrdXBGaWxlID0gSm9pbi1QYXRoICRiYWNrdXBEaXIgJ3NlcnZpY2VzLWJhY2t1cC5qc29uJwoKICAgICMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAjIExJU1RBIERFIFNFUlZJQ0lPUwogICAgIyBUaWVyIFNBRkUgICAgIDogc2VndXJvcyBlbiA5OSUgZGUgZXF1aXBvcyAoWGJveCwgdGVsZW1ldHJpYSwgZmF4KS4KICAgICMgVGllciBNT0RFUkFURSA6IGRlcGVuZGVuIGRlbCB1c28gKFNlbnNvclNlcnZpY2UgZW4gbGFwdG9wcywgV2Jpb1NydmMgc2kKICAgICMgICAgICAgICAgICAgICAgIHVzYXMgV2luZG93cyBIZWxsbywgZXRjKS4gU2UgcGlkZW4gY29uZmlybWFjaW9uZXMgZXh0cmEuCiAgICAjIENhZGEgZW50cmFkYSBpbmNsdXllICdSZXF1aXJlcycgY29uIElEcyBkZSBzaXR1YWNpb25lcyBlbiBsYXMgcXVlIGVsCiAgICAjIHNlcnZpY2lvIFNJIGhhY2UgZmFsdGEsIHBhcmEgaW1wcmltaXIgYWR2ZXJ0ZW5jaWFzLgogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCiAgICAkc2VydmljaW9zQU9wdGltaXphciA9IEAoCiAgICAgICAgIyAtLS0gVElFUiBTQUZFIC0tLQogICAgICAgIEB7IE5hbWU9J0RpYWdUcmFjayc7ICAgICAgICAgICBUaWVyPSdTQUZFJzsgRGVzYz0nVGVsZW1ldHJpYSAoQ29ubmVjdGVkIFVzZXIgRXhwZXJpZW5jZXMpJzsgTm90ZT0nTm8gYWZlY3RhIGZ1bmNpb25hbGlkYWQuJyB9LAogICAgICAgIEB7IE5hbWU9J2Rtd2FwcHVzaHNlcnZpY2UnOyAgICBUaWVyPSdTQUZFJzsgRGVzYz0nV0FQIFB1c2ggTWVzc2FnZSBSb3V0aW5nJzsgICAgICAgICAgICAgICAgIE5vdGU9J1NvbG8gYWZlY3RhIFNNUyBwdXNoIGVuIGVtcHJlc2EuJyB9LAogICAgICAgIEB7IE5hbWU9J1dlclN2Yyc7ICAgICAgICAgICAgICBUaWVyPSdTQUZFJzsgRGVzYz0nUmVwb3J0ZSBkZSBlcnJvcmVzIGRlIFdpbmRvd3MnOyAgICAgICAgICAgTm90ZT0nU29sbyBkZWphIGRlIG1hbmRhciBjcmFzaGVzIGEgTVMuJyB9LAogICAgICAgIEB7IE5hbWU9J3dpc3ZjJzsgICAgICAgICAgICAgICBUaWVyPSdTQUZFJzsgRGVzYz0nV2luZG93cyBJbnNpZGVyJzsgICAgICAgICAgICAgICAgICAgICAgICAgTm90ZT0nU29sbyBzaSBubyBlcmVzIEluc2lkZXIuJyB9LAogICAgICAgIEB7IE5hbWU9J1BjYVN2Yyc7ICAgICAgICAgICAgICBUaWVyPSdTQUZFJzsgRGVzYz0nQXNpc3RlbnRlIGRlIGNvbXBhdGliaWxpZGFkIHByb2dyYW1hcyc7ICAgTm90ZT0nU29sbyBkZWphIGRlIHN1Z2VyaXIgImVqZWN1dGFyIGVuIG1vZG8gY29tcGF0Ii4nIH0sCiAgICAgICAgQHsgTmFtZT0nWGJsQXV0aE1hbmFnZXInOyAgICAgIFRpZXI9J1NBRkUnOyBEZXNjPSdYYm94IExpdmUgQXV0aCc7ICAgICAgICAgICAgICAgICAgICAgICAgICAgTm90ZT0nU2kgTk8ganVlZ2FzIGEganVlZ29zIE1pY3Jvc29mdCBTdG9yZS4nIH0sCiAgICAgICAgQHsgTmFtZT0nWGJsR2FtZVNhdmUnOyAgICAgICAgIFRpZXI9J1NBRkUnOyBEZXNjPSdYYm94IExpdmUgR2FtZSBTYXZlJzsgICAgICAgICAgICAgICAgICAgICAgTm90ZT0nU2kgTk8ganVlZ2FzIGEganVlZ29zIE1pY3Jvc29mdCBTdG9yZS4nIH0sCiAgICAgICAgQHsgTmFtZT0nWGJveE5ldEFwaVN2Yyc7ICAgICAgIFRpZXI9J1NBRkUnOyBEZXNjPSdYYm94IExpdmUgTmV0d29ya2luZyc7ICAgICAgICAgICAgICAgICAgICAgTm90ZT0nU2kgTk8ganVlZ2FzIGEganVlZ29zIE1pY3Jvc29mdCBTdG9yZS4nIH0sCiAgICAgICAgQHsgTmFtZT0nWGJveEdpcFN2Yyc7ICAgICAgICAgIFRpZXI9J1NBRkUnOyBEZXNjPSdYYm94IEdhbWUgSW5wdXQgUHJvdG9jb2wnOyAgICAgICAgICAgICAgICAgTm90ZT0nU2kgTk8gdXNhcyBtYW5kbyBYYm94IHBvciBVU0IvQmx1ZXRvb3RoLicgfSwKICAgICAgICBAeyBOYW1lPSdNYXBzQnJva2VyJzsgICAgICAgICAgVGllcj0nU0FGRSc7IERlc2M9J01hcGFzIG9mZmxpbmUgKFdpbmRvd3MgTWFwcyknOyAgICAgICAgICAgICBOb3RlPSdTb2xvIGFmZWN0YSBhcHAgTWFwYXMgZGUgTVMuJyB9LAogICAgICAgIEB7IE5hbWU9J1dhbGxldFNlcnZpY2UnOyAgICAgICBUaWVyPSdTQUZFJzsgRGVzYz0nQ2FydGVyYSAoTWljcm9zb2Z0IFdhbGxldCknOyAgICAgICAgICAgICAgIE5vdGU9J0FwcCBkaXNjb250aW51YWRhLicgfSwKICAgICAgICBAeyBOYW1lPSdSZXRhaWxEZW1vJzsgICAgICAgICAgVGllcj0nU0FGRSc7IERlc2M9J01vZG8gZGVtbyBkZSB0aWVuZGEnOyAgICAgICAgICAgICAgICAgICAgICBOb3RlPSdTb2xvIHBhcmEgUENzIGRlIGRlbW9zdHJhY2lvbiBlbiB0aWVuZGFzLicgfSwKICAgICAgICBAeyBOYW1lPSdGYXgnOyAgICAgICAgICAgICAgICAgVGllcj0nU0FGRSc7IERlc2M9J0ZheCc7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTm90ZT0nUXVpZW4gdXNhIGZheCBob3kuJyB9LAogICAgICAgIEB7IE5hbWU9J1JlbW90ZVJlZ2lzdHJ5JzsgICAgICBUaWVyPSdTQUZFJzsgRGVzYz0nUmVnaXN0cm8gcmVtb3RvICh2ZWN0b3IgZGUgYXRhcXVlKSc7ICAgICAgTm90ZT0nRGVzaGFiaWxpdGFybG8gTUVKT1JBIHNlZ3VyaWRhZC4nIH0sCgogICAgICAgICMgLS0tIFRJRVIgTU9ERVJBVEUgLS0tCiAgICAgICAgQHsgTmFtZT0nVGFibGV0SW5wdXRTZXJ2aWNlJzsgIFRpZXI9J01PREVSQVRFJzsgRGVzYz0nRW50cmFkYSB0YWN0aWwgLyBsYXBpeic7ICAgICAgICAgICAgICAgTm90ZT0nUk9NUEU6IHBhbnRhbGxhcyB0YWN0aWxlcywgdGFibGV0cywgU3VyZmFjZS4nIH0sCiAgICAgICAgQHsgTmFtZT0nU2Vuc29yU2VydmljZSc7ICAgICAgIFRpZXI9J01PREVSQVRFJzsgRGVzYz0nU2VydmljaW8gZGUgc2Vuc29yZXMnOyAgICAgICAgICAgICAgICAgTm90ZT0nUk9NUEU6IHJvdGFjaW9uIHBhbnRhbGxhLCBhdXRvLWJyaWxsbyAobGFwdG9wcykuJyB9LAogICAgICAgIEB7IE5hbWU9J1NlbnNvckRhdGFTZXJ2aWNlJzsgICBUaWVyPSdNT0RFUkFURSc7IERlc2M9J0RhdG9zIGRlIHNlbnNvcmVzJzsgICAgICAgICAgICAgICAgICAgIE5vdGU9J0xvIG1pc21vIHF1ZSBTZW5zb3JTZXJ2aWNlLicgfSwKICAgICAgICBAeyBOYW1lPSdTZW5zclN2Yyc7ICAgICAgICAgICAgVGllcj0nTU9ERVJBVEUnOyBEZXNjPSdTdXBlcnZpc2lvbiBkZSBzZW5zb3Jlcyc7ICAgICAgICAgICAgICBOb3RlPSdMbyBtaXNtbyBxdWUgU2Vuc29yU2VydmljZS4nIH0sCiAgICAgICAgQHsgTmFtZT0nV2Jpb1NydmMnOyAgICAgICAgICAgIFRpZXI9J01PREVSQVRFJzsgRGVzYz0nQmlvbWV0cmlhIChodWVsbGFzIC8gV2luZG93cyBIZWxsbyknOyBOb3RlPSdST01QRTogaHVlbGxhIHkgcmVjb25vY2ltaWVudG8gZmFjaWFsLicgfSwKICAgICAgICBAeyBOYW1lPSdTcG9vbGVyJzsgICAgICAgICAgICAgVGllcj0nTU9ERVJBVEUnOyBEZXNjPSdQcmludCBTcG9vbGVyJzsgICAgICAgICAgICAgICAgICAgICAgICBOb3RlPSdST01QRTogaW1wcmVzaW9uLiBTaSBOTyBpbXByaW1lcywgdGFtYmllbiBjaWVycmEgQ1ZFIHRpcG8gUHJpbnROaWdodG1hcmUuJyB9LAogICAgICAgIEB7IE5hbWU9J1dTZWFyY2gnOyAgICAgICAgICAgICBUaWVyPSdNT0RFUkFURSc7IERlc2M9J0luZGV4YWRvciBkZSBXaW5kb3dzIFNlYXJjaCc7ICAgICAgICAgIE5vdGU9J1JPTVBFOiBidXNxdWVkYXMgcmFwaWRhcyBFeHBsb3JlciB5IE91dGxvb2suJyB9LAogICAgICAgIEB7IE5hbWU9J0J0aHNlcnYnOyAgICAgICAgICAgICBUaWVyPSdNT0RFUkFURSc7IERlc2M9J0JsdWV0b290aCBTdXBwb3J0JzsgICAgICAgICAgICAgICAgICAgIE5vdGU9J1JPTVBFOiBCbHVldG9vdGggKHNpIG5vIHVzYXMgbmFkYSBCVCwgc2UgcHVlZGUpLicgfQogICAgKQoKICAgIGZ1bmN0aW9uIFNob3ctSGVhZGVyIHsKICAgICAgICBDbGVhci1Ib3N0CiAgICAgICAgV3JpdGUtSG9zdCAnJwogICAgICAgIFdyaXRlLUhvc3QgJyAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PScgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIFdyaXRlLUhvc3QgJyAgIEFUTEFTIFBDIFNVUFBPUlQgLSBPUFRJTUlaQUNJT04gREUgU0VSVklDSU9TIHYyJyAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgIFdyaXRlLUhvc3QgJyAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PScgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIFdyaXRlLUhvc3QgJycKICAgIH0KCiAgICBmdW5jdGlvbiBDaGVjay1BZG1pbiB7CiAgICAgICAgJHAgPSBbU2VjdXJpdHkuUHJpbmNpcGFsLldpbmRvd3NQcmluY2lwYWxdOjpuZXcoW1NlY3VyaXR5LlByaW5jaXBhbC5XaW5kb3dzSWRlbnRpdHldOjpHZXRDdXJyZW50KCkpCiAgICAgICAgcmV0dXJuICRwLklzSW5Sb2xlKFtTZWN1cml0eS5QcmluY2lwYWwuV2luZG93c0J1aWx0SW5Sb2xlXTo6QWRtaW5pc3RyYXRvcikKICAgIH0KCiAgICBmdW5jdGlvbiBMaXN0LVNlcnZpY2VzIHsKICAgICAgICBwYXJhbShbc3RyaW5nXSRUaWVyRmlsdGVyID0gJycpCiAgICAgICAgJG91dCA9IEAoKQogICAgICAgIGZvcmVhY2ggKCRzIGluICRzZXJ2aWNpb3NBT3B0aW1pemFyKSB7CiAgICAgICAgICAgIGlmICgkVGllckZpbHRlciAtYW5kICRzLlRpZXIgLW5lICRUaWVyRmlsdGVyKSB7IGNvbnRpbnVlIH0KICAgICAgICAgICAgJHN2YyA9IEdldC1TZXJ2aWNlIC1OYW1lICRzLk5hbWUgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICAgICAgICAgaWYgKC1ub3QgJHN2YykgeyBjb250aW51ZSB9CiAgICAgICAgICAgIHRyeSB7CiAgICAgICAgICAgICAgICAkc3ZjQ2ltID0gR2V0LUNpbUluc3RhbmNlIC1DbGFzc05hbWUgV2luMzJfU2VydmljZSAtRmlsdGVyICJOYW1lPSckKCRzLk5hbWUpJyIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICAgICAgICAgICAgICRzdGFydE1vZGUgPSBpZiAoJHN2Y0NpbSkgeyAkc3ZjQ2ltLlN0YXJ0TW9kZSB9IGVsc2UgeyAnPycgfQogICAgICAgICAgICB9IGNhdGNoIHsgJHN0YXJ0TW9kZSA9ICc/JyB9CiAgICAgICAgICAgICRvdXQgKz0gW3BzY3VzdG9tb2JqZWN0XUB7CiAgICAgICAgICAgICAgICBOYW1lICAgICAgPSAkcy5OYW1lCiAgICAgICAgICAgICAgICBEZXNjICAgICAgPSAkcy5EZXNjCiAgICAgICAgICAgICAgICBOb3RlICAgICAgPSAkcy5Ob3RlCiAgICAgICAgICAgICAgICBUaWVyICAgICAgPSAkcy5UaWVyCiAgICAgICAgICAgICAgICBTdGF0dXMgICAgPSAkc3ZjLlN0YXR1cwogICAgICAgICAgICAgICAgU3RhcnRNb2RlID0gJHN0YXJ0TW9kZQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiAkb3V0CiAgICB9CgogICAgZnVuY3Rpb24gQXBwbHktU3RvcCB7CiAgICAgICAgcGFyYW0oJFRhcmdldHMpCiAgICAgICAgaWYgKC1ub3QgKENoZWNrLUFkbWluKSkgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICcnCiAgICAgICAgICAgIFdyaXRlLUhvc3QgJyAgW1hdIEFETUlOIHJlcXVlcmlkby4gUmVsYW56YSBjb24gcHJpdmlsZWdpb3MuJyAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICByZXR1cm4gJGZhbHNlCiAgICAgICAgfQoKICAgICAgICAjIEJhY2t1cCBlc3RhZG8gcHJldmlvCiAgICAgICAgJGJhY2t1cCA9IEAoKQogICAgICAgIGZvcmVhY2ggKCR0IGluICRUYXJnZXRzKSB7CiAgICAgICAgICAgICRzdmMgPSBHZXQtU2VydmljZSAtTmFtZSAkdC5OYW1lIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlCiAgICAgICAgICAgIGlmICgtbm90ICRzdmMpIHsgY29udGludWUgfQogICAgICAgICAgICAkY2ltID0gR2V0LUNpbUluc3RhbmNlIC1DbGFzc05hbWUgV2luMzJfU2VydmljZSAtRmlsdGVyICJOYW1lPSckKCR0Lk5hbWUpJyIgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKICAgICAgICAgICAgJGJhY2t1cCArPSBbcHNjdXN0b21vYmplY3RdQHsKICAgICAgICAgICAgICAgIE5hbWUgICAgICA9ICR0Lk5hbWUKICAgICAgICAgICAgICAgIFN0YXR1cyAgICA9ICRzdmMuU3RhdHVzLlRvU3RyaW5nKCkKICAgICAgICAgICAgICAgIFN0YXJ0TW9kZSA9IGlmICgkY2ltKSB7ICRjaW0uU3RhcnRNb2RlIH0gZWxzZSB7ICdVbmtub3duJyB9CiAgICAgICAgICAgICAgICBUaW1lc3RhbXAgPSAoR2V0LURhdGUpLlRvU3RyaW5nKCdzJykKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICAjIEFwcGVuZCBhIGhpc3RvcmlhbCBkZSBiYWNrdXBzIChubyBzb2JyZXNjcmliaXIgcGFyYSBwZXJtaXRpciBtdWx0aXBsZXMgdW5kb3MpCiAgICAgICAgJGhpc3RvcnkgPSBAKCkKICAgICAgICBpZiAoVGVzdC1QYXRoICRiYWNrdXBGaWxlKSB7CiAgICAgICAgICAgIHRyeSB7ICRoaXN0b3J5ID0gQChHZXQtQ29udGVudCAkYmFja3VwRmlsZSAtUmF3IHwgQ29udmVydEZyb20tSnNvbikgfSBjYXRjaCB7ICRoaXN0b3J5ID0gQCgpIH0KICAgICAgICB9CiAgICAgICAgJGVudHJ5ID0gW3BzY3VzdG9tb2JqZWN0XUB7CiAgICAgICAgICAgIFRpbWVzdGFtcCA9IChHZXQtRGF0ZSkuVG9TdHJpbmcoJ3MnKQogICAgICAgICAgICBTZXJ2aWNlcyAgPSAkYmFja3VwCiAgICAgICAgfQogICAgICAgICRoaXN0b3J5ID0gQCgkaGlzdG9yeSkgKyBAKCRlbnRyeSkKICAgICAgICAkaGlzdG9yeSB8IENvbnZlcnRUby1Kc29uIC1EZXB0aCA1IHwgT3V0LUZpbGUgLUZpbGVQYXRoICRiYWNrdXBGaWxlIC1FbmNvZGluZyBVVEY4CiAgICAgICAgV3JpdGUtSG9zdCAnJwogICAgICAgIFdyaXRlLUhvc3QgKCIgIFtpXSBCYWNrdXAgZ3VhcmRhZG86IHswfSIgLWYgJGJhY2t1cEZpbGUpIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICBXcml0ZS1Ib3N0ICcnCgogICAgICAgIGZvcmVhY2ggKCR0IGluICRUYXJnZXRzKSB7CiAgICAgICAgICAgIHRyeSB7CiAgICAgICAgICAgICAgICBTdG9wLVNlcnZpY2UgLU5hbWUgJHQuTmFtZSAtRm9yY2UgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAgICAgICAgIFNldC1TZXJ2aWNlICAtTmFtZSAkdC5OYW1lIC1TdGFydHVwVHlwZSBNYW51YWwgLUVycm9yQWN0aW9uIFN0b3AKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgKCIgIFtPS10gICB7MCwtMjJ9IGRldGVuaWRvIHkgbWFyY2FkbyBNYW51YWwiIC1mICR0Lk5hbWUpIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICBbRVJSXSAgezAsLTIyfSB7MX0iIC1mICR0Lk5hbWUsICRfLkV4Y2VwdGlvbi5NZXNzYWdlKSAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiAkdHJ1ZQogICAgfQoKICAgIGZ1bmN0aW9uIEFwcGx5LVVuZG8gewogICAgICAgIGlmICgtbm90IChDaGVjay1BZG1pbikpIHsKICAgICAgICAgICAgV3JpdGUtSG9zdCAnJwogICAgICAgICAgICBXcml0ZS1Ib3N0ICcgIFtYXSBBRE1JTiByZXF1ZXJpZG8uIFJlbGFuemEgY29uIHByaXZpbGVnaW9zLicgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgcmV0dXJuCiAgICAgICAgfQogICAgICAgIGlmICgtbm90IChUZXN0LVBhdGggJGJhY2t1cEZpbGUpKSB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAgICAgV3JpdGUtSG9zdCAnICBbIV0gTm8gaGF5IGJhY2t1cC4gTm8gc2UgaGEgb3B0aW1pemFkbyBuYWRhIGRlc2RlIGVzdGUgdG9vbC4nIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgIHJldHVybgogICAgICAgIH0KICAgICAgICB0cnkgewogICAgICAgICAgICAkaGlzdG9yeSA9IEAoR2V0LUNvbnRlbnQgJGJhY2t1cEZpbGUgLVJhdyB8IENvbnZlcnRGcm9tLUpzb24pCiAgICAgICAgfSBjYXRjaCB7CiAgICAgICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAgICAgV3JpdGUtSG9zdCAnICBbWF0gQmFja3VwIGNvcnJ1cHRvLicgLUZvcmVncm91bmRDb2xvciBSZWQKICAgICAgICAgICAgcmV0dXJuCiAgICAgICAgfQogICAgICAgIGlmICgkaGlzdG9yeS5Db3VudCAtZXEgMCkgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICcnCiAgICAgICAgICAgIFdyaXRlLUhvc3QgJyAgWyFdIEJhY2t1cCB2YWNpby4nIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgIHJldHVybgogICAgICAgIH0KCiAgICAgICAgV3JpdGUtSG9zdCAnJwogICAgICAgIFdyaXRlLUhvc3QgJyAgPT09IFBVTlRPUyBERSBSRVNUQVVSQUNJT04gPT09JyAtRm9yZWdyb3VuZENvbG9yIFllbGxvdwogICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAkaSA9IDEKICAgICAgICBmb3JlYWNoICgkZSBpbiAkaGlzdG9yeSkgewogICAgICAgICAgICAkbiA9IEAoJGUuU2VydmljZXMpLkNvdW50CiAgICAgICAgICAgIFdyaXRlLUhvc3QgKCIgIFt7MH1dIHsxfSAtIHsyfSBzZXJ2aWNpb3MgYWZlY3RhZG9zIiAtZiAkaSwgJGUuVGltZXN0YW1wLCAkbikgLUZvcmVncm91bmRDb2xvciBXaGl0ZQogICAgICAgICAgICAkaSsrCiAgICAgICAgfQogICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICBXcml0ZS1Ib3N0ICcgIFswXSBDYW5jZWxhcicgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAkc2VsID0gUmVhZC1Ib3N0ICcgIFF1ZSBiYWNrdXAgcmVzdGF1cmFyPycKICAgICAgICBpZiAoJHNlbCAtbWF0Y2ggJ15cZCskJyAtYW5kIFtpbnRdJHNlbCAtZ2UgMSAtYW5kIFtpbnRdJHNlbCAtbGUgJGhpc3RvcnkuQ291bnQpIHsKICAgICAgICAgICAgJGVudHJ5ID0gJGhpc3RvcnlbW2ludF0kc2VsIC0gMV0KICAgICAgICAgICAgZm9yZWFjaCAoJHMgaW4gJGVudHJ5LlNlcnZpY2VzKSB7CiAgICAgICAgICAgICAgICAkbW9kZU1hcCA9IEB7ICdBdXRvJyA9ICdBdXRvbWF0aWMnOyAnQXV0b21hdGljJyA9ICdBdXRvbWF0aWMnOyAnTWFudWFsJyA9ICdNYW51YWwnOyAnRGlzYWJsZWQnID0gJ0Rpc2FibGVkJzsgJ0Jvb3QnID0gJ0Jvb3QnOyAnU3lzdGVtJyA9ICdTeXN0ZW0nIH0KICAgICAgICAgICAgICAgICRtb2RlID0gaWYgKCRtb2RlTWFwLkNvbnRhaW5zS2V5KCRzLlN0YXJ0TW9kZSkpIHsgJG1vZGVNYXBbJHMuU3RhcnRNb2RlXSB9IGVsc2UgeyAnTWFudWFsJyB9CiAgICAgICAgICAgICAgICB0cnkgewogICAgICAgICAgICAgICAgICAgIFNldC1TZXJ2aWNlIC1OYW1lICRzLk5hbWUgLVN0YXJ0dXBUeXBlICRtb2RlIC1FcnJvckFjdGlvbiBTdG9wCiAgICAgICAgICAgICAgICAgICAgaWYgKCRzLlN0YXR1cyAtZXEgJ1J1bm5pbmcnKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIFN0YXJ0LVNlcnZpY2UgLU5hbWUgJHMuTmFtZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICBbT0tdICAgezAsLTIyfSBtb2RvPXsxLC0xMH0gZXN0YWRvX3ByZXY9ezJ9IiAtZiAkcy5OYW1lLCAkbW9kZSwgJHMuU3RhdHVzKSAtRm9yZWdyb3VuZENvbG9yIEdyZWVuCiAgICAgICAgICAgICAgICB9IGNhdGNoIHsKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICBbRVJSXSAgezAsLTIyfSB7MX0iIC1mICRzLk5hbWUsICRfLkV4Y2VwdGlvbi5NZXNzYWdlKSAtRm9yZWdyb3VuZENvbG9yIFJlZAogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAgICAgV3JpdGUtSG9zdCAnICBSZXN0YXVyYWNpb24gY29tcGxldGEuJyAtRm9yZWdyb3VuZENvbG9yIEN5YW4KICAgICAgICB9IGVsc2UgewogICAgICAgICAgICBXcml0ZS1Ib3N0ICcgIENhbmNlbGFkby4nIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICB9CiAgICB9CgogICAgZnVuY3Rpb24gU2hvdy1TZXJ2aWNlc1RhYmxlIHsKICAgICAgICBwYXJhbSgkTGlzdCkKICAgICAgICBXcml0ZS1Ib3N0ICgnICB7MCwtMjJ9IHsxLC02fSB7MiwtMTB9IHszLC0xMH0gezR9JyAtZiAnU2VydmljaW8nLCAnVGllcicsICdFc3RhZG8nLCAnU3RhcnRNb2RlJywgJ0Rlc2NyaXBjaW9uJykgLUZvcmVncm91bmRDb2xvciBDeWFuCiAgICAgICAgV3JpdGUtSG9zdCAoJyAgJyArICgnLScgKiA5MCkpIC1Gb3JlZ3JvdW5kQ29sb3IgRGFya0dyYXkKICAgICAgICBmb3JlYWNoICgkciBpbiAkTGlzdCkgewogICAgICAgICAgICAkY29sb3IgPSBpZiAoJHIuU3RhdHVzIC1lcSAnUnVubmluZycpIHsgJ0dyZWVuJyB9IGVsc2UgeyAnRGFya0dyYXknIH0KICAgICAgICAgICAgJGZsYWcgID0gaWYgKCRyLlN0YXR1cyAtZXEgJ1J1bm5pbmcnKSB7ICdSJyB9IGVsc2UgeyAnLScgfQogICAgICAgICAgICBXcml0ZS1Ib3N0ICgiICB7MCwtMjJ9IHsxLC02fSB7MiwtMTB9IHszLC0xMH0gezR9IiAtZiAkci5OYW1lLCAkci5UaWVyLCAkci5TdGF0dXMsICRyLlN0YXJ0TW9kZSwgJHIuRGVzYykgLUZvcmVncm91bmRDb2xvciAkY29sb3IKICAgICAgICAgICAgV3JpdGUtSG9zdCAoIiAgezAsMjJ9ICAgbm90ZTogezF9IiAtZiAnJywgJHIuTm90ZSkgLUZvcmVncm91bmRDb2xvciBEYXJrR3JheQogICAgICAgIH0KICAgIH0KCiAgICAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgIyBNRU5VIFBSSU5DSVBBTAogICAgIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgIHdoaWxlICgkdHJ1ZSkgewogICAgICAgIFNob3ctSGVhZGVyCiAgICAgICAgV3JpdGUtSG9zdCAnICBbMV0gVmVyIGVzdGFkbyBhY3R1YWwgZGUgbG9zIHNlcnZpY2lvcyBjYW5kaWRhdG9zJyAtRm9yZWdyb3VuZENvbG9yIFdoaXRlCiAgICAgICAgV3JpdGUtSG9zdCAnICBbMl0gRGV0ZW5lciBzZXJ2aWNpb3MgU0VHVVJPUyAoU0FGRSkgLSByZWNvbWVuZGFkbycgLUZvcmVncm91bmRDb2xvciBHcmVlbgogICAgICAgIFdyaXRlLUhvc3QgJyAgWzNdIERldGVuZXIgQURFTUFTIHNlcnZpY2lvcyBNT0RFUkFET1MgKGF2YW56YWRvKScgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICBXcml0ZS1Ib3N0ICcgIFs0XSBVTkRPIC0gUmVzdGF1cmFyIHVuIGJhY2t1cCBwcmV2aW8nIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgIFdyaXRlLUhvc3QgJyAgWzVdIFZlciBhZHZlcnRlbmNpYXMgZGUgY2FkYSBzZXJ2aWNpbycgLUZvcmVncm91bmRDb2xvciBEYXJrQ3lhbgogICAgICAgIFdyaXRlLUhvc3QgJyAgW1FdIFNhbGlyJwogICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAkc2VsID0gUmVhZC1Ib3N0ICcgIFNlbGVjY2lvbicKCiAgICAgICAgc3dpdGNoIC1yZWdleCAoJHNlbCkgewogICAgICAgICAgICAnXjEkJyB7CiAgICAgICAgICAgICAgICBTaG93LUhlYWRlcgogICAgICAgICAgICAgICAgJGxpc3QgPSBMaXN0LVNlcnZpY2VzCiAgICAgICAgICAgICAgICBpZiAoJGxpc3QuQ291bnQgLWVxIDApIHsKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICcgIE5vIHNlIGRldGVjdG8gbmluZ3VuIHNlcnZpY2lvIGRlIGxhIGxpc3RhIGVuIGVzdGUgV2luZG93cy4nIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIFNob3ctU2VydmljZXNUYWJsZSAkbGlzdAogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAnJwogICAgICAgICAgICAgICAgUmVhZC1Ib3N0ICcgIEVOVEVSIHBhcmEgdm9sdmVyJyB8IE91dC1OdWxsCiAgICAgICAgICAgIH0KICAgICAgICAgICAgJ14yJCcgewogICAgICAgICAgICAgICAgU2hvdy1IZWFkZXIKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgJyAgRGV0ZW5kcmEgU09MTyBzZXJ2aWNpb3MgZGVsIHRpZXIgU0FGRSAobm8gcm9tcGVuIG5hZGEgZW4gdW4gUEMgbm9ybWFsKS4nIC1Gb3JlZ3JvdW5kQ29sb3IgR3JlZW4KICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAgICAgICAgICRsaXN0ID0gTGlzdC1TZXJ2aWNlcyAtVGllckZpbHRlciAnU0FGRScgfCBXaGVyZS1PYmplY3QgeyAkXy5TdGF0dXMgLWVxICdSdW5uaW5nJyB9CiAgICAgICAgICAgICAgICBpZiAoJGxpc3QuQ291bnQgLWVxIDApIHsKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICcgIE5vIGhheSBzZXJ2aWNpb3MgU0FGRSBlbiBlamVjdWNpb24uIFlhIGVzdGEgb3B0aW1pemFkby4nIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAnICBFTlRFUicgfCBPdXQtTnVsbAogICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBTaG93LVNlcnZpY2VzVGFibGUgJGxpc3QKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAgICAgICAgICRjID0gUmVhZC1Ib3N0ICcgIFByb2NlZGVyPyBbUy9OXScKICAgICAgICAgICAgICAgIGlmICgkYyAtbWF0Y2ggJ15bU3NZeV0kJykgewogICAgICAgICAgICAgICAgICAgIEFwcGx5LVN0b3AgLVRhcmdldHMgJGxpc3QgfCBPdXQtTnVsbAogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAnJwogICAgICAgICAgICAgICAgUmVhZC1Ib3N0ICcgIEVOVEVSJyB8IE91dC1OdWxsCiAgICAgICAgICAgIH0KICAgICAgICAgICAgJ14zJCcgewogICAgICAgICAgICAgICAgU2hvdy1IZWFkZXIKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgJyAgTU9ETyBBVkFOWkFETzogc2UgZGV0ZW5kcmFuIEFERU1BUyBzZXJ2aWNpb3MgTU9ERVJBRE9TLicgLUZvcmVncm91bmRDb2xvciBZZWxsb3cKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgJyAgUmV2aXNhIGxhIG5vdGEgZGUgQ0FEQSBzZXJ2aWNpbyBhbnRlcyBkZSBkZWNpciBTSS4nIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICcnCiAgICAgICAgICAgICAgICAkbGlzdCA9IExpc3QtU2VydmljZXMgfCBXaGVyZS1PYmplY3QgeyAkXy5TdGF0dXMgLWVxICdSdW5uaW5nJyB9CiAgICAgICAgICAgICAgICBpZiAoJGxpc3QuQ291bnQgLWVxIDApIHsKICAgICAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICcgIFlhIGVzdGEgdG9kbyBkZXRlbmlkby4nIC1Gb3JlZ3JvdW5kQ29sb3IgQ3lhbgogICAgICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAnICBFTlRFUicgfCBPdXQtTnVsbAogICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBTaG93LVNlcnZpY2VzVGFibGUgJGxpc3QKICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAgICAgICAgICRjID0gUmVhZC1Ib3N0ICcgIFByb2NlZGVyIGNvbiBUT0RPUyBsb3MgZGV0ZWN0YWRvcz8gW1MvTl0nCiAgICAgICAgICAgICAgICBpZiAoJGMgLW1hdGNoICdeW1NzWXldJCcpIHsKICAgICAgICAgICAgICAgICAgICBBcHBseS1TdG9wIC1UYXJnZXRzICRsaXN0IHwgT3V0LU51bGwKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgJycKICAgICAgICAgICAgICAgIFJlYWQtSG9zdCAnICBFTlRFUicgfCBPdXQtTnVsbAogICAgICAgICAgICB9CiAgICAgICAgICAgICdeNCQnIHsKICAgICAgICAgICAgICAgIFNob3ctSGVhZGVyCiAgICAgICAgICAgICAgICBBcHBseS1VbmRvCiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICcnCiAgICAgICAgICAgICAgICBSZWFkLUhvc3QgJyAgRU5URVInIHwgT3V0LU51bGwKICAgICAgICAgICAgfQogICAgICAgICAgICAnXjUkJyB7CiAgICAgICAgICAgICAgICBTaG93LUhlYWRlcgogICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAnICAtLS0gQURWRVJURU5DSUFTIFBPUiBTRVJWSUNJTyAtLS0nIC1Gb3JlZ3JvdW5kQ29sb3IgWWVsbG93CiAgICAgICAgICAgICAgICBXcml0ZS1Ib3N0ICcnCiAgICAgICAgICAgICAgICBmb3JlYWNoICgkcyBpbiAkc2VydmljaW9zQU9wdGltaXphcikgewogICAgICAgICAgICAgICAgICAgICRjb2wgPSBpZiAoJHMuVGllciAtZXEgJ1NBRkUnKSB7ICdHcmVlbicgfSBlbHNlIHsgJ1llbGxvdycgfQogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgKCIgIFt7MH1dIHsxLC0yMn0gKHsyfSkiIC1mICRzLlRpZXIsICRzLk5hbWUsICRzLkRlc2MpIC1Gb3JlZ3JvdW5kQ29sb3IgJGNvbAogICAgICAgICAgICAgICAgICAgIFdyaXRlLUhvc3QgKCIgICAgICAgIHswfSIgLWYgJHMuTm90ZSkgLUZvcmVncm91bmRDb2xvciBHcmF5CiAgICAgICAgICAgICAgICAgICAgV3JpdGUtSG9zdCAnJwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgUmVhZC1Ib3N0ICcgIEVOVEVSJyB8IE91dC1OdWxsCiAgICAgICAgICAgIH0KICAgICAgICAgICAgJ15bUXFdJCcgeyByZXR1cm4gfQogICAgICAgICAgICBkZWZhdWx0IHsgV3JpdGUtSG9zdCAnICBPcGNpb24gbm8gdmFsaWRhLicgLUZvcmVncm91bmRDb2xvciBSZWQ7IFN0YXJ0LVNsZWVwIDEgfQogICAgICAgIH0KICAgIH0KfQo='



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