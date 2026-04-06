# skills

Personal [Cursor Agent Skills](https://cursor.com) — clone this repo and copy skill folders into your Cursor skills directory so the agent can follow `SKILL.md` for each workflow.

**Mirrors:** [GitHub](https://github.com/quanliu1991/skills) · [GitCode](https://gitcode.com/gcw_DwI0fw6c/skills)

```bash
# GitHub
git clone git@github.com:quanliu1991/skills.git
# GitCode
git clone git@gitcode.com:gcw_DwI0fw6c/skills.git
# HTTPS (GitCode)
git clone https://gitcode.com/gcw_DwI0fw6c/skills.git
```

## Skills in this repo

| Skill | Description |
|-------|-------------|
| [infographic](infographic/) | Build mobile-friendly infographic PNGs from HTML (design system + screenshot scripts: Node/Playwright or Windows Chrome/Edge). |

## Install (any OS)

1. **Clone** (pick either mirror, then `cd skills`)

   ```bash
   git clone git@github.com:quanliu1991/skills.git
   # or: git clone git@gitcode.com:gcw_DwI0fw6c/skills.git
   cd skills
   ```

2. **Install the skill for Cursor** — copy the skill folder into your user skills path (create the folder if needed):

   **macOS / Linux**

   ```bash
   mkdir -p ~/.cursor/skills
   cp -R infographic ~/.cursor/skills/infographic
   ```

   **Windows (PowerShell)**

   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cursor\skills" | Out-Null
   Copy-Item -Recurse -Force "infographic" "$env:USERPROFILE\.cursor\skills\infographic"
   ```

3. **Restart Cursor** (or reload the window) so new skills are picked up.

4. **Screenshot tooling** (pick one):

   - **Windows, no Node:** use Chrome or Edge + `infographic/scripts/screenshot.ps1` — see [infographic/WINDOWS.md](infographic/WINDOWS.md).
   - **Node (macOS / Linux / Windows):** from `infographic/`, run `npm install` and `npx playwright install chromium`, then use `scripts/screenshot.js`.

## Optional: project-local skill

To share a skill only with a repo, copy into that project:

`.cursor/skills/infographic/` (same inner layout as `infographic/` here).

## Examples

See [examples/](examples/) for a sample HTML infographic you can screenshot.

## License

MIT — see [LICENSE](LICENSE).
