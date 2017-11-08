#!/bin/bash
#
# Installs the dotfiles

packages="
  gsimplecal           $HOME/.config/gsimplecal
  i3-config            $HOME/.config/i3
  polybar              $HOME/.config/polybar
  termite              $HOME/.config/termite
  tools                /usr/local/bin
  xorg-conf            /etc/X11/xorg.conf.d
  bashrc               $HOME/.bashrc
  i3suspend@.service   /etc/systemd/system/i3suspend@.service
  tmux.conf            $HOME/.tmux.conf
  vimrc                $HOME/.vimrc
  xinitrc              $HOME/.xinitrc
  Xresources           $HOME/.Xresources
  ycm-conf.py          $HOME/.vim/.ycm_extra_conf.py
"

set -- $packages
while [ $# -ge 1 ]; do
  package="$(dirname "$0")/$1"
  target="$2"
  shift 2

  if [ -h $target ] && [ "$(readlink -f $target)" -ef "$package" ]; then
    echo "Target $target is already installed"
    continue
  fi

  if [ -e $target ]; then
    #TODO recursive descent if package and target are directories
    echo "$(tput setaf 1)There already exists a different file at $target$(tput sgr0)"
    continue
  fi

  ln -sr $package $target
  echo "$(tput setaf 2)Installed package $(basename $package)$(tput sgr0)"
done
