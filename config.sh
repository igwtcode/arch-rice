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

set_default_shell() {
  sudo chsh -s $(which zsh) "$USER"
}

link_dotfiles() {
  local dotconfig_items=(
    "alacritty"
    "bat"
    "lazygit"
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

  bat cache --build
  ya pack -a yazi-rs/flavors:catppuccin-mocha
}

check_directories
set_default_shell
link_dotfiles
post_config
