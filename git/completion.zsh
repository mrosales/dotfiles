#!/usr/bin/env zsh
# Aliases
alias git='noglob git'

# Makes git auto completion faster favouring for local completions
__git_files () {
    _wanted files expl 'local files' _files
}

# This line is necessary to stop the
# Autocomplete from spazzing
alias __git-add_main=_git_add
alias __git-checkout_main=_git_checkout
alias __git-diff_main=_git_diff
alias __git-commit_main=_git_commit
alias __git-push_main=_git_push
alias __git-branch_main=_git_branch
alias __git-log_main=_git_log
alias __git-reset_main=_git_reset
alias __git-pull_main=_git_pull
alias __git-fetch_main=_git_fetch
alias __git-show_main=_git_show
alias __git-cherry-pick_main=_git_cherry-pick
alias __git-rebase_main=_git_rebase
alias __git-merge_main=_git_merge
alias __git-tag_main=_git_tag
alias __git-submodule_main=_git_submodule

alias g='git'
compdef g=git

alias ga='noglob git add'
compdef _git ga=git-add

alias gs='git status'
compdef _git gs=git-status

alias gd='git diff'
compdef _git gd=git-diff
alias gdc='git diff --cached'
compdef _git gdc=git-diff
alias gl='git pull'
compdef _git gl=git-pull
alias gp='git push'
compdef _git gp=git-push
alias gd='git diff'

gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

alias gc='git commit -v'
compdef _git gc=git-commit

alias gco='noglob git checkout'
compdef _git gco=git-checkout
alias gnb='noglob git checkout -b'
compdef _git gnb=git-checkout

alias gr='git remote'
compdef _git gr=git-remote
alias grv='git remote -v'
compdef _git grv=git-remote
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch
alias grbi='git rebase -i'
compdef _git grbi=git-rebase
alias grbc='git rebase --continue'
compdef _git grbc=git-rebase
alias grba='git rebase --abort'
compdef _git grba=git-rebase

alias glg='git log --stat --max-count=10'
compdef _git glg=git-log
alias glo='git log --oneline --decorate --color'
compdef _git glo=git-log
alias glog='git log --oneline --decorate --color --graph'
compdef _git glog=git-log

alias gm='git merge'
compdef _git gm=git-merge

alias grh='noglob git reset HEAD'
compdef _git grh=git-reset
alias grhh='noblob git reset HEAD --hard'
compdef _git grhh=git-reset

alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

# Sign and verify commits with GPG
alias gcs='git commit -S'
compdef _git gcs=git-commit
alias gsps='git show --pretty=short --show-signature'
compdef _git gsps=git-show

# Sign and verify tags with GPG
alias gts='git tag -s'
compdef _git gts=git-tag
alias gvt='git verify-tag'
compdef _git gvt=git verify-tag

alias gdt='git difftool'
compdef _git gdt=git-difftool

alias gmt='git mergetool --no-prompt'
compdef _git gmt=git-mergetool

# Will cd into the top of the current repository
# or submodule.
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'

#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
alias glp="_git_log_prettily"
compdef _git glp=git-log

# Work In Progress (wip)
# These features allow to pause a branch development and switch to another one (wip)
# When you want to go back to work, just unwip it
#
# This function return a warning if the current branch is a wip
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}

# these alias commit and uncomit wip branches
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
