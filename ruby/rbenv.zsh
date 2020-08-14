#!/usr/bin/env zsh

if [ $commands[rbenv] ]; then

_zsh_rbenv_auto_use() {
  local ruby_version_path=".ruby-version"
  if [ -f "$ruby_version_path" ]; then
    ruby_version=$(rbenv local)
    export VIRTUAL_ENV=ruby-v$ruby_version
  elif [[ "${VIRTUAL_ENV}" == ruby-* ]]; then
    unset VIRTUAL_ENV
  fi
}
add-zsh-hook chpwd _zsh_rbenv_auto_use && _zsh_rbenv_auto_use
fi
