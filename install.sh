#!/usr/bin/env bash
set -euo pipefail

# BEI Agent & Skills Installer
# Creates symlinks from ~/.config/opencode/ to this repo's agents/ and skills/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/agents"
AGENTS_DEST="$HOME/.config/opencode/agents"
SKILLS_SRC="$SCRIPT_DIR/skills"
SKILLS_DEST="$HOME/.config/opencode/skills"

FORCE=false
if [[ "${1:-}" == "--force" ]]; then
  FORCE=true
fi

installed=0
skipped=0
updated=0

# --- Agents (file symlinks) ---

if [ -d "$AGENTS_SRC" ]; then
  mkdir -p "$AGENTS_DEST"
  echo "Agents"

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
fi

# --- Skills (directory symlinks) ---

if [ -d "$SKILLS_SRC" ]; then
  mkdir -p "$SKILLS_DEST"
  echo "Skills"

  for skill_dir in "$SKILLS_SRC"/*/; do
    [ -d "$skill_dir" ] || continue
    # Must contain a SKILL.md to be valid
    [ -f "$skill_dir/SKILL.md" ] || continue

    skill_name="$(basename "$skill_dir")"
    dest="$SKILLS_DEST/$skill_name"

    # Already symlinked to this repo -- skip
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "${skill_dir%/}" ]; then
      continue
    fi

    # Exists but is NOT a symlink to this repo
    if [ -e "$dest" ] || [ -L "$dest" ]; then
      if $FORCE; then
        rm -rf "$dest"
        ln -s "${skill_dir%/}" "$dest"
        updated=$((updated + 1))
        echo "  overwritten: $skill_name"
      else
        skipped=$((skipped + 1))
        echo "  skipped:     $skill_name (already exists, use --force to overwrite)"
      fi
      continue
    fi

    ln -s "${skill_dir%/}" "$dest"
    installed=$((installed + 1))
    echo "  installed:   $skill_name"
  done
fi

echo ""
echo "Done. installed=$installed updated=$updated skipped=$skipped"
echo "Agents:  $AGENTS_DEST"
echo "Skills:  $SKILLS_DEST"
