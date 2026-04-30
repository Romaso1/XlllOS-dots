#!/usr/bin/env bash
set -e

echo "[GPU/NVIDIA] Removing AMD-specific packages..."
sudo pacman -Rns --noconfirm \
    amdvlk lib32-amdvlk \
    vulkan-radeon lib32-vulkan-radeon \
    vulkan-amdgpu-pro amf-amdgpu-pro opencl-amd rocm-opencl-runtime \
    libva-mesa-driver lib32-libva-mesa-driver \
    mesa-vdpau lib32-mesa-vdpau \
    xf86-video-amdgpu \
    2>/dev/null || true

echo "[GPU/NVIDIA] Installing NVIDIA packages..."
sudo pacman -Syu --needed --noconfirm \
    nvidia-utils lib32-nvidia-utils \
    nvidia-settings \
    opencl-nvidia lib32-opencl-nvidia \
    libva-nvidia-driver \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    mesa-utils vulkan-tools

if pacman -Qq linux-cachyos >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm linux-cachyos-nvidia-open
fi

if pacman -Qq linux-cachyos-lts >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm linux-cachyos-lts-nvidia-open
fi

sudo mkinitcpio -P || true
echo "[GPU/NVIDIA] Done. Reboot is required."
