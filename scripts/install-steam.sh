#!/usr/bin/env bash
set -e

echo "[Steam] Enabling multilib repository..."
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    sudo cp /etc/pacman.conf "/etc/pacman.conf.bak-xlllos-steam-$(date +%F-%H%M%S)" || true
    if grep -q "^#\[multilib\]" /etc/pacman.conf; then
        sudo sed -i "/^#\[multilib\]/,/^#Include = \/etc\/pacman.d\/mirrorlist/s/^#//" /etc/pacman.conf
    else
        printf "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" | sudo tee -a /etc/pacman.conf >/dev/null
    fi
fi

echo "[Steam] Installing Linux Steam..."
sudo pacman -Sy --noconfirm
sudo pacman -S --needed --noconfirm steam
