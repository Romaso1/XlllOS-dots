# XlllOS system snapshot

Updated: 2026-05-03_04-37-21

This repo stores a safe snapshot of the current system:

- pacman native explicit packages
- AUR explicit packages
- Flatpak app list/remotes
- selected dotfiles and configs
- selected safe /etc configs
- services/timers state
- hardware/gaming state

Restore command:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

The restore helper explicitly installs:

```text
cachyos-gaming-meta
AUR/native Bottles
Soda runner
DWProton runner
DXVK
VKD3D-Proton
DXVK-NVAPI
LatencyFleX
Flatpak apps from snapshot
dotfiles
```

Secrets are intentionally excluded:

```text
SSH keys
GPG keys
browser profiles/cookies/passwords
keyrings
tokens
.env files
VPN/network secrets
Bottles prefixes/user bottles
Steam libraries/user data
```
