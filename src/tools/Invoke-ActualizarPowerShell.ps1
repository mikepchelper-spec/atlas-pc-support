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

      IMPORTANTE: esta tool corre en ventana aislada (temp .ps1). NO tiene
      acceso a las libs del launcher; por eso todas las helpers (admin check,
      detection, install) estan inline abajo. No remover.
    #>

    $ErrorActionPreference = 'Stop'

    # ----- Constantes (duplicadas de src/lib/PS7.ps1, auto-contenidas) -----
    $PS7_VERSION  = '7.5.0'
    $PS7_URL_X64  = "https://github.com/PowerShell/PowerShell/releases/download/v$PS7_VERSION/PowerShell-$PS7_VERSION-win-x64.msi"
    $PS7_MSI_NAME = "PowerShell-$PS7_VERSION-win-x64.msi"

    # ----- Helpers inline (no dependen de lib del launcher) -----
    function _Test-IsAdmin {
        try {
            $id = [Security.Principal.WindowsIdentity]::GetCurrent()
            $p  = New-Object Security.Principal.WindowsPrincipal($id)
            return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
        } catch { return $false }
    }

    function _Get-PS7Path {
        $cmd = Get-Command pwsh.exe -ErrorAction SilentlyContinue
        if ($cmd -and $cmd.Path) { return $cmd.Path }
        $candidates = @(
            "$env:ProgramFiles\PowerShell\7\pwsh.exe",
            "${env:ProgramFiles(x86)}\PowerShell\7\pwsh.exe",
            "$env:LOCALAPPDATA\Microsoft\PowerShell\7\pwsh.exe"
        )
        foreach ($c in $candidates) {
            if (Test-Path -LiteralPath $c) {
                return (Resolve-Path -LiteralPath $c).Path
            }
        }
        return $null
    }

    function _Find-OfflineMsi {
        $searchDirs = @()
        # Buscar hacia arriba del script actual por si estamos lanzados desde USB
        # (el launcher tipicamente corre desde %TEMP%\AtlasPC, asi que tambien
        # miramos estandar de USB).
        try {
            $invocPath = $MyInvocation.MyCommand.Path
            if ($invocPath) {
                $parent = Split-Path -Parent $invocPath
                $searchDirs += (Join-Path $parent 'deps')
                $gp = Split-Path -Parent $parent
                if ($gp) { $searchDirs += (Join-Path $gp 'deps') }
            }
        } catch {}
        $searchDirs += (Join-Path $env:LOCALAPPDATA 'AtlasPC\deps')
        # Tambien probar todas las unidades removibles (USB) por si el panel
        # se lanzo desde una URL pero el cliente puso la USB en paralelo.
        try {
            Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | ForEach-Object {
                $root = $_.Root
                if ($root) {
                    $searchDirs += (Join-Path $root 'ATLAS_PC_SUPPORT\deps')
                    $searchDirs += (Join-Path $root 'deps')
                }
            }
        } catch {}
        foreach ($dir in ($searchDirs | Select-Object -Unique)) {
            if (Test-Path -LiteralPath $dir) {
                $msi = Get-ChildItem -Path $dir -Filter 'PowerShell-*-win-x64.msi' -ErrorAction SilentlyContinue |
                    Sort-Object Name -Descending | Select-Object -First 1
                if ($msi) { return $msi.FullName }
            }
        }
        return $null
    }

    function _Install-PS7 {
        param([string]$OfflineSource)
        $msi = $null
        if ($OfflineSource -and (Test-Path -LiteralPath $OfflineSource)) {
            $msi = (Resolve-Path -LiteralPath $OfflineSource).Path
            Write-Host "  [>] Usando MSI local: $msi" -ForegroundColor Cyan
        }
        if (-not $msi) {
            $cacheDir = Join-Path $env:LOCALAPPDATA 'AtlasPC\deps'
            if (-not (Test-Path -LiteralPath $cacheDir)) {
                New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null
            }
            $msi = Join-Path $cacheDir $PS7_MSI_NAME
            Write-Host "  [>] Descargando PowerShell $PS7_VERSION (~120 MB)..." -ForegroundColor Cyan
            try {
                $ProgressPreference = 'SilentlyContinue'
                Invoke-WebRequest -Uri $PS7_URL_X64 -OutFile $msi -UseBasicParsing -TimeoutSec 900
            } catch {
                throw "Fallo descarga de PS 7: $($_.Exception.Message)"
            }
        }
        $msiArgs = @('/i', "`"$msi`"", '/qn', '/norestart', 'ADD_PATH=1', 'ENABLE_PSREMOTING=0', 'REGISTER_MANIFEST=1')
        Write-Host "  [>] Instalando MSI (msiexec silencioso)..." -ForegroundColor Cyan
        $p = Start-Process -FilePath 'msiexec.exe' -ArgumentList $msiArgs -Wait -PassThru
        if ($p.ExitCode -ne 0 -and $p.ExitCode -ne 3010) {
            throw "msiexec salio con codigo $($p.ExitCode)"
        }
        $path = _Get-PS7Path
        if (-not $path) {
            throw "Instalacion reportada OK pero pwsh.exe no se encuentra. Reinicia la sesion."
        }
        Write-Host "  [OK] PowerShell 7 instalado: $path" -ForegroundColor Green
        return $path
    }

    # ----- UI -----
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

    $ps7Path = _Get-PS7Path
    if ($ps7Path) {
        try {
            $verOutput = & $ps7Path -NoProfile -Command '$PSVersionTable.PSVersion.ToString()'
            Write-Host "  [OK] PowerShell 7 ya instalado: $verOutput" -ForegroundColor Green
            Write-Host "       Ruta: $ps7Path" -ForegroundColor DarkGray
        } catch {
            Write-Host "  [OK] pwsh.exe detectado: $ps7Path" -ForegroundColor Green
        }
        Write-Host ''
        Write-Host '  Las tools del panel ya se lanzan en PS 7 automaticamente.' -ForegroundColor DarkGray
        Write-Host '  Si quieres reinstalar / actualizar a una version mas nueva, pulsa [R]. Cualquier otra tecla para salir.' -ForegroundColor DarkGray
        $ans = Read-Host '  Opcion'
        if ($ans -notmatch '^[Rr]') { return }
    }

    if (-not (_Test-IsAdmin)) {
        Write-Host '  [!] Se requiere ejecutar como Administrador para instalar PowerShell 7.' -ForegroundColor Red
        Write-Host '      Cierra esta ventana y relanza el panel en modo admin.' -ForegroundColor DarkGray
        return
    }

    $offline = _Find-OfflineMsi
    if ($offline) {
        Write-Host "  [i] MSI local encontrado: $offline" -ForegroundColor Cyan
        Write-Host '      Se instalara sin descargar nada de internet.' -ForegroundColor DarkGray
    } else {
        Write-Host "  [i] MSI local NO encontrado. Se descargara de github.com/PowerShell/PowerShell (~120 MB)." -ForegroundColor Cyan
        Write-Host "      Version a instalar: $PS7_VERSION" -ForegroundColor DarkGray
    }

    Write-Host ''
    $go = Read-Host '  Continuar? [S/n]'
    if ($go -match '^[Nn]') {
        Write-Host '  Cancelado.' -ForegroundColor DarkGray
        return
    }

    Write-Host ''
    try {
        $installed = _Install-PS7 -OfflineSource $offline
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
