#!/usr/bin/env bash
set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== XlllOS restore from system snapshot ==="
echo "Repo: $REPO_DIR"
echo

echo "=== Installing native packages from snapshot ==="

if command -v pacman >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/pacman-native-explicit.txt" ]; then
  sudo pacman -S --needed - < "$REPO_DIR/system/packages/pacman-native-explicit.txt" || true
else
  echo "pacman not found or pacman-native-explicit.txt missing."
fi

echo
echo "=== Installing CachyOS gaming meta explicitly ==="

if command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed cachyos-gaming-meta || echo "WARNING: cachyos-gaming-meta install failed; continuing."
fi

echo
echo "=== Installing AUR packages from snapshot ==="

if command -v paru >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/aur-foreign-explicit.txt" ]; then
  paru -S --needed - < "$REPO_DIR/system/packages/aur-foreign-explicit.txt" || true
elif command -v yay >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/aur-foreign-explicit.txt" ]; then
  yay -S --needed - < "$REPO_DIR/system/packages/aur-foreign-explicit.txt" || true
else
  echo "paru/yay not found or aur-foreign-explicit.txt missing. AUR packages may be skipped."
fi

echo
echo "=== Installing Flatpak apps from snapshot ==="

if command -v flatpak >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/flatpak-apps.txt" ]; then
  if ! flatpak remotes | grep -q "^flathub"; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true
  fi

  while IFS= read -r app; do
    [ -n "$app" ] || continue
    flatpak install -y --or-update flathub "$app" || true
  done < "$REPO_DIR/system/packages/flatpak-apps.txt"
else
  echo "flatpak not found or flatpak-apps.txt missing."
fi

echo
echo "=== Guaranteed Bottles full setup ==="

if [ -x "$REPO_DIR/scripts/install-bottles-full-setup.sh" ]; then
  bash "$REPO_DIR/scripts/install-bottles-full-setup.sh" || echo "WARNING: Bottles full setup failed; continuing."
elif [ -x "$REPO_DIR/scripts/install-bottles-aur-soda-dwproton.sh" ]; then
  bash "$REPO_DIR/scripts/install-bottles-aur-soda-dwproton.sh" || echo "WARNING: Bottles Soda/DWProton setup failed; continuing."
fi

if [ -x "$REPO_DIR/scripts/install-bottles-latencyflex.sh" ]; then
  bash "$REPO_DIR/scripts/install-bottles-latencyflex.sh" || echo "WARNING: Bottles LatencyFleX install failed; continuing."
fi

echo
echo "=== Syncing dotfiles to HOME ==="

rsync -a "$REPO_DIR/dotfiles/home/" "$HOME/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.config/" "$HOME/.config/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.local/" "$HOME/.local/" 2>/dev/null || true

echo
echo "=== Reloading Hyprland if available ==="
hyprctl reload 2>/dev/null || true

echo
echo "Done. Reboot or relogin is recommended."
