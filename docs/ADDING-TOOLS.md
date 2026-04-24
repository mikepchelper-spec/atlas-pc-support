# Añadir una nueva herramienta

Esta guía explica cómo añadir una herramienta al panel. Toma ~5 minutos.

## 1. Crear el archivo de la herramienta

En `src/tools/`, crea un archivo llamado `Invoke-MiTool.ps1` (prefijo `Invoke-` obligatorio):

```powershell
# ============================================================
# Invoke-MiTool
# Descripción breve de qué hace
# Atlas PC Support — v1.0
# ============================================================

function Invoke-MiTool {
    [CmdletBinding()]
    param()

    # Tu lógica aquí. Puedes usar cualquier cmdlet PowerShell.
    # El Host.UI.RawUI ya tiene título asignado por el launcher.

    Clear-Host
    Write-Host "=== Mi Tool ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Hola desde mi herramienta"
    Write-Host ""
    Read-Host "Presiona Enter para cerrar"
}
```

### Reglas importantes

- ✅ **Nombre del archivo** debe empezar con `Invoke-`.
- ✅ **Nombre de la función** debe coincidir con el archivo.
- ✅ **Todo el código** dentro de la función.
- ❌ **NO incluir auto-elevación** (el launcher lo maneja vía `requiresAdmin` en `tools.json`).
- ❌ **NO usar `exit 0`** — usa `return` (o deja que la función termine naturalmente).
- ❌ **NO usar `#Requires`** — está en el launcher principal.

## 2. Registrar la herramienta en el manifiesto

Edita `config/tools.json` y añade una entrada:

```json
{
  "id": "mi-tool",
  "name": "Mi Tool",
  "description": "Descripción corta que aparece en la tarjeta (máximo ~150 caracteres).",
  "category": "mantenimiento",
  "function": "Invoke-MiTool",
  "source": "MiTool.ps1",
  "requiresAdmin": false,
  "runsInNewWindow": true,
  "dependencies": []
}
```

### Campos

| Campo | Valores | Descripción |
|---|---|---|
| `id` | kebab-case | ID único (sin espacios, en minúsculas). |
| `name` | string | Nombre visible en la tarjeta. |
| `description` | string | Descripción corta (1-2 líneas). |
| `category` | `diagnostico`, `mantenimiento`, `copia`, `redes`, `seguridad`, `software`, `entrega` | Determina pestaña e ícono. |
| `function` | string | Nombre exacto de la función PowerShell a invocar. |
| `source` | string | Nombre del `.ps1` original (informativo). |
| `requiresAdmin` | bool | Si `true`, el launcher eleva al ejecutar. |
| `runsInNewWindow` | bool | Si `true`, abre una nueva ventana de PowerShell. Recomendado para tools TUI. |
| `dependencies` | array | Lista de dependencias externas (`"FastCopy"`, `"winget"`, etc.). |

### Añadir una nueva categoría

Edita `branding.example.json` y `src/lib/Branding.ps1`:

```json
"categories": [
  { "id": "diagnostico", "label": "Diagnóstico", "icon": "🔍", "order": 1 },
  { "id": "nueva-cat",   "label": "Nueva",       "icon": "⭐", "order": 8 }
]
```

## 3. Compilar el launcher

```powershell
pwsh -NoProfile -File build.ps1
```

Esto regenera `launcher.ps1` en la raíz del repo.

## 4. Probar localmente

### Modo desarrollo (sin compilar)

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File src\Launcher.ps1
```

Ventaja: puedes modificar el código y re-ejecutar sin recompilar.

### Modo producción (usa `launcher.ps1` compilado)

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File launcher.ps1
```

## 5. Commit y push

```bash
git add src/tools/Invoke-MiTool.ps1 config/tools.json launcher.ps1
git commit -m "feat: añadir herramienta MiTool"
git push
```

CI regenera `launcher.ps1` automáticamente al recibir el push, así que aunque te olvides del `build.ps1` localmente, el `launcher.ps1` del repo queda actualizado.

## Gestionar dependencias externas

Si tu tool usa un binario externo (p. ej. `CrystalDiskInfo.exe`):

1. Registra la dependencia en `src/lib/Dependencies.ps1`:
   ```powershell
   $script:AtlasDepsRegistry['CrystalDiskInfo'] = @{
       DisplayName    = 'CrystalDiskInfo'
       ExecutableName = 'DiskInfo64.exe'
       WingetId       = 'CrystalDewWorld.CrystalDiskInfo'
       SearchPaths    = @(
           'C:\Program Files\CrystalDiskInfo\DiskInfo64.exe',
           '%LOCALAPPDATA%\AtlasPC\bin\CrystalDiskInfo\DiskInfo64.exe'
       )
   }
   ```

2. Declara la dependencia en `config/tools.json`:
   ```json
   "dependencies": ["CrystalDiskInfo"]
   ```

3. Dentro de tu tool, resuelve la ruta:
   ```powershell
   $exe = Resolve-AtlasDependency -Name 'CrystalDiskInfo' -InstallIfMissing
   if (-not $exe) {
       Write-Host "No se encontró CrystalDiskInfo." -ForegroundColor Red
       return
   }
   & $exe /Json reporte.json
   ```

## Convenciones de código

- **Encoding**: UTF-8 con BOM.
- **Comentarios**: en español, breves.
- **Funciones helper**: ponlas DENTRO de la función `Invoke-XXX`, no en el scope global, para no contaminar el launcher.
- **Variables globales**: evítalas. Si necesitas state compartido, usa `$script:`.
- **Errores**: captúralos con `try/catch` y escribe a log con `Write-AtlasLog`.
- **No uses** `exit`, `$Host.SetShouldExit()`, ni mates procesos del host.
