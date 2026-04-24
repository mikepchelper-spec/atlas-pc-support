function Invoke-ActualizarPowerShell {
    <#
    .SYNOPSIS
      Instala o actualiza PowerShell 7 para el panel Atlas PC Support.

    .DESCRIPTION
      Detecta la version actual y, si PS 7 no esta instalado, lo descarga
      desde GitHub (oficial de Microsoft) e instala silencioso con msiexec.
      Si hay un MSI local en deps\ (modo offline USB), lo usa en vez de descargar.

      Tras la instalacion, las siguientes tools que lances desde el panel
      correran automaticamente en pwsh.exe gracias al ToolRunner.
    #>

    $ErrorActionPreference = 'Stop'

    Clear-Host
    Write-Host ''
    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host '  Actualizar PowerShell 7' -ForegroundColor Cyan
    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host ''

    $current = "{0}.{1}" -f $PSVersionTable.PSVersion.Major, $PSVersionTable.PSVersion.Minor
    Write-Host "  Version actual de la consola: $current" -ForegroundColor White
    Write-Host "  Edicion: $($PSVersionTable.PSEdition)" -ForegroundColor White
    Write-Host ''

    $ps7Path = Get-AtlasPS7Path
    if ($ps7Path) {
        # Intentar leer version real
        try {
            $verOutput = & $ps7Path -NoProfile -Command '$PSVersionTable.PSVersion.ToString()'
            Write-Host "  [OK] PowerShell 7 ya instalado: $verOutput" -ForegroundColor Green
            Write-Host "       Ruta: $ps7Path" -ForegroundColor DarkGray
        } catch {
            Write-Host "  [OK] pwsh.exe detectado: $ps7Path" -ForegroundColor Green
        }
        Write-Host ''
        Write-Host '  Las tools del panel ya se lanzan en PS 7 automaticamente.' -ForegroundColor DarkGray
        Write-Host '  Si quieres reinstalar o actualizar a una version mas nueva, pulsa [R]. Cualquier otra tecla para salir.' -ForegroundColor DarkGray
        $ans = Read-Host '  Opcion'
        if ($ans -notmatch '^[Rr]') { return }
    }

    # Comprobar admin
    if (-not (Test-IsAdmin)) {
        Write-Host '  [!] Se requiere ejecutar como Administrador para instalar PowerShell 7.' -ForegroundColor Red
        Write-Host '      Cierra esta ventana y relanza el panel en modo admin.' -ForegroundColor DarkGray
        return
    }

    # Buscar MSI offline primero
    $offline = Find-AtlasPS7OfflineMsi
    if ($offline) {
        Write-Host "  [i] MSI local encontrado: $offline" -ForegroundColor Cyan
        Write-Host '      Se instalara sin descargar nada de internet.' -ForegroundColor DarkGray
    } else {
        Write-Host "  [i] MSI local NO encontrado. Se descargara de github.com/PowerShell/PowerShell (~120 MB)." -ForegroundColor Cyan
        Write-Host "      Version a instalar: $script:AtlasPS7Version" -ForegroundColor DarkGray
    }

    Write-Host ''
    $go = Read-Host '  Continuar? [S/n]'
    if ($go -match '^[Nn]') {
        Write-Host '  Cancelado.' -ForegroundColor DarkGray
        return
    }

    Write-Host ''
    try {
        $installed = Install-AtlasPS7 -OfflineSource $offline
        Write-Host ''
        Write-Host '  ================================================================' -ForegroundColor Green
        Write-Host '  PowerShell 7 instalado correctamente.' -ForegroundColor Green
        Write-Host '  ================================================================' -ForegroundColor Green
        Write-Host ''
        Write-Host "  Ruta: $installed" -ForegroundColor White
        Write-Host ''
        Write-Host '  RECOMENDADO: reinicia el panel para que ToolRunner detecte PS 7.' -ForegroundColor Yellow
        Write-Host '  Cierra esta ventana y vuelve a abrir el panel desde la URL corta.' -ForegroundColor DarkGray
    } catch {
        Write-Host ''
        Write-Host "  [X] Error durante la instalacion: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ''
        Write-Host '  Alternativa manual:' -ForegroundColor DarkGray
        Write-Host '    winget install --id Microsoft.PowerShell --source winget' -ForegroundColor White
        Write-Host '  o descarga el MSI desde:' -ForegroundColor DarkGray
        Write-Host '    https://github.com/PowerShell/PowerShell/releases/latest' -ForegroundColor White
    }
}
