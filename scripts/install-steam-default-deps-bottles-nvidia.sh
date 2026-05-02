#!/usr/bin/env bash
set -Eeuo pipefail

# XlllOS Steam default dependencies for mods + NVIDIA.
#
# Installs common Bottles-like dependencies into Steam Proton prefixes:
# - WebView2 / VC++ runtimes / fonts
# - DirectX helper DLLs
# - XAudio / XInput / DSound
# - MSXML / GDI+ / Quartz / Devenum
# - NVIDIA/NVAPI registry tweaks
#
# Safe behavior:
# - skips when Steam/Proton/Wine is running, unless FORCE=1
# - processes every AppID only once using marker signature
# - REINSTALL=1 forces reinstall
#
# Usage:
#   bash scripts/install-steam-default-deps-bottles-nvidia.sh
#   FORCE=1 bash scripts/install-steam-default-deps-bottles-nvidia.sh
#   APPID=548430 FORCE=1 bash scripts/install-steam-default-deps-bottles-nvidia.sh
#   REINSTALL=1 FORCE=1 bash scripts/install-steam-default-deps-bottles-nvidia.sh
#   INSTALL_DOTNET=1 FORCE=1 bash scripts/install-steam-default-deps-bottles-nvidia.sh

DEFAULT_DEPS="
vcrun2003
vcrun2005
vcrun2008
vcrun2010
vcrun2012
vcrun2013
vcrun2022
d3dcompiler_43
d3dcompiler_47
d3dx9
d3dx10
d3dx11_42
d3dx11_43
xact
xinput
dsound
quartz
devenum
gdiplus
msxml3
msxml4
msxml6
corefonts
cjkfonts
tahoma
webview2
"

DOTNET_DEPS="
dotnet48
"

DEPS="${DEPS:-$DEFAULT_DEPS}"

if [ "${INSTALL_DOTNET:-0}" = "1" ]; then
  DEPS="$DEPS $DOTNET_DEPS"
fi

NVIDIA_FIXES="${NVIDIA_FIXES:-1}"
MARKER=".xlllos-default-deps-bottles-nvidia-installed"

COMPAT_DIRS=(
  "$HOME/.local/share/Steam/steamapps/compatdata"
  "$HOME/.steam/root/steamapps/compatdata"
)

log() {
  echo "[$(date +%Y-%m-%d_%H-%M-%S)] $*"
}

active_processes_exist() {
  # Do not mutate prefixes while games or Steam are active.
  # No pkill here, only checking.
  local names=(
    steam
    steamwebhelper
    proton
    wineserver
    wine
    wine64
    pressure-vessel
    reaper
  )

  for name in "${names[@]}"; do
    if pgrep -x "$name" >/dev/null 2>&1; then
      log "Active process found: $name"
      return 0
    fi
  done

  return 1
}

if ! command -v protontricks >/dev/null 2>&1; then
  log "ERROR: protontricks is not installed."
  log "Install it with: sudo pacman -S --needed protontricks"
  exit 1
fi

if [ "${FORCE:-0}" != "1" ] && active_processes_exist; then
  log "Steam/Proton/Wine is running. Skipping for safety."
  log "Close Steam/games or run manually with FORCE=1."
  exit 0
fi

signature() {
  {
    echo "$DEPS"
    echo "NVIDIA_FIXES=$NVIDIA_FIXES"
    echo "INSTALL_DOTNET=${INSTALL_DOTNET:-0}"
  } | sha256sum | awk '{print $1}'
}

SIGNATURE="$(signature)"

find_prefix_path() {
  local appid="$1"

  for compat in "${COMPAT_DIRS[@]}"; do
    if [ -d "$compat/$appid/pfx" ]; then
      echo "$compat/$appid/pfx"
      return 0
    fi
  done

  return 1
}

collect_appids() {
  if [ -n "${APPID:-}" ]; then
    echo "$APPID"
    return 0
  fi

  for compat in "${COMPAT_DIRS[@]}"; do
    [ -d "$compat" ] || continue

    find "$compat" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" 2>/dev/null \
      | grep -E "^[0-9]+$" || true
  done | sort -n | awk '!seen[$0]++'
}

install_deps_for_appid() {
  local appid="$1"
  local pfx

  if ! [[ "$appid" =~ ^[0-9]+$ ]]; then
    log "SKIP invalid AppID: $appid"
    return 0
  fi

  pfx="$(find_prefix_path "$appid" || true)"

  if [ -z "$pfx" ]; then
    log "SKIP APPID $appid: prefix not found"
    return 0
  fi

  if [ -f "$pfx/$MARKER" ] && grep -q "$SIGNATURE" "$pfx/$MARKER" && [ "${REINSTALL:-0}" != "1" ]; then
    log "SKIP APPID $appid: already processed with same dependency signature"
    return 0
  fi

  log "Installing default Bottles-like deps for APPID $appid"
  log "Prefix: $pfx"

  # Try quiet mode first, then fallback to normal mode.
  if protontricks "$appid" -q $DEPS; then
    log "Deps installed with quiet mode for APPID $appid"
  elif protontricks "$appid" $DEPS; then
    log "Deps installed with normal mode for APPID $appid"
  else
    log "WARNING: dependency install failed for APPID $appid"
    return 0
  fi

  if [ "$NVIDIA_FIXES" = "1" ]; then
    log "Applying NVIDIA/NVAPI registry tweaks for APPID $appid"

    # HAGS-like key sometimes helps mods/tools that check Windows graphics settings.
    protontricks -c 'wine reg add "HKLM\System\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f' "$appid" || true

    # Prefer native NVAPI when available through Proton/DXVK-NVAPI.
    protontricks -c 'wine reg add "HKCU\Software\Wine\DllOverrides" /v nvapi /d native,builtin /f' "$appid" || true
    protontricks -c 'wine reg add "HKCU\Software\Wine\DllOverrides" /v nvapi64 /d native,builtin /f' "$appid" || true
  fi

  {
    echo "Installed: $(date)"
    echo "AppID: $appid"
    echo "Signature: $SIGNATURE"
    echo "NVIDIA_FIXES: $NVIDIA_FIXES"
    echo "INSTALL_DOTNET: ${INSTALL_DOTNET:-0}"
    echo
    echo "Dependencies:"
    echo "$DEPS"
  } > "$pfx/$MARKER"

  log "OK APPID $appid"
}

log "Starting scan"
log "Signature: $SIGNATURE"

found=0

while IFS= read -r appid; do
  [ -n "$appid" ] || continue
  found=1
  install_deps_for_appid "$appid"
done < <(collect_appids)

if [ "$found" = "0" ]; then
  log "No Steam Proton prefixes found."
  log "Launch each Steam game once, close Steam, then run this script again."
fi

log "Done"
