# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.  #
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Run the screensaver if we're in the bottom-left hot corner.
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Hide Safari's bookmark bar.
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Tap to click
defaults -currentHost write -globalDomain com.apple.mouse.tapBehavior -int 1
# Prefer non-natural scrolling
defaults write -g com.apple.swipescrolldirection -bool NO
# Autohide dock
defaults write com.apple.Dock autohide -bool TRUE
# Map caps lock to escape
defaults -currentHost write -g com.apple.keyboard.modifiermapping.1452-630-0 -array \
'<dict>
			<key>HIDKeyboardModifierMappingDst</key>
			<real>30064771113</real>
			<key>HIDKeyboardModifierMappingSrc</key>
			<real>30064771129</real>
</dict>'

# Set shell
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
# Faster key repeat
defaults write "Apple Global Domain" InitialKeyRepeat -int 15
defaults write "Apple Global Domain" KeyRepeat -int 2

# Show percentage left on battery
defaults write com.apple.menuextra.battery ShowPercent -bool TRUE
# Show date in clock
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM  HH:mm"
# Enable the locate database
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

#############
# HARDENING #
#############
# No guest users
sudo defaults write com.apple.loginwindow GuestEnabled -bool NO
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Anonymous computer name
sudo scutil --set ComputerName "Very Little Gravitas Indeed"
sudo scutil --set HostName VeryLittleGravitasIndeed
sudo scutil --set LocalHostName VeryLittleGravitasIndeed

# Known safe DNS
sudo networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1

# Enable filevault
sudo fdesetup enable
