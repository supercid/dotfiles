#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install tldr
else
	echo 'Failed to install tldr'
fi
