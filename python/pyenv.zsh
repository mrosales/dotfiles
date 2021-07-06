#!/usr/bin/env zsh

if [ $commands[pyenv] ] ; then
    _evalcache pyenv init - zsh --no-rehash --path
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"

    if [ $commands[pyenv-virtualenv] ]; then
        _evalcache pyenv virtualenv-init -
        export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"
    fi

    _zsh_pyenv_auto_use() {
        local python_version_path=".python-version"

        if [ -f "$python_version_path" ]; then
            pyenv local >/dev/null
        fi
    }
    add-zsh-hook chpwd _zsh_pyenv_auto_use && _zsh_pyenv_auto_use

    pyenv-brew-relink() {
        rm -f "${HOME}/.pyenv/versions/*-brew"

        local cellars=($(brew --cellar)/*)
        local python_cellars=${(M)cellars:#*/python@*}

        for python_cellar in ${(M)cellars:#*/python@*}; do
            local python_versions=(${python_cellar}/*)
            for python_home in ${python_versions}; do
                local pyenv_version_link="${HOME}/.pyenv/versions/${python_home##/*/}-brew"
                echo "Creating Link ${pyenv_version_link} -> ${python_home}" >&2
                ln -s --force ${python_home} ${pyenv_version_link};
            done
        done
    }

    pyenv-latest-python() {
        local pyenv_versions=($(pyenv install -l))
        # zsh glob to remove any "<name>-<version>" style versions and any "X.Y.ZaZYZ" alpha versions
        pyenv_versions=(${${pyenv_versions:#*-*}:#*a*})
        # print out the last item in the list
        echo ${pyenv_versions[-1]}
    }
fi
