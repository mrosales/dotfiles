#!/usr/bin/env zsh

# Only configure poetry paths if poetry dir exists.
if [[ -d "${HOME}/.poetry" ]]; then
    export POETRY_HOME=${HOME}/.poetry

    path=(${POETRY_HOME}/bin $path)

    if [[ ! -d $HOME/.zfunc ]]; then
        mkdir -p ${HOME}/.zfunc
    fi
    
    # The globbing is a little complicated here:
    # - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
    # - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
    # - '.' matches "regular files"
    # - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
    if [[ ! -f $HOME/.zfunc/_poetry ]] || [[ -n $HOME/.zfunc/_poetry(#qN.mh+24) ]] ; then
        ${POETRY_HOME}/bin/poetry completions zsh > ${HOME}/.zfunc/_poetry
    fi;
fi
