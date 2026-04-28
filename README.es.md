# Atlas PC Support

> Panel unificado de herramientas de soporte técnico para Windows, estilo WinUtil.

**🌐 Idioma: [English](README.md) | Español**

![License](https://img.shields.io/badge/license-MIT-green)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)
![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6)
[![Buy me a coffee](https://img.shields.io/badge/PayPal-Buy%20me%20a%20coffee-ffdd00?logo=paypal&logoColor=white)](https://www.paypal.me/atlaspcsupport)

Atlas PC Support es un launcher WPF (tema Fluent / Windows 11) que agrupa herramientas de diagnóstico, mantenimiento, redes, seguridad y entrega para técnicos que dan soporte a equipos Windows. Inspirado en [WinUtil de Chris Titus](https://github.com/ChrisTitusTech/winutil).

---

## 🚀 Instalación rápida (una sola línea)

Abre **PowerShell como Administrador** y pega:

```powershell
irm https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1 | iex
```

Eso es todo — no hay que instalar nada más. El launcher se descarga, se ejecuta en memoria y abre el panel.

> 💡 **Actualizaciones automáticas**: cada vez que ejecutas ese comando, se baja la versión más reciente desde GitHub. No hay que "instalar updates".

Si tu sesión de PowerShell muestra un error `﻿#: The term '﻿#' …` al inicio (un BOM UTF-8 que mete algún proxy local o antivirus), usa esta variante tolerante al BOM:

```powershell
iex ((irm "https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1?v=$(Get-Random)") -replace '^\uFEFF','')
```

---

## 🖼 Captura

![Panel Atlas PC Support](docs/img/panel-screenshot.png)

Sobre la rejilla de herramientas hay un dashboard en vivo (CPU / RAM / Disco + alertas) y un panel lateral con los datos del equipo (hostname, usuario, build de Windows, modelo de CPU, RAM total, uptime, IP local) siempre visible.

---

## 📦 Herramientas incluidas (v1.0)

El panel viene con **19 herramientas** organizadas en 7 categorías. Cada herramienta se ejecuta en su propia ventana de PowerShell para mantener la UX original.

### 🔍 Diagnóstico

| Herramienta | Descripción |
|---|---|
| **Parts Upgrade Advisor** | Analiza RAM, CPU (socket / BGA) y almacenamiento (NVMe / SATA / M.2). Recomendaciones de compra y avisos. |
| **Full System Report** | Reporte HTML integral: sistema, hardware, CPU, RAM, almacenamiento, red, batería, BSOD y Upgrade Advisor. |
| **Event Log Analyzer** | Lee el Visor de eventos e interpreta errores: reinicios, hardware (WHEA / disco), crashes, drivers, seguridad. Exporta HTML. |

### 🛠 Mantenimiento

| Herramienta | Descripción |
|---|---|
| **Deep Clean & Repair** | Suite de mantenimiento completa: Defender, limpieza, DISM / SFC, reparación del sistema y reporte final. |
| **Install/Update PowerShell 7** | Instala o actualiza PowerShell 7 (runtime moderno). Mejor encoding, enums modernos y menos bugs que Windows PowerShell 5.1. |
| **Windows Tweaks** | Wallpaper vía API Win32, modo oscuro, color de acento, ajustes de barra de tareas y marca de agua. |
| **Service Optimizer** | Detiene y pasa a Manual servicios no esenciales: telemetría, Xbox, sensores, fax, etc. |

### 📁 Backup & Sync

| Herramienta | Descripción |
|---|---|
| **FastCopy** | Copia multi-origen con perfiles, comparación, MD5 y resumen exportable. Mejor UX que Robocopy. |
| **Build Offline USB** | Copia el panel y sus dependencias a un USB para uso offline. Auto-actualiza el launcher cuando hay conexión. |
| **Robocopy Mirror** | Copia optimizada vía robocopy: modo espejo, reintentos y logging centralizado. |

### 🌐 Redes

| Herramienta | Descripción |
|---|---|
| **DNS Switcher** | Cambia el DNS entre perfiles (Cloudflare, Google, OpenDNS, custom) con un click. Incluye test de latencia y toggle DoH. |
| **Hosts File Editor** | Editor del archivo HOSTS de Windows con respaldo automático, importación de la lista Steven Black y revert. |
| **Router Security Audit** | Escaneo y auditoría del router local (port scan al gateway, ARP, contraseñas Wi-Fi). |

### 🔒 Seguridad

| Herramienta | Descripción |
|---|---|
| **Disable Legacy IPv6 Tunnels** | Hardening inicial: desactiva Teredo, 6to4 e ISATAP. Bitácora técnica exportable. |
| **BitLocker Manager** | Estado de BitLocker, activación, suspensión y exportación de claves de recuperación. |
| **Local Account Hardening** | Audita y aplica el principio de mínimo privilegio a las cuentas locales. |
| **Extract Product Keys** | Extrae las claves de Windows y Office (sólo lectura, seguro). |

### 📦 Software

| Herramienta | Descripción |
|---|---|
| **Bulk App Installer (winget)** | Instalación masiva de software vía winget. Catálogo curado por categoría, perfiles JSON por cliente, búsqueda integrada en winget y sección de Cleanup (limpieza de temporales). |

### ✅ Entrega

| Herramienta | Descripción |
|---|---|
| **PC Handover Report** | Protocolo de cierre: renombrar PC, limpieza final, reporte HTML con branding (resumen del sistema + checklist de entrega + impresión a PDF). |

---

## 🌍 Idiomas

El panel detecta tu idioma del sistema automáticamente y trae traducciones completas para:

**Inglés (default), Español, Portugués, Francés, Alemán, Italiano, Rumano.**

Puedes cambiar el idioma en caliente desde el dropdown del header. Para forzar uno específico, edita `branding.json`:

```json
{ "language": "es" }
```

Valores válidos: `"auto"`, `"en"`, `"es"`, `"pt"`, `"fr"`, `"de"`, `"it"`, `"ro"`. Detalles y cómo añadir más en [docs/LANGUAGES.md](docs/LANGUAGES.md).

---

## 🎨 Personalizar la marca (branding)

El panel acepta **un archivo `branding.json`** con tu propia marca: nombre, logo, colores, tagline, copyright, etc. Ideal si revendes o configuras el panel para un cliente específico.

Copia `branding.example.json` a `branding.json` y edítalo:

```json
{
  "brand": {
    "name": "TU EMPRESA DE SOPORTE",
    "tagline": "Soporte técnico para pymes",
    "companyUrl": "https://miempresa.com",
    "copyright": "© 2026 Mi Empresa"
  },
  "theme": {
    "accentColor": "#0078D4",
    "darkMode": false,
    "cornerRadius": 4
  },
  "window": {
    "title": "Panel Mi Empresa v1.0"
  }
}
```

Rutas donde el launcher busca `branding.json` (en orden):

1. `branding.json` junto al `launcher.ps1` (repo local).
2. `%LOCALAPPDATA%\AtlasPC\branding.json` (perfil del usuario).
3. `%APPDATA%\AtlasPC\branding.json`.

Si no existe, se usa el branding Atlas por defecto.

📘 Detalles completos en [docs/BRANDING.md](docs/BRANDING.md).

### Dominio corto propio

Si tienes tu propio dominio, puedes servir el launcher como `tools.tudominio.com` con Cloudflare Workers (gratis, ~10 min de setup). Instrucciones paso a paso en [docs/CLOUDFLARE-DOMAIN.md](docs/CLOUDFLARE-DOMAIN.md).

---

## 🧑‍💻 Desarrollo local

```powershell
git clone https://github.com/mikepchelper-spec/atlas-pc-support
cd atlas-pc-support

# Modo desarrollo (usa src/, sin compilar):
pwsh -NoProfile -ExecutionPolicy Bypass -File src\Launcher.ps1

# O compilar el launcher distribuible:
pwsh -NoProfile -File build.ps1
# Esto regenera launcher.ps1 (raíz del repo) con todo embebido.
```

### Estructura del repo

```
atlas-pc-support/
├── launcher.ps1              ← Compilado. Es lo que descarga `irm | iex`.
├── build.ps1                 ← Regenera launcher.ps1 desde src/.
├── branding.example.json     ← Plantilla de branding personalizado.
├── README.md / README.es.md  ← Docs en inglés / español.
├── LICENSE / .gitignore
├── config/
│   └── tools.json            ← Manifiesto de herramientas (ver "Añadir tool").
├── docs/                     ← Guías + capturas.
├── src/
│   ├── Launcher.ps1          ← Entry point de desarrollo.
│   ├── lib/                  ← Helpers (Branding, Admin, Logging, Dependencies, ToolRunner, PS7).
│   ├── gui/                  ← XAML + código de la GUI WPF.
│   └── tools/                ← Una herramienta por archivo (`Invoke-XXX.ps1`).
└── .github/workflows/        ← CI que rebuildea launcher.ps1 en cada push.
```

### Añadir una nueva herramienta

1. Crea `src/tools/Invoke-MiTool.ps1`:
   ```powershell
   function Invoke-MiTool {
       [CmdletBinding()] param()
       Write-Host "Hola desde MiTool"
       Read-Host "Presiona ENTER para salir"
   }
   ```
2. Regístrala en `config/tools.json`:
   ```json
   {
     "id": "mi-tool",
     "name": "Mi Tool",
     "description": "Descripción corta (máx. ~150 caracteres).",
     "category": "mantenimiento",
     "function": "Invoke-MiTool",
     "source": "MiTool.ps1",
     "requiresAdmin": false,
     "runsInNewWindow": true,
     "dependencies": []
   }
   ```
3. Ejecuta `pwsh -File build.ps1`.
4. Commit y push — CI regenera `launcher.ps1` automáticamente.

Ver [docs/ADDING-TOOLS.md](docs/ADDING-TOOLS.md) para la referencia completa.

---

## 📋 Logs y dependencias

- **Logs**: `%LOCALAPPDATA%\AtlasPC\logs\atlas-YYYY-MM-DD.log`.
- **Binarios externos** (FastCopy.exe, etc.): se descargan bajo demanda a `%LOCALAPPDATA%\AtlasPC\bin\`.
- **Datos de clientes / reportes**: se guardan en `%USERPROFILE%\Documents\AtlasPC\` y NUNCA se suben al repo.

---

## 🛡 Requisitos

- Windows 10 / 11 (x64).
- PowerShell 5.1 (incluido en Windows) o PowerShell 7.
- Ejecutar **como Administrador** para aprovechar todas las herramientas.

---

## 📄 Licencia

[MIT](LICENSE). Puedes usarlo, modificarlo y redistribuirlo libremente, incluso comercialmente. Solo mantén el aviso de copyright.

---

## 🙋 Soporte

Si eres técnico profesional y quieres:

- **Versión personalizada con tu marca** (logo, colores, herramientas específicas de tu empresa).
- **Soporte premium por email**.
- **Bundle pre-configurado** para empresas de 10+ PCs.

Visita [atlaspcsupport.com](https://atlaspcsupport.com) o abre un issue.

---

## 🙏 Agradecimientos

- [Chris Titus Tech · WinUtil](https://github.com/ChrisTitusTech/winutil) — inspiración y arquitectura.
- [ModernWpfUI](https://github.com/Kinnara/ModernWpf) — referencia de estilos Fluent.
- La comunidad de PowerShell.
