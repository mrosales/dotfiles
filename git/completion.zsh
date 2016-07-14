# Aliases
alias git='noglob git'

# Makes git auto completion faster favouring for local completions
__git_files () {
    _wanted files expl 'local files' _files
}

alias g='git'
compdef g=git

alias ga='noglob git add'
compdef _git ga=git-add

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

alias gs='git status '
alias gss='git status -s'
alias gst='git status'

alias gd='git diff'
compdef _git gd=git-diff
alias gdc='git diff --cached'
compdef _git gdc=git-diff
alias gdlc='git diff --cached HEAD^'
compdef _git gdlc=git-diff
alias gdt='git diff-tree --no-commit-id --name-only -r'
compdef _git gdc=git diff-tree --no-commit-id --name-only -r
alias gl='git pull'
compdef _git gl=git-pull
alias gup='git pull --rebase'
compdef _git gup=git-fetch
alias gp='git push'
compdef _git gp=git-push
alias gd='git diff'
gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gdt='git difftool'
alias gc='git commit -v'
compdef _git gc=git-commit
alias gc!='git commit -v --amend'
compdef _git gc!=git-commit
alias gca='git commit -v -a'
compdef _git gc=git-commit
alias gca!='git commit -v -a --amend'
compdef _git gca!=git-commit
alias gcmsg='git commit -m'
compdef _git gcmsg=git-commit
alias gco='noglob git checkout'
compdef _git gco=git-checkout
alias gcm='git checkout master'
alias gr='git remote'
compdef _git gr=git-remote
alias grv='git remote -v'
compdef _git grv=git-remote
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch

alias gsu='git submodule update'
compdef _git gsu=git-submodule
alias gsui='git submodule update --init'
compdef _git gsui=git-submodule

alias grbi='git rebase -i'
compdef _git grbi=git-rebase
alias grbc='git rebase --continue'
compdef _git grbc=git-rebase
alias grba='git rebase --abort'
compdef _git grba=git-rebase

alias gcount='git shortlog -sn'
compdef gcount=git
alias gcl='git config --list'
alias gcp='git cherry-pick'
compdef _git gcp=git-cherry-pick
alias glg='git log --stat --max-count=10'
compdef _git glg=git-log
alias glgg='git log --graph --max-count=10'
compdef _git glgg=git-log
alias glgga='git log --graph --decorate --all'
compdef _git glgga=git-log
alias glo='git log --oneline --decorate --color'
compdef _git glo=git-log
alias glog='git log --oneline --decorate --color --graph'
compdef _git glog=git-log

alias glop='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate'
compdef _git glop=git-log

alias gap='git add --patch'
alias gm='git merge'
compdef _git gm=git-merge

alias grh='noglob git reset HEAD'
compdef _git grh=git-reset
alias grhh='noblob git reset HEAD --hard'
compdef _git grhh=git-reset

alias gclean='git reset --hard && git clean -dfx'
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

alias gmt='git mergetool --no-prompt'
compdef _git gmt=git-mergetool

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias gk='gitk --all --branches'

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

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
compdef ggpull=git
alias ggpur='git pull --rebase origin $(current_branch)'
compdef ggpur=git
alias ggpush='git push origin $(current_branch)'
compdef ggpush=git
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
compdef ggpnp=git

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

# these alias ignore changes to file
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
# list temporarily ignored files
alias gignored='git ls-files -v | grep "^[[:lower:]]"'

alias gi='vim .gitignore'

#compdef git-branch

_git-branch ()
{
  declare l c m d

  l='--color --no-color -r -a --all -v --verbose --abbrev --no-abbrev'
  c='-l -f --force -t --track --no-track --set-upstream --contains --merged --no-merged'
  m='-m -M'
  d='-d -D'

  declare -a dependent_creation_args
  if (( words[(I)-r] == 0 )); then
    dependent_creation_args=(
      "($l $m $d): :__git_branch_names"
      "::start-point:__git_revisions")
  fi

  declare -a dependent_deletion_args
  if (( words[(I)-d] || words[(I)-D] )); then
    dependent_creation_args=
    dependent_deletion_args=(
      '-r[delete only remote-tracking branches]')
    if (( words[(I)-r] )); then
      dependent_deletion_args+='*: :__git_ignore_line_inside_arguments __git_remote_branch_names'
    else
      dependent_deletion_args+='*: :__git_ignore_line_inside_arguments __git_branch_names'
    fi
  fi

  declare -a dependent_modification_args
  if (( words[(I)-m] || words[(I)-M] )); then
    dependent_creation_args=
    dependent_modification_args=(
      ':old or new branch name:__git_branch_names'
      '::new branch name:__git_branch_names')
  fi

  _arguments -w -S -s \
    "($c $m $d --no-color :)--color=-[turn on branch coloring]:: :__git_color_whens" \
    "($c $m $d : --color)--no-color[turn off branch coloring]" \
    "($c $m      -a --all)-r[list or delete only remote-tracking branches]" \
    "($c $m $d : -r)"{-a,--all}"[list both remote-tracking branches and local branches]" \
    "($c $m $d : -v --verbose)"{-v,--verbose}'[show SHA1 and commit subject line for each head]' \
    "($c $m $d :)--abbrev=[set minimum SHA1 display-length]: :__git_guard_number length" \
    "($c $m $d :)--no-abbrev[do not abbreviate sha1s]" \
    "($l $m $d)-l[create the branch's reflog]" \
    "($l $m $d -f --force)"{-f,--force}"[force the creation of a new branch]" \
    "($l $m $d -t --track)"{-t,--track}"[set up configuration so that pull merges from the start point]" \
    "($l $m $d)--no-track[override the branch.autosetupmerge configuration variable]" \
    "($l $m $d)--set-upstream[set up configuration so that pull merges]" \
    "($l $m $d)--contains=[only list branches which contain the specified commit]: :__git_committishs" \
    "($l $m $d)--merged=[only list branches which are fully contained by HEAD]: :__git_committishs" \
    "($l $m $d)--no-merged=[do not list branches which are fully contained by HEAD]: :__git_committishs" \
    $dependent_creation_args \
    "($l $c $d -M)-m[rename a branch and the corresponding reflog]" \
    "($l $c $d -m)-M[rename a branch even if the new branch-name already exists]" \
    $dependent_modification_args \
    "($l $c $m -D)-d[delete a fully merged branch]" \
    "($l $c $m -d)-D[delete a branch]" \
    $dependent_deletion_args
}

(( $+functions[__git_ignore_line] )) ||
__git_ignore_line () {
  declare -a ignored
  ignored=()
  ((CURRENT > 1)) &&
    ignored+=(${line[1,CURRENT-1]//(#m)[\[\]()\\*?#<>~\^]/\\$MATCH})
  ((CURRENT < $#line)) &&
    ignored+=(${line[CURRENT+1,-1]//(#m)[\[\]()\\*?#<>~\^]/\\$MATCH})
  $* -F ignored
}

(( $+functions[__git_ignore_line_inside_arguments] )) ||
__git_ignore_line_inside_arguments () {
  declare -a compadd_opts

  zparseopts -D -E -a compadd_opts V: J: 1 2 n f X: M: P: S: r: R: q F:

  __git_ignore_line $* $compadd_opts
}

#compdef git-remote

# NOTE: --track is undocumented.
# TODO: --track, -t, --master, and -m should take remote branches, I guess.
# NOTE: --master is undocumented.
# NOTE: --fetch is undocumented.
_git-remote () {
  local curcontext=$curcontext state line
  declare -A opt_args

  _arguments -C \
    ':command:->command' \
    '*::options:->options' && ret=0

  case $state in
    (command)
      declare -a commands

      commands=(
        'add:add a new remote'
        'show:show information about a given remote'
        'prune:delete all stale tracking branches for a given remote'
        'update:fetch updates for a set of remotes'
        'rm:remove a remote from .git/config and all associated tracking branches'
        'rename:rename a remote from .git/config and update all associated tracking branches'
        'set-head:sets or deletes the default branch'
        'set-branches:changes the list of branches tracked by the named remote.'
        'set-url:changes URL remote points to.'
        )

      _describe -t commands 'sub-command' commands && ret=0
      ;;
    (options)
      case $line[1] in
        (add)
          _arguments \
            '*'{--track,-t}'[track given branch instead of default glob refspec]:branch:__git_branch_names' \
            '(--master -m)'{--master,-m}'[set the remote'\''s HEAD to point to given master branch]:branch:__git_branch_names' \
            '(--fetch -f)'{--fetch,-f}'[run git-fetch on the new remote after it has been created]' \
            ':branch name:__git_remotes' \
            ':url:_urls' && ret=0
          ;;
        (show)
          _arguments \
            '-n[do not contact the remote for a list of branches]' \
            ':remote:__git_remotes' && ret=0
          ;;
        (prune)
          _arguments \
            '(--dry-run -n)'{-n,--dry-run}'[do not actually prune, only list what would be done]' \
            ':remote:__git_remotes' && ret=0
          ;;
        (update)
          __git_remote-groups && ret=0
          ;;
        (rm)
          __git_remotes && ret=0
          ;;
        (rename)
          __git_remotes && ret=0
          ;;
        (set-url)
          _arguments \
            '*--push[manipulate push URLs]' \
            '(--add)--add[add URL]' \
            '(--delete)--delete[delete URLs]' \
            ':branch name:__git_remotes' \
            ':url:_urls' && ret=0
          ;;

      esac
      ;;
  esac
}

