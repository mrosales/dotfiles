#!/usr/bin/env zsh

# add these to system PATH
export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH=${GOPATH}/bin:${GOROOT}/bin:${PATH}
