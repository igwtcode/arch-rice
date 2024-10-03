#!/usr/bin/env zsh

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit
compinit

export HISTORY_TIME_FORMAT="%Y-%m-%d %T "
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=9999
export SAVEHIST=9999
alias hist=' history -E'

source ~/.config/shellrc/common.sh

if [ -f "$HOME/.config/shellrc/secret.sh" ]; then
  source $HOME/.config/shellrc/secret.sh
fi

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

complete -C "$(which aws_completer)" aws
complete -o nospace -C "$(which terraform)" terraform

source ~/.config/shellrc/catppuccin_mocha-zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)
source <(gh completion -s zsh)
source <(kubectl completion zsh)
source /usr/share/nvm/init-nvm.sh

