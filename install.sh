#!/usr/bin/env bash
set -e

echo "=== XlllOS Hyprland dots installer ==="

if ! command -v pacman >/dev/null 2>&1; then
    echo "Этот скрипт рассчитан на Arch/CachyOS."
    exit 1
fi

echo "[1/10] Updating system..."
sudo pacman -Syu --noconfirm

echo "[2/10] Installing packages..."
sudo pacman -S --needed --noconfirm \
    git curl wget rsync base-devel \
    hyprland xdg-desktop-portal-hyprland \
    kitty fish \
    quickshell swww matugen \
    steam lutris heroic-games-launcher \
    gamemode lib32-gamemode \
    mangohud goverlay protonup-qt \
    wine winetricks protontricks \
    gamescope vulkan-tools \
    power-profiles-daemon cpupower \
    nvidia-utils lib32-nvidia-utils \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    firefox

echo "[3/10] Backing up old configs..."
BACKUP="$HOME/.config-backup-xlllos-$(date +%s)"
mkdir -p "$BACKUP"

for dir in hypr quickshell illogical-impulse kitty fish; do
    if [ -e "$HOME/.config/$dir" ]; then
        mv "$HOME/.config/$dir" "$BACKUP/$dir"
        echo "Backup: ~/.config/$dir -> $BACKUP/$dir"
    fi
done

echo "[4/10] Copying configs..."
mkdir -p "$HOME/.config"
rsync -a home/.config/ "$HOME/.config/"

if [ -d "home/Pictures" ]; then
    mkdir -p "$HOME/Pictures"
    rsync -a home/Pictures/ "$HOME/Pictures/"
fi

if [ -d "home/.local" ]; then
    mkdir -p "$HOME/.local"
    rsync -a home/.local/ "$HOME/.local/"
fi

echo "[5/10] Forcing universal monitor config..."
cat > "$HOME/.config/hypr/monitors.conf" <<'EOF'
# Universal monitor config
# Uses preferred resolution/refresh rate and default scale
monitor = , preferred, auto, 1
EOF

echo "[6/10] Setting fish as default shell..."
if command -v fish >/dev/null 2>&1; then
    if ! grep -q "$(command -v fish)" /etc/shells; then
        command -v fish | sudo tee -a /etc/shells
    fi
    chsh -s "$(command -v fish)" "$USER" || true
fi

echo "[7/10] Restoring system performance configs..."
if [ -f system/etc/default/cpupower-service.conf ]; then
    sudo cp system/etc/default/cpupower-service.conf /etc/default/cpupower-service.conf
fi

if [ -f system/etc/systemd/system/force-cpu-performance.service ]; then
    sudo cp system/etc/systemd/system/force-cpu-performance.service /etc/systemd/system/force-cpu-performance.service
else
    sudo tee /etc/systemd/system/force-cpu-performance.service >/dev/null <<'EOF'
[Unit]
Description=Force CPU governor and EPP to performance
After=cpupower.service power-profiles-daemon.service multi-user.target
Wants=power-profiles-daemon.service

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -lc 'sleep 3; shopt -s nullglob; for g in /sys/devices/system/cpu/cpufreq/policy*/scaling_governor /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo performance > "$g" 2>/dev/null || true; done; for e in /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do echo performance > "$e" 2>/dev/null || true; done; exit 0'

[Install]
WantedBy=multi-user.target
EOF
fi

sudo systemctl daemon-reload
sudo systemctl enable --now power-profiles-daemon.service || true
sudo systemctl enable --now cpupower.service || true
sudo systemctl enable --now force-cpu-performance.service || true
powerprofilesctl set performance || true

echo "[8/10] Setting SDDM autologin to normal Hyprland..."
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/autologin.conf >/dev/null <<EOF
[Autologin]
User=$USER
Session=hyprland.desktop
Relogin=true
EOF

echo "[9/10] Applying Firefox prefs..."
FIREFOX_PROFILE="$(find "$HOME/.mozilla/firefox" -maxdepth 1 -type d -name "*.default*" 2>/dev/null | head -n1 || true)"

if [ -n "$FIREFOX_PROFILE" ]; then
    cat >> "$FIREFOX_PROFILE/user.js" <<EOF
user_pref("layout.frame_rate", 180);
user_pref("widget.wayland.vsync.enabled", true);
EOF
    echo "Firefox user.js updated: $FIREFOX_PROFILE/user.js"
else
    echo "Firefox profile not found. Open Firefox once and set layout.frame_rate=180 manually if needed."
fi

echo "[10/10] Disabling yellow night filter if present..."
if [ -f "$HOME/.config/quickshell/ii/services/Hyprsunset.qml" ]; then
    cp "$HOME/.config/quickshell/ii/services/Hyprsunset.qml" "$HOME/.config/quickshell/ii/services/Hyprsunset.qml.bak" 2>/dev/null || true
    python - <<'PY'
from pathlib import Path
p = Path.home() / ".config/quickshell/ii/services/Hyprsunset.qml"
if p.exists():
    s = p.read_text()
    s = s.replace("root.startHyprsunset();", "// root.startHyprsunset();")
    s = s.replace('Quickshell.execDetached(["bash", "-c", `pidof hyprsunset || hyprsunset`]);', "// disabled hyprsunset autostart")
    p.write_text(s)
PY
fi

pkill hyprsunset 2>/dev/null || true

echo
echo "=== Done ==="
echo "Перезагрузи систему:"
echo "reboot"
