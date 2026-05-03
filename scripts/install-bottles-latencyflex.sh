#!/usr/bin/env bash
set -Eeuo pipefail

BASE="${BOTTLES_BASE:-$HOME/.local/share/bottles}"
TARGET="$BASE/latencyflex"
VERSION="${LATENCYFLEX_VERSION:-latencyflex-v0.1.1}"

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

echo "=== Installing LatencyFleX for Bottles ==="
echo "Base:    $BASE"
echo "Version: $VERSION"
echo "Target:  $TARGET/$VERSION"

mkdir -p "$TARGET"
mkdir -p "$BASE/bottles" "$BASE/runners" "$BASE/dxvk" "$BASE/vkd3d" "$BASE/nvapi" "$BASE/winebridge" "$BASE/temp" "$BASE/downloads" "$BASE/components"
mkdir -p "$HOME/.config/bottles" "$HOME/.cache/bottles"

if [ -d "$TARGET/$VERSION" ]; then
  echo "LatencyFleX already installed:"
  echo "$TARGET/$VERSION"
  chmod -R u+rwX "$BASE" "$HOME/.config/bottles" "$HOME/.cache/bottles" 2>/dev/null || true
  exit 0
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

MANIFEST_URL="https://cloud-mirror.usebottles.com/repo/components/latencyflex/${VERSION}.yml"

echo
echo "Downloading manifest:"
echo "$MANIFEST_URL"
download_file "$MANIFEST_URL" "$tmp/latencyflex.yml"

URL="$(grep -E "url:" "$tmp/latencyflex.yml" | head -n1 | sed "s/.*url:[[:space:]]*//; s/[\"']//g")"
FILE="$(grep -E "file_name:" "$tmp/latencyflex.yml" | head -n1 | sed "s/.*file_name:[[:space:]]*//; s/[\"']//g")"

if [ -z "$URL" ]; then
  echo "ERROR: URL not found in LatencyFleX manifest."
  cat "$tmp/latencyflex.yml"
  exit 1
fi

[ -n "$FILE" ] || FILE="${VERSION}.tar.xz"

echo
echo "Downloading LatencyFleX archive:"
echo "$URL"
download_file "$URL" "$tmp/$FILE"

mkdir -p "$tmp/extract"
tar -xf "$tmp/$FILE" -C "$tmp/extract"

SRC="$(find "$tmp/extract" -mindepth 1 -maxdepth 1 -type d | head -n1 || true)"
[ -n "$SRC" ] || SRC="$tmp/extract"

rm -rf "$TARGET/$VERSION"
mkdir -p "$TARGET/$VERSION"
rsync -a --delete "$SRC/" "$TARGET/$VERSION/"

chmod -R u+rwX "$BASE" "$HOME/.config/bottles" "$HOME/.cache/bottles" 2>/dev/null || true

echo
echo "Installed:"
echo "$TARGET/$VERSION"

echo
echo "LatencyFleX files:"
find "$TARGET/$VERSION" -maxdepth 3 \( -type d -o -type f \) 2>/dev/null | sort
