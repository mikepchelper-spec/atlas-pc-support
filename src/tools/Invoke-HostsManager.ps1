# ============================================================
# Invoke-HostsManager
# Editor interactivo del archivo hosts de Windows con backups.
# Atlas PC Support - v1.0
# ============================================================

function Invoke-HostsManager {
    [CmdletBinding()]
    param()

    $hostsPath = Join-Path $env:SystemRoot 'System32\drivers\etc\hosts'

    try { $Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - GESTOR HOSTS" } catch {}

    $principal = [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin   = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    do {
        Clear-Host
        Write-Host ""
        Write-Host "  =================================================" -ForegroundColor DarkGray
        Write-Host "   ATLAS PC SUPPORT - GESTOR DEL ARCHIVO HOSTS" -ForegroundColor Yellow
        Write-Host "  =================================================" -ForegroundColor DarkGray
        Write-Host "  Ruta:  $hostsPath" -ForegroundColor Gray
        Write-Host "  Admin: $(if ($isAdmin) { 'SI' } else { 'NO (las escrituras fallaran)' })" -ForegroundColor $(if ($isAdmin) { 'Green' } else { 'Yellow' })
        Write-Host ""
        Write-Host "  Opciones:" -ForegroundColor Cyan
        Write-Host "    [1] Ver contenido actual"
        Write-Host "    [2] Hacer backup con timestamp"
        Write-Host "    [3] Agregar entrada (IP + nombre)"
        Write-Host "    [4] Eliminar lineas que contengan un nombre"
        Write-Host "    [5] Abrir en Notepad (admin)"
        Write-Host "    [6] Restaurar default (backup automatico previo)"
        Write-Host "    --- AVANZADO ---" -ForegroundColor Cyan
        Write-Host "    [7] Exportar hosts a Escritorio"
        Write-Host "    [8] Importar hosts desde archivo (con backup)"
        Write-Host "    [9] Aplicar StevenBlock ads/tracking (separado, con backup)" -ForegroundColor Yellow
        Write-Host "    [R] Revertir StevenBlock (restaurar pre-aplicacion)" -ForegroundColor Yellow
        Write-Host "    [Q] Salir"
        Write-Host ""
        $sel = Read-Host "  Seleccion"

        switch ($sel) {
            '1' {
                Write-Host ""
                if (Test-Path $hostsPath) {
                    Get-Content $hostsPath | ForEach-Object { Write-Host "    $_" -ForegroundColor Gray }
                } else {
                    Write-Host "  (no existe)" -ForegroundColor Red
                }
                Write-Host ""
                Read-Host "  Enter para continuar" | Out-Null
            }
            '2' {
                try {
                    $stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'
                    $backup = Join-Path (Split-Path $hostsPath) "hosts.backup.$stamp"
                    Copy-Item $hostsPath $backup -Force
                    Write-Host ""
                    Write-Host "  Backup creado: $backup" -ForegroundColor Green
                } catch {
                    Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '3' {
                $ip   = Read-Host "  IP"
                $name = Read-Host "  Nombre host"
                if ($ip -and $name) {
                    try {
                        $line = "{0}`t{1}`t# Atlas-added {2}" -f $ip, $name, (Get-Date -Format 'yyyy-MM-dd')
                        Add-Content -Path $hostsPath -Value "`r`n$line" -Encoding UTF8
                        Write-Host "  Agregada: $ip  $name" -ForegroundColor Green
                    } catch {
                        Write-Host "  Error (necesita admin?): $($_.Exception.Message)" -ForegroundColor Red
                    }
                } else {
                    Write-Host "  Cancelado (IP o nombre vacios)." -ForegroundColor Yellow
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '4' {
                $name = Read-Host "  Nombre a eliminar (lineas que lo contengan)"
                if ($name) {
                    try {
                        $pattern = [regex]::Escape($name)
                        $content = Get-Content $hostsPath
                        $kept    = $content | Where-Object { $_ -notmatch $pattern }
                        $deleted = $content.Count - $kept.Count
                        Set-Content -Path $hostsPath -Value $kept -Encoding UTF8
                        Write-Host "  Eliminadas $deleted linea(s) que contenian '$name'." -ForegroundColor Green
                    } catch {
                        Write-Host "  Error (necesita admin?): $($_.Exception.Message)" -ForegroundColor Red
                    }
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '5' {
                try {
                    Start-Process notepad.exe -ArgumentList $hostsPath -Verb RunAs
                    Write-Host "  Notepad abierto (en nueva ventana elevada)." -ForegroundColor Green
                } catch {
                    Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '6' {
                $ok = Read-Host "  Esto SOBREESCRIBE hosts. Confirmar? [s/N]"
                if ($ok -match '^[sSyY]$') {
                    try {
                        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
                        $before = Join-Path (Split-Path $hostsPath) "hosts.before-reset.$stamp"
                        Copy-Item $hostsPath $before -Force
                        $default = @"
# Copyright (c) 1993-2009 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# Localhost name resolution is handled within DNS itself.
#`t127.0.0.1`tlocalhost
#`t::1`tlocalhost
"@
                        Set-Content -Path $hostsPath -Value $default -Encoding UTF8
                        Write-Host "  hosts restaurado. Backup previo en: $before" -ForegroundColor Green
                    } catch {
                        Write-Host "  Error (necesita admin): $($_.Exception.Message)" -ForegroundColor Red
                    }
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '7' {
                try {
                    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
                    $out = Join-Path ([Environment]::GetFolderPath('Desktop')) "hosts.atlas.$stamp.txt"
                    Copy-Item $hostsPath $out -Force
                    Write-Host ""
                    Write-Host "  Exportado: $out" -ForegroundColor Green
                } catch {
                    Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '8' {
                $src = Read-Host "  Ruta completa del archivo hosts a importar (arrastra al CMD y Enter)"
                $src = $src.Trim('"').Trim("'")
                if (-not (Test-Path $src)) {
                    Write-Host "  Archivo no encontrado." -ForegroundColor Red
                    Read-Host "  Enter para continuar" | Out-Null
                    continue
                }
                $ok = Read-Host "  Esto SOBREESCRIBIRA hosts actual (se hara backup). Confirmar? [s/N]"
                if ($ok -match '^[sSyY]$') {
                    try {
                        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
                        $before = Join-Path (Split-Path $hostsPath) "hosts.before-import.$stamp"
                        Copy-Item $hostsPath $before -Force
                        Copy-Item $src $hostsPath -Force
                        Write-Host "  Importado. Backup previo: $before" -ForegroundColor Green
                    } catch {
                        Write-Host "  Error (necesita admin): $($_.Exception.Message)" -ForegroundColor Red
                    }
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            '9' {
                Write-Host ""
                Write-Host "  === STEVENBLACK HOSTS - Bloqueo ads/tracking ===" -ForegroundColor Yellow
                Write-Host "  Fuente oficial: https://github.com/StevenBlack/hosts" -ForegroundColor DarkGray
                Write-Host ""
                Write-Host "  Lista a aplicar:" -ForegroundColor Cyan
                Write-Host "    [1] unified (ads + malware)" -ForegroundColor White
                Write-Host "    [2] ads + malware + fakenews" -ForegroundColor White
                Write-Host "    [3] ads + malware + fakenews + gambling + social" -ForegroundColor White
                Write-Host "    [0] Cancelar" -ForegroundColor DarkGray
                $lsel = Read-Host "  Seleccion"
                $url = switch ($lsel) {
                    '1' { 'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts' }
                    '2' { 'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts' }
                    '3' { 'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts' }
                    default { $null }
                }
                if (-not $url) {
                    Read-Host "  Cancelado. Enter" | Out-Null
                    continue
                }
                Write-Host ""
                Write-Host "  [!] Se hara backup automatico de tu hosts actual" -ForegroundColor Yellow
                Write-Host "      en la MISMA carpeta (hosts.atlas-pre-stevenblack.<timestamp>)" -ForegroundColor Yellow
                Write-Host "      para que puedas revertir con la opcion [R]." -ForegroundColor Yellow
                Write-Host ""
                $ok = Read-Host "  Continuar y descargar la lista? [s/N]"
                if ($ok -notmatch '^[sSyY]$') { Read-Host "  Cancelado. Enter" | Out-Null; continue }
                try {
                    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
                    $before = Join-Path (Split-Path $hostsPath) "hosts.atlas-pre-stevenblack.$stamp"
                    Copy-Item $hostsPath $before -Force
                    # Preservar copia canonica (para opcion R siempre apunte al ultimo backup pre-SB)
                    $ptrFile = Join-Path $env:LOCALAPPDATA 'AtlasPC\hosts-last-stevenblack-backup.txt'
                    if (-not (Test-Path (Split-Path $ptrFile))) { New-Item -ItemType Directory -Path (Split-Path $ptrFile) -Force | Out-Null }
                    Set-Content -Path $ptrFile -Value $before -Encoding UTF8
                    Write-Host "  Backup listo: $before" -ForegroundColor Green
                    Write-Host "  Descargando lista..." -ForegroundColor Cyan
                    $tmp = Join-Path $env:TEMP "atlas-stevenblack-$stamp.txt"
                    Invoke-WebRequest -Uri $url -OutFile $tmp -UseBasicParsing -TimeoutSec 60
                    if (-not (Test-Path $tmp) -or (Get-Item $tmp).Length -lt 1000) {
                        throw "Descarga vacia o demasiado pequena."
                    }
                    # Anadir marcador + preservar las entradas manuales existentes al principio
                    $userLines = Get-Content $hostsPath
                    $marker = "# === ATLAS StevenBlack applied $stamp ==="
                    $new = @()
                    $new += $userLines
                    $new += ""
                    $new += $marker
                    $new += (Get-Content $tmp)
                    Set-Content -Path $hostsPath -Value $new -Encoding UTF8
                    Remove-Item $tmp -Force -ErrorAction SilentlyContinue
                    # Flush DNS cache
                    try { ipconfig /flushdns | Out-Null } catch {}
                    Write-Host "  [OK] StevenBlack aplicado. DNS cache purgada." -ForegroundColor Green
                } catch {
                    Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
                    Write-Host "  Sugerencia: verifica conexion, permisos admin, o intenta de nuevo." -ForegroundColor Yellow
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            { $_ -match '^[rR]$' } {
                $ptrFile = Join-Path $env:LOCALAPPDATA 'AtlasPC\hosts-last-stevenblack-backup.txt'
                if (-not (Test-Path $ptrFile)) {
                    Write-Host "  No hay backup de StevenBlack registrado." -ForegroundColor Yellow
                    Read-Host "  Enter para continuar" | Out-Null
                    continue
                }
                $backupPath = (Get-Content $ptrFile -Raw).Trim()
                if (-not (Test-Path $backupPath)) {
                    Write-Host "  Backup registrado no existe: $backupPath" -ForegroundColor Red
                    Read-Host "  Enter para continuar" | Out-Null
                    continue
                }
                Write-Host ""
                Write-Host "  Se restaurara: $backupPath" -ForegroundColor Cyan
                $ok = Read-Host "  Confirmar? [s/N]"
                if ($ok -match '^[sSyY]$') {
                    try {
                        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
                        $bumpBefore = Join-Path (Split-Path $hostsPath) "hosts.before-revert-stevenblack.$stamp"
                        Copy-Item $hostsPath $bumpBefore -Force
                        Copy-Item $backupPath $hostsPath -Force
                        try { ipconfig /flushdns | Out-Null } catch {}
                        Write-Host "  [OK] Restaurado. DNS cache purgada." -ForegroundColor Green
                        Write-Host "  (Backup del estado con StevenBlack: $bumpBefore)" -ForegroundColor DarkGray
                    } catch {
                        Write-Host "  Error (necesita admin): $($_.Exception.Message)" -ForegroundColor Red
                    }
                }
                Read-Host "  Enter para continuar" | Out-Null
            }
            { $_ -match '^[qQ]$' } { return }
        }
    } while ($true)
}
