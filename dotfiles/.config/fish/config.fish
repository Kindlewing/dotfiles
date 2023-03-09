# Startup Commands #


# Aliases
alias clear='clear && neofetch'
alias zls='zellij ls'
alias zak='zellij ka'
alias zr='zellij run -- $argv'

# Initialize Starship
starship init fish | source


# Sets environment variables
set -x ANDROID_HOME /home/hudson/Android/Sdk
set -x SUDO_EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim
set -x EDITOR /usr/bin/nvim
set -x BROWSER /usr/bin/brave
set ZJ_SESSIONS (zellij list-sessions)
set NO_SESSIONS (echo $ZJ_SESSIONS | wc -l)

# ZelliJ
if test $NO_SESSIONS -ge 2
    zellij attach (echo $ZJ_SESSIONS | sk)
else
    zellij attach -c
end
