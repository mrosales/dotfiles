#!/bin/bash

set -e

echo "Installing XCode command-line tools" >&2
xcode-select --install || true


echo "Installing Homebrew" >&2
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
/usr/local/bin/brew update


echo "Installing dependencies with brewfile" >&2
echo "/usr/local/bin/brew bundle" >&2

/usr/local/bin/brew bundle
