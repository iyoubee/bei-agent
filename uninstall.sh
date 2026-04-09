#!/usr/bin/env bash
set -euo pipefail

# BEI Agent & Skills Uninstaller
# Removes only symlinks that point back to this repo

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/agents"
AGENTS_DEST="$HOME/.config/opencode/agents"
SKILLS_SRC="$SCRIPT_DIR/skills"
SKILLS_DEST="$HOME/.config/opencode/skills"

removed=0

# --- Agents ---

if [ -d "$AGENTS_DEST" ]; then
  echo "Agents"
  for dest_file in "$AGENTS_DEST"/*.md; do
    [ -e "$dest_file" ] || [ -L "$dest_file" ] || continue

    if [ -L "$dest_file" ]; then
      target="$(readlink "$dest_file")"
      case "$target" in
        "$AGENTS_SRC"/*)
          rm -f "$dest_file"
          removed=$((removed + 1))
          echo "  removed: $(basename "$dest_file")"
          ;;
      esac
    fi
  done
fi

# --- Skills ---

if [ -d "$SKILLS_DEST" ]; then
  echo "Skills"
  for dest_dir in "$SKILLS_DEST"/*/; do
    [ -e "$dest_dir" ] || [ -L "${dest_dir%/}" ] || continue

    link="${dest_dir%/}"
    if [ -L "$link" ]; then
      target="$(readlink "$link")"
      case "$target" in
        "$SKILLS_SRC"/*)
          rm -f "$link"
          removed=$((removed + 1))
          echo "  removed: $(basename "$link")"
          ;;
      esac
    fi
  done
fi

echo ""
echo "Done. removed=$removed item(s)."
