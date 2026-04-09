#!/usr/bin/env bash
set -euo pipefail

# BEI Agent Installer
# Creates symlinks from ~/.config/opencode/agents/ to this repo's agents/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/agents"
AGENTS_DEST="$HOME/.config/opencode/agents"

FORCE=false
if [[ "${1:-}" == "--force" ]]; then
  FORCE=true
fi

if [ ! -d "$AGENTS_SRC" ]; then
  echo "Error: agents/ directory not found at $AGENTS_SRC"
  exit 1
fi

mkdir -p "$AGENTS_DEST"

installed=0
skipped=0
updated=0

for agent_file in "$AGENTS_SRC"/*.md; do
  [ -e "$agent_file" ] || continue

  filename="$(basename "$agent_file")"
  dest="$AGENTS_DEST/$filename"

  # Already symlinked to this repo -- skip
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$agent_file" ]; then
    continue
  fi

  # Exists but is NOT a symlink to this repo
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if $FORCE; then
      rm -f "$dest"
      ln -s "$agent_file" "$dest"
      updated=$((updated + 1))
      echo "  overwritten: $filename"
    else
      skipped=$((skipped + 1))
      echo "  skipped:     $filename (already exists, use --force to overwrite)"
    fi
    continue
  fi

  ln -s "$agent_file" "$dest"
  installed=$((installed + 1))
  echo "  installed:   $filename"
done

echo ""
echo "Done. installed=$installed updated=$updated skipped=$skipped"
echo "Agents directory: $AGENTS_DEST"
