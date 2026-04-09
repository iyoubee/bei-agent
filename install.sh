#!/usr/bin/env bash
set -euo pipefail

# BEI Agent, Skills & Commands Installer
# Creates symlinks from ~/.config/opencode/ to this repo

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/agents"
AGENTS_DEST="$HOME/.config/opencode/agents"
SKILLS_SRC="$SCRIPT_DIR/skills"
SKILLS_DEST="$HOME/.config/opencode/skills"
COMMANDS_SRC="$SCRIPT_DIR/commands"
COMMANDS_DEST="$HOME/.config/opencode/commands"
MARKER_FILE="$HOME/.config/opencode/.bei-agent-path"

FORCE=false
if [[ "${1:-}" == "--force" ]]; then
  FORCE=true
fi

installed=0
skipped=0
updated=0

# Helper: symlink a single file
link_file() {
  local src="$1" dest="$2" name="$3"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    return
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if $FORCE; then
      rm -f "$dest"
      ln -s "$src" "$dest"
      updated=$((updated + 1))
      echo "  overwritten: $name"
    else
      skipped=$((skipped + 1))
      echo "  skipped:     $name (already exists, use --force to overwrite)"
    fi
    return
  fi

  ln -s "$src" "$dest"
  installed=$((installed + 1))
  echo "  installed:   $name"
}

# Helper: symlink a directory
link_dir() {
  local src="$1" dest="$2" name="$3"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    return
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if $FORCE; then
      rm -rf "$dest"
      ln -s "$src" "$dest"
      updated=$((updated + 1))
      echo "  overwritten: $name"
    else
      skipped=$((skipped + 1))
      echo "  skipped:     $name (already exists, use --force to overwrite)"
    fi
    return
  fi

  ln -s "$src" "$dest"
  installed=$((installed + 1))
  echo "  installed:   $name"
}

# --- Agents (file symlinks) ---

if [ -d "$AGENTS_SRC" ]; then
  mkdir -p "$AGENTS_DEST"
  echo "Agents"

  for agent_file in "$AGENTS_SRC"/*.md; do
    [ -e "$agent_file" ] || continue
    link_file "$agent_file" "$AGENTS_DEST/$(basename "$agent_file")" "$(basename "$agent_file")"
  done
fi

# --- Skills (directory symlinks) ---

if [ -d "$SKILLS_SRC" ]; then
  mkdir -p "$SKILLS_DEST"
  echo "Skills"

  for skill_dir in "$SKILLS_SRC"/*/; do
    [ -d "$skill_dir" ] || continue
    [ -f "$skill_dir/SKILL.md" ] || continue

    skill_name="$(basename "$skill_dir")"
    link_dir "${skill_dir%/}" "$SKILLS_DEST/$skill_name" "$skill_name"
  done
fi

# --- Commands (file symlinks) ---

if [ -d "$COMMANDS_SRC" ]; then
  mkdir -p "$COMMANDS_DEST"
  echo "Commands"

  for cmd_file in "$COMMANDS_SRC"/*.md; do
    [ -e "$cmd_file" ] || continue
    link_file "$cmd_file" "$COMMANDS_DEST/$(basename "$cmd_file")" "$(basename "$cmd_file")"
  done
fi

# --- Write marker file ---

mkdir -p "$(dirname "$MARKER_FILE")"
echo "$SCRIPT_DIR" > "$MARKER_FILE"

echo ""
echo "Done. installed=$installed updated=$updated skipped=$skipped"
echo "Agents:   $AGENTS_DEST"
echo "Skills:   $SKILLS_DEST"
echo "Commands: $COMMANDS_DEST"
