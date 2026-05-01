#!/usr/bin/env bash
set -Eeuo pipefail

echo "Configuring SSH firewall exception..."

if systemctl is-active --quiet firewalld 2>/dev/null; then
  sudo firewall-cmd --add-service=ssh --permanent || true
  sudo firewall-cmd --add-port=22/tcp --permanent || true
  sudo firewall-cmd --reload || true
  echo "firewalld: SSH allowed"
elif systemctl is-active --quiet ufw 2>/dev/null; then
  sudo ufw allow 22/tcp || true
  sudo ufw reload || true
  echo "ufw: SSH allowed"
else
  echo "No active firewalld/ufw found, skipping SSH firewall rule"
fi
