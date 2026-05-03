# XlllOS Dots

Моя настройка CachyOS/Arch Hyprland.

Это не отдельный Linux-дистрибутив, а набор dotfiles, системных snapshot-файлов и restore-скриптов, которые восстанавливают моё окружение:

- Hyprland / Quickshell / Illogical Impulse
- Kitty / Fish / Starship
- GTK / Qt / Kvantum themes
- CachyOS gaming meta
- AUR/native Bottles
- Soda runner
- DWProton runner
- DXVK / VKD3D-Proton / DXVK-NVAPI / LatencyFleX
- Flatpak apps from snapshot
- performance mode / CPU governor / EPP performance
- selected safe system configs and services

## Быстрая установка

### NVIDIA

```bash
bash -lc 'set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "$HOME/XlllOS-dots/.git" ]; then git -C "$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "$HOME/XlllOS-dots"; fi; cd "$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; [ -x ./scripts/gpu-nvidia.sh ] && ./scripts/gpu-nvidia.sh || true; sudo reboot'
```

### AMD

```bash
bash -lc 'set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "$HOME/XlllOS-dots/.git" ]; then git -C "$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "$HOME/XlllOS-dots"; fi; cd "$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; [ -x ./scripts/gpu-amd.sh ] && ./scripts/gpu-amd.sh || true; sudo reboot'
```

## Основная restore-команда

```bash
cd ~/XlllOS-dots
bash scripts/install-from-current-system-snapshot.sh
```

## Что гарантированно восстанавливается

Restore helper делает отдельные шаги:

```text
pacman native packages from system/packages/pacman-native-explicit.txt
cachyos-gaming-meta
AUR packages from system/packages/aur-foreign-explicit.txt
Flatpak apps from system/packages/flatpak-apps.txt
AUR/native Bottles full setup
dotfiles
```

Bottles full setup ставит:

```text
AUR/native Bottles
Soda
DWProton
DXVK
VKD3D-Proton
DXVK-NVAPI
LatencyFleX
```

## Важные файлы

```text
install.sh
scripts/install-from-current-system-snapshot.sh
scripts/install-bottles-full-setup.sh
system/packages/pacman-native-explicit.txt
system/packages/aur-foreign-explicit.txt
system/packages/flatpak-apps.txt
system/README-system-snapshot.md
dotfiles/
```

## Проверка после установки

```bash
command -v bottles
pacman -Q bottles
pacman -Q cachyos-gaming-meta

find ~/.local/share/bottles/runners -maxdepth 2 \( -type d -o -type f \) | sort

find ~/.local/share/bottles/dxvk \
     ~/.local/share/bottles/vkd3d \
     ~/.local/share/bottles/nvapi \
     ~/.local/share/bottles/latencyflex \
     ~/.local/share/bottles/winebridge \
     -maxdepth 3 \( -type d -o -type f \) 2>/dev/null | sort
```

## Что не хранится в репозитории

Секреты и тяжёлые пользовательские данные специально исключены:

```text
SSH/GPG keys
browser cookies/passwords/profiles
keyrings
tokens
.env files
VPN/network secrets
Steam libraries/userdata
Bottles bottle prefixes
cache/log/session files
```

## GPU

GPU-настройка вынесена отдельно:

```bash
scripts/gpu-nvidia.sh
scripts/gpu-amd.sh
```

После установки лучше перезагрузиться.
