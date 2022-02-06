function findPid
	# Find out the pid of a specified process
	# Note that the command name can be specified via a regex
	# E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
	# Without 'sudo' it will only find processes of the current user
	lsof -t -c "$argv";
end