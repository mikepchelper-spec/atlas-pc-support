# ============================================================
# Invoke-ExtraerLicencias
# Migrado de: EXTAER+LICENCIAS.ps1
# Atlas PC Support — v1.0
# ============================================================

function Invoke-ExtraerLicencias {
    [CmdletBinding()]
    param()
# ============================================================================
# Script: Extractor de Licencias ATLAS y Auditor (Estable)
# Arquitectura: PowerShell (Compatible v2.0+)
# Objetivo: Extracción de BIOS, OS Actual y Detección de Originalidad
# ============================================================================

<#
.SYNOPSIS
    Fuerza la elevación de privilegios de Administrador de manera estable.
#>
$ErrorActionPreference = "Stop"

# (auto-elevación gestionada por Atlas Launcher)

<#
.SYNOPSIS
    Funciones de interfaz de usuario para alineación y formato estandarizado.
#>
$Host.UI.RawUI.WindowTitle = "ATLAS PC SUPPORT - Herramienta de Licencias"

function Write-Centered {
    param(
        [string]$Text,
        [ConsoleColor]$Color = 'White'
    )
    $windowWidth = $Host.UI.RawUI.WindowSize.Width
    if ($windowWidth -gt $Text.Length) {
        $padding = [math]::Max(0, [math]::Floor(($windowWidth - $Text.Length) / 2))
        $spaces = " " * $padding
        Write-Host "$spaces$Text" -ForegroundColor $Color
    } else {
        Write-Host $Text -ForegroundColor $Color
    }
}

function Show-Header {
    Clear-Host
    Write-Host "`n"
    Write-Centered -Text "========================================" -Color Yellow
    Write-Centered -Text "ATLAS PC SUPPORT" -Color Yellow
    Write-Centered -Text "========================================" -Color Yellow
    Write-Host "`n"
}

<#
.SYNOPSIS
    OPCIÓN 1: Extracción de clave inyectada en placa base (BIOS/UEFI)
#>
function Get-BiosKey {
    Show-Header
    Write-Centered -Text "--- EXTRACCIÓN DE CLAVE DE BIOS (DE FÁBRICA) ---" -Color Cyan
    Write-Host "`n"
    
    try {
        $wmiQuery = Get-WmiObject -Query 'select * from SoftwareLicensingService' -ErrorAction Stop
        $biosKey = $wmiQuery.OA3xOriginalProductKey
        $biosDesc = $wmiQuery.OA3xOriginalProductKeyDescription

        if ([string]::IsNullOrWhiteSpace($biosKey)) {
            Write-Centered -Text "[!] No se encontró clave OEM en la BIOS/UEFI." -Color Red
            Write-Centered -Text "Este equipo no vino con Windows preinstalado de fábrica." -Color Gray
        } else {
            Write-Centered -Text "[+] CLAVE BIOS ENCONTRADA:" -Color Green
            if (-not [string]::IsNullOrWhiteSpace($biosDesc)) {
                Write-Centered -Text "Edición de Fábrica: $biosDesc" -Color Cyan
            }
            Write-Centered -Text $biosKey -Color Yellow
            $biosKey | clip
            Write-Host "`n"
            Write-Centered -Text "(Copiada al portapapeles de manera segura)" -Color Gray
        }
    } catch {
        Write-Centered -Text "[X] Error al consultar la tabla ACPI: $($_.Exception.Message)" -Color Red
    }
    
    Write-Host "`n"
    Write-Centered -Text "Presione ENTER para volver al menú..." -Color White
    $null = Read-Host
}

<#
.SYNOPSIS
    OPCIÓN 2: Extracción de la clave instalada actualmente (Registro Avanzado Base24)
#>
function Get-CurrentKey {
    Show-Header
    Write-Centered -Text "--- EXTRACCIÓN DE CLAVE ACTUAL (OS INSTALADO) ---" -Color Cyan
    Write-Host "`n"
    
    try {
        # 1. Mostrar la Clave de la BIOS como referencia cruzada
        $sls = Get-WmiObject -Query 'select * from SoftwareLicensingService' -ErrorAction SilentlyContinue
        $biosRefKey = $sls.OA3xOriginalProductKey
        $biosRefDesc = $sls.OA3xOriginalProductKeyDescription
        
        if (-not [string]::IsNullOrWhiteSpace($biosRefKey)) {
            Write-Centered -Text "[+] CLAVE DE FÁBRICA (BIOS) DE REFERENCIA:" -Color DarkCyan
            if (-not [string]::IsNullOrWhiteSpace($biosRefDesc)) {
                Write-Centered -Text "Edición de Fábrica: $biosRefDesc" -Color Cyan
            }
            Write-Centered -Text $biosRefKey -Color Gray
            Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray
        }

        # 2. Búsqueda en el Registro para el OS Actual
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
        $backupKey = (Get-ItemProperty -Path $regPath -Name BackupProductKeyDefault -ErrorAction SilentlyContinue).BackupProductKeyDefault

        $hexPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
        
        # Corrección: Leer edición real desde WMI para evitar el falso "Windows 10" del registro de Win 11
        $currentEdition = (Get-WmiObject -Class Win32_OperatingSystem -ErrorAction SilentlyContinue).Caption -replace '^Microsoft\s+', ''
        
        $digitalProductId = (Get-ItemProperty -Path $hexPath -Name DigitalProductId -ErrorAction SilentlyContinue).DigitalProductId
        
        $decodedKey = $null
        $isKMSOrDigital = $false

        if ($digitalProductId -ne $null -and $digitalProductId.Length -ge 67) {
            $isWin8Or10 = [math]::Floor($digitalProductId[66] / 6) -band 1
            $digitalProductId[66] = ($digitalProductId[66] -band 0xF7) -bOr (($isWin8Or10 -band 2) * 4)
            $chars = "BCDFGHJKMPQRTVWXY2346789"
            $decodedKeyStr = ""
            for ($i = 24; $i -ge 0; $i--) {
                $current = 0
                for ($j = 14; $j -ge 0; $j--) {
                    $current = $current * 256 + $digitalProductId[$j + 52]
                    $digitalProductId[$j + 52] = [math]::Floor($current / 24)
                    $current = $current % 24
                }
                $decodedKeyStr = $chars[$current] + $decodedKeyStr
                $last = $current
            }
            if ($isWin8Or10 -eq 1) {
                $decodedKeyStr = $decodedKeyStr.Substring(1, $last) + "N" + $decodedKeyStr.Substring($last + 1)
            }
            $decodedKey = $decodedKeyStr.Insert(5, "-").Insert(11, "-").Insert(17, "-").Insert(23, "-")
            
            if ($decodedKey -eq "BBBBB-BBBBB-BBBBB-BBBBB-BBBBB") {
                $decodedKey = $null
                $isKMSOrDigital = $true
            }
        }

        $activeWmi = Get-WmiObject -Query "SELECT PartialProductKey, Description FROM SoftwareLicensingProduct WHERE LicenseStatus = 1 AND PartialProductKey IS NOT NULL" -ErrorAction SilentlyContinue

        if ($activeWmi) {
            Write-Centered -Text "[+] EVIDENCIA EN MOTOR DE ACTIVACIÓN (ÚNICOS DATOS REALES):" -Color Cyan
            foreach ($lic in $activeWmi) {
                Write-Centered -Text "Parcial: ******-******-******-******-$($lic.PartialProductKey)" -Color White
            }
            Write-Host ""
        }

        if (-not [string]::IsNullOrWhiteSpace($currentEdition)) {
            Write-Centered -Text "Edición Instalada: $currentEdition" -Color Cyan
            Write-Host ""
        }

        if ($isKMSOrDigital) {
            Write-Centered -Text "[!] ALERTA TÉCNICA: CLAVE OCULTA POR DISEÑO" -Color Yellow
            Write-Centered -Text "Windows ha borrado la clave del registro por seguridad corporativa." -Color Gray
            Write-Centered -Text "La licencia es MAK o Digital y no reside físicamente en el disco." -Color Gray
        } elseif (-not [string]::IsNullOrWhiteSpace($decodedKey)) {
            Write-Centered -Text "[+] CLAVE DECODIFICADA DEL REGISTRO:" -Color Green
            Write-Centered -Text $decodedKey -Color Yellow
            $decodedKey | clip
        }

        if (-not [string]::IsNullOrWhiteSpace($backupKey)) {
            Write-Host ""
            Write-Centered -Text "[+] CLAVE DE RESPALDO ENCONTRADA:" -Color DarkCyan
            Write-Centered -Text $backupKey -Color Gray
        }

    } catch {
        Write-Centered -Text "[X] Error crítico de decodificación." -Color Red
    }
    
    Write-Host "`n"
    Write-Centered -Text "Presione ENTER para volver al menú..." -Color White
    $null = Read-Host
}

<#
.SYNOPSIS
    OPCIÓN 3: Auditoría nativa mediante SLMGR
#>
function Invoke-NativeAudit {
    Show-Header
    Write-Centered -Text "--- AUDITORÍA NATIVA DEL SISTEMA (SLMGR) ---" -Color Cyan
    Write-Host "`n"
    Write-Centered -Text "Iniciando herramienta oficial de Microsoft..." -Color Gray
    
    # Ejecuta el comando nativo de Windows para mostrar información de la licencia
    cscript //nologo C:\Windows\System32\slmgr.vbs /dli
    
    Write-Host "`n"
    Write-Centered -Text "--- ANÁLISIS DE ORIGINALIDAD ---" -Color Cyan
    try {
        $wmi = Get-WmiObject -Query "SELECT Description, LicenseStatus FROM SoftwareLicensingProduct WHERE LicenseStatus = 1 AND PartialProductKey IS NOT NULL"
        foreach ($item in $wmi) {
            if ($item.Description -match "VOLUME_KMSCLIENT") {
                Write-Centered -Text "[!] DETECTADO: CANAL KMS (Posible activación por emulador)" -Color Yellow
            } elseif ($item.Description -match "VOLUME_MAK|RETAIL|OEM") {
                Write-Centered -Text "[+] DETECTADO: CANAL ORIGINAL ($($item.Description -replace '.*, ', ''))" -Color Green
            }
        }
    } catch {}

    Write-Host "`n"
    Write-Centered -Text "Presione ENTER para volver al menú..." -Color White
    $null = Read-Host
}

<#
.SYNOPSIS
    OPCIÓN 4: Información de Sistema (Incluye Clave BIOS, Clave Actual y Auditoría Visual)
#>
function Get-OsInfo {
    Show-Header
    Write-Centered -Text "--- INFORMACIÓN DEL SISTEMA OPERATIVO ---" -Color Cyan
    Write-Host "`n"
    
    # Variables para almacenar el reporte exportable
    $reportTxt = "========================================`r`nATLAS PC SUPPORT - REPORTE DE SISTEMA`r`n========================================`r`n`r`n"
    $reportHtml = "<html><head><meta charset='UTF-8'><title>Reporte ATLAS</title><style>body{font-family:'Segoe UI',Tahoma,sans-serif;background:#121212;color:#e0e0e0;text-align:center} .container{max-width:700px;margin:auto;background:#1e1e1e;padding:20px;border-radius:10px;box-shadow:0 4px 8px rgba(0,0,0,0.5)} h2{color:#f1c40f} .ok{color:#2ecc71} .warn{color:#f39c12} .info{color:#3498db;font-style:italic;font-size:0.9em;margin-top:5px;}</style></head><body><div class='container'><h2>ATLAS PC SUPPORT<br><small>Reporte de Licencias</small></h2><hr>"

    try {
        # Obtener datos del OS
        $os = Get-WmiObject -Class Win32_OperatingSystem
        Write-Centered -Text "Sistema: $($os.Caption)" -Color White
        Write-Centered -Text "Versión: $($os.Version)" -Color White
        Write-Centered -Text "Arquitectura: $($os.OSArchitecture)" -Color White
        Write-Centered -Text "Serie del OS: $($os.SerialNumber)" -Color White
        
        $reportTxt += "--- SISTEMA OPERATIVO ---`r`nSistema: $($os.Caption)`r`nVersión: $($os.Version)`r`nArquitectura: $($os.OSArchitecture)`r`nSerie: $($os.SerialNumber)`r`n`r`n"
        $reportHtml += "<h3>SISTEMA OPERATIVO</h3><p>Sistema: $($os.Caption)<br>Versión: $($os.Version)<br>Arquitectura: $($os.OSArchitecture)<br>Serie: $($os.SerialNumber)</p><hr>"
        
        Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray
        
        # ---------------------------------------------------------
        # Obtener datos de la BIOS (Punto 1 integrado)
        # ---------------------------------------------------------
        Write-Centered -Text "--- CLAVE DE FÁBRICA (BIOS/UEFI) ---" -Color Cyan
        $sls = Get-WmiObject -Query 'select * from SoftwareLicensingService'
        $biosKey = $sls.OA3xOriginalProductKey
        $biosDesc = $sls.OA3xOriginalProductKeyDescription
        
        $reportTxt += "--- CLAVE DE FÁBRICA (BIOS/UEFI) ---`r`n"
        $reportHtml += "<h3>CLAVE DE FÁBRICA (BIOS/UEFI)</h3>"

        if ([string]::IsNullOrWhiteSpace($biosKey)) {
            Write-Centered -Text "Clave BIOS: No encontrada (Equipo sin Windows de fábrica)" -Color Gray
            $reportTxt += "Estado: No encontrada.`r`n`r`n"
            $reportHtml += "<p>Estado: No encontrada.</p><hr>"
        } else {
            $descText = if ([string]::IsNullOrWhiteSpace($biosDesc)) { "Versión Desconocida" } else { $biosDesc }
            Write-Centered -Text "Versión de Fábrica: $descText" -Color Cyan
            Write-Centered -Text "Clave BIOS: $biosKey" -Color Green
            Write-Centered -Text "[i] LEYENDA: Las claves inyectadas en BIOS (OEM) provienen del" -Color DarkCyan
            Write-Centered -Text "fabricante del equipo y son licencias genuinas por naturaleza." -Color DarkCyan

            $reportTxt += "Versión de Fábrica: $descText`r`nClave BIOS: $biosKey`r`n[i] LEYENDA: Las claves inyectadas en BIOS (OEM) provienen del fabricante del equipo y son licencias genuinas por naturaleza.`r`n`r`n"
            $reportHtml += "<p>Versión de Fábrica: <strong style='color:#3498db'>$descText</strong></p><p>Clave BIOS: <strong class='ok'>$biosKey</strong></p><p class='info'>[i] LEYENDA: Las claves inyectadas en BIOS (OEM) provienen del fabricante del equipo y son licencias genuinas por naturaleza.</p><hr>"
        }
        
        Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray

        # ---------------------------------------------------------
        # Obtener datos de la Clave Actual (Punto 2 integrado)
        # ---------------------------------------------------------
        Write-Centered -Text "--- CLAVE ACTUAL (OS INSTALADO) ---" -Color Cyan
        
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
        $backupKey = (Get-ItemProperty -Path $regPath -Name BackupProductKeyDefault -ErrorAction SilentlyContinue).BackupProductKeyDefault

        $hexPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
        
        # Corrección WMI:
        $currentEdition = (Get-WmiObject -Class Win32_OperatingSystem -ErrorAction SilentlyContinue).Caption -replace '^Microsoft\s+', ''
        
        $digitalProductId = (Get-ItemProperty -Path $hexPath -Name DigitalProductId -ErrorAction SilentlyContinue).DigitalProductId
        
        $decodedKey = $null
        $isKMSOrDigital = $false

        if ($digitalProductId -ne $null -and $digitalProductId.Length -ge 67) {
            $isWin8Or10 = [math]::Floor($digitalProductId[66] / 6) -band 1
            $digitalProductId[66] = ($digitalProductId[66] -band 0xF7) -bOr (($isWin8Or10 -band 2) * 4)
            $chars = "BCDFGHJKMPQRTVWXY2346789"
            $decodedKeyStr = ""
            for ($i = 24; $i -ge 0; $i--) {
                $current = 0
                for ($j = 14; $j -ge 0; $j--) {
                    $current = $current * 256 + $digitalProductId[$j + 52]
                    $digitalProductId[$j + 52] = [math]::Floor($current / 24)
                    $current = $current % 24
                }
                $decodedKeyStr = $chars[$current] + $decodedKeyStr
                $last = $current
            }
            if ($isWin8Or10 -eq 1) {
                $decodedKeyStr = $decodedKeyStr.Substring(1, $last) + "N" + $decodedKeyStr.Substring($last + 1)
            }
            $decodedKey = $decodedKeyStr.Insert(5, "-").Insert(11, "-").Insert(17, "-").Insert(23, "-")
            
            if ($decodedKey -eq "BBBBB-BBBBB-BBBBB-BBBBB-BBBBB") {
                $decodedKey = $null
                $isKMSOrDigital = $true
            }
        }

        $reportTxt += "--- CLAVE ACTUAL (OS INSTALADO) ---`r`n"
        $reportHtml += "<h3>CLAVE ACTUAL (OS INSTALADO)</h3>"

        $edText = if ([string]::IsNullOrWhiteSpace($currentEdition)) { "Edición Desconocida" } else { $currentEdition }
        Write-Centered -Text "Edición Instalada: $edText" -Color Cyan
        $reportTxt += "Edición Instalada: $edText`r`n"
        $reportHtml += "<p>Edición Instalada: <strong style='color:#3498db'>$edText</strong></p>"

        if ($isKMSOrDigital) {
            Write-Centered -Text "Clave Decodificada: [Oculta por seguridad corporativa]" -Color Yellow
            $reportTxt += "Estado: Clave física oculta (MAK/KMS o Digital).`r`n"
            $reportHtml += "<p class='warn'>Estado: Clave física oculta (MAK/KMS o Digital).</p>"
        } elseif (-not [string]::IsNullOrWhiteSpace($decodedKey)) {
            Write-Centered -Text "Clave Decodificada: $decodedKey" -Color Green
            $reportTxt += "Clave Decodificada: $decodedKey`r`n"
            $reportHtml += "<p>Clave Decodificada: <strong class='ok'>$decodedKey</strong></p>"
        } else {
            Write-Centered -Text "Clave Decodificada: No encontrada" -Color Gray
            $reportTxt += "Clave Decodificada: No encontrada`r`n"
            $reportHtml += "<p>Clave Decodificada: No encontrada</p>"
        }

        if (-not [string]::IsNullOrWhiteSpace($backupKey)) {
            Write-Centered -Text "Clave de Respaldo: $backupKey" -Color DarkCyan
            $reportTxt += "Clave de Respaldo: $backupKey`r`n"
            $reportHtml += "<p>Clave de Respaldo: <strong>$backupKey</strong></p>"
        }

        $reportTxt += "`r`n"
        $reportHtml += "<hr>"
        Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray

        # ---------------------------------------------------------
        # Obtener datos de Originalidad Visual (Punto 3 integrado)
        # ---------------------------------------------------------
        Write-Centered -Text "--- ANÁLISIS DE ORIGINALIDAD ---" -Color Cyan
        $wmiLic = Get-WmiObject -Query "SELECT Description, LicenseStatus FROM SoftwareLicensingProduct WHERE LicenseStatus = 1 AND PartialProductKey IS NOT NULL"
        
        $reportTxt += "--- ANÁLISIS DE ORIGINALIDAD ---`r`n"
        $reportHtml += "<h3>ANÁLISIS DE ORIGINALIDAD</h3>"

        if (-not $wmiLic) {
            Write-Centered -Text "[!] No se detectó ninguna licencia activa en el sistema." -Color Red
            $reportTxt += "Estado: Sin licencia activa.`r`n"
            $reportHtml += "<p class='warn'>Estado: Sin licencia activa.</p>"
        } else {
            foreach ($item in $wmiLic) {
                $cleanDesc = $item.Description -replace '.*, ', ''
                if ($item.Description -match "VOLUME_KMSCLIENT") {
                    Write-Centered -Text "[!] DETECTADO: CANAL KMS ($cleanDesc)" -Color Yellow
                    Write-Centered -Text "[i] LEYENDA: Activación por volumen. Si este equipo no pertenece" -Color DarkCyan
                    Write-Centered -Text "a una empresa, es muy probable que se haya usado un emulador (Pirata)." -Color DarkCyan

                    $reportTxt += "[!] DETECTADO: CANAL KMS ($cleanDesc)`r`n[i] LEYENDA: Activación por volumen. Si este equipo no pertenece a una empresa, es muy probable que se haya usado un emulador (Pirata).`r`n"
                    $reportHtml += "<p class='warn'>[!] DETECTADO: CANAL KMS ($cleanDesc)</p><p class='info'>[i] LEYENDA: Activación por volumen. Si este equipo no pertenece a una empresa, es muy probable que se haya usado un emulador (Pirata).</p>"
                } elseif ($item.Description -match "VOLUME_MAK|RETAIL|OEM") {
                    Write-Centered -Text "[+] DETECTADO: CANAL ORIGINAL ($cleanDesc)" -Color Green
                    Write-Centered -Text "[i] LEYENDA: Se ha comprobado con el motor de licencias de Windows" -Color DarkCyan
                    Write-Centered -Text "que el canal actual es oficial y se encuentra ACTIVADO legalmente." -Color DarkCyan

                    $reportTxt += "[+] DETECTADO: CANAL ORIGINAL ($cleanDesc)`r`n[i] LEYENDA: Se ha comprobado con el motor de licencias de Windows que el canal actual es oficial y se encuentra ACTIVADO legalmente.`r`n"
                    $reportHtml += "<p class='ok'>[+] DETECTADO: CANAL ORIGINAL ($cleanDesc)</p><p class='info'>[i] LEYENDA: Se ha comprobado con el motor de licencias de Windows que el canal actual es oficial y se encuentra ACTIVADO legalmente.</p>"
                } else {
                    Write-Centered -Text "[?] DETECTADO: CANAL DESCONOCIDO ($cleanDesc)" -Color Gray
                    
                    $reportTxt += "[?] DETECTADO: CANAL DESCONOCIDO ($cleanDesc)`r`n"
                    $reportHtml += "<p>[?] DETECTADO: CANAL DESCONOCIDO ($cleanDesc)</p>"
                }
            }
        }
        $reportHtml += "</div></body></html>"
        
    } catch {
        Write-Centered -Text "[X] Error al obtener información del sistema." -Color Red
    }
    
    # Menú de Exportación
    Write-Host "`n----------------------------------------`n" -ForegroundColor DarkGray
    Write-Centered -Text "--- EXPORTAR ESTE REPORTE ---" -Color Yellow
    Write-Centered -Text "[ 1 ] Guardar como Documento de Texto (.txt)" -Color White
    Write-Centered -Text "[ 2 ] Guardar como Página Web (.html)" -Color White
    Write-Centered -Text "[ 0 ] Volver al menú sin guardar" -Color Red
    Write-Host "`n"

    $exportLoop = $true
    while ($exportLoop) {
        $expSel = Read-Host " Seleccione una opción"
        $desktopPath = [Environment]::GetFolderPath("Desktop")
        
        switch ($expSel) {
            '1' {
                $outPath = "$desktopPath\ATLAS_Reporte_Licencias.txt"
                [System.IO.File]::WriteAllText($outPath, $reportTxt)
                Write-Host "`n"
                Write-Centered -Text "[+] Guardado con éxito en su Escritorio:" -Color Green
                Write-Centered -Text "ATLAS_Reporte_Licencias.txt" -Color Gray
                $exportLoop = $false
            }
            '2' {
                $outPath = "$desktopPath\ATLAS_Reporte_Licencias.html"
                [System.IO.File]::WriteAllText($outPath, $reportHtml, [System.Text.Encoding]::UTF8)
                Write-Host "`n"
                Write-Centered -Text "[+] Guardado con éxito en su Escritorio:" -Color Green
                Write-Centered -Text "ATLAS_Reporte_Licencias.html" -Color Gray
                $exportLoop = $false
            }
            '0' {
                $exportLoop = $false
            }
            default {
                Write-Centered -Text "[!] Selección inválida. Intente nuevamente." -Color Red
            }
        }
    }

    Write-Host "`n"
    Write-Centered -Text "Presione ENTER para volver al menú principal..." -Color White
    $null = Read-Host
}

# Bucle principal
$menuLoop = $true
while ($menuLoop) {
    Show-Header
    Write-Centered -Text "M E N U   P R I N C I P A L" -Color Cyan
    Write-Host "`n"
    Write-Centered -Text "[ 1 ] Extraer Clave de Fábrica (BIOS/UEFI)" -Color White
    Write-Centered -Text "[ 2 ] Extraer y Diagnosticar Clave Actual (Registro)" -Color White
    Write-Centered -Text "[ 3 ] Auditoría Nativa y Originalidad (SLMGR)" -Color White
    Write-Centered -Text "[ 4 ] Reporte Completo (OS, BIOS, Actual y Originalidad)" -Color White
    Write-Centered -Text "[ 0 ] Salir" -Color Red
    Write-Host "`n"
    
    $selection = Read-Host " Seleccione una opción"
    
    switch ($selection) {
        '1' { Get-BiosKey }
        '2' { Get-CurrentKey }
        '3' { Invoke-NativeAudit }
        '4' { Get-OsInfo }
        '0' { $menuLoop = $false }
    }
}
}
