# Ghostty sets TERM=xterm-ghostty, which most remote hosts and containers
# don't have terminfo for. Fall back to xterm-256color when it's missing.
if string match -q '*ghostty*' -- $TERM
	if not infocmp $TERM >/dev/null 2>&1
		set -gx TERM xterm-256color
	end
end
