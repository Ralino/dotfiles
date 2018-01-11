#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Disable Ctrl-S
stty -ixon

#do not put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

#append to history
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s autocd
shopt -s checkwinsize

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

orange_bg='\[$(tput setab 208)\]'
orange_ft='\[$(tput setaf 208)\]'
grey_bg='\[$(tput setab 246)\]'
grey_ft='\[$(tput setaf 246)\]'
dgrey_bg='\[$(tput setab 235)\]'
dgrey_ft='\[$(tput setaf 235)\]'
black_ft='\[$(tput setaf 235)\]'
reset_clr='\[$(tput sgr0)\]'
bold_ft='\[$(tput bold)\]'
#prompt_base="${reset_clr}${orange_ft}${grey_bg} \w${reset_clr}${grey_ft}${reset_clr} "
prompt_base=" \w${reset_clr}${dgrey_ft}${reset_clr} "
PS1="${grey_bg}${black_ft}\h${dgrey_bg}${grey_ft}${orange_ft}${prompt_base}"
PROMPT_DIRTRIM=2

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=normal "$([ $? = 0 ] && echo Finished || echo Failed)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias start='setsid'
alias please='sudo $(history -p !-1)'
alias gits='git status'
alias nspawn='sudo nspawn'
alias con='sudo nspawn'
alias pacaur='echo "R.I.P pacaur :("; trizen'

bind -x '"\C-f": "/usr/bin/ranger"'

export TERM=xterm-termite
export EDITOR=vim
export COLORTERM=xterm-termite
