#!/usr/bin/env bash
# build.sh — Genera dist/ desde source/ para todos los providers
# Uso: ./build.sh

set -euo pipefail

SOURCE="source/skills"
DIST="dist"

# Claude Code requiere una estructura plana: un directorio por skill, cada uno con SKILL.md.
# El resto de providers usa la estructura original con commands/.
PROVIDERS_FLAT=(
  "claude-code:.claude/skills"
)
PROVIDERS_STANDARD=(
  "cursor:.cursor/skills"
  "gemini:.gemini/skills"
  "codex:.codex/skills"
  "agents:.agents/skills"
)

echo "→ Limpiando dist/..."
rm -rf "$DIST"

# ── Claude Code (estructura plana) ─────────────────────────────────────────
for entry in "${PROVIDERS_FLAT[@]}"; do
  provider="${entry%%:*}"
  hidden_path="${entry##*:}"
  target="$DIST/$provider/$hidden_path"

  echo "→ Generando $provider ($target) — estructura plana..."
  mkdir -p "$target"

  # Skill de contexto general
  mkdir -p "$target/revops-intelligence"
  cp "$SOURCE/revops-intelligence/SKILL.md" "$target/revops-intelligence/SKILL.md"

  # Cada comando se convierte en su propio skill con SKILL.md
  for cmd in "$SOURCE/revops-intelligence/commands/"*.md; do
    name=$(basename "$cmd" .md)
    mkdir -p "$target/$name"
    cp "$cmd" "$target/$name/SKILL.md"
  done
done

# ── Otros providers (estructura original con commands/) ───────────────────
for entry in "${PROVIDERS_STANDARD[@]}"; do
  provider="${entry%%:*}"
  hidden_path="${entry##*:}"
  target="$DIST/$provider/$hidden_path"

  echo "→ Generando $provider ($target)..."
  mkdir -p "$target"
  cp -r "$SOURCE"/. "$target/"
done

echo ""
echo "✓ Build completado. Providers generados:"
for entry in "${PROVIDERS_FLAT[@]}" "${PROVIDERS_STANDARD[@]}"; do
  provider="${entry%%:*}"
  hidden_path="${entry##*:}"
  echo "  dist/$provider/$hidden_path/"
done
