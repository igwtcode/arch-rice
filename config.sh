#!/usr/bin/env bash

DIR=$(pwd)
CONF_DIR=$DIR/config
DOT_CONF_DIR=$HOME/.config

if [ ! -d $DOT_CONF_DIR ]; then
  mkdir -p $DOT_CONF_DIR
fi

TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
if [ ! -d $TF_PLUGIN_CACHE_DIR ]; then
  mkdir -p $TF_PLUGIN_CACHE_DIR
fi

DOTCONFIG_ITEMS=(
  "alacritty"
  "bat"
  "lazygit"
  "nvim"
  "starship"
  "tmux"
  "shellrc"
)

for item in "${DOTCONFIG_ITEMS[@]}"; do
  ln -sfn $CONF_DIR/$item $DOT_CONF_DIR/$item
done

HOME_ITEMS=(
  ".gitconfig"
  ".bashrc"
  ".zshrc"
  ".vimrc"
)

for item in "${HOME_ITEMS[@]}"; do
  ln -sfn $CONF_DIR/$item $HOME/$item
done

TPM_DIR=$DOT_CONF_DIR/tmux/plugins/tpm
if [ ! -d $TPM_DIR ]; then
  git clone https://github.com/tmux-plugins/tpm $TPM_DIR
fi

bat cache --build
