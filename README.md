# blog-pipeline

Pipeline de Claude Code para producir posts de blog (español + inglés) para varios blogs de clientes, con un humano en el loop en cada punto de decisión.

No es una aplicación de software: es una configuración de agentes, skills y comandos de [Claude Code](https://claude.com/claude-code) que orquesta el flujo *investigación → curación → redacción → revisión crítica → traducción → imágenes → publicación*, con cada etapa separada por permisos de herramientas y un `status` explícito.

## Requisitos

- [Claude Code](https://claude.com/claude-code) instalado y autenticado.
- Acceso de escritura (vía `gh`/git) a los repos de los blogs listados en `blogs.yaml`, para la etapa de publicación.

## Estructura del repo

```
blogs.yaml              # datos de marca y repo de cada blog destino
posts/<slug>/           # un post en curso o publicado, un folder por slug
.claude/
  agents/               # subagentes: uno por etapa del pipeline
  commands/             # slash commands: uno por etapa, orquestan al agente
  skills/
    guia-de-estilo/     # estructura narrativa (patrones A/B/C)
    guia-editorial/     # límites de veracidad y ética comercial
```

## Flujo del pipeline

Cada post vive en `posts/<slug>/` como una serie de archivos numerados. Cada comando lee/actualiza el campo `status` en `00-config.md` y se niega a avanzar fuera de orden.

| Comando | Subagente | Archivo que produce | `status` resultante |
|---|---|---|---|
| `/post-nuevo` | — | `00-config.md` | `config` |
| `/investigar` | `investigador` | `01-research.md` | `investigado` |
| `/curar` | — (interactivo con el humano) | `02-curated.md` | `curado` |
| `/redactar` | `redactor` | `03-draft-es.md` | `redactado` |
| `/revisar` | `critico` | `04-review.md` | `revisado` |
| `/traducir` | `traductor` | `05-draft-en.md` | `traducido` |
| `/planificar-imagenes` | `imagenes` | `06-image-plan.md` | `imagenes_planificadas` |
| `/publicar` | `repo-manager` | `99-final/<slug>.{es,en}.md` + push a rama nueva | `publicado` |

### Uso típico

```
/post-nuevo          # slug, blog_slug, tema, tipo_post, ideas clave
/investigar <slug>
/curar <slug>        # el humano elige qué hallazgos usar
/redactar <slug>
/revisar <slug>      # si hay BLOQUEOS, se corrige antes de seguir
/traducir <slug>     # el humano aprueba las adaptaciones culturales
/planificar-imagenes <slug>   # el humano busca/genera y ubica las imágenes
/publicar <slug>
```

Ningún comando avanza automáticamente al siguiente si la etapa anterior tiene bloqueos o falta aprobación humana — cada uno se detiene y pregunta.

## Los agentes y su alcance

Cada subagente tiene permisos de herramientas mínimos para la tarea que hace, no más:

- **`investigador`** (`WebSearch`, `WebFetch`, `Read`, `Write`) — busca datos, cifras y casos reales verificables. No redacta ni decide qué se publica.
- **`redactor`** (`Read`, `Write`) — escribe `03-draft-es.md` únicamente a partir de lo ya curado por el humano. No inventa cifras: marca `[VERIFICAR: ...]` si falta un dato.
- **`critico`** (`WebSearch`, `WebFetch`, `Read`, `Write`) — revisa veracidad, similitud estructural con fuentes, ética comercial y guía editorial. Reporta BLOQUEOS/ADVERTENCIAS; nunca reescribe el borrador.
- **`traductor`** (`Read`, `Write`) — produce la versión en inglés adaptando cultura y público, no traduciendo literal. Reporta explícitamente qué adaptó.
- **`imagenes`** (`Read`, `Write`) — recomienda dónde poner imágenes y si buscarlas o generarlas (con prompt incluido). No genera ni busca imágenes él mismo.
- **`repo-manager`** (`Bash`, `Read`, `Write`) — el único agente con acceso a git. Clona/actualiza el repo del blog, crea rama `post/<slug>`, hace commit y push. Nunca publica directo a la rama de producción.

Esta separación es intencional: mantenerla al editar agentes o comandos.

## Configuración de blogs (`blogs.yaml`)

Cada blog destino define:

- `repo`, `rama`, `carpeta_posts` — dónde y cómo publica `repo-manager`.
- `idiomas` — si aplica traducción al inglés.
- `marca.voz`, `marca.publico`, `marca.evitar`, `marca.cta_tipica` — tono, público y límites que `redactor`, `critico` y `traductor` deben respetar para ese blog específico.
- `marca_en` (opcional) — si el público/tono en inglés difiere del español; si no está definido, el traductor asume el mismo tono, solo cambia el idioma.

Blogs actuales: **Nitza Develop** (desarrollo de software), **Metis Host** (hosting/cloud, con segmentos de público declarados), **Electro** (landing de servicios eléctricos).

## Guías compartidas (skills)

- **`guia-de-estilo`** — define los tres patrones narrativos disponibles (`tipo_post: A|B|C`) y reglas comunes: una sola afirmación cuantitativa/comparativa por fuente verificable, un solo CTA, sin superlativos no sustentados, subtítulos solo pasadas las 800 palabras.
  - **A** (default, 1000-1800 palabras): problema real → principio → aplicación.
  - **B** (300-600 palabras): nota corta con un solo gancho.
  - **C** (600-1000 palabras): anécdota → lección de negocio.
- **`guia-editorial`** — límites de veracidad y ética comercial aplicados por `critico` (y anticipados por `redactor`/`traductor`): toda cifra o comparación necesita fuente trazable en `01-research.md` o se marca `[VERIFICAR]`; no se inventan anécdotas de clientes; no se compara contra competidores nombrados; clasifica cada hallazgo como **BLOQUEO** (detiene el pipeline) o **ADVERTENCIA** (decisión del humano).

## Convenciones al modificar el pipeline

- Mantén el estilo de prompt en español y la estructura de secciones de los archivos existentes en `.claude/` — son instrucciones de ejecución real, no solo documentación.
- No le des acceso a `Bash`/git a ningún agente salvo `repo-manager`.
- Si agregas una etapa nueva, sigue el patrón existente: valida el `status` previo, invoca un solo subagente, resume su salida al humano (sin volcar el archivo completo salvo en la etapa de redacción), y actualiza `status` al terminar.

Ver [`CLAUDE.md`](./CLAUDE.md) para guía dirigida a Claude Code al trabajar en este repo.
