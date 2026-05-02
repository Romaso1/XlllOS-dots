#!/usr/bin/env bash
set -Eeuo pipefail

DWPROTON_VERSION="${DWPROTON_VERSION:-10.0-26}"
SODA_VERSION="${SODA_VERSION:-9.0-1}"

DWPROTON_NAME="dwproton-${DWPROTON_VERSION}"
SODA_NAME="soda-${SODA_VERSION}"
SODA_TOOL_NAME="Soda-${SODA_VERSION}-Bottles"

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

download_file() {
  local url="$1"
  local out="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -L --fail --progress-bar "$url" -o "$out"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$out" "$url"
  else
    echo "ERROR: curl/wget not found."
    return 1
  fi
}

write_proton_vdf() {
  local dst="$1"
  local tool_key="$2"
  local display_name="$3"

  cat > "$dst/compatibilitytool.vdf" <<VDF
"compatibilitytools"
{
  "compat_tools"
  {
    "$tool_key"
    {
      "install_path" "."
      "display_name" "$display_name"
      "from_oslist"  "windows"
      "to_oslist"    "linux"
    }
  }
}
VDF
}

install_dwproton_to_steam() {
  local steam_compat="$1"
  local dst="$steam_compat/$DWPROTON_NAME"
  local tarball="${DWPROTON_NAME}-x86_64.tar.xz"
  local url="https://dawn.wine/dawn-winery/dwproton/releases/download/${DWPROTON_NAME}/${tarball}"
  local tmp
  local src

  echo
  echo "=== Installing DWProton into Steam ==="

  if [ -x "$dst/proton" ]; then
    echo "DWProton already installed:"
    echo "$dst"
    write_proton_vdf "$dst" "$DWPROTON_NAME" "DWProton $DWPROTON_VERSION"
    return 0
  fi

  tmp="$(mktemp -d)"
  mkdir -p "$tmp/extract"

  echo "Downloading:"
  echo "$url"
  download_file "$url" "$tmp/$tarball"

  tar -xf "$tmp/$tarball" -C "$tmp/extract"

  src="$(find "$tmp/extract" -maxdepth 4 -type f -name proton -printf '%h\n' | head -n 1 || true)"

  if [ -z "$src" ]; then
    echo "ERROR: could not find proton launcher inside DWProton archive."
    rm -rf "$tmp"
    return 1
  fi

  rm -rf "$dst"
  mkdir -p "$dst"
  rsync -a --delete "$src/" "$dst/"
  chmod +x "$dst/proton" 2>/dev/null || true
  write_proton_vdf "$dst" "$DWPROTON_NAME" "DWProton $DWPROTON_VERSION"

  rm -rf "$tmp"

  echo "DWProton installed:"
  echo "$dst"
}

install_soda_to_steam() {
  local steam_compat="$1"
  local dst="$steam_compat/$SODA_TOOL_NAME"
  local tarball="${SODA_NAME}-x86_64.tar.xz"
  local url="https://github.com/bottlesdevs/wine/releases/download/${SODA_NAME}/${tarball}"
  local tmp
  local src=""
  local wine_bin=""

  echo
  echo "=== Installing Soda into Steam ==="

  if [ -d "$dst" ] && [ -x "$dst/proton" ] && [ -f "$dst/compatibilitytool.vdf" ]; then
    echo "Soda already installed:"
    echo "$dst"
    write_proton_vdf "$dst" "$SODA_TOOL_NAME" "Soda $SODA_VERSION (Steam)"
    return 0
  fi

  tmp="$(mktemp -d)"
  mkdir -p "$tmp/extract"

  echo "Downloading:"
  echo "$url"
  download_file "$url" "$tmp/$tarball"

  tar -xf "$tmp/$tarball" -C "$tmp/extract"

  wine_bin="$(find "$tmp/extract" -maxdepth 5 -type f -path '*/bin/wine' | head -n 1 || true)"

  if [ -z "$wine_bin" ]; then
    echo "ERROR: could not find bin/wine inside Soda archive."
    rm -rf "$tmp"
    return 1
  fi

  src="$(dirname "$(dirname "$wine_bin")")"

  rm -rf "$dst"
  mkdir -p "$dst"
  rsync -a --delete "$src/" "$dst/"

  write_proton_vdf "$dst" "$SODA_TOOL_NAME" "Soda $SODA_VERSION (Steam)"

  if [ ! -x "$dst/proton" ]; then
    cat > "$dst/proton" <<'WRAPPER'
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
    echo "${STEAM_COMPAT_DATA_PATH:-$HOME/.steam/steam/steamapps/compatdata/soda-steam}"
    exit 0
    ;;
  getnativepath)
    echo "$HERE"
    exit 0
    ;;
esac

export WINEPREFIX="${STEAM_COMPAT_DATA_PATH:-$HOME/.steam/steam/steamapps/compatdata/soda-steam}/pfx"
mkdir -p "$WINEPREFIX"

exec "$HERE/bin/wine" "$@"
WRAPPER
    chmod +x "$dst/proton"
  fi

  rm -rf "$tmp"

  echo "Soda installed:"
  echo "$dst"
}

main() {
  local steam_compat
  steam_compat="$(detect_steam_compat_dir)"

  echo "Steam compatibilitytools.d:"
  echo "$steam_compat"

  install_dwproton_to_steam "$steam_compat"
  install_soda_to_steam "$steam_compat"

  echo
  echo "Done. Restart Steam to see the tools."
  echo "Expected tools:"
  echo "  - DWProton $DWPROTON_VERSION"
  echo "  - Soda $SODA_VERSION (Steam)"
}

main "$@"
