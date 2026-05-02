#!/usr/bin/env bash
set -euo pipefail

echo "=== Local syntax verification ==="
bash -n install.sh
bash -n scripts/gpu-nvidia.sh
bash -n scripts/gpu-amd.sh

echo
echo "=== Local line counts ==="
python3 - <<'PY'
from pathlib import Path
minimums = {
    "install.sh": 120,
    "scripts/gpu-nvidia.sh": 25,
    "scripts/gpu-amd.sh": 25,
    "README.md": 100,
    "packages-pacman.txt": 50,
    "packages-aur.txt": 5,
    ".gitattributes": 5,
    ".gitignore": 10,
}
for name, minimum in minimums.items():
    count = len(Path(name).read_text(encoding="utf-8", errors="ignore").splitlines())
    print(f"{name}: {count} lines")
    if count < minimum:
        raise SystemExit(f"{name} looks broken: {count} lines < {minimum}")
print("Repository files look OK.")
PY
