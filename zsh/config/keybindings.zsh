#!/usr/bin/env zsh
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

if [[ ${TERM} == 'dumb' ]] ; then return ; fi

# Use human-friendly identifiers.
zmodload -F zsh/terminfo +b:echoti +p:terminfo
typeset -gA key_info

# for the list of what theys keys mean, see the man page
# man 5 terminfo
key_info=(
  'Space'        ' '
  'Control'      '\C-'
  'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd \eOD'
  'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc \eOC'
  'AltLeft'      '^[^[[D'
  'AltRight'     '^[^[[C'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    '^?'
  'Delete'       '^[[3~'
  'BackTab'      "${terminfo[kcbt]}"
  'Left'         "${terminfo[kcub1]}"
  'Down'         "${terminfo[kcud1]}"
  'Right'        "${terminfo[kcuf1]}"
  'Up'           "${terminfo[kcuu1]}"
  'End'          "${terminfo[kend]}"
  'F1'           "${terminfo[kf1]}"
  'F2'           "${terminfo[kf2]}"
  'F3'           "${terminfo[kf3]}"
  'F4'           "${terminfo[kf4]}"
  'F5'           "${terminfo[kf5]}"
  'F6'           "${terminfo[kf6]}"
  'F7'           "${terminfo[kf7]}"
  'F8'           "${terminfo[kf8]}"
  'F9'           "${terminfo[kf9]}"
  'F10'          "${terminfo[kf10]}"
  'F11'          "${terminfo[kf11]}"
  'F12'          "${terminfo[kf12]}"
  'Home'         "${terminfo[khome]}"
  'Insert'       "${terminfo[kich1]}"
  'PageDown'     "${terminfo[knp]}"
  'PageUp'       "${terminfo[kpp]}"
)


# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e                                            # Use emacs key bindings
# bindkey -v                                            # Use vim key bindings

bindkey '\ew' kill-region                             # [Esc-w] - Delete from the begining of the prompt to the cursor
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.


[[ -n ${key_info[PageUp]} ]]       && bindkey "${key_info[PageUp]}" up-line-or-history     # [PageUp] - Up a line of history
[[ -n ${key_info[PageDown]} ]]     && bindkey "${key_info[PageDown]}" down-line-or-history # [PageDown] - Down a line of history
[[ -n ${key_info[Up]} ]]           && bindkey "${key_info[Up]}" up-line-or-search          # [Up-Arrow] - fuzzy find history forward
[[ -n ${key_info[Down]} ]]         && bindkey "${key_info[Down]}" down-line-or-search      # [Down-Arrow] - fuzzy find history backward
[[ -n ${key_info[Home]} ]]         && bindkey "${key_info[Home]}" beginning-of-line        # [Home] - Go to beginning of line
[[ -n ${key_info[End]} ]]          && bindkey "${key_info[End]}" end-of-line               # [End] - Go to end of line
[[ -n ${key_info[ControlRight]} ]] && bindkey "${key_info[ControlRight]}" forward-word     # [Ctrl-RightArrow] - move forward one word
[[ -n ${key_info[ControlLeft]} ]]  && bindkey "${key_info[ControlLeft]}" backward-word     # [Ctrl-LeftArrow] - move backward one word
[[ -n ${key_info[AltRight]} ]]     && bindkey ${key_info[AltRight]} forward-word           # [Alt-RightArrow] - Forward word
[[ -n ${key_info[AltLeft]} ]]      && bindkey ${key_info[AltLeft]} backward-word           # [Alt-LeftArrow] - Previous word
[[ -n ${key_info[BackTab]} ]]      && bindkey "${key_info[BackTab]}" reverse-menu-complete # [Shift-Tab] - move through the completion menu backwards
[[ -n ${key_info[Space]} ]]        && bindkey ${key_info[Space]} magic-space               # [Space] - do history expansion
[[ -n ${key_info[Delete]} ]]       && bindkey ${key_info[Delete]} delete-char              # [Delete] - delete forward
[[ -n ${key_info[Backspace]} ]]    && bindkey ${key_info[Backspace]} backward-delete-char  # [Backspace] - delete backward

# Load the edit-command-line macro and add it as a zle widget
autoload -U edit-command-line; zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line                      # [Ctrl-x, Ctrl-e] - edit command in EDITOR

# Declare the zle-pwd function to use as a widget
# shows the result of pwd below the command line
function zle-pwd { zle -M "$(pwd)" }
zle -N zle-pwd; bindkey "\ep" zle-pwd        # [Esc-p] Print current directory below the command prompt

# Declare the zle-ls function to use as a widget
# Shows the result of ls below the command line
function zle-ls { zle -M "$(ls -Fh)" }
zle -N zle-ls; bindkey "\el" zle-ls          # [Esc-l] - Print result of ls below prompt
