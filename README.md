# XlllOS Dots

Моя настройка CachyOS Hyprland.

Это не отдельный Linux-дистрибутив, а набор dotfiles + установочный скрипт, который переносит мой внешний вид, Hyprland-конфиги, Quickshell/Illogical Impulse, терминал, fish shell, игровые пакеты и performance-настройки.

## Рекомендуемая база

Лучше ставить на чистую систему:

- CachyOS
- Hyprland edition
- Btrfs
- Limine bootloader
- NVIDIA proprietary driver, если используется NVIDIA GPU

## Что переносится

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
- PortProton / Proton VPN
- MangoHud / Gamescope / GameMode
- Firefox frame_rate 180

## Установка

### 1. Установить git

```bash
sudo pacman -Syu git
```

### 2. Скачать dotfiles

```bash
git clone https://github.com/Romaso1/XlllOS-dots.git
```

Если репозиторий Private, используй SSH:

```bash
git clone git@github.com:Romaso1/XlllOS-dots.git
```

### 3. Перейти в папку

```bash
cd XlllOS-dots
```

### 4. Сделать install.sh исполняемым

```bash
chmod +x install.sh
```

### 5. Запустить установку

```bash
./install.sh
```

### 6. Перезагрузить систему

```bash
reboot
```

После перезагрузки система должна запуститься с моими настройками Hyprland/Quickshell.

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

По умолчанию в dotfiles используется универсальная настройка:

```ini
monitor = , preferred, auto, 1
```

Это значит:

- пустое имя монитора - применить ко всем мониторам;
- preferred - выбрать лучшее разрешение и герцовку;
- auto - автоматическая позиция;
- 1 - масштаб 100%.

Файл монитора находится тут:

```bash
~/.config/hypr/monitors.conf
```

Открыть его:

```bash
nano ~/.config/hypr/monitors.conf
```

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

После установки:

  1. Открой PortProton.
  2. Установи нужный Windows-лаунчер или игру.
  3. Steam и Wargaming Center внутри PortProton каждый пользователь ставит сам.
  4. Вход в аккаунты Steam/Wargaming выполняется только на своей системе.

Proton VPN устанавливается через install.sh:

    proton-vpn-daemon
    proton-vpn-gtk-app

Демон Proton VPN включается автоматически:

    sudo systemctl enable --now proton-vpn-daemon.service

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

## Как обновить dotfiles у себя

Если я поменял конфиги у себя и хочу обновить репозиторий:

```bash
cd ~/XlllOS-dots
git add -A
git commit -m "Update configs"
git push
```

## Как другому человеку обновить dotfiles

```bash
cd ~/XlllOS-dots
git pull
./install.sh
reboot
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

<!-- Updated for PortProton + Proton VPN -->

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
