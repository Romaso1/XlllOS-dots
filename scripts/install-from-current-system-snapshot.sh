#!/usr/bin/env bash
set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== Installing native packages from snapshot ==="

if command -v pacman >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/pacman-native-explicit.txt" ]; then
  sudo pacman -S --needed - < "$REPO_DIR/system/packages/pacman-native-explicit.txt" || true
fi

echo
echo "=== Installing AUR packages from snapshot ==="

if command -v paru >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/aur-foreign-explicit.txt" ]; then
  paru -S --needed - < "$REPO_DIR/system/packages/aur-foreign-explicit.txt" || true
elif command -v yay >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/aur-foreign-explicit.txt" ]; then
  yay -S --needed - < "$REPO_DIR/system/packages/aur-foreign-explicit.txt" || true
else
  echo "paru/yay not found or AUR snapshot missing. AUR packages may be skipped."
fi

echo
echo "=== Guaranteed Bottles full setup ==="

if [ -x "$REPO_DIR/scripts/install-bottles-full-setup.sh" ]; then
  bash "$REPO_DIR/scripts/install-bottles-full-setup.sh" || echo "WARNING: Bottles full setup failed; continuing."
else
  echo "WARNING: install-bottles-full-setup.sh not found."
fi

echo
echo "=== Syncing dotfiles to HOME ==="

rsync -a "$REPO_DIR/dotfiles/home/" "$HOME/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.config/" "$HOME/.config/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.local/" "$HOME/.local/" 2>/dev/null || true

echo
echo "Done. Reboot or relogin is recommended."
