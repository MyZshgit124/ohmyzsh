_homebrew-installed() {
    type brew &> /dev/null
}

_pyenv-from-homebrew-installed() {
    brew --prefix pyenv &> /dev/null
}

FOUND_PYENV=0
pyenvdirs=("$HOME/.pyenv" "/usr/local/pyenv" "/opt/pyenv")

if [[ -n "$PYENV_ROOT" ]]; then
  pyenvdirs=($PYENV_ROOT "${pyenvdirs[@]}")
fi

for pyenvdir in "${pyenvdirs[@]}" ; do
    if [ -d $pyenvdir/bin -a $FOUND_PYENV -eq 0 ] ; then
        FOUND_PYENV=1
        export PYENV_ROOT=$pyenvdir
        export PATH=${pyenvdir}/bin:$PATH
        eval "$(pyenv init - zsh)"

        if pyenv commands | command grep -q virtualenv-init; then
            eval "$(pyenv virtualenv-init - zsh)"
        fi

        function pyenv_prompt_info() {
            echo "$(pyenv version-name)"
        }
    fi
done
unset pyenvdir

if [ $FOUND_PYENV -eq 0 ] ; then
    pyenvdir=$(brew --prefix pyenv 2> /dev/null)
    if [ $? -eq 0 -a -d $pyenvdir/bin ] ; then
        FOUND_PYENV=1
        export PYENV_ROOT=$pyenvdir
        export PATH=${pyenvdir}/bin:$PATH
        eval "$(pyenv init - zsh)"

        if pyenv commands | command grep -q virtualenv-init; then
            eval "$(pyenv virtualenv-init - zsh)"
        fi

        function pyenv_prompt_info() {
            echo "$(pyenv version-name)"
        }
    fi
fi

if [ $FOUND_PYENV -eq 0 ] ; then
    function pyenv_prompt_info() { echo "system: $(python -V 2>&1 | cut -f 2 -d ' ')" }
fi
