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
else
  echo "paru/yay not found. AUR packages skipped."
fi

echo
echo "=== Installing Bottles Soda/DWProton runners and components ==="
if [ -x "$REPO_DIR/scripts/install-bottles-aur-soda-dwproton.sh" ]; then
  bash "$REPO_DIR/scripts/install-bottles-aur-soda-dwproton.sh" || echo "WARNING: Bottles Soda/DWProton install failed; continuing."
else
  echo "WARNING: install-bottles-aur-soda-dwproton.sh not found."
fi

echo
echo "=== Syncing dotfiles to HOME ==="
rsync -a "$REPO_DIR/dotfiles/home/" "$HOME/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.config/" "$HOME/.config/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.local/" "$HOME/.local/" 2>/dev/null || true

echo
echo "Done. Reboot or relogin is recommended."

echo
echo "=== Installing Bottles LatencyFleX component ==="
if [ -x "$REPO_DIR/scripts/install-bottles-latencyflex.sh" ]; then
  bash "$REPO_DIR/scripts/install-bottles-latencyflex.sh" || echo "WARNING: Bottles LatencyFleX install failed; continuing."
else
  echo "WARNING: install-bottles-latencyflex.sh not found."
fi
