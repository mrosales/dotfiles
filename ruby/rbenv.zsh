#!/usr/bin/env zsh

if [ $commands[rbenv] ]; then
# lazy-load rbenv
rbenv() {
  if [[ -d '/usr/local/opt/rbenv' ]]; then
    unset -f rbenv
    eval "$(command rbenv init - zsh)"
    export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
    rbenv "$@"
  else
    echo "rbenv is not installed" >&2
    return 1
  fi
}

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
