#!/usr/bin/bash
source "$(dirname "$0")/scripts/library.sh"
clear

echo "     _       _    __ _ _            "
echo "  __| | ___ | |_ / _(_) | ___  ___  "
echo " / _' |/ _ \| __| |_| | |/ _ \/ __| "
echo "| (_| | (_) | |_|  _| | |  __/\__ \ "
echo " \__,_|\___/ \__|_| |_|_|\___||___/ "
echo "                                    "
echo "by Hudson Finn (2023)"
echo "-------------------------------------"
echo ""
echo "The script will ask for permission to remove existing directories and files from ~/.config/"
echo "Symbolic links will then be created from ~/dotfiles into your ~/.config/ directory."
echo "But you can decide to keep your personal versions by answering with No (Nn)."
echo ""

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

clear

echo "     _       _    __ _ _            "
echo "  __| | ___ | |_ / _(_) | ___  ___  "
echo " / _' |/ _ \| __| |_| | |/ _ \/ __| "
echo "| (_| | (_) | |_|  _| | |  __/\__ \ "
echo " \__,_|\___/ \__|_| |_|_|\___||___/ "
echo "                                    "
echo "by Hudson Finn (2023)"
echo "-------------------------------------"
echo ""

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

clear

echo "     _       _    __ _ _            "
echo "  __| | ___ | |_ / _(_) | ___  ___  "
echo " / _' |/ _ \| __| |_| | |/ _ \/ __| "
echo "| (_| | (_) | |_|  _| | |  __/\__ \ "
echo " \__,_|\___/ \__|_| |_|_|\___||___/ "
echo "                                    "
echo "by Hudson Finn (2023)"
echo "-------------------------------------"
echo ""

while true; do
	read -rp "Do you want to install the required packages? (Yy/Nn): " yn
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

echo ""
echo "-> Install main packages"

pacman_packages=(zsh zellij hyprland wl-clipboard kitty wofi waybar swaybg nodejs npm dunst xdg-desktop-portal-hyprland zathura git lazygit neovim ripgrep bat eza xh)

_installPackagesPacman "${pacman_packages[@]}"

yay_packages=(wlogout dotdrop swaylock-effects-git catppuccin-gtk-theme-mocha)
_installPackagesYay "${yay_packages[@]}"

clear

echo "     _       _    __ _ _            "
echo "  __| | ___ | |_ / _(_) | ___  ___  "
echo " / _' |/ _ \| __| |_| | |/ _ \/ __| "
echo "| (_| | (_) | |_|  _| | |  __/\__ \ "
echo " \__,_|\___/ \__|_| |_|_|\___||___/ "
echo "                                    "
echo "by Hudson Finn (2023)"
echo "-------------------------------------"
echo ""

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
# Dotdrop
# ------------------------------------------------------
# name symlink source target

dotdrop -c ~/.dotfiles/config.yml -p home

echo "Dotfiles successfully installed!"
