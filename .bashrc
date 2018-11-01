#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='pure'
#export BASH_IT_THEME='clean'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Load Bash It
source $BASH_IT/bash_it.sh

#----------------------------------My config-----------------------------------#


#-- Shared history
shopt -s histappend
export HISTSIZE=9000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignorespace:erasedups

history() {
    _bash_history_sync
    builtin history "$@"
}

_bash_history_sync() {
    builtin history -a         #[1]
    HISTFILESIZE=$HISTFILESIZE #[2]
    builtin history -c         #[3]
    builtin history -r         #[4]
}

export PROMPT_COMMAND="$PROMPT_COMMAND ; _bash_history_sync"


#-- Search history
# # Remap search forward - default ctrl-s doesn't work
# bind '"\C-t": forward-search-history'


#-- Alias and custom commands
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# mkdir && cd in one command
mkcd() {
    _dir="$*"
    mkdir -p "$_dir" && cd "$_dir"
}

#-- Replaced by GIT_PAGER='less -r' // git config --global core.pager 'less -r'
# # export default less options to have line wrapping with git
# export LESS=-FRX

#-- Editors
export EDITOR=vim

alias evil="emacs -nw"
alias evilc="emacsclient -nw"
alias xevil="emacs"
alias xevilc="emacsclient"
