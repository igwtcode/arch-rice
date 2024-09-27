#!/usr/bin/env bash

# export SUDO_ASKPASS=~/.config/rofi/scripts/ask-sudo-pass.sh

# Define the power options
options="Lock\nSuspend\nHibernate\nReboot\nShutdown\nLogout"

# Show the power menu using rofi
selected_option=$(echo -e "$options" | rofi -dmenu -i -matching "fuzzy" -p "Power Menu:")

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
