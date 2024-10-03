#!/usr/bin/env bash
# vim: ft=bash ts=2 sts=2 sw=2 et

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.config/shellrc/common.sh
[[ -f "$HOME/.config/shellrc/secret.sh" ]] && source $HOME/.config/shellrc/secret.sh

if [[ -n "$WAYLAND_DISPLAY" || -n "$DISPLAY" ]]; then
  eval "$(starship init bash)"
  eval "$(zoxide init --cmd cd bash)"

  source <(fzf --bash)
  complete -C "$(which aws_completer)" aws
  complete -C "$(which terraform)" terraform
  source <(gh completion -s bash)
  source <(kubectl completion bash)
  source /usr/share/nvm/init-nvm.sh
fi
