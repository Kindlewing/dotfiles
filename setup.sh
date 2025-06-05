#!/usr/bin/env bash

stow_dotfiles() {
	dir_name=$(basename "$0")
	echo "Stowing $dir_name..."
	stow -t ~ "$dir_name"
}

./install.sh

# stow the directories
export -f stow_dotfiles
find . -maxdepth 1 -mindepth 1 -type d ! -name ".git" ! -name ".github" ! -name "git" -exec bash -c 'stow_dotfiles "$0"' {} \;
