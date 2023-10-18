#!/bin/bash

# Update the package database and upgrade installed packages
sudo pacman -Syu --noconfirm

# Install the specified packages
sudo pacman -S --noconfirm \
  zsh \
  zellij \
  polybar \
  rofi \
  zathura \
  alacritty \
  git \
  lazygit \
  neovim \
  ripgrep \
  bat \
  eza \
  xh

git clone https://aur.archlinux.org/yay.git /tmp/yay
chown -R hudson:hudson /tmp/yay
(cd /tmp/yay && sudo -u hudson makepkg -si --noconfirm)
rm -rf /tmp/yay


# Install Dotdrop
yay -S dotdrop
# Change the shell to Zsh for the user "hudson"
sudo chsh -s /usr/bin/zsh hudson

# Run Dotdrop to install the "home-pc" profile
dotdrop install -p home-pc
