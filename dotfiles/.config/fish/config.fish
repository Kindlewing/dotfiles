# Startup Commands #
neofetch

# Aliases
alias clear='clear && neofetch'
alias zls='zellij ls'
alias zak='zellij ka'
alias zr='zellij run -- $argv'
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

# Run the script
run_zellij_sessions


