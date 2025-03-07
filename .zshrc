eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

export ZSH="$HOME/.zsh"
export ODIN_LIBS="$HOME/.odin/"
export ZSH_PLUGINS=$ZSH/plugins
export PATH="/usr/local/go/bin:$PATH"
export PATH="~/.go/bin/:$PATH"
export PATH="~/.local/bin/:$PATH"
export PATH="/home/hudson/.local/share/gem/ruby/3.0.0/bin:$PATH"
export PATH="/home/hudson/.odin:$PATH"
export PATH="~/Development/flutter/bin:$PATH"
export PATH="~/.android-tools/bin:$PATH"
export SUDO_EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"
export BROWSER="/usr/bin/firefox-developer-edition"
export PAGER="/usr/bin/less"
[ "$TERM" = "xterm-kitty" ]

if [[ -f "$HOME/.cargo/env" ]]; then
	source "$HOME/.cargo/env"	
fi

eval "$(sheldon source)"


ZSH_ATOSUGGEST_STRATEGY=(history completion)

SAVEHIST=1000
HISTFILE=~/.zsh_history

source $HOME/.aliases.zsh
source /etc/profile.d/debuginfod.sh
eval "$(zoxide init --cmd cd zsh)"


export NVM_DIR="/home/hudson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
