# ============================================================
# Atlas PC Support - Dependency manager
# Resuelve y descarga dependencias externas (FastCopy, etc.)
# a %LOCALAPPDATA%\AtlasPC\bin\ bajo demanda.
# ============================================================

$script:AtlasDepsRegistry = @{
    'FastCopy' = @{
        DisplayName    = 'FastCopy'
        ExecutableName = 'FastCopy.exe'
        WingetId       = 'FastCopy.FastCopy'
        DownloadUrl    = 'https://fastcopy.jp/archive/FastCopy5.11.2_installer.exe'
        SearchPaths    = @(
            'C:\Program Files\FastCopy\FastCopy.exe',
            'C:\Program Files (x86)\FastCopy\FastCopy.exe',
            '%LOCALAPPDATA%\FastCopy\FastCopy.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\FastCopy\FastCopy.exe'
        )
    }
    'winget' = @{
        DisplayName    = 'Windows Package Manager'
        ExecutableName = 'winget.exe'
        SearchPaths    = @(
            '%LOCALAPPDATA%\Microsoft\WindowsApps\winget.exe'
        )
    }
    'GPUZ' = @{
        DisplayName    = 'TechPowerUp GPU-Z'
        ExecutableName = 'GPU-Z.exe'
        WingetId       = 'TechPowerUp.GPU-Z'
        SearchPaths    = @(
            'C:\Program Files (x86)\GPU-Z\GPU-Z.exe',
            'C:\Program Files\GPU-Z\GPU-Z.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\GPUCheck\tools\GPU-Z.exe'
        )
    }
    'FurMark2' = @{
        DisplayName    = 'Geeks3D FurMark 2'
        ExecutableName = 'furmark.exe'
        WingetId       = 'Geeks3D.FurMark.2'
        SearchPaths    = @(
            'C:\Program Files\Geeks3D\FurMark2_x64\furmark.exe',
            'C:\Program Files (x86)\Geeks3D\FurMark2_x64\furmark.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\GPUCheck\tools\FurMark2_x64\furmark.exe'
        )
    }
    'HWiNFO' = @{
        DisplayName    = 'HWiNFO64'
        ExecutableName = 'HWiNFO64.exe'
        WingetId       = 'REALiX.HWiNFO'
        SearchPaths    = @(
            'C:\Program Files\HWiNFO64\HWiNFO64.exe',
            'C:\Program Files (x86)\HWiNFO64\HWiNFO64.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\GPUCheck\tools\HWiNFO64.exe'
        )
    }
    'CPUZ' = @{
        DisplayName    = 'CPUID CPU-Z'
        ExecutableName = 'cpuz.exe'
        WingetId       = 'CPUID.CPU-Z'
        SearchPaths    = @(
            'C:\Program Files\CPUID\CPU-Z\cpuz_x64.exe',
            'C:\Program Files\CPUID\CPU-Z\cpuz_x32.exe',
            'C:\Program Files\CPUID\CPU-Z\cpuz.exe',
            'C:\Program Files (x86)\CPUID\CPU-Z\cpuz_x64.exe',
            'C:\Program Files (x86)\CPUID\CPU-Z\cpuz_x32.exe',
            'C:\Program Files (x86)\CPUID\CPU-Z\cpuz.exe',
            '%LOCALAPPDATA%\Microsoft\WinGet\Links\cpuz.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\DiagnosticoMaster\tools\cpuz_x64.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\DiagnosticoMaster\tools\cpuz_x32.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\DiagnosticoMaster\tools\cpuz.exe'
        )
    }
    'BlueScreenView' = @{
        DisplayName    = 'NirSoft BlueScreenView'
        ExecutableName = 'BlueScreenView.exe'
        WingetId       = 'NirSoft.BlueScreenView'
        SearchPaths    = @(
            'C:\Program Files\NirSoft\BlueScreenView\BlueScreenView.exe',
            'C:\Program Files (x86)\NirSoft\BlueScreenView\BlueScreenView.exe',
            '%LOCALAPPDATA%\Microsoft\WinGet\Links\bluescreenview.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\DiagnosticoMaster\tools\BlueScreenView.exe'
        )
    }
    'BatteryInfoView' = @{
        DisplayName    = 'NirSoft BatteryInfoView'
        ExecutableName = 'BatteryInfoView.exe'
        WingetId       = 'NirSoft.BatteryInfoView'
        SearchPaths    = @(
            'C:\Program Files\NirSoft\BatteryInfoView\BatteryInfoView.exe',
            'C:\Program Files (x86)\NirSoft\BatteryInfoView\BatteryInfoView.exe',
            '%LOCALAPPDATA%\Microsoft\WinGet\Links\batteryinfoview.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\DiagnosticoMaster\tools\BatteryInfoView.exe'
        )
    }
    'CrystalDiskInfo' = @{
        DisplayName    = 'CrystalDiskInfo'
        ExecutableName = 'DiskInfo64.exe'
        WingetId       = 'CrystalDewWorld.CrystalDiskInfo'
        SearchPaths    = @(
            'C:\Program Files\CrystalDiskInfo\DiskInfo64.exe',
            'C:\Program Files (x86)\CrystalDiskInfo\DiskInfo64.exe',
            'C:\Program Files\CrystalDiskInfo\DiskInfo32.exe',
            'C:\Program Files (x86)\CrystalDiskInfo\DiskInfo32.exe',
            '%LOCALAPPDATA%\Microsoft\WinGet\Links\diskinfo.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\DiagnosticoMaster\tools\DiskInfo64.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\DiagnosticoMaster\tools\DiskInfo32.exe'
        )
    }
    'CrystalDiskMark' = @{
        DisplayName    = 'CrystalDiskMark'
        ExecutableName = 'DiskMark64.exe'
        WingetId       = 'CrystalDewWorld.CrystalDiskMark'
        SearchPaths    = @(
            'C:\Program Files\CrystalDiskMark8\DiskMark64.exe',
            'C:\Program Files\CrystalDiskMark9\DiskMark64.exe',
            'C:\Program Files\CrystalDiskMark\DiskMark64.exe',
            'C:\Program Files (x86)\CrystalDiskMark8\DiskMark64.exe',
            'C:\Program Files (x86)\CrystalDiskMark9\DiskMark64.exe',
            'C:\Program Files (x86)\CrystalDiskMark\DiskMark64.exe',
            '%LOCALAPPDATA%\Microsoft\WinGet\Links\diskmark.exe',
            '%LOCALAPPDATA%\AtlasPC\bin\DiagnosticoMaster\tools\DiskMark64.exe'
        )
    }
}

function Resolve-AtlasDependency {
    <#
    .SYNOPSIS
    Busca una dependencia en el sistema; si no la encuentra,
    intenta instalarla con winget o descargarla.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [string]$Name,
        [switch]$InstallIfMissing
    )

    if (-not $script:AtlasDepsRegistry.ContainsKey($Name)) {
        Write-AtlasLog "Dependencia desconocida: $Name" -Level ERROR -Tool 'Deps'
        return $null
    }
    $dep = $script:AtlasDepsRegistry[$Name]

    foreach ($p in $dep.SearchPaths) {
        $expanded = Expand-AtlasPath $p
        if (Test-Path $expanded) {
            Write-AtlasLog "Encontrada $Name en $expanded" -Tool 'Deps'
            return $expanded
        }
    }
    $inPath = Get-Command $dep.ExecutableName -ErrorAction SilentlyContinue
    if ($inPath) { return $inPath.Source }

    if (-not $InstallIfMissing) {
        Write-AtlasLog "$Name no encontrada (no se pidió instalar)." -Level WARN -Tool 'Deps'
        return $null
    }

    if ($dep.WingetId -and (Get-Command 'winget' -ErrorAction SilentlyContinue)) {
        Write-AtlasLog "Instalando $Name vía winget ($($dep.WingetId))" -Tool 'Deps'
        try {
            winget install --id $dep.WingetId --exact --accept-source-agreements --accept-package-agreements --silent | Out-Null
        } catch {
            Write-AtlasLog "winget falló: $_" -Level WARN -Tool 'Deps'
        }
        foreach ($p in $dep.SearchPaths) {
            $expanded = Expand-AtlasPath $p
            if (Test-Path $expanded) { return $expanded }
        }
    }

    # Fallback: direct download via DownloadUrl when winget is unavailable or failed
    if ($dep.DownloadUrl) {
        Write-AtlasLog "Intentando descarga directa de $Name ($($dep.DownloadUrl))" -Tool 'Deps'
        $cacheDir = Join-Path $env:LOCALAPPDATA 'AtlasPC\bin'
        if (-not (Test-Path $cacheDir)) { New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null }
        $installerFile = Join-Path $cacheDir ("$Name-installer-" + [guid]::NewGuid().ToString('N').Substring(0,8) + '.exe')
        try {
            $ProgressPreference = 'SilentlyContinue'
            Invoke-WebRequest -Uri $dep.DownloadUrl -OutFile $installerFile -UseBasicParsing -TimeoutSec 120 -ErrorAction Stop
            if ((Get-Item $installerFile).Length -gt 100KB) {
                $targetDir = Join-Path $env:LOCALAPPDATA "AtlasPC\bin\$Name"
                if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force | Out-Null }
                $p = Start-Process -FilePath $installerFile -ArgumentList @('/EXTRACT64', '/NOSUBDIR', '/AGREE_LICENSE', "/DIR=`"$targetDir`"") -Wait -PassThru -ErrorAction SilentlyContinue
                if (-not ($p -and $p.ExitCode -eq 0)) {
                    Start-Process -FilePath $installerFile -ArgumentList @('/SILENT', '/AGREE_LICENSE', "/DIR=`"$targetDir`"") -Wait -ErrorAction SilentlyContinue
                }
                Remove-Item $installerFile -ErrorAction SilentlyContinue
                foreach ($sp in $dep.SearchPaths) {
                    $expanded = Expand-AtlasPath $sp
                    if (Test-Path $expanded) { return $expanded }
                }
                $found = Get-ChildItem -Path $targetDir -Filter $dep.ExecutableName -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($found) { return $found.FullName }
            }
        } catch {
            Write-AtlasLog "Descarga directa falló: $_" -Level WARN -Tool 'Deps'
            Remove-Item $installerFile -ErrorAction SilentlyContinue
        }
    }

    Write-AtlasLog "No se pudo resolver $Name. Revisa la ruta manualmente." -Level ERROR -Tool 'Deps'
    return $null
}

function Register-AtlasDependency {
    param(
        [Parameter(Mandatory)] [string]$Name,
        [Parameter(Mandatory)] [hashtable]$Definition
    )
    $script:AtlasDepsRegistry[$Name] = $Definition
}
