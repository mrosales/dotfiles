#!/usr/bin/env zsh

function pyenv() {
    export PYENV_ROOT=$HOME/.pyenv
    unset -f pyenv
    eval "$(command pyenv init -)"
    if [[ -n "${ZSH_PYENV_LAZY_VIRTUALENV}" ]]; then
        eval "$(command pyenv virtualenv-init -)"
    fi
    export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"
    pyenv $@
}
