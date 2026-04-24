# ============================================================
# Atlas PC Support - Tool runner
# Ejecuta una herramienta en una nueva ventana de PowerShell.
# ============================================================

function Invoke-AtlasTool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [hashtable]$Tool,
        [hashtable]$Branding
    )

    Write-AtlasLog "Ejecutando: $($Tool.name) [$($Tool.id)]" -Tool 'Runner'

    $function = $Tool.function
    $cmd = Get-Command $function -ErrorAction SilentlyContinue
    if (-not $cmd) {
        $msg = "La función '$function' no está cargada. Revisa que el tool esté en src/tools/ y registrado en tools.json."
        Write-AtlasLog $msg -Level ERROR -Tool 'Runner'
        [System.Windows.MessageBox]::Show($msg, 'Atlas PC Support', 'OK', 'Error') | Out-Null
        return
    }

    if ($Tool.requiresAdmin -and -not (Test-IsAdmin)) {
        Write-AtlasLog "Tool requiere admin — relanzando elevada." -Level WARN -Tool 'Runner'
    }

    $runInNew = $true
    if ($Tool.ContainsKey('runsInNewWindow')) {
        $runInNew = [bool]$Tool.runsInNewWindow
    }

    if ($runInNew) {
        $title = "$($Branding.brand.shortName) — $($Tool.name)"

        # Serializar la función: necesitamos que la nueva ventana la tenga definida.
        # Obtenemos el cuerpo de la función del scope actual y lo embebemos.
        $funcBody = (Get-Command $function -CommandType Function -ErrorAction SilentlyContinue).Definition
        if (-not $funcBody) {
            $msg = "No se pudo serializar la función '$function'. ¿Está cargada?"
            Write-AtlasLog $msg -Level ERROR -Tool 'Runner'
            [System.Windows.MessageBox]::Show($msg, 'Atlas PC Support', 'OK', 'Error') | Out-Null
            return
        }

        $fullScript = @"
`$Host.UI.RawUI.WindowTitle = '$title'
function $function {
$funcBody
}
try {
    $function
} catch {
    Write-Host ""
    Write-Host "[!] Error en ${function}: `$_" -ForegroundColor Red
}
Write-Host ""
Write-Host "Presiona Enter para cerrar esta ventana..." -ForegroundColor Yellow
[Console]::ReadLine() | Out-Null
"@

        $sb = [scriptblock]::Create($fullScript)

        if ($Tool.requiresAdmin) {
            Invoke-AsAdmin -ScriptBlock $sb -Title $title | Out-Null
        } else {
            $encoded = [Convert]::ToBase64String(
                [System.Text.Encoding]::Unicode.GetBytes($sb.ToString())
            )
            Start-Process -FilePath 'powershell.exe' -ArgumentList @(
                '-NoProfile','-ExecutionPolicy','Bypass',
                '-EncodedCommand', $encoded
            ) | Out-Null
        }
    } else {
        try { & $function } catch {
            Write-AtlasLog "Error en ${function}: $_" -Level ERROR -Tool 'Runner'
            [System.Windows.MessageBox]::Show("Error: $_", 'Atlas PC Support', 'OK', 'Error') | Out-Null
        }
    }
}
