#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install fzf
else
	echo 'Failed to install fzf'
fi