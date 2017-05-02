_clone_git() {
  local url=$1; local folder=$2
  if [[ ! -d "$folder" ]]; then
    command git clone $url $folder
  fi
}

_download_plugin() {
  [[ -z "$1" || -z "$2" ]] && return 1
  local url=$1; local name=$2
  _clone_git $url $ZSH_CUSTOM/plugins/$name
  _map_put plugins $name enabled
}

_download_theme() {
  [[ -z "$1" || -z "$2" ]] && return 1
  local url=$1; local theme=$2
  _clone_git $url $ZSH_CUSTOM/themes/$theme
  command ln -s $ZSH_CUSTOM/themes/$theme/$theme.zsh-theme $ZSH_CUSTOM/$theme.zsh-theme
  _map_put themes theme $theme
}
