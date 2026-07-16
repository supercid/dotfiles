function ssh -d "ssh that prepares ghostty terminfo on the remote and auto-attaches tmux"
    # When launched from a Ghostty terminal, route through `ghostty +ssh`. It
    # installs the xterm-ghostty terminfo on the remote (falling back to
    # xterm-256color if tic is unavailable) and forwards COLORTERM/TERM_PROGRAM,
    # fixing the chicken-and-egg where the remote lacks Ghostty's terminfo.
    # Requires Ghostty >= 1.4; harmless everywhere else thanks to the guard.
    if string match -q '*ghostty*' -- $TERM; and type -q ghostty
        set -f ssh_cmd ghostty +ssh --
    else
        set -f ssh_cmd /usr/bin/ssh
    end

    switch (uname)
        case Darwin
            # attach (or create) tmux on the remote so sessions survive drops
            $ssh_cmd -t $argv 'fish -c "
                if test -z \"$TMUX\"
                    tmux attach || tmux new
                else
                    $SHELL
                end"'
        case '*'
            $ssh_cmd $argv
    end
end
