############################################################
######################## CMD PROMPT ########################
############################################################

() {
# Enabling and setting git info var to be used in prompt config.
autoload -Uz vcs_info
# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
FMT_PRE="%F{green}<"
FMT_SUF="%F{green}>"
FMT_STD="%F{green}%b%c%u"
FMT_ACT="%F{green}%b%F{yellow}|%{red}%a%c%u"
FMT_BRA="%b%F{red}:%F{yellow}%r"

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr    "%F{red}*"
zstyle ':vcs_info:*' stagedstr      "%F{yellow}+"
zstyle ':vcs_info:*' actionformats  "${FMT_PRE}${FMT_ACT}${FMT_SUF}%f "
zstyle ':vcs_info:*' formats        "${FMT_PRE}${FMT_STD}${FMT_SUF}%f "
zstyle ':vcs_info:*' nvcsformats    ""
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat  "${FMT_BRA}"
zstyle ':vcs_info:*' enable git cvs svn

precmd() {
    vcs_info
}

# Enable substitution in the prompt.
setopt prompt_subst

local PR_USER PR_PROMPT PR_HOST
# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
PR_USER=' %F{magenta}%n%f'
PR_PROMPT='%f➤ %f'
else # root
PR_USER='%F{red}%n%f'
PR_PROMPT='%F{red}➤ %f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
PR_HOST='%F{red}%M%f' # SSH
else
PR_HOST='%F{magenta}%M%f' # no SSH
fi

local user_host="${PR_USER}%F{green}@${PR_HOST}"
local current_dir="%F{blue}%~%f"
local git_branch='${vcs_info_msg_0_}'

PROMPT="╭─${user_host} ${current_dir} ${git_branch}
╰─$PR_PROMPT "
}

############################################################
######################## ZSH  EDITS ########################
############################################################

# Setup vim key bindings
bindkey -v

# Incase sensitive auto complete
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# bind (up/down keys) to search history based on pattern
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

############################################################
######################## USER EDITS ########################
############################################################

# Shortcuts
alias zsource='source ~/.zshrc'
alias zshell='vim ~/.zshrc'

# Keep aliases when sudo
alias sudo='sudo '

#color options
alias grep='grep --color=always'
alias ls='ls -G'

# ls options
alias ll='ls -l'
alias la='ls -lA'
alias lr='ls -ltr'

############################################################
######################### EXPORTS ##########################
############################################################

export VISUAL=vim
export EDITOR=vim
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="/Users/grezp/Library/Python/3.8/bin:$PATH"

############################################################
######################## USER FUNCS ########################
############################################################

# Flash qmk firmware to keeb
# qmkFlash () {
#     read -s -k '?Reset Device. Press any key to continue.'$'\n\n'
#     sudo dfu-programmer atmega32u4 erase --force
#     read -s -k '?Flash Device. Press any key to continue.'$'\n\n'
#     sudo dfu-programmer atmega32u4 flash ~/qmk_firmware/.build/crkbd*_grezp.hex
#     read -s -k '?Flash Device. Press any key to continue.'$'\n\n'
#     sudo dfu-programmer atmega32u4 reset
# }
