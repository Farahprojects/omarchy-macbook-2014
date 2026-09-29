#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/omarchy-macbook-2014/backups/$(date +%Y%m%d-%H%M%S)"
apply_system=false
apply_thunderbolt=false

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--system] [--thunderbolt]

  --system       Also install MacBook hardware configuration with sudo.
  --thunderbolt  With --system, include the optional Thunderbolt network setup.
USAGE
}

for argument in "$@"; do
  case "$argument" in
    --system) apply_system=true ;;
    --thunderbolt) apply_thunderbolt=true ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'Unknown option: %s\n' "$argument" >&2; usage >&2; exit 2 ;;
  esac
done

if [[ $apply_thunderbolt == true && $apply_system != true ]]; then
  printf '%s\n' '--thunderbolt requires --system.' >&2
  exit 2
fi

if [[ -r /etc/os-release ]]; then
  # shellcheck disable=SC1091
  source /etc/os-release
  if [[ ${ID:-} != omarchy ]]; then
    printf 'This overlay expects Omarchy; found %s.\n' "${PRETTY_NAME:-an unknown OS}" >&2
    exit 1
  fi
fi

backup_existing() {
  local destination=$1 relative=$2
  if [[ -e $destination || -L $destination ]]; then
    mkdir -p -- "$backup_root/$(dirname -- "$relative")"
    cp -a -- "$destination" "$backup_root/$relative"
  fi
}

install_user_file() {
  local source=$1 relative=${1#"$repo_root/home/"} destination="$HOME/${1#"$repo_root/home/"}" mode=0644
  [[ -x $source ]] && mode=0755
  backup_existing "$destination" "$relative"
  install -D -m "$mode" -- "$source" "$destination"
  printf 'Installed ~/%s\n' "$relative"
}

while IFS= read -r -d '' source; do
  install_user_file "$source"
done < <(find "$repo_root/home" -type f -print0 | sort -z)

systemctl --user daemon-reload 2>/dev/null || true
if command -v localsend >/dev/null 2>&1; then
  systemctl --user enable --now localsend.service ||
    printf 'LocalSend service installed; enable it after logging in.\n' >&2
fi
if command -v voxtype >/dev/null 2>&1; then
  systemctl --user enable --now voxtype.service ||
    printf 'Voxtype service installed; enable it after logging in.\n' >&2
fi

if [[ $apply_system == true ]]; then
  system_files=(
    system/etc/mbpfan.conf
    system/etc/modprobe.d/facetimehd.conf
    system/etc/modprobe.d/hid_apple.conf
  )

  if [[ $apply_thunderbolt == true ]]; then
    system_files+=(
      system/etc/modprobe.d/thunderbolt-net.conf
      system/etc/mkinitcpio.conf.d/thunderbolt_module.conf
    )
  fi

  for relative in "${system_files[@]}"; do
    source="$repo_root/$relative"
    destination="/${relative#system/}"
    if sudo test -e "$destination"; then
      mkdir -p -- "$backup_root/$(dirname -- "$relative")"
      sudo cp -a -- "$destination" "$backup_root/$relative"
    fi
    sudo install -D -m 0644 -- "$source" "$destination"
    printf 'Installed %s\n' "$destination"
  done

  sudo systemctl enable --now thermald.service 2>/dev/null || true
  sudo systemctl enable --now mbpfan.service 2>/dev/null || true
  if command -v mkinitcpio >/dev/null 2>&1; then
    sudo mkinitcpio -P
  fi
fi

if [[ -d $backup_root ]]; then
  printf '\nBackups: %s\n' "$backup_root"
fi
printf 'Overlay installed. Log out and back in if Hyprland does not reload automatically.\n'
