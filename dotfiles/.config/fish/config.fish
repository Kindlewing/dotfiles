# Startup Commands #
neofetch

# Aliases
alias clear='clear && neofetch'

# Server
alias home-server='ssh -p 589 hudson@homelab.lan'
alias hs='ssh -p 589 hudson@homelab.lan'

# Zellij
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
set -x CHARM_HOST home-server/home-server-charm

function run_zellij_sessions
	bash -c "~/.scripts/autostart-zellij.sh"
end


