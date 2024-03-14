#!/usr/bin/env zsh

# Aliases
alias git='noglob git'

# Makes git auto completion faster favouring for local completions
__git_files () {
    _wanted files expl 'local files' _files
}

alias g='git'
alias ga='noglob git add'
alias gs='git status'
alias gdc='git diff --cached'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'

gdv() { git diff -w "$@" | view - }

alias gc='git commit -v'
alias gco='noglob git checkout'
alias gnb='noglob git checkout -b'

alias gr='git remote'
alias grv='git remote -v'
alias gb='git branch'
alias gba='git branch -a'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

alias glg='git log --stat --max-count=10'
alias glo='git log --oneline --decorate --color'
alias glog='git log --oneline --decorate --color --graph'

alias gm='git merge'

alias grh='noglob git reset HEAD'
alias grhh='noglob git reset HEAD --hard'

alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

# Sign and verify commits with GPG
alias gcs='git commit -S'
alias gsps='git show --pretty=short --show-signature'

# Sign and verify tags with GPG
alias gts='git tag -s'
alias gvt='git verify-tag'

alias gdt='git difftool'

alias gmt='git mergetool --no-prompt'

# Will cd into the top of the current repository
# or submodule.
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'

# these alias commit and uncomit wip branches
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--" --no-verify'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
