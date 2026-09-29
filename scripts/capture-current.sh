#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)

tracked_home_files=(
  .codex/skills/omarchy-macbook-updates/SKILL.md
  .config/foot/foot.ini
  .config/hypr/hyprland.lua
  .config/hypr/floating.lua
  .config/hypr/bindings.lua
  .config/hypr/input.lua
  .config/hypr/looknfeel.lua
  .config/hypr/monitors.lua
  .config/omarchy/defaults/agent
  .config/omarchy/extensions/omarchy-menu.jsonc
  .config/omarchy/shell.json
  .config/systemd/user/localsend.service
  .config/systemd/user/voxtype.service
  .local/bin/foot-context-menu
  .local/bin/obs-dji-prewarm
)

tracked_home_directories=(
  .config/omarchy/plugins/peter.monitor
  .config/omarchy/plugins/peter.notifications
)

copy_file() {
  local relative=$1 source="$HOME/$1" destination="$repo_root/home/$1" mode=0644
  [[ -f $source ]] || { printf 'Missing: ~/%s\n' "$relative" >&2; return; }
  [[ -x $source ]] && mode=0755
  install -D -m "$mode" -- "$source" "$destination"
}

for relative in "${tracked_home_files[@]}"; do
  copy_file "$relative"
done

for relative in "${tracked_home_directories[@]}"; do
  [[ -d $HOME/$relative ]] || { printf 'Missing: ~/%s\n' "$relative" >&2; continue; }
  while IFS= read -r -d '' source; do
    child=${source#"$HOME/$relative/"}
    destination="$repo_root/home/$relative/$child"
    mode=0644
    [[ -x $source ]] && mode=0755
    install -D -m "$mode" -- "$source" "$destination"
  done < <(find "$HOME/$relative" -type f -print0 | sort -z)
done

printf 'Captured the allowlisted configuration. Review with: git diff\n'
