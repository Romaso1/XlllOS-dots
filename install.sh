#!/usr/bin/env bash
set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GPU="${XLLLOS_GPU:-auto}"

echo "=== XlllOS installer ==="
echo "Repo: $REPO_DIR"
echo "GPU:  $GPU"
echo

if ! command -v pacman >/dev/null 2>&1; then
  echo "ERROR: XlllOS installer is intended for Arch/CachyOS-based systems with pacman."
  exit 1
fi

echo "=== 1) System update and base tools ==="
sudo pacman -Syu --needed --noconfirm \
  git base-devel rsync curl wget tar xz zstd unzip python \
  desktop-file-utils xdg-utils flatpak || true

echo
echo "=== 2) Ensure AUR helper ==="
if ! command -v paru >/dev/null 2>&1 && ! command -v yay >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm paru || sudo pacman -S --needed --noconfirm yay || true
fi

if ! command -v paru >/dev/null 2>&1 && ! command -v yay >/dev/null 2>&1; then
  echo "WARNING: paru/yay not found. AUR packages may be skipped."
fi

echo
echo "=== 3) Make repo scripts executable ==="
chmod +x "$REPO_DIR"/scripts/*.sh 2>/dev/null || true

echo
echo "=== 4) Restore packages, Flatpaks, Bottles setup, and dotfiles ==="
if [ -x "$REPO_DIR/scripts/install-from-current-system-snapshot.sh" ]; then
  bash "$REPO_DIR/scripts/install-from-current-system-snapshot.sh"
else
  echo "ERROR: scripts/install-from-current-system-snapshot.sh is missing."
  exit 1
fi

echo
echo "=== 5) GPU setup ==="
case "$GPU" in
  nvidia|NVIDIA)
    if [ -x "$REPO_DIR/scripts/gpu-nvidia.sh" ]; then
      bash "$REPO_DIR/scripts/gpu-nvidia.sh"
    else
      sudo pacman -S --needed --noconfirm nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader || true
    fi
    ;;
  amd|AMD)
    if [ -x "$REPO_DIR/scripts/gpu-amd.sh" ]; then
      bash "$REPO_DIR/scripts/gpu-amd.sh"
    else
      sudo pacman -S --needed --noconfirm mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader || true
    fi
    ;;
  auto)
    echo "GPU auto mode: no explicit vendor script selected."
    ;;
  *)
    echo "Unknown XLLLOS_GPU value: $GPU"
    echo "Use: nvidia, amd, or auto."
    ;;
esac

echo
echo "=== 6) Gaming/performance defaults ==="
sudo systemctl disable --now ananicy-cpp 2>/dev/null || true
sudo systemctl disable --now ananicy 2>/dev/null || true

sudo systemctl enable --now power-profiles-daemon.service 2>/dev/null || true
sudo systemctl enable --now cpupower.service 2>/dev/null || true
powerprofilesctl set performance 2>/dev/null || true

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
sudo systemctl enable --now force-cpu-performance.service 2>/dev/null || true

echo
echo "=== 7) Disable yellow night filter if present ==="
systemctl --user disable --now hyprsunset.service 2>/dev/null || true
pkill -f hyprsunset 2>/dev/null || true

echo
echo "=== 8) Reload Hyprland if running ==="
hyprctl reload 2>/dev/null || true

echo
echo "=== XlllOS install complete ==="
echo "Reboot is recommended."
