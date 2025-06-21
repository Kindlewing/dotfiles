eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
source <(fzf --zsh)

export ZSH="$HOME/.zsh"
export ODIN_LIBS="$HOME/.odin"
export ZSH_PLUGINS=$ZSH/plugins
export PATH="/usr/local/go/bin:$PATH"
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
