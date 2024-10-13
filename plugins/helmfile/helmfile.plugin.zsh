if (( ! $+commands[helmfile] )); then
  return
fi

# If the completion file does not exist, generate it and then source it
# Otherwise, source it and regenerate in the background
if [[ ! -f "$ZSH_CACHE_DIR/completions/_helmfile" ]]; then
  helmfile completion zsh | tee "$ZSH_CACHE_DIR/completions/_helmfile" >/dev/null
  source "$ZSH_CACHE_DIR/completions/_helmfile"
else
  source "$ZSH_CACHE_DIR/completions/_helmfile"
  helmfile completion zsh | tee "$ZSH_CACHE_DIR/completions/_helmfile" >/dev/null &|
fi

alias hf='helmfile'
alias hfi='helmfile --interactive'
