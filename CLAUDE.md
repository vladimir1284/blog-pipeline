# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Not a software project — a Claude Code pipeline configuration for producing blog posts (Spanish + English) for three client blogs. There is no build, lint, or test tooling; all "code" is agent/skill/command markdown under `.claude/`. Content output lives under `posts/<slug>/`.

## Pipeline flow

Each post is a folder `posts/<slug>/` with numbered stage files, advanced by slash commands that each wrap one subagent and gate on `status` in `00-config.md`:

```
/post-nuevo   → 00-config.md            (status: config)
/investigar   → 01-research.md          (status: investigado)   [investigador]
/curar        → 02-curated.md           (status: curado)        (human picks findings)
/redactar     → 03-draft-es.md          (status: redactado)     [redactor]
/revisar      → 04-review.md            (status: revisado)      [critico]
/traducir     → 05-draft-en.md          (status: traducido)     [traductor]
/planificar-imagenes → 06-image-plan.md (status: imagenes_planificadas) [imagenes]
/subir-imagenes → 07-images-final.md    (status: imagenes_subidas)  [medios]
/publicar     → 99-final/<slug>.{es,en}.md → push to blog repo  [repo-manager]
```

Each command reads/updates `00-config.md`'s `status` field and refuses to proceed out of order (e.g. `/redactar` requires `status: curado`, `/traducir` requires `status: revisado` with no unresolved BLOQUEOS). `/publicar` requires `status: imagenes_subidas` (or `traducido` if the blog needs no images). When adding a new stage, follow this pattern: gate on prior status, invoke exactly one subagent, summarize output for the human (don't dump full files except at the draft stage), update status.

The human drops source images at `posts/<slug>/images/raw/` (gitignored) before running `/subir-imagenes` — that stage converts them to WebP, uploads them to R2, and inserts the resulting URLs directly into `03-draft-es.md`/`05-draft-en.md` at the locations from `06-image-plan.md`, so no binary image files are ever committed to this repo and no manual paste step is needed before `/publicar`.

## Agent boundaries (do not blur these)

- **investigador**: gathers/cites sources only, never drafts prose.
- **redactor**: writes `03-draft-es.md` only from `02-curated.md` (already human-approved) — never introduces new facts, uses `[VERIFICAR: ...]` for anything unsourced.
- **critico**: read-only reviewer — reports BLOQUEOS/ADVERTENCIAS in `04-review.md`, never edits the draft itself.
- **traductor**: adapts culturally rather than translating literally, and must report adaptations made (not just deliver text).
- **imagenes**: only recommends image placement/prompts, never fetches or generates images.
- **medios**: converts/resizes the images the human placed in `images/raw/` and uploads them to R2. Only ever runs ImageMagick (`convert`) and `aws s3` against R2 — never touches git or the blog repos. Uses the plan from `imagenes`, never chooses images itself.
- **repo-manager**: the only agent with git access, and never pushes directly to the blog's production branch — always a new `post/<slug>` branch, human merges.

Each agent's tool grants in its frontmatter reflect this (e.g. `redactor`/`critico`/`imagenes`/`traductor` get only `Read`/`Write` (+`WebSearch`/`WebFetch` for investigador/critico); `repo-manager` and `medios` are the only two with `Bash`, scoped respectively to git and to image conversion/R2 upload). Preserve this least-privilege split when editing agents.

## Shared configuration

- **`blogs.yaml`**: per-blog brand data (`marca.voz`, `marca.publico`, `marca.evitar`, `marca.cta_tipica`, repo URL/branch/posts folder). Every agent that writes prose must look up its `blog_slug` here — brand tone and hard limits (`marca.evitar`) come from this file, not from the skills.
- **`.env`** (gitignored, see `.env.example`): R2 credentials (`R2_ACCOUNT_ID`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`, `R2_BUCKET_NAME`, `R2_PUBLIC_URL`) used only by `medios`. Images are keyed in the bucket as `<blog_slug>/<post_slug>/<file>`, so one bucket serves all three blogs without collisions.
- **`.claude/skills/guia-de-estilo`**: narrative structure — patterns A (default, 1000-1800 words, problem→principle→application), B (300-600 words, single hook), C (600-1000 words, anecdote→business lesson) — plus cross-pattern rules (one CTA max, no unsourced superlatives/comparatives, subheadings only past 800 words). Defines *how* a post is structured; `blogs.yaml` defines tone/voice on top of it.
- **`.claude/skills/guia-editorial`**: veracity/ethics gate — every quantitative or comparative claim needs a traceable source in `01-research.md` or gets `[VERIFICAR: ...]`; no invented customer anecdotes; no disparaging named competitors; classifies findings as BLOQUEO (blocks progression) vs ADVERTENCIA (human's call). `critico` applies this as its primary checklist; `redactor`/`traductor` are expected to pre-empt it while writing.

## Working in this repo

- When editing a command or agent, keep the Spanish-language prompt style and section structure consistent with the existing files — these are the actual runtime instructions, not documentation.
- Never have `redactor`, `critico`, `traductor`, or `imagenes` touch git — that's a deliberate separation of concerns enforced via tool grants, not an oversight.
- `blogs.yaml` `carpeta_posts` paths assume an Astro content collection (`src/content/blog`) on the target repos; `repo-manager` is instructed to verify actual frontmatter format against an existing post in each target repo rather than assume it.
