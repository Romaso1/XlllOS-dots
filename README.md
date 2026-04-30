# XlllOS Dots

Моя настройка CachyOS Hyprland.

Это не отдельный Linux-дистрибутив, а набор dotfiles + установочный скрипт, который переносит внешний вид, Hyprland-конфиги, Quickshell/Illogical Impulse, терминал, fish shell, игровые пакеты и performance-настройки.

## Быстрая установка одной командой

### NVIDIA

Для NVIDIA / CachyOS / Arch / EndeavourOS:

~~~bash
bash -lc "set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "\$HOME/XlllOS-dots/.git" ]; then git -C "\$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "\$HOME/XlllOS-dots"; fi; cd "\$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; ./scripts/gpu-nvidia.sh; sudo reboot"
~~~

NVIDIA-команда ставит XlllOS-dots, затем удаляет AMD-специфичные Vulkan/Mesa/AMDGPU-пакеты и ставит NVIDIA-драйверы, OpenCL, Vulkan ICD, lib32-компоненты и NVIDIA VA-API.

### AMD

Для AMD-видеокарт:

~~~bash
bash -lc "set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d "\$HOME/XlllOS-dots/.git" ]; then git -C "\$HOME/XlllOS-dots" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git "\$HOME/XlllOS-dots"; fi; cd "\$HOME/XlllOS-dots"; chmod +x install.sh scripts/*.sh 2>/dev/null || true; ./install.sh; ./scripts/gpu-amd.sh; sudo reboot"
~~~

AMD-команда ставит XlllOS-dots, затем удаляет NVIDIA-пакеты и ставит Mesa/RADV, Vulkan Radeon, lib32-компоненты, VA-API/VDPAU для Mesa и AMDGPU Xorg-драйвер.


## Что устанавливается

- Hyprland config
- Quickshell / Illogical Impulse
- Kitty terminal
- Fish shell
- Обои
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
- MangoHud / Gamescope / GameMode
- Firefox frame_rate 180

## Linux Steam

Linux Steam устанавливается автоматически через пакет `steam`.

Проверить после установки:

~~~bash
steam
~~~

## Проверка монитора

~~~bash
hyprctl monitors
~~~

Универсальный вариант в конфиге:

~~~ini
monitor = , preferred, auto, 1
~~~

Для 3440x1440 180 Hz можно вручную поставить:

~~~ini
monitor = DP-1, 3440x1440@180, 0x0, 1
~~~

После изменения:

~~~bash
hyprctl reload
~~~

## CPU performance

Проверить governor:

~~~bash
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
~~~

Проверить EPP:

~~~bash
cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
~~~

Проверить power profile:

~~~bash
powerprofilesctl get
~~~

Нормально:

~~~text
performance
performance
performance
~~~

## PortProton / Proton VPN

После установки:

1. Открой PortProton.
2. Установи нужный Windows-лаунчер или игру.
3. Steam и Wargaming Center внутри PortProton каждый пользователь ставит сам.
4. Вход в аккаунты Steam/Wargaming выполняется только на своей системе.

Proton VPN устанавливается через `install.sh`.

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

В dotfiles добавлена удобная команда для ручного включения и отключения Cloudflare WARP:

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
