#!/usr/bin/env zsh

# PURE_PROMPT_SYMBOL=${PURE_PROMPT_SYMBOL:-λ}
PURE_PROMPT_SYMBOL=${PURE_PROMPT_SYMBOL:-❯}
autoload -U promptinit; promptinit
prompt pure
