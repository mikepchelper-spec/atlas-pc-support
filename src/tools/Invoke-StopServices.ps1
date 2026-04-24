# ============================================================
# Invoke-StopServices
# Optimiza Windows detenindo servicios opcionales (reversible).
# Atlas PC Support - v1.0
# ============================================================

function Invoke-StopServices {
    [CmdletBinding()]
    param()

    try { $Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - STOP SERVICES" } catch {}
    Clear-Host

    Write-Host ""
    Write-Host "  =================================================" -ForegroundColor DarkGray
    Write-Host "   ATLAS PC SUPPORT - OPTIMIZACION DE SERVICIOS" -ForegroundColor Yellow
    Write-Host "  =================================================" -ForegroundColor DarkGray
    Write-Host ""

    $serviciosAOptimizar = @(
        @{ Name = "DiagTrack";           Desc = "Telemetria (Connected User Experiences)" },
        @{ Name = "dmwappushservice";    Desc = "WAP Push Message Routing" },
        @{ Name = "WerSvc";              Desc = "Reporte de errores de Windows" },
        @{ Name = "wisvc";               Desc = "Windows Insider" },
        @{ Name = "PcaSvc";              Desc = "Asistente de compatibilidad de programas" },
        @{ Name = "XblAuthManager";      Desc = "Xbox Live Auth" },
        @{ Name = "XblGameSave";         Desc = "Xbox Live Game Save" },
        @{ Name = "XboxNetApiSvc";       Desc = "Xbox Live Networking" },
        @{ Name = "XboxGipSvc";          Desc = "Xbox Game Input Protocol" },
        @{ Name = "TabletInputService";  Desc = "Entrada tactil / lapiz" },
        @{ Name = "SensorService";       Desc = "Servicio de sensores" },
        @{ Name = "SensorDataService";   Desc = "Datos de sensores" },
        @{ Name = "SensrSvc";            Desc = "Supervision de sensores" },
        @{ Name = "WbioSrvc";            Desc = "Biometria (huellas / Hello)" },
        @{ Name = "MapsBroker";          Desc = "Mapas descargados" },
        @{ Name = "WalletService";       Desc = "Servicio de cartera" },
        @{ Name = "RetailDemo";          Desc = "Modo demo de tienda" },
        @{ Name = "Fax";                 Desc = "Fax" },
        @{ Name = "RemoteRegistry";      Desc = "Registro remoto" }
    )

    Write-Host "  Analizando servicios candidatos..." -ForegroundColor Gray
    Write-Host ""

    $report = @()
    foreach ($s in $serviciosAOptimizar) {
        $svc = Get-Service -Name $s.Name -ErrorAction SilentlyContinue
        if ($svc) {
            $flag  = if ($svc.Status -eq 'Running') { 'R' } else { '-' }
            $color = if ($svc.Status -eq 'Running') { 'Green' } else { 'DarkGray' }
            $line = "  [{0}]  {1,-22} {2,-10} {3}" -f $flag, $s.Name, $svc.Status, $s.Desc
            Write-Host $line -ForegroundColor $color
            $report += [pscustomobject]@{ Service = $s.Name; Desc = $s.Desc; Status = $svc.Status }
        } else {
            Write-Host ("  [!]  {0,-22} NOT-FOUND  {1}" -f $s.Name, $s.Desc) -ForegroundColor DarkGray
        }
    }

    $running = @($report | Where-Object { $_.Status -eq 'Running' })

    Write-Host ""
    Write-Host "  Servicios en ejecucion: $($running.Count) de $($report.Count)" -ForegroundColor Cyan

    if ($running.Count -eq 0) {
        Write-Host "  No hay nada que detener. Ya esta optimizado." -ForegroundColor Green
        return
    }

    Write-Host ""
    Write-Host "  Opciones:" -ForegroundColor Yellow
    Write-Host "    [D] Detener Y marcar como Manual (reversible via services.msc)"
    Write-Host "    [A] Abortar sin cambios"
    Write-Host ""
    $sel = Read-Host "  Seleccion"

    if ($sel -notmatch '^[Dd]$') {
        Write-Host "  Abortado." -ForegroundColor Gray
        return
    }

    $principal = [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host ""
        Write-Host "  ADMIN requerido. Relanza desde el panel Atlas con la tool marcada admin." -ForegroundColor Red
        return
    }

    Write-Host ""
    foreach ($r in $running) {
        try {
            Stop-Service -Name $r.Service -Force -ErrorAction Stop
            Set-Service  -Name $r.Service -StartupType Manual -ErrorAction Stop
            Write-Host ("  [OK]   {0,-22} detenido y Manual" -f $r.Service) -ForegroundColor Green
        } catch {
            Write-Host ("  [ERR]  {0,-22} {1}" -f $r.Service, $_.Exception.Message) -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "  Optimizacion aplicada. Para revertir: services.msc -> Automatico." -ForegroundColor Cyan
}
