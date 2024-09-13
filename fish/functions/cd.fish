function cd 
	# Always list directory contents upon 'cd'
	builtin cd $argv
	eza -a --long --grid --git --icons
end