#!/usr/bin/env zsh

if [ $commands[pyenv] ] ; then
    function pyenv() {
        export PYENV_ROOT=$HOME/.pyenv
        unset -f pyenv
        eval "$(command pyenv init -)"
        if [ $commands[pyenv-virtualenv] ]; then
            eval "$(command pyenv virtualenv-init -)"
        fi
        export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"
        pyenv $@
    }

    _zsh_pyenv_auto_use() {
        local python_version_path=".python-version"

        if [ -f "$python_version_path" ]; then
            pyenv local >/dev/null
        fi
    }
    add-zsh-hook chpwd _zsh_pyenv_auto_use && _zsh_pyenv_auto_use
fi
