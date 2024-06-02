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

NEWLINE=$'\n'

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
PR_HOST='%F{red}%M%f' # SSH
else
PR_HOST='%F{magenta}%M%f' # no SSH
fi

local user_host="${PR_USER}%F{green}@${PR_HOST}"
local current_dir="%F{blue}%~%f"
local git_branch='${vcs_info_msg_0_}'

PROMPT="╭─${user_host} ${current_dir} ${git_branch}${NEWLINE}╰─$PR_PROMPT "
}

############################################################
######################## ZSH  EDITS ########################
############################################################

# Setup vim key bindings
bindkey -v
# fix backspace after insert mode
# bindkey -v '^?' backward-delete-char
# # fix delete key
# bindkey "^[[3~" delete-char

# Incase sensitive auto complete
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey -M viins "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey -M viins "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M viins "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M viins '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M viins "${terminfo[kdch1]}" delete-char
else
  bindkey -M viins "^[[3~" delete-char

  bindkey -M viins "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M viins '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M viins '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M viins '^[[1;5D' backward-word


bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey ' ' magic-space                               # [Space] - don't do history expansion


# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word

# disable Ctrl-d
setopt IGNORE_EOF

############################################################
######################## USER EDITS ########################
############################################################

# Shortcuts
alias zsource='source ~/.zshrc'
alias zshell='nvim ~/.zshrc'

# Keep aliases when sudo
alias sudo='sudo '

#color options
alias grep='grep --color=always'
alias ls='ls -G'

# ls options
alias ll='ls -l'
alias la='ls -lA'
alias lr='ls -ltr'

alias nv='nvim'

# zmk
~/.zephyrrc

############################################################
######################### EXPORTS ##########################
############################################################

export VISUAL=nvim
export EDITOR=nvim
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

############################################################
######################## USER FUNCS ########################
############################################################

source "$HOME/.cargo/env"

# Flash qmk firmware to keeb
# qmkFlash () {
#     read -s -k '?Reset Device. Press any key to continue.'$'\n\n'
#     sudo dfu-programmer atmega32u4 erase --force
#     read -s -k '?Flash Device. Press any key to continue.'$'\n\n'
#     sudo dfu-programmer atmega32u4 flash ~/qmk_firmware/.build/crkbd*_grezp.hex
#     read -s -k '?Flash Device. Press any key to continue.'$'\n\n'
#     sudo dfu-programmer atmega32u4 reset
# }

git-merge-branch () { git restore -s $1 -SW -- $2 }
