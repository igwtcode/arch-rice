#!/bin/bash

# Set up directories and file paths
DIR=$(pwd)
CONF_DIR="$DIR/config"
DOT_CONF_DIR="$HOME/.config"
WALLPAPER_DIR="$HOME/Pictures/wallpaper"
TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
HOME_LOCAL_BIN="$HOME/.local/bin"
TMUX_TPM_DIR="$DOT_CONF_DIR/tmux/plugins/tpm"
YAY_DIR="/opt/yay"
PKG_FILE="pkg.txt"

# Services to enable and start
SERVICES=(
  "acpid"
  "bluetooth"
  "cronie"
  "docker"
  "fstrim.timer"
  "grub-btrfsd"
  "NetworkManager"
  "sshd"
  # "avahi-daemon"
)

# Configuration items to symlink in ~/.config
dotconfig_items=(
  "alacritty"
  "bat"
  "btop"
  "Code"
  "code-flags.conf"
  "dunst"
  "hypr"
  "kitty"
  "lazygit"
  "nvim"
  "prettier"
  "rofi"
  "shellrc"
  "starship"
  "tmux"
  "waybar"
)

# Home directory dotfiles to symlink
home_items=(
  ".gitconfig"
  ".bashrc"
  ".zshrc"
  ".vim"
  ".vimrc"
)

# Initialize and update pacman keys, update system, clean cache
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Sy --needed --noconfirm archlinux-keyring && sudo pacman -Su --noconfirm
sudo pacman -Sc --noconfirm

# Remove aws-cli if installed
sudo pacman -Rns aws-cli --noconfirm 2>/dev/null

# Install yay if not already installed
if ! command -v yay &>/dev/null; then
  sudo mkdir -p "$YAY_DIR"
  sudo chown -R "$USER":"$USER" "$YAY_DIR"
  git clone https://aur.archlinux.org/yay.git "$YAY_DIR"
  cd "$YAY_DIR" || exit
  makepkg -si --noconfirm
  yay -Y --gendb --noconfirm && yay -Syu --devel --noconfirm
  cd "$DIR" || exit
else
  echo "yay already installed."
fi

# Install packages from list, only those that are not already installed
yay -S --needed --noconfirm - <"$PKG_FILE"

# Set timezone and sync hardware clock
sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
sudo hwclock --systohc

# Set zsh as default shell if not already set
if [ "$SHELL" != "$(which zsh)" ]; then
  sudo chsh -s "$(which zsh)" "$USER"
fi

# Fix btop Intel graphics issue (set performance monitoring capability)
sudo setcap cap_perfmon=+ep "$(which btop)"

# Add user to docker group for running docker without sudo
sudo usermod -aG docker "$USER"

# Enable and start necessary services
for item in "${SERVICES[@]}"; do
  sudo systemctl enable --now "$item"
done

# Create necessary directories if they don't exist
mkdir -p "$DOT_CONF_DIR" "$WALLPAPER_DIR" "$TF_PLUGIN_CACHE_DIR" "$HOME_LOCAL_BIN"

# Symlink configuration files into ~/.config
for item in "${dotconfig_items[@]}"; do
  ln -sfn "$CONF_DIR/$item" "$DOT_CONF_DIR/$item"
done

# Symlink dotfiles into home directory
for item in "${home_items[@]}"; do
  ln -sfn "$CONF_DIR/$item" "$HOME/$item"
done

# Symlink custom bin directory
ln -sfn "$DIR/bin" "$HOME/bin"

# Install tmux plugin manager if not already installed
if [ ! -d "$TMUX_TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TMUX_TPM_DIR"
fi

# Rebuild bat cache for syntax highlighting
bat cache --build &>/dev/null

# Install Yazi flavor for Catppuccin Mocha theme
ya pack -a yazi-rs/flavors:catppuccin-mocha &>/dev/null

# Create the directory for pacman hooks if it doesn't already exist
sudo mkdir -p /etc/pacman.d/hooks

# Copy the Timeshift snapshot hook to create snapshots before pacman operations
sudo cp "$CONF_DIR/99-timeshift-pretransaction.hook" /etc/pacman.d/hooks/99-timeshift-pretransaction.hook

# Copy the grub-btrfs hook to add snapshots in systemd-boot menu after pacman operations
sudo cp "$CONF_DIR/99-btrfs-systemd-boot.hook" /etc/pacman.d/hooks/99-btrfs-systemd-boot.hook
