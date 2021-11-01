#!/bin/sh

FONTS_DIR="~/.local/share/fonts"

nix-env -i home-manager

mkdir -p "$FONTS_DIR"
ln -s "$PWD/home-manager/fonts" "~/.local/share/fonts"
