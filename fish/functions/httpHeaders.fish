function httpHeaders
	# Grabs headers from web page
	/usr/bin/curl -I -L "$argv";
end