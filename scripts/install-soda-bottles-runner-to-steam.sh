#!/usr/bin/env bash
set -Eeuo pipefail

SODA_VERSION="${SODA_VERSION:-9.0-1}"
SODA_NAME="soda-${SODA_VERSION}"
STEAM_TOOL_NAME="Soda-${SODA_VERSION}-Bottles"

if [ -d "$HOME/.steam/root" ]; then
  STEAM_ROOT="$HOME/.steam/root"
elif [ -d "$HOME/.local/share/Steam" ]; then
  STEAM_ROOT="$HOME/.local/share/Steam"
else
  mkdir -p "$HOME/.steam/root"
  STEAM_ROOT="$HOME/.steam/root"
fi

STEAM_COMPAT="$STEAM_ROOT/compatibilitytools.d"
mkdir -p "$STEAM_COMPAT"

SODA_SRC=""
for candidate in \
  "$HOME/.local/share/bottles/runners/$SODA_NAME" \
  "$HOME/.local/share/bottles/runners/soda-9.0.1" \
  "$HOME/.local/share/bottles/runners"/soda-9.0*; do
  if [ -d "$candidate" ]; then
    SODA_SRC="$candidate"
    break
  fi
done

if [ -z "$SODA_SRC" ]; then
  echo "ERROR: Soda runner not found in ~/.local/share/bottles/runners/"
  exit 1
fi

SODA_DST="$STEAM_COMPAT/$STEAM_TOOL_NAME"

mkdir -p "$SODA_DST"
rsync -a --delete "$SODA_SRC/" "$SODA_DST/"

cat > "$SODA_DST/compatibilitytool.vdf" <<VDF
"compatibilitytools"
{
  "compat_tools"
  {
    "$STEAM_TOOL_NAME"
    {
      "install_path" "."
      "display_name" "Soda $SODA_VERSION (Bottles)"
      "from_oslist"  "windows"
      "to_oslist"    "linux"
    }
  }
}
VDF

if [ ! -x "$SODA_DST/proton" ] && [ -x "$SODA_DST/bin/wine" ]; then
  cat > "$SODA_DST/proton" <<'WRAPPER'
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
    echo "${STEAM_COMPAT_DATA_PATH:-$HOME/.steam/steam/steamapps/compatdata/soda-bottles}"
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
  chmod +x "$SODA_DST/proton"
fi

echo "Installed Soda Steam tool:"
echo "$SODA_DST"
echo "Restart Steam."
