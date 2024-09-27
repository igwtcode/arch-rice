#!/usr/bin/env bash

# Kill existing instances of required services
pkill -x xdg-desktop-portal-wlr
pkill -x hyprpaper
pkill -x waybar
pkill -x hypridle
pkill -x xdg-desktop-portal

# Update environment variables for dbus
dbus-update-activation-environment --systemd --all

# Start necessary services
hyprpaper &
waybar &
hypridle &

# Start the polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Start xdg-desktop-portal services with a slight delay
/usr/lib/xdg-desktop-portal-wlr &
sleep 1
/usr/lib/xdg-desktop-portal &
