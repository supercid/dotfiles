#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew tap | grep -q 'moncho/dry' || brew tap moncho/dry
	brew install dry
else
	echo 'Failed to install dry'
fi