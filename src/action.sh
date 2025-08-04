baseDir="$(dirname "$(readlink -f "$0")")"
[ -f "$baseDir/nga-utils.sh" ] && . "$baseDir/nga-utils.sh" || exit

# code in action