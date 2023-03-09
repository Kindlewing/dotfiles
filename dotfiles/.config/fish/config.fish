# Startup Commands #
neofetch

# Zellij 

if status is-interactive
    # Configure auto-attach/exit to your likings (default is off).
	set ZELLIJ_AUTO_ATTACH false
	set ZELLIJ_AUTO_EXIT false
	eval (zellij setup --generate-auto-start fish | string collect)
end
if not set -q ZELLIJ
    if test "$ZELLIJ_AUTO_ATTACH" = "true"
        zellij attach -c
    else
        zellij
    end

    if test "$ZELLIJ_AUTO_EXIT" = "true"
        kill $fish_pid
    end
end

alias clear='clear && neofetch'

# Initialize Starship
starship init fish | source


# Sets environment variables
set -x ANDROID_HOME /home/hudson/Android/Sdk
set -x SUDO_EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim
set -x EDITOR /usr/bin/nvim
set -x BROWSER /usr/bin/brave
