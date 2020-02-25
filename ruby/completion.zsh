#!/usr/bin/env zsh
# Stolen from
#   https://github.com/sstephenson/rbenv/blob/master/completions/rbenv.zsh

compctl -K _rbenv rbenv

_rbenv() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(rbenv commands)"
  else
    completions="$(rbenv completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
