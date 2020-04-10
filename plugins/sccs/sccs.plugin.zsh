_SCCS_PROMPT=""

ZSH_THEME_SCCS_PROMPT_PREFIX="%{$fg_bold[blue]%}sccs:"
ZSH_THEME_SCCS_PROMPT_DIRTY="%{$fg_bold[red]%}✖"
ZSH_THEME_SCCS_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

function sccs_prompt_info () {
  if [ -d SCCS ]; then
    # There is an SCCS folder. Does it host SCCS files and does it
    # have "dirty" files?
    local IS_SCCS_FOLDER=false
    [[ -n SCCS/s.*(#qN) ]] && IS_SCCS_FOLDER=true
    
    if [ "$IS_SCCS_FOLDER" = true ]; then 
        local _EDITED_SYM="$ZSH_THEME_SCCS_PROMPT_CLEAN"

        local SCCS_CHECK=`sccs tell`
        if [[ -n $SCCS_CHECK ]]; then
            # We have dirty files here.
            _EDITED_SYM="$ZSH_THEME_SCCS_PROMPT_DIRTY"
        fi

        echo "$ZSH_THEME_SCCS_PROMPT_PREFIX" \
          "$_EDITED_SYM"\
          "%{$reset_color%}"
    fi
  fi
}

function _sccs_prompt () {
  local current=`echo $PROMPT $RPROMPT | grep sccs`

  if [ "$_SCCS_PROMPT" = "" -o "$current" = "" ]; then
    local _prompt=${PROMPT}
    local _rprompt=${RPROMPT}

    local is_prompt=`echo $PROMPT | grep git`

    if [ "$is_prompt" = "" ]; then
      export RPROMPT="$_rprompt"'$(sccs_prompt_info)'
    else
      export PROMPT="$_prompt"'$(sccs_prompt_info)'
    fi

    _SCCS_PROMPT="1"
  fi
}

autoload -U add-zsh-hook

add-zsh-hook precmd _sccs_prompt
