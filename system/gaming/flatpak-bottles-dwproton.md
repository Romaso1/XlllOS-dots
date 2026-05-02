# Flatpak Bottles DWProton runner

Bottles is installed as Flatpak:

```bash
com.usebottles.bottles
```

DWProton is installed into:

```bash
~/.var/app/com.usebottles.bottles/data/bottles/runners/dwproton-10.0-26
```

Manual install:

```bash
bash scripts/install-dwproton-flatpak-bottles.sh
```

Restore helper automatically runs it:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

Useful Bottle dependencies for OAuth/login issues:

```text
webview2
vcredist2022
corefonts
d3dcompiler_47
```

DWProton binaries are not stored in this repo. Only the installer script is stored.
