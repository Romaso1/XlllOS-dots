# XlllOS system snapshot

Updated: 2026-05-03_05-20-50

This repo stores a safe snapshot of the current system:

- pacman native explicit packages
- AUR explicit packages
- Flatpak app list/remotes
- selected dotfiles and configs
- selected safe /etc configs
- services/timers state
- hardware/gaming state

Install commands are in README.md.

Restore flow is handled by:

- install.sh
- scripts/install-from-current-system-snapshot.sh
- scripts/install-bottles-full-setup.sh

The installer explicitly restores:

- cachyos-gaming-meta
- AUR/native Bottles
- Soda
- DWProton
- DXVK
- VKD3D-Proton
- DXVK-NVAPI
- LatencyFleX
- Flatpak apps
- dotfiles

Secrets are intentionally excluded.
