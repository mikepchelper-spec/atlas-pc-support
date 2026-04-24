# ============================================================
# Invoke-RAMInfo
# Migrado de: RAM1.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-RAMInfo {
    [CmdletBinding()]
    param()
# ==========================================================
# DIAGNOSTICO DE MEMORIA RAM AVANZADO - ATLAS PC SUPPORT
# ==========================================================

# Variable para acumular el reporte en texto plano
$ReporteTexto = ""

# Funcion auxiliar para escribir en pantalla Y guardar en memoria
function Log-Out {
    param (
        [string]$Mensaje,
        [string]$Color = "White",
        [switch]$NoNewLine
    )
    
    # 1. Escribir en consola con color
    if ($NoNewLine) {
        Write-Host $Mensaje -ForegroundColor $Color -NoNewline
    } else {
        Write-Host $Mensaje -ForegroundColor $Color
    }

    # 2. Guardar en variable para el reporte TXT
    $script:ReporteTexto += $Mensaje
    if (-not $NoNewLine) { $script:ReporteTexto += "`r`n" }
}

Clear-Host
Log-Out "==================================" "Cyan"
Log-Out " REPORTE DE HARDWARE DE MEMORIA RAM" "Cyan"
Log-Out " Fecha: $(Get-Date -Format 'yyyy-MM-dd HH:mm')" "Gray"
Log-Out "==================================" "Cyan"

# --- OBTENCION DE DATOS ---
try {
    $placa = Get-CimInstance Win32_PhysicalMemoryArray -ErrorAction Stop
    $modulos = Get-CimInstance Win32_PhysicalMemory -ErrorAction Stop
} catch {
    Log-Out "[ERROR] No se pudo acceder al hardware. Ejecuta como Administrador." "Red"
    Pause
    return
}

# --- SECCION A: RESUMEN DE LA PLACA ---
Log-Out "`n[A] CAPACIDAD DE LA PLACA BASE" "Yellow"

if ($placa.MaxCapacity -gt 0) {
    # Calculo seguro compatible con PS 5.1
    $maxGB = [math]::Round(($placa.MaxCapacity / 1024 / 1024), 0)
} else {
    $maxGB = "Desconocido (BIOS Legacy)"
}

$slotsUsados = $modulos.Count
$slotsTotales = $placa.MemoryDevices

Log-Out "Slots Totales:      $slotsTotales"
Log-Out "Slots Ocupados:     $slotsUsados"
Log-Out "Maximo Soportado:   $maxGB GB" "Green"

# --- SECCION B: DETALLE POR MODULO ---
Log-Out "`n[B] DETALLE TECNICO POR MODULO" "Yellow"

# Array para guardar objetos (HTML)
$DatosHTML = @()

foreach ($ram in $modulos) {
    $voltaje = $ram.ConfiguredVoltage / 1000
    
    # Logica de velocidad corregida para PS 5.1
    $estadoVelocidad = "Optimo"
    if ($ram.ConfiguredClockSpeed -lt $ram.Speed) {
        $estadoVelocidad = "BAJA VELOCIDAD (XMP Apagado?)"
    }

    Log-Out "-----------------------------------"
    Log-Out "Ubicacion:        $($ram.DeviceLocator)" "Cyan"
    Log-Out "Fabricante:       $($ram.Manufacturer)"
    Log-Out "Capacidad:        $([math]::Round($ram.Capacity / 1GB, 0)) GB"
    Log-Out "Part Number:      $($ram.PartNumber)"
    Log-Out "Velocidad:        $($ram.ConfiguredClockSpeed) MHz (Nativo: $($ram.Speed) MHz)"
    
    # CORRECCION AQUI: Usamos IF clasico en lugar de ?
    if ($estadoVelocidad -eq "Optimo") {
        Log-Out "Estado Vel.:      $estadoVelocidad" "Green"
    } else {
        Log-Out "Estado Vel.:      $estadoVelocidad" "Red"
    }

    Log-Out "Voltaje:          $voltaje V"
    
    # Guardar objeto para HTML
    $ObjTemp = New-Object PSObject -Property @{
        Ubicacion   = $ram.DeviceLocator
        Fabricante  = $ram.Manufacturer
        Capacidad   = "$([math]::Round($ram.Capacity / 1GB, 0)) GB"
        Velocidad   = "$($ram.ConfiguredClockSpeed) MHz"
        Voltaje     = "$voltaje V"
        PartNumber  = $ram.PartNumber
    }
    $DatosHTML += $ObjTemp
}

Log-Out "`n=================================="

# --- MENU DE EXPORTACION ---
Write-Host "`nQue deseas hacer con este reporte?" -ForegroundColor Yellow
Write-Host " [1] Guardar en TXT (Bloc de notas)"
Write-Host " [2] Guardar en HTML (Navegador - Recomendado)"
Write-Host " [3] Salir"

$opcion = Read-Host "`n Elige una opcion"

$NombreBase = "ReporteRAM_$(Get-Date -Format 'yyyyMMdd_HHmm')"
$RutaEscritorio = [Environment]::GetFolderPath("Desktop")

switch ($opcion) {
    "1" { 
        $RutaFinal = "$RutaEscritorio\$NombreBase.txt"
        $ReporteTexto | Out-File -FilePath $RutaFinal -Encoding UTF8
        Write-Host "`n[OK] Reporte guardado en el Escritorio: $NombreBase.txt" -ForegroundColor Green
    }
    "2" { 
        $RutaFinal = "$RutaEscritorio\$NombreBase.html"
        
        # Generar HTML simple
        $Estilo = "<style>body{font-family:Segoe UI, sans-serif; background:#f0f0f0; padding:20px} h2{color:#0078D7} table{border-collapse:collapse; width:100%; background:white} th, td{border:1px solid #ddd; padding:8px; text-align:left} th{background-color:#0078D7; color:white} .info{background:#fff; padding:15px; border-radius:5px; margin-bottom:20px}</style>"
        $Encabezado = "<h2>Reporte ATLAS PC SUPPORT - Memoria RAM</h2><div class='info'><p><b>Fecha:</b> $(Get-Date)</p><p><b>Maximo Soportado:</b> $maxGB GB</p></div>"
        
        # ConvertTo-Html compatible con PS 5.1
        $CuerpoTabla = $DatosHTML | Select-Object Ubicacion, Fabricante, Capacidad, Velocidad, Voltaje, PartNumber | ConvertTo-Html -Fragment
        $HTMLFinal = "<html><head><title>Reporte RAM</title>$Estilo</head><body>$Encabezado $CuerpoTabla</body></html>"
        
        $HTMLFinal | Out-File -FilePath $RutaFinal -Encoding UTF8
        Write-Host "`n[OK] Reporte HTML generado en el Escritorio." -ForegroundColor Green
        Start-Process $RutaFinal
    }
    Default { Write-Host "Saliendo..." }
}
}
