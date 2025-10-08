#!/bin/sh -e

ROOT=$(
	cd "$(dirname "$0")" || return
	pwd -P
)

. "$ROOT"/secrets.sh
. "$ROOT"/lib.sh

###############################################################################
### CLI
###############################################################################

if [ "$1" != -q ]; then
	brew bundle install --cleanup
fi

link ghostty_config ~/.config/ghostty/config

link bashrc ~/.bashrc
link bash_profile ~/.bash_profile
link inputrc ~/.inputrc

link ssh_config ~/.ssh/config
tmpl git_config ~/.config/git/config GIT_NAME GIT_EMAIL

link tmux.conf ~/.config/tmux/tmux.conf

###############################################################################
### Development
###############################################################################

if [ ! -e ~/.config/nvim/.git ]; then
	mkdir -p ~/.config/nvim
	git clone https://codeberg.org/eju/nvimcf.git ~/.config/nvim
elif [ "$1" != -q ]; then
	git -C ~/.config/nvim pull
fi

if [ "$1" != -q ]; then
	~/.config/nvim/plug.sh
fi

###############################################################################
### GUI
###############################################################################

if [ "$(defaults read com.apple.dock autohide 2>/dev/null)" != 1 ]; then
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock tilesize -int 32
	defaults write com.apple.dock mru-spaces -bool false
	defaults write com.apple.dock show-recents -bool false
	defaults write com.apple.dock wvous-br-corner -int 0

	pkill Dock
fi

if [ "$(defaults -currentHost read com.apple.controlcenter Sound 2>/dev/null)" != 18 ]; then
	defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1
	defaults -currentHost write com.apple.controlcenter \
		BatteryShowPercentage -bool true
	defaults -currentHost write com.apple.controlcenter Sound -int 18
fi

# Faster key repeat with less delay:
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 25

# Disable typing corrections:
spelling_configs='
	Capitalization
	DashSubstitution
	PeriodSubstitution
	QuoteSubstitution
	SpellingCorrection
'
for s in $spelling_configs; do
	defaults write NSGlobalDomain "NSAutomatic${s}Enabled" -bool false
done
