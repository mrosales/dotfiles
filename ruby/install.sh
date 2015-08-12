#!/bin/sh
# Requires shell functions defined in
# DOTFILE_ROOT/scripts/install-helpers.sh

# can only perform setup if machine has homebrew installed
if ! is_osx ; then exit 0 ; fi

install_dep_if_needed rbenv
install_dep_if_needed ruby-build

latest_stable_ruby() {
    version=$(rbenv install -l | awk -F '.' '
               /^[[:space:]]*[0-9]+\.[0-9]+\.[0-9]+[[:space:]]*$/ {
                  if ( ($1 * 100 + $2) * 100 + $3 > Max ) {
                     Max = ($1 * 100 + $2) * 100 + $3
                     Version=$0
                     gsub(/ /, "", Version)
                     }
                  }
               END { print Version }')
    echo "$version"
}

RUBY_VERSION=$(latest_stable_ruby)
gem install -v  "$RUBY_VERSION" > "/tmp/ruby-$RUBY_VERSION-install.log"
