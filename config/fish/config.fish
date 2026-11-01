if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr --add l 'ls -all'
    abbr --add dv 'cd ~/programming'
    abbr --add nv 'nvim .'
    abbr --add cp 'g++-14 -std=c++2a -O2 -Wall'
    abbr --add cc 'cc -Wall -Wextra -pedantic -std=c99'
    abbr --add dte 'date -u +"%Y-%m-%dT%H:%M:%S%z"'
end
