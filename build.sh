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

# ── Claude Code ────────────────────────────────────────────────────────────
# Genera dos estructuras complementarias:
#   .claude/skills/  → sistema de skills (context en el system prompt)
#   .claude/commands/ → slash commands visibles en la UI (/pipeline-health, etc.)
for entry in "${PROVIDERS_FLAT[@]}"; do
  provider="${entry%%:*}"
  hidden_path="${entry##*:}"
  skills_target="$DIST/$provider/$hidden_path"
  commands_target="$DIST/$provider/.claude/commands"

  echo "→ Generando $provider — skills + commands..."
  mkdir -p "$skills_target" "$commands_target"

  # Skill de contexto general (solo en skills/)
  mkdir -p "$skills_target/revops-intelligence"
  cp "$SOURCE/revops-intelligence/SKILL.md" "$skills_target/revops-intelligence/SKILL.md"

  # Cada comando: skill plano en skills/ Y archivo en commands/
  for cmd in "$SOURCE/revops-intelligence/commands/"*.md; do
    name=$(basename "$cmd" .md)
    mkdir -p "$skills_target/$name"
    cp "$cmd" "$skills_target/$name/SKILL.md"
    cp "$cmd" "$commands_target/$name.md"
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
