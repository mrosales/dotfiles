
if [ $commands[rbenv] ]; then
  _evalcache rbenv init - zsh
  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
fi
