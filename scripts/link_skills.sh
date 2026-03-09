#!/bin/sh

set -eu

if [ "$#" -lt 2 ]; then
  echo "usage: link_skills.sh <target-project> <agent> [agent...]" >&2
  exit 1
fi

repo_root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
target_project=$1
shift

if [ ! -d "$target_project" ]; then
  echo "error: target project not found: $target_project" >&2
  exit 1
fi

skill_source=$repo_root/skills

skill_dir_for_agent() {
  case $1 in
    codex) printf '%s/.codex/skills\n' "$target_project" ;;
    claude|claude-code) printf '%s/.claude/skills\n' "$target_project" ;;
    cursor) printf '%s/.cursor/skills\n' "$target_project" ;;
    copilot|github-copilot) printf '%s/.github/skills\n' "$target_project" ;;
    antigravity) printf '%s/.agent/skills\n' "$target_project" ;;
    *)
      echo "error: unsupported agent: $1" >&2
      exit 1
      ;;
  esac
}

for agent in "$@"; do
  dest=$(skill_dir_for_agent "$agent")
  mkdir -p "$dest"

  for skill in "$skill_source"/*; do
    name=$(basename "$skill")
    link_path=$dest/$name
    rm -f "$link_path"
    ln -s "$skill" "$link_path"
    printf 'linked %s -> %s\n' "$link_path" "$skill"
  done
done
