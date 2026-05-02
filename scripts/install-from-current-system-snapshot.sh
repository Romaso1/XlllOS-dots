#!/usr/bin/env bash
set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== Installing native packages from snapshot ==="

if command -v pacman >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/pacman-native-explicit.txt" ]; then
  sudo pacman -S --needed - < "$REPO_DIR/system/packages/pacman-native-explicit.txt" || true
fi

if command -v paru >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/aur-foreign-explicit.txt" ]; then
  paru -S --needed - < "$REPO_DIR/system/packages/aur-foreign-explicit.txt" || true
elif command -v yay >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/aur-foreign-explicit.txt" ]; then
  yay -S --needed - < "$REPO_DIR/system/packages/aur-foreign-explicit.txt" || true
fi

echo
echo "=== Installing Flatpak apps from snapshot ==="

if ! command -v flatpak >/dev/null 2>&1 && command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed flatpak || true
fi

if command -v flatpak >/dev/null 2>&1; then
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true

  if [ -f "$REPO_DIR/system/packages/flatpak-apps.txt" ]; then
    while read -r app; do
      [ -n "$app" ] && flatpak install -y flathub "$app" || true
    done < "$REPO_DIR/system/packages/flatpak-apps.txt"
  fi
fi

echo
echo "=== Syncing dotfiles to HOME ==="
rsync -a "$REPO_DIR/dotfiles/home/" "$HOME/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.config/" "$HOME/.config/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.local/" "$HOME/.local/" 2>/dev/null || true

echo
echo "Done. Reboot or relogin is recommended."



echo
echo "=== Installing DWProton into Steam ==="
if [ -x "$REPO_DIR/scripts/install-steam-dwproton.sh" ]; then
  bash "$REPO_DIR/scripts/install-steam-dwproton.sh" || echo "WARNING: Steam DWProton install failed; continuing."
else
  echo "WARNING: install-steam-dwproton.sh not found."
fi


# BEGIN XlllOS Steam default deps Bottles NVIDIA
echo
echo "=== Installing default Steam deps for Bottles-like mods and NVIDIA ==="

if command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed protontricks winetricks protonplus || true
fi

mkdir -p "$HOME/.config/systemd/user"

if [ -f "$REPO_DIR/system/systemd-user/xlllos-steam-default-deps-bottles-nvidia.service" ]; then
  cp -a "$REPO_DIR/system/systemd-user/xlllos-steam-default-deps-bottles-nvidia.service" "$HOME/.config/systemd/user/"
fi

if [ -f "$REPO_DIR/system/systemd-user/xlllos-steam-default-deps-bottles-nvidia.timer" ]; then
  cp -a "$REPO_DIR/system/systemd-user/xlllos-steam-default-deps-bottles-nvidia.timer" "$HOME/.config/systemd/user/"
fi

systemctl --user daemon-reload || true
systemctl --user enable --now xlllos-steam-default-deps-bottles-nvidia.timer || true

if [ -x "$REPO_DIR/scripts/install-steam-default-deps-bottles-nvidia.sh" ]; then
  bash "$REPO_DIR/scripts/install-steam-default-deps-bottles-nvidia.sh" || echo "WARNING: default Steam dependency install failed; continuing."
else
  echo "WARNING: install-steam-default-deps-bottles-nvidia.sh not found."
fi
# END XlllOS Steam default deps Bottles NVIDIA

