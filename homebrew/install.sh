#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
fi

echo "Homebrew installer running."

# Install homebrew packages
brew install git mongodb python tmux vim wget

# extras 
# brew install autojump heroku-toolbelt macvim r todo-txt

exit 0
