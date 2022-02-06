function cd 
	# Always list directory contents upon 'cd'
	builtin cd $argv
	l
end