function ssh
    switch (uname)
    case Darwin
		set -x TERM xterm-256color
	    /usr/bin/ssh -t "$argv" 'fish -c "
		    if test -z \"$TMUX\"
		        tmux attach || tmux new
		    else
		        $SHELL
		    end"'
    case '*'
	/usr/bin/ssh $argv
    end
end
