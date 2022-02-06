function ssh
	# When using iTerm will attach to the session to a new tab/window
	/usr/bin/ssh -A -t "$argv" "tmux -CC attach || tmux -CC";
end