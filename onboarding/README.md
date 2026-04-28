# Atlas PC Support — RustDesk onboarding installer

A two-file kit that installs RustDesk on a new client's PC, pre-configured to point at Atlas's self-hosted server (`rustdesk.atlaspcsupport.com`), with a unique random permanent password generated per machine.

> **Important**: this is intended to be run **by the technician** during a one-shot AnyDesk session (or in person). It is *not* friction-free for an end-user to run cold — it shows a UAC prompt, a Windows SmartScreen warning, and a console window. The technician guides the client through it.

## Files

| File | What it does |
|---|---|
| `install.bat` | Tiny wrapper. Self-elevates to admin and downloads + runs the PS script. **This is the file you give the client.** |
| `install-rustdesk.ps1` | Real installer. Detects arch, downloads latest RustDesk, installs as service, applies Atlas config, generates a unique 16-char password, displays a popup with copy buttons. |

## Recommended workflow (Option H — assisted via AnyDesk)

1. Client calls / WhatsApp: *"quiero contratar Soporte Premium"*.
2. Send them a one-shot **AnyDesk** session (free for personal use). Ask them to install AnyDesk, give you their 9-digit code.
3. Connect to their PC. Open their browser. Go to:
   ```
   https://atlaspcsupport.com/install.bat
   ```
   *(or, if you haven't set up the Cloudflare pretty alias yet:)*
   ```
   https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/onboarding/install.bat
   ```
4. Save the file → double-click → "More info" → "Run anyway" → UAC → wait ~60-90 seconds.
5. A WinForms popup appears with the **ID** and **Password** for this PC. Hit `Copiar`, paste into Vaultwarden + RustDesk API Admin.
6. Close popup → close AnyDesk → done.

Total: 5 minutes per client. Zero friction for the client (you do everything via AnyDesk).

A backup copy of the credentials is also written to:
```
C:\ProgramData\Atlas\rustdesk-onboarding-<timestamp>.txt
```

## One-time setup before using this in production

The PS script needs **your** RustDesk Server Config string before it can configure new clients. Steps:

1. Open RustDesk on your master PC.
2. Settings → Network → "Unlock" (gear icon).
3. Click **"Export Server Config"** — the encoded string is copied to your clipboard.
4. Open `install-rustdesk.ps1` and paste it into:
   ```powershell
   $AtlasRustDeskConfig = '<<PASTE-EXPORTED-CONFIG-HERE>>'
   ```
5. Commit + push.

> **Why the placeholder?** The exported config string contains your hbbs public key. The key is *technically* public, but committing it tags it to your real domain and infra in a public repo. If you'd rather keep the string out of the public repo, fork this folder into your private `atlas-pc-support-handoff` repo and update the URL in `install.bat` to point there.

### Alternative (no Server Config export)

If you can't or don't want to use `--config`, set the **fallback** variables inside `install-rustdesk.ps1`:

```powershell
$AtlasIdServer    = 'rustdesk.atlaspcsupport.com'
$AtlasRelayServer = 'rustdesk.atlaspcsupport.com'
$AtlasApiServer   = ''               # optional
$AtlasPublicKey   = 'XXXXXX...UR24=' # ed25519 pubkey from /var/lib/docker/volumes/.../id_ed25519.pub on Oracle
```

When `$AtlasRustDeskConfig` is left as the placeholder, the script writes a `RustDesk2.toml` directly to `C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config\` (which is where the service-mode RustDesk reads its config from on Windows).

## Optional — Cloudflare pretty alias (`atlaspcsupport.com/install.bat`)

The repo's existing Cloudflare worker (see [docs/CLOUDFLARE-DOMAIN.md](../docs/CLOUDFLARE-DOMAIN.md)) routes `atlaspcsupport.com/launcher.ps1` to GitHub raw. Add a sister route for the installer:

```js
// Inside the worker:
if (url.pathname === '/install.bat') {
  return fetch('https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/onboarding/install.bat');
}
if (url.pathname === '/install-rustdesk.ps1') {
  return fetch('https://raw.githubusercontent.com/mikepchelper-spec/atlas-pc-support/main/onboarding/install-rustdesk.ps1');
}
```

After deploying, the URL the client sees is:

```
https://atlaspcsupport.com/install.bat
```

## Security notes

- The **public ed25519 key** of your hbbs is, by design, public. Distributing it via a pre-configured installer is *not* a security risk — it lets clients verify they're talking to the real Atlas server, nothing more. The matching **private key** never leaves `/var/lib/docker/volumes/.../id_ed25519` on your Oracle ARM.
- **Each client gets a unique random 16-character password.** Never reuse a password across clients. If one is compromised, only that client is affected and you can rotate it on a new visit.
- The recovery file at `C:\ProgramData\Atlas\rustdesk-onboarding-*.txt` contains the password in plain text. This is fine while you're on the machine in the same session — but consider deleting it via Atlas's `EntregaPC` checklist before handover, or include it in your standard PC-handover delivery routine.

## Future integration with Atlas (Phase 2)

When [Tool C — RustDesk integrado](../) lands in the panel, this folder becomes redundant: Atlas will run the same logic from a button click in the GUI, plus auto-upload credentials to Vaultwarden and auto-register the machine in RustDesk API Admin. Until then, this installer + manual paste into Vaultwarden is the bridge.

## Troubleshooting

| Symptom | Probable cause | Fix |
|---|---|---|
| `ERROR: Onboarding aborted: missing server config.` | You haven't filled `$AtlasRustDeskConfig` or `$AtlasPublicKey` | Do the one-time setup above. |
| Popup never appears, console exits with `cannot find rustdesk.exe` | RustDesk silent installer was blocked by AV | Whitelist temp dir + retry, or install RustDesk first manually then re-run the PS script. |
| `--get-id` returns empty | Service still booting, or RustDesk 1.4.6+ broke the flag | The script retries 6 times with 4s sleep. If still empty, open RustDesk GUI to read the ID — it's there. The installer log shows `(no detectado - abrir RustDesk para verlo)` in this case. |
| SmartScreen blocks the .bat | Expected — file is unsigned. | Click "More info" → "Run anyway". Or buy a code-signing cert (~€25/year via Certum) and sign the .bat to remove the warning permanently. |
| Custom architecture (ARM64 Surface Pro X, etc.) | The script auto-detects via `$env:PROCESSOR_ARCHITECTURE` and downloads `aarch64`. If that asset is missing in the latest release, the script will throw. | Wait for next RustDesk release that includes ARM64 binaries. |
