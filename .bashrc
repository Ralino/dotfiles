#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias steam-wine='WINEDEBUG=-all primusrun wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe >/dev/null 2>&1 &'
alias start='setsid'
alias please='sudo $(history -p !-1)'

export PAGER=vimpager
export TERM=terminator
export EDITOR=vim
export COLORTERM=terminator

