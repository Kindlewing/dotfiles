eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
source <(fzf --zsh)

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"


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
export ZSH_PLUGINS=$ZSH/plugins
export PATH="/usr/local/go/bin:$PATH"
export PATH="/opt/renesas/rfp/linux-x64/:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
export PATH="$HOME/.odin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="$HOME)/Development/flutter/bin:$PATH"
export PATH="$HOME/.android-tools/bin:$PATH"
export SUDO_EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"
export BROWSER="/usr/bin/firefox-developer-edition"
export PAGER="/usr/bin/less"

export CONFIG="$HOME/.config"
export DOTDIR="$HOME/.dotfiles"

eval "$(sheldon source)"

ZSH_ATOSUGGEST_STRATEGY=(history completion)

SAVEHIST=1000
HISTFILE=$HOME/.zsh_history

source "$HOME/.aliases.zsh"
source /etc/profile.d/debuginfod.sh

eval "$(zoxide init --cmd cd zsh)"


PATH="/home/hudson/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/hudson/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/hudson/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/hudson/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/hudson/perl5"; export PERL_MM_OPT;

# pnpm
export PNPM_HOME="/home/hudson/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
