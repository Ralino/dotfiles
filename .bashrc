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
#PS1='[\u@\h \W]\$ '

orange_bg='\[$(tput setab 192)\]'
orange_ft='\[$(tput setaf 192)\]'
grey_bg='\[$(tput setab 238)\]'
grey_ft='\[$(tput setaf 238)\]'
black_ft='\[$(tput setaf 232)\]'
reset_clr='\[$(tput sgr0)\]'
bold_ft='\[$(tput bold)\]'
prompt_base="${reset_clr}${orange_ft}${grey_bg} \w${reset_clr}${grey_ft}${reset_clr} "
PS1="${orange_bg}${black_ft}\h${prompt_base}"
PROMPT_DIRTRIM=2

alias steam-wine='WINEDEBUG=-all primusrun wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe >/dev/null 2>&1 &'
alias start='setsid'
alias please='sudo $(history -p !-1)'

alias ros-connect='~/docker/connect.sh'

#ROS native
ros() {
    source /opt/ros/kinetic/setup.bash
    export PYTHONPATH="/opt/ros/kinetic/lib/python2.7/site-packages:$PYTHONPATH"
    export PKG_CONFIG_PATH="/opt/ros/kinetic/lib/pkgconfig:$PKG_CONFIG_PATH"

    alias catkin_make="catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python2 -DPYTHON_INCLUDE_DIR=/usr/include/python2.7 -DPYTHON_LIBRARY=/usr/lib/libpython2.7.so"
    source /home/ralino/kamaro/catkin_ws/devel/setup.bash
    export LIBGL_ALWAYS_SOFTWARE=1
    cd /home/ralino/kamaro/catkin_ws/
    PS1="\[\e]2;\u@\h:\w - ROS\a\]${orange_bg}${black_ft}${bold_ft}ROS${prompt_base}"
    export PATH=~/kamaro/python2-dummy:$PATH
}

function btr() {
    ros
    export ROS_MASTER_URI=http://192.168.1.42:11311
    export ROS_IP=`ip a| sed -En 's/.*inet (addr:)?(192.([0-9]*\.){2}[0-9]*).*/\2/p'` # This forces ROS to identify this computer using its IP instead of the hostname which the robot cannot resolve
    PS1="\[\e]2;\u@\h:\w - BTR\a\]${orange_bg}${black_ft}${bold_ft}BTR${prompt_base}"
}


#ROS2 iboss
iboss() {
    source /home/ralino/ros2_ws/install/local_setup.bash
    source /home/ralino/fzi_job/iboss_ws/install/local_setup.bash
    cd /home/ralino/fzi_job/iboss_ws/
    PS1="\[\e]2;\u@\h:\w - iBOSS\a\]${orange_bg}${black_ft}${bold_ft}iBOSS${prompt_base}"
}

alias cd-scheduling='cd /home/ralino/fzi_job/iboss_ws/src/iboss/iboss_scheduling_node/'

alias ros-clion='ros && clion'
alias iboss-clion='iboss && clion'

export PAGER=vimpager
export TERM=xterm-256color
export EDITOR=vim
export COLORTERM=urxvt
