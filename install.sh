#!/usr/bin/bash
source $(dirname "$0")/scripts/library.sh
clear

# Update the package database and upgrade installed packages
while true; do
	read -p "Update required; continue? (Yy/Nn): " yn
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
sudo pacman -Syu --noconfirm

if sudo pacman -Qs yay >/dev/null; then
	echo "yay is installed. You can proceed with the installation"
else
	echo "yay is not installed. Will be installed now!"
	_installPackagesPacman "base-devel"
	git clone https://aur.archlinux.org/yay-git.git ~/yay-git
	cd ~/yay-git
	makepkg -si
	cd ~/dotfiles/
	clear
	echo "yay has been installed successfully."
fi

while true; do
	read -p "Do you want to install the required packages? (Yy/Nn): " yn
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

pacman_packages=(zsh zellij hyprland wl-clipboard waybar swaybg dunst xdg-desktop-portal-hyprland zathura git lazygit neovim ripgrep bat eza xh)

_installPackagesPacman "${pacman_packages[@]}"

yay_packages=(wlogout swaylock-effects-git catppuccin-gtk-theme-mocha)
_installPackagesYay "${yay_packages[@]}"

# Change the shell to Zsh for the user "hudson"
chsh -s /usr/bin/zsh hudson

while true; do
	read -p "Do you want to install dotfiles? (Yy/Nn): " yn
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

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A directory_mappings=(
	["dunst"]="$HOME/.config/dunst"
	["fonts"]="$HOME/.local/share/fonts"
	["hypr"]="$HOME/.config/hypr"
	["kitty"]="$HOME/.config/kitty"
	["nvim"]="$HOME/.config/nvim"
	["scripts"]="$HOME/.config/scripts"
	["waybar"]="$HOME/.config/waybar"
	["wlogout"]="$HOME/.config/wlogout"
	["wofi"]="$HOME/.config/wofi"
	["zathura"]="$HOME/.config/zathura"
	["zellij"]="$HOME/.config/zellij"
)

if _confirm_installation; then
	# Loop through the directory mappings and create symlinks.
	for src_dir in "${!directory_mappings[@]}"; do
		dest_dir="${directory_mappings[$src_dir]}"
		src_dir="$script_dir/$source_folder/$src_dir"

		_installSymLink "$src_dir" "$dest_dir" "$src_dir" "$dest_dir"
	done
fi
