#!/usr/bin/env bash

SUDO_ASKPASS=~/.config/rofi/scripts/askpass.sh

# Define the power options
options="Lock\nSuspend\nHibernate\nReboot\nShutdown\nLogout"

# Show the power menu using rofi
selected_option=$(echo -e "$options" | rofi -dmenu -p "Power Menu:")

# Perform the selected action
case $selected_option in
Lock)
  hyprlock
  ;;
Suspend)
  sudo -A systemctl suspend
  ;;
Hibernate)
  sudo -A systemctl hibernate
  ;;
Reboot)
  sudo -A systemctl reboot
  ;;
Shutdown)
  sudo -A systemctl poweroff
  ;;
Logout)
  hyprctl dispatch exit
  ;;
*)
  exit 1
  ;;
esac
