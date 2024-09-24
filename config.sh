#!/usr/bin/env bash

DIR=$(pwd)
CONF_DIR=$DIR/config
DOT_CONF_DIR=$HOME/.config

ln -sfn $CONF_DIR/nvim $DOT_CONF_DIR/nvim
ln -sfn $CONF_DIR/alacritty $DOT_CONF_DIR/alacritty
ln -sfn $CONF_DIR/lazygit $DOT_CONF_DIR/lazygit
ln -sfn $CONF_DIR/.gitconfig $HOME/.gitconfig
ln -sfn $CONF_DIR/bat $DOT_CONF_DIR/bat

bat cache --build
