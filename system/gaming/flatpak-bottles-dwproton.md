# Flatpak Bottles DWProton runner

Bottles is installed as Flatpak:

```bash
com.usebottles.bottles
```

DWProton is installed into the Flatpak Bottles runners directory:

```bash
~/.var/app/com.usebottles.bottles/data/bottles/runners/dwproton-10.0-26
```

Manual install:

```bash
bash scripts/install-dwproton-flatpak-bottles.sh
```

Restore helper automatically runs the same script:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

The DWProton runner binaries are not stored in this Git repo. The repo stores the installer script only.
