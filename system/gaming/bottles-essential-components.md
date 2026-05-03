# Bottles essential components

For clean AUR/native Bottles setup, these components should exist:

```text
~/.local/share/bottles/dxvk
~/.local/share/bottles/vkd3d
~/.local/share/bottles/nvapi
~/.local/share/bottles/latencyflex
~/.local/share/bottles/winebridge
```

If LatencyFleX is missing, Bottles may fail when creating a bottle with:

```text
Missing essential components
Fail to install components, tried 3 times
```

Manual fix:

```bash
bash scripts/install-bottles-latencyflex.sh
```

Restore helper runs this automatically:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

Installed LatencyFleX version:

```text
latencyflex-v0.1.1
```
