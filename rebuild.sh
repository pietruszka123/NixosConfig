#!/usr/bin/env bash

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

abs_path=$(readlink -f .)

NIX_PATH="$abs_path"

command="switch"
if ! [ -z "$1" ]
  then
    command=$1
fi

echo $command
echo $abs_path

nixos-rebuild switch --flake $NIX_PATH#laptop2 --option eval-cache false
