#!/usr/bin/env fish

if contains -- --linux $argv
	# a single unavailable package fails the whole transaction, so CI turns
	# red as soon as a package moves out of the debian repos
	set apt_packages \
		bat dnsmasq fasd fzf jq eza tmux tealdeer speedtest-cli thefuck \
		starship grc gh hyperfine kubectx htop nnn duf ncdu tree-sitter-cli \
		git-delta lazygit gitleaks icdiff netcat-openbsd prettyping ripgrep \
		mosh gnupg unzip ca-certificates

	sudo apt-get update
		or exit 1
	sudo apt-get install -yqq $apt_packages
		or exit 1

	mkdir -p $HOME/.bin
	set -x PATH $HOME/.bin $PATH

	# Debian ships bat as batcat, expose it under its usual name
	if not command -q bat; and command -q batcat
		ln -sf (command -v batcat) $HOME/.bin/bat
	end

	# not packaged by debian, install pinned releases; a moved or renamed
	# release asset makes the download fail and with it the CI
	set yazi_version v0.4.2
	set curlie_version 1.7.2
	set terragrunt_version v0.68.4
	set terraform_version 1.10.5
	set diskonaut_version 0.11.0
	set red_tldr_version 0.4.3
	# debian's neovim is too old for LazyVim (needs >= 0.11.2), use the release
	set nvim_version 0.11.7

	switch (uname -m)
		case aarch64 arm64
			set go_arch arm64
			set rust_triple aarch64-unknown-linux-musl
			set nvim_arch arm64
		case x86_64
			set go_arch amd64
			set rust_triple x86_64-unknown-linux-musl
			set nvim_arch x86_64
		case '*'
			echo "unsupported architecture "(uname -m)
			exit 1
	end

	if not command -q nvim
		curl -sSfLo /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/v$nvim_version/nvim-linux-$nvim_arch.tar.gz
			and rm -rf $HOME/.local/nvim
			and mkdir -p $HOME/.local
			and tar -xzf /tmp/nvim.tar.gz -C $HOME/.local
			and mv $HOME/.local/nvim-linux-$nvim_arch $HOME/.local/nvim
			and ln -sf $HOME/.local/nvim/bin/nvim $HOME/.bin/nvim
			and rm /tmp/nvim.tar.gz
			or exit 1
	end

	if not command -q yazi
		curl -sSfLo /tmp/yazi.zip https://github.com/sxyazi/yazi/releases/download/$yazi_version/yazi-$rust_triple.zip
			and unzip -oq /tmp/yazi.zip -d /tmp/yazi
			and cp /tmp/yazi/yazi-$rust_triple/yazi $HOME/.bin/
			and rm -rf /tmp/yazi.zip /tmp/yazi
			or exit 1
	end

	if not command -q curlie
		curl -sSfL https://github.com/rs/curlie/releases/download/v$curlie_version/curlie_"$curlie_version"_linux_$go_arch.tar.gz | tar -xz -C $HOME/.bin curlie
			or exit 1
	end

	if not command -q terragrunt
		curl -sSfLo $HOME/.bin/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/$terragrunt_version/terragrunt_linux_$go_arch
			and chmod +x $HOME/.bin/terragrunt
			or exit 1
	end

	if not command -q terraform
		curl -sSfLo /tmp/terraform.zip https://releases.hashicorp.com/terraform/$terraform_version/terraform_"$terraform_version"_linux_$go_arch.zip
			and unzip -oq /tmp/terraform.zip terraform -d $HOME/.bin
			and rm /tmp/terraform.zip
			or exit 1
	end

	# diskonaut only publishes x86_64 binaries
	if test (uname -m) = x86_64; and not command -q diskonaut
		curl -sSfL https://github.com/imsnif/diskonaut/releases/download/$diskonaut_version/diskonaut-$diskonaut_version-unknown-linux-musl.tar.gz | tar -xz -C $HOME/.bin diskonaut
			or exit 1
	end

	if not command -q red-tldr
		curl -sSfL https://github.com/Rvn0xsy/red-tldr/releases/download/v$red_tldr_version/red-tldr_"$red_tldr_version"_linux_$go_arch.tar.gz | tar -xz -C $HOME/.bin red-tldr
			or exit 1
	end

	# fail loudly when any expected binary is missing, whatever the reason
	set expected \
		bat fzf jq eza tmux tldr speedtest-cli thefuck starship grc gh \
		hyperfine kubectx htop nnn duf ncdu tree-sitter delta lazygit \
		gitleaks icdiff nc prettyping rg mosh gpg fasd nvim yazi curlie \
		terraform terragrunt red-tldr

	for bin in $expected
		command -q $bin
			or begin
				echo "expected $bin to be installed but it is missing"
				exit 1
			end
	end

	exit 0
end

if type -q brew
	brew list | grep 'bat' >> /dev/null; or brew install bat
	brew list | grep 'dnsmasq' >> /dev/null; or brew install dnsmasq
	brew list | grep 'fasd' >> /dev/null; or brew install fasd
	brew list | grep 'fzf' >> /dev/null; or brew install fzf
	brew list | grep 'jq' >> /dev/null; or brew install jq
	brew list | grep 'eza' >> /dev/null; or brew install eza
	brew list | grep 'tmux' >> /dev/null; or brew install tmux
	brew list | grep 'tlrc' >> /dev/null; or brew install tlrc
	brew list | grep 'speedtest-cli'  >> /dev/null; or brew install speedtest-cli
	brew list | grep 'thefuck' >> /dev/null; or brew install thefuck
	brew list | grep 'starship' >> /dev/null; or brew install starship
	brew list | grep 'grc' >> /dev/null; or brew install grc
	brew list | grep 'gh' >> /dev/null; or brew install gh
	brew list | grep 'neovim' >> /dev/null; or brew install neovim
	brew list | grep 'red-tldr' >> /dev/null; or brew install red-tldr
	brew list | grep 'hyperfine' >> /dev/null; or brew install hyperfine # Benchmarks
	brew list | grep 'kubectx' >> /dev/null; or brew install kubectx
	brew list | grep 'htop' >> /dev/null; or brew install htop
	# File management
	brew list | grep 'yazi' >> /dev/null; or brew install yazi
	brew list | grep 'nnn' >> /dev/null; or brew install nnn
	brew list | grep 'diskonaut' >> /dev/null; or brew install diskonaut
	brew list | grep 'duf' >> /dev/null; or brew install duf
	brew list | grep 'ncdu' >> /dev/null; or brew install ncdu
	brew list | grep 'tree-sitter' >> /dev/null; or brew install tree-sitter
	# Git
	brew list | grep 'git-delta'  >> /dev/null; or brew install git-delta
	brew list | grep 'lazygit' >> /dev/null; or brew install lazygit
	brew list | grep 'gitleaks' >> /dev/null; or brew install gitleaks
	brew list | grep 'icdiff' >> /dev/null; or brew install icdiff
	# Network
	brew list | grep 'curlie' >> /dev/null; or brew install rs/tap/curlie
	brew list | grep 'netcat' >> /dev/null; or brew install netcat
	brew list | grep 'terraform' >> /dev/null; or brew install terraform
	brew list | grep 'terragrunt' >> /dev/null; or brew install terragrunt
	brew list | grep 'prettyping' >> /dev/null; or brew install prettyping
	brew list | grep 'ripgrep' >> /dev/null; or brew install ripgrep
	brew list | grep 'mosh' >> /dev/null; or brew install mosh
	brew list | grep 'gpg' >> /dev/null; or brew install gpg
	
	switch (uname)
		case Darwin
			# Casks are not available on Linux
			brew list | grep 'mas' >> /dev/null; or brew install mas
			brew list | grep 'pinentry-mac' >> /dev/null; or brew install pinentry-mac
			brew list --cask ghostty; or brew install --cask ghostty
			brew list --cask sublime-text; or brew install --cask sublime-text
			brew list --cask alfred; or brew install --cask alfred
			brew list --cask jetbrains-toolbox; or brew install --cask jetbrains-toolbox
			brew list --cask docker; or brew install --cask docker
			brew list --cask tower; or brew install --cask tower
			brew list --cask little-snitch; or brew install --cask little-snitch
			# Internet Browsers
			brew list --cask brave-browser; or brew install --cask brave-browser
			brew list --cask firefox; or brew install --cask firefox
			brew list --cask google-chrome; or brew install --cask google-chrome
			
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
			mas lucky "WhatsApp"
			mas lucky "Velja"
			mas lucky "Pastebot"
		case '*'
			echo "Could not detect OS!" 
	end
	
else
	echo 'Brew not found, skipping packages intallation.'
end
