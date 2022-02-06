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
abbr -a dcdi 'docker rmi -f (docker images | grep "^<none>" | awk "{print $argv[3]}")'         # Docker clear dangling images
abbr -a dcdiq "docker rmi -f (docker images -f \"dangling=true\" | tr -s ' ' | cut -f3 -d' ')" # Remove dangling images without tags


#   -----------------------------------------------------
#   Magento
#   -----------------------------------------------------
abbr -a m2reset "bin/magento setup:upgrade; bin/magento setup:di:compile; bin/magento setup:static-content:deploy; bin/magento cache:clean"
abbr -a m "bin/magento"

#   -----------------------------------------------------
#   Terminal Navigation & Listing Improvements
#   -----------------------------------------------------
abbr -a cp 'cp -iv'                         # Preferred 'cp' implementation
abbr -a mv 'mv -iv'                         # Preferred 'mv' implementation
abbr -a mkdir 'mkdir -pv'                   # Preferred 'mkdir' implementation
abbr -a l 'exa -a --long --grid --git'      # Preferred 'ls' implementation using exa for colors, grid and git
abbr -a ll 'ls -FGlAhp'                     # Preferred 'ls' implementation
abbr -a less 'less -FSRXc'                  # Preferred 'less' implementation

function cd 
	# Always list directory contents upon 'cd'
	builtin cd $argv
	l
end 

abbr -a cd .='cd ../'                       # Go back 1 directory level
abbr -a ..='cd ../'                         # Go back 1 directory level
abbr -a ...='cd ../../'                     # Go back 2 directory levels
abbr -a .3 'cd ../../../'                   # Go back 3 directory levels
abbr -a .4 'cd ../../../../'                # Go back 4 directory levels
abbr -a .5 'cd ../../../../../'             # Go back 5 directory levels
abbr -a .6 'cd ../../../../../../'          # Go back 6 directory levels
abbr -a edit '$EDITOR '                     # edit:         Opens any file in default editor
abbr -a f 'open -a Finder ./'               # f:            Opens current directory in Finder
abbr -a ~="cd ~"                            # ~:            Go Home
abbr -a c 'clear'                           # c:            Clear terminal display
abbr -a which 'type -a'                     # which:        Find executables
abbr -a fix_stty 'stty sane'                # fix_stty:     Restore terminal settings when screwed up
abbr -a cic 'set completion-ignore-case On' # cic:          Make tab-completion case-insensitive

function mcd # Makes new Dir and jumps inside
	mkdir -p $argv && cd $argv; 
end

function trash # Moves a file to the MacOS trash
	command mv $argv ~/.Trash;
end

abbr -a DT 'tee ~/Desktop/terminalOut.txt'     # DT:           Pipe content to file on MacOS Desktop
abbr -a cat 'bat'                              # cat with syntax highliting and less (navigate using vi keystrokes)

abbr -a preview "fzf --preview 'bat --color \"always\" {}'"  # Open a nice view to select file and preview on a second pane

#   -----------------------------------------------------
#   File Management
#   -----------------------------------------------------
function zipf # Create a ZIP archive of a folder
	zip -r $argv.zip $argv;
end

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
function ff 
	# Find file under the current directory
	/usr/bin/find . -name "$argv";
end

function ffs 
	# Find file whose name starts with a given string
	/usr/bin/find . -name "$argv"'*';
end

function ffe 
	# Find file whose name ends with a given string
	/usr/bin/find . -name '*'"$argv"; 
end


function spotlight 
	# Search for a file using MacOS Spotlight's metadata
	mdfind "kMDItemDisplayName == '$argv'wc";
end

#   -----------------------------------------------------
#   Process Management
#   -----------------------------------------------------

function findPid
	# Find out the pid of a specified process
	# Note that the command name can be specified via a regex
	# E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
	# Without 'sudo' it will only find processes of the current user
	lsof -t -c "$argv";
end

# Find memory hogs
abbr -a memHogsTop 'top -l 1 -o rsize | head -20'
abbr -a memHogsPs 'ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

# Find CPU hogs
abbr -a cpu_hogs 'ps wwaxr -o pid,stat,%cpu,time,command | head -10'

function my_ps
	# List processes owned by my user:
	ps -u "$USER" -o pid,%cpu,%mem,start,time,bsdtime,command;
end

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


function ssh
	# When using iTerm will attach to the session to a new tab/window
	/usr/bin/ssh -A -t "$argv" "tmux -CC attach || tmux -CC";
end

#   -----------------------------------------------------
#   Systems Operations & Information
#   -----------------------------------------------------
abbr -a mountReadWrite '/sbin/mount -uw /'                                    # For use when booted into single-user
abbr -a cleanupDS "find . -type f -name '*.DS_Store' -ls -delete"             # Recursively delete .DS_Store files
abbr -a finderShowHidden 'defaults write com.apple.finder ShowAllFiles TRUE'  # Show hidden files in Finder
abbr -a finderHideHidden 'defaults write com.apple.finder ShowAllFiles FALSE' # Hide hidden files in Finder

# Clean up LaunchServices to remove duplicates in the "Open With" menu
abbr -a cleanupLS "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#   ---------------------------------------
#   Web
#   ---------------------------------------
function httpHeaders
	# Grabs headers from web page
	/usr/bin/curl -I -L "$argv";
 end

# Download a web page and show info on what took time
function httpDebug 
	/usr/bin/curl "$argv" -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n";
end

#   -----------------------------------------------------
#   MISC
#   -----------------------------------------------------
abbr -a help "tldr"
abbr -a genpass "LC_ALL=C tr -dc \"[:alpha:][:alnum:]\" < /dev/urandom | head -c 20 | pbcopy"
abbr -a shfmt "docker run --rm -v $PWD:/work tmknom/shfmt" # Shell Formatter
eval (thefuck --alias)
