#!/usr/bin/env bash

DIR=$(pwd)
CONF_DIR=$DIR/config
DOT_CONF_DIR=$HOME/.config

ln -sfn $CONF_DIR/nvim $DOT_CONF_DIR/nvim
ln -sfn $CONF_DIR/.gitconfig $HOME/.gitconfig
