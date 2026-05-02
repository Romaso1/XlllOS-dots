# Steam compatibility tools

Updated: 2026-05-02_23-09-11

Automatic installer:

```bash
bash scripts/install-steam-dwproton-soda.sh
```

Installed/managed tools:

- `dwproton-10.0-26`
- `Soda-9.0-1-Bottles`

Steam folder:

```bash
~/.steam/root/compatibilitytools.d/
```

Notes:

- DWProton is a normal Proton build and is the better option for Steam games.
- Soda is installed with a wrapper around its `bin/wine`; keep it as an extra test runner.
- Bottles is not required.
