#!/usr/bin/env zsh

zmodload zsh/datetime

function _current_epoch() {
  echo $(( $EPOCHSECONDS / 60 / 60 / 24 ))
}

function _update_zsh_update() {
  echo "LAST_EPOCH=$(_current_epoch)" >! ${ZSH_CACHE_DIR}/.zsh-update
}

function _upgrade_zsh() {
  env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
  # update the zsh file
  _update_zsh_update
}

epoch_target=$UPDATE_ZSH_DAYS
if [[ -z "$epoch_target" ]]; then
  # Default to old behavior
  epoch_target=13
fi

# Cancel upgrade if the current user doesn't have write permissions for the
# oh-my-zsh directory.
[[ -w "$ZSH" ]] || return 0

# Cancel upgrade if git is unavailable on the system
whence git >/dev/null || return 0

if mkdir "$ZSH/log/update.lock" 2>/dev/null; then
  if [ -f ${ZSH_CACHE_DIR}/.zsh-update ]; then
    . ${ZSH_CACHE_DIR}/.zsh-update

    if [[ -z "$LAST_EPOCH" ]]; then
      _update_zsh_update && return 0
    fi

    epoch_diff=$(($(_current_epoch) - $LAST_EPOCH))
    if [ $epoch_diff -gt $epoch_target ]; then
      if [ "$DISABLE_UPDATE_PROMPT" = "true" ]; then
        _upgrade_zsh
      else
        while true; do
          echo "[Oh My Zsh] Would you like to update? [Y/n/g/?]: \c"
          read line
          if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
            _upgrade_zsh
          elif [[ "$line" == G* ]] || [[ "$line" == g* ]]; then
            cd $ZSH
            git fetch
            git log -p
            continue
          elif [[ "$line" == "?" ]]; then
            echo -e "Yy - yes
Nn - no
Gg - show git log with patches"
            continue
          else
            _update_zsh_update
          fi
          break
        done
      fi
    fi
  else
    # create the zsh file
    _update_zsh_update
  fi

  rmdir $ZSH/log/update.lock
fi
