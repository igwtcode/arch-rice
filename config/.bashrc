#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/shellrc/common.sh

if [ -f "$HOME/.config/shellrc/secret.sh" ]; then
  source $HOME/.config/shellrc/secret.sh
fi

eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"

complete -C "$(which aws_completer)" aws

source <(fzf --bash)
source <(gh completion -s bash)
source <(kubectl completion bash)
source /usr/share/nvm/init-nvm.sh
