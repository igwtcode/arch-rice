alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias exit=' exit'
alias pwd=' pwd'
alias bg=' bg'
alias fg=' fg'
alias lazygit=' lazygit'
alias clear=' clear'
alias lg=lazygit
alias c=clear
alias v=nvim
alias b=bat
alias k=kubectl
alias tf=terraform
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='eza -l --group-directories-first --git --git-repos --icons'
alias lt='ll --ignore-glob ".git|.DS_Store" -aTL'
alias lla='ll -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ch="cliphist list | fzf --no-sort -d $'\t' --with-nth 2 | cliphist decode | wl-copy"

export EDITOR=nvim
export VISUAL=nvim
export MOZ_ENABLE_WAYLAND=1

export LG_CONFIG_FILE=$HOME/.config/lazygit/config.yaml
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.local/bin:$GOPATH/bin/bin:$HOME/bin
export SUDO_ASKPASS=$HOME/.config/rofi/askpass.sh

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
