#!/usr/bin/env zsh

if [ $commands[tfswitch] ] ; then
    load-tfswitch() {
        local tfswitchrc_path=".tfswitchrc"

        if [ -f "$tfswitchrc_path" ]; then
            tfswitch
        fi
    }
    add-zsh-hook chpwd load-tfswitch
    load-tfswitch
fi
