#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "=== Local syntax checks ==="
bash -n install.sh
bash -n scripts/install-steam.sh
bash -n scripts/gpu-nvidia.sh
bash -n scripts/gpu-amd.sh

echo "=== Local line counts ==="
python3 - <<'PY'
from pathlib import Path
checks = {
    'install.sh': 150,
    'scripts/install-steam.sh': 15,
    'scripts/gpu-nvidia.sh': 25,
    'scripts/gpu-amd.sh': 25,
    'README.md': 250,
    'packages-pacman.txt': 150,
    'packages-aur.txt': 10,
    '.gitattributes': 5,
    '.gitignore': 5,
}
failed = False
for name, minimum in checks.items():
    count = len(Path(name).read_text(encoding='utf-8', errors='ignore').splitlines())
    print(f'{name}: {count} lines')
    if count < minimum:
        failed = True
if failed:
    raise SystemExit('Some files look too short or broken.')
PY

echo "Repository files look OK."
