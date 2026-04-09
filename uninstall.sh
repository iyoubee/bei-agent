#!/usr/bin/env bash
set -euo pipefail

# BEI Agent, Skills & Commands Uninstaller
# Removes only symlinks that point back to this repo

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/agents"
AGENTS_DEST="$HOME/.config/opencode/agents"
SKILLS_SRC="$SCRIPT_DIR/skills"
SKILLS_DEST="$HOME/.config/opencode/skills"
COMMANDS_SRC="$SCRIPT_DIR/commands"
COMMANDS_DEST="$HOME/.config/opencode/commands"
MARKER_FILE="$HOME/.config/opencode/.bei-agent-path"

removed=0

# Helper: remove symlinks pointing to a source dir (files)
remove_file_links() {
  local src_dir="$1" dest_dir="$2" label="$3"

  [ -d "$dest_dir" ] || return 0
  echo "$label"

  for dest_file in "$dest_dir"/*.md; do
    [ -e "$dest_file" ] || [ -L "$dest_file" ] || continue

    if [ -L "$dest_file" ]; then
      target="$(readlink "$dest_file")"
      case "$target" in
        "$src_dir"/*)
          rm -f "$dest_file"
          removed=$((removed + 1))
          echo "  removed: $(basename "$dest_file")"
          ;;
      esac
    fi
  done
}

# Helper: remove symlinks pointing to a source dir (directories)
remove_dir_links() {
  local src_dir="$1" dest_dir="$2" label="$3"

  [ -d "$dest_dir" ] || return 0
  echo "$label"

  for dest_entry in "$dest_dir"/*/; do
    link="${dest_entry%/}"
    [ -e "$link" ] || [ -L "$link" ] || continue

    if [ -L "$link" ]; then
      target="$(readlink "$link")"
      case "$target" in
        "$src_dir"/*)
          rm -f "$link"
          removed=$((removed + 1))
          echo "  removed: $(basename "$link")"
          ;;
      esac
    fi
  done
}

remove_file_links "$AGENTS_SRC" "$AGENTS_DEST" "Agents"
remove_dir_links  "$SKILLS_SRC" "$SKILLS_DEST" "Skills"
remove_file_links "$COMMANDS_SRC" "$COMMANDS_DEST" "Commands"

# --- Remove marker file ---

if [ -f "$MARKER_FILE" ]; then
  rm -f "$MARKER_FILE"
  echo ""
  echo "Removed marker file."
fi

echo ""
echo "Done. removed=$removed item(s)."
