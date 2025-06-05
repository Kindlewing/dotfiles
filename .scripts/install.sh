#!/usr/bin/env bash
set -euo pipefail

DOTDIR="/home/hudson/.dotfiles"
REQUIREMENTS_FILE="$DOTDIR/requirements.txt"

# Check for required headers
if ! grep -q '^# Pacman' "$REQUIREMENTS_FILE"; then
	echo "❌ Missing '# Pacman' section in $REQUIREMENTS_FILE"
	exit 1
fi

if ! grep -q '^# AUR' "$REQUIREMENTS_FILE"; then
	echo "❌ Missing '# AUR' section in $REQUIREMENTS_FILE"
	exit 1
fi

# Extract Pacman packages (between "# Pacman" and "# AUR")
pacman_packages=$(sed -n '/^# Pacman/,/^# AUR/p' "$REQUIREMENTS_FILE" | sed -E '/^\s*#/d;/^\s*$/d')

# Extract AUR packages (after "# AUR" to end of file)
aur_packages=$(sed -n '/^# AUR/,$p' "$REQUIREMENTS_FILE" | sed -E '/^\s*#/d;/^\s*$/d')

# Install Pacman packages
if [[ -n "$pacman_packages" ]]; then
	echo "📦 Installing Pacman packages..."
	echo "$pacman_packages" | sudo pacman -S --needed -
fi

# Install AUR packages with paru or yay
if [[ -n "$aur_packages" ]]; then
	if command -v paru &>/dev/null; then
		echo "📦 Installing AUR packages with paru..."
		echo "$aur_packages" | paru -S --needed -
	elif command -v yay &>/dev/null; then
		echo "📦 Installing AUR packages with yay..."
		echo "$aur_packages" | yay -S --needed -
	else
		echo "⚠️  No AUR helper found (paru or yay). Please install AUR dependencies manually."
		exit 1
	fi
fi
