#!/usr/bin/env bash

# Function to launch an application in a specific workspace and wait for it to start
launch_app() {
  local ws="$1"
  local appcmd="$2"

  # Switch to the desired workspace
  hyprctl dispatch workspace $ws

  # Launch the application using eval and get its PID
  eval "$appcmd &"
  local app_pid=$!

  # Wait for the application to start
  wait_for_app "$app_pid"
}

# Function to wait for the application with the given PID to start
wait_for_app() {
  local pid="$1"

  # Loop until the process is running
  while ! ps -p "$pid" >/dev/null 2>&1; do
    sleep 0.3
  done

  # Optionally, wait for a brief moment to ensure it's fully initialized
  sleep 1
}

# Wait for Hyprland to be fully loaded
sleep 1

# kitty_tmux="kitty zsh -c 'tmux attach || ([ -f ~/.local/share/tmux/resurrect/last ] && tmux source-file ~/.local/share/tmux/resurrect/last || tmux new)'"
kitty_tmux="kitty zsh -c '$(tmux attach || tmux)'"
chatgpt="firefox -P default -no-remote https://chatgpt.com"
google="firefox -P test-profile -no-remote https://google.com"
msteams="firefox -P default -no-remote https://teams.microsoft.com"

# Launch applications on their respective workspaces
launch_app 1 "$kitty_tmux"
launch_app 2 "kitty"
launch_app 3 "$chatgpt"
launch_app 5 "$google"
launch_app 7 "$msteams"

sleep 1

# Finally, switch to workspace 1 to focus the terminal
hyprctl dispatch workspace 1
