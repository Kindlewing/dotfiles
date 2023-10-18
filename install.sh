# Check if the script is run as the superuser (root)
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as the superuser (root)."
    exit 1
fi

# Update the package database and upgrade installed packages
pacman -Syu --noconfirm

# Install yay
git clone https://aur.archlinux.org/yay.git /tmp/yay
chown -R hudson:hudson /tmp/yay
(cd /tmp/yay && sudo -u hudson makepkg -si --noconfirm)
rm -rf /tmp/yay

# Install the specified packages using yay as the user 'hudson'
sudo -u hudson yay -S --noconfirm \
  zsh \
  zellij \
  polybar \
  rofi \
  zathura \
  alacritty \
  git \
  lazygit \
  neovim \
  ripgrep \
  bat \
  eza \
  xh

# Install Dotdrop using yay as the user 'hudson'
sudo -u hudson yay -S --noconfirm dotdrop

# Change the shell to Zsh for the user "hudson"
chsh -s /usr/bin/zsh hudson

# Run Dotdrop to install the "home-pc" profile as the user 'hudson'
 dotdrop install -p home-pc

