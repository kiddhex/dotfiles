# Path to your oh-my-zsh configuration.
ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="custom"

# Load ~/.aliases and ~/.functions
for file in ~/.{aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=15

# Add custom directories to the PATH variable
local PHP7="/usr/local/opt/php70/bin"
local GOLANG="/usr/local/go/bin"
local COMPOSER="~/.composer/vendor/bin:./vendor/bin"
local MYSQL="/usr/local/mysql/bin"
local POSTGRES="/usr/local/postgres/bin"
local RVM="~/.rvm/bin"

export PATH="$PHP7:$COMPOSER:$GOLANG:$MYSQL:$POSTGRES:$RVM:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Add other environment variables for user scripts
export DIGITALOCEAN_SECRET_KEY="SomeRandomString"
export COMPOSER_DISABLE_XDEBUG_WARN=1
export GOPATH="$HOME/Code/Golang"
export PYTHONSTARTUP="$HOME/.pythonrc"

# Change default text editor from vi to sublime text
export EDITOR="subl -w"

# Fix the nasty fluorescent green the directory problem.
# http://forums.fedoraforum.org/showthread.php?t=169528 user:buddha
export LS_COLORS="${LS_COLORS}tw=30;47:ow=34;47:"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git composer laravel5 npm ruby rvm rails)

# Tracks your most used directories, based on 'frecency'
# source https://github.com/rupa/z
if [ -f "$HOME/rupa/z.sh" ]; then
    source "$HOME/rupa/z.sh"
fi

source "$ZSH/oh-my-zsh.sh"
