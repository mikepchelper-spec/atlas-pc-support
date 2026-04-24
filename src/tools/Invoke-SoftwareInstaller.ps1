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
