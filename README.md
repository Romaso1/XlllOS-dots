<!-- XlllOS preview start -->
<p align="center">
  <img src="assets/preview.png" alt="XlllOS Preview" width="100%">
</p>
<!-- XlllOS preview end -->

# XlllOS Dots

## Быстрая установка одной командой

### NVIDIA

Для NVIDIA / CachyOS / Arch / EndeavourOS:

```bash
bash -lc "sudo pacman -Syu --needed --noconfirm git base-devel && if [ -d \"\$HOME/XlllOS-dots/.git\" ]; then git -C \"\$HOME/XlllOS-dots\" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git \"\$HOME/XlllOS-dots\"; fi && cd \"\$HOME/XlllOS-dots\" && chmod +x install.sh && ./install.sh && sudo reboot"
```

### AMD

Для AMD-видеокарт:

```bash
bash -lc "set -e; sudo pacman -Syu --needed --noconfirm git base-devel; if [ -d \"\$HOME/XlllOS-dots/.git\" ]; then git -C \"\$HOME/XlllOS-dots\" pull; else git clone https://github.com/Romaso1/XlllOS-dots.git \"\$HOME/XlllOS-dots\"; fi; cd \"\$HOME/XlllOS-dots\"; chmod +x install.sh; ./install.sh; sudo pacman -S --needed --noconfirm mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau; pkgs=\"nvidia-utils nvidia-settings lib32-nvidia-utils opencl-nvidia lib32-opencl-nvidia libva-nvidia-driver linux-cachyos-nvidia-open linux-cachyos-lts-nvidia-open\"; installed=\"\$(pacman -Qq \$pkgs 2>/dev/null || true)\"; if [ -n \"\$installed\" ]; then sudo pacman -Rns --noconfirm \$installed || true; fi; sudo mkinitcpio -P; sudo reboot"
```

AMD-команда сначала ставит XlllOS-dots, потом ставит Mesa/Vulkan для AMD, удаляет NVIDIA-пакеты, если они установились, обновляет initramfs и перезагружает ПК.

Моя настройка CachyOS Hyprland.

Это не отдельный Linux-дистрибутив, а набор dotfiles + установочный скрипт, который переносит мой внешний вид, Hyprland-конфиги, Quickshell/Illogical Impulse, терминал, fish shell, игровые пакеты и performance-настройки.

## Бинды после установки

Основные бинды можно открыть прямо в системе через cheatsheet:

`Super + /`

### Shell

| Бинд | Действие |
|---|---|
| Super | Toggle search |
| Super + Tab | Toggle overview |
| Super + V | Clipboard history >> clipboard |
| Super + Period | Emoji >> clipboard |
| Super + A | Toggle left sidebar |
| Super + N | Toggle right sidebar |
| Super + / | Toggle cheatsheet |
| Super + K | Toggle on-screen keyboard |
| Super + M | Toggle media controls |
| Super + G | Toggle overlay |
| Ctrl + Alt + Delete | Toggle session menu |
| Super + J | Toggle bar |
| Ctrl + Super + T | Wallpaper selector |
| Ctrl + Alt + T | Random wallpaper |
| Ctrl + Super + R | Restart widgets |
| Ctrl + Super + P | Cycle panel family |

### Utilities

| Бинд | Действие |
|---|---|
| Super + Shift + S | Screen snip |
| Super + Shift + A | Google Lens |
| Super + Shift + X | Character recognition >> clipboard |
| Super + Shift + T | Translate screen content |
| Super + Shift + C | Pick color Hex >> clipboard |
| Super + Shift + R | Record region without sound |
| Super + Shift + Alt + R | Record screen with sound |
| Print | Screenshot >> clipboard |
| Ctrl + Print | Screenshot >> clipboard and file |

### Window

| Бинд | Действие |
|---|---|
| Super + LMB | Move |
| Super + RMB | Resize |
| Super + Arrow keys | Focus in direction |
| Super + Shift + Arrow keys | Move in direction |
| Super + Q | Close |
| Super + Shift + Alt + Q | Forcefully zap a window |
| Super + / | Adjust split ratio |
| Super + Alt + Space | Float / Tile |
| Super + D | Maximize |
| Super + F | Fullscreen |
| Super + Alt + F | Fullscreen spoof |
| Super + P | Pin |
| Super + Alt + number | Send to workspace number |
| Super + Shift + Page Up / Page Down | Send to workspace left / right |
| Super + Alt + S | Send to scratchpad |

### Workspace

| Бинд | Действие |
|---|---|
| Super + number | Focus workspace number |
| Ctrl + Super + Left / Right | Focus left / right |
| Super + Page Up / Page Down | Focus left / right |
| Super + Scroll Up / Down | Focus left / right |
| Super + S | Toggle scratchpad |

### Session / Screen / Media

| Бинд | Действие |
|---|---|
| Super + L | Lock |
| Super + Shift + L | Sleep |
| Super + Minus | Zoom out |
| Super + Equal | Zoom in |
| Super + Shift + N | Next track |
| Super + Shift + B | Previous track |
| Super + Shift + P | Play / pause media |

### Apps

| Бинд | Действие |
|---|---|
| Super + Enter | Terminal |
| Super + E | File manager |
| Super + W | Browser |
| Super + C | Code editor |
| Ctrl + Super + Shift + Alt + W | Office software |
| Super + X | Text editor |
| Ctrl + Super + V | Volume mixer |
| Super + I | Settings app |
| Ctrl + Shift + Escape | Task manager |

### User

| Бинд | Действие |
|---|---|
| Ctrl + Super + / | Edit shell config |
| Ctrl + Super + Alt + / | Edit extra keybinds |

### Virtual machines

| Бинд | Действие |
|---|---|
| Super + Alt + F1 | Disable keybinds |

## Рекомендуемая база

Лучше ставить на чистую систему:

- CachyOS
- Hyprland edition
- Btrfs
- Limine bootloader
- NVIDIA proprietary driver, если используется NVIDIA GPU
- Если используется AMD GPU - использовать стандартные open-source драйверы AMD (AMDGPU / Mesa / RADV), NVIDIA proprietary driver не выбирать

## Что переносится

- Hyprland config
- Hyprland monitors / workspaces / keybinds
- Hyprlock / Hypridle
- Quickshell / Illogical Impulse
- Общий Illogical Impulse config.json
- Панель, сайдбары, виджеты и shell-настройки Quickshell
- Kitty terminal config
- Fish shell config
- Fish functions, включая warp on / warp off / warp status
- Кастомные обои и wallpaper-настройки
- Кастомный Dolphin config
- Kvantum theme
- Qt5ct / Qt6ct настройки
- KDE globals / kdeglobals
- GTK 3 / GTK 4 настройки
- Dolphin previews: kio-extras, ffmpegthumbs, kdegraphics-thumbnailers
- Alt + Shift для смены языка
- Отключение ускорения мыши
- Прозрачность терминала
- Терминальные desktop widgets на первом workspace
- Автозапуск cbonsai / peaclock / asciiquarium / cmatrix
- Отключение жёлтого фильтра / hyprsunset
- Автологин в обычный Hyprland через SDDM
- CPU governor performance
- EPP performance
- Power profile performance
- DNS Quad9 + Cloudflare через systemd-resolved
- Cloudflare WARP helper без автозапуска
- PortProton / Proton VPN
- MangoHud / Gamescope / GameMode
- Lutris / Heroic Games Launcher
- Discord / Telegram / qBittorrent
- Firefox frame_rate 180
- Терминальные эффекты: cava, cmatrix, cbonsai, pipes.sh, asciiquarium
- Терминальные утилиты: fastfetch, btop, eza, bat, fzf, yazi, glow, chafa
- Starship prompt
- tty-clock / peaclock

## Важно про Private-репозиторий

Если репозиторий стоит как Private, другой человек не сможет его скачать просто так.

Чтобы любой мог установить:

1. Открой GitHub-репозиторий.
2. Перейди в Settings.
3. Открой General.
4. Пролистай вниз до Danger Zone.
5. Нажми Change repository visibility.
6. Выбери Public.

Или добавь человека как Collaborator:

1. Repository Settings.
2. Collaborators.
3. Add people.
4. Введи GitHub-ник человека.

## Настройка монитора

Настройки монитора вынесены в custom-конфиг:

```bash
~/.config/hypr/custom/monitors.conf
```

По умолчанию используется универсальная настройка:

```ini
monitor = , preferred, auto, 1
```

Это значит:

- пустое имя монитора - применить ко всем мониторам;
- preferred - выбрать лучшее разрешение и герцовку;
- auto - автоматическая позиция;
- 1 - масштаб 100%.

Проверить имя монитора:

```bash
hyprctl monitors
```

В выводе будет что-то типа:

```text
Monitor DP-1
Monitor HDMI-A-1
Monitor eDP-1
```

Пример настройки для 3440x1440 180Hz:

```ini
monitor = DP-1, 3440x1440@180, 0x0, 1
```

Если у вас другой монитор, измените только этот файл:

```bash
nano ~/.config/hypr/custom/monitors.conf
```

## Примеры monitor config

### Универсальный вариант

```ini
monitor = , preferred, auto, 1
```

### 3440x1440 180 Hz

```ini
monitor = DP-1, 3440x1440@180, 0x0, 1
```

### 2560x1440 144 Hz

```ini
monitor = DP-1, 2560x1440@144, 0x0, 1
```

### 1920x1080 60 Hz

```ini
monitor = HDMI-A-1, 1920x1080@60, 0x0, 1
```

### Ноутбук с масштабом 125%

```ini
monitor = eDP-1, preferred, auto, 1.25
```

### Два монитора

```ini
monitor = DP-1, 3440x1440@180, 0x0, 1
monitor = HDMI-A-1, 1920x1080@60, 3440x0, 1
```

После изменения применить:

```bash
hyprctl reload
```

Если что-то сломалось, верни универсальный вариант:

```ini
monitor = , preferred, auto, 1
```

## Проверка герцовки монитора

```bash
hyprctl monitors
```

В начале вывода будет строка типа:

```text
3440x1440@180.00000 at 0x0
```

Это значит, что монитор работает на 180 Hz.

## Настройки мыши

Ускорение мыши отключено через Hyprland input config.

Проверить:

```bash
hyprctl getoption input:accel_profile
hyprctl getoption input:force_no_accel
```

Должно быть примерно:

```text
str: flat
int: 1
```

## CPU performance

Проверить governor:

```bash
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
```

Проверить EPP:

```bash
cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
```

Проверить power profile:

```bash
powerprofilesctl get
```

Нормальный результат:

```text
performance
performance
performance
```

## PortProton / Proton VPN

### PortProton

После установки PortProton уже будет установлен автоматически.

Что делать дальше:

1. Открой PortProton из меню приложений.
2. Установи нужный Windows-лаунчер или игру.
3. Steam, Wargaming Center и другие лаунчеры внутри PortProton каждый пользователь ставит сам.
4. Вход в аккаунты Steam / Wargaming выполняется только на своей системе.

### Proton VPN

Proton VPN устанавливается автоматически через `install.sh`:

```bash
proton-vpn-daemon
proton-vpn-gtk-app
```

Графическое приложение запускается так:

```bash
protonvpn-app
```

Также Proton VPN можно открыть из меню приложений как обычную программу.

Важно: вручную включать `proton-vpn-daemon.service` не нужно. В этой сборке используется Proton VPN GTK app, а не старый `protonvpn-cli`.

## Game Launch Options

Обычный вариант:

```text
game-performance %command%
```

С MangoHud:

```text
mangohud game-performance %command%
```

С Gamescope:

```text
gamescope -f -W 3440 -H 1440 -r 180 -- game-performance %command%
```

С WINEDLLOVERRIDES:

```text
WINEDLLOVERRIDES="winmm,version=n,b" game-performance %command%
```

С MangoHud и WINEDLLOVERRIDES:

```text
WINEDLLOVERRIDES="winmm,version=n,b" mangohud game-performance %command%
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

## Terminal animations and effects

В конфиг также можно добавить красивые терминальные утилиты:

```bash
cava        # аудио-визуализатор музыки
cbonsai    # красивое ASCII-дерево
cmatrix    # Matrix-анимация
pipes.sh   # анимированные трубы в терминале
starship   # красивый prompt для shell


## Extra terminal tools

These dotfiles can automatically install extra beautiful and useful terminal tools:

```bash
fastfetch   # красивое инфо о системе
btop        # красивый мониторинг системы
eza         # красивый ls
bat         # красивый cat с подсветкой
yazi        # файловый менеджер в терминале
glow        # красивый просмотр README.md
chafa       # превью картинок в терминале
tty-clock   # большие часы
peaclock    # красивые часы/таймер
```

Pacman packages:

```bash
sudo pacman -S --needed fastfetch btop eza bat fzf yazi glow chafa
```

AUR packages:

```bash
paru -S --needed tty-clock peaclock
```

Run manually:

```bash
fastfetch
btop
eza -lah --icons
bat README.md
yazi
glow README.md
chafa ~/Pictures/image.png
tty-clock
peaclock
```

## DNS config

The installer automatically configures DNS through systemd-resolved:

```text
Quad9:      9.9.9.9 / 149.112.112.112
Cloudflare: 1.1.1.1 / 1.0.0.1
DNS-over-TLS: opportunistic
```

Check DNS status after installation:

```bash
resolvectl status
```

<!-- XlllOS one-command GPU install -->

## Cloudflare WARP helper

В dotfiles добавлена удобная команда для ручного включения и отключения Cloudflare WARP:

```fish
warp on      # включить WARP
warp off     # отключить WARP
warp status  # проверить статус WARP
```

Если во время установки какие-то пакеты не находятся, AUR не отвечает, терминал не может связаться с сервером или загрузка зависает из-за проблем с сетью, можно временно включить WARP:

```fish
warp on
```

После этого повторите установку. Когда установка закончится, лучше отключить WARP, чтобы не терять скорость интернета и не повышать пинг в играх:

```fish
warp off
```

WARP не включается автоматически при запуске системы. Его нужно включать вручную только при необходимости.


## Quickshell быстро открывается и моментально закрывается

Если меню Quickshell, например звук, трей или быстрые настройки, открывается и сразу закрывается, скорее всего это из-за PortProton. Он может оставаться в фоне и ломать фокус popup-окон Quickshell.

Фикс:



Или просто сделайте перезагрузку системы.

