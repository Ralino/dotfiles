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

alias ros-connect='/home/thomas/rosdocked/connect.sh'

#export PAGER=vimpager
export TERM=xterm-256color
export EDITOR=vim
export COLORTERM=terminator

#Decrease MANWIDTH for correct linebreaks with vimpagers linenumbers
#From the Archwiki: https://wiki.archlinux.org/index.php/Man_page
#man() {
#    local width=$(echo "$(tput cols) - 5" | bc)
    #[ $width -gt $MANWIDTH ] && width=$MANWIDTH
#    env MANWIDTH=$width man "$@"
#}

#xmodmap /home/thomas/.Xmodmap
