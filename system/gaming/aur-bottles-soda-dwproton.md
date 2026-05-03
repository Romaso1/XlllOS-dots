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

The helper preloads DXVK/VKD3D/NVAPI components. NVAPI must be installed into a versioned folder, for example:

```bash
~/.local/share/bottles/nvapi/dxvk-nvapi-vX.Y.Z
```

Not directly into:

```bash
~/.local/share/bottles/nvapi/x64
```
