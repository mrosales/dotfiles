#!/usr/bin/env zsh
# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )) && (( $+commands[brew] ))
then
  source /usr/local/etc/grc.bashrc
fi