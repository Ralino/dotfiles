#!/bin/bash

build_path="/home/ralino/documents/github/i3-workspace-namer/build"
log_path="$build_path/../logs/$(date +%F-%T).log"

sleep 0.5
if $(pgrep -x "i3-workspace-namer"); then
  echo "Instance already running, killing!"
  killall i3-workspace-namer
fi

$build_path/i3-workspace-namer $build_path/../config.json | tee $log_path
