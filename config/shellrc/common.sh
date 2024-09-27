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

# to fix issue with getting intel graphics data
# alias btop=' sudo btop'

export EDITOR=nvim
export VISUAL=nvim

export LG_CONFIG_FILE=$HOME/.config/lazygit/config.yaml
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.local/bin:$GOPATH/bin/bin
export MOZ_ENABLE_WAYLAND=1

# pull all git branches
git_pull_all_branches() {
  local current_branch=$(git branch --show-current)
  git fetch origin

  # Get a list of all remote branches (stripped of the 'origin/' prefix)
  for branch in $(git branch -r | grep -v '\->' | sed 's/origin\///'); do
    if ! git show-ref --verify --quiet refs/heads/$branch; then
      git branch --track "$branch" "origin/$branch"
    fi
    echo
    git checkout $branch && git pull origin $branch
  done

  git switch $current_branch
}

# pull all repos with a name filter in directory
pull_tracking() {
  for x in $(ls -1 | grep -i '.modul.tracking'); do echo -e "\n---------\n==> $x\n" && cd $x && git_pull_all_branches && cd ..; done
}
