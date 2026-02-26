#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTDIR="$(dirname "$SCRIPT_DIR")"
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

# Install AUR packages via git clone + makepkg
install_aur() {
	local pkg="$1"
	local tmpdir
	tmpdir=$(mktemp -d)
	echo "📦 Installing AUR package: $pkg..."
	git clone --depth 1 "https://aur.archlinux.org/${pkg}.git" "$tmpdir"
	(cd "$tmpdir" && makepkg -si --needed --noconfirm)
	rm -rf "$tmpdir"
}

if [[ -n "$aur_packages" ]]; then
	while IFS= read -r pkg; do
		install_aur "$pkg"
	done <<< "$aur_packages"
fi

# Build and install bossac from source
echo "📦 Installing bossac..."
tmpdir=$(mktemp -d)
git clone --depth 1 https://github.com/shumatech/BOSSA.git "$tmpdir"
make -C "$tmpdir" bossac
sudo install -m755 "$tmpdir/bin/bossac" /usr/local/bin/bossac
rm -rf "$tmpdir"
echo "✔ bossac installed to /usr/local/bin/bossac"
