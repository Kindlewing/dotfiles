#!/usr/bin/env bash

DOTDIR="$HOME/.dotfiles"
TARGET="$HOME"

link_dotfiles() {
	dir="$1"
	name="$(basename "$dir")"

	# Determine the target directory based on folder name
	case "$name" in
	.config) target="$HOME/.config" ;;
	.local) target="$HOME/.local" ;;
	.scripts)
		target="$HOME/.scripts"
		[[ -d "$target" ]] || mkdir -p "$target"
		;;
	*) target="$HOME" ;;
	esac

	echo "🔧 Linking into $target..."

	# Ensure the target directory exists
	mkdir -p "$target"

	# Link each file or directory inside the subdir
	for item in "$dir"/*; do
		[[ -e "$item" ]] || continue
		base_item="$(basename "$item")"
		src="$item"
		dest="$target/$base_item"

		if [[ -L "$dest" || -e "$dest" ]]; then
			echo "⚠️  Skipping existing: $dest"
		else
			ln -sv "$src" "$dest"
		fi
	done
}

export -f link_dotfiles
export DOTDIR TARGET

find "$DOTDIR" -maxdepth 1 -mindepth 1 -type d \
	! -name ".git" ! -name ".github" \
	-exec bash -c 'link_dotfiles "$0"' {} \;
