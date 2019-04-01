#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install fasd
else
	echo 'Failed to install fasd'
fi