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

    # Limpiar BOM UTF-8 (U+FEFF) y zero-width space (U+200B) en CUALQUIER
    # posicion del cuerpo. No solo al inicio: algunos archivos fuente tienen
    # el BOM en medio (p.ej. re-guardados por editor) y el parser revienta
    # con 'The term ''#'' is not recognized' si el BOM queda antes de un #.
    $funcBody = $funcBody -replace "[\uFEFF\u200B]", ""
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
    $stamp       = "$($Tool.id)-$(Get-Random)"
    $tempScript  = Join-Path $tempDir "run-$stamp.ps1"
    $tempWrapper = Join-Path $tempDir "run-$stamp.cmd"

    # Escribir .ps1 SIN BOM (UTF-8 without BOM).
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($tempScript, $sb.ToString(), $utf8NoBom)

    # Wrapper .cmd: necesario porque muchas tools llaman 'exit' dentro de
    # PowerShell, lo que termina el proceso antes de que podamos pausar.
    # Con un wrapper cmd.exe /c, el 'exit' de PS solo sale del child;
    # cmd.exe sigue vivo y ejecuta 'pause' para que la ventana no se cierre.
    # El .cmd wrapper se escribe puramente en ASCII (el titulo real de la
    # ventana lo gestiona el .ps1 via $Host.UI.RawUI.WindowTitle).
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
