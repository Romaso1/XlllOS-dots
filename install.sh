#!/usr/bin/env bash
set -e

echo "=== XlllOS Hyprland dots installer ==="

if ! command -v pacman >/dev/null 2>&1; then
    echo "Этот скрипт рассчитан на Arch/CachyOS."
    exit 1
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[1/11] Updating system..."
sudo pacman -Syu --noconfirm

# XlllOS default Linux Steam install
bash scripts/install-steam.sh

echo "[2/11] Installing packages..."
sudo pacman -S --needed --noconfirm \
    git curl wget rsync base-devel \
    hyprland xdg-desktop-portal-hyprland \
    kitty fish \
     awww matugen \
     lutris  \
    gamemode lib32-gamemode \
    mangohud goverlay protonup-qt \
    gamescope vulkan-tools \
    power-profiles-daemon cpupower \
    nvidia-utils lib32-nvidia-utils \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    proton-vpn-daemon proton-vpn-gtk-app \
    firefox

echo "[2.5/11] Enabling Proton VPN daemon..."


echo "[2.6/11] Installing all packages from package lists..."

if [ -f "$REPO_DIR/packages-pacman.txt" ]; then
    echo "Installing native pacman packages from packages-pacman.txt..."

    pacman -Slq | sort -u > /tmp/xlllos-repo-packages.txt
    sort -u "$REPO_DIR/packages-pacman.txt" > /tmp/xlllos-wanted-pacman.txt

    comm -12 /tmp/xlllos-wanted-pacman.txt /tmp/xlllos-repo-packages.txt > /tmp/xlllos-install-pacman.txt
    comm -23 /tmp/xlllos-wanted-pacman.txt /tmp/xlllos-repo-packages.txt > /tmp/xlllos-missing-pacman.txt

    if [ -s /tmp/xlllos-install-pacman.txt ]; then
        sudo pacman -S --needed --noconfirm - < /tmp/xlllos-install-pacman.txt
    fi

    if [ -s /tmp/xlllos-missing-pacman.txt ]; then
        echo "These pacman packages were not found in enabled repos:"
        cat /tmp/xlllos-missing-pacman.txt
    fi
fi

if [ -f "$REPO_DIR/packages-aur.txt" ]; then
    echo "Installing AUR/foreign packages from packages-aur.txt..."

    AUR_HELPER=""

    if command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    elif command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    fi

    if [ -z "$AUR_HELPER" ]; then
        echo "No AUR helper found. Installing paru..."
        sudo pacman -S --needed --noconfirm git base-devel

        TMP_PARU="/tmp/paru-build-xlllos"
        rm -rf "$TMP_PARU"
        git clone https://aur.archlinux.org/paru.git "$TMP_PARU"
        cd "$TMP_PARU"
        makepkg -si --noconfirm
        cd "$REPO_DIR"
        AUR_HELPER="paru"
    fi

    if [ -s "$REPO_DIR/packages-aur.txt" ]; then
        xargs -r "$AUR_HELPER" -S --needed --noconfirm < "$REPO_DIR/packages-aur.txt" || true
    fi
fi


echo "[3/11] Backing up old configs..."
BACKUP="$HOME/.config-backup-xlllos-$(date +%s)"
mkdir -p "$BACKUP"

for dir in hypr  illogical-impulse kitty fish; do
    if [ -e "$HOME/.config/$dir" ]; then
        mv "$HOME/.config/$dir" "$BACKUP/$dir"
        echo "Backup: ~/.config/$dir -> $BACKUP/$dir"
    fi
done

echo "[4/11] Copying user configs..."
mkdir -p "$HOME/.config"
rsync -a "$REPO_DIR/home/.config/" "$HOME/.config/"

if [ -d "$REPO_DIR/home/Pictures" ]; then
    mkdir -p "$HOME/Pictures"
    rsync -a "$REPO_DIR/home/Pictures/" "$HOME/Pictures/"
fi

if [ -d "$REPO_DIR/home/Wallpapers" ]; then
    mkdir -p "$HOME/Wallpapers"
    rsync -a "$REPO_DIR/home/Wallpapers/" "$HOME/Wallpapers/"
fi

if [ -d "$REPO_DIR/home/.local" ]; then
    mkdir -p "$HOME/.local"
    rsync -a "$REPO_DIR/home/.local/" "$HOME/.local/"
fi

echo "[5/11] Fixing user-specific paths..."
python - <<'PY'
import json
from pathlib import Path

p = Path.home() / ".config/illogical-impulse/config.json"

if p.exists():
    with open(p, encoding="utf-8") as f:
        cfg = json.load(f)

    def fix_paths(x):
        if isinstance(x, dict):
            return {k: fix_paths(v) for k, v in x.items()}
        if isinstance(x, list):
            return [fix_paths(v) for v in x]
        if isinstance(x, str):
            return x.replace("/home/xiii", str(Path.home()))
        return x

    cfg = fix_paths(cfg)

    with open(p, "w", encoding="utf-8") as f:
        json.dump(cfg, f, indent=4, ensure_ascii=False)
PY

echo "[6/11] Setting universal monitor config..."
cat > "$HOME/.config/hypr/monitors.conf" <<'EOF'
# Universal monitor config
# Uses preferred resolution/refresh rate and default scale
monitor = , preferred, auto, 1
EOF

echo "[7/11] Setting fish as default shell..."
if command -v fish >/dev/null 2>&1; then
    if ! grep -q "$(command -v fish)" /etc/shells; then
        command -v fish | sudo tee -a /etc/shells
    fi
    chsh -s "$(command -v fish)" "$USER" || true
fi

echo "[8/11] Restoring performance configs..."
if [ -f "$REPO_DIR/system/etc/default/cpupower-service.conf" ]; then
    sudo cp "$REPO_DIR/system/etc/default/cpupower-service.conf" /etc/default/cpupower-service.conf
fi

if [ -f "$REPO_DIR/system/etc/systemd/system/force-cpu-performance.service" ]; then
    sudo cp "$REPO_DIR/system/etc/systemd/system/force-cpu-performance.service" /etc/systemd/system/force-cpu-performance.service
else
    sudo tee /etc/systemd/system/force-cpu-performance.service >/dev/null <<'SERVICEEOF'
[Unit]
Description=Force CPU governor and EPP to performance
After=cpupower.service power-profiles-daemon.service multi-user.target
Wants=power-profiles-daemon.service

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -lc 'sleep 3; shopt -s nullglob; for g in /sys/devices/system/cpu/cpufreq/policy*/scaling_governor /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo performance > "$g" 2>/dev/null || true; done; for e in /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do echo performance > "$e" 2>/dev/null || true; done; exit 0'

[Install]
WantedBy=multi-user.target
SERVICEEOF
fi

sudo systemctl daemon-reload
sudo systemctl enable --now power-profiles-daemon.service || true
sudo systemctl enable --now cpupower.service || true
sudo systemctl enable --now force-cpu-performance.service || true
powerprofilesctl set performance || true

echo "[9/11] Setting SDDM autologin to normal Hyprland..."
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/autologin.conf >/dev/null <<EOF
[Autologin]
User=$USER
Session=hyprland.desktop
Relogin=true
EOF

echo "[10/11] Applying Firefox prefs..."
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

echo "[11/11] Disabling yellow night filter if present..."

# Disable Hyprsunset / night color filter if present
systemctl --user disable --now hyprsunset.service 2>/dev/null || true
pkill -f hyprsunset 2>/dev/null || true

# Remove common hyprsunset autostart lines from user configs
find "$HOME/.config/hypr" -type f \( -name "*.conf" -o -name "*.new" \) 2>/dev/null | while read -r f; do
    sed -i "/hyprsunset/d" "$f" 2>/dev/null || true
done

echo "=== XlllOS install complete ==="
echo "Reboot is recommended."
