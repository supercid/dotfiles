#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install jq
else
	echo 'Failed to install jq'
fi