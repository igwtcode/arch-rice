#!/usr/bin/env bash

DIR=$(pwd)
CONF_DIR=$DIR/config
DOT_CONF_DIR=$HOME/.config

dotconfig_items=(
  "alacritty"
  "bat"
  "lazygit"
  "nvim"
  "starship"
  "tmux"
)

for item in "${dotconfig_items[@]}"; do
  ln -sfn $CONF_DIR/$item $DOT_CONF_DIR/$item
done

home_items=(
  ".gitconfig"
  ".vimrc"
)

for item in "${home_items[@]}"; do
  ln -sfn $CONF_DIR/$item $HOME/$item
done

tpm_dir=$DOT_CONF_DIR/tmux/plugins/tpm
if [ ! -d $tpm_dir ]; then
  git clone https://github.com/tmux-plugins/tpm $tpm_dir
fi

bat cache --build
