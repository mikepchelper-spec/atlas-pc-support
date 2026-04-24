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

# --- FUNCIÓN: Renombrar Equipo ---
function Renombrar-Equipo {
    Escribir-Centrado "--- RENOMBRAR EQUIPO ---" "Cyan"
    Write-Host ""
    $actual = $env:COMPUTERNAME
    Write-Host "   Nombre actual: $actual" -ForegroundColor White
    Write-Host ""
    $nuevo = Read-Host "   -> Nuevo nombre (0 para cancelar)"
    if ($nuevo -eq "0" -or [string]::IsNullOrWhiteSpace($nuevo)) { return }
    if ($nuevo -notmatch '^[A-Za-z0-9\-]{1,15}$') {
        Write-Host "`n   [ERROR] Nombre invalido. Solo A-Z 0-9 y guion, max 15." -ForegroundColor Red
        Read-Host "`n   ENTER para volver"
        return
    }
    try {
        Rename-Computer -NewName $nuevo -Force -ErrorAction Stop
        Write-Host "`n   [OK] Nombre cambiado a: $nuevo" -ForegroundColor Green
        Write-Host "   Debe reiniciar el equipo para aplicar." -ForegroundColor Yellow
    } catch {
        Write-Host "`n   [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "`n   ENTER para volver"
}

# --- FUNCIÓN: Generar Checklist de Entrega (reporte) ---
function Generar-ChecklistEntrega {
    Escribir-Centrado "--- GENERANDO CHECKLIST DE ENTREGA ---" "Cyan"
    Write-Host ""
    Write-Host "   Recopilando informacion del equipo..." -ForegroundColor Yellow

    $report = @()
    $report += "==========================================="
    $report += "  ATLAS PC SUPPORT - CHECKLIST DE ENTREGA"
    $report += "==========================================="
    $report += "  Generado: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    $report += ""

    # Equipo
    try {
        $cs = Get-CimInstance Win32_ComputerSystem -ErrorAction Stop
        $bios = Get-CimInstance Win32_BIOS -ErrorAction Stop
        $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
        $report += "[EQUIPO]"
        $report += ("  Nombre:        {0}" -f $env:COMPUTERNAME)
        $report += ("  Fabricante:    {0}" -f $cs.Manufacturer)
        $report += ("  Modelo:        {0}" -f $cs.Model)
        $report += ("  Serial BIOS:   {0}" -f $bios.SerialNumber)
        $report += ("  OS:            {0}" -f $os.Caption)
        $report += ("  Version:       {0}" -f $os.Version)
        $report += ("  Build:         {0}" -f $os.BuildNumber)
        $report += ("  Arquitectura:  {0}" -f $os.OSArchitecture)
        $report += ("  RAM total:     {0:N1} GB" -f ($cs.TotalPhysicalMemory/1GB))
        $report += ""
    } catch {
        $report += "  [!] Error obteniendo info equipo: $($_.Exception.Message)"
    }

    # Activacion
    try {
        $licInfo = cscript.exe //Nologo "C:\Windows\System32\slmgr.vbs" /xpr 2>&1
        $report += "[ACTIVACION WINDOWS]"
        $licInfo | ForEach-Object { $report += "  $_" }
        $report += ""
    } catch {
        $report += "  [!] No se pudo consultar activacion."
    }

    # Usuarios
    try {
        $report += "[USUARIOS LOCALES]"
        Get-LocalUser -ErrorAction Stop | Where-Object { $_.Enabled } | ForEach-Object {
            $report += ("  - {0,-20} (FullName: {1})" -f $_.Name, $_.FullName)
        }
        $report += ""
        $report += "[ADMINISTRADORES]"
        $adminGroup = Get-LocalGroup | Where-Object SID -eq "S-1-5-32-544"
        if ($adminGroup) {
            Get-LocalGroupMember -Group $adminGroup -ErrorAction SilentlyContinue | ForEach-Object {
                $report += ("  - {0}" -f $_.Name)
            }
        }
        $report += ""
    } catch {
        $report += "  [!] Error listando usuarios: $($_.Exception.Message)"
    }

    # BitLocker
    try {
        $report += "[BITLOCKER]"
        $vols = Get-BitLockerVolume -ErrorAction Stop
        foreach ($v in $vols) {
            $report += ("  {0}: {1,-15} Protection: {2,-5} Enc: {3}%" -f $v.MountPoint, $v.VolumeStatus, $v.ProtectionStatus, $v.EncryptionPercentage)
            $rk = $v.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
            foreach ($r in $rk) {
                $report += ("     Recovery Key ID: {0}" -f $r.KeyProtectorId)
                $report += ("     Recovery Key:    {0}" -f $r.RecoveryPassword)
            }
        }
        $report += ""
    } catch {
        $report += "  [!] BitLocker no disponible o error: $($_.Exception.Message)"
        $report += ""
    }

    # Discos
    try {
        $report += "[DISCOS FISICOS]"
        Get-PhysicalDisk -ErrorAction Stop | ForEach-Object {
            $report += ("  - {0} {1}  {2:N0} GB  Health: {3}  Media: {4}" -f $_.FriendlyName, $_.SerialNumber, ($_.Size/1GB), $_.HealthStatus, $_.MediaType)
        }
        $report += ""
        $report += "[VOLUMENES]"
        Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter } | Sort-Object DriveLetter | ForEach-Object {
            $report += ("  {0}: {1,-15} {2:N1} GB libre de {3:N1} GB ({4})" -f $_.DriveLetter, $_.FileSystemLabel, ($_.SizeRemaining/1GB), ($_.Size/1GB), $_.FileSystem)
        }
        $report += ""
    } catch {
        $report += "  [!] Error discos: $($_.Exception.Message)"
    }

    # Windows Update
    try {
        $report += "[ULTIMAS ACTUALIZACIONES INSTALADAS]"
        Get-HotFix -ErrorAction Stop | Sort-Object InstalledOn -Descending | Select-Object -First 10 | ForEach-Object {
            $report += ("  - {0}  {1}  ({2})" -f $_.HotFixID, $_.InstalledOn, $_.Description)
        }
        $report += ""
    } catch {
        $report += "  [!] Error HotFix: $($_.Exception.Message)"
    }

    # Red
    try {
        $report += "[RED]"
        Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop | Where-Object { $_.IPAddress -notlike '169.*' -and $_.IPAddress -notlike '127.*' } | ForEach-Object {
            $report += ("  {0}: {1}/{2}" -f $_.InterfaceAlias, $_.IPAddress, $_.PrefixLength)
        }
        $report += ""
    } catch {}

    # Defender
    try {
        $mp = Get-MpComputerStatus -ErrorAction Stop
        $report += "[WINDOWS DEFENDER]"
        $report += ("  AV Enabled:          {0}" -f $mp.AntivirusEnabled)
        $report += ("  RealTime Protection: {0}" -f $mp.RealTimeProtectionEnabled)
        $report += ("  AV Signature:        {0}" -f $mp.AntivirusSignatureLastUpdated)
        $report += ""
    } catch {}

    # Checklist manual
    $report += "[CHECKLIST MANUAL PRE-ENTREGA]"
    $report += "  [ ] Hardware probado (pantalla, teclado, tactil, audio, USB)"
    $report += "  [ ] Bateria al 100% y cargador incluido"
    $report += "  [ ] Antivirus activo y actualizado"
    $report += "  [ ] BitLocker activado y recovery key guardada"
    $report += "  [ ] Windows Update al dia"
    $report += "  [ ] Navegador limpio (sin cuentas guardadas del tecnico)"
    $report += "  [ ] Usuario cliente creado con nombre correcto"
    $report += "  [ ] Password entregada fisicamente o por canal seguro"
    $report += "  [ ] Cliente informado sobre garantia y contacto"
    $report += "  [ ] Equipo limpio (polvo, pantalla, teclado)"
    $report += ""
    $report += "==========================================="
    $report += "  FIN DEL REPORTE"
    $report += "==========================================="

    # Guardar
    try {
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $desktop = [Environment]::GetFolderPath('Desktop')
        $out = Join-Path $desktop "atlas-entrega-$($env:COMPUTERNAME)-$stamp.txt"
        Set-Content -Path $out -Value $report -Encoding UTF8
        Write-Host ""
        Write-Host "   [OK] Reporte guardado en:" -ForegroundColor Green
        Write-Host "   $out" -ForegroundColor White
        try { Start-Process notepad.exe $out } catch {}
    } catch {
        Write-Host ""
        Write-Host "   [ERROR] No se pudo guardar: $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "`n   ENTER para volver"
}

# =================================================================
# BUCLE PRINCIPAL DEL MENÚ
# =================================================================
while ($true) {
    Mostrar-Encabezado

    $l1 = "[ 1 ]  Entregar equipo (Usuario actual: $env:USERNAME)"
    $l2 = "[ 2 ]  Crear un usuario nuevo adicional"
    $l3 = "[ 3 ]  Renombrar equipo"
    $l4 = "[ 4 ]  Generar CHECKLIST DE ENTREGA (reporte)"
    $l5 = "[ 5 ]  Salir y cerrar herramienta"

    $maxLen = [math]::Max($l1.Length, [math]::Max($l2.Length, [math]::Max($l3.Length, [math]::Max($l4.Length, $l5.Length))))

    Escribir-Centrado $l1.PadRight($maxLen) "White"
    Escribir-Centrado $l2.PadRight($maxLen) "White"
    Escribir-Centrado $l3.PadRight($maxLen) "White"
    Escribir-Centrado $l4.PadRight($maxLen) "Green"
    Escribir-Centrado $l5.PadRight($maxLen) "DarkGray"
    Write-Host ""

    $textoPrompt = "Seleccione una opción [1-5]"
    $ancho = $Host.UI.RawUI.WindowSize.Width
    $espacios = " " * ([math]::Max(0, [math]::Floor(($ancho - $textoPrompt.Length - 2) / 2)))
    Write-Host $espacios -NoNewline
    $opcion = Read-Host $textoPrompt

    switch ($opcion) {
        '1' { Mostrar-Encabezado; Modificar-UsuarioActual }
        '2' { Mostrar-Encabezado; Crear-NuevoUsuario }
        '3' { Mostrar-Encabezado; Renombrar-Equipo }
        '4' { Mostrar-Encabezado; Generar-ChecklistEntrega }
        '5' { Clear-Host; exit }
        default { Escribir-Centrado "Opción no válida." "Red"; Start-Sleep -s 1 }
    }
}
}
