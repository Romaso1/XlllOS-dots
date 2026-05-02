# XlllOS system snapshot

Updated: 2026-05-03_02-19-11

Current setup:

- CachyOS gaming applications/meta removed
- Steam removed and Steam leftovers cleaned
- Steam/Protontricks/DWProton-for-Steam automation removed
- Flatpak Bottles installed
- DWProton installed automatically into Flatpak Bottles
- Restore helper installs Flatpak Bottles and DWProton for Bottles

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

Backup created before Steam/gaming cleanup:

```bash
/home/xiii/XlllOS-gaming-steam-removal-backup-2026-05-03_02-19-11
```
