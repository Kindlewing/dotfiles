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

declare -A dotfiles

# Read JSON from a file
json_file="config.json" # Change this to your JSON file
json_entries=$(cat "$json_file")

# Parse JSON and call _installSymLink function for each entry
IFS=$'\n' read -r -d '' -a entries < <(jq -c '.[]' <<<"$json_entries")
for entry in "${entries[@]}"; do
	name=$(jq -r '.name' <<<"$entry")
	symlink=$(jq -r '.symlink' <<<"$entry")
	linksource=$(jq -r '.linksource' <<<"$entry")
	linktarget=$(jq -r '.linktarget' <<<"$entry")
	_installSymLink "$name" "$symlink" "$linksource" "$linktarget"
done

# Print the associative array for verification
for param in "${!dotfiles[@]}"; do
	echo "$param: ${dotfiles[$param]}"
done

# Check if the user wants to install dotfiles.
read -rp "Do you want to install the dotfiles? Existing symlinks will be removed (Yy/Nn): " yn
