#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew cask install iterm2
else
	echo 'Failed to install iTerm2'
fi

[ "$(uname -s)" != "Darwin" ] && exit 0
sed "s;/Users/carlos;$HOME;g" \
	"$DOTFILES"/iterm/com.googlecode.iterm2.plist.example >"$DOTFILES"/iterm/com.googlecode.iterm2.plist
defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "$DOTFILES/iterm"
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true
