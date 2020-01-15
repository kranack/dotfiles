#!/bin/bash

set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately

usage() { echo "Usage: $0 [-bdhu]" 1>&2; exit 1; }

args=`getopt bdhu "$*"`

set -- $args

DEBUG=false
BASIC=false
UPDATE=false
HELP=false

while true; do
  case "$1" in
    -b ) BASIC=true; shift ;;
	-d ) DEBUG=true; shift ;;
    -h ) HELP=true; shift ;;
	-u ) UPDATE=true; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ $HELP == true ]; then
	usage
fi

if [ $DEBUG == true ]; then
	echo DEBUG=$DEBUG
	echo BASIC=$BASIC
	echo UPDATE=$UPDATE
fi

# Install mac
echo -e '\033[38;5;242m# Installing Mac env #\033[0m'

if [ ! $UPDATE ]; then
	## Install xcode-tools
	echo -e '\033[38;5;242m## Installing Xcode developper tools ##\033[0m'
	if [ ! "$(which git)" ]; then
		XCODE_MESSAGE="$(osascript -e 'tell app "System Events" to display dialog "Please click install when Command Line Developer Tools appears"')"
		if [ "$XCODE_MESSAGE" = "button returned:OK" ]; then
			xcode-select --install
		else
			echo "You have cancelled the installation, please rerun the installer."
			# you have forgotten to exit here
			exit 1
		fi
	fi

	until [ "$(which git)" ]; do
			echo -n "."
			sleep 1
	done

	## Install brew
	if [ ! "$(which brew)" ]; then
		echo -e '\033[38;5;242m## Installing Homebrew ##\033[0m'
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	## Update brew
	brew update
	brew services

	## Install brew packages
	echo -e '\033[38;5;242m## Installing Homebrew packages ##\033[0m'
	brew install zsh zsh-completions curl openldap libiconv inetutils pkg-config lynx vim php composer httpd imagemagick gs node yarn
fi

## Link brew packages
brew link --force httpd composer node yarn
brew link --force php

## Install PHP dependencies
echo -e '\033[38;5;242m## Installing PHP packages ##\033[0m'
if [ ! "$(which pecl)" ]; then
	echo -e '\033[38;5;242m## PECL not found ##\033[0m'
	exit 2
else
	pecl install mongodb imagick xdebug
fi

if [ ! $BASIC ]; then
	brew tap blackfireio/homebrew-blackfire
	brew install blackfire-agent
	brew install blackfire-php73
fi

## Stop Apache
echo -e '\033[38;5;242m## Uninstalling Apache (mac) ##\033[0m'
sudo apachectl stop

## Unload Apache (mac)
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null

## Load Apache (brew)
echo -e '\033[38;5;242m## Installing Apache (brew) ##\033[0m'
sudo brew services start httpd
sudo apachectl start

# Exit if basic installation (no custom shell and applications)
if [ $BASIC == true ]; then
	exit 0
fi

# Full install files
if [ ! $UPDATE ]; then
	## Move dotfiles
	echo -e '\033[38;5;242m## Installing Dotfiles ##\033[0m'
	mkdir -p ~/Documents/dev/dotfiles
	git clone https://github.com/kranack/dotfiles.git ~/Documents/dev/dotfiles

	cp -R ~/Documents/dev/dotfiles/.{gnupg,oh-my-zsh,vimrc,zshrc} ~/

	## Oh-my-zsh
	echo -e '\033[38;5;242m## Installing Oh my zsh ##\033[0m'
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	## Powerline10k theme
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

	## Install zsh as default shell
	if ! grep -Fxq "/bin/zsh" /etc/shells
	then
		sudo echo "/bin/zsh" >> /etc/shells
	fi
	chsh -s /bin/zsh

	## Vundle
	echo -e '\033[38;5;242m## Installing Vim plugins ##\033[0m'
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	vim -c "call coc#util#install()"

	## Apps
	echo -e '\033[38;5;242m## Installing applications ##\033[0m'
	brew cask install db-browser-for-sqlite visual-studio-code github iterm2 mongodb robo-3t
	brew cask install adobe-creative-cloud dropbox google-chrome slack
	brew cask install chronos
	brew cask install spotify spotify-now-playing
	brew cask install gpg-suite
fi

# Log
echo -e '\033[38;5;242m# Installed apps versions #\033[0m'
echo "Homebrew version $(brew -v)"
echo "zsh version $(zsh --version)"
#echo "vim version $(vim --version)"

echo "PHP version $(php -v)"
echo "NodeJS version $(node -v)"
