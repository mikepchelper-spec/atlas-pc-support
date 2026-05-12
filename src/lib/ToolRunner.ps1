# ============================================================
# Atlas PC Support - Tool runner
# Ejecuta una herramienta en una nueva ventana de PowerShell.
#
# Enfoque:
#   * Extraer la source cruda de la tool usando el AST parser de PS
#     directamente del archivo launcher en disco. El AST preserva
#     here-strings y HTML intactos, sin depender de base64 ni de
#     (Get-Command).Definition (que corrompe whitespace en PS 5.1).
#   * Escribir esa fuente + una llamada a Invoke-X + try/catch
#     en un .ps1 temporal.
#   * Envolverlo en un .cmd que llama powershell.exe -File y DESPUES
#     hace pause, para sobrevivir llamadas a 'exit' dentro de la tool.
#   * Lanzar cmd.exe via Start-Process, con elevacion si procede.
#
# Por que NO usamos -EncodedCommand:
#   1. Limite de longitud de CreateProcess (~32 KB). Tools grandes
#      (FastCopy, Robocopy) superan el limite.
#   2. Interpolacion prematura de variables del cuerpo.
# ============================================================

function Get-AtlasToolSource {
    param([string]$FunctionName)
    # Leer el archivo launcher en disco y extraer la funcion por nombre
    # usando el AST parser. Preserva here-strings, HTML y cualquier
    # contenido literalmente, sin roundtrip por memoria.
    $launcherPath = $MyInvocation.ScriptName
    if (-not $launcherPath -or -not (Test-Path -LiteralPath $launcherPath)) {
        return $null
    }
    try {
        $ast = [System.Management.Automation.Language.Parser]::ParseFile(
            $launcherPath, [ref]$null, [ref]$null)
        $funcDef = $ast.FindAll({
            param($node)
            $node -is [System.Management.Automation.Language.FunctionDefinitionAst] -and
            $node.Name -eq $FunctionName
        }, $false) | Select-Object -First 1
        if (-not $funcDef) { return $null }
        # Leer los bytes exactos del archivo para preservar encoding original
        $allText = [System.IO.File]::ReadAllText($launcherPath, [System.Text.UTF8Encoding]::new($false))
        $start   = $funcDef.Extent.StartOffset
        $end     = $funcDef.Extent.EndOffset
        return $allText.Substring($start, $end - $start)
    } catch {
        Write-AtlasLog "Get-AtlasToolSource fallo para '$FunctionName': $_" -Level WARN -Tool 'Runner'
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

    # Ejecucion inline (sin nueva ventana) es para helpers/gui; raro.
    if (-not $runInNew) {
        try { & $function } catch {
            Write-AtlasLog "Error en ${function}: $_" -Level ERROR -Tool 'Runner'
            [System.Windows.MessageBox]::Show("Error: $_", 'Atlas PC Support', 'OK', 'Error') | Out-Null
        }
        return
    }

    # ----------- Recuperar la source cruda via AST -----------
    $rawSource = Get-AtlasToolSource -FunctionName $function

    if (-not $rawSource) {
        # Fallback: si el launcher no esta en disco (p.ej. dev desde src/)
        # usar .Definition como ultimo recurso.
        $cmd = Get-Command $function -CommandType Function -ErrorAction SilentlyContinue
        if (-not $cmd) {
            $msg = "La funcion '$function' no esta disponible."
            Write-AtlasLog $msg -Level ERROR -Tool 'Runner'
            [System.Windows.MessageBox]::Show($msg, 'Atlas PC Support', 'OK', 'Error') | Out-Null
            return
        }
        $funcBody = $cmd.Definition -replace "[\uFEFF\u200B]", ""
        $rawSource = "function $function {`n$funcBody`n}`n"
    } else {
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
    # Preferimos pwsh.exe (PS 7+) si esta instalado: mejor encoding por
    # defecto, enums modernos (AutomaticDelayedStart, etc.) y Set-Service
    # con mas parametros. Caemos a powershell.exe 5.1 solo si PS 7 no esta.
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
