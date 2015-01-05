#!/bin/zsh

# Exit if not OSX
if [ "${SYS_ARCH:-Linux}" != Darwin ] ; then return ; fi

if (( $+commands[todo.sh] )) ; then
  autoload bashcompinit
  bashcompinit
  source /usr/local/Cellar/todo-txt/2.10/etc/bash_completion.d/todo_completion

  TODO_EXE=$(which todo.sh)
  alias t=todo.sh
  complete -F _todo t
fi
