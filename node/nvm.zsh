#!/usr/bin/env zsh
# This code is a modified version of the plugin here:
# https://github.com/lukechilds/zsh-nvm

ZSH_NVM_DIR=${0:a:h}

NVM_INSTALL_DIR=${NVM_INSTALL_DIR:-/usr/local/opt/nvm}

# if we don't have nvm installed, don't bother running anything else
if [[ ! -d "${NVM_INSTALL_DIR}" ]]; then
  true
  return
fi

[[ -z "$NVM_DIR" ]] && export NVM_DIR="$HOME/.nvm"

_zsh_nvm_rename_function() {
  test -n "$(declare -f $1)" || return
  eval "${_/$1/$2}"
  unset -f $1
}

_zsh_nvm_has() {
  type "$1" > /dev/null 2>&1
}

_zsh_nvm_global_binaries() {

  # Look for global binaries
  local global_binary_paths="$(echo "$NVM_DIR"/v0*/bin/*(N) "$NVM_DIR"/versions/*/*/bin/*(N))"

  # If we have some, format them
  if [[ -n "$global_binary_paths" ]]; then
    echo "$NVM_DIR"/v0*/bin/*(N) "$NVM_DIR"/versions/*/*/bin/*(N) |
      xargs -n 1 basename |
      sort |
      uniq
  fi
}

_zsh_nvm_load() {
  # Source nvm
  source "$NVM_INSTALL_DIR/nvm.sh"

  # Rename main nvm function
  _zsh_nvm_rename_function nvm _zsh_nvm_nvm

  # Wrap nvm in our own function
  nvm() {
    case $1 in
      'use')
        _zsh_nvm_nvm "$@"
        local use_status=$?
        export NVM_AUTO_USE_ACTIVE=false
        return $use_status
        ;;
      *)
        _zsh_nvm_nvm "$@"
        ;;
    esac
  }
}

_zsh_nvm_lazy_load() {

  # Get all global node module binaries including node
  # (only if NVM_NO_USE is off)
  local global_binaries
  if [[ "$NVM_NO_USE" == true ]]; then
    global_binaries=()
  else
    global_binaries=($(_zsh_nvm_global_binaries))
  fi

  # Add yarn lazy loader if it's been installed by something other than npm
  _zsh_nvm_has yarn && global_binaries+=('yarn')

  # Add nvm
  global_binaries+=('nvm')

  # Remove any binaries that conflict with current aliases
  local cmds
  cmds=()
  for bin in $global_binaries; do
    [[ "$(which $bin 2> /dev/null)" = "$bin: aliased to "* ]] || cmds+=($bin)
  done

  # Create function for each command
  for cmd in $cmds; do

    # When called, unset all lazy loaders, load nvm then run current command
    eval "$cmd(){
      unset -f $cmds > /dev/null 2>&1
      _zsh_nvm_load
      $cmd \"\$@\"
    }"
  done
}

_zsh_nvm_auto_use() {
  local nvmrc_path=.nvmrc

  if [[ ! -f "$nvmrc_path" ]]; then
    if [[ ${VIRTUAL_ENV} == node-* ]]; then
      unset VIRTUAL_ENV
    fi
    return 0
  fi

  local red="\e[31m"
  local green="\e[32m"
  local yellow="\e[33m"
  local reset="\e[0m"

  local wanted_nvmrc_version=$(cat "$nvmrc_path")
  local node_version="$(nvm version)"
  local nvmrc_node_version="$(nvm version $wanted_nvmrc_version)"

  if [[ "$nvmrc_node_version" = "N/A" ]]; then
    printf "${yellow}Installing missing Node version: ${wanted_nvmrc_version}${reset}\n" >&2
    nvm install && export NVM_AUTO_USE_ACTIVE=true
  else
    printf "${green}Activating Node version: ${nvmrc_node_version}${reset}\n" >&2
    if nvm use --silent >/dev/null; then
      export NVM_AUTO_USE_ACTIVE=true
    else
      printf "${red}Failed activating Node ${wanted_node_version}${reset}\n" >&2
    fi
  fi
  export VIRTUAL_ENV="node-${wanted_nvmrc_version}"
}

_zsh_nvm_lazy_load
add-zsh-hook chpwd _zsh_nvm_auto_use && _zsh_nvm_auto_use

# Make sure we always return good exit code
# We can't `return 0` because that breaks antigen
true
