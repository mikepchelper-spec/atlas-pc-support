# Dominio corto propio vía Cloudflare

En lugar de hacer que tus clientes ejecuten:

```powershell
irm https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1 | iex
```

Puedes servirlo bajo **tu dominio** así:

```powershell
irm https://tools.atlaspcsupport.com | iex
```

Gratis, 2 minutos de setup con Cloudflare Workers.

---

## Requisitos previos

1. **Dominio** `atlaspcsupport.com` gestionado en Cloudflare (gratis añadirlo).
2. Cuenta Cloudflare (gratis).

Si tu dominio está en otro registrador (GoDaddy, Namecheap, etc.), basta con
cambiar los nameservers en el registrador por los de Cloudflare (te los dice
Cloudflare al añadir el sitio). Trámite normal de 15 min - 24 h.

---

## Opción recomendada: Cloudflare Worker

### 1. Crear el Worker

1. Cloudflare Dashboard → **Workers & Pages** → **Create application** → **Create Worker**.
2. Nombre sugerido: `atlas-launcher`.
3. Click **Deploy** (acepta el "Hello World" por defecto, lo cambiamos ahora).
4. Click **Edit code**.
5. Borra todo y pega esto:

   ```javascript
   // atlas-launcher — sirve el launcher.ps1 desde GitHub bajo tu dominio.
   // Permite pinnear versión vía ?v=1.2.3 (tag git) o ?ref=branch.

   const DEFAULT_REF = "main";
   const REPO = "mikepchelper-spec/atlas-pc-support";

   export default {
     async fetch(request) {
       const url = new URL(request.url);
       const ref = url.searchParams.get("v")
                 || url.searchParams.get("ref")
                 || DEFAULT_REF;

       const gh = `https://raw.githubusercontent.com/${REPO}/${encodeURIComponent(ref)}/launcher.ps1`;

       const upstream = await fetch(gh, {
         headers: { "User-Agent": "atlas-launcher-worker" },
         cf: { cacheTtl: 300, cacheEverything: true }
       });

       if (!upstream.ok) {
         return new Response(
           `# Atlas launcher: no se pudo obtener '${ref}' (${upstream.status})\n` +
           `Write-Error "Launcher no disponible (ref=${ref})"\n`,
           { status: 502, headers: { "Content-Type": "text/plain; charset=utf-8" } }
         );
       }

       const body = await upstream.text();
       return new Response(body, {
         status: 200,
         headers: {
           "Content-Type": "text/plain; charset=utf-8",
           "Cache-Control": "public, max-age=300",
           "X-Atlas-Source-Ref": ref
         }
       });
     }
   };
   ```

6. **Save and Deploy**.

Ya funciona bajo `atlas-launcher.<tu-subdominio>.workers.dev`. Falta atarlo a tu dominio.

### 2. Ruta personalizada `tools.atlaspcsupport.com`

1. En el Worker → pestaña **Settings** → **Triggers** → **Add Custom Domain**.
2. Escribe `tools.atlaspcsupport.com`.
3. Cloudflare crea el DNS automáticamente y propaga en minutos.

### 3. Comprobar

```powershell
# Ejecutable directo:
irm https://tools.atlaspcsupport.com | iex

# Pinnear versión (cuando hagamos releases con tags):
irm "https://tools.atlaspcsupport.com?v=v1.2.0" | iex

# Probar un branch específico antes de merge:
irm "https://tools.atlaspcsupport.com?ref=devin/alguna-rama" | iex
```

---

## Opción simple: Page Rule con redirect

Si no quieres tocar código de Workers:

1. Cloudflare Dashboard → tu dominio → **Rules** → **Page Rules** → **Create Page Rule**.
2. URL: `tools.atlaspcsupport.com/*`
3. Settings: **Forwarding URL** → **302 Temporary Redirect** →
   `https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/launcher.ps1`
4. Save.

**Contras**:
- Tras el redirect, la barra URL del usuario muestra GitHub (leve pérdida de marca).
- No puedes pinnear versiones con `?v=...`.

---

## Opción avanzada: analítica de uso

Añade un registro a KV storage dentro del Worker:

```javascript
// en fetch():
const country = request.cf?.country || "?";
await env.ATLAS_HITS.put(
  `${new Date().toISOString().slice(0,10)}:${country}`,
  String(((await env.ATLAS_HITS.get(...)) ?? 0) + 1),
  { expirationTtl: 86400 * 90 }  // 90 días
);
```

(Esto requiere crear un KV namespace en Cloudflare y bindearlo al Worker.
Setup 5 min.)

Te da conteo de ejecuciones por país/día sin tocar la app.

---

## Seguridad

El Worker sólo hace **proxy de un archivo público de GitHub** a tu dominio.
No hay credenciales, no hay state, no hay riesgo si el código del Worker se
filtra. Costo: **0 €** para el caso normal (100 000 requests/día gratis en el
plan free de Cloudflare Workers).
