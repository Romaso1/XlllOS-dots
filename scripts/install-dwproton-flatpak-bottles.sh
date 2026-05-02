#!/usr/bin/env bash
set -Eeuo pipefail

DWPROTON_VERSION="${DWPROTON_VERSION:-10.0-26}"
FLATPAK_APP="${FLATPAK_APP:-com.usebottles.bottles}"

RUNNER="dwproton-${DWPROTON_VERSION}"
TARBALL="${RUNNER}-x86_64.tar.xz"
URL="https://dawn.wine/dawn-winery/dwproton/releases/download/${RUNNER}/${TARBALL}"
RUNNERS_DIR="$HOME/.var/app/${FLATPAK_APP}/data/bottles/runners"

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

echo "=== Installing DWProton for Flatpak Bottles ==="
echo "Runner: $RUNNER"
echo "Target: $RUNNERS_DIR"

if ! command -v flatpak >/dev/null 2>&1; then
  echo "ERROR: flatpak not installed."
  exit 1
fi

if ! flatpak info "$FLATPAK_APP" >/dev/null 2>&1; then
  echo "ERROR: Flatpak Bottles is not installed."
  exit 1
fi

flatpak kill "$FLATPAK_APP" 2>/dev/null || true
mkdir -p "$RUNNERS_DIR"

if [ -x "$RUNNERS_DIR/$RUNNER/proton" ]; then
  echo "DWProton already installed: $RUNNERS_DIR/$RUNNER"
  exit 0
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/extract"

download_file "$URL" "$tmp/$TARBALL"
tar -xf "$tmp/$TARBALL" -C "$tmp/extract"

src="$(find "$tmp/extract" -maxdepth 5 -type f -name proton -printf "%h\n" | head -n 1 || true)"
if [ -z "$src" ]; then
  echo "ERROR: proton file not found in archive."
  exit 1
fi

rm -rf "$RUNNERS_DIR/$RUNNER"
mkdir -p "$RUNNERS_DIR/$RUNNER"
rsync -a --delete "$src/" "$RUNNERS_DIR/$RUNNER/"
chmod +x "$RUNNERS_DIR/$RUNNER/proton" 2>/dev/null || true

echo "Installed: $RUNNERS_DIR/$RUNNER"
