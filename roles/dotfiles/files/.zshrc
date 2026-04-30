eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

source <(fzf --zsh)

source /etc/profile.d/debuginfod.sh
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

# PLUGINS!
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export LESS_TERMCAP_mb=$'\e[1;31m'     # blinking text (rare)
export LESS_TERMCAP_md=$'\e[1;31m'     # bold headers in red
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\e[38;5;245m' # standout (highlighted text)
export LESS_TERMCAP_se=$'\e[0m'        # reset standout
export LESS_TERMCAP_us=$'\e[1;33m'     # underline (yellow)
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

export MANPAGER="less -RFX --use-color --mouse -S"
export MANWIDTH=80
export GROFF_NO_SGR=0

export ZSH="$HOME/.zsh"
export ODIN_LIBS="$HOME/.odin"
export ODIN_ROOT="$ODIN_LIBS"
export PATH="/opt/renesas/rfp/linux-x64/:$PATH"
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.odin:$PATH"
export SUDO_EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"
export PAGER="/usr/bin/less"


ZSH_AUTOSUGGEST_STRATEGY=(history completion)

SAVEHIST=1000
HISTFILE=$HOME/.zsh_history


eval "$(zoxide init --cmd cd zsh)"
alias zn='zellij'
alias za='zellij attach'
alias zls='zellij ls'
alias zka='zellij ka'
alias zr='zellij run -- $argv'
alias zrf='zellij run -f -- $argv'
alias ze='zellij edit $argv'
alias grep=rg
alias vim=nvim
alias cat=bat
alias ls='eza -hlX --icons --group-directories-first --color=always'
alias http=xh
