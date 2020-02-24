#!/bin/sh

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
rbenv install -v "${RUBY_VERSION}" | tee "/tmp/ruby-${RUBY_VERSION}-install.log"
