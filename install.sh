#!/bin/sh

# Install oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
chsh -s $(which zsh)

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew analytics off
brew update

brew install fortune
brew install cowsay
brew install lolcat
brew install grep
brew install wget
brew install tree
brew install httpie
brew install diff-so-fancy
brew install git
brew install nginx
brew install sqlite
brew install node
brew install yarn
brew install php
brew install postgresql
brew install composer

# Install fonts
brew tap caskroom/fonts
brew cask install font-hack

# Install applications
brew tap homebrew/cask

brew cask install 1password
brew cask install alfred
brew cask install bartender
brew cask install bear
brew cask install coderunner
brew cask install daisydisk
brew cask install dropbox
brew cask install google-chrome
brew cask install insomnia
brew cask install karabiner-elements
brew cask install moom
brew cask install phpstorm
brew cask install slack
brew cask install spotify
brew cask install sublime-text
brew cask install tableplus
brew cask install transmission
brew cask install transmit
brew cask install visual-studio-code
brew cask install vlc
brew cask install zoomus

# Install software from the Mac App Store
brew install mas

mas install 937984704 # Amphetamine
mas install 904280696 # Things

# install pygmentize
sudo easy_install Pygments

# Install global composer packages
/usr/local/bin/composer global require laravel/installer
/usr/local/bin/composer global require laravel/valet
/usr/local/bin/composer global require friendsofphp/php-cs-fixer

# Create a sites directory
mkdir $HOME/Sites