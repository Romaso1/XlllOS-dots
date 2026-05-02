# XlllOS system snapshot

Updated: 2026-05-02_23-05-49

This folder contains a safe snapshot of the current PC:

- `packages/` - pacman, AUR and Flatpak package lists
- `services/` - enabled/disabled systemd services
- `hardware/` - system and hardware info
- `gaming/` - Steam/Proton/GameMode environment info

Restore helper:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

## Bottles removed

Bottles and its local data are intentionally removed from this setup.

## Soda in Steam

Soda is preserved as a Steam compatibility tool on the current machine:

```bash
/home/xiii/.steam/root/compatibilitytools.d/Soda-9.0-1-Bottles
```

Local backup:

```bash
/home/xiii/XlllOS-steam-soda-backup-2026-05-02_23-05-49/Soda-9.0-1-Bottles
```

The Soda runner binaries are not stored in this Git repo.
