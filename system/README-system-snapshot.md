# XlllOS system snapshot

Updated: 2026-05-02_23-46-22

This snapshot reflects the current setup:

- Steam removed
- CachyOS gaming meta/applications removed
- Native/AUR Bottles removed
- Bottles installed via Flatpak
- Flatpak app list is included in `system/packages/flatpak-apps.txt`

Restore helper:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

Bottles Flatpak:

```bash
flatpak install -y flathub com.usebottles.bottles
```

Backup created before native Bottles deletion:

```bash
/home/xiii/XlllOS-bottles-aur-to-flatpak-backup-2026-05-02_23-46-22
```


## Flatpak Bottles DWProton

The restore helper automatically installs DWProton for Flatpak Bottles:

```bash
bash scripts/install-dwproton-flatpak-bottles.sh
```

Target:

```bash
~/.var/app/com.usebottles.bottles/data/bottles/runners/dwproton-10.0-26
```

