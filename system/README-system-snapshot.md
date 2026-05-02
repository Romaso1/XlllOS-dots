# XlllOS system snapshot

Updated: 2026-05-03_02-25-57

Current setup:

- cachyos-gaming-meta installed
- Flatpak Bottles installed
- DWProton installed automatically into Flatpak Bottles
- Restore helper keeps Flatpak Bottles + DWProton

Restore:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

Run Bottles:

```bash
flatpak run com.usebottles.bottles
```

DWProton target for Bottles:

```bash
~/.var/app/com.usebottles.bottles/data/bottles/runners/dwproton-10.0-26
```
