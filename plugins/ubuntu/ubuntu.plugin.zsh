<<<<<<< HEAD
# Authors:
# https://github.com/AlexBio
# https://github.com/dbb
# https://github.com/Mappleconfusers
# Nicolas Jonas nextgenthemes.com
#
# Debian, Ubuntu and friends related zsh aliases and functions for zsh

alias acs='apt-cache search'
compdef _acs acs='apt-cache search'

alias afs='apt-file search --regexp'
compdef _afs afs='apt-file search --regexp'

# These are apt-get only
alias ags='apt-get source'   # asrc
compdef _ags ags='apt-get source'

alias acp='apt-cache policy' # app
compdef _acp acp='apt-cache policy'

# superuser operations ######################################################
alias afu='sudo apt-file update'
compdef _afu afu='sudo apt-file update'

alias ppap='sudo ppa-purge'
compdef _ppap ppap='sudo ppa-purge'

alias ag='sudo apt-get'            # age - but without sudo
alias aga='sudo apt-get autoclean' # aac
alias agb='sudo apt-get build-dep' # abd
alias agc='sudo apt-get clean'     # adc
alias agd='sudo apt-get dselect-upgrade' # ads
alias agi='sudo apt-get install'  # ai
alias agp='sudo apt-get purge'    # ap
alias agr='sudo apt-get remove'   # ar
alias agu='sudo apt-get update'   # ad
alias agud='sudo apt-get update && sudo apt-get dist-upgrade' #adu
alias agug='sudo apt-get upgrade' # ag
alias aguu='sudo apt-get update && sudo apt-get upgrade'      #adg

compdef _ag ag='sudo apt-get'
compdef _aga aga='sudo apt-get autoclean'
compdef _agb agb='sudo apt-get build-dep'
compdef _agc agc='sudo apt-get clean'
compdef _agd agd='sudo apt-get dselect-upgrade'
compdef _agi agi='sudo apt-get install'
compdef _agp agp='sudo apt-get purge'
compdef _agr agr='sudo apt-get remove'
compdef _agu agu='sudo apt-get update'
compdef _agud agud='sudo apt-get update && sudo apt-get dist-upgrade'
compdef _agug agug='sudo apt-get upgrade'
compdef _aguu aguu='sudo apt-get update && sudo apt-get upgrade'

# Remove ALL kernel images and headers EXCEPT the one in use
alias kclean='sudo aptitude remove -P ?and(~i~nlinux-(ima|hea) \
	?not(~n`uname -r`))'

# Misc. #####################################################################
# print all installed packages
alias allpkgs='aptitude search -F "%p" --disable-columns ~i'
=======
(( $+commands[apt] )) && APT=apt || APT=apt-get

alias acs='apt-cache search'

alias afs='apt-file search --regexp'

# These are apt/apt-get only
alias ags="$APT source"

alias acp='apt-cache policy'

#List all installed packages
alias agli='apt list --installed'

# List available updates only
alias aglu='apt list --upgradable'

alias acsp='apt-cache showpkg'
compdef _acsp acsp='apt-cache showpkg'

# superuser operations ######################################################

alias afu='sudo apt-file update'

alias ppap='sudo ppa-purge'

alias age="sudo $APT"
alias aga="sudo $APT autoclean"
alias agb="sudo $APT build-dep"
alias agc="sudo $APT clean"
alias agd="sudo $APT dselect-upgrade"
alias agi="sudo $APT install"
alias agp="sudo $APT purge"
alias agr="sudo $APT remove"
alias agu="sudo $APT update"
alias agud="sudo $APT update && sudo $APT dist-upgrade"
alias agug="sudo $APT upgrade"
alias aguu="sudo $APT update && sudo $APT upgrade"
alias agar="sudo $APT autoremove"


# Remove ALL kernel images and headers EXCEPT the one in use
alias kclean='sudo aptitude remove -P ?and(~i~nlinux-(ima|hea) ?not(~n`uname -r`))'

# Misc. #####################################################################
# print all installed packages
alias allpkgs='dpkg --get-selections | grep -v deinstall'
>>>>>>> 4d9e5ce9a7d8db3c3aadcae81580a5c3ff5a0e8b

# Create a basic .deb package
alias mydeb='time dpkg-buildpackage -rfakeroot -us -uc'

# apt-add-repository with automatic install/upgrade of the desired package
# Usage: aar ppa:xxxxxx/xxxxxx [packagename]
<<<<<<< HEAD
# If packagename is not given as 2nd arument the function will ask for it and guess the defaupt by taking
# the part after the / from the ppa name wich is sometimes the right name for the package you want to install
aar() {
=======
# If packagename is not given as 2nd argument the function will ask for it and guess the default by taking
# the part after the / from the ppa name which is sometimes the right name for the package you want to install
function aar() {
>>>>>>> 4d9e5ce9a7d8db3c3aadcae81580a5c3ff5a0e8b
	if [ -n "$2" ]; then
		PACKAGE=$2
	else
		read "PACKAGE?Type in the package name to install/upgrade with this ppa [${1##*/}]: "
	fi
<<<<<<< HEAD
	
	if [ -z "$PACKAGE" ]; then
		PACKAGE=${1##*/}
	fi
	
	sudo apt-add-repository $1 && sudo apt-get update
	sudo apt-get install $PACKAGE
=======

	if [ -z "$PACKAGE" ]; then
		PACKAGE=${1##*/}
	fi

	sudo apt-add-repository $1 && sudo $APT update
	sudo $APT install $PACKAGE
>>>>>>> 4d9e5ce9a7d8db3c3aadcae81580a5c3ff5a0e8b
}

# Prints apt history
# Usage:
#   apt-history install
#   apt-history upgrade
#   apt-history remove
#   apt-history rollback
#   apt-history list
<<<<<<< HEAD
# Based On: http://linuxcommando.blogspot.com/2008/08/how-to-show-apt-log-history.html
apt-history () {
=======
# Based On: https://linuxcommando.blogspot.com/2008/08/how-to-show-apt-log-history.html
function apt-history() {
>>>>>>> 4d9e5ce9a7d8db3c3aadcae81580a5c3ff5a0e8b
  case "$1" in
    install)
      zgrep --no-filename 'install ' $(ls -rt /var/log/dpkg*)
      ;;
    upgrade|remove)
      zgrep --no-filename $1 $(ls -rt /var/log/dpkg*)
      ;;
    rollback)
      zgrep --no-filename upgrade $(ls -rt /var/log/dpkg*) | \
        grep "$2" -A10000000 | \
        grep "$3" -B10000000 | \
        awk '{print $4"="$5}'
      ;;
    list)
<<<<<<< HEAD
      zcat $(ls -rt /var/log/dpkg*)
=======
      zgrep --no-filename '' $(ls -rt /var/log/dpkg*)
>>>>>>> 4d9e5ce9a7d8db3c3aadcae81580a5c3ff5a0e8b
      ;;
    *)
      echo "Parameters:"
      echo " install - Lists all packages that have been installed."
      echo " upgrade - Lists all packages that have been upgraded."
      echo " remove - Lists all packages that have been removed."
      echo " rollback - Lists rollback information."
      echo " list - Lists all contains of dpkg logs."
      ;;
  esac
}

# Kernel-package building shortcut
<<<<<<< HEAD
kerndeb () {
    # temporarily unset MAKEFLAGS ( '-j3' will fail )
    MAKEFLAGS=$( print - $MAKEFLAGS | perl -pe 's/-j\s*[\d]+//g' )
    print '$MAKEFLAGS set to '"'$MAKEFLAGS'"
	appendage='-custom' # this shows up in $ (uname -r )
    revision=$(date +"%Y%m%d") # this shows up in the .deb file name

    make-kpkg clean

    time fakeroot make-kpkg --append-to-version "$appendage" --revision \
        "$revision" kernel_image kernel_headers
=======
function kerndeb() {
  # temporarily unset MAKEFLAGS ( '-j3' will fail )
  MAKEFLAGS=$( print - $MAKEFLAGS | perl -pe 's/-j\s*[\d]+//g' )
  print '$MAKEFLAGS set to '"'$MAKEFLAGS'"
  appendage='-custom' # this shows up in $(uname -r)
  revision=$(date +"%Y%m%d") # this shows up in the .deb file name

  make-kpkg clean

  time fakeroot make-kpkg --append-to-version "$appendage" --revision \
      "$revision" kernel_image kernel_headers
>>>>>>> 4d9e5ce9a7d8db3c3aadcae81580a5c3ff5a0e8b
}

# List packages by size
function apt-list-packages {
<<<<<<< HEAD
    dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | \
    grep -v deinstall | \
    sort -n | \
    awk '{print $1" "$2}'
=======
  dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | \
  grep -v deinstall | \
  sort -n | \
  awk '{print $1" "$2}'
>>>>>>> 4d9e5ce9a7d8db3c3aadcae81580a5c3ff5a0e8b
}
