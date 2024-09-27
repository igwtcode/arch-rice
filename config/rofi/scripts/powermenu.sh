#!/usr/bin/env bash

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
  sudo systemctl suspend
  ;;
Hibernate)
  sudo systemctl hibernate
  ;;
Reboot)
  sudo systemctl reboot
  ;;
Shutdown)
  sudo systemctl poweroff
  ;;
Logout)
  hyprctl dispatch exit
  ;;
*)
  exit 1
  ;;
esac
