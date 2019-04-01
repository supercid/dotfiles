#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install htop
else
	echo 'Failed to install htop'
fi