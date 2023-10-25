#!/usr/bin/bash
# Check if the script is run as the superuser (root)
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as the superuser (root)."
    exit 1
fi

# Update the package database and upgrade installed packages
pacman -Syu --noconfirm

# Install yay
if [[ -d "yay" ]]; then
    rm -rf yay
fi

pacman -S --needed git base-devel && sudo -u hudson git clone https://aur.archlinux.org/yay.git && cd yay && sudo -u hudson makepkg -si && cd ..

pacman_packages=(zsh zellij hyprland wl-clipboard waybar swaybg dunst xdg-desktop-portal-hyprland zathura git lazygit neovim ripgrep bat eza xh)
yay_packages=(wlogout swaylock-effects-git dotdrop catppuccin-gtk-theme-mocha)

for package in pacman_packages
do
    sudo pacman -S "$package" --noconfirm
done

for package in yay_packages
do
    sudo -u hudson yay -S "$package" --noconfirm
done

# Change the shell to Zsh for the user "hudson"
chsh -s /usr/bin/zsh hudson

# Run Dotdrop to install the "home-pc" profile as the user 'hudson'
 dotdrop install -p home-pc

