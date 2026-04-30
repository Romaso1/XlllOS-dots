#!/usr/bin/env bash
set -euo pipefail

echo "=== XlllOS Hyprland dots installer ==="

if ! command -v pacman >/dev/null 2>&1; then
    echo "Этот скрипт рассчитан на Arch/CachyOS."
    exit 1
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[1/11] Updating system..."
sudo pacman -Syu --noconfirm

echo "[1.5/11] Installing Linux Steam..."
bash "$REPO_DIR/scripts/install-steam.sh"

echo "[2/11] Installing base packages..."
sudo pacman -S --needed --noconfirm git curl wget rsync base-devel hyprland xdg-desktop-portal-hyprland kitty fish awww matugen lutris gamemode lib32-gamemode mangohud goverlay protonup-qt gamescope vulkan-tools power-profiles-daemon cpupower vulkan-icd-loader lib32-vulkan-icd-loader proton-vpn-daemon proton-vpn-gtk-app firefox

echo "[2.5/11] Enabling Proton VPN daemon..."
sudo systemctl enable --now proton-vpn-daemon 2>/dev/null || true

echo "[2.6/11] Installing pacman packages..."
if [ -f "$REPO_DIR/packages-pacman.txt" ]; then
    sudo pacman -S --needed --noconfirm - < "$REPO_DIR/packages-pacman.txt" || true
fi

echo "[2.7/11] Installing AUR packages..."
if [ -f "$REPO_DIR/packages-aur.txt" ]; then
    AUR_HELPER=""
    if command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    elif command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    fi

    if [ -n "$AUR_HELPER" ]; then
        xargs -r "$AUR_HELPER" -S --needed --noconfirm < "$REPO_DIR/packages-aur.txt" || true
    else
        echo "AUR helper not found. Install paru/yay manually if AUR packages are needed."
    fi
fi

echo "[3/11] Backing up old configs..."
BACKUP="$HOME/.config-backup-xlllos-$(date +%F-%H%M%S)"
mkdir -p "$BACKUP"

for dir in hypr illogical-impulse kitty fish; do
    if [ -e "$HOME/.config/$dir" ]; then
        mv "$HOME/.config/$dir" "$BACKUP/$dir"
        echo "Backup: ~/.config/$dir -> $BACKUP/$dir"
    fi
done

echo "[4/11] Copying configs..."
mkdir -p "$HOME/.config"

if [ -d "$REPO_DIR/home/.config" ]; then
    rsync -a "$REPO_DIR/home/.config/" "$HOME/.config/"
fi

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

echo "[5/11] Setting monitor config in custom..."
mkdir -p "$HOME/.config/hypr/custom"
printf "%s
" "# Universal monitor config" "monitor = , preferred, auto, 1" > "$HOME/.config/hypr/custom/monitors.conf"

echo "[6/11] Setting fish as default shell..."
if command -v fish >/dev/null 2>&1; then
    if ! grep -q "$(command -v fish)" /etc/shells; then
        command -v fish | sudo tee -a /etc/shells
    fi
    chsh -s "$(command -v fish)" "$USER" || true
fi

echo "[7/11] Performance mode..."
sudo systemctl enable --now power-profiles-daemon.service || true
sudo systemctl enable --now cpupower.service || true
powerprofilesctl set performance || true

sudo tee /etc/systemd/system/force-cpu-performance.service >/dev/null <<FORCECPU
[Unit]
Description=Force CPU governor and EPP to performance
After=cpupower.service power-profiles-daemon.service multi-user.target
Wants=power-profiles-daemon.service

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -lc "sleep 3; shopt -s nullglob; for g in /sys/devices/system/cpu/cpufreq/policy*/scaling_governor /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo performance > \$g 2>/dev/null || true; done; for e in /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do echo performance > \$e 2>/dev/null || true; done; exit 0"

[Install]
WantedBy=multi-user.target
FORCECPU

sudo systemctl daemon-reload
sudo systemctl enable --now force-cpu-performance.service || true

echo "[8/11] Setting SDDM autologin..."
sudo mkdir -p /etc/sddm.conf.d
printf "%s
" "[Autologin]" "User=$USER" "Session=hyprland.desktop" | sudo tee /etc/sddm.conf.d/autologin.conf >/dev/null

echo "[9/11] Applying Firefox prefs..."
FIREFOX_PROFILE="$(find "$HOME/.mozilla/firefox" -maxdepth 1 -type d -name "*.default-release" 2>/dev/null | head -n1 || true)"
if [ -n "$FIREFOX_PROFILE" ]; then
    printf "%s
" "// XlllOS" "user_pref("layout.frame_rate", 180);" >> "$FIREFOX_PROFILE/user.js"
fi

echo "[10/11] Disabling yellow night filter..."
systemctl --user disable --now hyprsunset.service 2>/dev/null || true
pkill -f hyprsunset 2>/dev/null || true

echo "[11/11] Done."
echo "=== XlllOS install complete ==="
echo "Reboot is recommended."
