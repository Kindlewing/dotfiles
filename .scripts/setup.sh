#!/usr/bin/env bash

DOTDIR="/home/hudson/.dotfiles/"
stow_dotfiles() {
	dir_name=$(basename "$0")
	echo "Stowing $dir_name..."
	stow -v "$DOTDIR"
}
sudo ./install.sh
export -f stow_dotfiles
echo "Stowing files"
find "$DOTDIR" -maxdepth 1 -mindepth 1 -type d ! -name ".git" ! -name ".github" ! -name "git" -exec bash -c 'stow_dotfiles "$0"' {} \;
