#!/usr/bin/env bash
set -euo pipefail

echo "=== XlllOS Hyprland dots installer ==="

if ! command -v pacman >/dev/null 2>&1; then
    echo "Этот скрипт рассчитан на Arch/CachyOS."
    exit 1
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_pacman_available() {
    local label="$1"
    shift
    local wanted="/tmp/xlllos-wanted-${label}.txt"
    local repo_pkgs="/tmp/xlllos-repo-${label}.txt"
    local install_list="/tmp/xlllos-install-${label}.txt"
    local missing_list="/tmp/xlllos-missing-${label}.txt"

    printf "%s\n" "$@" | sed '/^$/d' | sort -u > "$wanted"
    pacman -Slq | sort -u > "$repo_pkgs"
    comm -12 "$wanted" "$repo_pkgs" > "$install_list"
    comm -23 "$wanted" "$repo_pkgs" > "$missing_list"

    if [ -s "$install_list" ]; then
        mapfile -t pkgs < "$install_list"
        sudo pacman -S --needed --noconfirm "${pkgs[@]}"
    fi

    if [ -s "$missing_list" ]; then
        echo "[WARN] These pacman packages were not found in enabled repos:"
        cat "$missing_list"
    fi
}

echo "[1/11] Updating system..."
sudo pacman -Syu --noconfirm

echo "[1.5/11] Installing Linux Steam..."
bash "$REPO_DIR/scripts/install-steam.sh"

echo "[2/11] Installing base packages..."
install_pacman_available base \
    git curl wget rsync base-devel \
    hyprland xdg-desktop-portal-hyprland \
    kitty fish \
    matugen \
    lutris \
    gamemode lib32-gamemode \
    mangohud goverlay protonup-qt \
    gamescope vulkan-tools \
    power-profiles-daemon cpupower \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    proton-vpn-daemon proton-vpn-gtk-app \
    firefox

echo "[2.5/11] Enabling Proton VPN daemon..."
sudo systemctl enable --now proton-vpn-daemon 2>/dev/null || true

echo "[2.6/11] Installing pacman packages from package list..."
if [ -f "$REPO_DIR/packages-pacman.txt" ]; then
    mapfile -t list_pkgs < <(grep -vE '^\s*(#|$)' "$REPO_DIR/packages-pacman.txt" | sort -u)
    if [ "${#list_pkgs[@]}" -gt 0 ]; then
        install_pacman_available list "${list_pkgs[@]}"
    fi
fi

echo "[2.7/11] Installing AUR packages..."
if [ -f "$REPO_DIR/packages-aur.txt" ]; then
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

    mapfile -t aur_pkgs < <(grep -vE '^\s*(#|$)' "$REPO_DIR/packages-aur.txt" | sort -u)
    if [ "${#aur_pkgs[@]}" -gt 0 ]; then
        "$AUR_HELPER" -S --needed --noconfirm "${aur_pkgs[@]}" || true
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

echo "[5/11] Fixing user-specific paths..."
python3 - <<'PYUSERPATH'
import json
from pathlib import Path
p = Path.home() / ".config/illogical-impulse/config.json"
if p.exists():
    cfg = json.loads(p.read_text(encoding="utf-8"))
    def fix_paths(x):
        if isinstance(x, dict):
            return {k: fix_paths(v) for k, v in x.items()}
        if isinstance(x, list):
            return [fix_paths(v) for v in x]
        if isinstance(x, str):
            return x.replace("/home/xiii", str(Path.home()))
        return x
    p.write_text(json.dumps(fix_paths(cfg), indent=4, ensure_ascii=False), encoding="utf-8")
PYUSERPATH

echo "[6/11] Setting monitor config in custom..."
mkdir -p "$HOME/.config/hypr/custom"
printf "%s\n" "# Universal monitor config" "monitor = , preferred, auto, 1" > "$HOME/.config/hypr/custom/monitors.conf"

echo "[7/11] Setting fish as default shell..."
if command -v fish >/dev/null 2>&1; then
    if ! grep -q "$(command -v fish)" /etc/shells; then
        command -v fish | sudo tee -a /etc/shells
    fi
    chsh -s "$(command -v fish)" "$USER" || true
fi

echo "[8/11] Performance mode..."
sudo systemctl enable --now power-profiles-daemon.service || true
sudo systemctl enable --now cpupower.service || true
powerprofilesctl set performance || true

sudo tee /etc/systemd/system/force-cpu-performance.service >/dev/null <<'FORCECPU'
[Unit]
Description=Force CPU governor and EPP to performance
After=cpupower.service power-profiles-daemon.service multi-user.target
Wants=power-profiles-daemon.service

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -lc 'sleep 3; shopt -s nullglob; for g in /sys/devices/system/cpu/cpufreq/policy*/scaling_governor /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo performance > "$g" 2>/dev/null || true; done; for e in /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do echo performance > "$e" 2>/dev/null || true; done; exit 0'

[Install]
WantedBy=multi-user.target
FORCECPU

sudo systemctl daemon-reload
sudo systemctl enable --now force-cpu-performance.service || true

echo "[9/11] Setting SDDM autologin..."
sudo mkdir -p /etc/sddm.conf.d
printf "%s\n" "[Autologin]" "User=$USER" "Session=hyprland.desktop" | sudo tee /etc/sddm.conf.d/autologin.conf >/dev/null

echo "[10/11] Applying Firefox prefs..."
FIREFOX_PROFILE="$(find "$HOME/.mozilla/firefox" -maxdepth 1 -type d -name "*.default-release" 2>/dev/null | head -n1 || true)"
if [ -n "$FIREFOX_PROFILE" ]; then
    printf "%s\n" "// XlllOS" "user_pref(\"layout.frame_rate\", 180);" >> "$FIREFOX_PROFILE/user.js"
fi

echo "[11/11] Disabling yellow night filter..."
systemctl --user disable --now hyprsunset.service 2>/dev/null || true
pkill -f hyprsunset 2>/dev/null || true

find "$HOME/.config/hypr" -type f \( -name "*.conf" -o -name "*.new" \) 2>/dev/null | while read -r f; do
    sed -i "/hyprsunset/d" "$f" 2>/dev/null || true
done

echo "=== XlllOS install complete ==="
echo "Backup saved at: $BACKUP"
echo "Reboot is recommended."
