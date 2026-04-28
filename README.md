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

## PortProton

После установки:

1. Открой Steam.
2. Settings -> Compatibility.
3. Включи Steam Play.
4. Установи Proton Experimental или GE-Proton.
5. Запусти Windows-игру один раз.
6. После этого Protontricks увидит игру.

Открыть Protontricks:

```bash
protontricks --gui
```

## Steam Launch Options

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
