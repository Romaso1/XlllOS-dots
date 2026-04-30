#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

bash -n install.sh
bash -n scripts/install-steam.sh
bash -n scripts/gpu-nvidia.sh
bash -n scripts/gpu-amd.sh

python3 - <<'PY'
from pathlib import Path
checks = {
    "install.sh": 100,
    "scripts/install-steam.sh": 15,
    "scripts/gpu-nvidia.sh": 25,
    "scripts/gpu-amd.sh": 25,
    "README.md": 100,
    "packages-pacman.txt": 100,
    "packages-aur.txt": 10,
}
failed = False
for name, minimum in checks.items():
    count = len(Path(name).read_text(encoding="utf-8", errors="ignore").splitlines())
    print(f"{name}: {count} lines")
    if count < minimum:
        failed = True
if failed:
    raise SystemExit("Some files look broken")
PY

echo "Repository files look OK."
