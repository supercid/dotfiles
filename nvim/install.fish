#!/usr/bin/env fish

# ~/.config/nvim is symlinked to this repo's nvim/config by script/bootstrap.fish,
# so the LazyVim config is versioned here. This installer bootstraps LazyVim
# headlessly. LazyVim's full plugin tree only resolves after lazy.nvim and the
# LazyVim repo are on disk (a second pass), so a one-shot headless install runs
# long; the whole run is time-bounded and the rest installs on first real launch.
# What matters here is that the two core repos clone — if GitHub or either repo
# moved, they won't, and the bootstrap fails.

if not command -q nvim
	echo 'neovim not found, skipping LazyVim plugin install'
	exit 0
end

# timeout is coreutils, present on linux but not on stock macOS
set -l rc 0
if type -q timeout
	timeout 180 nvim --headless "+Lazy! install" +qa
	set rc $status
else
	nvim --headless "+Lazy! install" +qa
	set rc $status
end

# 124 means a slow build step ran out of time, which is fine. Any other non-zero
# is a real failure — a plugin repo that moved or is unreachable — and must fail
# the bootstrap so CI catches it.
if test $rc -ne 0; and test $rc -ne 124
	echo "LazyVim install failed (nvim exited $rc)"
	exit 1
end

# the core plugins must have cloned, otherwise resolution genuinely failed
test -d ~/.local/share/nvim/lazy/lazy.nvim
	and test -d ~/.local/share/nvim/lazy/LazyVim
	or begin
		echo 'LazyVim core plugins are missing after install'
		exit 1
	end
