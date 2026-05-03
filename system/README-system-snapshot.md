# XlllOS system snapshot

Updated: 2026-05-03_03-16-00

Current setup:

- AUR/native Bottles installed
- Flatpak Bottles removed
- DWProton auto-installs into AUR/native Bottles
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
