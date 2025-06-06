#!/usr/bin/env bash
DOTDIR="$HOME/.dotfiles"
TARGET="$HOME"

stow_dotfiles() {
	dir="$1"
	name="$(basename "$dir")"
	if [[ ! -d "$HOME/.scripts" ]]; then
		mkdir "$HOME/.scripts"
	fi
	case "$name" in
	.config) target="$HOME/.config" ;;
	.local) target="$HOME/.local" ;;
	.scripts) target="$HOME/.scripts" ;; # optional, or use $HOME/bin
	*) target="$HOME" ;;
	esac
	echo "🔧 Stowing $target..."
	stow -v -d "$DOTDIR" -t "$target" "$name"
}

export -f stow_dotfiles
export DOTDIR TARGET

find "$DOTDIR" -maxdepth 1 -mindepth 1 -type d \
	! -name ".git" ! -name ".github" \
	-exec bash -c 'stow_dotfiles "$0"' {} \;
