#!/usr/bin/env bash

# Get the list of Firefox profiles, excluding the default profile
profiles=$(grep -E '^\[Profile[0-9]+\]' -A 2 ~/.mozilla/firefox/profiles.ini | grep -E 'Name|Path' | sed 'N;s/\n/|/' | grep -vE "Name=*default*")

# Use rofi to select a profile, removing the 'Name=' prefix
selected_profile=$(echo "$profiles" | cut -d'|' -f1 | sed 's/Name=//' | rofi -dmenu -p "Firefox Profiles:")

# Check if a profile was selected
if [ -z "$selected_profile" ]; then
  exit 1
fi

# Launch Firefox with the selected profile using the profile name
firefox -P "$selected_profile" -no-remote
