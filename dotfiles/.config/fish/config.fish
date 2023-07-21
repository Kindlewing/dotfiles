# Startup Commands #
neofetch

# Aliases
alias clear='clear && neofetch'

# Server
alias home-server='ssh -p 589 hudson@homelab'
alias hs='ssh -p 589 hudson@homelab'

# Zellij
alias zn='zellij'
alias za=run_zellij_sessions
alias zls='zellij ls'
alias zka='zellij ka'
alias zr='zellij run -- $argv'
alias zrf='zellij run -f -- $argv'
alias ze='zellij edit $argv'

# dotdrop
alias dotdrop='/home/hudson/.dotfiles/dotdrop.sh --cfg=/home/hudson/.dotfiles/config.yaml'
# Initialize Starship
starship init fish | source


# Sets environment variables
set -x  PATH $PATH /usr/local/go/bin
set -x PATH $PATH ~/.go/bin/
set -x PATH $PATH /home/hudson/.local/share/gem/ruby/3.0.0/bin
set -x PATH $PATH ~/Development/flutter/bin
set -x PATH $PATH ~/.android-tools/bin
set -x ANDROID_HOME /home/hudson/Android/Sdk
set -x SUDO_EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim
set -x EDITOR /usr/bin/nvim
set -x BROWSER /usr/bin/brave
set -x CHARM_HOST home-server/home-server-charm

function run_zellij_sessions
	bash -c "~/.scripts/autostart-zellij.sh"
end


