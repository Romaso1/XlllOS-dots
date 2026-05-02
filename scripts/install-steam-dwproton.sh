#!/usr/bin/env bash
set -Eeuo pipefail

DWPROTON_VERSION="${DWPROTON_VERSION:-10.0-26}"

RUNNER="dwproton-${DWPROTON_VERSION}"
TARBALL="${RUNNER}-x86_64.tar.xz"
URL="https://dawn.wine/dawn-winery/dwproton/releases/download/${RUNNER}/${TARBALL}"

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

detect_steam_compat_dirs() {
  local dirs=()

  # Use existing Steam root if Steam has already created it.
  if [ -d "$HOME/.steam/root" ] || [ -L "$HOME/.steam/root" ]; then
    dirs+=("$HOME/.steam/root/compatibilitytools.d")
  fi

  # Common Arch/CachyOS Steam data path.
  dirs+=("$HOME/.local/share/Steam/compatibilitytools.d")

  # Existing compatibilitytools.d from all visible Steam paths.
  while IFS= read -r d; do
    dirs+=("$d")
  done < <(find "$HOME/.steam" "$HOME/.local/share/Steam" -path "*/compatibilitytools.d" -type d 2>/dev/null || true)

  printf "%s\n" "${dirs[@]}" | awk 'NF && !seen[$0]++'
}

safe_stop_steam() {
  echo "Stopping Steam with exact process names only..."

  # IMPORTANT:
  # Do NOT use "pkill -f steam" here.
  # It can kill this script because the script name contains "steam".
  for proc in \
    steam \
    steamwebhelper \
    steam-runtime-launcher-service \
    steam-runtime-supervisor; do
    pkill -x "$proc" 2>/dev/null || true
  done

  sleep 2
}

install_runner_to_dir() {
  local compat_dir="$1"
  local src="$2"

  mkdir -p "$compat_dir"

  echo
  echo "Installing to:"
  echo "$compat_dir/$RUNNER"

  rm -rf "$compat_dir/$RUNNER"
  mkdir -p "$compat_dir/$RUNNER"
  rsync -a --delete "$src/" "$compat_dir/$RUNNER/"
  chmod +x "$compat_dir/$RUNNER/proton" 2>/dev/null || true

  if [ ! -f "$compat_dir/$RUNNER/compatibilitytool.vdf" ]; then
    cat > "$compat_dir/$RUNNER/compatibilitytool.vdf" <<EOF
"compatibilitytools"
{
  "compat_tools"
  {
    "$RUNNER"
    {
      "install_path" "."
      "display_name" "DWProton $DWPROTON_VERSION"
      "from_oslist"  "windows"
      "to_oslist"    "linux"
    }
  }
}
EOF
  fi
}

echo "=== Installing DWProton into Steam ==="
echo "Version: $DWPROTON_VERSION"
echo "Runner:  $RUNNER"

if ! command -v steam >/dev/null 2>&1 && ! pacman -Q steam >/dev/null 2>&1; then
  echo "ERROR: Steam is not installed."
  exit 1
fi

safe_stop_steam

# If already installed in any known path, do not reinstall.
if detect_steam_compat_dirs | while IFS= read -r d; do [ -x "$d/$RUNNER/proton" ] && echo "$d/$RUNNER"; done | head -n 1 | grep -q .; then
  echo "DWProton already installed:"
  detect_steam_compat_dirs | while IFS= read -r d; do [ -x "$d/$RUNNER/proton" ] && echo "$d/$RUNNER"; done | sort
  exit 0
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/extract"

echo
echo "Downloading:"
echo "$URL"
download_file "$URL" "$tmp/$TARBALL"

echo
echo "Extracting..."
tar -xf "$tmp/$TARBALL" -C "$tmp/extract"

src="$(find "$tmp/extract" -maxdepth 5 -type f -name proton -printf "%h\n" | head -n 1 || true)"

if [ -z "$src" ]; then
  echo "ERROR: proton file not found inside archive."
  exit 1
fi

echo "Found source:"
echo "$src"

while IFS= read -r compat_dir; do
  [ -n "$compat_dir" ] && install_runner_to_dir "$compat_dir" "$src"
done < <(detect_steam_compat_dirs)

echo
echo "Installed DWProton. Restart Steam to see:"
echo "  DWProton $DWPROTON_VERSION"
