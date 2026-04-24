# Personalización de marca (branding)

El panel Atlas PC Support permite **personalizar completamente la marca visible**: nombre, colores, logo, tagline, copyright, etc. Esto es útil para:

- **Técnicos individuales** que quieren usar su propia identidad.
- **Empresas de soporte** que revenden el panel a clientes con sus colores corporativos.
- **Consultoras** que configuran una versión interna específica.

## Cómo funciona

El launcher lee un archivo `branding.json` en tiempo de ejecución. Si lo encuentra, fusiona sus valores con los valores por defecto. Si no, usa el branding Atlas estándar.

### Rutas donde se busca `branding.json`

En este orden:

1. `branding.json` junto al `launcher.ps1` (mismo directorio).
2. `%LOCALAPPDATA%\AtlasPC\branding.json` (específico del usuario).
3. `%APPDATA%\AtlasPC\branding.json` (roaming del usuario).

El primero que exista se usa.

## Archivo de ejemplo

```json
{
  "brand": {
    "name": "SOPORTE PREMIUM 24/7",
    "shortName": "SP24",
    "tagline": "Soporte técnico premium para empresas",
    "version": "1.0.0",
    "companyUrl": "https://soportepremium.com",
    "supportEmail": "soporte@soportepremium.com",
    "copyright": "© 2026 Soporte Premium SL"
  },
  "theme": {
    "accentColor": "#0078D4",
    "darkMode": false,
    "useSystemAccent": false,
    "cornerRadius": 4,
    "fontFamily": "Segoe UI Variable"
  },
  "window": {
    "title": "Soporte Premium · Panel Cliente v1.0",
    "width": 1200,
    "height": 800,
    "minWidth": 900,
    "minHeight": 600,
    "showSearch": true,
    "showFooter": true
  },
  "behavior": {
    "autoElevate": true,
    "logPath": "%LOCALAPPDATA%\\SP24\\logs",
    "dependenciesPath": "%LOCALAPPDATA%\\SP24\\bin",
    "defaultCategory": "Diagnóstico",
    "confirmBeforeRun": true
  },
  "categories": [
    { "id": "diagnostico",    "label": "Diagnóstico",     "icon": "🔍", "order": 1 },
    { "id": "mantenimiento",  "label": "Mantenimiento",   "icon": "🛠", "order": 2 },
    { "id": "copia",          "label": "Copia",           "icon": "📁", "order": 3 },
    { "id": "redes",          "label": "Redes",           "icon": "🌐", "order": 4 },
    { "id": "seguridad",      "label": "Seguridad",       "icon": "🔒", "order": 5 },
    { "id": "software",       "label": "Software",        "icon": "📦", "order": 6 },
    { "id": "entrega",        "label": "Entrega",         "icon": "✅", "order": 7 }
  ]
}
```

## Campos disponibles

### `brand`

| Campo | Tipo | Descripción |
|---|---|---|
| `name` | string | Nombre visible en header. |
| `shortName` | string | Nombre corto (títulos de ventanas de tools). |
| `tagline` | string | Subtítulo bajo el nombre. |
| `version` | string | Versión visible en footer. |
| `companyUrl` | string | URL del botón "Acerca de". |
| `supportEmail` | string | Email de soporte (opcional). |
| `copyright` | string | Texto legal en el footer. |

### `theme`

| Campo | Tipo | Descripción |
|---|---|---|
| `accentColor` | `#RRGGBB` | Color principal (botones, pills, acentos). |
| `darkMode` | bool | `true` = oscuro, `false` = claro. |
| `useSystemAccent` | bool | Ignora `accentColor` y usa el color del sistema. |
| `cornerRadius` | int | Radio de esquinas redondeadas (0 = cuadrado). |
| `fontFamily` | string | Fuente por defecto. Usa `Segoe UI Variable` en Windows 11. |

### `window`

| Campo | Tipo | Descripción |
|---|---|---|
| `title` | string | Título de la ventana. |
| `width` / `height` | int | Tamaño inicial. |
| `minWidth` / `minHeight` | int | Tamaño mínimo. |
| `showSearch` | bool | Mostrar barra de búsqueda. |
| `showFooter` | bool | Mostrar footer con copyright. |

### `behavior`

| Campo | Tipo | Descripción |
|---|---|---|
| `autoElevate` | bool | Auto-elevar a admin al abrir. |
| `logPath` | string | Ruta de logs (acepta variables `%LOCALAPPDATA%`, etc.). |
| `dependenciesPath` | string | Ruta de binarios descargados. |
| `defaultCategory` | string | Categoría seleccionada al abrir. |
| `confirmBeforeRun` | bool | Pedir confirmación antes de lanzar una tool. |

### `categories`

Array de categorías visibles en las pestañas. Reemplaza las por defecto. Cada una tiene `id`, `label`, `icon` (emoji o texto), `order`.

## Recetas rápidas

### Cambiar sólo el color

```json
{ "theme": { "accentColor": "#FF0055" } }
```

Los demás valores se mantienen por defecto.

### Marca totalmente distinta + modo claro

```json
{
  "brand": { "name": "PCFixers", "copyright": "© PCFixers 2026" },
  "theme": { "accentColor": "#22C55E", "darkMode": false, "cornerRadius": 8 },
  "window": { "title": "PCFixers Panel" }
}
```

### Revendedor que distribuye a sus clientes

1. Crea un `branding.json` con la marca del cliente.
2. Colócalo junto a `launcher.ps1` en el pack que entregas.
3. El cliente ejecuta `launcher.ps1` y ve su marca.

## Valores por defecto

Todos los valores por defecto están codificados en `src/lib/Branding.ps1`. El hash-merge respeta los valores que tú defines y completa el resto. Por ejemplo, si sólo defines `brand.name`, el resto del objeto `brand` se rellena con los valores Atlas.
