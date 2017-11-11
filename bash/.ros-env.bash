orange_bg='\[$(tput setab 208)\]'
orange_ft='\[$(tput setaf 208)\]'
grey_bg='\[$(tput setab 246)\]'
grey_ft='\[$(tput setaf 246)\]'
dgrey_bg='\[$(tput setab 235)\]'
dgrey_ft='\[$(tput setaf 235)\]'
black_ft='\[$(tput setaf 235)\]'
reset_clr='\[$(tput sgr0)\]'
bold_ft='\[$(tput bold)\]'
prompt_base="${reset_clr}${dgrey_bg}${grey_ft}${orange_ft} \w${reset_clr}${dgrey_ft}${reset_clr} "

#ROS native
ros() {
    source /opt/ros/kinetic/setup.bash
    export PKG_CONFIG_PATH="/opt/ros/kinetic/lib/pkgconfig:$PKG_CONFIG_PATH"

    source /home/ralino/kamaro/catkin_ws/devel/setup.bash
    #export LIBGL_ALWAYS_SOFTWARE=1
    PS1="\[\e]2;\u@\h:\w - ROS\a\]${grey_bg}${black_ft}${bold_ft}ROS${prompt_base}"
}

#Connect with Beteigeuze
btr() {
    ros
    export ROS_MASTER_URI=http://192.168.1.42:11311
    export ROS_IP=`ip a| sed -En 's/.*inet (addr:)?(192.([0-9]*\.){2}[0-9]*).*/\2/p'` # This forces ROS to identify this computer using its IP instead of the hostname which the robot cannot resolve
    PS1="\[\e]2;\u@\h:\w - BTR\a\]${grey_bg}${black_ft}${bold_ft}BTR${prompt_base}"
}


#ROS2 iboss
iboss() {
    source /home/ralino/ros2_ws/install/local_setup.bash
    source /home/ralino/fzi/iboss_ws/install/local_setup.bash
    alias cd-src="cd /home/ralino/fzi/iboss_ws/src/iboss/"
    alias cd-ws="cd /home/ralino/fzi/iboss_ws/"
    alias pi-connect='~/fzi/iboss_ws/ros2/pi-connect.sh'
    PS1="\[\e]2;\u@\h:\w - iBOSS\a\]${grey_bg}${black_ft}${bold_ft}iBOSS${prompt_base}"
}
