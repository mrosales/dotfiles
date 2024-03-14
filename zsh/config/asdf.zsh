
if [[ -d "${BREW_PREFIX}/opt/asdf" ]]; then
    source "${BREW_PREFIX}/opt/asdf/libexec/asdf.sh"
fi

if [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv" ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
fi

export WORKON_HOME="${HOME}/.virtualenvs"

mkenv() {
    local project_name=$(basename $PWD)
    local dest_dir="${WORKON_HOME}/${project_name}"

    if [[ -d "${dest_dir}" ]]; then
        echo "mkenv: failed: ${dest_dir} already exists..."
        return 1
    fi

    local python_bin
    if [[ -z "$1" ]]; then
        python_bin=$(asdf where python "$1")/bin/python
    else
        python_bin=$(asdf which python)
    fi

    if [[ ! -e "${python_bin}" ]]; then
        echo "mkenv: failed: ${python_bin} does not exist."
        return 1
    fi

    echo Creating Environment: "${python_bin}" -m venv "${dest_dir}"
    "${python_bin}" -m venv "${dest_dir}"

    source "${dest_dir}/bin/activate"
}

_auto_workon() {
    local project_name=$(basename $PWD)
    if [ -d "${WORKON_HOME}/${project_name}" ]; then
        source "${WORKON_HOME}/${project_name}/bin/activate"

        # If using the starship prompt, manually reload it.
        if [ $commands[starship] ] ; then
            source <(${BREW_PREFIX}/bin/starship init zsh --print-full-init)
        fi
    fi
}

add-zsh-hook chpwd _auto_workon && _auto_workon
