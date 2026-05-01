# XlllOS Dots

<p align="center">
  <img src="assets/preview.png" alt="XlllOS Preview" width="100%">
</p>

Моя настройка CachyOS Hyprland.

Это не отдельный Linux-дистрибутив, а набор dotfiles + установочный скрипт, который переносит внешний вид, Hyprland-конфиги, Quickshell/Illogical Impulse, терминал, fish shell, игровые пакеты и performance-настройки.

## Быстрая установка одной командой

### NVIDIA

Для NVIDIA / CachyOS / Arch / EndeavourOS:

```bash
bash -lc 'set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "$HOME/XlllOS-dots/.git" ]; then git -C "$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "$HOME/XlllOS-dots"; fi; cd "$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; ./scripts/gpu-nvidia.sh; sudo reboot'
```

NVIDIA-команда ставит XlllOS-dots, удаляет AMD-специфичные Vulkan/Mesa/AMDGPU-пакеты и ставит NVIDIA-драйверы, OpenCL, Vulkan ICD, lib32-компоненты и NVIDIA VA-API.

### AMD

Для AMD-видеокарт:

```bash
bash -lc 'set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "$HOME/XlllOS-dots/.git" ]; then git -C "$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "$HOME/XlllOS-dots"; fi; cd "$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; ./scripts/gpu-amd.sh; sudo reboot'
```

AMD-команда ставит XlllOS-dots, удаляет NVIDIA-пакеты и ставит Mesa/RADV, Vulkan Radeon, lib32-компоненты, VA-API/VDPAU для Mesa и AMDGPU Xorg-драйвер.

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

## Какие файлы переносятся и перезаписываются

Перед копированием установщик делает backup старых пользовательских конфигов:

```text
~/.config/hypr              -> ~/.config-backup-xlllos-YYYY-MM-DD-HHMMSS/hypr
~/.config/illogical-impulse -> ~/.config-backup-xlllos-YYYY-MM-DD-HHMMSS/illogical-impulse
~/.config/kitty             -> ~/.config-backup-xlllos-YYYY-MM-DD-HHMMSS/kitty
~/.config/fish              -> ~/.config-backup-xlllos-YYYY-MM-DD-HHMMSS/fish
```

После backup установщик переносит файлы из репозитория в систему:

```text
~/XlllOS-dots/home/.config/     -> ~/.config/
~/XlllOS-dots/home/Pictures/    -> ~/Pictures/
~/XlllOS-dots/home/Wallpapers/  -> ~/Wallpapers/
~/XlllOS-dots/home/.local/      -> ~/.local/
```

Файлы с одинаковыми путями перезаписываются через `rsync`.

Также установщик создаёт или перезаписывает:

```text
~/.config/hypr/custom/monitors.conf
/etc/sddm.conf.d/autologin.conf
/etc/systemd/system/force-cpu-performance.service
```

Steam installer может изменить `/etc/pacman.conf`, если `multilib` ещё не включён. Перед этим создаётся backup:

```text
/etc/pacman.conf.bak-xlllos-steam-YYYY-MM-DD-HHMMSS
```

Если найден Firefox profile, в него добавляется настройка:

```text
~/.mozilla/firefox/*.default-release/user.js
```

Добавляемая строка:

```javascript
user_pref("layout.frame_rate", 180);
```

GPU-скрипты не копируют dotfiles, а только устанавливают и удаляют пакеты драйверов:

```text
scripts/gpu-nvidia.sh - удаляет AMD-специфичные пакеты и ставит NVIDIA-пакеты
scripts/gpu-amd.sh    - удаляет NVIDIA-пакеты и ставит AMD Mesa/RADV-пакеты
```

### Список файлов из папки `home/`, которые будут перенесены

<details>
<summary>Показать полный список файлов</summary>

```text
home/.config/dolphinrc
home/.config/fish/auto-Hypr.fish
home/.config/fish/conf.d/fish_frozen_key_bindings.fish
home/.config/fish/conf.d/fish_frozen_theme.fish
home/.config/fish/config.fish
home/.config/fish/fish_variables
home/.config/fish/functions/warp.fish
home/.config/fontconfig/fonts.conf
home/.config/gtk-3.0/gtk.css
home/.config/gtk-4.0/gtk.css
home/.config/hypr/custom/env.conf
home/.config/hypr/custom/execs.conf
home/.config/hypr/custom/general.conf
home/.config/hypr/custom/keybinds.conf
home/.config/hypr/custom/rules.conf
home/.config/hypr/custom/scripts/__restore_video_wallpaper.sh
home/.config/hypr/custom/variables.conf
home/.config/hypr/desktop-widgets.conf
home/.config/hypr/hypridle.conf
home/.config/hypr/hypridle.conf.new
home/.config/hypr/hyprland/colors.conf
home/.config/hypr/hyprland.conf
home/.config/hypr/hyprland/env.conf
home/.config/hypr/hyprland/execs.conf
home/.config/hypr/hyprland/general.conf
home/.config/hypr/hyprland/keybinds.conf
home/.config/hypr/hyprland/rules.conf
home/.config/hypr/hyprland/scripts/ai/license_show-loaded-ollama-models.txt
home/.config/hypr/hyprland/scripts/ai/primary-buffer-query.sh
home/.config/hypr/hyprland/scripts/ai/show-loaded-ollama-models.sh
home/.config/hypr/hyprland/scripts/fuzzel-emoji.sh
home/.config/hypr/hyprland/scripts/launch_first_available.sh
home/.config/hypr/hyprland/scripts/snip_to_search.sh
home/.config/hypr/hyprland/scripts/start_geoclue_agent.sh
home/.config/hypr/hyprland/scripts/workspace_action.sh
home/.config/hypr/hyprland/scripts/zoom.sh
home/.config/hypr/hyprland/shellOverrides/main.conf
home/.config/hypr/hyprland/variables.conf
home/.config/hypr/hyprlock/colors.conf
home/.config/hypr/hyprlock.conf
home/.config/hypr/hyprlock.conf.new
home/.config/hypr/monitors.conf
home/.config/hypr/monitors.conf.new
home/.config/hypr/scripts/desktop-widgets.sh
home/.config/hypr/workspaces.conf
home/.config/hypr/workspaces.conf.new
home/.config/illogical-impulse/config.json
home/.config/illogical-impulse/installed_listfile
home/.config/illogical-impulse/installed_true
home/.config/kdeglobals
home/.config/kitty/kitty.conf
home/.config/kitty/scroll_mark.py
home/.config/kitty/search.py
home/.config/Kvantum/Colloid/ColloidDark.kvconfig
home/.config/Kvantum/Colloid/ColloidDark.svg
home/.config/Kvantum/Colloid/Colloid.kvconfig
home/.config/Kvantum/Colloid/Colloid.svg
home/.config/Kvantum/kvantum.kvconfig
home/.config/Kvantum/MaterialAdw/MaterialAdw.kvconfig
home/.config/Kvantum/MaterialAdw/MaterialAdw.kvconfig.bak2
home/.config/Kvantum/MaterialAdw/MaterialAdw.kvconfig.bak-stripes
home/.config/Kvantum/MaterialAdw/MaterialAdw.svg
home/.config/mimeapps.list
home/.config/qt6ct/qss/dolphin-bar-match.qss
home/.config/qt6ct/qss/dolphin-kvantum-fix.qss
home/.config/qt6ct/qss/dolphin-topbar-transparent.qss
home/.config/quickshell/ii/assets/icons/arch-symbolic.svg
home/.config/quickshell/ii/assets/icons/cachyos-symbolic.svg
home/.config/quickshell/ii/assets/icons/cloudflare-dns-symbolic.svg
home/.config/quickshell/ii/assets/icons/crosshair-symbolic.svg
home/.config/quickshell/ii/assets/icons/debian-symbolic.svg
home/.config/quickshell/ii/assets/icons/deepseek-symbolic.svg
home/.config/quickshell/ii/assets/icons/desktop-symbolic.svg
home/.config/quickshell/ii/assets/icons/endeavouros-symbolic.svg
home/.config/quickshell/ii/assets/icons/fedora-symbolic.svg
home/.config/quickshell/ii/assets/icons/flatpak-symbolic.svg
home/.config/quickshell/ii/assets/icons/fluent/add-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/add.svg
home/.config/quickshell/ii/assets/icons/fluent/alert-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/alert-off-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/alert-off.svg
home/.config/quickshell/ii/assets/icons/fluent/alert-snooze-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/alert-snooze.svg
home/.config/quickshell/ii/assets/icons/fluent/alert.svg
home/.config/quickshell/ii/assets/icons/fluent/app-generic-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/app-generic.svg
home/.config/quickshell/ii/assets/icons/fluent/apps-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/apps.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-clockwise-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-clockwise.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-counterclockwise-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-counterclockwise.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-enter-left-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-enter-left.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-left-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-left.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-right-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-right.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-sync.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-up-left-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/arrow-up-left.svg
home/.config/quickshell/ii/assets/icons/fluent/auto-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/auto.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-0.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-1.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-2.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-3.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-4.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-5.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-6.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-7.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-8.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-9.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-charge.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-full.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-saver.svg
home/.config/quickshell/ii/assets/icons/fluent/battery-warning.svg
home/.config/quickshell/ii/assets/icons/fluent/bluetooth-connected-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/bluetooth-connected.svg
home/.config/quickshell/ii/assets/icons/fluent/bluetooth-disabled-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/bluetooth-disabled.svg
home/.config/quickshell/ii/assets/icons/fluent/bluetooth-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/bluetooth-searching.svg
home/.config/quickshell/ii/assets/icons/fluent/bluetooth.svg
home/.config/quickshell/ii/assets/icons/fluent/calculator-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/calculator.svg
home/.config/quickshell/ii/assets/icons/fluent/calendar-add-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/calendar-add.svg
home/.config/quickshell/ii/assets/icons/fluent/camera-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/camera.svg
home/.config/quickshell/ii/assets/icons/fluent/caret-down-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/caret-down.svg
home/.config/quickshell/ii/assets/icons/fluent/caret-up-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/caret-up.svg
home/.config/quickshell/ii/assets/icons/fluent/checkmark-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/checkmark.svg
home/.config/quickshell/ii/assets/icons/fluent/chevron-down-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/chevron-down.svg
home/.config/quickshell/ii/assets/icons/fluent/chevron-left-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/chevron-left.svg
home/.config/quickshell/ii/assets/icons/fluent/chevron-right-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/chevron-right.svg
home/.config/quickshell/ii/assets/icons/fluent/chevron-up-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/chevron-up.svg
home/.config/quickshell/ii/assets/icons/fluent/corporation.svg
home/.config/quickshell/ii/assets/icons/fluent/crop-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/crop.svg
home/.config/quickshell/ii/assets/icons/fluent/cut-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/cut.svg
home/.config/quickshell/ii/assets/icons/fluent/dark-theme-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/dark-theme.svg
home/.config/quickshell/ii/assets/icons/fluent/desktop-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/desktop-speaker-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/desktop-speaker.svg
home/.config/quickshell/ii/assets/icons/fluent/desktop.svg
home/.config/quickshell/ii/assets/icons/fluent/device-eq-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/device-eq.svg
home/.config/quickshell/ii/assets/icons/fluent/dismiss.svg
home/.config/quickshell/ii/assets/icons/fluent/drink-coffee-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/drink-coffee.svg
home/.config/quickshell/ii/assets/icons/fluent/empty.svg
home/.config/quickshell/ii/assets/icons/fluent/ethernet-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/ethernet.svg
home/.config/quickshell/ii/assets/icons/fluent/eyedropper-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/eyedropper.svg
home/.config/quickshell/ii/assets/icons/fluent/eye-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/eye-off-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/eye-off.svg
home/.config/quickshell/ii/assets/icons/fluent/eye.svg
home/.config/quickshell/ii/assets/icons/fluent/fire-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/fire.svg
home/.config/quickshell/ii/assets/icons/fluent/flash-off-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/flash-off.svg
home/.config/quickshell/ii/assets/icons/fluent/flash-on-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/flash-on.svg
home/.config/quickshell/ii/assets/icons/fluent/games-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/games.svg
home/.config/quickshell/ii/assets/icons/fluent/globe-search-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/globe-search.svg
home/.config/quickshell/ii/assets/icons/fluent/globe-shield-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/globe-shield.svg
home/.config/quickshell/ii/assets/icons/fluent/headphones-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/headphones.svg
home/.config/quickshell/ii/assets/icons/fluent/image-copy-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/image-copy.svg
home/.config/quickshell/ii/assets/icons/fluent/image-edit-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/image-edit.svg
home/.config/quickshell/ii/assets/icons/fluent/image-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/image.svg
home/.config/quickshell/ii/assets/icons/fluent/keyboard-dock-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/keyboard-dock.svg
home/.config/quickshell/ii/assets/icons/fluent/keyboard-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/keyboard.svg
home/.config/quickshell/ii/assets/icons/fluent/leaf-two-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/leaf-two.svg
home/.config/quickshell/ii/assets/icons/fluent/library-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/library.svg
home/.config/quickshell/ii/assets/icons/fluent/lock-closed-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/lock-closed.svg
home/.config/quickshell/ii/assets/icons/fluent/lock-open-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/lock-open.svg
home/.config/quickshell/ii/assets/icons/fluent/mic-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/mic-off-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/mic-off.svg
home/.config/quickshell/ii/assets/icons/fluent/mic-on.svg
home/.config/quickshell/ii/assets/icons/fluent/mic.svg
home/.config/quickshell/ii/assets/icons/fluent/more-horizontal-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/more-horizontal.svg
home/.config/quickshell/ii/assets/icons/fluent/music-note-2-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/music-note-2.svg
home/.config/quickshell/ii/assets/icons/fluent/news-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/news.svg
home/.config/quickshell/ii/assets/icons/fluent/next-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/next.svg
home/.config/quickshell/ii/assets/icons/fluent/open-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/open.svg
home/.config/quickshell/ii/assets/icons/fluent/options-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/options.svg
home/.config/quickshell/ii/assets/icons/fluent/pause-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/pause.svg
home/.config/quickshell/ii/assets/icons/fluent/people-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/people-settings-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/people-settings.svg
home/.config/quickshell/ii/assets/icons/fluent/people.svg
home/.config/quickshell/ii/assets/icons/fluent/people-team-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/people-team.svg
home/.config/quickshell/ii/assets/icons/fluent/phone-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/phone.svg
home/.config/quickshell/ii/assets/icons/fluent/pin-off.svg
home/.config/quickshell/ii/assets/icons/fluent/pin.svg
home/.config/quickshell/ii/assets/icons/fluent/play-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/play.svg
home/.config/quickshell/ii/assets/icons/fluent/power-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/power.svg
home/.config/quickshell/ii/assets/icons/fluent/previous-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/previous.svg
home/.config/quickshell/ii/assets/icons/fluent/README.md
home/.config/quickshell/ii/assets/icons/fluent/record-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/record.svg
home/.config/quickshell/ii/assets/icons/fluent/scan-text-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/scan-text.svg
home/.config/quickshell/ii/assets/icons/fluent/search-visual-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/search-visual.svg
home/.config/quickshell/ii/assets/icons/fluent/server-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/server.svg
home/.config/quickshell/ii/assets/icons/fluent/settings-cog-multiple-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/settings-cog-multiple.svg
home/.config/quickshell/ii/assets/icons/fluent/settings.svg
home/.config/quickshell/ii/assets/icons/fluent/shield-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/shield-lock-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/shield-lock.svg
home/.config/quickshell/ii/assets/icons/fluent/shield.svg
home/.config/quickshell/ii/assets/icons/fluent/speaker-0.svg
home/.config/quickshell/ii/assets/icons/fluent/speaker-1.svg
home/.config/quickshell/ii/assets/icons/fluent/speaker-2-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/speaker-mute-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/speaker-mute.svg
home/.config/quickshell/ii/assets/icons/fluent/speaker-none.svg
home/.config/quickshell/ii/assets/icons/fluent/speaker-off.svg
home/.config/quickshell/ii/assets/icons/fluent/speaker-settings.svg
home/.config/quickshell/ii/assets/icons/fluent/speaker.svg
home/.config/quickshell/ii/assets/icons/fluent/start-here-pressed.svg
home/.config/quickshell/ii/assets/icons/fluent/start-here.svg
home/.config/quickshell/ii/assets/icons/fluent/stop-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/stop.svg
home/.config/quickshell/ii/assets/icons/fluent/store-microsoft-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/store-microsoft.svg
home/.config/quickshell/ii/assets/icons/fluent/subtract-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/subtract.svg
home/.config/quickshell/ii/assets/icons/fluent/.svg
home/.config/quickshell/ii/assets/icons/fluent/system-search-checked-dark.svg
home/.config/quickshell/ii/assets/icons/fluent/system-search-checked-light.svg
home/.config/quickshell/ii/assets/icons/fluent/system-search-dark.svg
home/.config/quickshell/ii/assets/icons/fluent/system-search-light.svg
home/.config/quickshell/ii/assets/icons/fluent/task-view-dark.svg
home/.config/quickshell/ii/assets/icons/fluent/task-view-light.svg
home/.config/quickshell/ii/assets/icons/fluent/task-view-pressed-dark.svg
home/.config/quickshell/ii/assets/icons/fluent/task-view-pressed-light.svg
home/.config/quickshell/ii/assets/icons/fluent/temperature-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/temperature.svg
home/.config/quickshell/ii/assets/icons/fluent/video-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/video.svg
home/.config/quickshell/ii/assets/icons/fluent/wand-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/wand.svg
home/.config/quickshell/ii/assets/icons/fluent/weather-moon-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/weather-moon-off-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/weather-moon-off.svg
home/.config/quickshell/ii/assets/icons/fluent/weather-moon.svg
home/.config/quickshell/ii/assets/icons/fluent/weather-sunny-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/weather-sunny.svg
home/.config/quickshell/ii/assets/icons/fluent/widgets.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-1-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-1.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-2-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-2.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-3-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-3.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-4-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-4.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-lock-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-lock.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-off-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-off.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-warning-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/wifi-warning.svg
home/.config/quickshell/ii/assets/icons/fluent/window-shield-filled.svg
home/.config/quickshell/ii/assets/icons/fluent/window-shield.svg
home/.config/quickshell/ii/assets/icons/gentoo-symbolic.svg
home/.config/quickshell/ii/assets/icons/github-symbolic.svg
home/.config/quickshell/ii/assets/icons/linux-symbolic.svg
home/.config/quickshell/ii/assets/icons/microsoft-symbolic.svg
home/.config/quickshell/ii/assets/icons/mistral-symbolic.svg
home/.config/quickshell/ii/assets/icons/nixos-symbolic.svg
home/.config/quickshell/ii/assets/icons/nyarch-symbolic.svg
home/.config/quickshell/ii/assets/icons/ollama-symbolic.svg
home/.config/quickshell/ii/assets/icons/openai-symbolic.svg
home/.config/quickshell/ii/assets/icons/openrouter-symbolic.svg
home/.config/quickshell/ii/assets/icons/spark-symbolic.svg
home/.config/quickshell/ii/assets/icons/ubuntu-symbolic.svg
home/.config/quickshell/ii/assets/images/default_wallpaper.png
home/.config/quickshell/ii/defaults/ai/prompts/ii-Default.md
home/.config/quickshell/ii/defaults/ai/prompts/ii-Imouto.md
home/.config/quickshell/ii/defaults/ai/prompts/NoPrompt.md
home/.config/quickshell/ii/defaults/ai/prompts/nyarch-Acchan.md
home/.config/quickshell/ii/defaults/ai/prompts/w-FourPointedSparkle.md
home/.config/quickshell/ii/defaults/ai/prompts/w-OpenMechanicalFlower.md
home/.config/quickshell/ii/defaults/ai/README.md
home/.config/quickshell/ii/GlobalStates.qml
home/.config/quickshell/ii/killDialog.qml
home/.config/quickshell/ii/modules/common/Appearance.qml
home/.config/quickshell/ii/modules/common/Config.qml
home/.config/quickshell/ii/modules/common/Directories.qml
home/.config/quickshell/ii/modules/common/functions/ColorUtils.qml
home/.config/quickshell/ii/modules/common/functions/DateUtils.qml
home/.config/quickshell/ii/modules/common/functions/FileUtils.qml
home/.config/quickshell/ii/modules/common/functions/Fuzzy.qml
home/.config/quickshell/ii/modules/common/functions/fuzzysort.js
home/.config/quickshell/ii/modules/common/functions/levendist.js
home/.config/quickshell/ii/modules/common/functions/Levendist.qml
home/.config/quickshell/ii/modules/common/functions/NotificationUtils.qml
home/.config/quickshell/ii/modules/common/functions/ObjectUtils.qml
home/.config/quickshell/ii/modules/common/functions/Session.qml
home/.config/quickshell/ii/modules/common/functions/StringUtils.qml
home/.config/quickshell/ii/modules/common/Icons.qml
home/.config/quickshell/ii/modules/common/Images.qml
home/.config/quickshell/ii/modules/common/models/AdaptedMaterialScheme.qml
home/.config/quickshell/ii/modules/common/models/AnimatedTabIndexPair.qml
home/.config/quickshell/ii/modules/common/models/FolderListModelWithHistory.qml
home/.config/quickshell/ii/modules/common/models/gCloud/GCloudApi.qml
home/.config/quickshell/ii/modules/common/models/gCloud/GCloudTranslate.qml
home/.config/quickshell/ii/modules/common/models/gCloud/GCloudVision.qml
home/.config/quickshell/ii/modules/common/models/gCloud/GCloudVisionResult.qml
home/.config/quickshell/ii/modules/common/models/hyprland/HyprlandConfigOption.qml
home/.config/quickshell/ii/modules/common/models/IndexModel.qml
home/.config/quickshell/ii/modules/common/models/LauncherSearchResult.qml
home/.config/quickshell/ii/modules/common/models/NestableObject.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/AntiFlashbangToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/AudioToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/BluetoothToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/CloudflareWarpToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/ColorPickerToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/DarkModeToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/EasyEffectsToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/GameModeToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/IdleInhibitorToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/MicToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/MusicRecognitionToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/NetworkToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/NightLightToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/NotificationToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/OnScreenKeyboardToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/PowerProfilesToggle.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/QuickToggleModel.qml
home/.config/quickshell/ii/modules/common/models/quickToggles/ScreenSnipToggle.qml
home/.config/quickshell/ii/modules/common/panels/lock/LockContext.qml
home/.config/quickshell/ii/modules/common/panels/lock/LockScreen.qml
home/.config/quickshell/ii/modules/common/panels/lock/pam/fprintd.conf
home/.config/quickshell/ii/modules/common/Persistent.qml
home/.config/quickshell/ii/modules/common/utils/ImageDownloaderProcess.qml
home/.config/quickshell/ii/modules/common/utils/MultiTurnProcess.qml
home/.config/quickshell/ii/modules/common/utils/ScreenshotAction.qml
home/.config/quickshell/ii/modules/common/utils/TempScreenshotProcess.qml
home/.config/quickshell/ii/modules/common/widgets/AddressBar.qml
home/.config/quickshell/ii/modules/common/widgets/AddressBreadcrumb.qml
home/.config/quickshell/ii/modules/common/widgets/ButtonGroup.qml
home/.config/quickshell/ii/modules/common/widgets/CalendarView.qml
home/.config/quickshell/ii/modules/common/widgets/Circle.qml
home/.config/quickshell/ii/modules/common/widgets/CircularProgress.qml
home/.config/quickshell/ii/modules/common/widgets/CliphistImage.qml
home/.config/quickshell/ii/modules/common/widgets/ClippedFilledCircularProgress.qml
home/.config/quickshell/ii/modules/common/widgets/ClippedProgressBar.qml
home/.config/quickshell/ii/modules/common/widgets/ConfigRow.qml
home/.config/quickshell/ii/modules/common/widgets/ConfigSelectionArray.qml
home/.config/quickshell/ii/modules/common/widgets/ConfigSlider.qml
home/.config/quickshell/ii/modules/common/widgets/ConfigSpinBox.qml
home/.config/quickshell/ii/modules/common/widgets/ConfigSwitch.qml
home/.config/quickshell/ii/modules/common/widgets/ContentPage.qml
home/.config/quickshell/ii/modules/common/widgets/ContentSection.qml
home/.config/quickshell/ii/modules/common/widgets/ContentSubsectionLabel.qml
home/.config/quickshell/ii/modules/common/widgets/ContentSubsection.qml
home/.config/quickshell/ii/modules/common/widgets/CustomIcon.qml
home/.config/quickshell/ii/modules/common/widgets/DashedBorder.qml
home/.config/quickshell/ii/modules/common/widgets/DialogButton.qml
home/.config/quickshell/ii/modules/common/widgets/DialogListItem.qml
home/.config/quickshell/ii/modules/common/widgets/DirectoryIcon.qml
home/.config/quickshell/ii/modules/common/widgets/DragManager.qml
home/.config/quickshell/ii/modules/common/widgets/ErrorShakeAnimation.qml
home/.config/quickshell/ii/modules/common/widgets/FadeLoader.qml
home/.config/quickshell/ii/modules/common/widgets/Favicon.qml
home/.config/quickshell/ii/modules/common/widgets/FloatingActionButton.qml
home/.config/quickshell/ii/modules/common/widgets/FlowButtonGroup.qml
home/.config/quickshell/ii/modules/common/widgets/FocusedScrollMouseArea.qml
home/.config/quickshell/ii/modules/common/widgets/FullscreenPolkitWindow.qml
home/.config/quickshell/ii/modules/common/widgets/Graph.qml
home/.config/quickshell/ii/modules/common/widgets/GroupButton.qml
home/.config/quickshell/ii/modules/common/widgets/IconAndTextToolbarButton.qml
home/.config/quickshell/ii/modules/common/widgets/IconToolbarButton.qml
home/.config/quickshell/ii/modules/common/widgets/KeyboardKey.qml
home/.config/quickshell/ii/modules/common/widgets/LightDarkPreferenceButton.qml
home/.config/quickshell/ii/modules/common/widgets/MaskMultiEffect.qml
home/.config/quickshell/ii/modules/common/widgets/MaterialCookie.qml
home/.config/quickshell/ii/modules/common/widgets/MaterialLoadingIndicator.qml
home/.config/quickshell/ii/modules/common/widgets/MaterialShape.qml
home/.config/quickshell/ii/modules/common/widgets/MaterialShapeWrappedMaterialSymbol.qml
home/.config/quickshell/ii/modules/common/widgets/MaterialSymbol.qml
home/.config/quickshell/ii/modules/common/widgets/MaterialTextArea.qml
home/.config/quickshell/ii/modules/common/widgets/MaterialTextField.qml
home/.config/quickshell/ii/modules/common/widgets/MenuButton.qml
home/.config/quickshell/ii/modules/common/widgets/NavigationRailButton.qml
home/.config/quickshell/ii/modules/common/widgets/NavigationRailExpandButton.qml
home/.config/quickshell/ii/modules/common/widgets/NavigationRail.qml
home/.config/quickshell/ii/modules/common/widgets/NavigationRailTabArray.qml
home/.config/quickshell/ii/modules/common/widgets/NoticeBox.qml
home/.config/quickshell/ii/modules/common/widgets/NotificationActionButton.qml
home/.config/quickshell/ii/modules/common/widgets/NotificationAppIcon.qml
home/.config/quickshell/ii/modules/common/widgets/NotificationGroupExpandButton.qml
home/.config/quickshell/ii/modules/common/widgets/NotificationGroup.qml
home/.config/quickshell/ii/modules/common/widgets/NotificationItem.qml
home/.config/quickshell/ii/modules/common/widgets/NotificationListView.qml
home/.config/quickshell/ii/modules/common/widgets/OptionalMaterialSymbol.qml
home/.config/quickshell/ii/modules/common/widgets/PagePlaceholder.qml
home/.config/quickshell/ii/modules/common/widgets/PointingHandInteraction.qml
home/.config/quickshell/ii/modules/common/widgets/PointingHandLinkHover.qml
home/.config/quickshell/ii/modules/common/widgets/PopupToolTip.qml
home/.config/quickshell/ii/modules/common/widgets/Revealer.qml
home/.config/quickshell/ii/modules/common/widgets/RippleButton.qml
home/.config/quickshell/ii/modules/common/widgets/RippleButtonWithIcon.qml
home/.config/quickshell/ii/modules/common/widgets/RoundCorner.qml
home/.config/quickshell/ii/modules/common/widgets/ScrollEdgeFade.qml
home/.config/quickshell/ii/modules/common/widgets/SecondaryTabBar.qml
home/.config/quickshell/ii/modules/common/widgets/SecondaryTabButton.qml
home/.config/quickshell/ii/modules/common/widgets/SelectionDialog.qml
home/.config/quickshell/ii/modules/common/widgets/SelectionGroupButton.qml
home/.config/quickshell/ii/modules/common/widgets/shapes/example.qml
home/.config/quickshell/ii/modules/common/widgets/shapes/example-squircle.qml
home/.config/quickshell/ii/modules/common/widgets/shapes/geometry/offset.js
home/.config/quickshell/ii/modules/common/widgets/shapes/.gitignore
home/.config/quickshell/ii/modules/common/widgets/shapes/graphics/matrix.js
home/.config/quickshell/ii/modules/common/widgets/shapes/LICENSE
home/.config/quickshell/ii/modules/common/widgets/shapes/material-shapes.js
home/.config/quickshell/ii/modules/common/widgets/shapes/README.md
home/.config/quickshell/ii/modules/common/widgets/shapes/ShapeCanvas.qml
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/corner-rounding.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/cubic.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/feature.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/feature-mapping.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/float-mapping.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/morph.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/point.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/polygon-measure.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/rounded-corner.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/rounded-polygon.js
home/.config/quickshell/ii/modules/common/widgets/shapes/shapes/utils.js
home/.config/quickshell/ii/modules/common/widgets/SineCookie.qml
home/.config/quickshell/ii/modules/common/widgets/SqueezedAnnotationStyledText.qml
home/.config/quickshell/ii/modules/common/widgets/StyledBlurEffect.qml
home/.config/quickshell/ii/modules/common/widgets/StyledComboBox.qml
home/.config/quickshell/ii/modules/common/widgets/StyledDropShadow.qml
home/.config/quickshell/ii/modules/common/widgets/StyledFlickable.qml
home/.config/quickshell/ii/modules/common/widgets/StyledImage.qml
home/.config/quickshell/ii/modules/common/widgets/StyledIndeterminateProgressBar.qml
home/.config/quickshell/ii/modules/common/widgets/StyledListView.qml
home/.config/quickshell/ii/modules/common/widgets/StyledProgressBar.qml
home/.config/quickshell/ii/modules/common/widgets/StyledRadioButton.qml
home/.config/quickshell/ii/modules/common/widgets/StyledRectangularShadow.qml
home/.config/quickshell/ii/modules/common/widgets/StyledScrollBar.qml
home/.config/quickshell/ii/modules/common/widgets/StyledSlider.qml
home/.config/quickshell/ii/modules/common/widgets/StyledSpinBox.qml
home/.config/quickshell/ii/modules/common/widgets/StyledSwitch.qml
home/.config/quickshell/ii/modules/common/widgets/StyledTextArea.qml
home/.config/quickshell/ii/modules/common/widgets/StyledTextInput.qml
home/.config/quickshell/ii/modules/common/widgets/StyledText.qml
home/.config/quickshell/ii/modules/common/widgets/StyledToolTipContent.qml
home/.config/quickshell/ii/modules/common/widgets/StyledToolTip.qml
home/.config/quickshell/ii/modules/common/widgets/ThumbnailImage.qml
home/.config/quickshell/ii/modules/common/widgets/ToolbarButton.qml
home/.config/quickshell/ii/modules/common/widgets/ToolbarPairedFab.qml
home/.config/quickshell/ii/modules/common/widgets/Toolbar.qml
home/.config/quickshell/ii/modules/common/widgets/ToolbarTabBar.qml
home/.config/quickshell/ii/modules/common/widgets/ToolbarTabButton.qml
home/.config/quickshell/ii/modules/common/widgets/ToolbarTextField.qml
home/.config/quickshell/ii/modules/common/widgets/VerticalButtonGroup.qml
home/.config/quickshell/ii/modules/common/widgets/VibrantToolbarButton.qml
home/.config/quickshell/ii/modules/common/widgets/WaveVisualizer.qml
home/.config/quickshell/ii/modules/common/widgets/WavyLine.qml
home/.config/quickshell/ii/modules/common/widgets/WeekRow.qml
home/.config/quickshell/ii/modules/common/widgets/widgetCanvas/AbstractOverlayWidget.qml
home/.config/quickshell/ii/modules/common/widgets/widgetCanvas/AbstractWidget.qml
home/.config/quickshell/ii/modules/common/widgets/widgetCanvas/WidgetCanvas.qml
home/.config/quickshell/ii/modules/common/widgets/WindowDialogButtonRow.qml
home/.config/quickshell/ii/modules/common/widgets/WindowDialogParagraph.qml
home/.config/quickshell/ii/modules/common/widgets/WindowDialog.qml
home/.config/quickshell/ii/modules/common/widgets/WindowDialogSectionHeader.qml
home/.config/quickshell/ii/modules/common/widgets/WindowDialogSeparator.qml
home/.config/quickshell/ii/modules/common/widgets/WindowDialogSlider.qml
home/.config/quickshell/ii/modules/common/widgets/WindowDialogTitle.qml
home/.config/quickshell/ii/modules/ii/background/Background.qml
home/.config/quickshell/ii/modules/ii/background/widgets/AbstractBackgroundWidget.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/ClockText.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/ClockWidget.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/CookieClock.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/CookieQuote.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/dateIndicator/BubbleDate.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/dateIndicator/DateIndicator.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/dateIndicator/RectangleDate.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/dateIndicator/RotatingDate.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/DigitalClock.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/HourHand.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/HourMarks.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/MinuteHand.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/minuteMarks/BigHourNumbers.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/minuteMarks/Dots.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/minuteMarks/Lines.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/minuteMarks/MinuteMarks.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/SecondHand.qml
home/.config/quickshell/ii/modules/ii/background/widgets/clock/TimeColumn.qml
home/.config/quickshell/ii/modules/ii/background/widgets/weather/WeatherWidget.qml
home/.config/quickshell/ii/modules/ii/bar/ActiveWindow.qml
home/.config/quickshell/ii/modules/ii/bar/BarContent.qml
home/.config/quickshell/ii/modules/ii/bar/BarGroup.qml
home/.config/quickshell/ii/modules/ii/bar/Bar.qml
home/.config/quickshell/ii/modules/ii/bar/BatteryIndicator.qml
home/.config/quickshell/ii/modules/ii/bar/BatteryPopup.qml
home/.config/quickshell/ii/modules/ii/bar/CircleUtilButton.qml
home/.config/quickshell/ii/modules/ii/bar/ClockWidgetPopup.qml
home/.config/quickshell/ii/modules/ii/bar/ClockWidget.qml
home/.config/quickshell/ii/modules/ii/bar/HyprlandXkbIndicator.qml
home/.config/quickshell/ii/modules/ii/bar/LeftSidebarButton.qml
home/.config/quickshell/ii/modules/ii/bar/Media.qml
home/.config/quickshell/ii/modules/ii/bar/NotificationUnreadCount.qml
home/.config/quickshell/ii/modules/ii/bar/Resource.qml
home/.config/quickshell/ii/modules/ii/bar/ResourcesPopup.qml
home/.config/quickshell/ii/modules/ii/bar/Resources.qml
home/.config/quickshell/ii/modules/ii/bar/ScrollHint.qml
home/.config/quickshell/ii/modules/ii/bar/StyledPopupHeaderRow.qml
home/.config/quickshell/ii/modules/ii/bar/StyledPopup.qml
home/.config/quickshell/ii/modules/ii/bar/StyledPopupValueRow.qml
home/.config/quickshell/ii/modules/ii/bar/SysTrayItem.qml
home/.config/quickshell/ii/modules/ii/bar/SysTrayMenuEntry.qml
home/.config/quickshell/ii/modules/ii/bar/SysTrayMenu.qml
home/.config/quickshell/ii/modules/ii/bar/SysTray.qml
home/.config/quickshell/ii/modules/ii/bar/UtilButtons.qml
home/.config/quickshell/ii/modules/ii/bar/weather/WeatherBar.qml
home/.config/quickshell/ii/modules/ii/bar/weather/WeatherCard.qml
home/.config/quickshell/ii/modules/ii/bar/weather/WeatherPopup.qml
home/.config/quickshell/ii/modules/ii/bar/Workspaces.qml
home/.config/quickshell/ii/modules/ii/cheatsheet/CheatsheetKeybinds.qml
home/.config/quickshell/ii/modules/ii/cheatsheet/CheatsheetPeriodicTable.qml
home/.config/quickshell/ii/modules/ii/cheatsheet/Cheatsheet.qml
home/.config/quickshell/ii/modules/ii/cheatsheet/ElementTile.qml
home/.config/quickshell/ii/modules/ii/cheatsheet/periodic_table.js
home/.config/quickshell/ii/modules/ii/dock/DockAppButton.qml
home/.config/quickshell/ii/modules/ii/dock/DockApps.qml
home/.config/quickshell/ii/modules/ii/dock/DockButton.qml
home/.config/quickshell/ii/modules/ii/dock/Dock.qml
home/.config/quickshell/ii/modules/ii/dock/DockSeparator.qml
home/.config/quickshell/ii/modules/ii/lock/Lock.qml
home/.config/quickshell/ii/modules/ii/lock/LockSurface.qml
home/.config/quickshell/ii/modules/ii/lock/PasswordChars.qml
home/.config/quickshell/ii/modules/ii/mediaControls/MediaControls.qml
home/.config/quickshell/ii/modules/ii/mediaControls/PlayerControl.qml
home/.config/quickshell/ii/modules/ii/notificationPopup/NotificationPopup.qml
home/.config/quickshell/ii/modules/ii/onScreenDisplay/indicators/BrightnessIndicator.qml
home/.config/quickshell/ii/modules/ii/onScreenDisplay/indicators/GammaIndicator.qml
home/.config/quickshell/ii/modules/ii/onScreenDisplay/indicators/VolumeIndicator.qml
home/.config/quickshell/ii/modules/ii/onScreenDisplay/OnScreenDisplay.qml
home/.config/quickshell/ii/modules/ii/onScreenDisplay/OsdValueIndicator.qml
home/.config/quickshell/ii/modules/ii/onScreenKeyboard/layouts.js
home/.config/quickshell/ii/modules/ii/onScreenKeyboard/OnScreenKeyboard.qml
home/.config/quickshell/ii/modules/ii/onScreenKeyboard/OskContent.qml
home/.config/quickshell/ii/modules/ii/onScreenKeyboard/OskKey.qml
home/.config/quickshell/ii/modules/ii/overlay/crosshair/CrosshairContent.qml
home/.config/quickshell/ii/modules/ii/overlay/crosshair/Crosshair.qml
home/.config/quickshell/ii/modules/ii/overlay/floatingImage/FloatingImage.qml
home/.config/quickshell/ii/modules/ii/overlay/fpsLimiter/FpsLimiterContent.qml
home/.config/quickshell/ii/modules/ii/overlay/fpsLimiter/FpsLimiter.qml
home/.config/quickshell/ii/modules/ii/overlay/notes/NotesContent.qml
home/.config/quickshell/ii/modules/ii/overlay/notes/Notes.qml
home/.config/quickshell/ii/modules/ii/overlay/OverlayBackground.qml
home/.config/quickshell/ii/modules/ii/overlay/OverlayContent.qml
home/.config/quickshell/ii/modules/ii/overlay/OverlayContext.qml
home/.config/quickshell/ii/modules/ii/overlay/Overlay.qml
home/.config/quickshell/ii/modules/ii/overlay/OverlayTaskbar.qml
home/.config/quickshell/ii/modules/ii/overlay/OverlayWidgetDelegateChooser.qml
home/.config/quickshell/ii/modules/ii/overlay/recorder/Recorder.qml
home/.config/quickshell/ii/modules/ii/overlay/resources/Resources.qml
home/.config/quickshell/ii/modules/ii/overlay/StyledOverlayWidget.qml
home/.config/quickshell/ii/modules/ii/overlay/volumeMixer/VolumeMixer.qml
home/.config/quickshell/ii/modules/ii/overview/Overview.qml
home/.config/quickshell/ii/modules/ii/overview/OverviewWidget.qml
home/.config/quickshell/ii/modules/ii/overview/OverviewWindow.qml
home/.config/quickshell/ii/modules/ii/overview/SearchBar.qml
home/.config/quickshell/ii/modules/ii/overview/SearchItem.qml
home/.config/quickshell/ii/modules/ii/overview/SearchWidget.qml
home/.config/quickshell/ii/modules/ii/polkit/PolkitContent.qml
home/.config/quickshell/ii/modules/ii/polkit/Polkit.qml
home/.config/quickshell/ii/modules/ii/regionSelector/CircleSelectionDetails.qml
home/.config/quickshell/ii/modules/ii/regionSelector/CursorGuide.qml
home/.config/quickshell/ii/modules/ii/regionSelector/OptionsToolbar.qml
home/.config/quickshell/ii/modules/ii/regionSelector/RectCornersSelectionDetails.qml
home/.config/quickshell/ii/modules/ii/regionSelector/RegionFunctions.qml
home/.config/quickshell/ii/modules/ii/regionSelector/RegionSelection.qml
home/.config/quickshell/ii/modules/ii/regionSelector/RegionSelector.qml
home/.config/quickshell/ii/modules/ii/regionSelector/TargetRegion.qml
home/.config/quickshell/ii/modules/ii/screenCorners/ScreenCorners.qml
home/.config/quickshell/ii/modules/ii/screenTranslator/ScreenTextOverlay.qml
home/.config/quickshell/ii/modules/ii/screenTranslator/ScreenTranslatorPanel.qml
home/.config/quickshell/ii/modules/ii/screenTranslator/ScreenTranslator.qml
home/.config/quickshell/ii/modules/ii/sessionScreen/SessionActionButton.qml
home/.config/quickshell/ii/modules/ii/sessionScreen/SessionScreen.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/AiMessageControlButton.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/AiMessage.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/AnnotationSourceButton.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/AttachedFileIndicator.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/MessageCodeBlock.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/MessageTextBlock.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/MessageThinkBlock.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/AiChat.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/aiChat/SearchQueryButton.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/anime/BooruImage.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/anime/BooruResponse.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/Anime.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/ApiCommandButton.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/ApiInputBoxIndicator.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/DescriptionBox.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/ScrollToBottomButton.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/SidebarLeftContent.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/SidebarLeft.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/translator/LanguageSelectorButton.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/Translator.qml
home/.config/quickshell/ii/modules/ii/sidebarLeft/translator/TextCanvas.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/bluetoothDevices/BluetoothDeviceItem.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/bluetoothDevices/BluetoothDialog.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/BottomWidgetGroup.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/calendar/CalendarDayButton.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/calendar/CalendarHeaderButton.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/calendar/calendar_layout.js
home/.config/quickshell/ii/modules/ii/sidebarRight/calendar/CalendarWidget.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/CenterWidgetGroup.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/nightLight/NightLightDialog.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/notifications/NotificationList.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/notifications/NotificationStatusButton.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/pomodoro/PomodoroTimer.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/pomodoro/PomodoroWidget.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/pomodoro/Stopwatch.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/QuickSliders.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/AbstractQuickPanel.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/AndroidQuickPanel.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidAntiFlashbangToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidAudioToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidBluetoothToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidCloudflareWarpToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidColorPickerToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidDarkModeToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidEasyEffectsToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidGameModeToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidIdleInhibitorToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidMicToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidMusicRecognition.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidNetworkToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidNightLightToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidNotificationToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidOnScreenKeyboardToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidPowerProfileToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidQuickToggleButton.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidScreenSnipToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/androidStyle/AndroidToggleDelegateChooser.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/ClassicQuickPanel.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/BluetoothToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/CloudflareWarp.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/EasyEffectsToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/GameMode.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/IdleInhibitor.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/NetworkToggle.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/NightLight.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/quickToggles/classicStyle/QuickToggleButton.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/SidebarRightContent.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/SidebarRight.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/todo/TaskList.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/todo/TodoItemActionButton.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/todo/TodoWidget.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/volumeMixer/AudioDeviceSelectorButton.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/volumeMixer/VolumeDialogContent.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/volumeMixer/VolumeDialog.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/volumeMixer/VolumeMixerEntry.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/wifiNetworks/WifiDialog.qml
home/.config/quickshell/ii/modules/ii/sidebarRight/wifiNetworks/WifiNetworkItem.qml
home/.config/quickshell/ii/modules/ii/verticalBar/BatteryIndicator.qml
home/.config/quickshell/ii/modules/ii/verticalBar/Resource.qml
home/.config/quickshell/ii/modules/ii/verticalBar/Resources.qml
home/.config/quickshell/ii/modules/ii/verticalBar/VerticalBarContent.qml
home/.config/quickshell/ii/modules/ii/verticalBar/VerticalBar.qml
home/.config/quickshell/ii/modules/ii/verticalBar/VerticalClockWidget.qml
home/.config/quickshell/ii/modules/ii/verticalBar/VerticalMedia.qml
home/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperDirectoryItem.qml
home/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelectorContent.qml
home/.config/quickshell/ii/modules/ii/wallpaperSelector/WallpaperSelector.qml
home/.config/quickshell/ii/modules/settings/About.qml
home/.config/quickshell/ii/modules/settings/AdvancedConfig.qml
home/.config/quickshell/ii/modules/settings/BackgroundConfig.qml
home/.config/quickshell/ii/modules/settings/BarConfig.qml
home/.config/quickshell/ii/modules/settings/GeneralConfig.qml
home/.config/quickshell/ii/modules/settings/InterfaceConfig.qml
home/.config/quickshell/ii/modules/settings/QuickConfig.qml
home/.config/quickshell/ii/modules/settings/ServicesConfig.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/ActionCenterContent.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/ActionCenterContext.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/bluetooth/BluetoothControl.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/bluetooth/BluetoothDeviceItem.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/ExpandableChoiceButton.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/HeaderRow.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/mainPage/MainPageBody.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/mainPage/MainPageBodySliders.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/mainPage/MainPageBodyToggles.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/mainPage/MainPageFooter.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/MediaPaneContent.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/nightLight/NightLightControl.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/SectionText.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/ToggleItem.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/toggles/ActionCenterToggleButton.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/toggles/ActionCenterTogglesDelegateChooser.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/toggles/WNetworkToggle.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/volumeControl/VolumeControl.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/volumeControl/VolumeEntry.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/WaffleActionCenter.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/wifi/WifiControl.qml
home/.config/quickshell/ii/modules/waffle/actionCenter/wifi/WWifiNetworkItem.qml
home/.config/quickshell/ii/modules/waffle/background/WaffleBackground.qml
home/.config/quickshell/ii/modules/waffle/bar/AppButton.qml
home/.config/quickshell/ii/modules/waffle/bar/BarButton.qml
home/.config/quickshell/ii/modules/waffle/bar/BarIconButton.qml
home/.config/quickshell/ii/modules/waffle/bar/BarMenu.qml
home/.config/quickshell/ii/modules/waffle/bar/BarPopup.qml
home/.config/quickshell/ii/modules/waffle/bar/BarToolTip.qml
home/.config/quickshell/ii/modules/waffle/bar/SearchButton.qml
home/.config/quickshell/ii/modules/waffle/bar/StartButton.qml
home/.config/quickshell/ii/modules/waffle/bar/SystemButton.qml
home/.config/quickshell/ii/modules/waffle/bar/tasks/TaskAppButton.qml
home/.config/quickshell/ii/modules/waffle/bar/tasks/TaskPreview.qml
home/.config/quickshell/ii/modules/waffle/bar/tasks/Tasks.qml
home/.config/quickshell/ii/modules/waffle/bar/tasks/WindowPreview.qml
home/.config/quickshell/ii/modules/waffle/bar/TaskViewButton.qml
home/.config/quickshell/ii/modules/waffle/bar/TimeButton.qml
home/.config/quickshell/ii/modules/waffle/bar/tray/TrayButton.qml
home/.config/quickshell/ii/modules/waffle/bar/tray/TrayOverflowMenu.qml
home/.config/quickshell/ii/modules/waffle/bar/tray/Tray.qml
home/.config/quickshell/ii/modules/waffle/bar/UpdatesButton.qml
home/.config/quickshell/ii/modules/waffle/bar/WaffleBarContent.qml
home/.config/quickshell/ii/modules/waffle/bar/WaffleBar.qml
home/.config/quickshell/ii/modules/waffle/bar/WidgetsButton.qml
home/.config/quickshell/ii/modules/waffle/lock/WaffleLock.qml
home/.config/quickshell/ii/modules/waffle/looks/AcrylicButton.qml
home/.config/quickshell/ii/modules/waffle/looks/AcrylicRectangle.qml
home/.config/quickshell/ii/modules/waffle/looks/BodyRectangle.qml
home/.config/quickshell/ii/modules/waffle/looks/CloseButton.qml
home/.config/quickshell/ii/modules/waffle/looks/FluentIcon.qml
home/.config/quickshell/ii/modules/waffle/looks/FooterRectangle.qml
home/.config/quickshell/ii/modules/waffle/looks/Looks.qml
home/.config/quickshell/ii/modules/waffle/looks/VerticalPageIndicator.qml
home/.config/quickshell/ii/modules/waffle/looks/WAmbientShadow.qml
home/.config/quickshell/ii/modules/waffle/looks/WAppIcon.qml
home/.config/quickshell/ii/modules/waffle/looks/WBarAttachedPanelContent.qml
home/.config/quickshell/ii/modules/waffle/looks/WBorderedButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WBorderlessButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WChoiceButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WFadeLoader.qml
home/.config/quickshell/ii/modules/waffle/looks/WIcons.qml
home/.config/quickshell/ii/modules/waffle/looks/WIndeterminateProgressBar.qml
home/.config/quickshell/ii/modules/waffle/looks/WListView.qml
home/.config/quickshell/ii/modules/waffle/looks/WMenuItem.qml
home/.config/quickshell/ii/modules/waffle/looks/WMenu.qml
home/.config/quickshell/ii/modules/waffle/looks/WMouseAreaButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WPanelIconButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WPanelPageColumn.qml
home/.config/quickshell/ii/modules/waffle/looks/WPanelSeparator.qml
home/.config/quickshell/ii/modules/waffle/looks/WPane.qml
home/.config/quickshell/ii/modules/waffle/looks/WPopupToolTip.qml
home/.config/quickshell/ii/modules/waffle/looks/WProgressBar.qml
home/.config/quickshell/ii/modules/waffle/looks/WRectangularShadow.qml
home/.config/quickshell/ii/modules/waffle/looks/WRectangularShadowThis.qml
home/.config/quickshell/ii/modules/waffle/looks/WScrollBar.qml
home/.config/quickshell/ii/modules/waffle/looks/WSlider.qml
home/.config/quickshell/ii/modules/waffle/looks/WStackView.qml
home/.config/quickshell/ii/modules/waffle/looks/WSwitch.qml
home/.config/quickshell/ii/modules/waffle/looks/WTextButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WTextField.qml
home/.config/quickshell/ii/modules/waffle/looks/WTextInput.qml
home/.config/quickshell/ii/modules/waffle/looks/WText.qml
home/.config/quickshell/ii/modules/waffle/looks/WTextWithFixedWidth.qml
home/.config/quickshell/ii/modules/waffle/looks/WToolbarButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WToolbarIconButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WToolbarIconTabButton.qml
home/.config/quickshell/ii/modules/waffle/looks/WToolbar.qml
home/.config/quickshell/ii/modules/waffle/looks/WToolbarSeparator.qml
home/.config/quickshell/ii/modules/waffle/looks/WToolbarTabBar.qml
home/.config/quickshell/ii/modules/waffle/looks/WToolTipContent.qml
home/.config/quickshell/ii/modules/waffle/looks/WToolTip.qml
home/.config/quickshell/ii/modules/waffle/looks/WUserAvatar.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/CalendarWidget.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/DateHeader.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/FocusFooter.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/NotificationCenterContent.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/NotificationHeaderButton.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/NotificationPaneContent.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/SmallBorderedIconAndTextButton.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/SmallBorderedIconButton.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/WaffleNotificationCenter.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/WNotificationAppIcon.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/WNotificationDismissAnim.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/WNotificationGroup.qml
home/.config/quickshell/ii/modules/waffle/notificationCenter/WSingleNotification.qml
home/.config/quickshell/ii/modules/waffle/notificationPopup/WaffleNotificationPopup.qml
home/.config/quickshell/ii/modules/waffle/onScreenDisplay/BrightnessOSD.qml
home/.config/quickshell/ii/modules/waffle/onScreenDisplay/OSDValue.qml
home/.config/quickshell/ii/modules/waffle/onScreenDisplay/VolumeOSD.qml
home/.config/quickshell/ii/modules/waffle/onScreenDisplay/WaffleOSD.qml
home/.config/quickshell/ii/modules/waffle/polkit/WafflePolkit.qml
home/.config/quickshell/ii/modules/waffle/polkit/WPolkitContent.qml
home/.config/quickshell/ii/modules/waffle/README.md
home/.config/quickshell/ii/modules/waffle/screenSnip/WRectangularSelection.qml
home/.config/quickshell/ii/modules/waffle/screenSnip/WRegionSelectionPanel.qml
home/.config/quickshell/ii/modules/waffle/screenSnip/WScreenSnip.qml
home/.config/quickshell/ii/modules/waffle/sessionScreen/PowerButton.qml
home/.config/quickshell/ii/modules/waffle/sessionScreen/SessionScreenContent.qml
home/.config/quickshell/ii/modules/waffle/sessionScreen/WaffleSessionScreen.qml
home/.config/quickshell/ii/modules/waffle/sessionScreen/WSessionScreenTextButton.qml
home/.config/quickshell/ii/modules/waffle/startMenu/SearchBar.qml
home/.config/quickshell/ii/modules/waffle/startMenu/searchPage/SearchEntryIcon.qml
home/.config/quickshell/ii/modules/waffle/startMenu/searchPage/SearchPageContent.qml
home/.config/quickshell/ii/modules/waffle/startMenu/searchPage/SearchResultButton.qml
home/.config/quickshell/ii/modules/waffle/startMenu/searchPage/SearchResults.qml
home/.config/quickshell/ii/modules/waffle/startMenu/searchPage/TagStrip.qml
home/.config/quickshell/ii/modules/waffle/startMenu/StartMenuContent.qml
home/.config/quickshell/ii/modules/waffle/startMenu/StartMenuContext.qml
home/.config/quickshell/ii/modules/waffle/startMenu/startPage/AggregatedAppCategoryModel.qml
home/.config/quickshell/ii/modules/waffle/startMenu/startPage/AllAppsGrid.qml
home/.config/quickshell/ii/modules/waffle/startMenu/startPage/AppCategoryGrid.qml
home/.config/quickshell/ii/modules/waffle/startMenu/startPage/BigAppGrid.qml
home/.config/quickshell/ii/modules/waffle/startMenu/startPage/StartAppButton.qml
home/.config/quickshell/ii/modules/waffle/startMenu/startPage/StartPageApps.qml
home/.config/quickshell/ii/modules/waffle/startMenu/startPage/StartPageContent.qml
home/.config/quickshell/ii/modules/waffle/startMenu/startPage/StartUserButton.qml
home/.config/quickshell/ii/modules/waffle/startMenu/WaffleStartMenu.qml
home/.config/quickshell/ii/modules/waffle/taskView/TaskViewContent.qml
home/.config/quickshell/ii/modules/waffle/taskView/TaskViewWindow.qml
home/.config/quickshell/ii/modules/waffle/taskView/TaskViewWorkspace.qml
home/.config/quickshell/ii/modules/waffle/taskView/WaffleTaskView.qml
home/.config/quickshell/ii/modules/waffle/taskView/window-layout.js
home/.config/quickshell/ii/panelFamilies/IllogicalImpulseFamily.qml
home/.config/quickshell/ii/panelFamilies/PanelLoader.qml
home/.config/quickshell/ii/panelFamilies/WaffleFamily.qml
home/.config/quickshell/ii/.qmlformat.ini
home/.config/quickshell/ii/ReloadPopup.qml
home/.config/quickshell/ii/scripts/ai/gemini-categorize-wallpaper.sh
home/.config/quickshell/ii/scripts/ai/gemini-translate.sh
home/.config/quickshell/ii/scripts/ai/show-installed-ollama-models.sh
home/.config/quickshell/ii/scripts/cava/raw_output_config.txt
home/.config/quickshell/ii/scripts/colors/applycolor.sh
home/.config/quickshell/ii/scripts/colors/code/material-code-set-color.sh
home/.config/quickshell/ii/scripts/colors/generate_colors_material.py
home/.config/quickshell/ii/scripts/colors/random/random_konachan_wall.sh
home/.config/quickshell/ii/scripts/colors/random/random_osu_wall.sh
home/.config/quickshell/ii/scripts/colors/scheme_for_image.py
home/.config/quickshell/ii/scripts/colors/switchwall.sh
home/.config/quickshell/ii/scripts/colors/terminal/kitty-theme.conf
home/.config/quickshell/ii/scripts/colors/terminal/scheme-base.json
home/.config/quickshell/ii/scripts/colors/terminal/sequences.txt
home/.config/quickshell/ii/scripts/hyprland/get_keybinds.py
home/.config/quickshell/ii/scripts/hyprland/hyprconfigurator.py
home/.config/quickshell/ii/scripts/images/find_regions.py
home/.config/quickshell/ii/scripts/images/find-regions-venv.sh
home/.config/quickshell/ii/scripts/images/least_busy_region.py
home/.config/quickshell/ii/scripts/images/least-busy-region-venv.sh
home/.config/quickshell/ii/scripts/images/text_color.py
home/.config/quickshell/ii/scripts/images/text-color-venv.sh
home/.config/quickshell/ii/scripts/keyring/is_unlocked.sh
home/.config/quickshell/ii/scripts/keyring/try_lookup.sh
home/.config/quickshell/ii/scripts/keyring/unlock.sh
home/.config/quickshell/ii/scripts/kvantum/adwsvgDark.py
home/.config/quickshell/ii/scripts/kvantum/adwsvg.py
home/.config/quickshell/ii/scripts/kvantum/changeAdwColors.py
home/.config/quickshell/ii/scripts/kvantum/materialQT.sh
home/.config/quickshell/ii/scripts/musicRecognition/recognize-music.sh
home/.config/quickshell/ii/scripts/thumbnails/generate-thumbnails-magick.sh
home/.config/quickshell/ii/scripts/thumbnails/thumbgen.py
home/.config/quickshell/ii/scripts/thumbnails/thumbgen-venv.sh
home/.config/quickshell/ii/scripts/videos/record.sh
home/.config/quickshell/ii/services/ai/AiMessageData.qml
home/.config/quickshell/ii/services/ai/AiModel.qml
home/.config/quickshell/ii/services/ai/ApiStrategy.qml
home/.config/quickshell/ii/services/ai/GeminiApiStrategy.qml
home/.config/quickshell/ii/services/ai/MistralApiStrategy.qml
home/.config/quickshell/ii/services/ai/OpenAiApiStrategy.qml
home/.config/quickshell/ii/services/Ai.qml
home/.config/quickshell/ii/services/AppSearch.qml
home/.config/quickshell/ii/services/Audio.qml
home/.config/quickshell/ii/services/Battery.qml
home/.config/quickshell/ii/services/BluetoothStatus.qml
home/.config/quickshell/ii/services/Booru.qml
home/.config/quickshell/ii/services/BooruResponseData.qml
home/.config/quickshell/ii/services/Brightness.qml
home/.config/quickshell/ii/services/Cliphist.qml
home/.config/quickshell/ii/services/ConflictKiller.qml
home/.config/quickshell/ii/services/DateTime.qml
home/.config/quickshell/ii/services/EasyEffects.qml
home/.config/quickshell/ii/services/Emojis.qml
home/.config/quickshell/ii/services/FirstRunExperience.qml
home/.config/quickshell/ii/services/gCloud/token_from_key.py
home/.config/quickshell/ii/services/gCloud/token-from-key-venv.sh
home/.config/quickshell/ii/services/GlobalFocusGrab.qml
home/.config/quickshell/ii/services/GoogleCloud.qml
home/.config/quickshell/ii/services/hyprlandAntiFlashbangShader/anti-flashbang.glsl
home/.config/quickshell/ii/services/HyprlandAntiFlashbangShader.qml
home/.config/quickshell/ii/services/HyprlandConfig.qml
home/.config/quickshell/ii/services/HyprlandData.qml
home/.config/quickshell/ii/services/HyprlandKeybinds.qml
home/.config/quickshell/ii/services/HyprlandXkb.qml
home/.config/quickshell/ii/services/Hyprsunset.qml
home/.config/quickshell/ii/services/Idle.qml
home/.config/quickshell/ii/services/KeyringStorage.qml
home/.config/quickshell/ii/services/LatexRenderer.qml
home/.config/quickshell/ii/services/LauncherApps.qml
home/.config/quickshell/ii/services/LauncherSearch.qml
home/.config/quickshell/ii/services/MaterialThemeLoader.qml
home/.config/quickshell/ii/services/MprisController.qml
home/.config/quickshell/ii/services/Network.qml
home/.config/quickshell/ii/services/network/WifiAccessPoint.qml
home/.config/quickshell/ii/services/Notifications.qml
home/.config/quickshell/ii/services/PolkitService.qml
home/.config/quickshell/ii/services/Privacy.qml
home/.config/quickshell/ii/services/ResourceUsage.qml
home/.config/quickshell/ii/services/SessionWarnings.qml
home/.config/quickshell/ii/services/SongRec.qml
home/.config/quickshell/ii/services/SystemInfo.qml
home/.config/quickshell/ii/services/TaskbarApps.qml
home/.config/quickshell/ii/services/TimerService.qml
home/.config/quickshell/ii/services/Todo.qml
home/.config/quickshell/ii/services/Translation.qml
home/.config/quickshell/ii/services/TrayService.qml
home/.config/quickshell/ii/services/Updates.qml
home/.config/quickshell/ii/services/Wallpapers.qml
home/.config/quickshell/ii/services/Weather.qml
home/.config/quickshell/ii/services/Ydotool.qml
home/.config/quickshell/ii/settings.qml
home/.config/quickshell/ii/shell.qml
home/.config/quickshell/ii/translations/de_DE.json
home/.config/quickshell/ii/translations/en_US.json
home/.config/quickshell/ii/translations/es_MX.json
home/.config/quickshell/ii/translations/fr_FR.json
home/.config/quickshell/ii/translations/he_HE.json
home/.config/quickshell/ii/translations/id_ID.json
home/.config/quickshell/ii/translations/it_IT.json
home/.config/quickshell/ii/translations/ja_JP.json
home/.config/quickshell/ii/translations/pt_BR.json
home/.config/quickshell/ii/translations/ru_RU.json
home/.config/quickshell/ii/translations/tools/guide/translation-tools-guide.md
home/.config/quickshell/ii/translations/tools/guide/translation-tools-guide-zh_CN.md
home/.config/quickshell/ii/translations/tools/manage-translations.sh
home/.config/quickshell/ii/translations/tools/README.md
home/.config/quickshell/ii/translations/tools/translation-cleaner.py
home/.config/quickshell/ii/translations/tools/translation-manager.py
home/.config/quickshell/ii/translations/tr_TR.json
home/.config/quickshell/ii/translations/uk_UA.json
home/.config/quickshell/ii/translations/vi_VN.json
home/.config/quickshell/ii/translations/zh_CN.json
home/.config/quickshell/ii/welcome.qml
home/.config/wlogout/layout
home/.config/wlogout/style.css
home/.local/bin/dolphin-nostripes
home/.local/share/applications/org.kde.dolphin.desktop
home/.local/share/applications/STEAM_PP.desktop
home/.local/share/applications/Wargaming Game Center.desktop
home/.local/share/fonts/illogical-impulse-google-sans-flex/GoogleSansFlex-VariableFont_GRAD,ROND,opsz,slnt,wdth,wght.ttf
home/.local/share/fonts/illogical-impulse-google-sans-flex/LICENSE
home/.local/share/fonts/illogical-impulse-google-sans-flex/README.md
home/.local/share/fonts/illogical-impulse-google-sans-flex/.uuid
home/.local/share/fonts/.uuid
home/.local/share/icons/hicolor/16x16/apps/C06E_winhlp32.0.png
home/.local/share/icons/hicolor/16x16/apps/D15F_hh.0.png
home/.local/share/icons/hicolor/16x16/apps/D23E_msiexec.0.png
home/.local/share/icons/hicolor/256x256/apps/C06E_winhlp32.0.png
home/.local/share/icons/hicolor/256x256/apps/D15F_hh.0.png
home/.local/share/icons/hicolor/256x256/apps/D23E_msiexec.0.png
home/.local/share/icons/hicolor/32x32/apps/C06E_winhlp32.0.png
home/.local/share/icons/hicolor/32x32/apps/D15F_hh.0.png
home/.local/share/icons/hicolor/32x32/apps/D23E_msiexec.0.png
home/.local/share/icons/hicolor/32x32/apps/steam_icon_548430.png
home/.local/share/icons/hicolor/48x48/apps/C06E_winhlp32.0.png
home/.local/share/icons/hicolor/48x48/apps/D15F_hh.0.png
home/.local/share/icons/hicolor/48x48/apps/D23E_msiexec.0.png
home/.local/share/icons/illogical-impulse.svg
home/Wallpapers/ChatGPT Image 28 апр. 2026 г., 12_12_28_upscayl_2x_digital-art-4x.png
home/Wallpapers/random_wallpaper-1.png
home/Wallpapers/random_wallpaper_upscayl_4x_digital-art-4x.png
```

</details>

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

## Настройка монитора

Настройка монитора находится в:

```text
~/.config/hypr/custom/monitors.conf
```

Универсальный вариант:

```ini
monitor=,preferred,auto,1
```

Для 3440x1440 180 Hz можно вручную поставить:

```ini
monitor = DP-1, 3440x1440@180, 0x0, 1
```

После изменения:

```bash
hyprctl reload
```

### Как поставить свой личный монитор локально

В репозитории по умолчанию стоит универсальный вариант:

```ini
monitor=,preferred,auto,1
```

Это сделано специально, чтобы сборка нормально запускалась на разных ПК и мониторах.

Если нужно поставить свой монитор, например `DP-1`, `3440x1440`, `180 Hz`, делай это **локально после установки**. Эти изменения не нужно пушить в GitHub:

```fish
mkdir -p ~/.config/hypr/custom

printf '%s\n' \
'# My personal monitor config' \
'monitor=DP-1,3440x1440@180,0x0,1' \
> ~/.config/hypr/custom/monitors.conf

printf '%s\n' \
'# My personal monitor config' \
'monitor=DP-1,3440x1440@180,0x0,1' \
> ~/.config/hypr/monitors.conf

hyprctl reload

echo "=== Local monitor configs ==="
cat ~/.config/hypr/custom/monitors.conf
echo
cat ~/.config/hypr/monitors.conf
echo
hyprctl monitors
```

Пояснение:

```text
~/.config/hypr/custom/monitors.conf - личная настройка монитора
~/.config/hypr/monitors.conf        - локальный monitor config
~/XlllOS-dots/...                   - репозиторий, туда личный DP-1 лучше не пушить
```

Для другого монитора поменяй строку:

```ini
monitor=DP-1,3440x1440@180,0x0,1
```

Например:

```ini
monitor=HDMI-A-1,1920x1080@144,0x0,1
```

Посмотреть имя монитора:

```fish
hyprctl monitors
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

## Multilib

`scripts/install-steam.sh` automatically enables the `[multilib]` repository before installing Steam.

The installer creates a backup of `/etc/pacman.conf` before editing it:

```text
/etc/pacman.conf.bak-xlllos-steam-YYYY-MM-DD-HHMMSS
```

This is required for Steam and `lib32-*` gaming packages on Arch/CachyOS.

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

## CachyOS Gaming Packages

Для gaming-установки репозиторий ставит официальные CachyOS meta-пакеты:

```text
cachyos-gaming-meta
cachyos-gaming-applications
```

Они подтягивают основные библиотеки, зависимости и приложения для игр на CachyOS.

Дополнительно в списке установки есть игровые инструменты и зависимости:

```text
Steam
Steam Devices
GameMode
MangoHud
GOverlay
Gamescope
ProtonUp-Qt
Protontricks
Winetricks
Lutris
UMU Launcher
Wine
Wine Mono
Wine Gecko
Vulkan tools
VKD3D
SDL3
PortProton
game-devices-udev
```

SteamTinkerLaunch dependencies:

```text
xdotool
xorg-xwininfo
```

SteamTinkerLaunch Roberta dependencies:

```text
scummvm
inotify-tools
```

Если какой-то пакет отсутствует в подключённых репозиториях, установочный скрипт пропустит его и продолжит установку.


## Game Launch Options

Открыть в Steam:

```text
Steam → Библиотека → ПКМ по игре → Свойства → Общие → Параметры запуска
```

Обычный GameMode:

```text
gamemoderun %command%
```

MangoHud + GameMode:

```text
mangohud gamemoderun %command%
```

NVIDIA/NVAPI + MangoHud + GameMode:

```text
PROTON_ENABLE_NVAPI=1 DXVK_ENABLE_NVAPI=1 mangohud gamemoderun %command%
```

NVIDIA/NVAPI + DLL overrides для модов:

```text
PROTON_ENABLE_NVAPI=1 DXVK_ENABLE_NVAPI=1 WINEDLLOVERRIDES="winmm=n,b;version=n,b" mangohud gamemoderun %command%
```

Gamescope 3440x1440 180 Hz + NVIDIA/NVAPI + MangoHud + GameMode:

```text
PROTON_ENABLE_NVAPI=1 DXVK_ENABLE_NVAPI=1 gamescope -f -W 3440 -H 1440 -r 180 -- mangohud gamemoderun %command%
```

## WARP helper

```fish
warp on
warp off
warp status
```

WARP не включается автоматически при запуске системы. Его нужно включать вручную только при необходимости.

## Проверка репозитория

```bash
bash scripts/verify-repo.sh
```

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
