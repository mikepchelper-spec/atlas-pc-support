# ============================================================
# Invoke-Deduplicador
# Atlas PC Support — v1.0
# ============================================================

function Invoke-Deduplicador {
    [CmdletBinding()]
    param()

    #region ── Inicializacion ─────────────────────────────────────────────────────
    [console]::BackgroundColor = "Black"
    [console]::ForegroundColor = "White"
    Clear-Host

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
    $lang = _Atlas-DetectLang
    $es   = ($lang -eq 'es')

    $T = @{
        Title       = if ($es) { "Deduplicador Visual Web" } else { "Visual Web Deduplicator" }
        Opt1        = if ($es) { " [1] Iniciar Servidor Deduplicador Web y Abrir Navegador" } else { " [1] Start Web Deduplicator Server & Open Browser" }
        Opt2        = if ($es) { " [2] Detener Servidor Deduplicador Activo (DeduplicadorServer)" } else { " [2] Stop Active Deduplicator Server (DeduplicadorServer)" }
        Opt0        = if ($es) { " [0] Volver al Menú Principal / Salir" } else { " [0] Back to Main Menu / Exit" }
        Prompt      = if ($es) { "Elige una opción (0-2): " } else { "Choose an option (0-2): " }
        FolderP     = if ($es) { " Carpeta a escanear [D:\0.MULTIMEDIA\memes]: " } else { " Folder to scan [D:\0.MULTIMEDIA\memes]: " }
        Checking    = if ($es) { " [>] Verificando dependencias de Python..." } else { " [>] Checking Python dependencies..." }
        PyErr       = if ($es) { " [ERROR] Python no está instalado o no se encuentra en el PATH." } else { " [ERROR] Python is not installed or not found in PATH." }
        PyHint      = if ($es) { " Descárgalo e instálalo desde python.org y activa 'Add python.exe to PATH'." } else { " Download and install it from python.org and select 'Add python.exe to PATH'." }
        PillInstall = if ($es) { " [i] Pillow no está instalado. Instalándolo vía pip..." } else { " [i] Pillow is not installed. Installing via pip..." }
        ScNotF      = if ($es) { " [!] No se pudo encontrar 'app_deduplicar.py' automáticamente." } else { " [!] Could not locate 'app_deduplicar.py' automatically." }
        ScPrompt    = if ($es) { " Ingrese la ruta completa de app_deduplicar.py: " } else { " Enter the full path of app_deduplicar.py: " }
        Starting    = if ($es) { " [>] Iniciando servidor en segundo plano..." } else { " [>] Starting server in background..." }
        Started     = if ($es) { " [OK] Servidor iniciado. Abriendo navegador predeterminado..." } else { " [OK] Server started. Opening default browser..." }
        Stopping    = if ($es) { " [>] Deteniendo servidores activos..." } else { " [>] Stopping active servers..." }
        Stopped     = if ($es) { " [OK] Servidor(es) detenido(s) con éxito." } else { " [OK] Server(s) successfully stopped." }
        Next        = if ($es) { " Presiona cualquier tecla para continuar..." } else { " Press any key to continue..." }
    }
    #endregion

    while ($true) {
        Clear-Host
        Write-Host ''
        Write-Host '============================================================' -ForegroundColor Orange
        Write-Host "         ATLAS PC SUPPORT - $($T.Title)" -ForegroundColor Orange
        Write-Host '============================================================' -ForegroundColor Orange
        Write-Host ''
        Write-Host $T.Opt1 -ForegroundColor White
        Write-Host $T.Opt2 -ForegroundColor White
        Write-Host ''
        Write-Host $T.Opt0 -ForegroundColor DarkGray
        Write-Host ''

        $opt = Read-Host $T.Prompt
        if ($opt -eq '0') {
            break
        }
        elseif ($opt -eq '1') {
            # 1. Verificar Python
            Write-Host ''
            Write-Host $T.Checking -ForegroundColor Cyan
            $pythonCheck = Get-Command python -ErrorAction SilentlyContinue
            if (-not $pythonCheck) {
                Write-Host $T.PyErr -ForegroundColor Red
                Write-Host $T.PyHint -ForegroundColor Yellow
                Write-Host ''
                Read-Host $T.Next
                continue
            }

            # Verificar Pillow
            python -c "from PIL import Image" 2>$null
            if ($LASTEXITCODE -ne 0) {
                Write-Host $T.PillInstall -ForegroundColor Cyan
                pip install Pillow
            }

            # 2. Localizar app_deduplicar.py
            $possiblePaths = @(
                "D:\1.ATLASPCSUPPORT\MANUALES\ATLAS PC SUPPORT\SERVICIOS FUNCIONALES\IMMICH\scripts\app_deduplicar.py",
                "C:\1.ATLASPCSUPPORT\MANUALES\ATLAS PC SUPPORT\SERVICIOS FUNCIONALES\IMMICH\scripts\app_deduplicar.py",
                (Join-Path $PSScriptRoot "app_deduplicar.py"),
                (Join-Path $PSScriptRoot "scripts\app_deduplicar.py"),
                (Join-Path (Split-Path -Parent $PSScriptRoot) "scripts\app_deduplicar.py"),
                (Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) "scripts\app_deduplicar.py"),
                (Join-Path (Get-Location).Path "scripts\app_deduplicar.py"),
                (Join-Path (Get-Location).Path "app_deduplicar.py")
            )
            $scriptPath = $null
            foreach ($p in $possiblePaths) {
                if (Test-Path -LiteralPath $p) {
                    $scriptPath = (Resolve-Path -LiteralPath $p).Path
                    break
                }
            }
            if (-not $scriptPath) {
                Write-Host $T.ScNotF -ForegroundColor Yellow
                $scriptPath = Read-Host $T.ScPrompt
                if (-not (Test-Path -LiteralPath $scriptPath)) {
                    Write-Host " [ERROR] Archivo no encontrado en la ruta especificada." -ForegroundColor Red
                    Write-Host ''
                    Read-Host $T.Next
                    continue
                }
            }

            # 3. Solicitar carpeta a escanear
            $folderPath = Read-Host $T.FolderP
            if ([string]::IsNullOrWhiteSpace($folderPath)) {
                $folderPath = "D:\0.MULTIMEDIA\memes"
            }

            # Validar que exista la carpeta
            if (-not (Test-Path -Path $folderPath)) {
                Write-Host " [ERROR] La carpeta especificada no existe: $folderPath" -ForegroundColor Red
                Write-Host ''
                Read-Host $T.Next
                continue
            }

            # 4. Iniciar Servidor
            Write-Host $T.Starting -ForegroundColor Cyan
            $normalizedFolder = $folderPath -replace '\\', '/'
            
            # Detener antes si hay uno corriendo
            taskkill /f /fi "windowtitle eq DeduplicadorServer" 2>$null | Out-Null
            
            # Lanzar cmd con título e iniciar python de forma minimizada
            Start-Process cmd.exe -ArgumentList "/c title DeduplicadorServer && python `"$scriptPath`" `"$normalizedFolder`"" -WindowStyle Minimized
            
            Write-Host $T.Started -ForegroundColor Green
            Write-Host ''
            Read-Host $T.Next
        }
        elseif ($opt -eq '2') {
            Write-Host ''
            Write-Host $T.Stopping -ForegroundColor Cyan
            taskkill /f /fi "windowtitle eq DeduplicadorServer" 2>$null | Out-Null
            Write-Host $T.Stopped -ForegroundColor Green
            Write-Host ''
            Read-Host $T.Next
        }
    }
}
