# XlllOS system snapshot

Updated: 2026-05-02_22-55-20

This folder contains a safe snapshot of the current PC:

- `packages/` - pacman, AUR and Flatpak package lists
- `services/` - enabled/disabled systemd services
- `hardware/` - system and hardware info
- `gaming/` - Steam/Proton/Bottles/PortProton/Gamemode environment info

Restore helper:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

Important: this repo intentionally does not copy browser profiles, passwords, SSH keys, keyrings, Steam game prefixes, Wine prefixes or full home directory.
