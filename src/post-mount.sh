# shellcheck shell=ash

baseDir="$(dirname "$(readlink -f "$0")")"
# shellcheck disable=SC1091
[ -f "$baseDir/nga-utils.sh" ] && . "$baseDir/nga-utils.sh" || exit

# code in post-mount, just supported by ShiroSU, KernelSU and APatch, not Magisk
