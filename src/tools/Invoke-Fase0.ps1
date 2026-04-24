# ============================================================
# Invoke-Fase0
# Migrado de: Fase+0.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-Fase0 {
    [CmdletBinding()]
    param()
<#
    .SYNOPSIS
    ATLAS PC SUPPORT - FASE 0: IPv6 Hardening Tool v4.0 (Smart Custom Log)
#>

# --- 1. CONFIGURACIÓN INICIAL ---
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$AtlasOrange = "$([char]0x1b)[38;2;255;102;0m"
$AtlasWhite  = "$([char]0x1b)[38;2;255;255;255m"
$AtlasGray   = "$([char]0x1b)[38;2;100;100;100m"
$AtlasGreen  = "$([char]0x1b)[38;2;0;255;0m"
$AtlasRed    = "$([char]0x1b)[38;2;255;50;50m"
$Reset       = "$([char]0x1b)[0m"

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

# Variables globales para el sistema de logs
$global:IsLogging = $false 
$global:LogFile = ""

# --- 2. AUTO-ELEVACIÓN A ADMINISTRADOR ---
# (auto-elevación gestionada por Atlas Launcher)

# --- 3. FUNCIONES VISUALES ---
function Write-Centered {
    param([string]$Text, [string]$Color = $AtlasWhite)
    $WindowWidth = $Host.UI.RawUI.WindowSize.Width
    $Padding = [math]::Max(0, [int](($WindowWidth - $Text.Length) / 2))
    $LeftSpaces = " " * $Padding
    Write-Host "$LeftSpaces$Color$Text$Reset"
}

function Show-Header {
    Clear-Host
    Write-Host "`n`n`n"
    Write-Centered "ATLAS PC SUPPORT" $AtlasOrange
    Write-Centered "SEGURIDAD FASE 0" $AtlasWhite
    Write-Centered "================================" $AtlasGray
    
    if ($global:IsLogging) {
        Write-Centered "[ REC ] BITÁCORA ACTIVA" $AtlasRed
    } else {
        Write-Centered "[   ] BITÁCORA INACTIVA" $AtlasGray
    }
    Write-Host "`n`n"
}

# --- 4. MOTOR DE LOGS PERSONALIZADO ---
function Write-AtlasLog {
    param([string]$Message)
    # Solo escribe en el archivo si la bitácora está activa
    if ($global:IsLogging -and $global:LogFile) {
        $Timestamp = Get-Date -Format "HH:mm:ss"
        "[$Timestamp] $Message" | Out-File -FilePath $global:LogFile -Append -Encoding UTF8
    }
}

function Start-AtlasLog {
    if ($global:IsLogging) {
        Show-Header; Write-Centered "La bitácora ya está iniciada." $AtlasOrange; Start-Sleep -Seconds 2; return
    }

    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    $LogFolder = Join-Path -Path $DesktopPath -ChildPath "ATLAS_SUPPORT"
    if (-not (Test-Path -Path $LogFolder)) { New-Item -ItemType Directory -Path $LogFolder -Force | Out-Null }
    
    $TimeString = Get-Date -Format "yyyyMMdd_HHmmss"
    $global:LogFile = Join-Path -Path $LogFolder -ChildPath "Reporte_Fase0_$TimeString.txt"
    $global:IsLogging = $true
    
    # Escribir encabezado profesional en el archivo de texto
    $ReportHeader = "=========================================`n" +
                    " ATLAS PC SUPPORT - REPORTE TÉCNICO`n" +
                    "=========================================`n" +
                    "Fecha de inicio : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')`n" +
                    "Equipo Cliente  : $env:COMPUTERNAME`n" +
                    "Usuario         : $env:USERNAME`n" +
                    "=========================================`n"
    $ReportHeader | Out-File -FilePath $global:LogFile -Encoding UTF8
    
    Show-Header
    Write-Centered "Bitácora iniciada correctamente." $AtlasGreen
    Start-Sleep -Seconds 1
}

function Stop-AtlasLog {
    if (-not $global:IsLogging) { return }
    
    Write-AtlasLog "--- CIERRE DE SESIÓN ---"
    $global:IsLogging = $false
    
    Show-Header
    Write-Centered "Reporte guardado exitosamente." $AtlasGreen
    Start-Sleep -Seconds 1
}

# --- 5. FUNCIONES DE LÓGICA CON LOGS ---
function Hardening-Apply {
    Show-Header
    Write-Centered "[ APLICANDO PROTOCOLO DE BLINDAJE ]" $AtlasWhite
    Write-Host "`n"
    
    Write-AtlasLog "-> INICIANDO PROTOCOLO DE BLINDAJE (FASE 0)"

    Write-Centered "Desactivando Teredo Tunneling... [OK]" $AtlasGreen
    Write-AtlasLog "[EJECUTANDO] Desactivando Teredo Tunneling..."
    $res1 = netsh interface teredo set state disabled
    Write-AtlasLog "Resultado: $res1"
    
    Write-Centered "Desactivando 6to4 Interface... [OK]" $AtlasGreen
    Write-AtlasLog "[EJECUTANDO] Desactivando 6to4 Interface..."
    $res2 = netsh interface ipv6 6to4 set state state=disabled undoonstop=disabled
    Write-AtlasLog "Resultado: $res2"

    Write-Centered "Desactivando ISATAP Tunneling... [OK]" $AtlasGreen
    Write-AtlasLog "[EJECUTANDO] Desactivando ISATAP Tunneling..."
    $res3 = netsh interface ipv6 isatap set state state=disabled
    Write-AtlasLog "Resultado: $res3"

    Write-AtlasLog "-> FASE 0 COMPLETADA CON ÉXITO."

    Write-Host "`n"
    Write-Centered "FASE 0 COMPLETADA." $AtlasOrange
    Write-Host "`n"
    Write-Centered "[ Presiona cualquier tecla para volver ]" $AtlasGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Restore-Defaults {
    Show-Header
    Write-Centered "[ RESTAURANDO VALORES DE FÁBRICA ]" $AtlasRed
    Write-Host "`n"

    Write-AtlasLog "-> REVIRTIENDO CAMBIOS (RESTAURACIÓN DE FÁBRICA)"

    Write-Centered "Restaurando Teredo... [OK]" $AtlasWhite
    $res1 = netsh interface teredo set state type=default
    Write-AtlasLog "[EJECUTANDO] Restaurando Teredo... Resultado: $res1"

    Write-Centered "Restaurando 6to4... [OK]" $AtlasWhite
    $res2 = netsh interface ipv6 6to4 set state state=enabled
    Write-AtlasLog "[EJECUTANDO] Restaurando 6to4... Resultado: $res2"

    Write-Centered "Restaurando ISATAP... [OK]" $AtlasWhite
    $res3 = netsh interface ipv6 isatap set state state=enabled
    Write-AtlasLog "[EJECUTANDO] Restaurando ISATAP... Resultado: $res3"

    Write-AtlasLog "-> ADVERTENCIA: El equipo ha sido devuelto a su estado predeterminado."

    Write-Host "`n"
    Write-Centered "WARN: El equipo ha vuelto a su estado vulnerable." $AtlasWhite
    Write-Host "`n"
    Write-Centered "[ Presiona cualquier tecla para volver ]" $AtlasGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Check-Status {
    Show-Header
    Write-Centered "[ ESTADO ACTUAL DE LA RED ]" $AtlasWhite
    Write-Host "`n"
    
    Write-AtlasLog "-> SOLICITANDO ESTADO ACTUAL DE INTERFACES"

    $Teredo = (netsh interface teredo show state | Out-String).Trim()
    $6to4 = (netsh interface ipv6 6to4 show state | Out-String).Trim()
    
    # Grabamos el resultado limpio en el log
    Write-AtlasLog "--- RESULTADO TEREDO ---`n$Teredo"
    Write-AtlasLog "--- RESULTADO 6to4 ---`n$6to4"

    Write-Centered "--- TEREDO STATE ---" $AtlasGray
    Write-Centered "$Teredo" $AtlasWhite
    Write-Host "`n"
    Write-Centered "--- 6to4 STATE ---" $AtlasGray
    Write-Centered "$6to4" $AtlasWhite
    Write-Host "`n"
    Write-Centered "[ Presiona cualquier tecla para volver ]" $AtlasGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# --- 6. MENÚ PRINCIPAL ---
do {
    Show-Header
    
    Write-Centered "[1] Iniciar bitácora               " $AtlasGreen
    Write-Centered "[2] EJECUTAR BLINDAJE (Recomendado)" $AtlasWhite
    Write-Centered "[3] Verificar Estado Actual        " $AtlasWhite
    Write-Centered "[4] Restaurar Configuración (Undo) " $AtlasRed
    Write-Centered "[5] Finalizar bitácora             " $AtlasGray
    Write-Centered "[Q] Salir                          " $AtlasGray
    
    Write-Host "`n      > Atlas_Admin@Terminal: " -NoNewline -ForegroundColor DarkYellow
    $Selection = Read-Host

    switch ($Selection) {
        '1' { Start-AtlasLog }
        '2' { Hardening-Apply }
        '3' { Check-Status }
        '4' { Restore-Defaults }
        '5' { Stop-AtlasLog }
        'q' { Stop-AtlasLog; exit }
        'Q' { Stop-AtlasLog; exit }
    }
} while ($true)
}
