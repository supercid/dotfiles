#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install bat
else
	echo 'Failed to install bat'
fi