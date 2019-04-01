#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install exa
else
	echo 'Failed to install exa'
fi