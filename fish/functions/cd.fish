function cd 
	# Always list directory contents upon 'cd'
	builtin cd $argv
	exa -a --long --grid --git --icons
end