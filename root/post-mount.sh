baseDir="$(dirname "$(readlink -f "$0")")"
[ -f "$baseDir/skt-utils.sh" ] && . "$baseDir/skt-utils.sh" || exit

# code in post-mount, just supported by KernelSU and APatch, not Magisk