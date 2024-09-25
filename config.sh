#!/usr/bin/env bash

DIR=$(pwd)
CONF_DIR=$DIR/config
DOT_CONF_DIR=$HOME/.config
WALLPAPER_DIR=$HOME/Pictures/wallpaper

check_directories() {
  if [ ! -d $DOT_CONF_DIR ]; then
    mkdir -p $DOT_CONF_DIR
  fi

  if [ ! -d $WALLPAPER_DIR ]; then
    mkdir -p $WALLPAPER_DIR
  fi

  local TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
  if [ ! -d $TF_PLUGIN_CACHE_DIR ]; then
    mkdir -p $TF_PLUGIN_CACHE_DIR
  fi

  local HOME_LOCAL_BIN=$HOME/.local/bin
  if [ ! -d "$HOME_LOCAL_BIN" ]; then
    mkdir -p $HOME_LOCAL_BIN
  fi

}

link_dotfiles() {
  local dotconfig_items=(
    "alacritty"
    "bat"
    "dunst"
    "lazygit"
    "rofi"
    "nvim"
    "starship"
    "tmux"
    "shellrc"
    "hypr"
  )

  local home_items=(
    ".gitconfig"
    ".bashrc"
    ".zshrc"
    ".vimrc"
  )

  for item in "${dotconfig_items[@]}"; do
    ln -sfn $CONF_DIR/$item $DOT_CONF_DIR/$item
  done

  for item in "${home_items[@]}"; do
    ln -sfn $CONF_DIR/$item $HOME/$item
  done
}

post_config() {
  local TPM_DIR=$DOT_CONF_DIR/tmux/plugins/tpm
  if [ ! -d $TPM_DIR ]; then
    git clone https://github.com/tmux-plugins/tpm $TPM_DIR
  fi

  bat cache --build &>/dev/null
  ya pack -a yazi-rs/flavors:catppuccin-mocha &>/dev/null
}

# rofi_themes() {
#   local tmp_dir=$(mktemp -d -q)
#   cd $tmp_dir
#   git clone https://github.com/lr-tech/rofi-themes-collection.git
#   cd rofi-themes-collection
#   mkdir -p $HOME/.local/share/rofi/themes/
#   cp -r themes ~/.local/share/rofi/
#   cd $DIR
#   rm -rf $tmp_dir 2>/dev/null
# }

check_directories
link_dotfiles
# rofi_themes
post_config
