# Atlas PC Support

> Panel unificado de herramientas de soporte técnico para Windows, estilo WinUtil.

![License](https://img.shields.io/badge/license-MIT-green)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)
![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6)

Atlas PC Support es un launcher WPF (tema Fluent / Windows 11) que agrupa herramientas de diagnóstico, mantenimiento, redes, seguridad y entrega para técnicos que dan soporte a equipos Windows. Inspirado en [WinUtil de Chris Titus](https://github.com/ChrisTitusTech/winutil).

---

## 🚀 Instalación rápida (una sola línea)

Abre **PowerShell como Administrador** y pega:

```powershell
irm https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1 | iex
```

Eso es todo — no hay que instalar nada más. El launcher se descarga, se ejecuta en memoria y abre el panel.

> 💡 **Actualizaciones automáticas**: cada vez que ejecutas ese comando, se baja la versión más reciente desde GitHub. No hay que "instalar updates".

---

## 🖼 Captura

```
┌──────────────────────────────────────────────────────────────┐
│  ATLAS PC SUPPORT  ·  v1.0    🔍 buscar...   🛡 Admin        │
├──────────────────────────────────────────────────────────────┤
│  [🔍 Diagnóstico] [🛠 Mantenimiento] [📁 Copia] [🌐 Redes]    │
├──────────────────────────────────────────────────────────────┤
│   ┌───────────────────┐  ┌───────────────────┐              │
│   │ 🔍 Fase 0 — IPv6  │  │ 📁 FastCopy       │              │
│   │    Hardening      │  │    Copia multi-   │              │
│   │                   │  │    origen         │              │
│   │ [▶ Ejecutar] 🛡   │  │ [▶ Ejecutar]      │              │
│   └───────────────────┘  └───────────────────┘              │
│   ┌───────────────────┐  ┌───────────────────┐              │
│   │ 🔍 RAM Info       │  │ 🔒 Gestor BitLock │              │
│   │ ...                                                       │
└──────────────────────────────────────────────────────────────┘
```

---

## 📦 Herramientas incluidas (v1.0)

| Categoría | Herramienta | Descripción breve |
|---|---|---|
| 🔒 Seguridad | **Fase 0 — IPv6 Hardening** | Desactiva Teredo, 6to4 e ISATAP. Bitácora exportable. |
| 🔍 Diagnóstico | **RAM Info** | Slots, velocidad, voltaje, XMP, detección soldada. |
| 🛠 Mantenimiento | **Personalización Avanzada** | Wallpaper (API Win32), tema oscuro, acento, barra tareas. |
| 🛠 Mantenimiento | **Stop Services** | Pasa a Manual: telemetría, Xbox, sensores, etc. |
| 📁 Copia | **FastCopy** | Multi-origen, perfiles, MD5, resumen exportable. |
| 📁 Copia | **Robocopy** | Copia optimizada con reintentos y logging central. |
| 🌐 Redes | **Selector DNS** | Cambia DNS: Cloudflare, Google, OpenDNS, custom. |
| 🌐 Redes | **Gestor HOSTS** | Editor con respaldo automático. |
| 🌐 Redes | **Auditoría Router** | Escaneo y auditoría del router local. |
| 🔒 Seguridad | **Gestor BitLocker** | Estado, activación, exportación de claves. |
| 🔒 Seguridad | **Principio Menor Privilegio** | Auditoría de cuentas locales. |
| 🔒 Seguridad | **Extraer Licencias** | Claves de Windows y Office (lectura segura). |
| 📦 Software | **Software Installer** | Panel maestro de `winget`. |
| 📦 Software | **Bundle Atlas** | Pack pre-configurado recomendado. |
| ✅ Entrega | **Entrega PC** | Protocolo de cierre y resumen para el cliente. |

Cada herramienta se ejecuta en su propia ventana de PowerShell para mantener la UX original.

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

📘 Ver detalles en [docs/BRANDING.md](docs/BRANDING.md).

### Idiomas

El panel detecta automáticamente el idioma del sistema. Soportados actualmente:
**español (nativo), inglés, rumano**. Para forzar uno concreto, edita
`branding.json`:

```json
{ "language": "en" }
```

Valores: `"auto"`, `"es"`, `"en"`, `"ro"`. Detalles y cómo añadir otros idiomas
en [docs/LANGUAGES.md](docs/LANGUAGES.md).

---

## 🧑‍💻 Desarrollo local

```powershell
git clone https://github.com/mikepchelper-spec/atlas-pc-support
cd atlas-pc-support
# Ejecutar modo desarrollo (usa src/, sin compilar):
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
├── README.md / LICENSE / .gitignore
├── config/
│   └── tools.json            ← Manifiesto de herramientas (ver abajo).
├── docs/                     ← Guías.
├── src/
│   ├── Launcher.ps1          ← Entry point de desarrollo.
│   ├── lib/                  ← Helpers (Branding, Admin, Logging, Dependencies, ToolRunner).
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
       Read-Host "Presiona Enter para salir"
   }
   ```
2. Añade la entrada en `config/tools.json`:
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

Ver [docs/ADDING-TOOLS.md](docs/ADDING-TOOLS.md) para detalles.

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
