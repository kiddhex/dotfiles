# Create new file(s) change permissions and open in Sublime Text
function create() {
    if [ $# -eq 0 ]; then
       echo "usage: create filename [filename [filename [...]]]"
    else
        touch $@; chmod 755 $@; subl $@
    fi
}

# Create new directory and cd into it
function mkd() {
    if [ $# -eq 0 ]; then
        echo "usage: mkd directory [directory [directory [...]]]"
    else
        mkdir -p "$@" && cd "$_";
    fi
}

# Filter processes with keyword
function showps() {
    ps -A | grep -v 'grep' | grep -i "$@"
}

# Get colors in manual pages
function man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m")    \
    LESS_TERMCAP_md=$(printf "\e[1;31m")    \
    LESS_TERMCAP_me=$(printf "\e[0m")       \
    LESS_TERMCAP_se=$(printf "\e[0m")       \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m")       \
    LESS_TERMCAP_us=$(printf "\e[1;32m")    \
    man "$@"
}

# Start a PHP server from a directory, optionally specifying the port (Requires PHP >= 5.4)
function phpserver() {
    local port="${1:-4000}";
    sleep 1 && open "http://localhost:${port}/" & php -S "localhost:${port}";
}

# Show laravel routes
function routes() {
    if [ $# -eq 0 ]; then
        php artisan route:list
    else
        php artisan route:list | grep ${1}
    fi
}

# Shorthand for tree with hidden files and ignoring common vendors
# The output gets piped into less
function tre() {
    tree -aC -I '.git|vendor|node_modules|bower_components' --dirsfirst "$@" | less -FRX;
}

# Create a simple scafold to build a test application.
function scafold() {
    if [ -d $1 ] ; then
        echo "scafold: '$1': Directory exists"
    else
        mkdir -p $1 & cd $1;
        mkdir js css;
        touch index.html js/main.js css/style.css;
        sudo chmod -R 775 ./
    fi
}

# Extract archives based on the extension
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1   ;;
            *.tar.gz)  tar xvzf $1   ;;
            *.bz2)     bunzip2 $1    ;;
            *.rar)     unrar x $1    ;;
            *.gz)      gunzip $1     ;;
            *.tar)     tar xvf $1    ;;
            *.tbz2)    tar xvjf $1   ;;
            *.tgz)     tar xvzf $1   ;;
            *.zip)     unzip $1      ;;
            *.Z)       uncompress $1 ;;
            *.7z)      7z x $1       ;;
            *)         echo "don't know how to extract '$1'..." ;;
        esac
    else
       echo "'$1' is not a valid file!"
    fi
}

# Create a python files with __init__.py and tests
function pytouch {

    for dir in 'src' 'test'
    do
        if ! [ -d $dir ] ; then
            mkdir $dir
            touch $dir/__init__.py
        fi
    done

    if ! [ -f __init__.py ] ; then
        touch __init__.py
    fi

    for file in $@
    do
        if ! [ -f src/$file ] ; then
            echo "#! /usr/bin/env python" >> src/$file
            echo "# -*- coding: utf-8 -*-\n" >> src/$file
            echo "from __future__ import unicode_literals" >> src/$file
        else
            echo "pytouch: 'src/$file': File already exists"
        fi

        if ! [ -f test/test_$file ] ; then
            echo "#! /usr/bin/env python" >> test/test_$file
            echo "# -*- coding: utf-8 -*-\n" >> test/test_$file
            echo "from __future__ import unicode_literals" >> test/test_$file
            echo "import unittest" >> test/test_$file
        fi
    done

    sudo chmod -R 775 ./
}

# Start new projects using SASS, ES6 and Browserify with Gulp
function web-start() {
    if [ $# -eq 0 ]; then
        echo 'usage: web-start name'
    fi

    if ! [ -d $1 ]; then
        git clone git@github.com:scrubmx/web-starter.git $1
        cd $1
        sudo npm install
        gulp & python -m SimpleHTTPServer 8000
    else
        echo "web-start: '$1': Directory already exists"
    fi
}

# Control a local PostgreSQL server on Mac OSX
function pg () {
    local datadir="$HOME/Library/Application Support/Postgres/var-9.4"
    local logfile="/usr/local/var/postgres/server.log"

    case $1 in
        ('start' | 'stop' | 'restart' | 'reload' | 'status')
            pg_ctl $1 --pgdata $datadir --log $logfile ;;
        ('console')
            psql --port 5432 ;;
        (*)
            echo 'usage: pg option'
    esac
}

# Handy function to start a productive day of work
# Optional [-v] to start the homestead virtual machine
function work() {
    open -a '/Applications/Google Chrome.app' \
        https://github.com \
        https://trello.com \
        https://laravel.com/docs

    open -a /Applications/Mail.app
    open -a /Applications/Spotify.app
    open -a /Applications/PhpStorm.app

    while getopts "$@" option; do
        if [ "$option" = "v" ]; then
            cd ~/.composer/vendor/laravel/homestead && vagrant up
            cd -
        fi
    done
}

# https://github.com/taylorotwell/zap/blob/master/zap.sh
function zap() {
    USAGE="Usage: zap [remember|to|forget|locations] [bookmark]" ;
    if  [ ! -e ~/.bookmarks ] ; then
        mkdir ~/.bookmarks
    fi

    case $1 in
        # create bookmark
        remember) shift
            if [ ! -f ~/.bookmarks/$1 ] ; then
                echo "cd `pwd`" > ~/.bookmarks/"$1" ;
                echo "OK, I'll remember it." ;
            else
                echo "There is already a bookmark named '$1'."
            fi
            ;;
        # goto bookmark
        to) shift
            if [ -f ~/.bookmarks/$1 ] ; then
                source ~/.bookmarks/"$1"
            else
                echo "This bookmark's location has been lost to the void." ;
            fi
            ;;
        # delete bookmark
        forget) shift
            if [ -f ~/.bookmarks/$1 ] ; then
                rm ~/.bookmarks/"$1" ;
                echo "The '$1' bookmark has been forgotten." ;
            else
                echo "I can't find a bookmark with that name." ;
            fi
            ;;
        # list bookmarks
        locations) shift
            ls -l ~/.bookmarks/ ;
            ;;
         *) echo "$USAGE" ;
            ;;
    esac
}

# Accessing homestead globally
function hs() {
    cd ~/.composer/vendor/laravel/homestead

    command="$1"

    if [ "$command" = "edit" ]; then
        subl ~/.homestead/Homestead.yaml
    else
        if [ -z "$command" ]; then
           command="ssh"
        fi

        if [ "$command" = "down" ]; then
           command="halt"
        fi

        vagrant "$command"
    fi

    cd -
}

# Apache Tomcat functions
function tomcatup() { 
    /usr/local/tomcat/bin/startup.sh
}

function tomcatdown() { 
    /usr/local/tomcat/bin/shutdown.sh
}

# Open the current git repository in the browser
function github() {
    if [ ! -d .git ]; then
        echo "ERROR: This isnt a git directory" && exit 1;
    fi

    local option="${1:-NA}"
    local remote=$(git config --get remote.origin.url)
    local github_url github_help

    read -r -d '' github_help<<EOF
github opens the current git repository in the browser.

Usage:
  github [options]

Options:
  -b, --branch        open repository on the current branch
  -c, --commit        open repository current commit
  -d, --diff          open a diff with two commits or refs [default: "develop", "master"]
  -p, --pulls         open the pull requests page
  -s, --settings      open settings page for the project
  -w, --wiki          open wiki page for the project
EOF

    if [[ $remote != *github* ]]; then
        echo "ERROR: Remote origin is invalid" && exit 1;
    fi

    github_url="${remote%.git}" # remove ".git" suffix

    if [[ $github_url =~ git@github.com:* ]]; then
        # remove "git@github.com:" prefix
        github_url="https://github.com/${github_url#*:}"
    fi

    case "$option" in
        '-b' | '--branch' ) option="/tree/$(git rev-parse --abbrev-ref HEAD)" ;;
        '-c' | '--commit' ) option="/tree/$(git rev-parse HEAD)" ;;
        '-d' | '--diff' ) option="/compare/${2:-develop}...${3:-master}" ;;
        '-h' | '--help' ) echo $github_help && return ;;
        '-p' | '--pulls' ) option="/pulls" ;;
        '-s' | '--settings' ) option="/settings" ;;
        '-w' | '--wiki' ) option="/wiki" ;;
        'NA' | *) option="" ;;
    esac

    open -a '/Applications/Google Chrome.app' "$github_url$option"
}

