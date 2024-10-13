if (( ! $+commands[stern] )); then
  return
fi

# If the completion file does not exist, generate it and then source it
# Otherwise, source it and regenerate in the background
if [[ ! -f "$ZSH_CACHE_DIR/completions/_stern" ]]; then
  stern --completion zsh | tee "$ZSH_CACHE_DIR/completions/_stern" >/dev/null
  source "$ZSH_CACHE_DIR/completions/_stern"
else
  source "$ZSH_CACHE_DIR/completions/_stern"
  stern --completion zsh | tee "$ZSH_CACHE_DIR/completions/_stern" >/dev/null &|
fi
