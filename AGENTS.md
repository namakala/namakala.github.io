# Toolchain

| Tool | Version | Purpose |
|------|---------|---------|
| R | 4.3.1 | Statistical computing, knitr code chunks |
| renv | latest | R package management (lockfile: renv.lock) |
| Quarto | latest | Document rendering (book + website) |
| mise | latest | Task orchestration (mise run render, mise run preview) |

R environment variable: `RENV_CONFIG_SANDBOX_ENABLED=FALSE` (set in .Renviron).

# Profiles

Each profile uses a dedicated `_quarto-<profile>.yml` config and renders to `_render/<profile>/`.

| Profile | Output file | Format | Purpose |
|---------|-------------|--------|---------|
| `web` (default) | journey | HTML | Full website with navbar, sidebar, all sections |
| `proposal` | proposal | PDF (xelatex) | PhD proposal with UI template |
| `site` | site | HTML | Book-style: proposal + learning-space + presentation |
| `rug` | project-definition | HTML/PDF/DOCX | RUG project definition document |
| `intro-essay` | introductory-essay | HTML/PDF | Introductory essay (index + proposal intro) |

# Commands

```bash
# Render a specific profile
quarto render --profile <profile>

# Render via mise (default profile)
mise run render

# Live preview with tailscale serve
mise run preview --profile <profile>

# Preview script directly
./scripts/preview.sh --profile <profile> --port 1810
```

# Directory Structure

```
.
├── docs/                    # All book/website content
│   ├── proposal/            # Research proposal chapters + methods partials
│   ├── project-definition/  # 5 project chapters with include partials
│   ├── learning-space/      # Curated notes (git-in-research, graph-theory)
│   ├── rug-essay/           # RUG introductory essay
│   └── _metadata.yml        # Shared defaults (reference-location, cap-location)
├── fig/                     # Figures (PNG, drawio exports)
├── scripts/                 # Shell scripts (preview.sh)
├── mise-tasks/              # Task definitions (render, preview)
├── style/                   # TeX templates (ui.tex, doc-class.tex)
├── _render/                 # Render output per profile (gitignored)
├── _freeze/                 # Quarto freeze cache (gitignored, auto-managed)
├── _quarto.yml              # Base Quarto config
├── _quarto-*.yml            # Profile-specific Quarto configs
├── ref.bib                  # Bibliography
├── index.qmd                # Root landing page
├── .mise.toml               # mise tool versions
├── .github/workflows/       # CI: publish to gh-pages on push to master
└── renv/                    # R package management
```

# Git Workflow

- **master:** Source branch. CI triggers on push.
- **gh-pages:** Published output (auto-deployed by GitHub Actions).
- Branch from `master` for all work.
- Use conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `chore:`.

# Conventions

- All content lives in `.qmd` files (Quarto markdown).
- Files prefixed with `_` are include partials, not standalone documents.
- Partials are included via `{{< include path/to/file.qmd >}}`.
- Profile-conditional content uses `::: {.content-visible when-profile="X"}`.
- Bibliography: `ref.bib` at repo root, cite with `@citekey`.
- Cross-references: `[-@fig-label]` for figures, `[-@sec-label]` for sections.
- `docs/_metadata.yml` applies shared defaults to all docs content.

# Pitfalls

- `_freeze/` is auto-managed by Quarto. Do not edit manually.
- `_render/` contains build output. Gitignored, regenerated on render.
- `methods.qmd` (UI variant) and `methods-rug.qmd` (RUG variant) are separate. Do not mix content between them.
- The `proposal` profile renders PDF via xelatex with a custom UI template (`style/ui.tex`).
- renv sandbox is disabled. Package restoration runs without isolation.
