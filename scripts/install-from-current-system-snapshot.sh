#!/usr/bin/env bash
set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== Installing packages from snapshot ==="

if command -v pacman >/dev/null 2>&1; then
  if [ -f "$REPO_DIR/system/packages/pacman-native-explicit.txt" ]; then
    sudo pacman -S --needed - < "$REPO_DIR/system/packages/pacman-native-explicit.txt" || true
  fi
fi

if command -v paru >/dev/null 2>&1; then
  if [ -f "$REPO_DIR/system/packages/aur-foreign-explicit.txt" ]; then
    paru -S --needed - < "$REPO_DIR/system/packages/aur-foreign-explicit.txt" || true
  fi
elif command -v yay >/dev/null 2>&1; then
  if [ -f "$REPO_DIR/system/packages/aur-foreign-explicit.txt" ]; then
    yay -S --needed - < "$REPO_DIR/system/packages/aur-foreign-explicit.txt" || true
  fi
else
  echo "paru/yay not found. AUR packages skipped."
fi

if command -v flatpak >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/flatpak-apps.txt" ]; then
  while read -r app; do
    [ -n "$app" ] && flatpak install -y flathub "$app" || true
  done < "$REPO_DIR/system/packages/flatpak-apps.txt"
fi

echo
echo "=== Syncing dotfiles to HOME ==="
rsync -a "$REPO_DIR/dotfiles/home/" "$HOME/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.config/" "$HOME/.config/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.local/" "$HOME/.local/" 2>/dev/null || true

echo
echo "=== Installing Steam compatibility tools ==="
if [ -x "$REPO_DIR/scripts/install-steam-dwproton-soda.sh" ]; then
  bash "$REPO_DIR/scripts/install-steam-dwproton-soda.sh" || echo "WARNING: Steam compatibility tools install failed; continuing."
else
  echo "WARNING: install-steam-dwproton-soda.sh not found."
fi

echo
echo "=== Gaming service preference ==="
sudo systemctl disable --now ananicy-cpp 2>/dev/null || true
sudo systemctl disable --now ananicy 2>/dev/null || true

echo
echo "Done. Reboot or relogin is recommended."
