# ============================================================
# Atlas PC Support - Auto-elevation
# Sustituye a los .bat de cada tool.
# ============================================================

function Test-IsAdmin {
    [CmdletBinding()]
    param()
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($id)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Invoke-SelfElevate {
    [CmdletBinding()]
    param(
        [string]$ScriptPath = $PSCommandPath
    )
    if (Test-IsAdmin) { return $true }

    if (-not $ScriptPath) {
        Write-Warning "No se puede auto-elevar: no hay ruta de script."
        return $false
    }

    try {
        Start-Process -FilePath "powershell.exe" `
            -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$ScriptPath`"") `
            -Verb RunAs | Out-Null
        exit 0
    } catch {
        Write-Warning "No se pudo elevar: $_"
        return $false
    }
}

function Invoke-AsAdmin {
    <#
    .SYNOPSIS
    Ejecuta un bloque de código en una nueva ventana de PowerShell elevada.
    .PARAMETER ScriptBlock
    Bloque de código a ejecutar.
    .PARAMETER Title
    Título de la ventana.
    .PARAMETER Wait
    Esperar a que termine antes de volver.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [scriptblock]$ScriptBlock,
        [string]$Title = "Atlas PC Support",
        [switch]$Wait
    )

    # Write the block to a temp file and run with -File instead of -EncodedCommand.
    # -EncodedCommand triggers AV heuristics on many endpoints.
    $tmp = Join-Path $env:TEMP ("atlas-admin-" + [guid]::NewGuid().ToString('N').Substring(0,8) + ".ps1")
    try {
        [System.IO.File]::WriteAllText($tmp, $ScriptBlock.ToString(), [System.Text.UTF8Encoding]::new($false))
    } catch {
        Write-Warning "No se pudo escribir script temporal: $_"
        return $false
    }

    $psArgs = @(
        "-NoProfile",
        "-ExecutionPolicy", "Bypass",
        "-File", $tmp
    )

    $startArgs = @{
        FilePath     = "powershell.exe"
        ArgumentList = $psArgs
        Verb         = "RunAs"
    }
    if ($Wait) { $startArgs.Wait = $true }

    try {
        Start-Process @startArgs | Out-Null
        # Cleanup is best-effort; the elevated process may still be running if -Wait was not set.
        if ($Wait) { Remove-Item $tmp -ErrorAction SilentlyContinue }
        return $true
    } catch {
        Remove-Item $tmp -ErrorAction SilentlyContinue
        Write-Warning "No se pudo lanzar ventana elevada: $_"
        return $false
    }
}
