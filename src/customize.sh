# shellcheck shell=ash

# shellcheck disable=SC1091,SC2015
[ -f "$MODPATH/nga-utils.sh" ] && . "$MODPATH/nga-utils.sh" || abort '! File "nga-utils.sh" does not exist!'
nga_install_init # Don't write code before this line!

# code in install

nga_install_done # Don't write code after this line!
