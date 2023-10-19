# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Startup Commands
neofetch


export ZSH="$HOME/.zsh"
export ZSH_PLUGINS=$ZSH/plugins/
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

# plugins=(git history-substring-search colored-man-pages zsh-autosuggestions z docker zsh-syntax-highlighting)
ZSH_ATOSUGGEST_STRATEGY=(history completion)

SAVEHIST=1000
HISTFILE=~/.zsh_history

ssh() {
    bash -c "TERM=xterm-256color ssh $@"
}


eval "$(starship init zsh)"
source $HOME/.zsh_aliases

[[ -d $ZSH/antidote ]] || git clone https://github.com/mattmc3/antidote $ZSH/antidote

source $ZSH/antidote/antidote.zsh
antidote load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
