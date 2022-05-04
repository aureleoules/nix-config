#!/bin/sh

FONTS_DIR="/home/aureleoules/.local/share/fonts"

# nix-env -i home-manager

mkdir -p $FONTS_DIR
ln -s "$PWD/home-manager/fonts" "/home/aureleoules/.local/share/fonts"
