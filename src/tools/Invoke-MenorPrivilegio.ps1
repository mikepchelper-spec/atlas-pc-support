# ============================================================
# Invoke-MenorPrivilegio
# Migrado de: Principio_Menor_Privilegio.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-MenorPrivilegio {
    [CmdletBinding()]
    param()
﻿# ATLAS PC SUPPORT - SECURITY SUITE v3.0
# Herramienta: Principio de Menor Privilegio + Hardening UAC
# Fixes: BSTR leak, SecureString check, wmic deprecated, shutdown /l, ErrorActionPreference
# Upscale: Auditoria, Deshabilitar cuenta, Politica de contraseñas, UAC en header, informe .txt

$ErrorActionPreference = "Stop"

# --- 0. AUTO-ELEVACION ---
# (auto-elevación gestionada por Atlas Launcher)

# --- 1. CONFIGURACION VISUAL ---
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT | Security Suite v3.0"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Gray"
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(90, 48) } catch {}
Clear-Host
try { [Console]::CursorVisible = $true } catch {}

# --- 2. DETECCION MULTI-IDIOMA (SIDs) ---
try {
    $objSIDAdmin = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544")
    $adminGroupName = $objSIDAdmin.Translate([System.Security.Principal.NTAccount]).Value.Split("\")[-1]

    $objSIDUser = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-545")
    $stdGroupName = $objSIDUser.Translate([System.Security.Principal.NTAccount]).Value.Split("\")[-1]
} catch {
    $adminGroupName = "Administradores"
    $stdGroupName = "Usuarios"
}

# --- 3. HELPERS ---

function Escribir-Centrado {
    param([string]$Texto, [ConsoleColor]$Color = "White", [boolean]$NewLine = $true)
    try {
        $Ancho = $Host.UI.RawUI.WindowSize.Width
        $PadLeft = [math]::Max(0, [math]::Floor(($Ancho - $Texto.Length) / 2))
        Write-Host (" " * $PadLeft) -NoNewline
        if ($NewLine) { Write-Host $Texto -ForegroundColor $Color }
        else { Write-Host $Texto -ForegroundColor $Color -NoNewline }
    } catch { Write-Host $Texto -ForegroundColor $Color }
}

function Obtener-EstadoUAC {
    try {
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
        $lua  = (Get-ItemProperty -Path $regPath -Name "EnableLUA" -ErrorAction SilentlyContinue).EnableLUA
        $sdt  = (Get-ItemProperty -Path $regPath -Name "PromptOnSecureDesktop" -ErrorAction SilentlyContinue).PromptOnSecureDesktop
        $usr  = (Get-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorUser" -ErrorAction SilentlyContinue).ConsentPromptBehaviorUser
        $adm  = (Get-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorAdmin" -ErrorAction SilentlyContinue).ConsentPromptBehaviorAdmin
        if ($lua -eq 1 -and $sdt -eq 1 -and $usr -eq 1 -and $adm -eq 2) { return @{ Texto = "UAC: MAXIMO [OK]"; Color = "Green" } }
        elseif ($lua -eq 0) { return @{ Texto = "UAC: DESACTIVADO [RIESGO]"; Color = "Red" } }
        else { return @{ Texto = "UAC: PARCIAL [REVISAR]"; Color = "Yellow" } }
    } catch { return @{ Texto = "UAC: DESCONOCIDO"; Color = "DarkGray" } }
}

function Obtener-RolUsuario {
    param([string]$NombreUsuario)
    try {
        $miembros = Get-LocalGroupMember -SID "S-1-5-32-544" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name.Split("\")[-1] }
        if ($miembros -contains $NombreUsuario) { return "Administrador" } else { return "Estandar" }
    } catch { return "Desconocido" }
}

function Dibujar-Header {
    Clear-Host
    Write-Host "`n"
    $uac = Obtener-EstadoUAC
    $rol = Obtener-RolUsuario $env:USERNAME
    $rolColor = if ($rol -eq "Administrador") { "Cyan" } else { "Green" }

    Escribir-Centrado "==========================================================" "DarkGray"
    Escribir-Centrado "A T L A S   P C   S U P P O R T" "Cyan"
    Escribir-Centrado "Security Suite v3.0" "DarkGray"
    Escribir-Centrado "==========================================================" "DarkGray"
    Write-Host ""
    Escribir-Centrado "Usuario: $env:USERNAME  |  Rol: $rol" $rolColor
    Escribir-Centrado $uac.Texto $uac.Color
    Escribir-Centrado "==========================================================" "DarkGray"
    Write-Host ""
}

function Validar-Contrasena {
    param([System.Security.SecureString]$Pass)
    if ($Pass.Length -lt 8) { return "La contrasena debe tener al menos 8 caracteres." }
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Pass)
    try {
        $plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
        if ($plain -notmatch '[0-9]')         { return "Debe contener al menos un numero." }
        if ($plain -notmatch '[A-Z]')         { return "Debe contener al menos una mayuscula." }
        if ($plain -notmatch '[^a-zA-Z0-9]') { return "Debe contener al menos un caracter especial." }
        return $null
    } finally {
        [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    }
}


function Escribir-Descripcion {
    param(
        [string]$Que,
        [string]$Recomendacion,
        [string]$Precaucion
    )
    $w = $Host.UI.RawUI.WindowSize.Width
    $sep = "-" * 54
    $pad = [math]::Max(0, [math]::Floor(($w - 56) / 2))
    $s = " " * $pad
    Write-Host "$s+$sep+" -ForegroundColor DarkGray
    Write-Host "$s|  " -NoNewline; Write-Host ("QUE HACE:".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    # Wrap Que
    $words = $Que -split ' '; $line = "  "; foreach ($word in $words) { if (($line + $word).Length -gt 51) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor White -NoNewline; Write-Host "|" -ForegroundColor DarkGray; $line = "  $word " } else { $line += "$word " } }; if ($line.Trim()) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor White -NoNewline; Write-Host "|" -ForegroundColor DarkGray }
    Write-Host "$s|  " -NoNewline; Write-Host ("".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    Write-Host "$s|  " -NoNewline; Write-Host ("RECOMENDACION:".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    $words = $Recomendacion -split ' '; $line = "  "; foreach ($word in $words) { if (($line + $word).Length -gt 51) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor Cyan -NoNewline; Write-Host "|" -ForegroundColor DarkGray; $line = "  $word " } else { $line += "$word " } }; if ($line.Trim()) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor Cyan -NoNewline; Write-Host "|" -ForegroundColor DarkGray }
    Write-Host "$s|  " -NoNewline; Write-Host ("".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    Write-Host "$s|  " -NoNewline; Write-Host ("PRECAUCION:".PadRight(53)) -ForegroundColor DarkGray -NoNewline; Write-Host "|" -ForegroundColor DarkGray
    $words = $Precaucion -split ' '; $line = "  "; foreach ($word in $words) { if (($line + $word).Length -gt 51) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor Yellow -NoNewline; Write-Host "|" -ForegroundColor DarkGray; $line = "  $word " } else { $line += "$word " } }; if ($line.Trim()) { Write-Host "$s|  " -NoNewline; Write-Host ($line.PadRight(53)) -ForegroundColor Yellow -NoNewline; Write-Host "|" -ForegroundColor DarkGray }
    Write-Host "$s+$sep+" -ForegroundColor DarkGray
    Write-Host ""
}


function Escribir-Descripcion {
    param([string]$Que, [string]$Recomendacion, [string]$Precaucion)
    $w   = $Host.UI.RawUI.WindowSize.Width
    $sep = "-" * 54
    $pad = [math]::Max(0, [math]::Floor(($w - 58) / 2))
    $s   = " " * $pad
    function WrapLine($txt, $col) {
        $words = $txt -split ' '; $line = "  "
        foreach ($word in $words) {
            if (($line + $word).Length -gt 51) {
                Write-Host "$s|  " -NoNewline
                Write-Host ($line.PadRight(53)) -ForegroundColor $col -NoNewline
                Write-Host "|" -ForegroundColor DarkGray
                $line = "  $word "
            } else { $line += "$word " }
        }
        if ($line.Trim()) {
            Write-Host "$s|  " -NoNewline
            Write-Host ($line.PadRight(53)) -ForegroundColor $col -NoNewline
            Write-Host "|" -ForegroundColor DarkGray
        }
    }
    function LabelLine($lbl) {
        Write-Host "$s|  " -NoNewline
        Write-Host ($lbl.PadRight(53)) -ForegroundColor DarkGray -NoNewline
        Write-Host "|" -ForegroundColor DarkGray
    }
    function BlankLine {
        Write-Host "$s|  " -NoNewline
        Write-Host ("".PadRight(53)) -NoNewline
        Write-Host "|" -ForegroundColor DarkGray
    }
    Write-Host "$s+$sep+" -ForegroundColor DarkGray
    LabelLine "  QUE HACE:"
    WrapLine $Que "White"
    BlankLine
    LabelLine "  RECOMENDACION:"
    WrapLine $Recomendacion "Cyan"
    BlankLine
    LabelLine "  PRECAUCION:"
    WrapLine $Precaucion "Yellow"
    Write-Host "$s+$sep+" -ForegroundColor DarkGray
    Write-Host ""
}

function Desencriptar-Pass {
    param([System.Security.SecureString]$Pass)
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Pass)
    try { return [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) }
    finally { [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR) }
}

# --- 4. LOGICA DEL MENU ---

do {
    Dibujar-Header

    $anchoPantalla = $Host.UI.RawUI.WindowSize.Width
    $textoReferencia = "5. Deshabilitar / Habilitar Cuenta de Usuario"
    $padBloque = [math]::Max(0, [math]::Floor(($anchoPantalla - $textoReferencia.Length) / 2))
    $espacio = " " * $padBloque
    $padInput = [math]::Max(0, [math]::Floor(($anchoPantalla - 10) / 2))

    Write-Host "$espacio" -NoNewline; Write-Host "1. Crear NUEVO Administrador (Respaldo)" -ForegroundColor White
    Write-Host "$espacio" -NoNewline; Write-Host "2. Convertir Usuario Actual a ESTANDAR" -ForegroundColor White
    Write-Host "$espacio" -NoNewline; Write-Host "3. Configuracion del UAC - Seguridad Maxima" -ForegroundColor Cyan
    Write-Host "$espacio" -NoNewline; Write-Host "4. Auditoria de Usuarios del Sistema" -ForegroundColor Yellow
    Write-Host "$espacio" -NoNewline; Write-Host "5. Deshabilitar / Habilitar Cuenta de Usuario" -ForegroundColor Magenta
    Write-Host "$espacio" -NoNewline; Write-Host "6. Configurar Politica de Contrasenas" -ForegroundColor DarkCyan
    Write-Host "$espacio" -NoNewline; Write-Host "7. Exportar Informe de Seguridad (.txt)" -ForegroundColor DarkYellow
    Write-Host "$espacio" -NoNewline; Write-Host "8. Salir" -ForegroundColor DarkGray
    Write-Host ""

    Write-Host (" " * $padInput) -NoNewline
    $seleccion = Read-Host "Opcion"

    switch ($seleccion) {

        # =========================================================
        "1" {
            Dibujar-Header
            Escribir-Centrado ">>> CREAR NUEVO ADMINISTRADOR <<<" "Green"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Crea una cuenta de Administrador local nueva con contrasena segura y sin caducidad. Sirve como cuenta de respaldo para recuperar el sistema si la cuenta principal falla." `
                -Recomendacion "Usa un nombre discreto (no admin ni backup). Guarda las credenciales en un gestor seguro como Bitwarden. Crea solo una cuenta de respaldo por equipo." `
                -Precaucion "Tener dos cuentas Admin activas amplia la superficie de ataque. Crea esta cuenta, verifica que funciona y luego aplica la opcion 2 al usuario principal."
            Escribir-Centrado "(Nombre en blanco = volver)" "DarkGray"
            Write-Host (" " * ($padInput - 5)) -NoNewline
            $newAdminUser = Read-Host "Nombre Admin"
            if ([string]::IsNullOrWhiteSpace($newAdminUser)) { break }

            # Comprobar si ya existe
            $existe = Get-LocalUser -Name $newAdminUser -ErrorAction SilentlyContinue
            if ($existe) {
                Escribir-Centrado "ERROR: Ya existe una cuenta con ese nombre." "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            Write-Host (" " * ($padInput - 5)) -NoNewline
            Write-Host "Contrasena (min 8 car., 1 num., 1 MAY., 1 especial): " -NoNewline -ForegroundColor Yellow
            $passSecure = Read-Host -AsSecureString

            if ($passSecure.Length -eq 0) {
                Escribir-Centrado "ERROR: La contrasena no puede estar vacia." "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            $errPass = Validar-Contrasena $passSecure
            if ($errPass) {
                Escribir-Centrado "ERROR: $errPass" "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            Write-Host ""
            Escribir-Centrado "Procesando..." "Cyan"

            try {
                New-LocalUser -Name $newAdminUser -Password $passSecure -PasswordNeverExpires $true -ErrorAction Stop | Out-Null
                Add-LocalGroupMember -SID "S-1-5-32-544" -Member $newAdminUser -ErrorAction Stop
                Escribir-Centrado "EXITO: Administrador '$newAdminUser' creado." "Green"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "2" {
            Dibujar-Header
            Escribir-Centrado ">>> CONVERTIR A ESTANDAR <<<" "Yellow"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Quita los privilegios de Administrador al usuario actual y lo convierte en usuario Estandar. Aplica el principio de menor privilegio para el uso diario del cliente." `
                -Recomendacion "Esta es la configuracion ideal para el dia a dia. Reduce drasticamente el riesgo de infecciones por malware y cambios accidentales en el sistema." `
                -Precaucion "IRREVERSIBLE sin otro Admin activo. El script lo verifica automaticamente, pero asegurate de que la cuenta de respaldo (opcion 1) ya existe y funciona antes de continuar."

            # Verificar que exista otro admin antes de proceder
            try {
                $todosAdmins = @(Get-LocalGroupMember -SID "S-1-5-32-544" -ErrorAction Stop | ForEach-Object { $_.Name.Split("\")[-1] })
                $otrosAdmins = $todosAdmins | Where-Object { $_ -ne $env:USERNAME }
                if ($otrosAdmins.Count -eq 0) {
                    Escribir-Centrado "BLOQUEADO: No existe otro Administrador activo." "Red"
                    Escribir-Centrado "Crea uno primero con la opcion 1." "Yellow"
                    Read-Host "`nPresione Enter para continuar..."
                    break
                }
            } catch {
                Escribir-Centrado "ERROR al verificar admins: $($_.Exception.Message)" "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            Escribir-Centrado "ATENCION: Esta accion quitara tus permisos de Admin." "Red"
            Escribir-Centrado "Otro administrador detectado: OK" "Green"
            Write-Host ""
            Escribir-Centrado "(Escribe 'SI' para confirmar, o Enter para volver)" "Gray"
            Write-Host (" " * ($padInput - 10)) -NoNewline
            $confirm = Read-Host "Confirmar"
            if ($confirm -ne "SI") { break }

            $targetUser = $env:USERNAME
            Escribir-Centrado "Procesando..." "Cyan"

            try {
                Add-LocalGroupMember -SID "S-1-5-32-545" -Member $targetUser -ErrorAction SilentlyContinue
                Remove-LocalGroupMember -SID "S-1-5-32-544" -Member $targetUser -ErrorAction Stop
                Escribir-Centrado "PERMISOS ACTUALIZADOS. Ahora eres usuario Estandar." "Green"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
                Read-Host "`nPresione Enter para continuar..."
                break
            }

            Write-Host ""
            Write-Host (" " * ($padInput - 10)) -NoNewline
            $logoff = Read-Host "Cerrar sesion ahora para aplicar cambios? (S/N)"
            if ($logoff -eq "S" -or $logoff -eq "s") {
                Start-Process "shutdown.exe" -ArgumentList "/l"
                return
            }
        }

        # =========================================================
        "3" {
            Dibujar-Header
            Escribir-Centrado ">>> BLINDAJE DE SEGURIDAD (UAC) <<<" "Cyan"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Activa el Control de Cuentas de Usuario (UAC) al nivel maximo. Obliga a introducir credenciales de Admin para instalar software o cambiar configuraciones criticas del sistema." `
                -Recomendacion "Ejecutar siempre despues de convertir al usuario a Estandar (opcion 2). Es la segunda capa de defensa mas importante. Aplica en cada entrega de equipo." `
                -Precaucion "El cliente vera mas ventanas de confirmacion. Informa que es por seguridad. Puede interrumpir flujos de trabajo de usuarios acostumbrados a trabajar sin UAC activo."
            Escribir-Centrado "Se aplicaran estas 4 reglas de registro:" "White"
            Write-Host ""
            Escribir-Centrado "  [1] EnableLUA = 1              (UAC activo)" "Gray"
            Escribir-Centrado "  [2] PromptOnSecureDesktop = 1  (Escritorio seguro)" "Gray"
            Escribir-Centrado "  [3] ConsentPromptBehaviorUser = 1  (Credenciales para estandar)" "Gray"
            Escribir-Centrado "  [4] ConsentPromptBehaviorAdmin = 2 (Credenciales para admins)" "Gray"
            Write-Host ""
            Escribir-Centrado "(Enter para aplicar, 'N' para cancelar)" "Gray"
            Write-Host (" " * $padInput) -NoNewline
            $uacConf = Read-Host ""
            if ($uacConf -eq "N" -or $uacConf -eq "n") { break }

            try {
                $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
                Escribir-Centrado "Aplicando reglas de registro..." "DarkGray"

                Set-ItemProperty -Path $regPath -Name "EnableLUA"                    -Value 1 -ErrorAction Stop
                Set-ItemProperty -Path $regPath -Name "PromptOnSecureDesktop"        -Value 1 -ErrorAction Stop
                Set-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorUser"    -Value 1 -ErrorAction Stop
                Set-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorAdmin"   -Value 2 -ErrorAction Stop

                Write-Host ""
                Escribir-Centrado "CONFIGURACION APLICADA." "Green"
                Escribir-Centrado "Windows pedira credenciales para instalar software." "Gray"
                Escribir-Centrado "Se requiere reinicio para aplicar completamente." "Yellow"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "4" {
            Dibujar-Header
            Escribir-Centrado ">>> AUDITORIA DE USUARIOS DEL SISTEMA <<<" "Yellow"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Lista todas las cuentas locales del equipo mostrando nombre, rol (Admin/Estandar), estado (activa/desactivada) y si tienen contrasena requerida." `
                -Recomendacion "Ejecuta antes y despues de cualquier cambio para verificar el estado real. Ideal para documentar la configuracion al inicio y al final de una intervencion tecnica." `
                -Precaucion "Solo lectura, no realiza ningun cambio. Si ves cuentas Admin desconocidas o cuentas activas sin contrasena, investiga antes de continuar con otras opciones."

            try {
                $usuarios = Get-LocalUser -ErrorAction Stop
                $admins   = @(Get-LocalGroupMember -SID "S-1-5-32-544" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name.Split("\")[-1] })

                $anchoPantalla2 = $Host.UI.RawUI.WindowSize.Width
                $lineaEncabezado = "{0,-22} {1,-14} {2,-12} {3,-10}" -f "USUARIO","ROL","ESTADO","CLAVE"
                $padAudit = [math]::Max(0, [math]::Floor(($anchoPantalla2 - $lineaEncabezado.Length) / 2))
                $spc = " " * $padAudit

                Write-Host "$spc$lineaEncabezado" -ForegroundColor DarkGray
                Write-Host "$spc$("-" * $lineaEncabezado.Length)" -ForegroundColor DarkGray

                foreach ($u in $usuarios) {
                    $rol    = if ($admins -contains $u.Name) { "Admin" } else { "Estandar" }
                    $estado = if ($u.Enabled) { "Activa" } else { "Desactivada" }
                    $clave  = if ($u.PasswordRequired) { "Requerida" } else { "No req." }
                    $linea  = "{0,-22} {1,-14} {2,-12} {3,-10}" -f $u.Name, $rol, $estado, $clave

                    $color = if (!$u.Enabled) { "DarkGray" }
                             elseif ($rol -eq "Admin") { "Cyan" }
                             else { "White" }
                    Write-Host "$spc$linea" -ForegroundColor $color
                }
                Write-Host ""
                Escribir-Centrado "Total: $($usuarios.Count) cuenta(s) | Admins: $($admins.Count)" "DarkGray"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "5" {
            Dibujar-Header
            Escribir-Centrado ">>> DESHABILITAR / HABILITAR CUENTA <<<" "Magenta"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Desactiva o reactiva una cuenta local sin eliminarla. Una cuenta desactivada no puede iniciar sesion pero conserva todos sus datos y configuracion intactos." `
                -Recomendacion "Prefiere deshabilitar sobre eliminar. Si en el futuro necesitas recuperar acceso a esa cuenta, podras reactivarla sin perder datos ni configuracion del perfil." `
                -Precaucion "No puedes deshabilitar tu propia cuenta activa. No deshabilites la unica cuenta Admin del sistema o el equipo quedara inaccesible sin reinstalar Windows."

            try {
                $usuarios = Get-LocalUser -ErrorAction Stop | Where-Object { $_.Name -ne $env:USERNAME }
                if ($usuarios.Count -eq 0) {
                    Escribir-Centrado "No hay otras cuentas disponibles." "Yellow"
                    Read-Host "`nPresione Enter para continuar..."
                    break
                }

                $anchoPantalla3 = $Host.UI.RawUI.WindowSize.Width
                $i = 1
                foreach ($u in $usuarios) {
                    $estado = if ($u.Enabled) { "[ACTIVA]" } else { "[DESACTIVADA]" }
                    $color  = if ($u.Enabled) { "White" } else { "DarkGray" }
                    $linea  = "  $i. $($u.Name) $estado"
                    $pad3   = [math]::Max(0, [math]::Floor(($anchoPantalla3 - $linea.Length) / 2))
                    Write-Host (" " * $pad3 + $linea) -ForegroundColor $color
                    $i++
                }

                Write-Host ""
                Escribir-Centrado "(Numero de cuenta, o Enter para volver)" "DarkGray"
                Write-Host (" " * $padInput) -NoNewline
                $numStr = Read-Host "Cuenta"
                if ([string]::IsNullOrWhiteSpace($numStr)) { break }

                $num = 0
                if (![int]::TryParse($numStr, [ref]$num) -or $num -lt 1 -or $num -gt $usuarios.Count) {
                    Escribir-Centrado "Numero invalido." "Red"
                    Read-Host "`nPresione Enter para continuar..."
                    break
                }

                $cuentaElegida = @($usuarios)[$num - 1]
                if ($cuentaElegida.Enabled) {
                    Disable-LocalUser -Name $cuentaElegida.Name -ErrorAction Stop
                    Escribir-Centrado "Cuenta '$($cuentaElegida.Name)' DESHABILITADA." "Yellow"
                } else {
                    Enable-LocalUser -Name $cuentaElegida.Name -ErrorAction Stop
                    Escribir-Centrado "Cuenta '$($cuentaElegida.Name)' HABILITADA." "Green"
                }
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "6" {
            Dibujar-Header
            Escribir-Centrado ">>> POLITICA DE CONTRASENAS <<<" "DarkCyan"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Configura las reglas globales de contrasenas del sistema: longitud minima, dias hasta caducidad y numero de intentos fallidos antes de bloquear la cuenta." `
                -Recomendacion "Valores recomendados: longitud minima 10, expiracion 90 dias, bloqueo tras 5 intentos. Para uso domestico puedes poner expiracion 0 (nunca caduca)." `
                -Precaucion "Estos cambios afectan a TODAS las cuentas del equipo. Un lockout muy agresivo (3 intentos) puede bloquear al cliente si olvida su contrasena con frecuencia."

            try {
                $politicaActual = net accounts 2>$null | Select-String "Minimum|Maximum|Lockout" | ForEach-Object { "  " + $_.Line.Trim() }
                Escribir-Centrado "Politica actual:" "DarkGray"
                $politicaActual | ForEach-Object { Escribir-Centrado $_ "Gray" }
            } catch {}

            Write-Host ""
            Escribir-Centrado "--- Configurar nueva politica ---" "DarkCyan"
            Write-Host ""

            Write-Host (" " * ($padInput - 8)) -NoNewline
            $minLen = Read-Host "Longitud minima (Enter = no cambiar)"

            Write-Host (" " * ($padInput - 8)) -NoNewline
            $maxAge = Read-Host "Dias hasta expiracion (Enter = no cambiar, 0 = nunca)"

            Write-Host (" " * ($padInput - 8)) -NoNewline
            $lockout = Read-Host "Intentos antes de bloquear (Enter = no cambiar)"

            $cambios = 0
            try {
                if (![string]::IsNullOrWhiteSpace($minLen) -and $minLen -match '^\d+$') {
                    net accounts /minpwlen:$minLen | Out-Null; $cambios++
                }
                if (![string]::IsNullOrWhiteSpace($maxAge) -and $maxAge -match '^\d+$') {
                    net accounts /maxpwage:$maxAge | Out-Null; $cambios++
                }
                if (![string]::IsNullOrWhiteSpace($lockout) -and $lockout -match '^\d+$') {
                    net accounts /lockoutthreshold:$lockout | Out-Null; $cambios++
                }
                if ($cambios -gt 0) { Escribir-Centrado "$cambios cambio(s) aplicados." "Green" }
                else { Escribir-Centrado "Sin cambios." "DarkGray" }
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "7" {
            Dibujar-Header
            Escribir-Centrado ">>> EXPORTAR INFORME DE SEGURIDAD <<<" "DarkYellow"
            Write-Host ""
            Escribir-Descripcion `
                -Que "Genera un archivo .txt en el escritorio con el estado completo de seguridad: nivel UAC, lista de usuarios con roles y estados, y politica de contrasenas vigente." `
                -Recomendacion "Genera el informe al inicio y al final de cada intervencion. Guardalo en la ficha del cliente como evidencia del trabajo realizado y estado del equipo." `
                -Precaucion "El informe contiene informacion sensible (nombres de cuentas, configuracion). No lo dejes en el escritorio del cliente: guardalo en tu sistema y elimina la copia local."
            Escribir-Centrado "Generando informe..." "Cyan"

            try {
                $uac      = Obtener-EstadoUAC
                $usuarios = Get-LocalUser -ErrorAction Stop
                $admins   = @(Get-LocalGroupMember -SID "S-1-5-32-544" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name.Split("\")[-1] })
                $politica = net accounts 2>$null

                $lineas = @()
                $lineas += "=========================================================="
                $lineas += "  ATLAS PC SUPPORT - INFORME DE SEGURIDAD"
                $lineas += "  Fecha    : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
                $lineas += "  Equipo   : $env:COMPUTERNAME"
                $lineas += "  Usuario  : $env:USERNAME"
                $lineas += "=========================================================="
                $lineas += ""
                $lineas += "--- ESTADO UAC ---"
                $lineas += "  " + $uac.Texto
                $lineas += ""
                $lineas += "--- USUARIOS LOCALES ---"
                $lineas += "  {0,-22} {1,-14} {2,-12} {3}" -f "NOMBRE","ROL","ESTADO","CLAVE"
                $lineas += "  " + ("-" * 60)
                foreach ($u in $usuarios) {
                    $rol    = if ($admins -contains $u.Name) { "Admin" } else { "Estandar" }
                    $estado = if ($u.Enabled) { "Activa" } else { "Desactivada" }
                    $clave  = if ($u.PasswordRequired) { "Requerida" } else { "No req." }
                    $lineas += "  {0,-22} {1,-14} {2,-12} {3}" -f $u.Name, $rol, $estado, $clave
                }
                $lineas += ""
                $lineas += "--- POLITICA DE CONTRASENAS ---"
                $politica | ForEach-Object { $lineas += "  $_" }
                $lineas += ""
                $lineas += "=========================================================="
                $lineas += "  Informe generado por Atlas PC Support Security Suite v3.0"
                $lineas += "=========================================================="

                $rutaInforme = "$env:USERPROFILE\Desktop\Informe_Seguridad_$(Get-Date -Format 'yyyyMMdd_HHmm').txt"
                $lineas | Out-File -FilePath $rutaInforme -Encoding UTF8
                Escribir-Centrado "Informe guardado en:" "Green"
                Escribir-Centrado $rutaInforme "White"
            } catch {
                Escribir-Centrado "ERROR: $($_.Exception.Message)" "Red"
            }
            Read-Host "`nPresione Enter para continuar..."
        }

        # =========================================================
        "8" { Exit }
    }

} while ($true)
}
