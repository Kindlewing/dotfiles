# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.zsh"
export ZSH_PLUGINS=$ZSH/plugins
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

ZSH_ATOSUGGEST_STRATEGY=(history completion)

SAVEHIST=1000
HISTFILE=~/.zsh_history

if [[ ! -d "$ZSH" ]]; then
    mkdir -p "~/.zsh/plugins"
fi

if [[ ! -d "$ZSH_PLUGINS/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_PLUGINS/powerlevel10k
fi

if [[ ! -d "$ZSH_PLUGINS/zsh-autosuggestions" ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH_PLUGINS/zsh-autosuggestions
fi

if [[ ! -d "$ZSH_PLUGINS/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGINS/zsh-syntax-highlighting
fi

if [[ ! -f "$ZSH_PLUGINS/catppuccin_syntax_highlighting.zsh" ]]; then
    curl -qo $ZSH_PLUGINS/catppuccin_syntax_highlighting.zsh https://gist.githubusercontent.com/Kindlewing/b47c566bc588cf6644f0ca650eb939b5/raw/c5023459ed755c7f0792e3ff3fd1507c1a37199e/catppuccin_syntax_highlighting.zsh
fi


source $ZSH_PLUGINS/powerlevel10k/powerlevel10k.zsh-theme
source $ZSH_PLUGINS/catppuccin_syntax_highlighting.zsh
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh

source $HOME/.zsh_aliases
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
