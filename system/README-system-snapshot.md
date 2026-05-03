# XlllOS system snapshot

Updated: 2026-05-03_03-32-37

Current setup:

- AUR/native Bottles installed
- Flatpak Bottles removed
- Bottles data was fully reset and re-created cleanly
- DWProton auto-installs into AUR/native Bottles
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

DWProton target:

```bash
~/.local/share/bottles/runners/dwproton-10.0-26
```
