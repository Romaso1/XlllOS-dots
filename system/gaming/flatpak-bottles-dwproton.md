# Flatpak Bottles + DWProton

Current setup uses Flatpak Bottles:

```bash
com.usebottles.bottles
```

Run Bottles:

```bash
flatpak run com.usebottles.bottles
```

DWProton runner installed into:

```bash
~/.var/app/com.usebottles.bottles/data/bottles/runners/dwproton-10.0-26
```

Manual install:

```bash
bash scripts/install-dwproton-flatpak-bottles.sh
```

Restore helper automatically runs the same installer.

Recommended Bottle dependencies for login/mod-heavy games:

```text
webview2
vcredist2022
corefonts
d3dcompiler_47
```

Steam/CachyOS gaming stack is intentionally removed in this setup.
