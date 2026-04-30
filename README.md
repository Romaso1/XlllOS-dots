# XlllOS Dots

<p align="center">
  <img src="assets/preview.png" alt="XlllOS Preview" width="100%">
</p>

Моя настройка CachyOS Hyprland.

Это не отдельный Linux-дистрибутив, а набор dotfiles + установочный скрипт для установки моего Hyprland-окружения, Quickshell / Illogical Impulse, терминала, fish shell, игровых пакетов и performance-настроек.

## Быстрая установка одной командой

### NVIDIA

Для NVIDIA / CachyOS / Arch / EndeavourOS:

```bash
bash -lc 'set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "$HOME/XlllOS-dots/.git" ]; then git -C "$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "$HOME/XlllOS-dots"; fi; cd "$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; ./scripts/gpu-nvidia.sh; sudo reboot'
```

### AMD

Для AMD-видеокарт:

```bash
bash -lc 'set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "$HOME/XlllOS-dots/.git" ]; then git -C "$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "$HOME/XlllOS-dots"; fi; cd "$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; ./scripts/gpu-amd.sh; sudo reboot'
```

## Что устанавливается

- Hyprland / Hyprlock / Hypridle
- Quickshell / Illogical Impulse config
- Kitty terminal config
- Fish shell config
- Starship prompt
- Обои и визуальный стиль
- Dolphin / Kvantum / Qt theme
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
- MangoHud / Gamescope / GameMode
- ProtonUp-Qt
- Vulkan tools
- NVIDIA или AMD GPU setup отдельным скриптом
- Firefox frame_rate 180
- Desktop widgets с задержкой запуска 8 секунд
- Monitor config в `~/.config/hypr/custom/monitors.conf`

## Pacman-пакеты

<details>
<summary>Показать полный список</summary>

```text
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
jdownloader2-latest
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
man-pages
mangohud
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
steam
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
```

</details>

## AUR-пакеты

<details>
<summary>Показать полный список</summary>

```text
asciiquarium-transparent-git
cbonsai
cloudflare-warp-bin
heroic-games-launcher-bin
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
```

</details>

## Какие файлы переносятся и перезаписываются

Установщик сначала делает backup старых пользовательских конфигов, а уже потом копирует файлы из репозитория.

### Backup старых конфигов

Перед копированием эти папки переносятся в backup:

```text
~/.config/hypr              -> ~/.config-backup-xlllos-YYYY-MM-DD-HHMMSS/hypr
~/.config/illogical-impulse -> ~/.config-backup-xlllos-YYYY-MM-DD-HHMMSS/illogical-impulse
~/.config/kitty             -> ~/.config-backup-xlllos-YYYY-MM-DD-HHMMSS/kitty
~/.config/fish              -> ~/.config-backup-xlllos-YYYY-MM-DD-HHMMSS/fish
```

### Основные переносы из репозитория

После backup установщик копирует содержимое этих папок:

```text
~/XlllOS-dots/home/.config/     -> ~/.config/
~/XlllOS-dots/home/Pictures/    -> ~/Pictures/
~/XlllOS-dots/home/Wallpapers/  -> ~/Wallpapers/
~/XlllOS-dots/home/.local/      -> ~/.local/
```

Копирование выполняется через `rsync -a`, поэтому файлы с одинаковыми путями **перезаписываются**.

### Полный список пользовательских файлов, которые могут быть перенесены или перезаписаны

<details>
<summary>Показать полный список файлов из `home/`</summary>

```text
~/.config/Kvantum/Colloid/Colloid.kvconfig
~/.config/Kvantum/Colloid/Colloid.svg
~/.config/Kvantum/Colloid/ColloidDark.kvconfig
~/.config/Kvantum/Colloid/ColloidDark.svg
~/.config/Kvantum/MaterialAdw/MaterialAdw.kvconfig
~/.config/Kvantum/MaterialAdw/MaterialAdw.kvconfig.bak-stripes
~/.config/Kvantum/MaterialAdw/MaterialAdw.kvconfig.bak2
~/.config/Kvantum/MaterialAdw/MaterialAdw.svg
~/.config/Kvantum/kvantum.kvconfig
~/.config/dolphinrc
~/.config/fish/auto-Hypr.fish
~/.config/fish/conf.d/fish_frozen_key_bindings.fish
~/.config/fish/conf.d/fish_frozen_theme.fish
~/.config/fish/config.fish
~/.config/fish/fish_variables
~/.config/fish/functions/warp.fish
~/.config/fontconfig/fonts.conf
~/.config/gtk-3.0/gtk.css
~/.config/gtk-4.0/gtk.css
~/.config/hypr/custom/env.conf
~/.config/hypr/custom/execs.conf
~/.config/hypr/custom/general.conf
~/.config/hypr/custom/keybinds.conf
~/.config/hypr/custom/rules.conf
~/.config/hypr/custom/scripts/__restore_video_wallpaper.sh
~/.config/hypr/custom/variables.conf
~/.config/hypr/desktop-widgets.conf
~/.config/hypr/hypridle.conf
~/.config/hypr/hypridle.conf.new
~/.config/hypr/hyprland/colors.conf
~/.config/hypr/hyprland/env.conf
~/.config/hypr/hyprland/execs.conf
~/.config/hypr/hyprland/general.conf
~/.config/hypr/hyprland/keybinds.conf
~/.config/hypr/hyprland/rules.conf
~/.config/hypr/hyprland/scripts/ai/license_show-loaded-ollama-models.txt
~/.config/hypr/hyprland/scripts/ai/primary-buffer-query.sh
~/.config/hypr/hyprland/scripts/ai/show-loaded-ollama-models.sh
~/.config/hypr/hyprland/scripts/fuzzel-emoji.sh
~/.config/hypr/hyprland/scripts/launch_first_available.sh
~/.config/hypr/hyprland/scripts/snip_to_search.sh
~/.config/hypr/hyprland/scripts/start_geoclue_agent.sh
~/.config/hypr/hyprland/scripts/workspace_action.sh
~/.config/hypr/hyprland/scripts/zoom.sh
~/.config/hypr/hyprland/shellOverrides/main.conf
~/.config/hypr/hyprland/variables.conf
~/.config/hypr/hyprland.conf
~/.config/hypr/hyprlock/colors.conf
~/.config/hypr/hyprlock.conf
~/.config/hypr/hyprlock.conf.new
~/.config/hypr/monitors.conf
~/.config/hypr/monitors.conf.new
~/.config/hypr/scripts/desktop-widgets.sh
~/.config/hypr/workspaces.conf
~/.config/hypr/workspaces.conf.new
~/.config/illogical-impulse/config.json
~/.config/illogical-impulse/installed_listfile
~/.config/illogical-impulse/installed_true
~/.config/kdeglobals
~/.config/kitty/kitty.conf
~/.config/kitty/scroll_mark.py
~/.config/kitty/search.py
~/.config/mimeapps.list
~/.config/qt6ct/qss/dolphin-bar-match.qss
~/.config/qt6ct/qss/dolphin-kvantum-fix.qss
~/.config/qt6ct/qss/dolphin-topbar-transparent.qss
~/.config/quickshell/ii/.qmlformat.ini
~/.config/quickshell/ii/GlobalStates.qml
~/.config/quickshell/ii/ReloadPopup.qml
~/.config/quickshell/ii/assets/icons/ai-openai-symbolic.svg
~/.config/quickshell/ii/assets/icons/arch-symbolic.svg
~/.config/quickshell/ii/assets/icons/cachyos-symbolic.svg
~/.config/quickshell/ii/assets/icons/cloudflare-dns-symbolic.svg
~/.config/quickshell/ii/assets/icons/crosshair-symbolic.svg
~/.config/quickshell/ii/assets/icons/debian-symbolic.svg
~/.config/quickshell/ii/assets/icons/deepseek-symbolic.svg
~/.config/quickshell/ii/assets/icons/desktop-symbolic.svg
~/.config/quickshell/ii/assets/icons/endeavouros-symbolic.svg
~/.config/quickshell/ii/assets/icons/fedora-symbolic.svg
~/.config/quickshell/ii/assets/icons/flatpak-symbolic.svg
~/.config/quickshell/ii/assets/icons/fluent/.svg
~/.config/quickshell/ii/assets/icons/fluent/README.md
~/.config/quickshell/ii/assets/icons/fluent/add-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/add.svg
~/.config/quickshell/ii/assets/icons/fluent/alert-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/alert-off-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/alert-off.svg
~/.config/quickshell/ii/assets/icons/fluent/alert-snooze-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/alert-snooze.svg
~/.config/quickshell/ii/assets/icons/fluent/alert.svg
~/.config/quickshell/ii/assets/icons/fluent/app-generic-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/app-generic.svg
~/.config/quickshell/ii/assets/icons/fluent/apps-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/apps.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-clockwise-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-clockwise.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-counterclockwise-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-counterclockwise.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-enter-left-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-enter-left.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-left-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-left.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-right-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-right.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-sync.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-up-left-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/arrow-up-left.svg
~/.config/quickshell/ii/assets/icons/fluent/auto-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/auto.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-0.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-1.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-2.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-3.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-4.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-5.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-6.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-7.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-8.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-9.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-charge.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-full.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-saver.svg
~/.config/quickshell/ii/assets/icons/fluent/battery-warning.svg
~/.config/quickshell/ii/assets/icons/fluent/bluetooth-connected-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/bluetooth-connected.svg
~/.config/quickshell/ii/assets/icons/fluent/bluetooth-disabled-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/bluetooth-disabled.svg
~/.config/quickshell/ii/assets/icons/fluent/bluetooth-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/bluetooth-searching.svg
~/.config/quickshell/ii/assets/icons/fluent/bluetooth.svg
~/.config/quickshell/ii/assets/icons/fluent/calculator-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/calculator.svg
~/.config/quickshell/ii/assets/icons/fluent/calendar-add-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/calendar-add.svg
~/.config/quickshell/ii/assets/icons/fluent/camera-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/camera.svg
~/.config/quickshell/ii/assets/icons/fluent/caret-down-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/caret-down.svg
~/.config/quickshell/ii/assets/icons/fluent/caret-up-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/caret-up.svg
~/.config/quickshell/ii/assets/icons/fluent/checkmark-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/checkmark.svg
~/.config/quickshell/ii/assets/icons/fluent/chevron-down-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/chevron-down.svg
~/.config/quickshell/ii/assets/icons/fluent/chevron-left-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/chevron-left.svg
~/.config/quickshell/ii/assets/icons/fluent/chevron-right-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/chevron-right.svg
~/.config/quickshell/ii/assets/icons/fluent/chevron-up-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/chevron-up.svg
~/.config/quickshell/ii/assets/icons/fluent/cloudflare-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/cloudflare.svg
~/.config/quickshell/ii/assets/icons/fluent/corporation.svg
~/.config/quickshell/ii/assets/icons/fluent/crop-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/crop.svg
~/.config/quickshell/ii/assets/icons/fluent/cut-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/cut.svg
~/.config/quickshell/ii/assets/icons/fluent/dark-theme-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/dark-theme.svg
~/.config/quickshell/ii/assets/icons/fluent/desktop-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/desktop-speaker-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/desktop-speaker.svg
~/.config/quickshell/ii/assets/icons/fluent/desktop.svg
~/.config/quickshell/ii/assets/icons/fluent/device-eq-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/device-eq.svg
~/.config/quickshell/ii/assets/icons/fluent/dismiss.svg
~/.config/quickshell/ii/assets/icons/fluent/drink-coffee-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/drink-coffee.svg
~/.config/quickshell/ii/assets/icons/fluent/empty.svg
~/.config/quickshell/ii/assets/icons/fluent/ethernet-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/ethernet.svg
~/.config/quickshell/ii/assets/icons/fluent/eye-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/eye-off-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/eye-off.svg
~/.config/quickshell/ii/assets/icons/fluent/eye.svg
~/.config/quickshell/ii/assets/icons/fluent/eyedropper-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/eyedropper.svg
~/.config/quickshell/ii/assets/icons/fluent/fire-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/fire.svg
~/.config/quickshell/ii/assets/icons/fluent/flash-off-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/flash-off.svg
~/.config/quickshell/ii/assets/icons/fluent/flash-on-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/flash-on.svg
~/.config/quickshell/ii/assets/icons/fluent/games-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/games.svg
~/.config/quickshell/ii/assets/icons/fluent/globe-search-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/globe-search.svg
~/.config/quickshell/ii/assets/icons/fluent/globe-shield-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/globe-shield.svg
~/.config/quickshell/ii/assets/icons/fluent/headphones-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/headphones.svg
~/.config/quickshell/ii/assets/icons/fluent/image-copy-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/image-copy.svg
~/.config/quickshell/ii/assets/icons/fluent/image-edit-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/image-edit.svg
~/.config/quickshell/ii/assets/icons/fluent/image-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/image.svg
~/.config/quickshell/ii/assets/icons/fluent/keyboard-dock-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/keyboard-dock.svg
~/.config/quickshell/ii/assets/icons/fluent/keyboard-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/keyboard.svg
~/.config/quickshell/ii/assets/icons/fluent/leaf-two-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/leaf-two.svg
~/.config/quickshell/ii/assets/icons/fluent/library-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/library.svg
~/.config/quickshell/ii/assets/icons/fluent/lock-closed-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/lock-closed.svg
~/.config/quickshell/ii/assets/icons/fluent/lock-open-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/lock-open.svg
~/.config/quickshell/ii/assets/icons/fluent/mic-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/mic-off-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/mic-off.svg
~/.config/quickshell/ii/assets/icons/fluent/mic-on.svg
~/.config/quickshell/ii/assets/icons/fluent/mic.svg
~/.config/quickshell/ii/assets/icons/fluent/more-horizontal-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/more-horizontal.svg
~/.config/quickshell/ii/assets/icons/fluent/music-note-2-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/music-note-2.svg
~/.config/quickshell/ii/assets/icons/fluent/news-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/news.svg
~/.config/quickshell/ii/assets/icons/fluent/next-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/next.svg
~/.config/quickshell/ii/assets/icons/fluent/open-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/open.svg
~/.config/quickshell/ii/assets/icons/fluent/options-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/options.svg
~/.config/quickshell/ii/assets/icons/fluent/pause-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/pause.svg
~/.config/quickshell/ii/assets/icons/fluent/people-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/people-settings-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/people-settings.svg
~/.config/quickshell/ii/assets/icons/fluent/people-team-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/people-team.svg
~/.config/quickshell/ii/assets/icons/fluent/people.svg
~/.config/quickshell/ii/assets/icons/fluent/phone-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/phone.svg
~/.config/quickshell/ii/assets/icons/fluent/pin-off.svg
~/.config/quickshell/ii/assets/icons/fluent/pin.svg
~/.config/quickshell/ii/assets/icons/fluent/play-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/play.svg
~/.config/quickshell/ii/assets/icons/fluent/power-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/power.svg
~/.config/quickshell/ii/assets/icons/fluent/previous-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/previous.svg
~/.config/quickshell/ii/assets/icons/fluent/record-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/record.svg
~/.config/quickshell/ii/assets/icons/fluent/scan-text-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/scan-text.svg
~/.config/quickshell/ii/assets/icons/fluent/search-visual-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/search-visual.svg
~/.config/quickshell/ii/assets/icons/fluent/server-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/server.svg
~/.config/quickshell/ii/assets/icons/fluent/settings-cog-multiple-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/settings-cog-multiple.svg
~/.config/quickshell/ii/assets/icons/fluent/settings.svg
~/.config/quickshell/ii/assets/icons/fluent/shield-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/shield-lock-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/shield-lock.svg
~/.config/quickshell/ii/assets/icons/fluent/shield.svg
~/.config/quickshell/ii/assets/icons/fluent/speaker-0.svg
~/.config/quickshell/ii/assets/icons/fluent/speaker-1.svg
~/.config/quickshell/ii/assets/icons/fluent/speaker-2-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/speaker-mute-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/speaker-mute.svg
~/.config/quickshell/ii/assets/icons/fluent/speaker-none.svg
~/.config/quickshell/ii/assets/icons/fluent/speaker-off.svg
~/.config/quickshell/ii/assets/icons/fluent/speaker-settings.svg
~/.config/quickshell/ii/assets/icons/fluent/speaker.svg
~/.config/quickshell/ii/assets/icons/fluent/start-here-pressed.svg
~/.config/quickshell/ii/assets/icons/fluent/start-here.svg
~/.config/quickshell/ii/assets/icons/fluent/stop-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/stop.svg
~/.config/quickshell/ii/assets/icons/fluent/store-microsoft-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/store-microsoft.svg
~/.config/quickshell/ii/assets/icons/fluent/subtract-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/subtract.svg
~/.config/quickshell/ii/assets/icons/fluent/system-search-checked-dark.svg
~/.config/quickshell/ii/assets/icons/fluent/system-search-checked-light.svg
~/.config/quickshell/ii/assets/icons/fluent/system-search-dark.svg
~/.config/quickshell/ii/assets/icons/fluent/system-search-light.svg
~/.config/quickshell/ii/assets/icons/fluent/task-view-dark.svg
~/.config/quickshell/ii/assets/icons/fluent/task-view-light.svg
~/.config/quickshell/ii/assets/icons/fluent/task-view-pressed-dark.svg
~/.config/quickshell/ii/assets/icons/fluent/task-view-pressed-light.svg
~/.config/quickshell/ii/assets/icons/fluent/temperature-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/temperature.svg
~/.config/quickshell/ii/assets/icons/fluent/video-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/video.svg
~/.config/quickshell/ii/assets/icons/fluent/wand-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/wand.svg
~/.config/quickshell/ii/assets/icons/fluent/weather-moon-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/weather-moon-off-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/weather-moon-off.svg
~/.config/quickshell/ii/assets/icons/fluent/weather-moon.svg
~/.config/quickshell/ii/assets/icons/fluent/weather-sunny-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/weather-sunny.svg
~/.config/quickshell/ii/assets/icons/fluent/widgets.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-1-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-1.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-2-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-2.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-3-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-3.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-4-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-4.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-lock-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-lock.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-off-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-off.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-warning-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/wifi-warning.svg
~/.config/quickshell/ii/assets/icons/fluent/window-shield-filled.svg
~/.config/quickshell/ii/assets/icons/fluent/window-shield.svg
~/.config/quickshell/ii/assets/icons/gentoo-symbolic.svg
~/.config/quickshell/ii/assets/icons/github-symbolic.svg
~/.config/quickshell/ii/assets/icons/google-gemini-symbolic.svg
~/.config/quickshell/ii/assets/icons/linux-symbolic.svg
~/.config/quickshell/ii/assets/icons/microsoft-symbolic.svg
~/.config/quickshell/ii/assets/icons/mistral-symbolic.svg
~/.config/quickshell/ii/assets/icons/nixos-symbolic.svg
~/.config/quickshell/ii/assets/icons/nyarch-symbolic.svg
~/.config/quickshell/ii/assets/icons/ollama-symbolic.svg
~/.config/quickshell/ii/assets/icons/openai-symbolic.svg
~/.config/quickshell/ii/assets/icons/openrouter-symbolic.svg
~/.config/quickshell/ii/assets/icons/spark-symbolic.svg
~/.config/quickshell/ii/assets/icons/ubuntu-symbolic.svg
~/.config/quickshell/ii/assets/images/default_wallpaper.png
~/.config/quickshell/ii/defaults/ai/README.md
~/.config/quickshell/ii/defaults/ai/prompts/NoPrompt.md
~/.config/quickshell/ii/defaults/ai/prompts/ii-Default.md
~/.config/quickshell/ii/defaults/ai/prompts/ii-Imouto.md
~/.config/quickshell/ii/defaults/ai/prompts/nyarch-Acchan.md
~/.config/quickshell/ii/defaults/ai/prompts/w-FourPointedSparkle.md
~/.config/quickshell/ii/defaults/ai/prompts/w-OpenMechanicalFlower.md
~/.config/quickshell/ii/killDialog.qml
~/.config/quickshell/ii/modules/common/Appearance.qml
~/.config/quickshell/ii/modules/common/Config.qml
~/.config/quickshell/ii/modules/common/Directories.qml
~/.config/quickshell/ii/modules/common/Icons.qml
~/.config/quickshell/ii/modules/common/Images.qml
~/.config/quickshell/ii/modules/common/Persistent.qml
~/.config/quickshell/ii/modules/common/functions/ColorUtils.qml
~/.config/quickshell/ii/modules/common/functions/DateUtils.qml
~/.config/quickshell/ii/modules/common/functions/FileUtils.qml
~/.config/quickshell/ii/modules/common/functions/Fuzzy.qml
~/.config/quickshell/ii/modules/common/functions/Levendist.qml
~/.config/quickshell/ii/modules/common/functions/NotificationUtils.qml
~/.config/quickshell/ii/modules/common/functions/ObjectUtils.qml
~/.config/quickshell/ii/modules/common/functions/Session.qml
~/.config/quickshell/ii/modules/common/functions/StringUtils.qml
~/.config/quickshell/ii/modules/common/functions/fuzzysort.js
~/.config/quickshell/ii/modules/common/functions/levendist.js
~/.config/quickshell/ii/modules/common/models/AdaptedMaterialScheme.qml
~/.config/quickshell/ii/modules/common/models/AnimatedTabIndexPair.qml
~/.config/quickshell/ii/modules/common/models/FolderListModelWithHistory.qml
~/.config/quickshell/ii/modules/common/models/IndexModel.qml
~/.config/quickshell/ii/modules/common/models/LauncherSearchResult.qml
~/.config/quickshell/ii/modules/common/models/NestableObject.qml
~/.config/quickshell/ii/modules/common/models/gCloud/GCloudApi.qml
~/.config/quickshell/ii/modules/common/models/gCloud/GCloudTranslate.qml
~/.config/quickshell/ii/modules/common/models/gCloud/GCloudVision.qml
~/.config/quickshell/ii/modules/common/models/gCloud/GCloudVisionResult.qml
~/.config/quickshell/ii/modules/common/models/hyprland/HyprlandConfigOption.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/AntiFlashbangToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/AudioToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/BluetoothToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/CloudflareWarpToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/ColorPickerToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/DarkModeToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/EasyEffectsToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/GameModeToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/IdleInhibitorToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/MicToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/MusicRecognitionToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/NetworkToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/NightLightToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/NotificationToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/OnScreenKeyboardToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/PowerProfilesToggle.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/QuickToggleModel.qml
~/.config/quickshell/ii/modules/common/models/quickToggles/ScreenSnipToggle.qml
~/.config/quickshell/ii/modules/common/panels/lock/LockContext.qml
~/.config/quickshell/ii/modules/common/panels/lock/LockScreen.qml
~/.config/quickshell/ii/modules/common/panels/lock/pam/fprintd.conf
~/.config/quickshell/ii/modules/common/utils/ImageDownloaderProcess.qml
~/.config/quickshell/ii/modules/common/utils/MultiTurnProcess.qml
~/.config/quickshell/ii/modules/common/utils/ScreenshotAction.qml
~/.config/quickshell/ii/modules/common/utils/TempScreenshotProcess.qml
~/.config/quickshell/ii/modules/common/widgets/AddressBar.qml
~/.config/quickshell/ii/modules/common/widgets/AddressBreadcrumb.qml
~/.config/quickshell/ii/modules/common/widgets/ButtonGroup.qml
~/.config/quickshell/ii/modules/common/widgets/CalendarView.qml
~/.config/quickshell/ii/modules/common/widgets/Circle.qml
~/.config/quickshell/ii/modules/common/widgets/CircularProgress.qml
~/.config/quickshell/ii/modules/common/widgets/CliphistImage.qml
~/.config/quickshell/ii/modules/common/widgets/ClippedFilledCircularProgress.qml
~/.config/quickshell/ii/modules/common/widgets/ClippedProgressBar.qml
~/.config/quickshell/ii/modules/common/widgets/ConfigRow.qml
~/.config/quickshell/ii/modules/common/widgets/ConfigSelectionArray.qml
~/.config/quickshell/ii/modules/common/widgets/ConfigSlider.qml
~/.config/quickshell/ii/modules/common/widgets/ConfigSpinBox.qml
~/.config/quickshell/ii/modules/common/widgets/ConfigSwitch.qml
~/.config/quickshell/ii/modules/common/widgets/ContentPage.qml
~/.config/quickshell/ii/modules/common/widgets/ContentSection.qml
~/.config/quickshell/ii/modules/common/widgets/ContentSubsection.qml
~/.config/quickshell/ii/modules/common/widgets/ContentSubsectionLabel.qml
~/.config/quickshell/ii/modules/common/widgets/CustomIcon.qml
~/.config/quickshell/ii/modules/common/widgets/DashedBorder.qml
~/.config/quickshell/ii/modules/common/widgets/DialogButton.qml
~/.config/quickshell/ii/modules/common/widgets/DialogListItem.qml
~/.config/quickshell/ii/modules/common/widgets/DirectoryIcon.qml
~/.config/quickshell/ii/modules/common/widgets/DragManager.qml
~/.config/quickshell/ii/modules/common/widgets/ErrorShakeAnimation.qml
~/.config/quickshell/ii/modules/common/widgets/FadeLoader.qml
~/.config/quickshell/ii/modules/common/widgets/Favicon.qml
~/.config/quickshell/ii/modules/common/widgets/FloatingActionButton.qml
~/.config/quickshell/ii/modules/common/widgets/FlowButtonGroup.qml
~/.config/quickshell/ii/modules/common/widgets/FocusedScrollMouseArea.qml
~/.config/quickshell/ii/modules/common/widgets/FullscreenPolkitWindow.qml
~/.config/quickshell/ii/modules/common/widgets/Graph.qml
~/.config/quickshell/ii/modules/common/widgets/GroupButton.qml
~/.config/quickshell/ii/modules/common/widgets/IconAndTextToolbarButton.qml
~/.config/quickshell/ii/modules/common/widgets/IconToolbarButton.qml
~/.config/quickshell/ii/modules/common/widgets/KeyboardKey.qml
~/.config/quickshell/ii/modules/common/widgets/LightDarkPreferenceButton.qml
~/.config/quickshell/ii/modules/common/widgets/MaskMultiEffect.qml
~/.config/quickshell/ii/modules/common/widgets/MaterialCookie.qml
~/.config/quickshell/ii/modules/common/widgets/MaterialLoadingIndicator.qml
~/.config/quickshell/ii/modules/common/widgets/MaterialShape.qml
~/.config/quickshell/ii/modules/common/widgets/MaterialShapeWrappedMaterialSymbol.qml
~/.config/quickshell/ii/modules/common/widgets/MaterialSymbol.qml
~/.config/quickshell/ii/modules/common/widgets/MaterialTextArea.qml
~/.config/quickshell/ii/modules/common/widgets/MaterialTextField.qml
~/.config/quickshell/ii/modules/common/widgets/MenuButton.qml
~/.config/quickshell/ii/modules/common/widgets/NavigationRail.qml
~/.config/quickshell/ii/modules/common/widgets/NavigationRailButton.qml
~/.config/quickshell/ii/modules/common/widgets/NavigationRailExpandButton.qml
~/.config/quickshell/ii/modules/common/widgets/NavigationRailTabArray.qml
~/.config/quickshell/ii/modules/common/widgets/NoticeBox.qml
~/.config/quickshell/ii/modules/common/widgets/NotificationActionButton.qml
~/.config/quickshell/ii/modules/common/widgets/NotificationAppIcon.qml
~/.config/quickshell/ii/modules/common/widgets/NotificationGroup.qml
~/.config/quickshell/ii/modules/common/widgets/NotificationGroupExpandButton.qml
~/.config/quickshell/ii/modules/common/widgets/NotificationItem.qml
~/.config/quickshell/ii/modules/common/widgets/NotificationListView.qml
~/.config/quickshell/ii/modules/common/widgets/OptionalMaterialSymbol.qml
~/.config/quickshell/ii/modules/common/widgets/PagePlaceholder.qml
~/.config/quickshell/ii/modules/common/widgets/PointingHandInteraction.qml
~/.config/quickshell/ii/modules/common/widgets/PointingHandLinkHover.qml
~/.config/quickshell/ii/modules/common/widgets/PopupToolTip.qml
~/.config/quickshell/ii/modules/common/widgets/Revealer.qml
~/.config/quickshell/ii/modules/common/widgets/RippleButton.qml
~/.config/quickshell/ii/modules/common/widgets/RippleButtonWithIcon.qml
~/.config/quickshell/ii/modules/common/widgets/RoundCorner.qml
~/.config/quickshell/ii/modules/common/widgets/ScrollEdgeFade.qml
~/.config/quickshell/ii/modules/common/widgets/SecondaryTabBar.qml
~/.config/quickshell/ii/modules/common/widgets/SecondaryTabButton.qml
~/.config/quickshell/ii/modules/common/widgets/SelectionDialog.qml
~/.config/quickshell/ii/modules/common/widgets/SelectionGroupButton.qml
~/.config/quickshell/ii/modules/common/widgets/SineCookie.qml
~/.config/quickshell/ii/modules/common/widgets/SqueezedAnnotationStyledText.qml
~/.config/quickshell/ii/modules/common/widgets/StyledBlurEffect.qml
~/.config/quickshell/ii/modules/common/widgets/StyledComboBox.qml
~/.config/quickshell/ii/modules/common/widgets/StyledDropShadow.qml
~/.config/quickshell/ii/modules/common/widgets/StyledFlickable.qml
~/.config/quickshell/ii/modules/common/widgets/StyledImage.qml
~/.config/quickshell/ii/modules/common/widgets/StyledIndeterminateProgressBar.qml
~/.config/quickshell/ii/modules/common/widgets/StyledListView.qml
~/.config/quickshell/ii/modules/common/widgets/StyledProgressBar.qml
~/.config/quickshell/ii/modules/common/widgets/StyledRadioButton.qml
~/.config/quickshell/ii/modules/common/widgets/StyledRectangularShadow.qml
~/.config/quickshell/ii/modules/common/widgets/StyledScrollBar.qml
~/.config/quickshell/ii/modules/common/widgets/StyledSlider.qml
~/.config/quickshell/ii/modules/common/widgets/StyledSpinBox.qml
~/.config/quickshell/ii/modules/common/widgets/StyledSwitch.qml
~/.config/quickshell/ii/modules/common/widgets/StyledText.qml
~/.config/quickshell/ii/modules/common/widgets/StyledTextArea.qml
~/.config/quickshell/ii/modules/common/widgets/StyledTextInput.qml
~/.config/quickshell/ii/modules/common/widgets/StyledToolTip.qml
~/.config/quickshell/ii/modules/common/widgets/StyledToolTipContent.qml
~/.config/quickshell/ii/modules/common/widgets/ThumbnailImage.qml
~/.config/quickshell/ii/modules/common/widgets/Toolbar.qml
~/.config/quickshell/ii/modules/common/widgets/ToolbarButton.qml
~/.config/quickshell/ii/modules/common/widgets/ToolbarPairedFab.qml
~/.config/quickshell/ii/modules/common/widgets/ToolbarTabBar.qml
~/.config/quickshell/ii/modules/common/widgets/ToolbarTabButton.qml
~/.config/quickshell/ii/modules/common/widgets/ToolbarTextField.qml
~/.config/quickshell/ii/modules/common/widgets/VerticalButtonGroup.qml
~/.config/quickshell/ii/modules/common/widgets/VibrantToolbarButton.qml
~/.config/quickshell/ii/modules/common/widgets/WaveVisualizer.qml
~/.config/quickshell/ii/modules/common/widgets/WavyLine.qml
~/.config/quickshell/ii/modules/common/widgets/WeekRow.qml
~/.config/quickshell/ii/modules/common/widgets/WindowDialog.qml
~/.config/quickshell/ii/modules/common/widgets/WindowDialogButtonRow.qml
~/.config/quickshell/ii/modules/common/widgets/WindowDialogParagraph.qml
~/.config/quickshell/ii/modules/common/widgets/WindowDialogSectionHeader.qml
~/.config/quickshell/ii/modules/common/widgets/WindowDialogSeparator.qml
~/.config/quickshell/ii/modules/common/widgets/WindowDialogSlider.qml
~/.config/quickshell/ii/modules/common/widgets/WindowDialogTitle.qml
~/.config/quickshell/ii/modules/common/widgets/shapes/.gitignore
~/.config/quickshell/ii/modules/common/widgets/shapes/LICENSE
~/.config/quickshell/ii/modules/common/widgets/shapes/README.md
~/.config/quickshell/ii/modules/common/widgets/shapes/ShapeCanvas.qml
~/.config/quickshell/ii/modules/common/widgets/shapes/example-squircle.qml
~/.config/quickshell/ii/modules/common/widgets/shapes/example.qml
~/.config/quickshell/ii/modules/common/widgets/shapes/geometry/offset.js
~/.config/quickshell/ii/modules/common/widgets/shapes/graphics/matrix.js
~/.config/quickshell/ii/modules/common/widgets/shapes/material-shapes.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/corner-rounding.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/cubic.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/feature-mapping.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/feature.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/float-mapping.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/morph.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/point.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/polygon-measure.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/rounded-corner.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/rounded-polygon.js
~/.config/quickshell/ii/modules/common/widgets/shapes/shapes/utils.js
~/.config/quickshell/ii/modules/common/widgets/widgetCanvas/AbstractOverlayWidget.qml
~/.config/quickshell/ii/modules/common/widgets/widgetCanvas/AbstractWidget.qml
~/.config/quickshell/ii/modules/common/widgets/widgetCanvas/WidgetCanvas.qml
~/.config/quickshell/ii/modules/ii/background/Background.qml
~/.config/quickshell/ii/modules/ii/background/widgets/AbstractBackgroundWidget.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/ClockText.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/ClockWidget.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/CookieClock.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/CookieQuote.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/DigitalClock.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/HourHand.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/HourMarks.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/MinuteHand.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/SecondHand.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/TimeColumn.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/dateIndicator/BubbleDate.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/dateIndicator/DateIndicator.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/dateIndicator/RectangleDate.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/dateIndicator/RotatingDate.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/minuteMarks/BigHourNumbers.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/minuteMarks/Dots.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/minuteMarks/Lines.qml
~/.config/quickshell/ii/modules/ii/background/widgets/clock/minuteMarks/MinuteMarks.qml
~/.config/quickshell/ii/modules/ii/background/widgets/weather/WeatherWidget.qml
~/.config/quickshell/ii/modules/ii/bar/ActiveWindow.qml
~/.config/quickshell/ii/modules/ii/bar/Bar.qml
~/.config/quickshell/ii/modules/ii/bar/BarContent.qml
~/.config/quickshell/ii/modules/ii/bar/BarGroup.qml
~/.config/quickshell/ii/modules/ii/bar/BatteryIndicator.qml
~/.config/quickshell/ii/modules/ii/bar/BatteryPopup.qml
~/.config/quickshell/ii/modules/ii/bar/CircleUtilButton.qml
~/.config/quickshell/ii/modules/ii/bar/ClockWidget.qml
~/.config/quickshell/ii/modules/ii/bar/ClockWidgetPopup.qml
~/.config/quickshell/ii/modules/ii/bar/HyprlandXkbIndicator.qml
~/.config/quickshell/ii/modules/ii/bar/LeftSidebarButton.qml
~/.config/quickshell/ii/modules/ii/bar/Media.qml
~/.config/quickshell/ii/modules/ii/bar/NotificationUnreadCount.qml
~/.config/quickshell/ii/modules/ii/bar/Resource.qml
~/.config/quickshell/ii/modules/ii/bar/Resources.qml
~/.config/quickshell/ii/modules/ii/bar/ResourcesPopup.qml
~/.config/quickshell/ii/modules/ii/bar/ScrollHint.qml
~/.config/quickshell/ii/modules/ii/bar/StyledPopup.qml
~/.config/quickshell/ii/modules/ii/bar/StyledPopupHeaderRow.qml
~/.config/quickshell/ii/modules/ii/bar/StyledPopupValueRow.qml
~/.config/quickshell/ii/modules/ii/bar/SysTray.qml
~/.config/quickshell/ii/modules/ii/bar/SysTrayItem.qml
~/.config/quickshell/ii/modules/ii/bar/SysTrayMenu.qml
~/.config/quickshell/ii/modules/ii/bar/SysTrayMenuEntry.qml
~/.config/quickshell/ii/modules/ii/bar/UtilButtons.qml
~/.config/quickshell/ii/modules/ii/bar/Workspaces.qml
~/.config/quickshell/ii/modules/ii/bar/weather/WeatherBar.qml
~/.config/quickshell/ii/modules/ii/bar/weather/WeatherCard.qml
~/.config/quickshell/ii/modules/ii/bar/weather/WeatherPopup.qml
~/.config/quickshell/ii/modules/ii/cheatsheet/Cheatsheet.qml
~/.config/quickshell/ii/modules/ii/cheatsheet/CheatsheetKeybinds.qml
~/.config/quickshell/ii/modules/ii/cheatsheet/CheatsheetPeriodicTable.qml
~/.config/quickshell/ii/modules/ii/cheatsheet/ElementTile.qml
~/.config/quickshell/ii/modules/ii/cheatsheet/periodic_table.js
~/.config/quickshell/ii/modules/ii/dock/Dock.qml
~/.config/quickshell/ii/modules/ii/dock/DockAppButton.qml
~/.config/quickshell/ii/modules/ii/dock/DockApps.qml
~/.config/quickshell/ii/modules/ii/dock/DockButton.qml
~/.config/quickshell/ii/modules/ii/dock/DockSeparator.qml
~/.config/quickshell/ii/modules/ii/lock/Lock.qml
~/.config/quickshell/ii/modules/ii/lock/LockSurface.qml
~/.config/quickshell/ii/modules/ii/lock/PasswordChars.qml
~/.config/quickshell/ii/modules/ii/mediaControls/MediaControls.qml
~/.config/quickshell/ii/modules/ii/mediaControls/PlayerControl.qml
~/.config/quickshell/ii/modules/ii/notificationPopup/NotificationPopup.qml
~/.config/quickshell/ii/modules/ii/onScreenDisplay/OnScreenDisplay.qml
~/.config/quickshell/ii/modules/ii/onScreenDisplay/OsdValueIndicator.qml
~/.config/quickshell/ii/modules/ii/onScreenDisplay/indicators/BrightnessIndicator.qml
~/.config/quickshell/ii/modules/ii/onScreenDisplay/indicators/GammaIndicator.qml
~/.config/quickshell/ii/modules/ii/onScreenDisplay/indicators/VolumeIndicator.qml
~/.config/quickshell/ii/modules/ii/onScreenKeyboard/OnScreenKeyboard.qml
~/.config/quickshell/ii/modules/ii/onScreenKeyboard/OskContent.qml
~/.config/quickshell/ii/modules/ii/onScreenKeyboard/OskKey.qml
~/.config/quickshell/ii/modules/ii/onScreenKeyboard/layouts.js
~/.config/quickshell/ii/modules/ii/overlay/Overlay.qml
~/.config/quickshell/ii/modules/ii/overlay/OverlayBackground.qml
~/.config/quickshell/ii/modules/ii/overlay/OverlayContent.qml
~/.config/quickshell/ii/modules/ii/overlay/OverlayContext.qml
~/.config/quickshell/ii/modules/ii/overlay/OverlayTaskbar.qml
~/.config/quickshell/ii/modules/ii/overlay/OverlayWidgetDelegateChooser.qml
~/.config/quickshell/ii/modules/ii/overlay/StyledOverlayWidget.qml
~/.config/quickshell/ii/modules/ii/overlay/crosshair/Crosshair.qml
~/.config/quickshell/ii/modules/ii/overlay/crosshair/CrosshairContent.qml
~/.config/quickshell/ii/modules/ii/overlay/floatingImage/FloatingImage.qml
~/.config/quickshell/ii/modules/ii/overlay/fpsLimiter/FpsLimiter.qml
~/.config/quickshell/ii/modules/ii/overlay/fpsLimiter/FpsLimiterContent.qml
~/.config/quickshell/ii/modules/ii/overlay/notes/Notes.qml
~/.config/quickshell/ii/modules/ii/overlay/notes/NotesContent.qml
~/.config/quickshell/ii/modules/ii/overlay/recorder/Recorder.qml
~/.config/quickshell/ii/modules/ii/overlay/resources/Resources.qml
~/.config/quickshell/ii/modules/ii/overlay/volumeMixer/VolumeMixer.qml
~/.config/quickshell/ii/modules/ii/overview/Overview.qml
~/.config/quickshell/ii/modules/ii/overview/OverviewWidget.qml
~/.config/quickshell/ii/modules/ii/overview/OverviewWindow.qml
~/.config/quickshell/ii/modules/ii/overview/SearchBar.qml
~/.config/quickshell/ii/modules/ii/overview/SearchItem.qml
~/.config/quickshell/ii/modules/ii/overview/SearchWidget.qml
~/.config/quickshell/ii/modules/ii/polkit/Polkit.qml
~/.config/quickshell/ii/modules/ii/polkit/PolkitContent.qml
~/.config/quickshell/ii/modules/ii/regionSelector/CircleSelectionDetails.qml
~/.config/quickshell/ii/modules/ii/regionSelector/CursorGuide.qml
~/.config/quickshell/ii/modules/ii/regionSelector/OptionsToolbar.qml
~/.config/quickshell/ii/modules/ii/regionSelector/RectCornersSelectionDetails.qml
~/.config/quickshell/ii/modules/ii/regionSelector/RegionFunctions.qml
~/.config/quickshell/ii/modules/ii/regionSelector/RegionSelection.qml
~/.config/quickshell/ii/modules/ii/regionSelector/RegionSelector.qml
~/.config/quickshell/ii/modules/ii/regionSelector/TargetRegion.qml
~/.config/quickshell/ii/modules/ii/screenCorners/ScreenCorners.qml
~/.config/quickshell/ii/modules/ii/screenTranslator/ScreenTextOverlay.qml
~/.config/quickshell/ii/modules/ii/screenTranslator/ScreenTranslator.qml
~/.config/quickshell/ii/modules/ii/screenTranslator/ScreenTranslatorPanel.qml
~/.config/quickshell/ii/modules/ii/sessionScreen/SessionActionButton.qml
~/.config/quickshell/ii/modules/ii/sessionScreen/SessionScreen.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/AiChat.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/Anime.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/ApiCommandButton.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/ApiInputBoxIndicator.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/DescriptionBox.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/ScrollToBottomButton.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/SidebarLeft.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/SidebarLeftContent.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/Translator.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/AiMessage.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/AiMessageControlButton.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/AnnotationSourceButton.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/AttachedFileIndicator.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/MessageCodeBlock.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/MessageTextBlock.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/MessageThinkBlock.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/SearchQueryButton.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/anime/BooruImage.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/anime/BooruResponse.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/translator/LanguageSelectorButton.qml
~/.config/quickshell/ii/modules/ii/sidebarLeft/translator/TextCanvas.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/BottomWidgetGroup.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/CenterWidgetGroup.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/QuickSliders.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/SidebarRight.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/SidebarRightContent.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/bluetoothDevices/BluetoothDeviceItem.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/bluetoothDevices/BluetoothDialog.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/calendar/CalendarDayButton.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/calendar/CalendarHeaderButton.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/calendar/CalendarWidget.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/calendar/calendar_layout.js
~/.config/quickshell/ii/modules/ii/sidebarRight/nightLight/NightLightDialog.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/notifications/NotificationList.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/notifications/NotificationStatusButton.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/pomodoro/PomodoroTimer.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/pomodoro/PomodoroWidget.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/pomodoro/Stopwatch.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/AbstractQuickPanel.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/AndroidQuickPanel.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/ClassicQuickPanel.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidAntiFlashbangToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidAudioToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidBluetoothToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidCloudflareWarpToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidColorPickerToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidDarkModeToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidEasyEffectsToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidGameModeToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidIdleInhibitorToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidMicToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidMusicRecognition.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidNetworkToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidNightLightToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidNotificationToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidOnScreenKeyboardToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidPowerProfileToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidQuickToggleButton.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidScreenSnipToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidToggleDelegateChooser.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/BluetoothToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/CloudflareWarp.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/EasyEffectsToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/GameMode.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/IdleInhibitor.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/NetworkToggle.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/NightLight.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/QuickToggleButton.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/todo/TaskList.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/todo/TodoItemActionButton.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/todo/TodoWidget.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/volumeMixer/AudioDeviceSelectorButton.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/volumeMixer/VolumeDialog.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/volumeMixer/VolumeDialogContent.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/volumeMixer/VolumeMixerEntry.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/wifiNetworks/WifiDialog.qml
~/.config/quickshell/ii/modules/ii/sidebarRight/wifiNetworks/WifiNetworkItem.qml
~/.config/quickshell/ii/modules/ii/verticalBar/BatteryIndicator.qml
~/.config/quickshell/ii/modules/ii/verticalBar/Resource.qml
~/.config/quickshell/ii/modules/ii/verticalBar/Resources.qml
~/.config/quickshell/ii/modules/ii/verticalBar/VerticalBar.qml
~/.config/quickshell/ii/modules/ii/verticalBar/VerticalBarContent.qml
~/.config/quickshell/ii/modules/ii/verticalBar/VerticalClockWidget.qml
~/.config/quickshell/ii/modules/ii/verticalBar/VerticalMedia.qml
~/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperDirectoryItem.qml
~/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelector.qml
~/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelectorContent.qml
~/.config/quickshell/ii/modules/settings/About.qml
~/.config/quickshell/ii/modules/settings/AdvancedConfig.qml
~/.config/quickshell/ii/modules/settings/BackgroundConfig.qml
~/.config/quickshell/ii/modules/settings/BarConfig.qml
~/.config/quickshell/ii/modules/settings/GeneralConfig.qml
~/.config/quickshell/ii/modules/settings/InterfaceConfig.qml
~/.config/quickshell/ii/modules/settings/QuickConfig.qml
~/.config/quickshell/ii/modules/settings/ServicesConfig.qml
~/.config/quickshell/ii/modules/waffle/README.md
~/.config/quickshell/ii/modules/waffle/actionCenter/ActionCenterContent.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/ActionCenterContext.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/ExpandableChoiceButton.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/HeaderRow.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/MediaPaneContent.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/SectionText.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/ToggleItem.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/WaffleActionCenter.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/bluetooth/BluetoothControl.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/bluetooth/BluetoothDeviceItem.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/mainPage/MainPageBody.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/mainPage/MainPageBodySliders.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/mainPage/MainPageBodyToggles.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/mainPage/MainPageFooter.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/nightLight/NightLightControl.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/toggles/ActionCenterToggleButton.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/toggles/ActionCenterTogglesDelegateChooser.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/toggles/WNetworkToggle.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/volumeControl/VolumeControl.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/volumeControl/VolumeEntry.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/wifi/WWifiNetworkItem.qml
~/.config/quickshell/ii/modules/waffle/actionCenter/wifi/WifiControl.qml
~/.config/quickshell/ii/modules/waffle/background/WaffleBackground.qml
~/.config/quickshell/ii/modules/waffle/bar/AppButton.qml
~/.config/quickshell/ii/modules/waffle/bar/BarButton.qml
~/.config/quickshell/ii/modules/waffle/bar/BarIconButton.qml
~/.config/quickshell/ii/modules/waffle/bar/BarMenu.qml
~/.config/quickshell/ii/modules/waffle/bar/BarPopup.qml
~/.config/quickshell/ii/modules/waffle/bar/BarToolTip.qml
~/.config/quickshell/ii/modules/waffle/bar/SearchButton.qml
~/.config/quickshell/ii/modules/waffle/bar/StartButton.qml
~/.config/quickshell/ii/modules/waffle/bar/SystemButton.qml
~/.config/quickshell/ii/modules/waffle/bar/TaskViewButton.qml
~/.config/quickshell/ii/modules/waffle/bar/TimeButton.qml
~/.config/quickshell/ii/modules/waffle/bar/UpdatesButton.qml
~/.config/quickshell/ii/modules/waffle/bar/WaffleBar.qml
~/.config/quickshell/ii/modules/waffle/bar/WaffleBarContent.qml
~/.config/quickshell/ii/modules/waffle/bar/WidgetsButton.qml
~/.config/quickshell/ii/modules/waffle/bar/tasks/TaskAppButton.qml
~/.config/quickshell/ii/modules/waffle/bar/tasks/TaskPreview.qml
~/.config/quickshell/ii/modules/waffle/bar/tasks/Tasks.qml
~/.config/quickshell/ii/modules/waffle/bar/tasks/WindowPreview.qml
~/.config/quickshell/ii/modules/waffle/bar/tray/Tray.qml
~/.config/quickshell/ii/modules/waffle/bar/tray/TrayButton.qml
~/.config/quickshell/ii/modules/waffle/bar/tray/TrayOverflowMenu.qml
~/.config/quickshell/ii/modules/waffle/lock/WaffleLock.qml
~/.config/quickshell/ii/modules/waffle/looks/AcrylicButton.qml
~/.config/quickshell/ii/modules/waffle/looks/AcrylicRectangle.qml
~/.config/quickshell/ii/modules/waffle/looks/BodyRectangle.qml
~/.config/quickshell/ii/modules/waffle/looks/CloseButton.qml
~/.config/quickshell/ii/modules/waffle/looks/FluentIcon.qml
~/.config/quickshell/ii/modules/waffle/looks/FooterRectangle.qml
~/.config/quickshell/ii/modules/waffle/looks/Looks.qml
~/.config/quickshell/ii/modules/waffle/looks/VerticalPageIndicator.qml
~/.config/quickshell/ii/modules/waffle/looks/WAmbientShadow.qml
~/.config/quickshell/ii/modules/waffle/looks/WAppIcon.qml
~/.config/quickshell/ii/modules/waffle/looks/WBarAttachedPanelContent.qml
~/.config/quickshell/ii/modules/waffle/looks/WBorderedButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WBorderlessButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WChoiceButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WFadeLoader.qml
~/.config/quickshell/ii/modules/waffle/looks/WIcons.qml
~/.config/quickshell/ii/modules/waffle/looks/WIndeterminateProgressBar.qml
~/.config/quickshell/ii/modules/waffle/looks/WListView.qml
~/.config/quickshell/ii/modules/waffle/looks/WMenu.qml
~/.config/quickshell/ii/modules/waffle/looks/WMenuItem.qml
~/.config/quickshell/ii/modules/waffle/looks/WMouseAreaButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WPane.qml
~/.config/quickshell/ii/modules/waffle/looks/WPanelIconButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WPanelPageColumn.qml
~/.config/quickshell/ii/modules/waffle/looks/WPanelSeparator.qml
~/.config/quickshell/ii/modules/waffle/looks/WPopupToolTip.qml
~/.config/quickshell/ii/modules/waffle/looks/WProgressBar.qml
~/.config/quickshell/ii/modules/waffle/looks/WRectangularShadow.qml
~/.config/quickshell/ii/modules/waffle/looks/WRectangularShadowThis.qml
~/.config/quickshell/ii/modules/waffle/looks/WScrollBar.qml
~/.config/quickshell/ii/modules/waffle/looks/WSlider.qml
~/.config/quickshell/ii/modules/waffle/looks/WStackView.qml
~/.config/quickshell/ii/modules/waffle/looks/WSwitch.qml
~/.config/quickshell/ii/modules/waffle/looks/WText.qml
~/.config/quickshell/ii/modules/waffle/looks/WTextButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WTextField.qml
~/.config/quickshell/ii/modules/waffle/looks/WTextInput.qml
~/.config/quickshell/ii/modules/waffle/looks/WTextWithFixedWidth.qml
~/.config/quickshell/ii/modules/waffle/looks/WToolTip.qml
~/.config/quickshell/ii/modules/waffle/looks/WToolTipContent.qml
~/.config/quickshell/ii/modules/waffle/looks/WToolbar.qml
~/.config/quickshell/ii/modules/waffle/looks/WToolbarButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WToolbarIconButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WToolbarIconTabButton.qml
~/.config/quickshell/ii/modules/waffle/looks/WToolbarSeparator.qml
~/.config/quickshell/ii/modules/waffle/looks/WToolbarTabBar.qml
~/.config/quickshell/ii/modules/waffle/looks/WUserAvatar.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/CalendarWidget.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/DateHeader.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/FocusFooter.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/NotificationCenterContent.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/NotificationHeaderButton.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/NotificationPaneContent.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/SmallBorderedIconAndTextButton.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/SmallBorderedIconButton.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/WNotificationAppIcon.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/WNotificationDismissAnim.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/WNotificationGroup.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/WSingleNotification.qml
~/.config/quickshell/ii/modules/waffle/notificationCenter/WaffleNotificationCenter.qml
~/.config/quickshell/ii/modules/waffle/notificationPopup/WaffleNotificationPopup.qml
~/.config/quickshell/ii/modules/waffle/onScreenDisplay/BrightnessOSD.qml
~/.config/quickshell/ii/modules/waffle/onScreenDisplay/OSDValue.qml
~/.config/quickshell/ii/modules/waffle/onScreenDisplay/VolumeOSD.qml
~/.config/quickshell/ii/modules/waffle/onScreenDisplay/WaffleOSD.qml
~/.config/quickshell/ii/modules/waffle/polkit/WPolkitContent.qml
~/.config/quickshell/ii/modules/waffle/polkit/WafflePolkit.qml
~/.config/quickshell/ii/modules/waffle/screenSnip/WRectangularSelection.qml
~/.config/quickshell/ii/modules/waffle/screenSnip/WRegionSelectionPanel.qml
~/.config/quickshell/ii/modules/waffle/screenSnip/WScreenSnip.qml
~/.config/quickshell/ii/modules/waffle/sessionScreen/PowerButton.qml
~/.config/quickshell/ii/modules/waffle/sessionScreen/SessionScreenContent.qml
~/.config/quickshell/ii/modules/waffle/sessionScreen/WSessionScreenTextButton.qml
~/.config/quickshell/ii/modules/waffle/sessionScreen/WaffleSessionScreen.qml
~/.config/quickshell/ii/modules/waffle/startMenu/SearchBar.qml
~/.config/quickshell/ii/modules/waffle/startMenu/StartMenuContent.qml
~/.config/quickshell/ii/modules/waffle/startMenu/StartMenuContext.qml
~/.config/quickshell/ii/modules/waffle/startMenu/WaffleStartMenu.qml
~/.config/quickshell/ii/modules/waffle/startMenu/searchPage/SearchEntryIcon.qml
~/.config/quickshell/ii/modules/waffle/startMenu/searchPage/SearchPageContent.qml
~/.config/quickshell/ii/modules/waffle/startMenu/searchPage/SearchResultButton.qml
~/.config/quickshell/ii/modules/waffle/startMenu/searchPage/SearchResults.qml
~/.config/quickshell/ii/modules/waffle/startMenu/searchPage/TagStrip.qml
~/.config/quickshell/ii/modules/waffle/startMenu/startPage/AggregatedAppCategoryModel.qml
~/.config/quickshell/ii/modules/waffle/startMenu/startPage/AllAppsGrid.qml
~/.config/quickshell/ii/modules/waffle/startMenu/startPage/AppCategoryGrid.qml
~/.config/quickshell/ii/modules/waffle/startMenu/startPage/BigAppGrid.qml
~/.config/quickshell/ii/modules/waffle/startMenu/startPage/StartAppButton.qml
~/.config/quickshell/ii/modules/waffle/startMenu/startPage/StartPageApps.qml
~/.config/quickshell/ii/modules/waffle/startMenu/startPage/StartPageContent.qml
~/.config/quickshell/ii/modules/waffle/startMenu/startPage/StartUserButton.qml
~/.config/quickshell/ii/modules/waffle/taskView/TaskViewContent.qml
~/.config/quickshell/ii/modules/waffle/taskView/TaskViewWindow.qml
~/.config/quickshell/ii/modules/waffle/taskView/TaskViewWorkspace.qml
~/.config/quickshell/ii/modules/waffle/taskView/WaffleTaskView.qml
~/.config/quickshell/ii/modules/waffle/taskView/window-layout.js
~/.config/quickshell/ii/panelFamilies/IllogicalImpulseFamily.qml
~/.config/quickshell/ii/panelFamilies/PanelLoader.qml
~/.config/quickshell/ii/panelFamilies/WaffleFamily.qml
~/.config/quickshell/ii/scripts/ai/gemini-categorize-wallpaper.sh
~/.config/quickshell/ii/scripts/ai/gemini-translate.sh
~/.config/quickshell/ii/scripts/ai/show-installed-ollama-models.sh
~/.config/quickshell/ii/scripts/cava/raw_output_config.txt
~/.config/quickshell/ii/scripts/colors/applycolor.sh
~/.config/quickshell/ii/scripts/colors/code/material-code-set-color.sh
~/.config/quickshell/ii/scripts/colors/generate_colors_material.py
~/.config/quickshell/ii/scripts/colors/random/random_konachan_wall.sh
~/.config/quickshell/ii/scripts/colors/random/random_osu_wall.sh
~/.config/quickshell/ii/scripts/colors/scheme_for_image.py
~/.config/quickshell/ii/scripts/colors/switchwall.sh
~/.config/quickshell/ii/scripts/colors/terminal/kitty-theme.conf
~/.config/quickshell/ii/scripts/colors/terminal/scheme-base.json
~/.config/quickshell/ii/scripts/colors/terminal/sequences.txt
~/.config/quickshell/ii/scripts/hyprland/get_keybinds.py
~/.config/quickshell/ii/scripts/hyprland/hyprconfigurator.py
~/.config/quickshell/ii/scripts/images/find-regions-venv.sh
~/.config/quickshell/ii/scripts/images/find_regions.py
~/.config/quickshell/ii/scripts/images/least-busy-region-venv.sh
~/.config/quickshell/ii/scripts/images/least_busy_region.py
~/.config/quickshell/ii/scripts/images/text-color-venv.sh
~/.config/quickshell/ii/scripts/images/text_color.py
~/.config/quickshell/ii/scripts/keyring/is_unlocked.sh
~/.config/quickshell/ii/scripts/keyring/try_lookup.sh
~/.config/quickshell/ii/scripts/keyring/unlock.sh
~/.config/quickshell/ii/scripts/kvantum/adwsvg.py
~/.config/quickshell/ii/scripts/kvantum/adwsvgDark.py
~/.config/quickshell/ii/scripts/kvantum/changeAdwColors.py
~/.config/quickshell/ii/scripts/kvantum/materialQT.sh
~/.config/quickshell/ii/scripts/musicRecognition/recognize-music.sh
~/.config/quickshell/ii/scripts/thumbnails/generate-thumbnails-magick.sh
~/.config/quickshell/ii/scripts/thumbnails/thumbgen-venv.sh
~/.config/quickshell/ii/scripts/thumbnails/thumbgen.py
~/.config/quickshell/ii/scripts/videos/record.sh
~/.config/quickshell/ii/services/Ai.qml
~/.config/quickshell/ii/services/AppSearch.qml
~/.config/quickshell/ii/services/Audio.qml
~/.config/quickshell/ii/services/Battery.qml
~/.config/quickshell/ii/services/BluetoothStatus.qml
~/.config/quickshell/ii/services/Booru.qml
~/.config/quickshell/ii/services/BooruResponseData.qml
~/.config/quickshell/ii/services/Brightness.qml
~/.config/quickshell/ii/services/Cliphist.qml
~/.config/quickshell/ii/services/ConflictKiller.qml
~/.config/quickshell/ii/services/DateTime.qml
~/.config/quickshell/ii/services/EasyEffects.qml
~/.config/quickshell/ii/services/Emojis.qml
~/.config/quickshell/ii/services/FirstRunExperience.qml
~/.config/quickshell/ii/services/GlobalFocusGrab.qml
~/.config/quickshell/ii/services/GoogleCloud.qml
~/.config/quickshell/ii/services/HyprlandAntiFlashbangShader.qml
~/.config/quickshell/ii/services/HyprlandConfig.qml
~/.config/quickshell/ii/services/HyprlandData.qml
~/.config/quickshell/ii/services/HyprlandKeybinds.qml
~/.config/quickshell/ii/services/HyprlandXkb.qml
~/.config/quickshell/ii/services/Hyprsunset.qml
~/.config/quickshell/ii/services/Idle.qml
~/.config/quickshell/ii/services/KeyringStorage.qml
~/.config/quickshell/ii/services/LatexRenderer.qml
~/.config/quickshell/ii/services/LauncherApps.qml
~/.config/quickshell/ii/services/LauncherSearch.qml
~/.config/quickshell/ii/services/MaterialThemeLoader.qml
~/.config/quickshell/ii/services/MprisController.qml
~/.config/quickshell/ii/services/Network.qml
~/.config/quickshell/ii/services/Notifications.qml
~/.config/quickshell/ii/services/PolkitService.qml
~/.config/quickshell/ii/services/Privacy.qml
~/.config/quickshell/ii/services/ResourceUsage.qml
~/.config/quickshell/ii/services/SessionWarnings.qml
~/.config/quickshell/ii/services/SongRec.qml
~/.config/quickshell/ii/services/SystemInfo.qml
~/.config/quickshell/ii/services/TaskbarApps.qml
~/.config/quickshell/ii/services/TimerService.qml
~/.config/quickshell/ii/services/Todo.qml
~/.config/quickshell/ii/services/Translation.qml
~/.config/quickshell/ii/services/TrayService.qml
~/.config/quickshell/ii/services/Updates.qml
~/.config/quickshell/ii/services/Wallpapers.qml
~/.config/quickshell/ii/services/Weather.qml
~/.config/quickshell/ii/services/Ydotool.qml
~/.config/quickshell/ii/services/ai/AiMessageData.qml
~/.config/quickshell/ii/services/ai/AiModel.qml
~/.config/quickshell/ii/services/ai/ApiStrategy.qml
~/.config/quickshell/ii/services/ai/GeminiApiStrategy.qml
~/.config/quickshell/ii/services/ai/MistralApiStrategy.qml
~/.config/quickshell/ii/services/ai/OpenAiApiStrategy.qml
~/.config/quickshell/ii/services/gCloud/token-from-key-venv.sh
~/.config/quickshell/ii/services/gCloud/token_from_key.py
~/.config/quickshell/ii/services/hyprlandAntiFlashbangShader/anti-flashbang.glsl
~/.config/quickshell/ii/services/network/WifiAccessPoint.qml
~/.config/quickshell/ii/settings.qml
~/.config/quickshell/ii/shell.qml
~/.config/quickshell/ii/translations/de_DE.json
~/.config/quickshell/ii/translations/en_US.json
~/.config/quickshell/ii/translations/es_MX.json
~/.config/quickshell/ii/translations/fr_FR.json
~/.config/quickshell/ii/translations/he_HE.json
~/.config/quickshell/ii/translations/id_ID.json
~/.config/quickshell/ii/translations/it_IT.json
~/.config/quickshell/ii/translations/ja_JP.json
~/.config/quickshell/ii/translations/pt_BR.json
~/.config/quickshell/ii/translations/ru_RU.json
~/.config/quickshell/ii/translations/tools/README.md
~/.config/quickshell/ii/translations/tools/guide/translation-tools-guide-zh_CN.md
~/.config/quickshell/ii/translations/tools/guide/translation-tools-guide.md
~/.config/quickshell/ii/translations/tools/manage-translations.sh
~/.config/quickshell/ii/translations/tools/translation-cleaner.py
~/.config/quickshell/ii/translations/tools/translation-manager.py
~/.config/quickshell/ii/translations/tr_TR.json
~/.config/quickshell/ii/translations/uk_UA.json
~/.config/quickshell/ii/translations/vi_VN.json
~/.config/quickshell/ii/translations/zh_CN.json
~/.config/quickshell/ii/welcome.qml
~/.config/wlogout/layout
~/.config/wlogout/style.css
~/.local/bin/dolphin-nostripes
~/.local/share/applications/STEAM_PP.desktop
~/.local/share/applications/Wargaming Game Center.desktop
~/.local/share/applications/org.kde.dolphin.desktop
~/.local/share/fonts/.uuid
~/.local/share/fonts/illogical-impulse-google-sans-flex/.uuid
~/.local/share/fonts/illogical-impulse-google-sans-flex/GoogleSansFlex-VariableFont_GRAD,ROND,opsz,slnt,wdth,wght.ttf
~/.local/share/fonts/illogical-impulse-google-sans-flex/LICENSE
~/.local/share/fonts/illogical-impulse-google-sans-flex/README.md
~/.local/share/icons/hicolor/16x16/apps/C06E_winhlp32.0.png
~/.local/share/icons/hicolor/16x16/apps/D15F_hh.0.png
~/.local/share/icons/hicolor/16x16/apps/D23E_msiexec.0.png
~/.local/share/icons/hicolor/256x256/apps/C06E_winhlp32.0.png
~/.local/share/icons/hicolor/256x256/apps/D15F_hh.0.png
~/.local/share/icons/hicolor/256x256/apps/D23E_msiexec.0.png
~/.local/share/icons/hicolor/32x32/apps/C06E_winhlp32.0.png
~/.local/share/icons/hicolor/32x32/apps/D15F_hh.0.png
~/.local/share/icons/hicolor/32x32/apps/D23E_msiexec.0.png
~/.local/share/icons/hicolor/32x32/apps/steam_icon_548430.png
~/.local/share/icons/hicolor/48x48/apps/C06E_winhlp32.0.png
~/.local/share/icons/hicolor/48x48/apps/D15F_hh.0.png
~/.local/share/icons/hicolor/48x48/apps/D23E_msiexec.0.png
~/.local/share/icons/illogical-impulse.svg
~/Wallpapers/ChatGPT Image 28 апр. 2026 г., 12_12_28_upscayl_2x_digital-art-4x.png
~/Wallpapers/random_wallpaper-1.png
~/Wallpapers/random_wallpaper_upscayl_4x_digital-art-4x.png
```

</details>

### Файлы, которые создаются или перезаписываются установщиком

```text
~/.config/hypr/custom/monitors.conf
/etc/sddm.conf.d/autologin.conf
/etc/systemd/system/force-cpu-performance.service
```

### Возможное изменение pacman.conf

Steam installer включает `multilib`, если он ещё не включён. Перед изменением создаётся backup:

```text
/etc/pacman.conf.bak-xlllos-steam-YYYY-MM-DD-HHMMSS
```

Файл, который может быть изменён:

```text
/etc/pacman.conf
```

### Возможное изменение Firefox profile

Если найден Firefox profile, установщик добавляет настройку в:

```text
~/.mozilla/firefox/*.default-release/user.js
```

Добавляемая строка:

```javascript
user_pref("layout.frame_rate", 180);
```

### Что делают GPU-скрипты

GPU-скрипты не копируют dotfiles. Они только устанавливают и удаляют пакеты драйверов:

```text
scripts/gpu-nvidia.sh - удаляет AMD-специфичные пакеты и ставит NVIDIA-пакеты
scripts/gpu-amd.sh    - удаляет NVIDIA-пакеты и ставит AMD Mesa/RADV-пакеты
```


## Настройка монитора

Настройка монитора находится в:

```text
~/.config/hypr/custom/monitors.conf
```

Универсальный вариант:

```ini
monitor = , preferred, auto, 1
```

Для 3440x1440 180 Hz можно вручную поставить:

```ini
monitor = DP-1, 3440x1440@180, 0x0, 1
```

После изменения:

```bash
hyprctl reload
```

## Бинды после установки

Открыть cheatsheet:

```text
Super + /
```

Основные бинды:

| Бинд | Действие |
|---|---|
| Super | Search |
| Super + Tab | Overview |
| Super + Enter | Terminal |
| Super + E | File manager |
| Super + W | Browser |
| Super + Q | Close window |
| Super + F | Fullscreen |
| Super + D | Maximize |
| Super + S | Scratchpad |
| Super + Shift + S | Screenshot region |
| Ctrl + Super + R | Restart widgets |

## Linux Steam

Steam ставится автоматически через `scripts/install-steam.sh`.

## PortProton / Proton VPN

PortProton и Proton VPN ставятся автоматически.

## Quickshell popup закрывается сразу

Если popup-меню Quickshell открывается и сразу закрывается, часто виноват зависший PortProton.

Фикс:

```bash
pgrep -f "$HOME/PortProton|/usr/bin/portproton|yad_gui_pp" | xargs -r kill -9
```

Или просто сделайте перезагрузку системы.

## Game Launch Options

```text
game-performance %command%
mangohud game-performance %command%
gamescope -f -W 3440 -H 1440 -r 180 -- game-performance %command%
WINEDLLOVERRIDES="winmm,version=n,b" game-performance %command%
```

## WARP helper

```fish
warp on
warp off
warp status
```

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
