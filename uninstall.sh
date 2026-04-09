#!/usr/bin/env bash
set -euo pipefail

# BEI Agent Uninstaller
# Removes only symlinks that point back to this repo's agents/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/agents"
AGENTS_DEST="$HOME/.config/opencode/agents"

if [ ! -d "$AGENTS_DEST" ]; then
  echo "Nothing to uninstall. $AGENTS_DEST does not exist."
  exit 0
fi

removed=0

for dest_file in "$AGENTS_DEST"/*.md; do
  [ -e "$dest_file" ] || [ -L "$dest_file" ] || continue

  # Only remove symlinks that point into this repo's agents/ dir
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

echo ""
echo "Done. removed=$removed agent(s)."
