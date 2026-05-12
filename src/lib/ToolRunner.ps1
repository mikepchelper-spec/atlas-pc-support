# ============================================================
# Atlas PC Support - Tool runner
# Ejecuta una herramienta en una nueva ventana de PowerShell.
#
# Las tools NO estan embebidas en el launcher. Se buscan en orden:
#   1. USB offline: deps\tools\ junto al launcher en disco
#   2. Cache local: %LOCALAPPDATA%\AtlasPC\tools\
#   3. Descarga desde GitHub (se guarda en cache para proximas veces)
#
# El script temporal se escribe con BOM UTF-8 para que PS 5.1 lo
# lea correctamente. Se envuelve en un .cmd que hace pause al final
# para sobrevivir llamadas a 'exit' dentro de la tool.
# ============================================================

function Get-AtlasToolScript {
    param([string]$FunctionName)

    $fileName  = "$FunctionName.ps1"
    $cacheDir  = Join-Path $env:LOCALAPPDATA 'AtlasPC\tools'
    $cachePath = Join-Path $cacheDir $fileName

    # 1. Buscar en USB offline: carpeta deps\tools\ junto al launcher
    $launcherDir = $null
    try {
        $launcherPath = $MyInvocation.ScriptName
        if ($launcherPath -and (Test-Path -LiteralPath $launcherPath)) {
            $launcherDir = Split-Path -Parent $launcherPath
        }
    } catch {}

    if ($launcherDir) {
        $usbPath = Join-Path $launcherDir "deps\tools\$fileName"
        if (Test-Path -LiteralPath $usbPath) {
            Write-AtlasLog "Tool desde USB: $usbPath" -Tool 'Runner'
            return $usbPath
        }
    }

    # 2. Cache local
    if (Test-Path -LiteralPath $cachePath) {
        Write-AtlasLog "Tool desde cache: $cachePath" -Tool 'Runner'
        return $cachePath
    }

    # 3. Descargar desde GitHub
    Write-AtlasLog "Descargando tool: $FunctionName" -Tool 'Runner'
    try {
        if (-not (Test-Path $cacheDir)) {
            New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null
        }
        $url = "$script:AtlasToolsBaseUrl/$fileName"
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri ($url + '?v=' + [guid]::NewGuid().ToString('N').Substring(0,8)) `
            -OutFile $cachePath -UseBasicParsing -TimeoutSec 60 -ErrorAction Stop
        Write-AtlasLog "Tool descargada: $cachePath" -Tool 'Runner'
        return $cachePath
    } catch {
        Write-AtlasLog "Fallo descarga de '$FunctionName': $_" -Level ERROR -Tool 'Runner'
        return $null
    }
}

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

    if (-not $runInNew) {
        # Inline (sin nueva ventana): cargar el script en el scope actual y llamar la funcion.
        $toolPath = Get-AtlasToolScript -FunctionName $function
        if (-not $toolPath) {
            $msg = "No se pudo obtener la tool '$function'."
            [System.Windows.MessageBox]::Show($msg, 'Atlas PC Support', 'OK', 'Error') | Out-Null
            return
        }
        try {
            . $toolPath
            & $function
        } catch {
            Write-AtlasLog "Error en ${function}: $_" -Level ERROR -Tool 'Runner'
            [System.Windows.MessageBox]::Show("Error: $_", 'Atlas PC Support', 'OK', 'Error') | Out-Null
        }
        return
    }

    # ----------- Obtener ruta del script de la tool -----------
    $toolScriptPath = Get-AtlasToolScript -FunctionName $function
    if (-not $toolScriptPath) {
        $msg = "No se pudo obtener la tool '$($Tool.name)'. Verifica tu conexion a internet."
        Write-AtlasLog $msg -Level ERROR -Tool 'Runner'
        [System.Windows.MessageBox]::Show($msg, 'Atlas PC Support', 'OK', 'Error') | Out-Null
        return
    }

    # ----------- Asegurar BOM para PS 5.1 -----------
    try {
        $bytes = [System.IO.File]::ReadAllBytes($toolScriptPath)
        if ($bytes.Length -lt 3 -or $bytes[0] -ne 0xEF -or $bytes[1] -ne 0xBB -or $bytes[2] -ne 0xBF) {
            $bom = [byte[]](0xEF, 0xBB, 0xBF)
            $withBom = New-Object byte[] ($bom.Length + $bytes.Length)
            [System.Buffer]::BlockCopy($bom, 0, $withBom, 0, $bom.Length)
            [System.Buffer]::BlockCopy($bytes, 0, $withBom, $bom.Length, $bytes.Length)
            [System.IO.File]::WriteAllBytes($toolScriptPath, $withBom)
        }
    } catch {
        Write-AtlasLog "BOM check fallo para '$function': $_" -Level WARN -Tool 'Runner'
    }

    $brandName = if ($Branding -and $Branding.brand -and $Branding.brand.shortName) { $Branding.brand.shortName } else { 'Atlas PC Support' }
    $title = "$brandName - $($Tool.name)"

    # ----------- Script temporal que llama a la tool -----------
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine('# Atlas PC Support - runner temp script')
    [void]$sb.AppendLine('$ErrorActionPreference = ''Continue''')
    [void]$sb.AppendLine('try { $Host.UI.RawUI.WindowTitle = ' + ("'{0}'" -f ($title -replace "'","''")) + ' } catch {}')
    [void]$sb.AppendLine('')
    # Dot-source el archivo de la tool (define la funcion)
    $escapedPath = $toolScriptPath -replace "'", "''"
    [void]$sb.AppendLine(". '$escapedPath'")
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

    $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
    [System.IO.File]::WriteAllText($tempScript, $sb.ToString(), $utf8WithBom)

    $psFile = $tempScript.Replace('%', '%%')
    $psExe = 'powershell.exe'
    if ($script:AtlasPS7CachedPath -and (Test-Path -LiteralPath $script:AtlasPS7CachedPath)) {
        $psExe = "`"$($script:AtlasPS7CachedPath)`""
    }
    $wrapperLines = @(
        '@echo off',
        'chcp 65001 > nul 2>&1',
        ($psExe + ' -NoProfile -ExecutionPolicy Bypass -File "' + $psFile + '"'),
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
