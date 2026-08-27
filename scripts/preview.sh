#!/usr/bin/env bash
# Render posts/<slug>/03-draft-es.md (+ 05-draft-en.md) to local HTML preview.
# Pure shell + pandoc — no LLM/agent call, no token cost. Mirrors the logic
# of the (now removed) /preview slash command.
#
# Usage: scripts/preview.sh [slug]
#   slug optional if posts/ has exactly one post directory.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

command -v pandoc >/dev/null 2>&1 || { echo "Error: pandoc no está instalado." >&2; exit 1; }

SLUG="${1:-}"
if [[ -z "$SLUG" ]]; then
  mapfile -t POSTS < <(find posts -mindepth 1 -maxdepth 1 -type d -printf '%f\n' 2>/dev/null | sort)
  if [[ ${#POSTS[@]} -eq 1 ]]; then
    SLUG="${POSTS[0]}"
  elif [[ ${#POSTS[@]} -eq 0 ]]; then
    echo "Error: no hay posts en posts/." >&2; exit 1
  else
    echo "Error: hay varios posts, especifica el slug:" >&2
    printf '  %s\n' "${POSTS[@]}" >&2
    exit 1
  fi
fi

POST_DIR="posts/$SLUG"
CONFIG="$POST_DIR/00-config.md"
[[ -f "$CONFIG" ]] || { echo "Error: no existe $CONFIG" >&2; exit 1; }

BLOG_SLUG=$(sed -n 's/^blog_slug:[[:space:]]*//p' "$CONFIG" | head -1 | tr -d '\r')
STATUS=$(sed -n 's/^status:[[:space:]]*//p' "$CONFIG" | head -1 | tr -d '\r')

DRAFT_ES="$POST_DIR/03-draft-es.md"
DRAFT_EN="$POST_DIR/05-draft-en.md"
IMAGE_PLAN="$POST_DIR/06-image-plan.md"

[[ -f "$DRAFT_ES" ]] || { echo "Error: no existe $DRAFT_ES — corre /redactar primero." >&2; exit 1; }

# ---- idiomas del blog en blogs.yaml (bloque "- slug: $BLOG_SLUG" hasta el próximo "- slug:") ----
IDIOMAS_LINE=$(awk -v s="$BLOG_SLUG" '
  $0 ~ "- slug:[[:space:]]*"s"$" { inblock=1; next }
  inblock && /^  - slug:/ { inblock=0 }
  inblock && /idiomas:/ { print; exit }
' blogs.yaml)
WANTS_EN=0
[[ "$IDIOMAS_LINE" == *en* ]] && WANTS_EN=1

RENDER_EN=0
if [[ -f "$DRAFT_EN" && "$WANTS_EN" -eq 1 ]]; then
  RENDER_EN=1
fi

PREVIEW_DIR="$POST_DIR/preview"
mkdir -p "$PREVIEW_DIR"

IMAGES_PENDING=0
if [[ "$STATUS" != "imagenes_subidas" && "$STATUS" != "publicado" ]]; then
  IMAGES_PENDING=1
fi

render_lang() {
  local src="$1" lang="$2" out="$3"

  local title
  title=$(grep -m1 '^# ' "$src" | sed 's/^# *//')
  [[ -z "$title" ]] && title="$SLUG"

  local body_html
  body_html=$(pandoc --from=markdown --to=html "$src")

  # Resaltar [VERIFICAR: ...]
  local verificar_count
  verificar_count=$(grep -o '\[VERIFICAR:' "$src" | wc -l | tr -d ' ')
  if [[ "$verificar_count" -gt 0 ]]; then
    body_html=$(printf '%s' "$body_html" | sed -E 's/\[VERIFICAR:[^]]*\]/<span class="verificar">&<\/span>/g')
  fi

  local pending_banner=""
  if [[ "$IMAGES_PENDING" -eq 1 && -f "$IMAGE_PLAN" ]]; then
    local items
    items=$(grep -E '^## Imagen [0-9]+' "$IMAGE_PLAN" | sed -E 's/^## //')
    if [[ -n "$items" ]]; then
      pending_banner="<div class=\"img-pendiente\"><strong>Imágenes aún no insertadas</strong> (status: $STATUS) — plan en 06-image-plan.md:<ul>"
      while IFS= read -r line; do
        pending_banner+="<li>$(printf '%s' "$line" | sed 's/&/\&amp;/g; s/</\&lt;/g')</li>"
      done <<< "$items"
      pending_banner+="</ul></div>"
    fi
  fi

  cat > "$out" <<HTML
<!DOCTYPE html>
<html lang="$lang">
<head>
<meta charset="utf-8">
<title>$title</title>
<style>
body{max-width:700px;margin:2rem auto;padding:0 1.25rem;font-family:Georgia,'Times New Roman',serif;line-height:1.65;color:#222;background:#fdfdfb;}
h1,h2,h3{font-family:Georgia,serif;line-height:1.25;}
h1{font-size:1.9rem;margin-bottom:.3em;}
h2{font-size:1.35rem;margin-top:2em;border-bottom:1px solid #ddd;padding-bottom:.2em;}
img{max-width:100%;height:auto;display:block;margin:1.2em 0;border-radius:4px;}
p{margin:1em 0;}
.verificar{background:#fff3a3;padding:0 .15em;}
.img-pendiente{background:#eee;border:2px dashed #999;color:#333;padding:1em 1.25em;font-family:sans-serif;font-size:.85rem;margin:0 0 1.5em;}
.img-pendiente ul{margin:.4em 0 0;padding-left:1.2em;}
a{color:#a33;}
</style>
</head>
<body>
$pending_banner
$body_html
</body>
</html>
HTML

  echo "$out|$verificar_count"
}

RESULT_ES=$(render_lang "$DRAFT_ES" "es" "$PREVIEW_DIR/$SLUG.es.html")
OUT_ES="${RESULT_ES%%|*}"
VER_ES="${RESULT_ES##*|}"

OUT_EN=""
VER_EN=0
if [[ "$RENDER_EN" -eq 1 ]]; then
  RESULT_EN=$(render_lang "$DRAFT_EN" "en" "$PREVIEW_DIR/$SLUG.en.html")
  OUT_EN="${RESULT_EN%%|*}"
  VER_EN="${RESULT_EN##*|}"
fi

OPENER=""
command -v xdg-open >/dev/null 2>&1 && OPENER="xdg-open"
[[ -z "$OPENER" ]] && command -v open >/dev/null 2>&1 && OPENER="open"

if [[ -n "$OPENER" ]]; then
  "$OPENER" "$OUT_ES" >/dev/null 2>&1 &
  [[ -n "$OUT_EN" ]] && "$OPENER" "$OUT_EN" >/dev/null 2>&1 &
fi

echo "Preview generado:"
echo "  $OUT_ES"
[[ -n "$OUT_EN" ]] && echo "  $OUT_EN"
[[ -z "$OPENER" ]] && echo "(no se encontró xdg-open/open — abre los archivos manualmente)"

TOTAL_VER=$((VER_ES + VER_EN))
[[ "$TOTAL_VER" -gt 0 ]] && echo "Atención: $TOTAL_VER marca(s) [VERIFICAR] sin resolver."
[[ "$IMAGES_PENDING" -eq 1 ]] && echo "Atención: status=$STATUS — imágenes aún no insertadas (ver banner en el HTML)."

exit 0
