function ssh
    switch (uname)
    case Darwin
	set -x TERM xterm-256color
	/usr/bin/ssh -t "$argv" '
	    if command -v fish >/dev/null 2>&1; then
		fish -c "if test -z \"\$TMUX\"; tmux attach || tmux new; else; exec fish; end"
	    elif command -v zsh >/dev/null 2>&1; then
		zsh -c "if [ -z \"\$TMUX\" ]; then tmux attach || tmux new; else exec zsh; fi"
	    else
		bash -c "if [ -z \"\$TMUX\" ]; then tmux attach || tmux new; else exec bash; fi"
	    fi'
    case '*'
	/usr/bin/ssh $argv
    end
end
