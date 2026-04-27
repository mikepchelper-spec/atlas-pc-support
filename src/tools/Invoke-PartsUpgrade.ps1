# ============================================================
# Invoke-PartsUpgrade  ->  Parts Upgrade Advisor
#
# i18n: Option A (en default + full es secondary). Function name
# kept as Invoke-PartsUpgrade for tools.json compatibility.
#
# Atlas PC Support
# ============================================================

function Invoke-PartsUpgrade {
    [CmdletBinding()]
    param()

    # --- Language detection ---
    function _Atlas-DetectLang {
        if ($env:ATLAS_LANG) { return [string]$env:ATLAS_LANG }
        try {
            $cfg = Join-Path $env:LOCALAPPDATA 'AtlasPC\config.json'
            if (Test-Path -LiteralPath $cfg) {
                $obj = Get-Content -Raw -LiteralPath $cfg -Encoding UTF8 | ConvertFrom-Json
                if ($obj.language) { return [string]$obj.language }
            }
        } catch {}
        $sys = (Get-Culture).TwoLetterISOLanguageName
        if ($sys -eq 'es') { return 'es' }
        return 'en'
    }

    $T = @{
        en = @{
            WinTitle      = 'ATLAS PC SUPPORT - Parts Upgrade Advisor'
            HeaderMain    = 'ATLAS PARTS UPGRADE ADVISOR'
            DateLbl       = 'Date: {0}'
            CompLbl       = 'Computer: {0}'
            Vendor        = 'Manufacturer: {0}'
            Model         = 'Model:        {0}'
            ModelExact    = 'Exact model:  {0}'
            Mainboard     = 'Mainboard:    {0} {1}'
            FormFactor    = 'Form factor:  {0}'
            FFLaptop      = 'Laptop'
            FFDesktop     = 'Desktop/Other'
            SecRAM        = '1. RAM MEMORY'
            RAMErr        = '[ERROR] Could not query RAM. Run as administrator.'
            SlotsTotal    = 'Total slots:    {0}'
            SlotsUsed     = 'Used slots:     {0}'
            SlotsFree     = 'Free slots:     {0}'
            RAMTotal      = 'Total RAM:      {0} GB'
            BiosMaxRAM    = 'BIOS max:       {0} GB'
            ModulesHdr    = '--- Installed modules ---'
            XmpOff        = '  [XMP OFF]'
            ModuleLine    = '  [{0}] {1} GB {2} @ {3}/{4} MHz  {5}  PN: {6}{7}'
            RAMRecHdr     = '--- RAM recommendations ---'
            RAMSlotsFree  = '[OK] You have {0} free slot(s). You can expand.'
            RAMBuyMatch   = '     Buy modules of the SAME type ({0}) and SAME speed ({1} MHz) for dual-channel mode.'
            RAMNoSlots    = '[!] All slots are populated. To expand, replace modules with higher-capacity ones.'
            RAMLow        = '[!] Total RAM < 8 GB. Recommended: 8 GB min (general use), 16 GB (productivity), 32 GB+ (gaming/pro).'
            RAMMid        = '[i] 8 GB is acceptable for basic use, but 16 GB is the sweet spot today.'
            RAMOK         = '[OK] {0} GB is enough for most use cases.'
            RAMCautionsHdr= '--- RAM buying precautions ---'
            RAMCau1       = '  * Same type (DDR4 with DDR4, DDR5 with DDR5, never mix).'
            RAMCau2       = '  * Same form factor: DIMM (desktop) or SO-DIMM (laptop).'
            RAMCau3       = '  * Speed EQUAL or HIGHER than existing module (lower will be downclocked).'
            RAMCau4       = '  * Voltage EQUAL. Mixing 1.35V with 1.2V is unstable.'
            RAMCau5       = '  * Similar brand/latencies for clean dual-channel.'
            RAMCau6       = '  * Verify current RAM with CPU-Z before buying.'
            SecCPU        = '2. CPU (Processor)'
            CPUErr        = '[ERROR] Could not query CPU.'
            CPULine       = 'Processor: {0}'
            CoresThreads  = 'Cores/Threads: {0}C / {1}T'
            SocketRep     = 'Reported socket: {0}'
            UpgradeMethod = 'Upgrade method: {0}'
            Generation    = 'Generation: {0}'
            ReplaceableHdr= '--- Replaceable? ---'
            CPUSoldered   = '[X] CPU SOLDERED TO BOARD (BGA). NOT replaceable.'
            CPUSolderedNote='    Upgrade: impossible without replacing the entire mainboard (and at that point, the entire PC).'
            CPUMaybeSold  = '[?] CPU PROBABLY SOLDERED. Verify with manufacturer before buying anything.'
            CPUInSocket   = '[OK] CPU in SOCKET ({0}) - Replaceable.'
            CPUSocketNote = '    You can swap it for another CPU compatible with this socket and chipset.'
            SignalsLine   = '    Signals detected: {0}'
            CPURecHdr     = '--- CPU recommendations ---'
            CPURecSold    = '  No upgrade possible. For more performance, consider a new PC or SSD+RAM to extend life.'
            CPURec1       = '  1) Note the socket: {0}'
            CPURec2       = "  2) Find the exact mainboard model (above) and download its official 'CPU Support List'."
            CPURec3       = '  3) Check BIOS requirement: many Intel/AMD chipsets require BIOS update before installing newer CPU.'
            CPURec4       = '  4) Compare TDP: a CPU with TDP higher than current cooler is fine but thermally punished. Replace cooler if going from 65W to 95W+.'
            CPURec5       = '  5) Check supported generation: not every socket supports every gen (e.g. LGA1200 supports 10th/11th gen only).'
            CPUCauHdr     = '--- CPU buying precautions ---'
            CPUCau1       = '  * Socket and chipset compatible (not just the physical socket).'
            CPUCau2       = '  * BIOS updated to a version that supports the target CPU.'
            CPUCau3       = '  * TDP compatible with cooler/PSU. If raising TDP, change thermal paste minimum.'
            CPUCau4       = '  * In laptops: almost ALWAYS soldered. Save your time, no upgrade.'
            CPUCau5       = '  * If the CPU comes without a fan ("tray" or "OEM"), buy one separately.'
            SecStorage    = '3. STORAGE (Disks and slots)'
            DisksErr      = '[ERROR] Could not enumerate disks.'
            DisksHdr      = '--- Installed disks ---'
            KindNVMe      = 'NVMe (M.2)'
            KindUSB       = 'USB external'
            KindHDD       = 'Mechanical HDD'
            KindSSDSATA   = 'SATA SSD'
            KindSSDSATAi  = 'SATA SSD (inferred)'
            KindHDDi      = 'HDD (inferred)'
            DiskLine      = '  {0}  [{1}]  bus={2}  media={3}  size={4} GB  health={5}'
            StorageSummary= '--- Storage summary ---'
            SumNVMe       = '  NVMe (M.2):    {0}'
            SumSATA       = '  SSD SATA:      {0}'
            SumHDD        = '  HDD mechanical:{0}'
            SumUSB        = '  USB external:  {0}'
            SlotsHdr      = '--- Available physical slots (inferred) ---'
            SlotsNote     = 'Windows does NOT directly expose "free M.2 slots". Inferred from mainboard model.'
            DetectedBoard = 'Mainboard detected: {0} {1}'
            ToFindSlots   = 'To find real slot count:'
            GoogleSearch  = '  1) Google: {0} specifications M.2 SATA slots'
            DirectURL     = '  2) Direct URL: https://www.google.com/search?q={0}'
            NoBoard       = 'Could not detect mainboard model. Check physical label or CPU-Z -> Mainboard.'
            LaptopTyp     = 'In typical laptops:'
            LaptopTyp1    = '  - 1 M.2 NVMe slot (sometimes 2 in gaming).'
            LaptopTyp2    = '  - Sometimes 1 2.5" SATA bay (rarer every year).'
            LaptopTyp3    = '  - Rarely possible to add a disk without disassembly.'
            DesktopTyp    = 'In typical desktop (ATX mid-range):'
            DesktopTyp1   = '  - 1-3 M.2 slots (one usually PCIe 4.0+, others PCIe 3.0).'
            DesktopTyp2   = '  - 2-6 SATA ports (for 2.5" SSD or 3.5" HDD).'
            DesktopTyp3   = '  - Check M.2: some slots are M.2 SATA, others M.2 NVMe, others both ("combo").'
            StorageRecHdr = '--- Storage recommendations ---'
            StorageHDDOnly= '[!!] System BOOTS from HDD. Migrating to SSD gives 5-10x perceived speedup. MAX priority.'
            StorageHDDAlso= '[i] HDD present. Useful for data/backup. System should be on SSD (already seems to be).'
            StorageNoNVMe = '[i] No NVMe. Consider migrating to M.2 NVMe for >3 GB/s sequential reads (SATA SSD caps at 550 MB/s).'
            StorageCauHdr = '--- Storage buying precautions ---'
            StorageCau1   = '  * M.2 NVMe vs M.2 SATA: NOT interchangeable. Verify which your slot supports.'
            StorageCau2   = '  * PCIe 4.0 vs 3.0: a PCIe 4.0 SSD works in PCIe 3.0 but capped to slot speed.'
            StorageCau3   = '  * M.2 size: 2280 is standard (80 mm). 2230/2242 exist in ultraslim laptops.'
            StorageCau4   = '  * DRAM cache: SSDs without DRAM (low-end QLC) degrade fast under sustained load.'
            StorageCau5   = '  * TBW (terabytes written): check endurance before buying for server/video editor.'
            StorageCau6   = '  * Buy SSD >= 500 GB (cost per GB nearly equal and performance better).'
            StorageCau7   = '  * Clone with vendor tool (Samsung Magician, Crucial Storage Executive, etc.) or Macrium Reflect.'
            SecOther      = '4. OTHER COMPONENTS'
            GPUHdr        = '--- GPU ---'
            GPULine       = '  {0} ({1} MB VRAM reported)'
            GPULaptop     = '  [i] GPU in laptops is NOT upgradeable (soldered to mainboard or rare MXM).'
            GPUDesk1      = '  [i] GPU in desktop: upgradeable if you have free PCIe and enough PSU (W).'
            GPUDesk2      = '  [!] When buying GPU verify: connector (8/6/12VHPWR), physical length (case), TDP vs PSU, PCIe slot.'
            PSUHdr        = '--- Power Supply (PSU) ---'
            PSULine1      = '  Windows does NOT expose PSU brand/wattage. Check the physical label inside the case.'
            PSULine2      = '  For GPU upgrade or strong CPU: ensure PSU is 80+ Bronze or higher with enough wattage.'
            BIOSHdr       = '--- BIOS / UEFI ---'
            BIOSVersion   = '  Version:  {0}'
            BIOSDate      = '  Date:     {0} ({1} years ago)'
            BIOSOld       = '  [!] Old BIOS. Updating may unlock newer CPUs and fix bugs. Check vendor website.'
            BIOSReadErr   = '  Could not read BIOS.'
            ExportHdr     = 'EXPORT REPORT'
            ExportOpt1    = ' [1] Save TXT to Desktop'
            ExportOpt2    = ' [2] Save HTML to Desktop'
            ExportOpt3    = ' [3] Quit without saving'
            ChooseOpt     = ' Choose option'
            TXTSaved      = '[OK] TXT saved: {0}'
            HTMLSaved     = '[OK] HTML saved: {0}'
            QuitNoSave    = 'Quitting without saving.'
            CPUUMOther    = 'Other'
            CPUUMUnknown  = 'Unknown'
            CPUUMBGA      = 'None (BGA/Soldered)'
            CPUUMReplace  = 'Replaceable'
            CPUUMNotRep   = 'Not reported'
        }
        es = @{
            WinTitle      = 'ATLAS PC SUPPORT - Parts Upgrade Advisor'
            HeaderMain    = 'ATLAS PARTS UPGRADE ADVISOR'
            DateLbl       = 'Fecha: {0}'
            CompLbl       = 'Equipo: {0}'
            Vendor        = 'Fabricante:   {0}'
            Model         = 'Modelo:       {0}'
            ModelExact    = 'Modelo exacto: {0}'
            Mainboard     = 'Placa base:   {0} {1}'
            FormFactor    = 'Form factor:  {0}'
            FFLaptop      = 'Laptop'
            FFDesktop     = 'Desktop/Otro'
            SecRAM        = '1. MEMORIA RAM'
            RAMErr        = '[ERROR] No se pudo consultar la RAM. Ejecuta como administrador.'
            SlotsTotal    = 'Slots totales:  {0}'
            SlotsUsed     = 'Slots ocupados: {0}'
            SlotsFree     = 'Slots libres:   {0}'
            RAMTotal      = 'RAM total:      {0} GB'
            BiosMaxRAM    = 'Maximo segun BIOS: {0} GB'
            ModulesHdr    = '--- Modulos instalados ---'
            XmpOff        = '  [XMP APAGADO]'
            ModuleLine    = '  [{0}] {1} GB {2} @ {3}/{4} MHz  {5}  PN: {6}{7}'
            RAMRecHdr     = '--- Recomendaciones RAM ---'
            RAMSlotsFree  = '[OK] Tienes {0} slot(s) libre(s). Puedes ampliar.'
            RAMBuyMatch   = '     Compra modulos del MISMO tipo ({0}) y MISMA velocidad ({1} MHz) para modo dual-channel.'
            RAMNoSlots    = '[!] Todos los slots estan ocupados. Para ampliar habra que reemplazar modulos por unos de mayor capacidad.'
            RAMLow        = '[!] RAM total < 8 GB. Recomendado: minimo 8 GB (uso general), 16 GB (productividad), 32 GB+ (gaming/pro).'
            RAMMid        = '[i] 8 GB es aceptable para uso basico, pero 16 GB es lo optimo hoy.'
            RAMOK         = '[OK] {0} GB de RAM es suficiente para la mayoria de usos.'
            RAMCautionsHdr= '--- Precauciones al comprar RAM ---'
            RAMCau1       = '  * Mismo tipo (DDR4 con DDR4, DDR5 con DDR5, nunca mezclar).'
            RAMCau2       = '  * Mismo form factor: DIMM (escritorio) o SO-DIMM (laptop).'
            RAMCau3       = '  * Velocidad IGUAL o SUPERIOR al modulo existente (si pones menor, el CPU la bajara).'
            RAMCau4       = '  * Voltaje IGUAL. Mezclar 1.35V con 1.2V da inestabilidad.'
            RAMCau5       = '  * Marca/latencias parecidas para dual-channel limpio.'
            RAMCau6       = '  * Verifica con CPU-Z la RAM actual antes de comprar.'
            SecCPU        = '2. CPU (Procesador)'
            CPUErr        = '[ERROR] No se pudo consultar el CPU.'
            CPULine       = 'Procesador: {0}'
            CoresThreads  = 'Nucleos/Hilos: {0}C / {1}T'
            SocketRep     = 'Socket reportado: {0}'
            UpgradeMethod = 'Upgrade method: {0}'
            Generation    = 'Generacion: {0}'
            ReplaceableHdr= '--- Reemplazable? ---'
            CPUSoldered   = '[X] CPU SOLDADO A LA PLACA (BGA). NO es reemplazable.'
            CPUSolderedNote='    Actualizacion: imposible salvo reemplazo completo de placa base (y con eso, el PC entero).'
            CPUMaybeSold  = '[?] CPU PROBABLEMENTE SOLDADO. Verifica con el fabricante antes de comprar nada.'
            CPUInSocket   = '[OK] CPU en SOCKET ({0}) - Reemplazable.'
            CPUSocketNote = '    Puedes cambiarlo por otro CPU compatible con este socket y chipset.'
            SignalsLine   = '    Senales detectadas: {0}'
            CPURecHdr     = '--- Recomendaciones CPU ---'
            CPURecSold    = '  No hay upgrade posible. Si quieres mas rendimiento, considera un equipo nuevo o SSD+RAM para extender vida util.'
            CPURec1       = '  1) Anota el socket: {0}'
            CPURec2       = "  2) Busca el modelo exacto de la placa base (arriba) y descarga su 'CPU Support List' oficial."
            CPURec3       = '  3) Revisa requisito de BIOS: muchos chipsets Intel/AMD requieren actualizar BIOS antes de poner CPU mas nuevo.'
            CPURec4       = '  4) Compara TDP: un CPU con TDP superior al del disipador actual podra pero termicamente castigado. Cambia disipador si subes de 65W a 95W+.'
            CPURec5       = '  5) Verifica generacion compatible: no todos los sockets admiten todas las gens (ej: LGA1200 admite 10th/11th gen solo).'
            CPUCauHdr     = '--- Precauciones al comprar CPU ---'
            CPUCau1       = '  * Socket y chipset compatibles (no solo el socket fisico).'
            CPUCau2       = '  * BIOS actualizada a version que soporte el CPU objetivo.'
            CPUCau3       = '  * TDP compatible con el disipador/fuente. Si subes TDP, cambia pasta termica minimo.'
            CPUCau4       = '  * En laptops: casi SIEMPRE soldado. Ahorrate tiempo, no hay upgrade.'
            CPUCau5       = '  * Si el CPU viene sin fan (tipo "tray" o "OEM"), compra uno aparte.'
            SecStorage    = '3. ALMACENAMIENTO (Discos y slots)'
            DisksErr      = '[ERROR] No se pudieron enumerar discos.'
            DisksHdr      = '--- Discos instalados ---'
            KindNVMe      = 'NVMe (M.2)'
            KindUSB       = 'USB externo'
            KindHDD       = 'HDD mecanico'
            KindSSDSATA   = 'SSD SATA'
            KindSSDSATAi  = 'SSD SATA (inferido)'
            KindHDDi      = 'HDD (inferido)'
            DiskLine      = '  {0}  [{1}]  bus={2}  media={3}  tam={4} GB  salud={5}'
            StorageSummary= '--- Resumen almacenamiento ---'
            SumNVMe       = '  NVMe (M.2):    {0}'
            SumSATA       = '  SSD SATA:      {0}'
            SumHDD        = '  HDD mecanico:  {0}'
            SumUSB        = '  USB externo:   {0}'
            SlotsHdr      = '--- Slots fisicos disponibles (inferencia) ---'
            SlotsNote     = 'Windows NO expone directamente "slots M.2 libres". Se infiere del modelo de placa base.'
            DetectedBoard = 'Placa base detectada: {0} {1}'
            ToFindSlots   = 'Para saber slots reales:'
            GoogleSearch  = '  1) Busca en Google: {0} specifications M.2 SATA slots'
            DirectURL     = '  2) URL directa: https://www.google.com/search?q={0}'
            NoBoard       = 'No se pudo detectar modelo de placa base. Consulta etiqueta fisica o CPU-Z -> Mainboard.'
            LaptopTyp     = 'En laptops tipicos:'
            LaptopTyp1    = '  - 1 slot M.2 NVMe (a veces 2 en gaming).'
            LaptopTyp2    = '  - A veces 1 bahia 2.5" SATA (cada vez menos comun).'
            LaptopTyp3    = '  - Rara vez se puede anadir disco sin desmontar.'
            DesktopTyp    = 'En desktop tipico (ATX mid-range):'
            DesktopTyp1   = '  - 1-3 slots M.2 (uno suele ser PCIe 4.0 o superior, otros PCIe 3.0).'
            DesktopTyp2   = '  - 2-6 puertos SATA (para SSD 2.5" o HDD 3.5").'
            DesktopTyp3   = '  - Verifica M.2: algunos slots son M.2 SATA, otros M.2 NVMe, otros ambos ("combo").'
            StorageRecHdr = '--- Recomendaciones almacenamiento ---'
            StorageHDDOnly= '[!!] El SISTEMA arranca de HDD. Migrar a SSD da 5-10x mejora percibida. Prioridad MAXIMA.'
            StorageHDDAlso= '[i] Tienes HDD presente. Util para datos/backup. Sistema deberia estar en SSD (ya parece serlo).'
            StorageNoNVMe = '[i] Sin NVMe. Considera migrar a M.2 NVMe para lectura secuencial >3 GB/s (SATA SSD tope es 550 MB/s).'
            StorageCauHdr = '--- Precauciones al comprar almacenamiento ---'
            StorageCau1   = '  * M.2 NVMe vs M.2 SATA: NO son intercambiables. Verifica cual admite tu slot.'
            StorageCau2   = '  * PCIe 4.0 vs 3.0: un SSD PCIe 4.0 funciona en slot PCIe 3.0 pero limitado a la velocidad del slot.'
            StorageCau3   = '  * Tamano M.2: 2280 es el estandar (80 mm). 2230/2242 existen en laptops ultraslim.'
            StorageCau4   = '  * DRAM cache: SSDs sin DRAM (QLC low-end) se degradan rapido con cargas sostenidas.'
            StorageCau5   = '  * TBW (terabytes writes): revisa endurance antes de comprar para servidor/editor de video.'
            StorageCau6   = '  * Compra SSD >= 500 GB (el coste GB es casi igual y rendimiento mejora).'
            StorageCau7   = '  * Clona con herramienta del fabricante (Samsung Magician, Crucial Storage Executive, etc) o Macrium Reflect.'
            SecOther      = '4. OTROS COMPONENTES'
            GPUHdr        = '--- GPU ---'
            GPULine       = '  {0} ({1} MB VRAM reportado)'
            GPULaptop     = '  [i] GPU en laptops NO es upgradeable (soldada al mainboard o en MXM raro).'
            GPUDesk1      = '  [i] GPU en desktop: upgradeable si tienes PCIe libre y fuente suficiente (W).'
            GPUDesk2      = '  [!] Al comprar GPU verifica: conector (8/6/12VHPWR), largo fisico (caja), TDP vs fuente, slot PCIe.'
            PSUHdr        = '--- Fuente de poder (PSU) ---'
            PSULine1      = '  Windows NO expone la marca/wattage de la PSU. Revisa la etiqueta fisica dentro de la caja.'
            PSULine2      = '  Para upgrade de GPU o CPU potente: verifica que la fuente sea 80+ Bronze o superior y con wattage suficiente.'
            BIOSHdr       = '--- BIOS / UEFI ---'
            BIOSVersion   = '  Version:  {0}'
            BIOSDate      = '  Fecha:    {0} (hace {1} anios)'
            BIOSOld       = '  [!] BIOS antigua. Actualizarla puede habilitar CPUs nuevos y corregir bugs. Revisa la web del fabricante.'
            BIOSReadErr   = '  No se pudo leer BIOS.'
            ExportHdr     = 'EXPORTAR REPORTE'
            ExportOpt1    = ' [1] Guardar TXT en Escritorio'
            ExportOpt2    = ' [2] Guardar HTML en Escritorio'
            ExportOpt3    = ' [3] Salir sin guardar'
            ChooseOpt     = ' Elige opcion'
            TXTSaved      = '[OK] TXT guardado: {0}'
            HTMLSaved     = '[OK] HTML guardado: {0}'
            QuitNoSave    = 'Saliendo sin guardar.'
            CPUUMOther    = 'Otro'
            CPUUMUnknown  = 'Desconocido'
            CPUUMBGA      = 'Ninguno (BGA/Soldado)'
            CPUUMReplace  = 'Reemplazable'
            CPUUMNotRep   = 'No reportado'
        }
    }
    $lang = _Atlas-DetectLang
    if (-not $T.ContainsKey($lang)) { $lang = 'en' }
    $L = $T[$lang]

    $ErrorActionPreference = 'Continue'
    $Host.UI.RawUI.WindowTitle = $L.WinTitle
    try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(110, 50) } catch {}
    Clear-Host

    $script:ReporteTexto = ''

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
    # GENERAL INFO
    # ================================================================
    Section-Header $L.HeaderMain
    Log-Out ($L.DateLbl -f (Get-Date -Format 'yyyy-MM-dd HH:mm')) 'Gray'
    Log-Out ($L.CompLbl -f $env:COMPUTERNAME) 'Gray'

    $cs = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
    $csp = Get-CimInstance Win32_ComputerSystemProduct -ErrorAction SilentlyContinue
    $bb = Get-CimInstance Win32_BaseBoard -ErrorAction SilentlyContinue
    $chassis = Get-CimInstance Win32_SystemEnclosure -ErrorAction SilentlyContinue
    $isLaptop = $false
    if ($chassis) { foreach ($ct in $chassis.ChassisTypes) { if ($ct -in @(9,10,14,31,32)) { $isLaptop = $true; break } } }

    if ($cs) { Log-Out ($L.Vendor -f $cs.Manufacturer) }
    if ($cs) { Log-Out ($L.Model -f $cs.Model) }
    if ($csp -and $csp.Name) { Log-Out ($L.ModelExact -f $csp.Name) }
    if ($bb) { Log-Out ($L.Mainboard -f $bb.Manufacturer, $bb.Product) }
    Log-Out ($L.FormFactor -f $(if ($isLaptop) { $L.FFLaptop } else { $L.FFDesktop }))

    # ================================================================
    # RAM
    # ================================================================
    Section-Header $L.SecRAM

    try {
        $placa = Get-CimInstance Win32_PhysicalMemoryArray -ErrorAction Stop
        $modulos = @(Get-CimInstance Win32_PhysicalMemory -ErrorAction Stop)
    } catch {
        Log-Out $L.RAMErr 'Red'
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

    Log-Out ($L.SlotsTotal -f $slotsTotales)
    Log-Out ($L.SlotsUsed -f $slotsUsados)
    Log-Out ($L.SlotsFree -f $slotsLibres)
    Log-Out ($L.RAMTotal -f $ramTotalGB) 'Green'
    if ($maxGB) { Log-Out ($L.BiosMaxRAM -f $maxGB) 'Green' }

    $ramTypes = @{}
    Log-Out ''
    Log-Out $L.ModulesHdr 'Yellow'
    foreach ($ram in $modulos) {
        $capGB = [math]::Round($ram.Capacity / 1GB, 0)
        $ramTypeCode = [int]$ram.SMBIOSMemoryType
        $ramTypeMap = @{ 20='DDR'; 21='DDR2'; 24='DDR3'; 26='DDR4'; 34='DDR5' }
        $ramTypeName = if ($ramTypeMap.ContainsKey($ramTypeCode)) { $ramTypeMap[$ramTypeCode] } else { "Type $ramTypeCode" }
        $ramTypes[$ramTypeName] = $true
        $nat = $ram.Speed
        $cfg = $ram.ConfiguredClockSpeed
        $xmpFlag = if ($cfg -lt $nat) { $L.XmpOff } else { '' }
        Log-Out ($L.ModuleLine -f $ram.DeviceLocator, $capGB, $ramTypeName, $cfg, $nat, $ram.Manufacturer, $ram.PartNumber, $xmpFlag)
    }

    Log-Out ''
    Log-Out $L.RAMRecHdr 'Magenta'
    $ramTypesList = @($ramTypes.Keys) -join ', '
    if ($slotsLibres -gt 0) {
        Log-Out ($L.RAMSlotsFree -f $slotsLibres) 'Green'
        Log-Out ($L.RAMBuyMatch -f $ramTypesList, ($modulos[0].Speed))
    } else {
        Log-Out $L.RAMNoSlots 'Yellow'
    }
    if ($ramTotalGB -lt 8) {
        Log-Out $L.RAMLow 'Yellow'
    } elseif ($ramTotalGB -lt 16) {
        Log-Out $L.RAMMid 'White'
    } else {
        Log-Out ($L.RAMOK -f $ramTotalGB) 'Green'
    }
    Log-Out ''
    Log-Out $L.RAMCautionsHdr 'Cyan'
    Log-Out $L.RAMCau1
    Log-Out $L.RAMCau2
    Log-Out $L.RAMCau3
    Log-Out $L.RAMCau4
    Log-Out $L.RAMCau5
    Log-Out $L.RAMCau6

    # ================================================================
    # CPU
    # ================================================================
    Section-Header $L.SecCPU

    $proc = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $proc) {
        Log-Out $L.CPUErr 'Red'
    } else {
        $cpuName = if ($proc.Name) { $proc.Name.Trim() } else { $L.CPUUMUnknown }
        $cores = $proc.NumberOfCores
        $threads = $proc.NumberOfLogicalProcessors
        $socketName = if ($proc.SocketDesignation) { $proc.SocketDesignation } else { $L.CPUUMNotRep }
        $upgradeCode = if ($proc.UpgradeMethod) { [int]$proc.UpgradeMethod } else { 2 }

        $upgradeMethodNames = @{
            1=$L.CPUUMOther; 2=$L.CPUUMUnknown; 3='Daughter Board'; 4='ZIF Socket'; 5=$L.CPUUMReplace
            6=$L.CPUUMBGA; 7='LIF Socket'; 8='Slot 1'; 9='Slot 2'
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
        $upgradeMethodName = if ($upgradeMethodNames.ContainsKey($upgradeCode)) { $upgradeMethodNames[$upgradeCode] } else { "Code $upgradeCode" }

        $gen = 0; $genLabel = ''
        if ($cpuName -match 'i[3579]-(\d{1,2})(\d{2,3})') { $gen = [int]$matches[1]; $genLabel = "Intel Gen $gen" }
        elseif ($cpuName -match 'Core\s*Ultra') { $gen = 14; $genLabel = 'Intel Core Ultra (Gen 14+)' }
        elseif ($cpuName -match 'Ryzen\s+[3579]\s+(\d)(\d{2,4})') { $gen = [int]$matches[1]; $genLabel = "AMD Ryzen Gen $gen" }
        elseif ($cpuName -match 'Athlon|A[46]-|A[46]\s|E[12]-|FX-') { $gen = 1; $genLabel = 'AMD Legacy' }

        Log-Out ($L.CPULine -f $cpuName) 'Green'
        Log-Out ($L.CoresThreads -f $cores, $threads)
        Log-Out ($L.SocketRep -f $socketName)
        Log-Out ($L.UpgradeMethod -f $upgradeMethodName)
        if ($genLabel) { Log-Out ($L.Generation -f $genLabel) }

        $bgaSignals = 0; $bgaReasons = @()
        if ($upgradeCode -eq 6) { $bgaSignals += 3; $bgaReasons += 'UpgradeMethod = None/BGA' }
        elseif ($upgradeMethodName -match 'BGA') { $bgaSignals += 3; $bgaReasons += "Socket BGA ($upgradeMethodName)" }
        if ($socketName -match 'BGA') { $bgaSignals += 2; $bgaReasons += 'Socket designated BGA' }
        if ($cpuName -match '[-\s](\d{4,5})[UYHPG]\b') { $bgaSignals += 1; $bgaReasons += 'Mobile suffix (U/Y/H/P/G)' }
        if ($isLaptop -and $bgaSignals -ge 1) { $bgaSignals += 1; $bgaReasons += 'Laptop chassis' }

        Log-Out ''
        Log-Out $L.ReplaceableHdr 'Magenta'
        if ($bgaSignals -ge 3) {
            Log-Out $L.CPUSoldered 'Red'
            Log-Out $L.CPUSolderedNote
        } elseif ($bgaSignals -ge 1) {
            Log-Out $L.CPUMaybeSold 'Yellow'
        } else {
            Log-Out ($L.CPUInSocket -f $socketName) 'Green'
            Log-Out $L.CPUSocketNote
        }
        if ($bgaReasons.Count -gt 0) { Log-Out ($L.SignalsLine -f ($bgaReasons -join ' | ')) 'DarkGray' }

        Log-Out ''
        Log-Out $L.CPURecHdr 'Magenta'
        if ($bgaSignals -ge 3) {
            Log-Out $L.CPURecSold
        } else {
            Log-Out ($L.CPURec1 -f $socketName)
            Log-Out $L.CPURec2
            Log-Out $L.CPURec3
            Log-Out $L.CPURec4
            Log-Out $L.CPURec5
        }
        Log-Out ''
        Log-Out $L.CPUCauHdr 'Cyan'
        Log-Out $L.CPUCau1
        Log-Out $L.CPUCau2
        Log-Out $L.CPUCau3
        Log-Out $L.CPUCau4
        Log-Out $L.CPUCau5
    }

    # ================================================================
    # STORAGE
    # ================================================================
    Section-Header $L.SecStorage

    $physDisks = @(Get-PhysicalDisk -ErrorAction SilentlyContinue)
    $nvmeCount = 0; $sataSsdCount = 0; $hddCount = 0; $usbCount = 0

    if ($physDisks.Count -eq 0) {
        Log-Out $L.DisksErr 'Red'
    } else {
        Log-Out $L.DisksHdr 'Yellow'
        foreach ($pd in $physDisks) {
            $name = if ($pd.FriendlyName) { $pd.FriendlyName } else { 'Disk' }
            $bus = if ($pd.BusType) { $pd.BusType.ToString() } else { '?' }
            $media = if ($pd.MediaType) { $pd.MediaType.ToString() } else { '?' }
            $sizeGB = if ($pd.Size) { [math]::Round($pd.Size / 1GB, 0) } else { 0 }
            $health = if ($pd.HealthStatus) { $pd.HealthStatus.ToString() } else { '?' }

            $kind = 'Other'
            if ($bus -match 'NVMe') { $kind = $L.KindNVMe; $nvmeCount++ }
            elseif ($bus -match 'USB') { $kind = $L.KindUSB; $usbCount++ }
            elseif ($media -match 'HDD') { $kind = $L.KindHDD; $hddCount++ }
            elseif ($media -match 'SSD' -and $bus -match 'SATA|ATA') { $kind = $L.KindSSDSATA; $sataSsdCount++ }
            elseif ($bus -match 'SATA|ATA') {
                if ($sizeGB -lt 300) { $kind = $L.KindSSDSATAi; $sataSsdCount++ }
                else { $kind = $L.KindHDDi; $hddCount++ }
            }

            Log-Out ($L.DiskLine -f $kind, $name, $bus, $media, $sizeGB, $health)
        }
    }

    Log-Out ''
    Log-Out $L.StorageSummary 'Yellow'
    Log-Out ($L.SumNVMe -f $nvmeCount)
    Log-Out ($L.SumSATA -f $sataSsdCount)
    Log-Out ($L.SumHDD  -f $hddCount)
    Log-Out ($L.SumUSB  -f $usbCount)

    Log-Out ''
    Log-Out $L.SlotsHdr 'Magenta'
    Log-Out $L.SlotsNote
    if ($bb) {
        Log-Out ($L.DetectedBoard -f $bb.Manufacturer, $bb.Product) 'Cyan'
        Log-Out $L.ToFindSlots
        $searchQuery = [uri]::EscapeDataString(("{0} {1} specifications M.2 SATA slots" -f $bb.Manufacturer, $bb.Product))
        Log-Out ($L.GoogleSearch -f "$($bb.Manufacturer) $($bb.Product)")
        Log-Out ($L.DirectURL -f $searchQuery)
    } else {
        Log-Out $L.NoBoard
    }
    Log-Out ''
    if ($isLaptop) {
        Log-Out $L.LaptopTyp
        Log-Out $L.LaptopTyp1
        Log-Out $L.LaptopTyp2
        Log-Out $L.LaptopTyp3
    } else {
        Log-Out $L.DesktopTyp
        Log-Out $L.DesktopTyp1
        Log-Out $L.DesktopTyp2
        Log-Out $L.DesktopTyp3
    }

    Log-Out ''
    Log-Out $L.StorageRecHdr 'Magenta'
    if ($hddCount -gt 0 -and $nvmeCount -eq 0 -and $sataSsdCount -eq 0) {
        Log-Out $L.StorageHDDOnly 'Red'
    } elseif ($hddCount -gt 0) {
        Log-Out $L.StorageHDDAlso
    }
    if ($nvmeCount -eq 0 -and -not $isLaptop) {
        Log-Out $L.StorageNoNVMe
    }
    Log-Out ''
    Log-Out $L.StorageCauHdr 'Cyan'
    Log-Out $L.StorageCau1
    Log-Out $L.StorageCau2
    Log-Out $L.StorageCau3
    Log-Out $L.StorageCau4
    Log-Out $L.StorageCau5
    Log-Out $L.StorageCau6
    Log-Out $L.StorageCau7

    # ================================================================
    # OTHER COMPONENTS
    # ================================================================
    Section-Header $L.SecOther

    $gpus = @(Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue | Where-Object { $_.Name -notmatch 'Microsoft Basic|Remote' })
    if ($gpus.Count -gt 0) {
        Log-Out $L.GPUHdr 'Yellow'
        foreach ($g in $gpus) {
            $vram = if ($g.AdapterRAM -gt 0) { [math]::Round($g.AdapterRAM / 1MB, 0) } else { 0 }
            Log-Out ($L.GPULine -f $g.Name, $vram)
        }
        if ($isLaptop) {
            Log-Out $L.GPULaptop 'Yellow'
        } else {
            Log-Out $L.GPUDesk1 'Green'
            Log-Out $L.GPUDesk2 'Cyan'
        }
    }

    Log-Out ''
    Log-Out $L.PSUHdr 'Yellow'
    Log-Out $L.PSULine1
    Log-Out $L.PSULine2

    Log-Out ''
    Log-Out $L.BIOSHdr 'Yellow'
    try {
        $bios = Get-CimInstance Win32_BIOS -ErrorAction Stop
        Log-Out ($L.BIOSVersion -f $bios.SMBIOSBIOSVersion)
        $biosDate = $null
        if ($bios.ReleaseDate) {
            try { $biosDate = [Management.ManagementDateTimeConverter]::ToDateTime($bios.ReleaseDate) } catch {}
        }
        if ($biosDate) {
            $ageYears = [math]::Round(((Get-Date) - $biosDate).TotalDays / 365.25, 1)
            Log-Out ($L.BIOSDate -f $biosDate.ToString('yyyy-MM-dd'), $ageYears)
            if ($ageYears -gt 3) {
                Log-Out $L.BIOSOld 'Yellow'
            }
        }
    } catch {
        Log-Out $L.BIOSReadErr 'Red'
    }

    # ================================================================
    # EXPORT
    # ================================================================
    Section-Header $L.ExportHdr
    Log-Out $L.ExportOpt1
    Log-Out $L.ExportOpt2
    Log-Out $L.ExportOpt3
    Log-Out ''
    $opc = Read-Host $L.ChooseOpt
    $base = "PartsUpgrade_$(Get-Date -Format 'yyyyMMdd_HHmm')"
    $desk = [Environment]::GetFolderPath('Desktop')
    switch ($opc) {
        '1' {
            $p = Join-Path $desk "$base.txt"
            [System.IO.File]::WriteAllText($p, $script:ReporteTexto, [System.Text.UTF8Encoding]::new($true))
            Log-Out ''
            Log-Out ($L.TXTSaved -f $p) 'Green'
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
            $html = "<html><head><meta charset='UTF-8'><title>Parts Upgrade - $env:COMPUTERNAME</title>$style</head><body><h1>Atlas PC Support - Parts Upgrade Advisor</h1><pre>$escaped</pre><div class='foot'>Generated $(Get-Date)</div></body></html>"
            [System.IO.File]::WriteAllText($p, $html, [System.Text.UTF8Encoding]::new($true))
            Log-Out ''
            Log-Out ($L.HTMLSaved -f $p) 'Green'
            try { Start-Process $p } catch {}
        }
        default { Log-Out $L.QuitNoSave 'DarkGray' }
    }
}
