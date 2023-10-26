#!/usr/bin/bash
source "$(dirname "$0")/scripts/library.sh"
clear

# Update the package database and upgrade installed packages
while true; do
	read -rp "Update required; continue? (Yy/Nn): " yn
	case $yn in
	[Yy]*)
		echo "Installation started."
		break
		;;
	[Nn]*)
		exit
		;;
	*) echo "Please answer yes or no." ;;
	esac
done
sudo pacman -Syu --noconfirm

if sudo pacman -Qs yay >/dev/null; then
	echo "yay is installed. You can proceed with the installation"
else
	echo "yay is not installed. Will be installed now!"
	_installPackagesPacman "base-devel"
	git clone https://aur.archlinux.org/yay-git.git ~/yay-git
	cd ~/yay-git || return
	makepkg -si
	cd ~/dotfiles/ || return
	clear
	echo "yay has been installed successfully."
fi

while true; do
	read -rp "Do you want to install the required packages? (Yy/Nn): " yn
	case $yn in
	[Yy]*)
		echo "Installation started."
		break
		;;
	[Nn]*)
		exit
		break
		;;
	*) echo "Please answer yes or no." ;;
	esac
done

echo ""
echo "-> Install main packages"

pacman_packages=(jq zsh zellij hyprland wl-clipboard kitty wofi waybar swaybg dunst xdg-desktop-portal-hyprland zathura git lazygit neovim ripgrep bat eza xh)

_installPackagesPacman "${pacman_packages[@]}"

yay_packages=(wlogout swaylock-effects-git catppuccin-gtk-theme-mocha)
_installPackagesYay "${yay_packages[@]}"

while true; do
	read -rp "Do you want to install dotfiles? (Yy/Nn): " yn
	case $yn in
	[Yy]*)
		echo "Installation started."
		break
		;;
	[Nn]*)
		exit
		;;
	*) echo "Please answer yes or no." ;;
	esac
done
# ------------------------------------------------------
# Create .config folder
# ------------------------------------------------------
echo ""
echo "-> Check if .config folder exists"

if [ -d ~/.config ]; then
	echo ".config folder already exists."
else
	mkdir ~/.config
	echo ".config folder created."
fi

# ------------------------------------------------------
# Create symbolic links
# ------------------------------------------------------
# name symlink source target

echo ""
echo "-------------------------------------"
echo "-> Install general dotfiles"
echo "-------------------------------------"
echo ""

_installSymLink nvim ~/.config/nvim ~/.dotfiles/nvim/ ~/.config
_installSymLink rofi ~/.config/rofi ~/.dotfiles/rofi/ ~/.config
_installSymLink dunst ~/.config/dunst ~/.dotfiles/dunst/ ~/.config
_installSymLink wofi ~/.config/wofi ~/.dotfiles/wofi/ ~/.config
_installSymLink kitty ~/.config/kitty ~/.dotfiles/kitty/ ~/.config
_installSymLink zellij ~/.config/zellij ~/.dotfiles/zellij/ ~/.config
_installSymLink zathura ~/.config/zathura ~/.dotfiles/zathura/ ~/.config
_installSymLink .fonts ~/.local/share/fonts ~/.dotfiles/fonts/ ~/.local/share/fonts

echo ""
echo "-------------------------------------"
echo "-> Install general dotfiles"
echo "-------------------------------------"
echo ""

_installSymLink .zshrc ~/.zshrc ~/.dotfiles/.zshrc
_installSymLink .zsh_aliases ~/.zsh_aliases ~/.dotfiles/.zsh_aliases
_installSymLink .p10k.zsh ~/.p10k.zsh ~/.dotfiles/.p10k.zsh

echo "-------------------------------------"
echo "-> Install Hyprland dotfiles"
echo "-------------------------------------"
echo ""

_installSymLink hypr ~/.config/hypr ~/.dotfiles/hypr/ ~/.config
_installSymLink waybar ~/.config/waybar ~/.dotfiles/waybar/ ~/.config
_installSymLink swaylock ~/.config/swaylock ~/.dotfiles/swaylock/ ~/.config
_installSymLink wlogout ~/.config/wlogout ~/.dotfiles/wlogout/ ~/.config

echo "Dotfiles successfully installed!"
