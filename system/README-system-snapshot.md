# XlllOS system snapshot

Updated: 2026-05-03_03-49-14

Current setup:

- AUR/native Bottles installed
- Flatpak Bottles removed
- Bottles data was fully reset and re-created cleanly
- Soda auto-installs into AUR/native Bottles
- DWProton auto-installs into AUR/native Bottles
- DXVK/VKD3D/NVAPI components are preloaded for Bottles
- Hyprland Bottles/Wine windows use PortProton-like native floating rules
- Full system snapshots and dotfiles synced

Restore:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

Run Bottles:

```bash
bottles
```

AUR/native Bottles data path:

```bash
~/.local/share/bottles
```

Soda target:

```bash
~/.local/share/bottles/runners/soda-9.0-1
```

DWProton target:

```bash
~/.local/share/bottles/runners/dwproton-10.0-26
```

## Bottles LatencyFleX

Bottles essential component auto-install is enabled.

Target:

```bash
~/.local/share/bottles/latencyflex/latencyflex-v0.1.1
```

Manual install:

```bash
bash scripts/install-bottles-latencyflex.sh
```

Restore:

```bash
bash scripts/install-from-current-system-snapshot.sh
```
