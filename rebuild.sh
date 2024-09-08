#!/usr/bin/env bash

abs_path=$(readlink -f .)

NIX_PATH="$abs_path"

command="switch"
if ! [ -z "$1" ]
  then
    command=$1
fi

echo $command
echo $abs_path

nixos-rebuild switch --flake $NIX_PATH#pc --option eval-cache false
