#!/bin/sh

is_osx() {
    [ "${IS_OSX}" = true ]
    return $?
}
export -f is_osx

command_exists_in_path() {
    command -v "$1" >/dev/null 2>&1
    return $?
}
export -f command_exists_in_path

install_dep_if_needed() {
    if ! command_exists_in_path "$1" ; then
        echo " Installing $1 for you."
        brew install "$1" > "/tmp/$1-install.log"
    else
        echo " Skipping install of $1. It has already been installed."
    fi
}
export -f install_dep_if_needed