#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew list | grep -q 'bat' || brew install bat
	brew list | grep -q 'ctop' || brew install ctop
	brew list | grep -q 'dnsmasq' || brew install dnsmasq

	brew tap | grep -q 'moncho/dry' || brew tap moncho/dry
	brew list | grep -q 'dry' || brew install dry

	brew tap | grep -q 'sambadevi/powerlevel9k' || brew tap sambadevi/powerlevel9k
	brew list | grep -q 'powerlevel9k' || brew install powerlevel9k@0.6.7

	brew list | grep -q 'exa' || brew install exa
	brew list | grep -q 'fasd' || brew install fasd
	brew list | grep -q 'fzf' || brew install fzf
	brew list | grep -q 'htop' || brew install htop
	brew list | grep -q 'jq' || brew install jq
	brew list | grep -q 'ncdu' || brew install ncdu
	brew list | grep -q 'tldr' || brew install tldr
	brew list | grep -q 'tmux' || brew install tmux
	brew list | grep -q 'icdiff' || brew install icdiff
	brew list | grep -q 'speedtest-cli' || brew install speedtest-cli
	brew list | grep -q 'diff-so-fancy' || brew install diff-so-fancy
	brew cask list iterm2 || brew cask install iterm2
	brew cask list sublime-text || brew cask install sublime-text
else
	echo 'Brew not installed, Skipping packages intallation.'
fi
