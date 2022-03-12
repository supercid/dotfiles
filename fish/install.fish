#!/usr/bin/env fish
set -U fish_greeting

# This file hold most of my aliases

#   -----------------------------------------------------
#   Shell
#   -----------------------------------------------------
abbr -a reload! 'exec "$SHELL" -l'

#   -----------------------------------------------------
#   PHP, the greatest language
#   -----------------------------------------------------
abbr -a phpserver "php bin/console server:run"
abbr -a sy "php bin/console"
abbr -a phing "./vendor/bin/phing validate"
abbr -a phan "./vendor/bin/phan --config-file=phan.php --output-mode=checkstyle -p --color"
abbr -a runPhan "composer install --quiet; c; phan; composer install --no-dev --quiet"

#   -----------------------------------------------------
#   Docker
#   -----------------------------------------------------
abbr -a dc "docker-compose"
abbr -a ds "docker-sync"
abbr -a dcdi 'docker rmi -f (docker images | grep "latest" | awk \'{print $3}\')' # Docker clear dangling images
abbr -a dcdiq "docker rmi -f (docker images -f \"dangling=true\" | tr -s ' ' | cut -f3 -d' ')" # Remove dangling images without tags

#   -----------------------------------------------------
#   Magento
#   -----------------------------------------------------
abbr -a m2reset "bin/magento setup:upgrade; bin/magento setup:di:compile; bin/magento setup:static-content:deploy; bin/magento cache:clean"
abbr -a m "bin/magento"

#   -----------------------------------------------------
#   Terminal Navigation & Listing Improvements
#   -----------------------------------------------------
abbr -a cp 'cp -iv'                            # Preferred 'cp' implementation
abbr -a mv 'mv -iv'                            # Preferred 'mv' implementation
abbr -a mkdir 'mkdir -pv'                      # Preferred 'mkdir' implementation
abbr -a l 'exa -a --long --grid --git'         # Preferred 'ls' implementation using exa for colors, grid and git
abbr -a ll 'ls -FGlAhp'                        # Preferred 'ls' implementation
abbr -a less 'less -FSRXc'                     # Preferred 'less' implementation
abbr -a edit '$EDITOR '                        # edit:         Opens any file in default editor
abbr -a f 'open -a Finder ./'                  # f:            Opens current directory in Finder
abbr -a ~ "cd ~"                               # ~:            Go Home
abbr -a c 'clear'                              # c:            Clear terminal display
abbr -a which 'type -a'                        # which:        Find executables
abbr -a fix_stty 'stty sane'                   # fix_stty:     Restore terminal settings when screwed up
abbr -a cic 'set completion-ignore-case On'    # cic:          Make tab-completion case-insensitive
abbr -a DT 'tee ~/Desktop/terminalOut.txt'     # DT:           Pipe content to file on MacOS Desktop
abbr -a cat 'bat'                              # cat with syntax highliting and less (navigate using vi keystrokes)
abbr -a preview "fzf --preview 'bat --color \"always\" {}'"  # Open a nice view to select file and preview on a second pane

#   -----------------------------------------------------
#   File Management
#   -----------------------------------------------------

abbr -a du "ncdu --color dark -rr -x --exclude .git --exclude node_modules" # Overwrite builtin du to use a modern one
abbr -a numFiles 'echo (ls -1 | wc -l)'                                     # Count of non-hidden files in current dir
abbr -a make1mb 'mkfile 1m ./1MB.dat'                                       # Creates a file of 1mb size (all zeros)
abbr -a make5mb 'mkfile 5m ./5MB.dat'                                       # Creates a file of 5mb size (all zeros)
abbr -a make10mb 'mkfile 10m ./10MB.dat'                                    # Creates a file of 10mb size (all zeros)


# Full Recursive Directory Listing
abbr -a lr 'ls -R | grep ":" | sed -e '\''s/://'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   -----------------------------------------------------
#   Searching
#   -----------------------------------------------------
abbr -a qfind "find . -name "                      # Quickly search for file

# Find memory hogs
abbr -a memHogsTop 'top -l 1 -o rsize | head -20'
abbr -a memHogsPs 'ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

# Find CPU hogs
abbr -a cpu_hogs 'ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   -----------------------------------------------------
#   Networking
#   -----------------------------------------------------
abbr -a speedtest "speedtest-cli --secure"          # Check connection speed
abbr -a ping 'prettyping --nolegend'                # PrettyPing instead of builtin ping bin
abbr -a myip 'curl ipinfo.io'                       # Public facing IP Address
abbr -a netCons 'lsof -i'                           # Show all open TCP/IP sockets
abbr -a flushDNS 'dscacheutil -flushcache'          # Flush out the DNS Cache
abbr -a lsock 'sudo /usr/sbin/lsof -i -P'           # Display open sockets
abbr -a lsockU 'sudo /usr/sbin/lsof -nP | grep UDP' # Display only open UDP sockets
abbr -a lsockT 'sudo /usr/sbin/lsof -nP | grep TCP' # Display only open TCP sockets
abbr -a ipInfo0 'ipconfig getpacket en0'            # Get info on connections for en0
abbr -a ipInfo1 'ipconfig getpacket en1'            # Get info on connections for en1
abbr -a openPorts 'sudo lsof -i | grep LISTEN'      # All listening connections
abbr -a showBlocked 'sudo ipfw list'                # All ipfw rules inc/ blocked IPs

#   -----------------------------------------------------
#   Systems Operations & Information
#   -----------------------------------------------------
abbr -a mountReadWrite '/sbin/mount -uw /'                                    # For use when booted into single-user
abbr -a cleanupDS "find . -type f -name '*.DS_Store' -ls -delete"             # Recursively delete .DS_Store files
abbr -a finderShowHidden 'defaults write com.apple.finder ShowAllFiles TRUE'  # Show hidden files in Finder
abbr -a finderHideHidden 'defaults write com.apple.finder ShowAllFiles FALSE' # Hide hidden files in Finder

# Clean up LaunchServices to remove duplicates in the "Open With" menu
abbr -a cleanupLS "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#   -----------------------------------------------------
#   MISC
#   -----------------------------------------------------
abbr -a help "tldr"
abbr -a genpass "LC_ALL=C tr -dc \"[:alpha:][:alnum:]\" < /dev/urandom | head -c 20 | pbcopy"
abbr -a shfmt "docker run --rm -v $PWD:/work tmknom/shfmt" # Shell Formatter

#   -----------------------------------------------------
#   Dual homebrew installation for M1 macs
#   -----------------------------------------------------
abbr -a ibrew "arch -x86_64 /usr/local/bin/brew"
abbr -a mbrew "arch -arm64e /opt/homebrew/bin/brew"
