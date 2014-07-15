alias rs='repo sync -a'
compdef _repo rs='repo sync'

alias rs.='repo sync -a .'
compdef _repo rs.='repo sync'

alias rsrra='repo sync -a ; repo rebase --auto-stash'
compdef _repo rsrra='repo rebase'

alias rsrra.='repo sync -a .; repo rebase --auto-stash .'
compdef _repo rsrra.='repo rebase'

function rsbrsrra()
{
    if [[ -z $1 ]]; then
        echo "usage: rsbrsrra <branch name>"
        exit 1
    fi
    echo "Starting branch $1 and syncing up all project (repo rebase)"
    repo start $1 --all || return 1
    repo sync -a || return 1
    repo rebase --auto-stash || return 1
}

alias rclean="repo forall -c 'git remote prune umg'"
compdef _repo rclean='repo forall'
