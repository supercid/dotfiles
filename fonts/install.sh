#!/bin/sh
URL="https://github.com/powerline/fonts/archive/2015-12-04.zip"
install() {
	curl -L -s -o /tmp/powerline.zip "$URL"
	unzip -o /tmp/powerline.zip -d /tmp/PowerlineFonts
	cp /tmp/PowerlineFonts/fonts-2015-12-04/*/*.ttf "$1"
}

if [ "$(uname -s)" = "Darwin" ]; then
	install ~/Library/Fonts
else
	mkdir -p ~/.fonts
	install ~/.fonts
fi
