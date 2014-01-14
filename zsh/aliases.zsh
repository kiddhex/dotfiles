# Easier navigation 
alias ..='cd ..'
alias ...='cd ../..' 
alias ....='cd ./../..'
alias sites="cd ~/Sites"

# List files pretty format and colors
alias ls='ls -FHG'
alias la='ls -A'
alias ll='ls -alF'
alias l='ls -CF'
alias history='fc -l 1'

# List only directories
alias lsd='ls -l | grep "^d"' 

# File size
alias fs="stat -f \"%z bytes\""


# ------------------------------------------------------------------------------
# | Miscellaneous                                                              |
# ------------------------------------------------------------------------------

# Super user
alias _='sudo'
alias please='sudo'
alias fucking='sudo'

# Open files in VIM and Sublime Text
alias vi='vim'
alias svi='sudo vim'

# Create new aliases
alias newalias="sublime ~/.zshrc"

alias subl='sublime'
alias sublime="open -a '/Applications/Sublime Text.app'"
alias larafiles="sublime app/controllers; sublime app/models; sublime app/views; sublime app/database; sublime app/routes.php; sublime public"

# Server connection shortcuts                                                
alias tangentlabs='ssh -p 443 root@208.117.43.22 -D 8080'
alias hacemoscodigo='ssh root@hacemoscodigo.com'

# Show Datetime
alias now='date "+%A, %B %d - %H:%M"'


# ------------------------------------------------------------------------------
# | GIT Stuff                                                                  |
# ------------------------------------------------------------------------------

# Undo a git push
alias undopush="git push -f origin HEAD^:master"
alias g="git"

# ------------------------------------------------------------------------------
# | PHP Web Development                                                        |
# ------------------------------------------------------------------------------

alias phplog="tail -f /Applications/MAMP/logs/php_error.log"

# Create documentation for project
# http://www.phpdoc.org/
alias documentor="vendor/phpdocumentor/phpdocumentor/bin/phpdoc.php"

# laravel artisan shortcuts
alias pa="php artisan"
alias routes="php artisan route"
alias mm="php artisan migration:make"
alias cm="php artisan controller:make"


# ------------------------------------------------------------------------------
# | OS X Specific aliases                                                      |
# ------------------------------------------------------------------------------

# Create new virtual host
alias vhost="sublime /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf; sublime /etc/hosts"

# Custom start/stop server scripts
alias startServer="open -gn ~/scripts/startServer.app"
alias stopServer="open -gn ~/scripts/stopServer.app"

# Custom controllers for afplay 
alias playMusic="find ~/Dropbox/Musica -name '*.mp3' -exec afplay --volume 1 '{}' \; &"
alias stopMusic="pgrep -f afplay | xargs kill $1"
alias nextSong="pgrep -f ~/Dropbox/Musica/ | xargs kill $1"

# Show hidden Files in finder
alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'

# Delete all .DS_Store files recursively
alias deleteDS="find . -name '*.DS_Store' -type f -ls -delete"
				

# Xcode Emulation
alias ipad="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"
alias iphone="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"
