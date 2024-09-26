#!/usr/bin/env bash

killall -e xdg-desktop-portal-wlr
killall hyprpaper waybar hypridle xdg-desktop-portal

sleep 1

# dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd --all

hyprpaper &
waybar &
hypridle &

/usr/lib/xdg-desktop-portal-wlr &
sleep 3
/usr/lib/xdg-desktop-portal &

# pkill -9 hyprpaper &>/dev/null
# pkill -9 waybar &>/dev/null
# pkill -9 hypridle &>/dev/null

# pkill -9 nm-applet
# nm-applet &

# sleep 1
# killall -e xdg-desktop-portal-hyprland
# killall xdg-desktop-portal
# /usr/lib/xdg-desktop-portal-hyprland &
# sleep 2
# /usr/lib/xdg-desktop-portal &
