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
        $sb = [scriptblock]::Create("& $function")

        if ($Tool.requiresAdmin) {
            Invoke-AsAdmin -ScriptBlock $sb -Title $title | Out-Null
        } else {
            $encoded = [Convert]::ToBase64String(
                [System.Text.Encoding]::Unicode.GetBytes($sb.ToString())
            )
            Start-Process -FilePath 'powershell.exe' -ArgumentList @(
                '-NoProfile','-ExecutionPolicy','Bypass','-NoExit',
                '-Command', "`$Host.UI.RawUI.WindowTitle = '$title'; & { `$sb = [scriptblock]::Create([System.Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('$encoded'))); & `$sb }"
            ) | Out-Null
        }
    } else {
        try { & $function } catch {
            Write-AtlasLog "Error en ${function}: $_" -Level ERROR -Tool 'Runner'
            [System.Windows.MessageBox]::Show("Error: $_", 'Atlas PC Support', 'OK', 'Error') | Out-Null
        }
    }
}
