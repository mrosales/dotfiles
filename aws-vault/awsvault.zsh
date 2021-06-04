
if [ $commands[aws-vault] ]; then
function aws_vault_exec_profile () {
   local aws_vault_profile="$1"; shift
   local aws_vault_extra_args=()
   local aws_vault_sub_args=()

   while [[ $# -gt 0 ]] && [[ ! "$1" == "--" ]]; do aws_vault_sub_args+=( "$1" ); shift; done
   if [[ "$1" == '--' ]]; then 
      aws_vault_extra_args=("${aws_vault_sub_args[@]}")
      aws_vault_sub_args=()
      shift;
   fi
   while [[ $# -gt 0 ]]; do aws_vault_sub_args+=( "$1" ); shift; done

   aws-vault exec "$aws_vault_profile"  ${aws_vault_extra_args} -- zsh -c "$aws_vault_sub_args"
   return $?
}
fi