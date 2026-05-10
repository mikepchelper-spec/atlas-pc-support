# AI Readiness Assessment

AI Readiness Assessment is a native, self-contained PowerShell tool for the Atlas PC Support panel. It replaces the previous wrapper-only integration that expected an external `AI-Readiness.ps1` file to exist on the technician PC.

## Purpose

Use it when a customer asks whether their PC is suitable for local AI tools, Ollama/GGUF models, or cloud AI workflows.

The goal is a practical technician verdict before promising an AI setup or a performance improvement:

- **READY / APTO**
- **LIMITED / LIMITADO**
- **NOT READY / NO APTO**

The report also recommends the most realistic mode:

- Local GPU models.
- CPU GGUF / small local models.
- Cloud AI first.
- Not recommended without upgrades.

## Checks

The audit is read-only and dependency-free. It checks:

- RAM capacity.
- CPU cores, logical processors and a short synthetic CPU benchmark.
- GPU inventory, reported VRAM, driver date/status and optional `nvidia-smi` details when available.
- Storage type and health via `Get-PhysicalDisk` or WMI fallback.
- Local AI stack presence: Ollama, Python and winget.
- Basic connectivity to Ollama.com, Hugging Face and OpenAI API.
- Suggested Ollama models and copy/paste `ollama pull` commands based on detected RAM/VRAM.
- Previous-scan delta for the same client.

## Reports

Reports are written under:

```text
Desktop\REPORTES_PC\AIReadiness\<ClientName>\
```

Files:

- `report.html` — latest customer-facing report.
- `report.json` — latest machine-readable baseline used for delta comparison.
- `report-YYYYMMDD-HHMMSS.html` — timestamped copy.

## Safety model

AI Readiness Assessment is read-only:

- It does not install Ollama.
- It does not download AI models.
- It does not change drivers, services, registry or firewall rules.
- It only opens the generated HTML report after completion.

Some details may be richer when running as Administrator, but admin is not required for the default audit.

## Offline USB

`Build Offline USB` copies the compiled `launcher.ps1`. Because AI Readiness Assessment is now fully embedded in `src/tools/Invoke-AIReadiness.ps1` and then in the compiled launcher, preparing or updating an offline USB includes it automatically.

To refresh an existing USB:

1. Open the panel from a PC with internet.
2. Run **Build Offline USB**.
3. Select the same USB.
4. Choose update/overwrite when prompted.

## Integration

- Tool file: `src/tools/Invoke-AIReadiness.ps1`
- Manifest id: `ai-readiness`
- Category: `diagnostico`
- External dependencies: none
- Admin: not required

## Validation

After changes, rebuild and validate:

```powershell
pwsh -NoLogo -NoProfile -File build.ps1
pwsh -NoLogo -NoProfile -File tests/Test-ToolSources.ps1
```

Also parse the changed tool directly:

```powershell
$tokens = $null
$errors = $null
[System.Management.Automation.Language.Parser]::ParseFile("src/tools/Invoke-AIReadiness.ps1", [ref]$tokens, [ref]$errors)
$errors
```
