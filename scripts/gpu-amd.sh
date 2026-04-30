#!/usr/bin/env bash
set -euo pipefail

echo "[GPU/AMD] Removing NVIDIA packages..."
sudo pacman -Rns --noconfirm \
    nvidia nvidia-dkms nvidia-lts \
    nvidia-open nvidia-open-dkms \
    nvidia-utils lib32-nvidia-utils \
    nvidia-settings \
    opencl-nvidia lib32-opencl-nvidia \
    libva-nvidia-driver \
    linux-cachyos-nvidia-open linux-cachyos-lts-nvidia-open \
    2>/dev/null || true

echo "[GPU/AMD] Removing AMDVLK/AMDGPU-PRO to prefer Mesa RADV..."
sudo pacman -Rns --noconfirm \
    amdvlk lib32-amdvlk \
    vulkan-amdgpu-pro amf-amdgpu-pro opencl-amd rocm-opencl-runtime \
    2>/dev/null || true

echo "[GPU/AMD] Installing AMD Mesa/RADV packages..."
sudo pacman -Syu --needed --noconfirm \
    mesa lib32-mesa \
    vulkan-radeon lib32-vulkan-radeon \
    libva-mesa-driver lib32-libva-mesa-driver \
    mesa-vdpau lib32-mesa-vdpau \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    mesa-utils vulkan-tools \
    xf86-video-amdgpu

sudo mkinitcpio -P || true
echo "[GPU/AMD] Done. Reboot is required."
