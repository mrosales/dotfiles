# Prevent background jobs from getting a lower CPU-scheduling priority
setopt NO_BG_NICE

# Prevent background jobs from getting a HUP when interactive shell exits
setopt NO_HUP

# Don't beep on an ambiguous completion.
setopt NO_LIST_BEEP

# Allow functions to have local options
# Options get restored at the point of return from a function.
setopt LOCAL_OPTIONS

# Allow functions to have local traps
setopt LOCAL_TRAPS

# Parameter expansion, command substitution and arithmetic expansion are performed in prompts.
setopt PROMPT_SUBST

# Try to correct the spelling of commands.
setopt CORRECT

# If unset, the cursor is set to the end of the word if completion is started.
# Otherwise it stays there and completion is done from both ends.
setopt COMPLETE_IN_WORD

# Do not exit on end-of-file. Require the use of exit or logout instead. 
# However, ten consecutive EOFs will cause the shell to exit anyway, 
# to avoid the shell hanging if its tty goes away.
setopt IGNORE_EOF

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt NO_COMPLETE_ALIASES

# Use extended glob syntax
# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc. 
# (An initial unquoted ‘~’ always produces named directory expansion.)
setopt EXTENDED_GLOB
