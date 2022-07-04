# just exit if toolbox isnt found
if ! type toolbox &>/dev/null; then
  return
fi

function toolbox_prompt_info() {
  [[ -f /run/.toolboxenv ]] && echo "⬢"
}

# check if completion command exists
# (exit status 16 for "no manual entry" (command exists), 1 for bad command)
toolbox completion >| /dev/null
if [[ $? == 16 ]]; then
  source <(toolbox completion zsh)
  compdef _toolbox toolbox
fi

alias tb="toolbox enter"
