# ============================================================
# Invoke-PartsUpgrade
# Parts Upgrade Advisor: RAM + CPU + Almacenamiento
# Atlas PC Support — v1.0
# ============================================================

function Invoke-PartsUpgrade {
    [CmdletBinding()]
    param()

    $ErrorActionPreference = 'Continue'
    $Host.UI.RawUI.WindowTitle = 'ATLAS PC SUPPORT - Parts Upgrade Advisor'
    try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(110, 50) } catch {}
    Clear-Host

    $script:ReporteTexto = ''
    $script:HtmlSections = @()

    function Log-Out { param([string]$Msg, [string]$Color='White', [switch]$NoNewLine)
        if ($NoNewLine) { Write-Host $Msg -ForegroundColor $Color -NoNewline }
        else { Write-Host $Msg -ForegroundColor $Color }
        $script:ReporteTexto += $Msg
        if (-not $NoNewLine) { $script:ReporteTexto += "`r`n" }
    }

    function Section-Header { param([string]$Title)
        Log-Out ''
        Log-Out ('=' * 70) 'Cyan'
        Log-Out "  $Title" 'Yellow'
        Log-Out ('=' * 70) 'Cyan'
    }

    # ================================================================
    # INFO GENERAL
    # ================================================================
    Section-Header 'ATLAS PARTS UPGRADE ADVISOR'
    Log-Out ("Fecha: {0}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm')) 'Gray'
    Log-Out ("Equipo: {0}" -f $env:COMPUTERNAME) 'Gray'

    $cs = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
    $csp = Get-CimInstance Win32_ComputerSystemProduct -ErrorAction SilentlyContinue
    $bb = Get-CimInstance Win32_BaseBoard -ErrorAction SilentlyContinue
    $chassis = Get-CimInstance Win32_SystemEnclosure -ErrorAction SilentlyContinue
    $isLaptop = $false
    if ($chassis) { foreach ($ct in $chassis.ChassisTypes) { if ($ct -in @(9,10,14,31,32)) { $isLaptop = $true; break } } }

    if ($cs) { Log-Out ("Fabricante:   {0}" -f $cs.Manufacturer) }
    if ($cs) { Log-Out ("Modelo:       {0}" -f $cs.Model) }
    if ($csp -and $csp.Name) { Log-Out ("Modelo exacto: {0}" -f $csp.Name) }
    if ($bb) { Log-Out ("Placa base:   {0} {1}" -f $bb.Manufacturer, $bb.Product) }
    Log-Out ("Form factor:  {0}" -f $(if ($isLaptop) {'Laptop'} else {'Desktop/Otro'}))

    # ================================================================
    # RAM
    # ================================================================
    Section-Header '1. MEMORIA RAM'

    try {
        $placa = Get-CimInstance Win32_PhysicalMemoryArray -ErrorAction Stop
        $modulos = @(Get-CimInstance Win32_PhysicalMemory -ErrorAction Stop)
    } catch {
        Log-Out '[ERROR] No se pudo consultar la RAM. Ejecuta como administrador.' 'Red'
        $placa = $null; $modulos = @()
    }

    $maxGB = $null
    if ($placa -and $placa.MaxCapacity -gt 0) {
        $maxGB = [math]::Round(($placa.MaxCapacity / 1024 / 1024), 0)
    }
    $slotsTotales = if ($placa) { $placa.MemoryDevices } else { 0 }
    $slotsUsados = $modulos.Count
    $slotsLibres = [Math]::Max(0, [int]$slotsTotales - [int]$slotsUsados)
    $ramTotalGB = if ($modulos) { [math]::Round((($modulos | Measure-Object Capacity -Sum).Sum / 1GB), 2) } else { 0 }

    Log-Out ("Slots totales:  {0}" -f $slotsTotales)
    Log-Out ("Slots ocupados: {0}" -f $slotsUsados)
    Log-Out ("Slots libres:   {0}" -f $slotsLibres)
    Log-Out ("RAM total:      {0} GB" -f $ramTotalGB) 'Green'
    if ($maxGB) { Log-Out ("Maximo segun BIOS: {0} GB" -f $maxGB) 'Green' }

    $ramTypes = @{}
    Log-Out ''
    Log-Out '--- Modulos instalados ---' 'Yellow'
    foreach ($ram in $modulos) {
        $capGB = [math]::Round($ram.Capacity / 1GB, 0)
        $ramTypeCode = [int]$ram.SMBIOSMemoryType
        $ramTypeMap = @{
            20='DDR'; 21='DDR2'; 24='DDR3'; 26='DDR4'; 34='DDR5'
        }
        $ramTypeName = if ($ramTypeMap.ContainsKey($ramTypeCode)) { $ramTypeMap[$ramTypeCode] } else { "Tipo $ramTypeCode" }
        $ramTypes[$ramTypeName] = $true
        $nat = $ram.Speed
        $cfg = $ram.ConfiguredClockSpeed
        $xmpFlag = if ($cfg -lt $nat) { '  [XMP APAGADO]' } else { '' }
        Log-Out ("  [{0}] {1} GB {2} @ {3}/{4} MHz  {5}  PN: {6}{7}" -f `
            $ram.DeviceLocator, $capGB, $ramTypeName, $cfg, $nat, $ram.Manufacturer, $ram.PartNumber, $xmpFlag)
    }

    # Recomendaciones RAM
    Log-Out ''
    Log-Out '--- Recomendaciones RAM ---' 'Magenta'
    $ramTypesList = @($ramTypes.Keys) -join ', '
    if ($slotsLibres -gt 0) {
        Log-Out ("[OK] Tienes {0} slot(s) libre(s). Puedes ampliar." -f $slotsLibres) 'Green'
        Log-Out ("     Compra modulos del MISMO tipo ({0}) y MISMA velocidad ({1} MHz) para modo dual-channel." -f $ramTypesList, ($modulos[0].Speed))
    } else {
        Log-Out '[!] Todos los slots estan ocupados. Para ampliar habra que reemplazar modulos por unos de mayor capacidad.' 'Yellow'
    }
    if ($ramTotalGB -lt 8) {
        Log-Out '[!] RAM total < 8 GB. Recomendado: minimo 8 GB (uso general), 16 GB (productividad), 32 GB+ (gaming/pro).' 'Yellow'
    } elseif ($ramTotalGB -lt 16) {
        Log-Out '[i] 8 GB es aceptable para uso basico, pero 16 GB es lo optimo hoy.' 'White'
    } else {
        Log-Out ("[OK] {0} GB de RAM es suficiente para la mayoria de usos." -f $ramTotalGB) 'Green'
    }
    Log-Out ''
    Log-Out '--- Precauciones al comprar RAM ---' 'Cyan'
    Log-Out '  * Mismo tipo (DDR4 con DDR4, DDR5 con DDR5, nunca mezclar).'
    Log-Out '  * Mismo form factor: DIMM (escritorio) o SO-DIMM (laptop).'
    Log-Out '  * Velocidad IGUAL o SUPERIOR al modulo existente (si pones menor, el CPU la bajara).'
    Log-Out '  * Voltaje IGUAL. Mezclar 1.35V con 1.2V da inestabilidad.'
    Log-Out '  * Marca/latencias parecidas para dual-channel limpio.'
    Log-Out '  * Verifica con CPU-Z la RAM actual antes de comprar.'

    # ================================================================
    # CPU
    # ================================================================
    Section-Header '2. CPU (Procesador)'

    $proc = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $proc) {
        Log-Out '[ERROR] No se pudo consultar el CPU.' 'Red'
    } else {
        $cpuName = if ($proc.Name) { $proc.Name.Trim() } else { 'Desconocido' }
        $cores = $proc.NumberOfCores
        $threads = $proc.NumberOfLogicalProcessors
        $socketName = if ($proc.SocketDesignation) { $proc.SocketDesignation } else { 'No reportado' }
        $upgradeCode = if ($proc.UpgradeMethod) { [int]$proc.UpgradeMethod } else { 2 }

        $upgradeMethodNames = @{
            1='Otro'; 2='Desconocido'; 3='Daughter Board'; 4='ZIF Socket'; 5='Reemplazable'
            6='Ninguno (BGA/Soldado)'; 7='LIF Socket'; 8='Slot 1'; 9='Slot 2'
            10='370-pin'; 11='Slot A'; 12='Slot M'; 13='Socket 423'; 14='Socket A (462)'
            15='Socket 478'; 16='Socket 754'; 17='Socket 940'; 18='Socket 939'
            19='mPGA604'; 20='LGA771'; 21='LGA775'; 22='S1'; 23='AM2'; 24='F (1207)'
            25='LGA1366'; 26='G34'; 27='AM3'; 28='C32'; 29='LGA1156'; 30='LGA1567'
            31='PGA988A'; 32='BGA1288'; 33='rPGA988B'; 34='BGA1023'; 35='BGA1224'
            36='LGA1155'; 37='LGA1356'; 38='LGA2011'; 39='FS1'; 40='FS2'; 41='FM1'
            42='FM2'; 43='LGA2011-3'; 44='LGA1356-3'; 45='LGA1150'; 46='BGA1168'
            47='BGA1234'; 48='BGA1364'; 49='AM4'; 50='LGA1151'; 51='BGA1356'
            52='BGA1440'; 53='BGA1515'; 54='LGA3647-1'; 55='SP3'; 56='SP3r2'
            57='LGA2066'; 58='BGA1392'; 59='BGA1510'; 60='BGA1528'; 61='LGA4189'
            62='LGA1200'; 63='LGA4677'; 64='LGA1700'; 65='BGA1744'; 66='BGA1781'
            67='BGA1211'; 68='BGA2422'; 69='LGA1211'; 70='LGA2085'; 71='LGA4710'
        }
        $upgradeMethodName = if ($upgradeMethodNames.ContainsKey($upgradeCode)) { $upgradeMethodNames[$upgradeCode] } else { "Codigo $upgradeCode" }

        # Generacion
        $gen = 0; $genLabel = ''
        if ($cpuName -match 'i[3579]-(\d{1,2})(\d{2,3})') { $gen = [int]$matches[1]; $genLabel = "Intel Gen $gen" }
        elseif ($cpuName -match 'Core\s*Ultra') { $gen = 14; $genLabel = 'Intel Core Ultra (Gen 14+)' }
        elseif ($cpuName -match 'Ryzen\s+[3579]\s+(\d)(\d{2,4})') { $gen = [int]$matches[1]; $genLabel = "AMD Ryzen Gen $gen" }
        elseif ($cpuName -match 'Athlon|A[46]-|A[46]\s|E[12]-|FX-') { $gen = 1; $genLabel = 'AMD Legacy' }

        Log-Out ("Procesador: {0}" -f $cpuName) 'Green'
        Log-Out ("Nucleos/Hilos: {0}C / {1}T" -f $cores, $threads)
        Log-Out ("Socket reportado: {0}" -f $socketName)
        Log-Out ("Upgrade method: {0}" -f $upgradeMethodName)
        if ($genLabel) { Log-Out ("Generacion: {0}" -f $genLabel) }

        # Deteccion BGA/soldado
        $bgaSignals = 0; $bgaReasons = @()
        if ($upgradeCode -eq 6) { $bgaSignals += 3; $bgaReasons += 'UpgradeMethod = None/BGA' }
        elseif ($upgradeMethodName -match 'BGA') { $bgaSignals += 3; $bgaReasons += "Socket BGA ($upgradeMethodName)" }
        if ($socketName -match 'BGA') { $bgaSignals += 2; $bgaReasons += 'Socket designado BGA' }
        if ($cpuName -match '[-\s](\d{4,5})[UYHPG]\b') { $bgaSignals += 1; $bgaReasons += 'Sufijo mobile (U/Y/H/P/G)' }
        if ($isLaptop -and $bgaSignals -ge 1) { $bgaSignals += 1; $bgaReasons += 'Equipo laptop' }

        Log-Out ''
        Log-Out '--- Reemplazable? ---' 'Magenta'
        if ($bgaSignals -ge 3) {
            Log-Out '[X] CPU SOLDADO A LA PLACA (BGA). NO es reemplazable.' 'Red'
            Log-Out '    Actualizacion: imposible salvo reemplazo completo de placa base (y con eso, el PC entero).'
        } elseif ($bgaSignals -ge 1) {
            Log-Out '[?] CPU PROBABLEMENTE SOLDADO. Verifica con el fabricante antes de comprar nada.' 'Yellow'
        } else {
            Log-Out ("[OK] CPU en SOCKET ({0}) - Reemplazable." -f $socketName) 'Green'
            Log-Out '    Puedes cambiarlo por otro CPU compatible con este socket y chipset.'
        }
        if ($bgaReasons.Count -gt 0) { Log-Out ("    Senales detectadas: {0}" -f ($bgaReasons -join ' | ')) 'DarkGray' }

        # Recomendaciones CPU
        Log-Out ''
        Log-Out '--- Recomendaciones CPU ---' 'Magenta'
        if ($bgaSignals -ge 3) {
            Log-Out '  No hay upgrade posible. Si quieres mas rendimiento, considera un equipo nuevo o SSD+RAM para extender vida util.'
        } else {
            Log-Out ("  1) Anota el socket: {0}" -f $socketName)
            Log-Out "  2) Busca el modelo exacto de la placa base (arriba) y descarga su 'CPU Support List' oficial."
            Log-Out '  3) Revisa requisito de BIOS: muchos chipsets Intel/AMD requieren actualizar BIOS antes de poner CPU mas nuevo.'
            Log-Out '  4) Compara TDP: un CPU con TDP superior al del disipador actual podra pero termicamente castigado. Cambia disipador si subes de 65W a 95W+.'
            Log-Out '  5) Verifica generacion compatible: no todos los sockets admiten todas las gens (ej: LGA1200 admite 10th/11th gen solo).'
        }
        Log-Out ''
        Log-Out '--- Precauciones al comprar CPU ---' 'Cyan'
        Log-Out '  * Socket y chipset compatibles (no solo el socket fisico).'
        Log-Out '  * BIOS actualizada a version que soporte el CPU objetivo.'
        Log-Out '  * TDP compatible con el disipador/fuente. Si subes TDP, cambia pasta termica minimo.'
        Log-Out '  * En laptops: casi SIEMPRE soldado. Ahorrate tiempo, no hay upgrade.'
        Log-Out '  * Si el CPU viene sin fan (tipo "tray" o "OEM"), compra uno aparte.'
    }

    # ================================================================
    # ALMACENAMIENTO
    # ================================================================
    Section-Header '3. ALMACENAMIENTO (Discos y slots)'

    $physDisks = @(Get-PhysicalDisk -ErrorAction SilentlyContinue)
    $nvmeCount = 0; $sataSsdCount = 0; $hddCount = 0; $usbCount = 0

    if ($physDisks.Count -eq 0) {
        Log-Out '[ERROR] No se pudieron enumerar discos.' 'Red'
    } else {
        Log-Out '--- Discos instalados ---' 'Yellow'
        foreach ($pd in $physDisks) {
            $name = if ($pd.FriendlyName) { $pd.FriendlyName } else { 'Disco' }
            $bus = if ($pd.BusType) { $pd.BusType.ToString() } else { '?' }
            $media = if ($pd.MediaType) { $pd.MediaType.ToString() } else { '?' }
            $sizeGB = if ($pd.Size) { [math]::Round($pd.Size / 1GB, 0) } else { 0 }
            $health = if ($pd.HealthStatus) { $pd.HealthStatus.ToString() } else { '?' }

            $kind = 'Otro'
            if ($bus -match 'NVMe') { $kind = 'NVMe (M.2)'; $nvmeCount++ }
            elseif ($bus -match 'USB') { $kind = 'USB externo'; $usbCount++ }
            elseif ($media -match 'HDD') { $kind = 'HDD mecanico'; $hddCount++ }
            elseif ($media -match 'SSD' -and $bus -match 'SATA|ATA') { $kind = 'SSD SATA'; $sataSsdCount++ }
            elseif ($bus -match 'SATA|ATA') {
                if ($sizeGB -lt 300) { $kind = 'SSD SATA (inferido)'; $sataSsdCount++ }
                else { $kind = 'HDD (inferido)'; $hddCount++ }
            }

            Log-Out ("  {0}  [{1}]  bus={2}  media={3}  tam={4} GB  salud={5}" -f $kind, $name, $bus, $media, $sizeGB, $health)
        }
    }

    Log-Out ''
    Log-Out '--- Resumen almacenamiento ---' 'Yellow'
    Log-Out ("  NVMe (M.2):    {0}" -f $nvmeCount)
    Log-Out ("  SSD SATA:      {0}" -f $sataSsdCount)
    Log-Out ("  HDD mecanico:  {0}" -f $hddCount)
    Log-Out ("  USB externo:   {0}" -f $usbCount)

    # Slots disponibles - inferencia
    Log-Out ''
    Log-Out '--- Slots fisicos disponibles (inferencia) ---' 'Magenta'
    Log-Out 'Windows NO expone directamente "slots M.2 libres". Se infiere del modelo de placa base.'
    if ($bb) {
        Log-Out ("Placa base detectada: {0} {1}" -f $bb.Manufacturer, $bb.Product) 'Cyan'
        Log-Out 'Para saber slots reales:'
        $searchQuery = [uri]::EscapeDataString(("{0} {1} specifications M.2 SATA slots" -f $bb.Manufacturer, $bb.Product))
        Log-Out ("  1) Busca en Google: {0} specifications M.2 SATA slots" -f "$($bb.Manufacturer) $($bb.Product)")
        Log-Out ("  2) URL directa: https://www.google.com/search?q={0}" -f $searchQuery)
    } else {
        Log-Out 'No se pudo detectar modelo de placa base. Consulta etiqueta fisica o CPU-Z -> Mainboard.'
    }
    Log-Out ''
    if ($isLaptop) {
        Log-Out 'En laptops tipicos:'
        Log-Out '  - 1 slot M.2 NVMe (a veces 2 en gaming).'
        Log-Out '  - A veces 1 bahia 2.5" SATA (cada vez menos comun).'
        Log-Out '  - Rara vez se puede anadir disco sin desmontar.'
    } else {
        Log-Out 'En desktop tipico (ATX mid-range):'
        Log-Out '  - 1-3 slots M.2 (uno suele ser PCIe 4.0 o superior, otros PCIe 3.0).'
        Log-Out '  - 2-6 puertos SATA (para SSD 2.5" o HDD 3.5").'
        Log-Out '  - Verifica M.2: algunos slots son M.2 SATA, otros M.2 NVMe, otros ambos ("combo").'
    }

    # Recomendaciones storage
    Log-Out ''
    Log-Out '--- Recomendaciones almacenamiento ---' 'Magenta'
    if ($hddCount -gt 0 -and $nvmeCount -eq 0 -and $sataSsdCount -eq 0) {
        Log-Out '[!!] El SISTEMA arranca de HDD. Migrar a SSD da 5-10x mejora percibida. Prioridad MAXIMA.' 'Red'
    } elseif ($hddCount -gt 0) {
        Log-Out '[i] Tienes HDD presente. Util para datos/backup. Sistema deberia estar en SSD (ya parece serlo).'
    }
    if ($nvmeCount -eq 0 -and -not $isLaptop) {
        Log-Out '[i] Sin NVMe. Considera migrar a M.2 NVMe para lectura secuencial >3 GB/s (SATA SSD tope es 550 MB/s).'
    }
    Log-Out ''
    Log-Out '--- Precauciones al comprar almacenamiento ---' 'Cyan'
    Log-Out '  * M.2 NVMe vs M.2 SATA: NO son intercambiables. Verifica cual admite tu slot.'
    Log-Out '  * PCIe 4.0 vs 3.0: un SSD PCIe 4.0 funciona en slot PCIe 3.0 pero limitado a la velocidad del slot.'
    Log-Out '  * Tamano M.2: 2280 es el estandar (80 mm). 2230/2242 existen en laptops ultraslim.'
    Log-Out '  * DRAM cache: SSDs sin DRAM (QLC low-end) se degradan rapido con cargas sostenidas.'
    Log-Out '  * TBW (terabytes writes): revisa endurance antes de comprar para servidor/editor de video.'
    Log-Out '  * Compra SSD >= 500 GB (el coste GB es casi igual y rendimiento mejora).'
    Log-Out '  * Clona con herramienta del fabricante (Samsung Magician, Crucial Storage Executive, etc) o Macrium Reflect.'

    # ================================================================
    # OTROS COMPONENTES (complementos)
    # ================================================================
    Section-Header '4. OTROS COMPONENTES'

    # GPU
    $gpus = @(Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue | Where-Object { $_.Name -notmatch 'Microsoft Basic|Remote' })
    if ($gpus.Count -gt 0) {
        Log-Out '--- GPU ---' 'Yellow'
        foreach ($g in $gpus) {
            $vram = if ($g.AdapterRAM -gt 0) { [math]::Round($g.AdapterRAM / 1MB, 0) } else { 0 }
            Log-Out ("  {0} ({1} MB VRAM reportado)" -f $g.Name, $vram)
        }
        if ($isLaptop) {
            Log-Out '  [i] GPU en laptops NO es upgradeable (soldada al mainboard o en MXM raro).' 'Yellow'
        } else {
            Log-Out '  [i] GPU en desktop: upgradeable si tienes PCIe libre y fuente suficiente (W).' 'Green'
            Log-Out '  [!] Al comprar GPU verifica: conector (8/6/12VHPWR), largo fisico (caja), TDP vs fuente, slot PCIe.' 'Cyan'
        }
    }

    # PSU - limitado en info
    Log-Out ''
    Log-Out '--- Fuente de poder (PSU) ---' 'Yellow'
    Log-Out '  Windows NO expone la marca/wattage de la PSU. Revisa la etiqueta fisica dentro de la caja.'
    Log-Out '  Para upgrade de GPU o CPU potente: verifica que la fuente sea 80+ Bronze o superior y con wattage suficiente.'

    # BIOS
    Log-Out ''
    Log-Out '--- BIOS / UEFI ---' 'Yellow'
    try {
        $bios = Get-CimInstance Win32_BIOS -ErrorAction Stop
        Log-Out ("  Version:  {0}" -f $bios.SMBIOSBIOSVersion)
        $biosDate = $null
        if ($bios.ReleaseDate) {
            try { $biosDate = [Management.ManagementDateTimeConverter]::ToDateTime($bios.ReleaseDate) } catch {}
        }
        if ($biosDate) {
            $ageYears = [math]::Round(((Get-Date) - $biosDate).TotalDays / 365.25, 1)
            Log-Out ("  Fecha:    {0} (hace {1} anios)" -f $biosDate.ToString('yyyy-MM-dd'), $ageYears)
            if ($ageYears -gt 3) {
                Log-Out '  [!] BIOS antigua. Actualizarla puede habilitar CPUs nuevos y corregir bugs. Revisa la web del fabricante.' 'Yellow'
            }
        }
    } catch {
        Log-Out '  No se pudo leer BIOS.' 'Red'
    }

    # ================================================================
    # EXPORT
    # ================================================================
    Section-Header 'EXPORTAR REPORTE'
    Log-Out ' [1] Guardar TXT en Escritorio'
    Log-Out ' [2] Guardar HTML en Escritorio'
    Log-Out ' [3] Salir sin guardar'
    Log-Out ''
    $opc = Read-Host ' Elige opcion'
    $base = "PartsUpgrade_$(Get-Date -Format 'yyyyMMdd_HHmm')"
    $desk = [Environment]::GetFolderPath('Desktop')
    switch ($opc) {
        '1' {
            $p = Join-Path $desk "$base.txt"
            [System.IO.File]::WriteAllText($p, $script:ReporteTexto, [System.Text.UTF8Encoding]::new($true))
            Log-Out ''
            Log-Out ("[OK] TXT guardado: {0}" -f $p) 'Green'
            try { Start-Process notepad.exe $p } catch {}
        }
        '2' {
            $p = Join-Path $desk "$base.html"
            $style = @'
<style>
body{font-family:Segoe UI,sans-serif;background:#1e1e1e;color:#e0e0e0;padding:20px}
h1{color:#0078D7;border-bottom:2px solid #0078D7;padding-bottom:5px}
h2{color:#00A8FF;margin-top:25px}
pre{background:#2d2d2d;border:1px solid #444;padding:15px;border-radius:5px;font-size:13px;white-space:pre-wrap}
.foot{color:#888;text-align:center;margin-top:30px;font-size:11px}
</style>
'@
            $escaped = [System.Web.HttpUtility]::HtmlEncode($script:ReporteTexto)
            if (-not $escaped) {
                $escaped = $script:ReporteTexto -replace '&','&amp;' -replace '<','&lt;' -replace '>','&gt;'
            }
            $html = "<html><head><meta charset='UTF-8'><title>Parts Upgrade - $env:COMPUTERNAME</title>$style</head><body><h1>Atlas PC Support - Parts Upgrade Advisor</h1><pre>$escaped</pre><div class='foot'>Generado $(Get-Date)</div></body></html>"
            [System.IO.File]::WriteAllText($p, $html, [System.Text.UTF8Encoding]::new($true))
            Log-Out ''
            Log-Out ("[OK] HTML guardado: {0}" -f $p) 'Green'
            try { Start-Process $p } catch {}
        }
        default { Log-Out 'Saliendo sin guardar.' 'DarkGray' }
    }
}
