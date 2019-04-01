#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install ctop
else
	echo 'Failed to install ctop'
fi