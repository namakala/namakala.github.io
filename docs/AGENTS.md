# Docs Agent Guide

This directory contains all content for the Quarto book/website. Subdirectories map to chapters and sections across profiles.

## Content Architecture

| Subdirectory | Profiles used in | Description |
|-------------|-----------------|-------------|
| `proposal/` | proposal, web, site, intro-essay | Research proposal chapters and methods |
| `project-definition/` | web, rug | 5 project definition chapters |
| `learning-space/` | site, web | Curated learning notes and slides |
| `rug-essay/` | rug | RUG introductory essay |

## Include Pattern

Files prefixed with `_` are partials included into wrapper files:

```qmd
# Chapter Title

{{< include _chapter-01.qmd >}}

:::: {.content-visible when-profile="web"}
# References
::: {#refs}
:::
::::
```

Rules:
- Partials have no YAML frontmatter and no standalone title.
- Wrapper files provide the heading, `{{< include >}}`, and profile-conditional sections.
- Never add frontmatter or a title to a `_`-prefixed partial.

## Profile-Conditional Content

Quarto gates content per profile using div syntax:

```qmd
::: {.content-visible when-profile="proposal"}
Only visible in the proposal profile.
:::

::: {.content-hidden when-profile="proposal"}
Visible in all profiles EXCEPT proposal.
:::
```

Do not break these blocks. They control what appears in each rendered output.

## Metadata

`docs/_metadata.yml` sets shared defaults for all `.qmd` files under `docs/`:

```yaml
reference-location: margin
cap-location: margin
```

Do not duplicate these settings in individual files.

## Cross-Referencing

- Bibliography: cite with `@citekey`, defined in `ref.bib` (repo root).
- Figures: `[-@fig-label]` references `#| label: fig-label` in code chunks.
- Sections: `[-@sec-label]` references `# Heading {#sec-label}`.
- Use relative paths for images: `../../fig/filename.png` from nested dirs.

## Code Chunks

- R code chunks use knitr. Default options set in `_quarto.yml`: `echo: false`, `eval: true`.
- Override per chunk with `#| echo: true` when showing code is intentional.
- Use `knitr::include_graphics("path")` for figures with explicit paths.
