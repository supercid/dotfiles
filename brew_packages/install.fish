#!/usr/bin/env fish

if type -q brew
	brew list | grep 'bat' >> /dev/null; or brew install bat
	brew list | grep 'ctop' >> /dev/null; or brew install ctop
	brew list | grep 'dnsmasq' >> /dev/null; or brew install dnsmasq
	brew tap  | grep 'moncho/dry' >> /dev/null; or brew tap moncho/dry
	brew list | grep 'dry' >> /dev/null; or brew install dry
	brew list | grep 'eza' >> /dev/null; or brew install eza
	brew list | grep 'fasd' >> /dev/null; or brew install fasd
	brew list | grep 'fzf' >> /dev/null; or brew install fzf
	brew list | grep 'htop' >> /dev/null; or brew install htop
	brew list | grep 'jq' >> /dev/null; or brew install jq
	brew list | grep 'ncdu' >> /dev/null; or brew install ncdu
	brew list | grep 'tldr' >> /dev/null; or brew install tldr
	brew list | grep 'tmux' >> /dev/null; or brew install tmux
	brew list | grep 'icdiff' >> /dev/null; or brew install icdiff
	brew list | grep 'speedtest-cli'  >> /dev/null; or brew install speedtest-cli
	brew list | grep 'thefuck' >> /dev/null; or brew install thefuck
	brew list | grep 'git-delta'  >> /dev/null; or brew install git-delta
	brew list | grep 'hyperfine' >> /dev/null; or brew install hyperfine
	brew list | grep 'curlie' >> /dev/null; or brew install rs/tap/curlie
	brew list | grep 'hyperfine' >> /dev/null; or brew install hyperfine
	brew list | grep 'starship' >> /dev/null; or brew install starship
	brew list | grep 'kubectx' >> /dev/null; or brew install kubectx
	brew list | grep 'grc' >> /dev/null; or brew install grc
	brew list | grep 'gh' >> /dev/null; or brew install gh
	brew list | grep 'yazi' >> /dev/null; or brew install yazi
	brew list | grep 'nnn' >> /dev/null; or brew install nnn
	brew list | grep 'diskonaut' >> /dev/null; or brew install diskonaut
	brew list | grep 'duf' >> /dev/null; or brew install duf
	brew list | grep 'gitleaks' >> /dev/null; or brew install gitleaks
	brew list | grep 'lazygit' >> /dev/null; or brew install lazygit
	brew list | grep 'netcat' >> /dev/null; or brew install netcat
	brew list | grep 'terraform' >> /dev/null; or brew install terraform
	brew list | grep 'terragrunt' >> /dev/null; or brew install terragrunt
	brew list | grep 'tree-sitter' >> /dev/null; or brew install tree-sitter
	brew list | grep 'prettyping' >> /dev/null; or brew install prettyping
	brew list | grep 'ripgrep' >> /dev/null; or brew install ripgrep
	brew list | grep 'mosh' >> /dev/null; or brew install mosh
	
	switch (uname)
		case Darwin
			# Casks are not available on Linux
			brew list | grep 'mas' >> /dev/null; or brew install mas
			brew list --cask ghostty; or brew install --cask ghostty
			brew list --cask sublime-text; or brew install --cask sublime-text
			brew list --cask visual-studio-code; or brew install --cask visual-studio-code
			brew list --cask alfred; or brew install --cask alfred
			brew list --cask mysqlworkbench; or brew install --cask mysqlworkbench
			brew list --cask jetbrains-toolbox; or brew install --cask jetbrains-toolbox
			brew list --cask docker; or brew install --cask docker
			brew list --cask tower; or brew install --cask tower
			brew list --cask virtualbox; or brew install --cask virtualbox
			brew list --cask little-snitch; or brew install --cask little-snitch
			# Internet Browsers
			brew list --cask brave-browser; or brew install --cask brave-browser
			brew list --cask firefox; or brew install --cask firefox
			brew list --cask google-chrome; or brew install --cask google-chrome
			brew list --cask tor-browser; or brew install --cask tor-browser
			
			brew list --cask wireshark; or brew install --cask wireshark
			brew list --cask ankiapp-anki; or brew install --cask ankiapp-anki
			brew list --cask kap; or brew install --cask kap # Screen captures
			brew list --cask postman; or brew install --cask postman
			brew list --cask vlc; or brew install --cask vlc
			brew list --cask telegram; or brew install --cask telegram
			brew list --cask slack; or brew install --cask slack
			brew list --cask lunar; or brew install --cask lunar # Control external display brightness
			brew list --cask spotify; or brew install --cask spotify
			brew list --cask the-unarchiver; or brew install --cask the-unarchiver
			brew list --cask sequel-ace; or brew install --cask sequel-ace
			brew list --cask rectangle; or brew install --cask rectangle

			# Need to be logged into mac app store beforehand
			mas lucky todoist
			mas lucky fantastical
			mas lucky unclutter
			mas lucky spark
			mas lucky "Blackmagic Disk Speed Test"
			mas lucky "WhatsApp Desktop"
		case '*'
			echo "Could not detect OS!" 
	end
	
else
	echo 'Brew not found, skipping packages intallation.'
end
