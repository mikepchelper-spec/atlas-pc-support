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

    # .ps1 en UTF-8 sin BOM.
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($tempScript, $sb.ToString(), $utf8NoBom)

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
