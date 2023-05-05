# Startup Commands #
neofetch

# Aliases
alias clear='clear && neofetch'
alias zn='zellij'
alias za=run_zellij_sessions
alias zls='zellij ls'
alias zka='zellij ka'
alias zr='zellij run -- $argv'
alias zrf='zellij run -f -- $argv'
alias ze='zellij edit $argv'
alias swagger-codegen='java -jar /opt/swagger-codegen/swagger-codegen-cli.jar'
# Define an alias for the Bash script

# Initialize Starship
starship init fish | source


# Sets environment variables
set -x  PATH $PATH /usr/local/go/bin
set -x PATH $PATH ~/.go/bin/
set -x ANDROID_HOME /home/hudson/Android/Sdk
set -x SUDO_EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim
set -x EDITOR /usr/bin/nvim
set -x BROWSER /usr/bin/brave

function run_zellij_sessions
	bash -c "~/.scripts/autostart-zellij.sh"
end


