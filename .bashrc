#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd
shopt -s checkwinsize

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias steam-wine='WINEDEBUG=-all primusrun wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe >/dev/null 2>&1 &'
alias start='setsid'
alias please='sudo $(history -p !-1)'

alias ros-connect='~/docker/connect.sh'

export PAGER=vimpager
export TERM=xterm-256color
export EDITOR=vim
export COLORTERM=urxvt
