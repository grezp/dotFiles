# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=90000
SAVEHIST=180000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename '/Users/pat/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#autoload -Uz promptinit
#promptinit
PS1='%F{blue}%n%f@%F{blue}%m%f: %F{blue}%~%f$ '

# Shortcuts
alias zsource='source ~/.zshrc'
alias zshell='vim ~/.zshrc'

# Keep aliases when sudo
alias sudo='sudo '

#color options
alias grep='grep --color=always'
#alias ls='ls -G'

# ls options
alias ll='ls -lFG'
alias la='ls -lAFG'
alias lr='ls -ltrFG'

#exports
#######################################
#export LANG=en_US.UTF-8
export VISUAL=vim
export EDITOR=vim
export PATH="$PATH:$HOME/.vim/plugged/vim-superman/bin"

# user functions
#######################################
