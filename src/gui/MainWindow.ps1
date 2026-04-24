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
        'COFFEE_LABEL'       = (Get-AtlasString 'footer.coffee')
        'COFFEE_TOOLTIP'     = (Get-AtlasString 'footer.coffeeTooltip')
        'LANG_TOOLTIP'       = (Get-AtlasString 'header.languageTooltip')
        'RESTART_TOOLTIP'    = (Get-AtlasString 'header.restartTooltip')
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
    $btnRestart  = $window.FindName('BtnRestart')
    $coffeeLink  = $window.FindName('CoffeeLink')
    $langCombo   = $window.FindName('LanguageCombo')

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

    # Selector de idioma (header)
    if ($langCombo) {
        $supported = Get-AtlasSupportedLanguages
        $currentLang = $script:AtlasCurrentLang
        $selectedIndex = 0
        $i = 0
        foreach ($code in $supported) {
            $item = New-Object System.Windows.Controls.ComboBoxItem
            $item.Content = Get-AtlasLanguageName $code
            $item.Tag = $code
            [void]$langCombo.Items.Add($item)
            if ($code -eq $currentLang) { $selectedIndex = $i }
            $i++
        }
        $langCombo.SelectedIndex = $selectedIndex
        # Marcar initial selection como hecho ANTES de enganchar el handler,
        # para evitar que un evento espureo dispare al crear la ComboBox.
        $script:LangComboReady = $true
        $langCombo.Add_SelectionChanged({
            param($eventSender, $eventArgs)
            if (-not $script:LangComboReady) { return }
            $sel = $eventSender.SelectedItem
            if (-not $sel) { return }
            $newLang = [string]$sel.Tag
            if ($newLang -eq $script:AtlasCurrentLang) { return }
            $ok = Set-AtlasLanguagePref $newLang
            Write-AtlasLog "Idioma cambiado a '$newLang' (guardado=$ok). Reinicio requerido." -Tool 'UI'
            $brand = if ($script:Branding -and $script:Branding.brand) { $script:Branding.brand.shortName } else { 'Atlas PC Support' }
            # Usar el string del NUEVO idioma (ya cargado en el dict, solo no aplicado a UI)
            $msg = $script:AtlasStringsDict[$newLang]['language.restartRequired']
            if (-not $msg) { $msg = Get-AtlasString 'language.restartRequired' }
            [System.Windows.MessageBox]::Show($msg, $brand, 'OK', 'Information') | Out-Null
        })
    }

    # Boton Reiniciar (relanzar via irm|iex y cerrar ventana actual)
    if ($btnRestart) {
        $btnRestart.Add_Click({
            try {
                $bootstrapUrl = 'https://tools.atlaspcsupport.com/?v=' + [guid]::NewGuid().ToString('N')
                # WPF requiere apartment STA. PS7 (pwsh) arranca MTA por defecto; forzar -Sta.
                # Usar Windows PowerShell 5.1 (siempre STA en consola) para maxima robustez
                # en este caso concreto de relanzamiento; el panel sigue detectando PS7 al
                # arrancar y lanzando tools en pwsh como siempre.
                $psExe = 'powershell.exe'
                # Capturar errores del child a un log conocido para poder diagnosticar.
                $errLog = Join-Path $env:TEMP 'atlas-restart.log'
                $cmd = "try { `$ErrorActionPreference='Continue'; (Get-Date).ToString('u') + ' --- restart child START' | Out-File -Append -Encoding UTF8 '$errLog'; irm '$bootstrapUrl' | iex } catch { `"`$(Get-Date -Format u) ERR: `$(`$_ | Out-String)`" | Out-File -Append -Encoding UTF8 '$errLog' }"
                Write-AtlasLog "Reinicio solicitado desde UI (psExe=$psExe, log=$errLog)" -Tool 'UI'
                Start-Process -FilePath $psExe -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-Sta','-Command',$cmd -WindowStyle Hidden | Out-Null
                Start-Sleep -Milliseconds 600
                Write-AtlasLog "Reinicio: cerrando ventana actual" -Tool 'UI'
                if ($script:MainWindow) { $script:MainWindow.Close() }
            } catch {
                Write-AtlasLog "Error al reiniciar el panel: $_" -Level WARN -Tool 'UI'
                [System.Windows.MessageBox]::Show("No se pudo reiniciar: $_", 'Atlas', 'OK', 'Error') | Out-Null
            }
        })
    }

    # Coffee / donacion (footer)
    if ($coffeeLink) {
        $coffeeUrl = 'https://www.paypal.me/atlaspcsupport'
        $coffeeLink.Add_MouseLeftButtonUp({
            try {
                Start-Process $coffeeUrl
            } catch {
                Write-AtlasLog "No se pudo abrir URL de donacion: $_" -Level WARN
            }
        })
    }

    $script:MainWindow = $window
    $script:Branding = $Branding
    $script:AllTools = $Tools

    [void]$window.ShowDialog()
}
