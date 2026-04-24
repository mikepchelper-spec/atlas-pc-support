# ============================================================
# Invoke-StopServices
# Migrado de: Stop+services+-+pendiente.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-StopServices {
    [CmdletBinding()]
    param()
$ServiciosAOptimizar = @(
    "DiagTrack", "dmwappushservice", "WerSvc", "wisvc", "PcaSvc",
    "XblAuthManager", "XblGameSave", "XboxNetApiSvc", "XboxGipSvc",
    "TabletInputService", "SensorService", "SensorDataService", "SensrSvc", "WbioSrvc",
    "MapsBroker", "WalletService", "RetailDemo", "Fax", "RemoteRegistry"
)

foreach ($Servicio in $ServiciosAOptimizar) {
    # Aquí iría la lógica para detenerlos y pasarlos a Manual
}
}
