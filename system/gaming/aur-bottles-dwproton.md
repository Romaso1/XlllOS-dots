# AUR/native Bottles + DWProton

Bottles command:

```bash
bottles
```

DWProton is installed into:

```bash
~/.local/share/bottles/runners/dwproton-10.0-26
```

Manual install:

```bash
bash scripts/install-dwproton-aur-bottles.sh
```

Restore helper automatically runs it:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

The DWProton archive itself is not stored in this repo. The repo stores the installer script.

If Bottles has no default runner after clean reset, open:

```text
Bottles -> Preferences -> Runners
```

and download a default runner such as Soda/Caffe/Vaniglia if needed.
