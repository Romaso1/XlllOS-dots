# XlllOS system snapshot

Updated: 2026-05-02_23-09-11

This folder contains a safe snapshot of the current PC:

- `packages/` - pacman, AUR and Flatpak package lists
- `services/` - enabled/disabled systemd services
- `hardware/` - system and hardware info
- `gaming/` - Steam/Proton/GameMode environment info

Restore helper:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

## Steam compatibility tools

The restore helper automatically installs into Steam:

```bash
DWProton 10.0-26
Soda 9.0-1 (Steam)
```

Manual install:

```bash
bash scripts/install-steam-dwproton-soda.sh
```

Steam target:

```bash
~/.steam/root/compatibilitytools.d/
```

Bottles is not required for this setup. The scripts download Soda directly from Bottles wine releases and DWProton directly from Dawn Winery releases.
