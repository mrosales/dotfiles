
if [ $commands[rbenv] ]; then
  eval "$(command rbenv init - zsh)"
  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
fi
