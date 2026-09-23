# Contributing

Thank you for considering contributing to this project. This document covers setup, content guidelines, and the contribution workflow.

## Prerequisites

- **R** 4.3.1
- **Quarto** (latest release)
- **mise** (task runner, installs tool versions from `.mise.toml`)
- **renv** (R package management, auto-restored on project load)

## Setup

```bash
# 1. Clone the repository
git clone git@github.com:namakala/namakala.github.io.git
cd namakala.github.io

# 2. Install tool versions (R, Node.js)
mise install

# 3. Restore R packages
Rscript -e 'renv::restore()'
```

## Preview and Render

```bash
# Live preview (default profile: web)
mise run preview

# Preview a specific profile
mise run preview --profile proposal

# Render all outputs
mise run render

# Render a specific profile directly
quarto render --profile web
```

Profiles: `web` (default), `proposal`, `site`, `rug`, `intro-essay`.

## Content Guidelines

- Write content in `.qmd` files (Quarto markdown).
- Files prefixed with `_` are include partials. They have no YAML frontmatter and no standalone title.
- Include partials via `{{< include path/to/file.qmd >}}` in wrapper files.
- Use `::: {.content-visible when-profile="X"}` for profile-specific content.
- Citations: use `@citekey` format. All keys must exist in `ref.bib` (repo root).
- Figures: place in `fig/` or subdirectories. Reference with relative paths.
- Cross-references: `[-@fig-label]` for figures, `[-@sec-label]` for sections.
- Code chunks: R with knitr. Default `echo: false`. Override per chunk when needed.
- Academic tone, British English.

## Branching and Pull Requests

- Branch from `master`.
- Use conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `chore:`.
- Keep commits focused: one logical change per commit.
- Describe what and why, not how. Subject line under 75 characters.

## Project Structure

```
docs/                    # All content
├── proposal/            # Research proposal
├── project-definition/  # Project chapters
├── learning-space/      # Learning notes
├── rug-essay/           # RUG essay
fig/                     # Figures
scripts/                 # Shell scripts
style/                   # TeX templates
```

## License

By contributing, you agree that your contributions will be licensed under CC BY.
