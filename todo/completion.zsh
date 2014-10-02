#!/bin/zsh
autoload bashcompinit
bashcompinit
source /usr/local/Cellar/todo-txt/2.10/etc/bash_completion.d/todo_completion

TODO_EXE=$(which todo.sh)
alias t=todo.sh
complete -F _todo t
