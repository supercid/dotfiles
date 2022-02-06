function myPs
	# List processes owned by my user:
	ps -u "$USER" -o pid,%cpu,%mem,start,time,bsdtime,command;
end