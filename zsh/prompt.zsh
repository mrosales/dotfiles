#!/bin/zsh


autoload -U promptinit && promptinit
prompt pure

# export LSCOLORS=gxfxcxdxbxegedabagacad
# export LS_COLORS="di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"


return
#############################################################
############## THE BOTTOM PART IS IGNORED! ##################

autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "%{$fg_bold[blue]%}git:( %{$fg_bold[green]%}$(git_prompt_info)%{$fg_bold[blue]%} )%{$reset_color%}"
    else
      echo "%{$fg_bold[blue]%}git:( %{$fg_bold[red]%}$(git_prompt_info)%{$fg_bold[blue]%} )%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo "%{$fg_bold[magenta]%} <- unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
  else
    echo ""
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%~%{$reset_color%}"
}

machine_prefix() {
  if ! [[ -z "$MACHINE_PREFIX" ]]
  then
    echo "%{$fg_bold[magenta]%}$MACHINE_PREFIX%{$reset_color%} \u279c "
  else
    echo ""
  fi
}

set_prompt () {
  export PROMPT=$'\n$(machine_prefix)$(directory_name) $(git_dirty)$(need_push)\n› '
  export RPROMPT='%{$fg_bold[cyan]%}%{$reset_color%}'
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
