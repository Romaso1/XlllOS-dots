# XlllOS Dots

<p align="center">
  <img src="assets/preview.png" alt="XlllOS Preview" width="100%">
</p>

Моя настройка CachyOS Hyprland.

Это не отдельный Linux-дистрибутив, а набор dotfiles + установочный скрипт, который переносит внешний вид, Hyprland-конфиги, Quickshell/Illogical Impulse, терминал, fish shell, игровые пакеты и performance-настройки.

## Быстрая установка одной командой

### NVIDIA

Для NVIDIA / CachyOS / Arch / EndeavourOS:

~~~bash
bash -lc "set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "\$HOME/XlllOS-dots/.git" ]; then git -C "\$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "\$HOME/XlllOS-dots"; fi; cd "\$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; ./scripts/gpu-nvidia.sh; sudo reboot"
~~~

NVIDIA-команда ставит XlllOS-dots, удаляет AMD-специфичные Vulkan/Mesa/AMDGPU-пакеты и ставит NVIDIA-драйверы, OpenCL, Vulkan ICD, lib32-компоненты и NVIDIA VA-API.

### AMD

Для AMD-видеокарт:

~~~bash
bash -lc "set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "\$HOME/XlllOS-dots/.git" ]; then git -C "\$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "\$HOME/XlllOS-dots"; fi; cd "\$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; ./scripts/gpu-amd.sh; sudo reboot"
~~~

AMD-команда ставит XlllOS-dots, удаляет NVIDIA-пакеты и ставит Mesa/RADV, Vulkan Radeon, lib32-компоненты, VA-API/VDPAU для Mesa и AMDGPU Xorg-драйвер.

## Что устанавливается

### Основные компоненты и настройки

- Hyprland config
- Hyprlock / Hypridle
- Quickshell / Illogical Impulse config
- Kitty terminal config
- Fish shell config
- Starship prompt
- Обои и визуальный стиль
- Kvantum / Qt theme-настройки
- Dolphin / KDE file manager-настройки
- Alt + Shift для смены языка
- Отключение ускорения мыши
- Прозрачность терминала
- Отключение жёлтого фильтра / hyprsunset
- Автологин в обычный Hyprland
- CPU governor performance
- EPP performance
- Power profile performance
- Linux Steam
- PortProton
- Proton VPN
- Lutris
- Heroic Games Launcher
- MangoHud
- Gamescope
- GameMode
- ProtonUp-Qt
- Vulkan tools
- NVIDIA / AMD GPU setup через отдельные скрипты
- Firefox frame_rate 180, если найден профиль Firefox
- WARP helper-команды
- Quickshell widgets / desktop widgets
- Настройка монитора через custom-конфиг

### Pacman-пакеты из `packages-pacman.txt`

<details>
<summary>Показать полный список</summary>

~~~text
accountsservice
alacritty
alsa-firmware
alsa-plugins
alsa-utils
ark
awesome-terminal-fonts
base
base-devel
bash-completion
bat
bind
bluez
bluez-hid2hci
bluez-libs
bluez-obex
bluez-utils
btop
btrfs-assistant
btrfs-progs
cachyos-fish-config
cachyos-hello
cachyos-hooks
cachyos-kernel-manager
cachyos-keyring
cachyos-micro-settings
cachyos-mirrorlist
cachyos-packageinstaller
cachyos-plymouth-bootanimation
cachyos-plymouth-theme
cachyos-rate-mirrors
cachyos-settings
cachyos-snapper-support
cachyos-v3-mirrorlist
cachyos-v4-mirrorlist
cachyos-wallpapers
cachyos-zsh-config
cantarell-fonts
cava
chafa
chwd
cmatrix
cpupower
cryptsetup
device-mapper
diffutils
discord
dmidecode
dmraid
dnsmasq
dolphin
dosfstools
duf
e2fsprogs
efibootmgr
efitools
egl-wayland
ethtool
exfatprogs
eza
f2fs-tools
fastfetch
ffmpegthumbnailer
ffmpegthumbs
firefox
firefox-i18n-ru
fsarchiver
fzf
gamemode
git
glances
glow
goverlay
gst-libav
gst-plugin-pipewire
gst-plugins-bad
gst-plugins-ugly
hdparm
hwdetect
hwinfo
icoutils
inetutils
intel-ucode
iwd
jdownloader2
jfsutils
kate
kdegraphics-thumbnailers
kio-extras
konsole
kvantum
less
lib32-gamemode
lib32-libpulse
lib32-opencl-icd-loader
lib32-v4l-utils
lib32-vulkan-icd-loader
libdvdcss
libgsf
libmythes
libopenraw
libreoffice-still
limine
limine-mkinitcpio-hook
limine-snapper-sync
linux-cachyos
linux-cachyos-headers
linux-cachyos-lts
linux-cachyos-lts-headers
linux-firmware
logrotate
lsb-release
lsscsi
lutris
lvm2
man-db
mangohud
man-pages
mdadm
meld
mesa-utils
micro
mkinitcpio
modemmanager
mtools
nano
nano-syntax-highlighting
netctl
networkmanager-openvpn
nfs-utils
nilfs-utils
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
nss-mdns
opencl-icd-loader
openssh
os-prober
pacman-contrib
paru
perl
pipewire-alsa
pkgfile
plasma-browser-integration
plocate
plymouth
poppler-glib
power-profiles-daemon
proton-vpn-daemon
proton-vpn-gtk-app
pv
python
python-defusedxml
python-packaging
qbittorrent
qt5ct
qt6ct
rebuild-detector
reflector
sddm
sg3_utils
shelly
smartmontools
s-nail
snapper
sof-firmware
starship
sudo
sysfsutils
telegram-desktop
texinfo
tree
ttf-bitstream-vera
ttf-dejavu
ttf-liberation
ttf-meslo-nerd
ttf-opensans
ufw
ufw-extras
unrar
unzip
usb_modeswitch
usbutils
uwsm
vim
vlc
vlc-plugins-all
vulkan-icd-loader
vulkan-tools
which
wofi
wpa_supplicant
xfsprogs
xl2tpd
xorg-xwayland
yay
yazi
steam
~~~

</details>

### AUR / foreign-пакеты из `packages-aur.txt`

<details>
<summary>Показать полный список</summary>

~~~text
asciiquarium-transparent-git
cbonsai
cloudflare-warp-bin
illogical-impulse-basic
illogical-impulse-bibata-modern-classic-bin
illogical-impulse-fonts-themes
illogical-impulse-microtex-git
illogical-impulse-python
illogical-impulse-toolkit
peaclock
pipes.sh
portproton
tty-clock
upscayl-bin
heroic-games-launcher-bin
~~~

</details>

## Настройка монитора

Настройка монитора находится в custom:

~~~text
~/.config/hypr/custom/monitors.conf
~~~

Универсальный вариант:

~~~ini
monitor = , preferred, auto, 1
~~~

Для 3440x1440 180 Hz:

~~~ini
monitor = DP-1, 3440x1440@180, 0x0, 1
~~~

После изменения:

~~~bash
hyprctl reload
~~~

## Linux Steam

Linux Steam устанавливается автоматически через `scripts/install-steam.sh`.

Проверить после установки:

~~~bash
steam
~~~

## PortProton / Proton VPN

После установки PortProton уже будет установлен автоматически.

Steam, Wargaming Center и другие Windows-лаунчеры внутри PortProton каждый пользователь ставит сам. Вход в аккаунты выполняется только на своей системе.

Proton VPN устанавливается автоматически через `install.sh`.

Проверить:

~~~bash
systemctl status proton-vpn-daemon
~~~

## Quickshell быстро открывается и моментально закрывается

Если меню Quickshell, например звук, трей или быстрые настройки, открывается и сразу закрывается, скорее всего это из-за PortProton. Он может оставаться в фоне и ломать фокус popup-окон Quickshell.

Фикс:

~~~bash
pgrep -f "$HOME/PortProton|/usr/bin/portproton|yad_gui_pp" | xargs -r kill -9
~~~

Или просто сделайте перезагрузку системы.

## Game Launch Options

Обычный вариант:

~~~text
game-performance %command%
~~~

С MangoHud:

~~~text
mangohud game-performance %command%
~~~

С Gamescope:

~~~text
gamescope -f -W 3440 -H 1440 -r 180 -- game-performance %command%
~~~

С WINEDLLOVERRIDES:

~~~text
WINEDLLOVERRIDES="winmm,version=n,b" game-performance %command%
~~~

## WARP helper

~~~fish
warp on
warp off
warp status
~~~

WARP не включается автоматически при запуске системы. Его нужно включать вручную только при необходимости.

## Важно

Не добавлять в репозиторий:

- `~/.ssh`
- `~/.gnupg`
- `~/.mozilla`
- `~/.steam`
- `~/.local/share/Steam`
- `~/.cache`
- браузерные профили
- пароли
- токены
- личные документы
