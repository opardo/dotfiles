#!/usr/bin/env bash

SCM_THEME_PROMPT_PREFIX="${cyan}(${green}"
SCM_THEME_PROMPT_SUFFIX="${cyan})"
SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${green}✓"

function virtualenv_prompt() {
    if [ ! -z "$VIRTUAL_ENV" ]
    then
        env=$(basename "$VIRTUAL_ENV")
        echo "${cyan}(${reset_color}${green}${env}${cyan})${reset_color}"
    fi
}

prompt() {
    local env="$(virtualenv_prompt)"
    local git=""
    if [ ! -z "$(scm_prompt_info)" ]
    then
        local git="$(scm_prompt_info)"
    fi
    PS1="${git}${reset_color}${env}${reset_color}[${cyan}\W${reset_color}] "
}

PROMPT_COMMAND=prompt
