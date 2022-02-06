function spotlight 
	# Search for a file using MacOS Spotlight's metadata
	mdfind "kMDItemDisplayName == '$argv'wc";
end