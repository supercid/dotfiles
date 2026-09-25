#!/usr/bin/env fish
set -Ux EDITOR vim
set -Ux VISUAL $EDITOR
set -Ux WEDITOR code

set -Ux DOTFILES ~/.dotfiles
set -Ux dotfiles $DOTFILES
set -Ux PROJECTS ~/Developer

for p in $DOTFILES/bin $HOME/.bin
	contains $p $fish_user_paths
		or set -Ua fish_user_paths $p
end

# functions and conf.d files are symlinked into ~/.config/fish by script/bootstrap.fish

if test -f ~/.localrc.fish
	ln -sf ~/.localrc.fish ~/.config/fish/conf.d/localrc.fish
end