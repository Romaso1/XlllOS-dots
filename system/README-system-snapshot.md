# XlllOS system snapshot

Updated: 2026-05-03_01-35-29

Current setup:

- Bottles completely removed
- Flatpak Bottles removed
- Native/AUR Bottles removed
- Bottles data and launcher leftovers cleaned
- CachyOS gaming meta/applications installed
- Steam and gaming tools restored
- DWProton/Bottles automation removed from repo

Restore:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

Backup created before Bottles removal:

```bash
/home/xiii/XlllOS-bottles-removal-backup-2026-05-03_01-35-29
```


## Steam default dependencies for Bottles-like mods and NVIDIA

Steam/Proton uses a separate prefix for every game, so libraries cannot be installed once globally.

This repo uses a user systemd timer to make it behave like default automation:

```text
xlllos-steam-default-deps-bottles-nvidia.timer
```

The helper installs common Bottles-like libraries and NVIDIA/NVAPI tweaks into every existing/new Steam prefix:

```bash
bash scripts/install-steam-default-deps-bottles-nvidia.sh
```

ProtonPlus is used for managing Proton runners. Protontricks installs Windows dependencies inside game prefixes.

