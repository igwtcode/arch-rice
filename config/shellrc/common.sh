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

export EDITOR=nvim
export VISUAL=nvim

export LG_CONFIG_FILE=$HOME/.config/lazygit/config.yaml
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

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
