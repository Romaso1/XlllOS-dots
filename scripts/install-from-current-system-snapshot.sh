#!/usr/bin/env bash
set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DWPROTON_VERSION="${DWPROTON_VERSION:-10.0-26}"
SODA_VERSION="${SODA_VERSION:-9.0-1}"

detect_steam_compat_dir() {
  local steam_root=""

  if [ -d "$HOME/.steam/root" ]; then
    steam_root="$HOME/.steam/root"
  elif [ -d "$HOME/.local/share/Steam" ]; then
    steam_root="$HOME/.local/share/Steam"
  else
    mkdir -p "$HOME/.steam/root"
    steam_root="$HOME/.steam/root"
  fi

  mkdir -p "$steam_root/compatibilitytools.d"
  printf "%s\n" "$steam_root/compatibilitytools.d"
}

install_dwproton_for_bottles() {
  local runner_name="dwproton-${DWPROTON_VERSION}"
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
    echo "WARNING: curl/wget not found. Cannot download ${runner_name}."
    rm -rf "$tmp_dir"
    return 1
  fi

  tar -xf "$tmp_dir/$tarball" -C "$tmp_dir/extract"
  extracted="$(find "$tmp_dir/extract" -maxdepth 3 -type f -name proton -printf '%h\n' | head -n 1 || true)"

  if [ -z "$extracted" ]; then
    echo "WARNING: could not find proton file inside ${tarball}"
    rm -rf "$tmp_dir"
    return 1
  fi

  rm -rf "$runners_dir/$runner_name"
  mv "$extracted" "$runners_dir/$runner_name"
  rm -rf "$tmp_dir"

  echo "Installed:"
  echo "$runners_dir/$runner_name"
}

install_soda_bottles_runner_to_steam() {
  local soda_name="soda-${SODA_VERSION}"
  local steam_tool_name="Soda-${SODA_VERSION}-Bottles"
  local steam_compat
  local soda_src=""
  local soda_dst

  echo
  echo "=== Copying Bottles Soda runner to Steam ==="

  steam_compat="$(detect_steam_compat_dir)"
  soda_dst="$steam_compat/$steam_tool_name"

  for candidate in \
    "$HOME/.local/share/bottles/runners/$soda_name" \
    "$HOME/.local/share/bottles/runners/soda-9.0.1" \
    "$HOME/.local/share/bottles/runners"/soda-9.0*; do
    if [ -d "$candidate" ]; then
      soda_src="$candidate"
      break
    fi
  done

  if [ -z "$soda_src" ]; then
    echo "WARNING: Soda runner not found in ~/.local/share/bottles/runners/"
    echo "Install/download Soda in Bottles first, then run this restore script again."
    return 0
  fi

  mkdir -p "$soda_dst"
  rsync -a --delete "$soda_src/" "$soda_dst/"

  cat > "$soda_dst/compatibilitytool.vdf" <<VDF
"compatibilitytools"
{
  "compat_tools"
  {
    "$steam_tool_name"
    {
      "install_path" "."
      "display_name" "Soda $SODA_VERSION (Bottles)"
      "from_oslist"  "windows"
      "to_oslist"    "linux"
    }
  }
}
VDF

  if [ ! -x "$soda_dst/proton" ] && [ -x "$soda_dst/bin/wine" ]; then
    cat > "$soda_dst/proton" <<'WRAPPER'
#!/usr/bin/env bash
set -Eeuo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export PATH="$HERE/bin:$PATH"
export WINEDLLPATH="$HERE/lib/wine:$HERE/lib32/wine:${WINEDLLPATH:-}"
export LD_LIBRARY_PATH="$HERE/lib:$HERE/lib32:${LD_LIBRARY_PATH:-}"

verb="${1:-run}"

case "$verb" in
  run|waitforexitandrun)
    shift || true
    ;;
  getcompatpath)
    echo "${STEAM_COMPAT_DATA_PATH:-$HOME/.steam/steam/steamapps/compatdata/soda-bottles}/pfx"
    exit 0
    ;;
  getnativepath)
    echo "$HERE"
    exit 0
    ;;
esac

export WINEPREFIX="${STEAM_COMPAT_DATA_PATH:-$HOME/.steam/steam/steamapps/compatdata/soda-bottles}/pfx"
mkdir -p "$WINEPREFIX"

exec "$HERE/bin/wine" "$@"
WRAPPER
    chmod +x "$soda_dst/proton"
  fi

  echo "Installed Soda Steam tool:"
  echo "$soda_dst"
  echo "Restart Steam."
}

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
echo "=== Gaming runners ==="
install_dwproton_for_bottles || echo "WARNING: DWProton install failed; continuing."
install_soda_bottles_runner_to_steam || echo "WARNING: Soda Steam copy failed; continuing."

echo
echo "=== Gaming service preference ==="
sudo systemctl disable --now ananicy-cpp 2>/dev/null || true
sudo systemctl disable --now ananicy 2>/dev/null || true

echo
echo "Done. Reboot or relogin is recommended."
