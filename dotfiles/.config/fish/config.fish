# Startup Commands #
neofetch

# Aliases
alias clear='clear && neofetch'

# Server
alias home-server='ssh -p 589 pi@home-server'
alias home-git-server='ssh ssh://pi@home-server:23231'

# Zellij
alias zn='zellij'
alias za=run_zellij_sessions
alias zls='zellij ls'
alias zka='zellij ka'
alias zr='zellij run -- $argv'
alias zrf='zellij run -f -- $argv'
alias ze='zellij edit $argv'
# Define an alias for the Bash script

# Initialize Starship
starship init fish | source


# Sets environment variables
set -x ANDROID_HOME /home/hudson/Android/Sdk
set -x SUDO_EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim
set -x EDITOR /usr/bin/nvim
set -x BROWSER /usr/bin/brave

function run_zellij_sessions
	bash -c "~/.scripts/autostart-zellij.sh"
end


