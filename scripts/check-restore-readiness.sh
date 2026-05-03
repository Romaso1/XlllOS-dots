#!/usr/bin/env bash
set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

echo "=== XlllOS restore readiness check ==="

ok=1

need_file() {
  local f="$1"
  if [ -e "$f" ]; then
    echo "OK: $f"
  else
    echo "MISSING: $f"
    ok=0
  fi
}

need_exec() {
  local f="$1"
  if [ -x "$f" ]; then
    echo "OK executable: $f"
  else
    echo "MISSING executable: $f"
    ok=0
  fi
}

need_exec install.sh
need_exec scripts/install-from-current-system-snapshot.sh
need_exec scripts/install-bottles-full-setup.sh

need_file system/packages/pacman-native-explicit.txt
need_file system/packages/aur-foreign-explicit.txt
need_file system/packages/pacman-explicit.txt
need_file system/packages/flatpak-apps.txt
need_file dotfiles

echo
echo "=== Required packages in snapshots ==="
for pkg in cachyos-gaming-meta bottles; do
  echo "--- $pkg ---"
  if grep -Rnx "$pkg" system/packages/pacman-native-explicit.txt system/packages/pacman-explicit.txt system/packages/aur-foreign-explicit.txt 2>/dev/null; then
    true
  else
    echo "MISSING in package snapshots: $pkg"
    ok=0
  fi
done

echo
echo "=== Restore helper important lines ==="
grep -nE "cachyos-gaming-meta|install-bottles-full-setup|Flatpak|Syncing dotfiles" scripts/install-from-current-system-snapshot.sh || true

echo
if [ "$ok" = "1" ]; then
  echo "READY: repo restore looks good."
else
  echo "NOT READY: fix missing items above."
  exit 1
fi
