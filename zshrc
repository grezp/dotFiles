# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="grezp"
# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=180
source $ZSH/oh-my-zsh.sh

############################################################
######################## USER EDITS ########################
############################################################

# Setup vim key bindings
bindkey -v

# Shortcuts
alias zsource='source ~/.zshrc'
alias zshell='vim ~/.zshrc'

# Keep aliases when sudo
alias sudo='sudo '

#color options
alias grep='grep --color=always'
alias ls='ls -G'

# ls options
alias ll='ls -lF'
alias la='ls -lAF'
alias lr='ls -ltrF'

#exports
#######################################
export VISUAL=vim
export EDITOR=vim
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="/Users/grezp/Library/Python/3.8/bin:$PATH"

# user functions
#######################################

# Flash qmk firmware to keeb
# qmkFlash () {
#     read -s -k '?Reset Device. Press any key to continue.'$'\n\n'
#     sudo dfu-programmer atmega32u4 erase --force
#     read -s -k '?Flash Device. Press any key to continue.'$'\n\n'
#     sudo dfu-programmer atmega32u4 flash ~/qmk_firmware/.build/crkbd*_grezp.hex
#     read -s -k '?Flash Device. Press any key to continue.'$'\n\n'
#     sudo dfu-programmer atmega32u4 reset
# }
