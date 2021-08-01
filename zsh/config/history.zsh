# The path of the history file.
HISTFILE=~/.zsh_history

# The number of commands that are loaded into memory from the history file
HISTSIZE=10000

# The number of commands that are stored in the zsh history file
SAVEHIST=10000

# Whenever the user enters a line with history substitution, don't execute the line directly;
# instead, perform history substitution and reload the line into the editing buffer.
setopt HIST_VERIFY

# Incrementally write to history AND read the whole history when calling a history command.
setopt SHARE_HISTORY

# Add start and end timestamps to the history file
setopt EXTENDED_HISTORY

# Sessions append to history file instead of overwriting it.
setopt APPEND_HISTORY

# Executing a duplicate command removes the previous invocation from history.
setopt HIST_IGNORE_ALL_DUPS

# Remove superfluous blanks from each command line being added to the history list.
setopt HIST_REDUCE_BLANKS
