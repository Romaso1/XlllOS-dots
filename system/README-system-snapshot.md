# XlllOS system snapshot

Updated: 2026-05-03_02-51-48

Current setup:

- AUR/native Bottles installed
- Flatpak Bottles removed
- cachyos-gaming-meta installed
- DWProton auto-installs into AUR/native Bottles from repo restore

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
