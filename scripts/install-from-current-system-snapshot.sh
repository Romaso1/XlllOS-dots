#!/usr/bin/env bash
set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== Installing native packages from snapshot ==="

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

echo
echo "=== Installing Flatpak apps from snapshot ==="

if ! command -v flatpak >/dev/null 2>&1; then
  if command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed flatpak || true
  fi
fi

if command -v flatpak >/dev/null 2>&1; then
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true

  if [ -f "$REPO_DIR/system/packages/flatpak-apps.txt" ]; then
    while read -r app; do
      [ -n "$app" ] && flatpak install -y flathub "$app" || true
    done < "$REPO_DIR/system/packages/flatpak-apps.txt"
  fi

  if flatpak info com.usebottles.bottles >/dev/null 2>&1; then
    flatpak override --user --reset com.usebottles.bottles || true

    flatpak override --user com.usebottles.bottles \
      --share=network \
      --talk-name=org.freedesktop.portal.Desktop \
      --filesystem=xdg-download \
      --filesystem=xdg-documents \
      --filesystem=xdg-desktop \
      --filesystem=/mnt \
      --filesystem=/run/media \
      --filesystem=$HOME/Games:create || true
  fi
else
  echo "Flatpak still not available. Flatpak apps skipped."
fi

echo
echo "=== Syncing dotfiles to HOME ==="
rsync -a "$REPO_DIR/dotfiles/home/" "$HOME/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.config/" "$HOME/.config/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.local/" "$HOME/.local/" 2>/dev/null || true

echo
echo "Done. Reboot or relogin is recommended."

echo
echo "=== Installing DWProton for Flatpak Bottles ==="
if [ -x "$REPO_DIR/scripts/install-dwproton-flatpak-bottles.sh" ]; then
  bash "$REPO_DIR/scripts/install-dwproton-flatpak-bottles.sh" || echo "WARNING: DWProton Flatpak Bottles install failed; continuing."
else
  echo "WARNING: install-dwproton-flatpak-bottles.sh not found."
fi
