#!/bin/bash
#
# Installs the dotfiles

packages="
  gsimplecal           $HOME/.config/gsimplecal
  i3-config            $HOME/.config/i3
  polybar              $HOME/.config/polybar
  termite              $HOME/.config/termite
  dunst                $HOME/.config/dunst
  tools                /usr/local/bin
  xorg-conf            /etc/X11/xorg.conf.d
  bash                 $HOME
  i3suspend@.service   /etc/systemd/system/i3suspend@.service
  tmux.conf            $HOME/.tmux.conf
  vimrc                $HOME/.vimrc
  xinitrc              $HOME/.xinitrc
  Xresources           $HOME/.Xresources
  ycm-conf.py          $HOME/.vim/.ycm_extra_conf.py
"

install-package() {
  local file
  local target
  file="$1"
  target="$2"
  if [ -h "$target" ] && [ "$(readlink -f $target)" -ef "$(dirname "$0")/$file" ]; then
    echo "$file is already installed"
    return
  fi

  if [ -e "$target" ] || [ -h "$target" ]; then
    if [ -d "$target" ] && [ -d "$file" ]; then
      for child in $(ls -A $file); do
        install-package "$file/$child" "$target/$child"
      done
    else
      echo "$(tput setaf 1)There already exists a different file at $target$(tput sgr0)"
      return
    fi
  else
    if ! ln -sr $(dirname "$0")/$1 $target; then
      read -e -p "$(tput setaf 1)Failed to link to $target! May I try with root? [Y/n]$(tput sgr0)" choice
      if [[ "$choice" == [Nn]* ]]; then
        return
      fi
      if ! sudo ln -sr $(dirname "$0")/$1 $target; then
        echo "$(tput setaf 1)Failed to link $file!$(tput sgr0)"
        return
      fi
    fi
    echo "$(tput setaf 2)Installed $1$(tput sgr0)"
  fi
}

set -- $packages
while [ $# -ge 1 ]; do
  install-package "$1" "$2"
  shift 2
done
