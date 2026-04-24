# ============================================================
# Invoke-EntregaPC
# Migrado de: Entrega_PC.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-EntregaPC {
    [CmdletBinding()]
    param()
﻿# =================================================================
# SCRIPT DE ENTREGA PREMIUM CENTRADO - ATLAS SOPORTE
# =================================================================

# 1. Forzar permisos de Administrador
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "ATENCIÓN: Este script necesita permisos de Administrador."
    Write-Warning "Haz clic derecho en el archivo y selecciona 'Ejecutar con PowerShell' como administrador."
    Pause
    return
}

# 2. Configurar la interfaz de la consola
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

# --- FUNCIÓN: Centrar Texto Mágicamente ---
function Escribir-Centrado {
    param([string]$texto, [string]$color)
    $anchoConsola = $Host.UI.RawUI.WindowSize.Width
    $espacios = " " * ([math]::Max(0, [math]::Floor(($anchoConsola - $texto.Length) / 2)))
    Write-Host ($espacios + $texto) -ForegroundColor $color
}

# --- FUNCIÓN: Mostrar el Logo ---
function Mostrar-Encabezado {
    Clear-Host
    Write-Host "`n"
    Escribir-Centrado " █████╗ ████████╗██╗      █████╗ ███████╗" "DarkYellow"
    Escribir-Centrado "██╔══██╗╚══██╔══╝██║     ██╔══██╗██╔════╝" "DarkYellow"
    Escribir-Centrado "███████║   ██║   ██║     ███████║███████╗" "DarkYellow"
    Escribir-Centrado "██╔══██║   ██║   ██║     ██╔══██║╚════██║" "DarkYellow"
    Escribir-Centrado "██║  ██║   ██║   ███████╗██║  ██║███████║" "DarkYellow"
    Escribir-Centrado "╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝" "DarkYellow"
    Escribir-Centrado "        P C   S U P P O R T              " "DarkYellow"
    Escribir-Centrado "=========================================" "DarkGray"
    Write-Host "`n"
}

# --- FUNCIÓN: Modificar Usuario Actual ---
function Modificar-UsuarioActual {
    $userName = $env:USERNAME
    Escribir-Centrado "--- CONFIGURANDO USUARIO ACTUAL: [$userName] ---" "Cyan"
    Write-Host ""
    Write-Host "   (Escriba '0' en cualquier momento para cancelar y volver)" -ForegroundColor DarkGray
    Write-Host ""
    
    $newDisplayName = Read-Host "   -> Nombre y apellido del cliente"
    if ($newDisplayName -eq "0") { return }
    
    Write-Host "   -> Contraseña (Escriba a ciegas y presione ENTER. Deje en blanco para NO usar clave)" -ForegroundColor Yellow
    $securePassword = Read-Host "      Clave" -AsSecureString

    try {
        if (![string]::IsNullOrWhiteSpace($newDisplayName)) {
            Set-LocalUser -Name $userName -FullName $newDisplayName
            Write-Host "`n   [OK] Nombre actualizado a: $newDisplayName" -ForegroundColor Green
        }
        if ($securePassword.Length -gt 0) {
            Set-LocalUser -Name $userName -Password $securePassword
            Write-Host "   [OK] Contraseña establecida." -ForegroundColor Green
        } else {
            Write-Host "`n   [OK] El usuario se mantiene sin contraseña." -ForegroundColor Green
        }
    } catch {
        Write-Host "`n   [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host "`n   Presione ENTER para volver al menú principal..." -ForegroundColor DarkGray
    Read-Host
}

# --- FUNCIÓN: Crear Usuario Nuevo ---
function Crear-NuevoUsuario {
    Escribir-Centrado "--- CREANDO NUEVO USUARIO ---" "Cyan"
    Write-Host ""
    Write-Host "   (Escriba '0' en cualquier momento para cancelar y volver)" -ForegroundColor DarkGray
    Write-Host ""
    
    $newUser = Read-Host "   -> Nombre interno de la cuenta (ej. jorge, sin espacios)"
    if ($newUser -eq "0" -or [string]::IsNullOrWhiteSpace($newUser)) { return }

    $newDisplayName = Read-Host "   -> Nombre completo para la pantalla (ej. Jorge Martínez)"
    if ($newDisplayName -eq "0") { return }
    
    Write-Host "   -> Contraseña (Escriba a ciegas y presione ENTER. Deje en blanco para NO usar clave)" -ForegroundColor Yellow
    $securePassword = Read-Host "      Clave" -AsSecureString
    
    $esAdmin = Read-Host "   -> ¿Hacer a este usuario Administrador? (S/N)"
    if ($esAdmin -eq "0") { return }

    try {
        if ($securePassword.Length -gt 0) {
            New-LocalUser -Name $newUser -FullName $newDisplayName -Password $securePassword -PasswordNeverExpires $true | Out-Null
        } else {
            New-LocalUser -Name $newUser -FullName $newDisplayName -NoPassword | Out-Null
        }
        Write-Host "`n   [OK] Usuario '$newUser' creado correctamente." -ForegroundColor Green

        if ($esAdmin -match "^[sS]") {
            $AdminGroup = Get-LocalGroup | Where-Object SID -eq "S-1-5-32-544"
            Add-LocalGroupMember -Group $AdminGroup -Member $newUser
            Write-Host "   [OK] Permisos de Administrador concedidos." -ForegroundColor Green
        } else {
            $UsersGroup = Get-LocalGroup | Where-Object SID -eq "S-1-5-32-545"
            Add-LocalGroupMember -Group $UsersGroup -Member $newUser
            Write-Host "   [OK] Permisos de Usuario Estándar concedidos." -ForegroundColor Green
        }
    } catch {
        Write-Host "`n   [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host "`n   Presione ENTER para volver al menú principal..." -ForegroundColor DarkGray
    Read-Host
}

# =================================================================
# BUCLE PRINCIPAL DEL MENÚ
# =================================================================
while ($true) {
    Mostrar-Encabezado
    
    # 1. Definir las líneas
    $l1 = "[ 1 ]  Entregar equipo (Usuario actual: $env:USERNAME)"
    $l2 = "[ 2 ]  Crear un usuario nuevo adicional"
    $l3 = "[ 3 ]  Salir y cerrar herramienta"
    
    # 2. Calcular la línea más larga para alinear el bloque
    $maxLen = [math]::Max($l1.Length, [math]::Max($l2.Length, $l3.Length))
    
    # 3. Imprimir rellenando con espacios a la derecha (.PadRight)
    Escribir-Centrado $l1.PadRight($maxLen) "White"
    Escribir-Centrado $l2.PadRight($maxLen) "White"
    Escribir-Centrado $l3.PadRight($maxLen) "DarkGray"
    Write-Host ""
    
    # Truco para centrar el prompt de elección (sin los dos puntos dobles)
    $textoPrompt = "Seleccione una opción [1-3]"
    $ancho = $Host.UI.RawUI.WindowSize.Width
    $espacios = " " * ([math]::Max(0, [math]::Floor(($ancho - $textoPrompt.Length - 2) / 2)))
    Write-Host $espacios -NoNewline
    $opcion = Read-Host $textoPrompt

    switch ($opcion) {
        '1' { Mostrar-Encabezado; Modificar-UsuarioActual }
        '2' { Mostrar-Encabezado; Crear-NuevoUsuario }
        '3' { Clear-Host; exit }
        default { Escribir-Centrado "Opción no válida." "Red"; Start-Sleep -s 1 }
    }
}
}
