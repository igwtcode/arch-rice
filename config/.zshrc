#!/usr/bin/env zsh
# vim: ft=zsh ts=2 sts=2 sw=2 et

setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_FIND_NO_DUPS HIST_SAVE_NO_DUPS
setopt prompt_subst AUTO_CD
zstyle ':completion:*' matcher-list 'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit
compinit

export HISTORY_TIME_FORMAT="%Y-%m-%d %T "
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=9999
export SAVEHIST=9999
alias hist='history -E'

source $HOME/.config/shellrc/common.sh
[[ -f "$HOME/.config/shellrc/secret.sh" ]] && source $HOME/.config/shellrc/secret.sh

if [[ -n "$WAYLAND_DISPLAY" || -n "$DISPLAY" ]]; then
  eval "$(starship init zsh)"
  eval "$(zoxide init --cmd cd zsh)"

  # [[ -x "$(which aws_completer)" ]] && complete -C "$(which aws_completer)" aws

  source <(fzf --zsh)
  complete -C "$(which aws_completer)" aws
  complete -o nospace -C "$(which terraform)" terraform
  source <(gh completion -s zsh)
  source <(kubectl completion zsh)

  source ~/.config/shellrc/catppuccin_mocha-zsh-syntax-highlighting.zsh
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/nvm/init-nvm.sh
fi
