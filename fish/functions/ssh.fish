function ssh
	# When using iTerm will attach to the session to a new tab/window
	switch (uname)
	case Darwin
		/usr/bin/ssh -A -t "$argv" "tmux -CC attach || tmux -CC";
	case '*'
		/usr/bin/ssh $argv
	end
end