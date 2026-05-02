# XlllOS system snapshot

Updated: 2026-05-03_01-25-17

Current setup:

- Steam removed
- CachyOS gaming meta/applications removed
- Native/AUR Bottles removed
- Bottles installed via Flatpak
- DWProton automatically installed for Flatpak Bottles
- Flatpak Bottles permissions are kept safer: no full home access

Restore:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

Run Bottles:

```bash
flatpak run com.usebottles.bottles
```

DWProton target:

```bash
~/.var/app/com.usebottles.bottles/data/bottles/runners/dwproton-10.0-26
```

Recommended Bottles dependencies for Google/Facebook login in games:

```text
webview2
vcredist2022
corefonts
d3dcompiler_47
```
