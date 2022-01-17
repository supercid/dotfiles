#!/bin/sh
if ! command -v brew >/dev/null 2>&1; then
	echo 'Brew not installed, attempting installation...'
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if command -v brew >/dev/null 2>&1; then
	brew list | grep -q 'bat' || brew install bat
	brew list | grep -q 'ctop' || brew install ctop
	brew list | grep -q 'dnsmasq' || brew install dnsmasq
	brew tap | grep -q 'moncho/dry' || brew tap moncho/dry
	brew list | grep -q 'dry' || brew install dry
	brew list | grep -q 'powerlevel10k' || brew install romkatv/powerlevel10k/powerlevel10k
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
	brew list | grep -q 'thefuck' || brew install thefuck
	brew list | grep -q 'git-delta' || brew install git-delta
	brew list | grep -q 'hyperfine' || brew install hyperfine
	
	if [ "$(uname -s)" = "Darwin" ]; then
		# Casks are not available on Linux
		brew list | grep -q 'mas' || brew install mas
		brew list --cask iterm2 || brew install --cask iterm2
		brew list --cask sublime-text || brew install --cask sublime-text
		brew list --cask visual-studio-code || brew install --cask visual-studio-code
		brew list --cask alfred || brew install --cask alfred
		brew list --cask mysqlworkbench || brew install --cask mysqlworkbench
		brew list --cask jetbrains-toolbox || brew install --cask jetbrains-toolbox
		brew list --cask docker || brew install --cask docker
		brew list --cask keybase || brew install --cask keybase
		brew list --cask tower || brew install --cask tower
		brew list --cask virtualbox || brew install --cask virtualbox
		brew list --cask little-snitch || brew install --cask little-snitch
		brew list --cask micro-snitch || brew install --cask micro-snitch
		# Internet Browsers
		brew list --cask brave-browser || brew install --cask brave-browser
		brew list --cask firefox || brew install --cask firefox
		brew list --cask google-chrome || brew install --cask google-chrome
		brew list --cask tor-browser || brew install --cask tor-browser
		
		brew list --cask wireshark || brew install --cask wireshark
		brew list --cask ankiapp-anki || brew install --cask ankiapp-anki
		brew list --cask kap || brew install --cask kap # Screen captures
		brew list --cask postman || brew install --cask postman
		brew list --cask vlc || brew install --cask vlc
		brew list --cask telegram || brew install --cask telegram
		brew list --cask slack || brew install --cask slack
		brew list --cask lunar || brew install --cask lunar # Control external display brightness
		brew list --cask spotify || brew install --cask spotify
		brew list --cask the-unarchiver || brew install --cask the-unarchiver
		brew list --cask intel-power-gadget || brew install --cask intel-power-gadget
		brew list --cask sequel-ace || brew install --cask sequel-ace
		brew list --cask rectangle || brew install --cask rectangle


		# Need to be logged into mac app store beforehand
		mas lucky tweetbot
		mas lucky todoist
		mas lucky fantastical
		mas lucky unclutter
		mas lucky spark
		mas lucky "Blackmagic Disk Speed Test"
		mas lucky spark
		mas lucky "WhatsApp Desktop"
		#mas install 426410278 # Flexiglass 1.7.1 - No longer developed
	fi
	
else
	echo 'Could not install Brew, Skipping packages intallation.'
fi
