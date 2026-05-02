#!/usr/bin/env bash
set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# BEGIN XlllOS Bottles DWProton auto-install
install_dwproton_for_bottles() {
  local version="${DWPROTON_VERSION:-10.0-26}"
  local runner_name="dwproton-${version}"
  local tarball="${runner_name}-x86_64.tar.xz"
  local url="https://dawn.wine/dawn-winery/dwproton/releases/download/${runner_name}/${tarball}"
  local runners_dir="$HOME/.local/share/bottles/runners"
  local tmp_dir
  local extracted

  echo
  echo "=== Installing Bottles runner: ${runner_name} ==="

  mkdir -p "$runners_dir"

  if [ -f "$runners_dir/$runner_name/proton" ] || [ -x "$runners_dir/$runner_name/proton" ]; then
    echo "${runner_name} already installed:"
    echo "$runners_dir/$runner_name"
    return 0
  fi

  tmp_dir="$(mktemp -d)"
  mkdir -p "$tmp_dir/extract"

  echo "Downloading:"
  echo "$url"

  if command -v curl >/dev/null 2>&1; then
    curl -L --fail --progress-bar "$url" -o "$tmp_dir/$tarball"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$tmp_dir/$tarball" "$url"
  else
    echo "ERROR: curl/wget not found. Cannot download ${runner_name}."
    rm -rf "$tmp_dir"
    return 1
  fi

  tar -xf "$tmp_dir/$tarball" -C "$tmp_dir/extract"

  extracted="$(find "$tmp_dir/extract" -maxdepth 3 -type f -name proton -printf '%h\n' | head -n 1 || true)"

  if [ -z "$extracted" ]; then
    echo "ERROR: could not find proton file inside ${tarball}"
    rm -rf "$tmp_dir"
    return 1
  fi

  rm -rf "$runners_dir/$runner_name"
  mv "$extracted" "$runners_dir/$runner_name"
  rm -rf "$tmp_dir"

  echo "Installed:"
  echo "$runners_dir/$runner_name"
}
# END XlllOS Bottles DWProton auto-install


echo "=== Installing packages from snapshot ==="

if command -v pacman >/dev/null 2>&1; then
  if [ -f "$REPO_DIR/system/packages/pacman-native-explicit.txt" ]; then
    sudo pacman -S --needed - < "$REPO_DIR/system/packages/pacman-native-explicit.txt"
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
  echo "paru/yay не найден. AUR пакеты не установлены."
fi

if command -v flatpak >/dev/null 2>&1 && [ -f "$REPO_DIR/system/packages/flatpak-apps.txt" ]; then
  while read -r app; do
    [ -n "$app" ] && flatpak install -y flathub "$app" || true
  done < "$REPO_DIR/system/packages/flatpak-apps.txt"
fi

echo
echo "=== Installing Bottles DWProton runner ==="
install_dwproton_for_bottles || echo "WARNING: DWProton install failed; continuing restore."

echo
echo "=== Syncing dotfiles to HOME ==="
rsync -a "$REPO_DIR/dotfiles/home/" "$HOME/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.config/" "$HOME/.config/" 2>/dev/null || true
rsync -a "$REPO_DIR/dotfiles/.local/" "$HOME/.local/" 2>/dev/null || true

echo
echo "=== Gaming service preference ==="
sudo systemctl disable --now ananicy-cpp 2>/dev/null || true
sudo systemctl disable --now ananicy 2>/dev/null || true

echo
echo "Done. Reboot or relogin is recommended."
