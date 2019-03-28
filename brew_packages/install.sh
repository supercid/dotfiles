#!/bin/sh

# Reinstall all of my brew formulae
xargs brew tap < $DOTFILES/brew_packages/tap_list.txt
xargs brew install < $DOTFILES/brew_packages/brew_packages.txt