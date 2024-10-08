#!/bin/bash

DIR=$(pwd)
PACMAN_PACKAGE_FILE="pkg-pacman.txt"
YAY_PACKAGE_FILE="pkg-yay.txt"
YAY_PATH=/opt/yay

init_pacman() {
  # https://wiki.archlinux.org/title/Pacman/Package_signing
  sudo pacman-key --init
  sudo pacman-key --populate
  sudo pacman -Sy --needed --noconfirm archlinux-keyring && sudo pacman -Su --noconfirm
  sudo pacman -Sc --noconfirm
  sudo pacman -Rns aws-cli --noconfirm 2>/dev/null
}

install_pacman_packages() {
  mapfile -t packages < <(grep -vE '^\s*#|^\s*$' "$PACMAN_PACKAGE_FILE")
  if [ "${#packages[@]}" -ne 0 ]; then
    sudo pacman -S --needed --noconfirm "${packages[@]}"
  fi
}

init_yay() {
  if command -v yay &>/dev/null; then
    echo "yay already installed."
  else
    sudo mkdir -p "$YAY_PATH" 2>/dev/null
    sudo chown -R "$USER":"$USER" $YAY_PATH
    git clone https://aur.archlinux.org/yay.git $YAY_PATH
    cd $YAY_PATH
    makepkg -si --noconfirm
    yay -Y --gendb --noconfirm && yay -Syu --devel --noconfirm
    cd $DIR
  fi
}

install_yay_packages() {
  mapfile -t packages < <(grep -vE '^\s*#|^\s*$' "$YAY_PACKAGE_FILE")
  if [ "${#packages[@]}" -ne 0 ]; then
    yay -S --needed --noconfirm "${packages[@]}"
  fi
}

configure_time() {
  sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
  sudo hwclock --systohc
}

set_default_shell() {
  sudo chsh -s $(which zsh) "$USER"
}

setup_services() {
  local services=(
    "acpid"
    "avahi-daemon"
    "bluetooth"
    "docker"
    "fstrim.timer"
    "NetworkManager"
    "sshd"
  )

  for item in "${services[@]}"; do
    sudo systemctl enable $item
    sudo systemctl restart $item
  done
}

init_pacman
install_pacman_packages
init_yay
install_yay_packages
set_default_shell
configure_time

# add user to docker group (docker without sudo)
sudo usermod -aG docker $USER

setup_services

# fix btop intel graphics issue
sudo setcap cap_perfmon=+ep $(which btop)
