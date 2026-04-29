#!/usr/bin/env bash
set -u

pkill -f "xlll-bonsai|xlll-clock|xlll-aquarium|xlll-matrix|xlll-pipes|xlll-desktop-widgets" 2>/dev/null || true
tmux kill-session -t xlll-widgets 2>/dev/null || true

sleep 2.5

hyprctl dispatch workspace 1 >/dev/null 2>&1 || true
sleep 0.3

hyprctl keyword general:layout dwindle >/dev/null 2>&1 || true
hyprctl keyword dwindle:preserve_split true >/dev/null 2>&1 || true
hyprctl keyword dwindle:use_active_for_splits true >/dev/null 2>&1 || true
hyprctl keyword dwindle:default_split_ratio 1.0 >/dev/null 2>&1 || true

wait_class() {
cls="$1"
for i in $(seq 1 100); do
hyprctl clients | grep -q "class: $cls" && return 0
sleep 0.1
done
return 1
}

# 1. Bonsai terminal - left top
kitty --class xlll-bonsai --title "Bonsai" \
    --override font_size=8 \
    --override scrollback_lines=0 \
    bash -lc 'clear; echo "Waiting for layout..."; sleep 6; while true; do clear; LC_ALL=C cbonsai -l -t 0.05 -L 22 -M 4; sleep 1; done' &
wait_class xlll-bonsai
hyprctl dispatch focuswindow "class:^(xlll-bonsai)$" >/dev/null 2>&1 || true
hyprctl dispatch settiled "class:^(xlll-bonsai)$" >/dev/null 2>&1 || true
sleep 0.9

# 2. Aquarium - center
hyprctl dispatch layoutmsg preselect r >/dev/null 2>&1 || true
kitty --class xlll-aquarium --title "Aquarium" --override font_size=8 bash -lc 'asciiquarium' &
wait_class xlll-aquarium
hyprctl dispatch focuswindow "class:^(xlll-aquarium)$" >/dev/null 2>&1 || true
hyprctl dispatch settiled "class:^(xlll-aquarium)$" >/dev/null 2>&1 || true
sleep 0.9

# 3. Matrix - right
hyprctl dispatch layoutmsg preselect r >/dev/null 2>&1 || true
kitty --class xlll-matrix --title "Matrix" --override font_size=5 --override scrollback_lines=0 bash -lc 'sleep 4; clear; exec cmatrix -ab -u 1' &
wait_class xlll-matrix
hyprctl dispatch focuswindow "class:^(xlll-matrix)$" >/dev/null 2>&1 || true
hyprctl dispatch settiled "class:^(xlll-matrix)$" >/dev/null 2>&1 || true
sleep 0.9

# 4. Clock - left bottom
hyprctl dispatch focuswindow "class:^(xlll-bonsai)$" >/dev/null 2>&1 || true
sleep 0.4
hyprctl dispatch layoutmsg preselect d >/dev/null 2>&1 || true
kitty --class xlll-clock --title "Clock" --override font_size=7 bash -lc 'peaclock' &
wait_class xlll-clock
hyprctl dispatch focuswindow "class:^(xlll-clock)$" >/dev/null 2>&1 || true
hyprctl dispatch settiled "class:^(xlll-clock)$" >/dev/null 2>&1 || true
sleep 1.0

# Equal left windows + main layout
hyprctl dispatch resizewindowpixel "exact 850 675,class:^(xlll-bonsai)$" >/dev/null 2>&1 || true
sleep 0.4
hyprctl dispatch resizewindowpixel "exact 850 675,class:^(xlll-clock)$" >/dev/null 2>&1 || true
sleep 0.4
hyprctl dispatch resizewindowpixel "exact 850 1350,class:^(xlll-aquarium)$" >/dev/null 2>&1 || true
sleep 0.4
hyprctl dispatch resizewindowpixel "exact 1740 1350,class:^(xlll-matrix)$" >/dev/null 2>&1 || true
sleep 2.5

# Force redraw after final layout
hyprctl dispatch focuswindow "class:^(xlll-bonsai)$" >/dev/null 2>&1 || true
sleep 0.4
hyprctl dispatch resizeactive 1 1 >/dev/null 2>&1 || true
sleep 0.4
hyprctl dispatch resizeactive -1 -1 >/dev/null 2>&1 || true

hyprctl dispatch focuswindow "class:^(xlll-clock)$" >/dev/null 2>&1 || true
