#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install dnsmasq
else
	echo 'Failed to install dnsmasq'
fi