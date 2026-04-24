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
            { $_ -match '^[qQ]$' } { return }
        }
    } while ($true)
}
