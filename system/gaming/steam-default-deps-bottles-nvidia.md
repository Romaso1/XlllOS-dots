# Steam default dependencies for Bottles-like mods and NVIDIA

Steam/Proton has no single global prefix. Every game has its own prefix:

```text
~/.local/share/Steam/steamapps/compatdata/APPID/pfx
```

This repo makes dependencies behave as close to "default everywhere" as possible:

1. Installs common dependencies into all existing Steam prefixes.
2. Creates a user systemd timer.
3. The timer scans for new prefixes every 30 minutes.
4. Each prefix is processed only once unless the dependency signature changes or `REINSTALL=1` is used.

Helper:

```bash
bash scripts/install-steam-default-deps-bottles-nvidia.sh
```

Timer:

```text
xlllos-steam-default-deps-bottles-nvidia.timer
```

Manual forced run:

```bash
FORCE=1 bash scripts/install-steam-default-deps-bottles-nvidia.sh
```

One game:

```bash
APPID=548430 FORCE=1 bash scripts/install-steam-default-deps-bottles-nvidia.sh
```

Reinstall into all prefixes:

```bash
REINSTALL=1 FORCE=1 bash scripts/install-steam-default-deps-bottles-nvidia.sh
```

Optional .NET:

```bash
INSTALL_DOTNET=1 FORCE=1 bash scripts/install-steam-default-deps-bottles-nvidia.sh
```

Default dependency set:

```text
vcrun2003
vcrun2005
vcrun2008
vcrun2010
vcrun2012
vcrun2013
vcrun2022
d3dcompiler_43
d3dcompiler_47
d3dx9
d3dx10
d3dx11_42
d3dx11_43
xact
xinput
dsound
quartz
devenum
gdiplus
msxml3
msxml4
msxml6
corefonts
cjkfonts
tahoma
webview2
```

NVIDIA tweaks applied per prefix:

```text
HwSchMode=2
nvapi=native,builtin
nvapi64=native,builtin
```

ProtonPlus is kept for managing Proton runners, but Windows dependencies inside prefixes are handled by Protontricks.

For DLL mods, Steam launch options may still be required. See:

```text
system/gaming/steam-nvidia-mods-launch-options.txt
```
