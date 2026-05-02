# XlllOS system snapshot

Updated: 2026-05-02_23-15-23

This folder contains a safe snapshot of the current PC:

- `packages/` - pacman, AUR and Flatpak package lists
- `services/` - enabled/disabled systemd services
- `hardware/` - system and hardware info
- `gaming/` - Steam/Proton/Bottles/PortProton/GameMode environment info

Restore helper:

```bash
bash scripts/install-from-current-system-snapshot.sh
```

## Bottles DWProton

The restore helper automatically downloads and installs:

```bash
dwproton-10.0-26
```

into:

```bash
~/.local/share/bottles/runners/
```

## Soda runner for Steam

The restore helper automatically tries to copy:

```bash
~/.local/share/bottles/runners/soda-9.0-1
```

to Steam compatibility tools:

```bash
~/.steam/root/compatibilitytools.d/Soda-9.0-1-Bottles
```

Manual helper:

```bash
bash scripts/install-soda-bottles-runner-to-steam.sh
```

Important: this repo intentionally does not copy browser profiles, passwords, SSH keys, keyrings, Steam game prefixes, Wine prefixes, full home directory, DWProton binaries, or Soda binaries.
