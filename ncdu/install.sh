#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install ncdu
else
	echo 'Failed to install ncdu'
fi
