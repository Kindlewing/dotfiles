# Startup Commands
neofetch


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export PATH="/usr/local/go/bin:$PATH"
export PATH="~/.go/bin/:$PATH"
export PATH="/home/hudson/.local/share/gem/ruby/3.0.0/bin:$PATH"
export PATH="~/Development/flutter/bin:$PATH"
export PATH="~/.android-tools/bin:$PATH"
export SUDO_EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"
export BROWSER="/usr/bin/firefox-developer-edition"
export PAGER="/usr/bin/bat"
export CHARM_HOST="home-server/home-server-charm"

plugins=(git history-substring-search colored-man-pages zsh-autosuggestions z docker zsh-syntax-highlighting)

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_THEME="robbyrussell"

ssh() {
    bash -c "TERM=xterm-256color ssh $@"
}

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases
eval "$(starship init zsh)"
