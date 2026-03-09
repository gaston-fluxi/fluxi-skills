#!/usr/bin/env bash
# build.sh — Genera dist/ desde source/ para todos los providers
# Uso: ./build.sh

set -euo pipefail

SOURCE="source/skills"
DIST="dist"

PROVIDERS=(
  "claude-code:.claude/skills"
  "cursor:.cursor/skills"
  "gemini:.gemini/skills"
  "codex:.codex/skills"
  "agents:.agents/skills"
)

echo "→ Limpiando dist/..."
rm -rf "$DIST"

for entry in "${PROVIDERS[@]}"; do
  provider="${entry%%:*}"
  hidden_path="${entry##*:}"
  target="$DIST/$provider/$hidden_path"

  echo "→ Generando $provider ($target)..."
  mkdir -p "$target"

  # Copiar todos los skills
  cp -r "$SOURCE"/. "$target/"
done

echo ""
echo "✓ Build completado. Providers generados:"
for entry in "${PROVIDERS[@]}"; do
  provider="${entry%%:*}"
  hidden_path="${entry##*:}"
  echo "  dist/$provider/$hidden_path/"
done
