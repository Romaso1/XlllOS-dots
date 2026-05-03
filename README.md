# XlllOS Dots

Моя настройка CachyOS/Arch Hyprland.

Это набор dotfiles, package snapshots и restore-скриптов, чтобы одной командой восстановить мою систему.

## NVIDIA

```bash
bash -lc 'set -euo pipefail; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "$HOME/XlllOS-dots/.git" ]; then git -C "$HOME/XlllOS-dots" pull --ff-only || git -C "$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "$HOME/XlllOS-dots"; fi; cd "$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; XLLLOS_GPU=nvidia ./install.sh; sudo reboot'
```

## AMD

```bash
bash -lc 'set -euo pipefail; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "$HOME/XlllOS-dots/.git" ]; then git -C "$HOME/XlllOS-dots" pull --ff-only || git -C "$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "$HOME/XlllOS-dots"; fi; cd "$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; XLLLOS_GPU=amd ./install.sh; sudo reboot'
```

## Что ставится

Эти команды запускают `install.sh`, а он восстанавливает систему из snapshot-файлов репозитория.

Ставится и применяется:

- pacman native packages
- AUR packages
- Flatpak apps
- `cachyos-gaming-meta`
- AUR/native Bottles
- Soda
- DWProton
- DXVK
- VKD3D-Proton
- DXVK-NVAPI
- LatencyFleX
- Hyprland / Quickshell / Kitty / Fish / GTK / Qt / Kvantum dotfiles
- gaming/performance defaults

## Проверка репозитория

В репозитории есть проверка готовности restore:

`bash scripts/check-restore-readiness.sh`

## Что не хранится

Не сохраняются секреты и тяжёлые пользовательские данные:

- SSH/GPG keys
- browser cookies/passwords/profiles
- keyrings
- tokens
- `.env`
- VPN/network secrets
- Steam libraries/userdata
- Bottles prefixes
- cache/log/session files
