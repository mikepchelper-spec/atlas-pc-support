@echo off
setlocal
chcp 65001 >nul
title Atlas PC Support - Instalador de Acceso Remoto

REM ============================================================
REM Atlas PC Support - RustDesk onboarding installer (.bat wrapper)
REM
REM This file is a thin wrapper. The real PowerShell installer
REM lives in the PRIVATE handoff repo and is served via a
REM Cloudflare Worker that injects a GitHub PAT.
REM
REM Public URL (what clients hit):
REM   https://toolspanel.atlaspcsupport.com/install.ps1
REM
REM Source of this .bat:
REM   https://github.com/mikepchelper-spec/atlas-pc-support
REM
REM Usage (technician-side, during a one-shot AnyDesk session):
REM   1. Open the client's web browser.
REM   2. Visit:
REM        https://toolspanel.atlaspcsupport.com/install.bat
REM   3. Save and double-click the file.
REM   4. Accept the Windows SmartScreen warning ("More info" -> "Run anyway").
REM   5. Accept UAC.
REM   6. Wait ~60-90 seconds. A window will pop up with the
REM      ID and password generated for this PC.
REM   7. Copy them into Vaultwarden + RustDesk API Admin.
REM ============================================================

REM ---- Self-elevate to administrator -------------------------
fltmc >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo Este instalador requiere permisos de administrador.
    echo Solicitando elevacion...
    echo.
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo ================================================================
echo   ATLAS PC SUPPORT - Instalador de Acceso Remoto (RustDesk)
echo ================================================================
echo.
echo   Este proceso tarda 1-2 minutos. No cierre esta ventana.
echo.
echo   Pasos:
echo     [1/4] Descargando la ultima version de RustDesk
echo     [2/4] Instalando como servicio de Windows
echo     [3/4] Aplicando configuracion del servidor Atlas
echo     [4/4] Generando contrasena unica para esta PC
echo.

REM ---- Run the PowerShell installer (served by CF Worker) -----
REM The Worker fetches install-rustdesk.ps1 from the PRIVATE repo
REM (atlas-pc-support-handoff) using a GitHub PAT stored as a
REM Worker secret. See docs/CLOUDFLARE-DOMAIN.md.
set "PS_URL=https://toolspanel.atlaspcsupport.com/install.ps1"

powershell -NoProfile -ExecutionPolicy Bypass -Command "& {Set-ExecutionPolicy Bypass -Scope Process -Force; iex (iwr -UseBasicParsing -Uri '%PS_URL%').Content}"

set "RC=%errorlevel%"
echo.
if %RC% neq 0 (
    echo.
    echo ================================================================
    echo   ERROR
    echo ================================================================
    echo   La instalacion fallo con codigo %RC%.
    echo   Por favor, contacte con su tecnico de Atlas PC Support.
    echo.
)
echo.
echo Pulse cualquier tecla para cerrar esta ventana...
pause >nul
endlocal & exit /b %RC%
