# AUR/native Bottles + Soda + DWProton

Bottles command:

```bash
bottles
```

Soda runner:

```bash
~/.local/share/bottles/runners/soda-9.0-1
```

DWProton runner:

```bash
~/.local/share/bottles/runners/dwproton-10.0-26
```

Manual install:

```bash
bash scripts/install-bottles-aur-soda-dwproton.sh
```

Restore helper automatically runs it:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

The runner archives themselves are not stored in this repo. The repo stores the installer script.

The helper also preloads DXVK/VKD3D/NVAPI components to avoid Bottles create-bottle errors caused by empty component lists.
