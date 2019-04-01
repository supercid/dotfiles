#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install tmux
else
	echo 'Failed to install tmux'
fi