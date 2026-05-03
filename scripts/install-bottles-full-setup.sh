#!/usr/bin/env bash
set -Eeuo pipefail

# XlllOS full Bottles setup helper.
#
# This script is safe to run repeatedly.
# It guarantees AUR/native Bottles + required Bottles runners/components.

SODA_VERSION="${SODA_VERSION:-9.0-1}"
DWPROTON_VERSION="${DWPROTON_VERSION:-10.0-26}"
LATENCYFLEX_VERSION="${LATENCYFLEX_VERSION:-latencyflex-v0.1.1}"

BASE="${BOTTLES_BASE:-$HOME/.local/share/bottles}"
RUNNERS_DIR="${BOTTLES_RUNNERS_DIR:-$BASE/runners}"

SODA_RUNNER="soda-${SODA_VERSION}"
DWPROTON_RUNNER="dwproton-${DWPROTON_VERSION}"

SODA_URL="https://github.com/bottlesdevs/wine/releases/download/${SODA_RUNNER}/${SODA_RUNNER}-x86_64.tar.xz"
DWPROTON_URL="https://dawn.wine/dawn-winery/dwproton/releases/download/${DWPROTON_RUNNER}/${DWPROTON_RUNNER}-x86_64.tar.xz"

echo "=== XlllOS full Bottles setup ==="
echo "Base:        $BASE"
echo "Runners:     $RUNNERS_DIR"
echo "Soda:        $SODA_RUNNER"
echo "DWProton:    $DWPROTON_RUNNER"
echo "LatencyFleX: $LATENCYFLEX_VERSION"
echo

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

install_native_deps() {
  echo
  echo "=== Installing Bottles native dependencies ==="

  local pkgs=(
    rsync
    curl
    wget
    tar
    xz
    zstd
    unzip
    python
    xdg-utils
    desktop-file-utils
    gvfs
    webkit2gtk-4.1
    gamemode
    lib32-gamemode
    vkd3d
    lib32-vkd3d
    vulkan-icd-loader
    lib32-vulkan-icd-loader
    lib32-gnutls
    wine-cachyos-opt
  )

  local available=()
  local p

  for p in "${pkgs[@]}"; do
    if pacman -Si "$p" >/dev/null 2>&1; then
      available+=("$p")
    else
      echo "Skip unavailable package: $p"
    fi
  done

  if [ "${#available[@]}" -gt 0 ]; then
    sudo pacman -S --needed "${available[@]}" || true
  fi
}

install_aur_bottles() {
  echo
  echo "=== Installing AUR/native Bottles ==="

  if command -v bottles >/dev/null 2>&1 && pacman -Q bottles >/dev/null 2>&1; then
    echo "Bottles already installed:"
    command -v bottles
    pacman -Q bottles
    return 0
  fi

  if command -v paru >/dev/null 2>&1; then
    paru -S --needed bottles
  elif command -v yay >/dev/null 2>&1; then
    yay -S --needed bottles
  else
    echo "ERROR: paru/yay not found. Cannot install AUR Bottles."
    return 1
  fi

  echo
  echo "Bottles installed:"
  command -v bottles || true
  pacman -Q bottles || true
}

prepare_dirs() {
  echo
  echo "=== Preparing Bottles folders ==="

  mkdir -p "$BASE/bottles"
  mkdir -p "$BASE/runners"
  mkdir -p "$BASE/dxvk"
  mkdir -p "$BASE/vkd3d"
  mkdir -p "$BASE/nvapi"
  mkdir -p "$BASE/latencyflex"
  mkdir -p "$BASE/winebridge"
  mkdir -p "$BASE/temp"
  mkdir -p "$BASE/downloads"
  mkdir -p "$BASE/components"
  mkdir -p "$HOME/.config/bottles"
  mkdir -p "$HOME/.cache/bottles"

  chmod -R u+rwX "$BASE" "$HOME/.config/bottles" "$HOME/.cache/bottles" 2>/dev/null || true
}

extract_runner_src() {
  local extract_dir="$1"
  local marker
  marker="$(find "$extract_dir" -maxdepth 7 -type f \( -name proton -o -path "*/bin/wine" \) | head -n 1 || true)"

  if [ -z "$marker" ]; then
    return 1
  fi

  local d
  d="$(dirname "$marker")"

  if [ "$(basename "$d")" = "bin" ]; then
    dirname "$d"
  else
    echo "$d"
  fi
}

install_runner_from_url() {
  local runner="$1"
  local url="$2"
  local marker_kind="$3"

  echo
  echo "=== Installing runner: $runner ==="
  echo "URL:    $url"
  echo "Target: $RUNNERS_DIR/$runner"

  mkdir -p "$RUNNERS_DIR"

  if [ "$marker_kind" = "proton" ] && [ -x "$RUNNERS_DIR/$runner/proton" ]; then
    echo "Already installed:"
    echo "$RUNNERS_DIR/$runner"
    return 0
  fi

  if [ "$marker_kind" = "wine" ] && [ -x "$RUNNERS_DIR/$runner/bin/wine" ]; then
    echo "Already installed:"
    echo "$RUNNERS_DIR/$runner"
    return 0
  fi

  local tmp archive extract src
  tmp="$(mktemp -d)"
  archive="$tmp/${runner}.tar.xz"
  extract="$tmp/extract"
  mkdir -p "$extract"

  download_file "$url" "$archive"
  tar -xf "$archive" -C "$extract"

  src="$(extract_runner_src "$extract" || true)"

  if [ -z "$src" ]; then
    echo "ERROR: runner source folder not found inside archive: $runner"
    find "$extract" -maxdepth 4 -type f | sort | head -n 80
    rm -rf "$tmp"
    return 1
  fi

  rm -rf "$RUNNERS_DIR/$runner"
  mkdir -p "$RUNNERS_DIR/$runner"
  rsync -a --delete "$src/" "$RUNNERS_DIR/$runner/"

  chmod +x "$RUNNERS_DIR/$runner/proton" 2>/dev/null || true
  chmod +x "$RUNNERS_DIR/$runner/bin/wine" 2>/dev/null || true
  chmod +x "$RUNNERS_DIR/$runner/bin/wine64" 2>/dev/null || true

  rm -rf "$tmp"

  echo "Installed:"
  echo "$RUNNERS_DIR/$runner"
}

download_latest_github_asset() {
  local repo="$1"
  local pattern="$2"
  local out="$3"

  python3 - "$repo" "$pattern" "$out" <<'PY'
import json, re, sys, urllib.request

repo, pattern, out = sys.argv[1], sys.argv[2], sys.argv[3]
url = f"https://api.github.com/repos/{repo}/releases/latest"

with urllib.request.urlopen(url, timeout=45) as r:
    data = json.load(r)

rx = re.compile(pattern)
assets = data.get("assets", [])

for a in assets:
    name = a.get("name", "")
    dl = a.get("browser_download_url", "")
    if rx.search(name):
        print(f"Downloading {name}")
        urllib.request.urlretrieve(dl, out)
        with open(out + ".name", "w", encoding="utf-8") as f:
            f.write(name)
        sys.exit(0)

print("No matching asset found")
print("Repo:", repo)
print("Pattern:", pattern)
print("Assets:", [a.get("name") for a in assets])
sys.exit(1)
PY
}

strip_archive_ext() {
  local name="$1"
  name="${name%.tar.gz}"
  name="${name%.tar.xz}"
  name="${name%.tar.zst}"
  echo "$name"
}

install_latest_component_generic() {
  local label="$1"
  local repo="$2"
  local pattern="$3"
  local target="$4"

  echo
  echo "=== Installing component: $label ==="
  echo "Target: $target"

  mkdir -p "$target"

  local tmp archive extract src name
  tmp="$(mktemp -d)"
  archive="$tmp/${label}.archive"
  extract="$tmp/extract"
  mkdir -p "$extract"

  if ! download_latest_github_asset "$repo" "$pattern" "$archive"; then
    echo "WARNING: failed to download latest $label"
    rm -rf "$tmp"
    return 0
  fi

  if ! tar -xf "$archive" -C "$extract"; then
    echo "WARNING: failed to extract $label"
    rm -rf "$tmp"
    return 0
  fi

  src="$(find "$extract" -mindepth 1 -maxdepth 1 -type d | head -n 1 || true)"

  if [ -z "$src" ]; then
    echo "WARNING: no extracted folder for $label"
    rm -rf "$tmp"
    return 0
  fi

  name="$(basename "$src")"

  rm -rf "$target/$name"
  mkdir -p "$target/$name"
  rsync -a --delete "$src/" "$target/$name/"

  rm -rf "$tmp"

  echo "Installed $label:"
  echo "$target/$name"
}

install_latest_nvapi() {
  local target="$BASE/nvapi"

  echo
  echo "=== Installing component: nvapi ==="
  echo "Target: $target"

  mkdir -p "$target"

  local tmp archive extract asset_name component_name src
  tmp="$(mktemp -d)"
  archive="$tmp/nvapi.archive"
  extract="$tmp/extract"
  mkdir -p "$extract"

  if ! download_latest_github_asset "jp7677/dxvk-nvapi" "^dxvk-nvapi-v?[0-9].*\\.(tar\\.gz|tar\\.xz|tar\\.zst)$" "$archive"; then
    echo "WARNING: failed to download latest nvapi"
    rm -rf "$tmp"
    return 0
  fi

  asset_name="$(cat "$archive.name")"
  component_name="$(strip_archive_ext "$asset_name")"

  if ! tar -xf "$archive" -C "$extract"; then
    echo "WARNING: failed to extract nvapi"
    rm -rf "$tmp"
    return 0
  fi

  # dxvk-nvapi archives may extract directly into x64/x32.
  # Bottles expects a versioned folder in ~/.local/share/bottles/nvapi/.
  if [ -f "$extract/x64/nvapi64.dll" ]; then
    src="$extract"
  else
    src="$(find "$extract" -type f -path "*/x64/nvapi64.dll" -printf "%h\n" | head -n 1 | sed 's#/x64$##' || true)"
  fi

  if [ -z "$src" ]; then
    echo "WARNING: no nvapi x64/nvapi64.dll found"
    find "$extract" -maxdepth 4 -type f | sort | head -n 80
    rm -rf "$tmp"
    return 0
  fi

  rm -rf "$target/x64" "$target/x86" "$target/x32"
  rm -rf "$target/$component_name"
  mkdir -p "$target/$component_name"
  rsync -a --delete "$src/" "$target/$component_name/"
  chmod -R u+rwX "$target/$component_name" 2>/dev/null || true

  rm -rf "$tmp"

  echo "Installed nvapi:"
  echo "$target/$component_name"
}

install_latencyflex() {
  local target="$BASE/latencyflex"
  local version="$LATENCYFLEX_VERSION"

  echo
  echo "=== Installing component: LatencyFleX ==="
  echo "Target: $target/$version"

  mkdir -p "$target"

  if [ -d "$target/$version" ]; then
    echo "Already installed:"
    echo "$target/$version"
    return 0
  fi

  local tmp manifest_url url file src
  tmp="$(mktemp -d)"

  manifest_url="https://cloud-mirror.usebottles.com/repo/components/latencyflex/${version}.yml"

  download_file "$manifest_url" "$tmp/latencyflex.yml"

  url="$(grep -E "url:" "$tmp/latencyflex.yml" | head -n1 | sed "s/.*url:[[:space:]]*//; s/[\"']//g")"
  file="$(grep -E "file_name:" "$tmp/latencyflex.yml" | head -n1 | sed "s/.*file_name:[[:space:]]*//; s/[\"']//g")"

  if [ -z "$url" ]; then
    echo "WARNING: URL not found in LatencyFleX manifest."
    cat "$tmp/latencyflex.yml"
    rm -rf "$tmp"
    return 0
  fi

  [ -n "$file" ] || file="${version}.tar.xz"

  download_file "$url" "$tmp/$file"

  mkdir -p "$tmp/extract"
  tar -xf "$tmp/$file" -C "$tmp/extract"

  src="$(find "$tmp/extract" -mindepth 1 -maxdepth 1 -type d | head -n1 || true)"
  [ -n "$src" ] || src="$tmp/extract"

  rm -rf "$target/$version"
  mkdir -p "$target/$version"
  rsync -a --delete "$src/" "$target/$version/"

  rm -rf "$tmp"

  echo "Installed LatencyFleX:"
  echo "$target/$version"
}

cleanup_temp() {
  rm -rf "$BASE/temp/"* "$BASE/downloads/"* "$HOME/.cache/bottles/"* 2>/dev/null || true
  chmod -R u+rwX "$BASE" "$HOME/.config/bottles" "$HOME/.cache/bottles" 2>/dev/null || true
}

final_report() {
  echo
  echo "=== Final Bottles state ==="
  command -v bottles || true
  pacman -Q bottles 2>/dev/null || true

  echo
  echo "=== Runners ==="
  find "$BASE/runners" -maxdepth 2 \( -type f -o -type d \) 2>/dev/null | sort | sed -n '1,160p' || true

  echo
  echo "=== Components ==="
  find "$BASE/dxvk" "$BASE/vkd3d" "$BASE/nvapi" "$BASE/latencyflex" "$BASE/winebridge" \
    -maxdepth 3 \( -type f -o -type d \) 2>/dev/null | sort | sed -n '1,240p' || true
}

install_native_deps
install_aur_bottles
prepare_dirs

install_runner_from_url "$SODA_RUNNER" "$SODA_URL" "wine"
install_runner_from_url "$DWPROTON_RUNNER" "$DWPROTON_URL" "proton"

install_latest_component_generic "dxvk" "doitsujin/dxvk" "^dxvk-[0-9].*\\.tar\\.gz$" "$BASE/dxvk"
install_latest_component_generic "vkd3d" "HansKristian-Work/vkd3d-proton" "^vkd3d-proton-[0-9].*\\.tar\\.(zst|gz|xz)$" "$BASE/vkd3d"
install_latest_nvapi
install_latencyflex

cleanup_temp
final_report

echo
echo "Done."
