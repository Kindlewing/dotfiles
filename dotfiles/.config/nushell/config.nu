# Startup commands
neofetch

# Source the prompt
source ~/.cache/starship/init.nu
# Aliases
alias vim = nvim
alias grep = rg
alias clear = (clear; neofetch)
alias cat = bat
alias ship = cd ~/repos/ship/
alias pack = cd ~/repos/pack/
# Main configuration 
let-env config = {
show_banner: false
	table:  {
		mode: rounded
	}
}
