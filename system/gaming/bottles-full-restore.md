# Guaranteed Bottles restore

The repo restore helper guarantees AUR/native Bottles installation and all required Bottles fixes.

Restore command:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

Main helper:

```bash
bash scripts/install-bottles-full-setup.sh
```

It installs:

```text
AUR/native Bottles
Soda runner: soda-9.0-1
DWProton runner: dwproton-10.0-26
DXVK
VKD3D-Proton
DXVK-NVAPI
LatencyFleX: latencyflex-v0.1.1
```

Important paths:

```bash
~/.local/share/bottles/runners/soda-9.0-1
~/.local/share/bottles/runners/dwproton-10.0-26
~/.local/share/bottles/dxvk
~/.local/share/bottles/vkd3d
~/.local/share/bottles/nvapi
~/.local/share/bottles/latencyflex
~/.local/share/bottles/winebridge
```

Reason:

Bottles AUR package alone does not always create/download all required components after a clean wipe. This helper forces the full setup.
