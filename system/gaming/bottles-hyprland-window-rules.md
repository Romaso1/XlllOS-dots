# Bottles Hyprland window rules

Bottles and Wine/.exe windows are configured to behave more like PortProton windows:

- floating
- centered
- native/app-defined size preserved
- no forced size
- no persistent_size
- fullscreen/maximize requests suppressed for helper/setup/login windows

Config location:

```bash
~/.config/hypr/hyprland.conf
```

Repo location:

```bash
dotfiles/.config/hypr/hyprland.conf
```

Rule block:

```text
BEGIN XlllOS Bottles PortProton-like native floating rules
```
