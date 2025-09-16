baseDir="$(dirname "$(readlink -f "$0")")"
[ -f "$baseDir/nga-utils.sh" ] && . "$baseDir/nga-utils.sh" || exit

# code in boot completed, just supported by ShiroSU, KernelSU and APatch, not Magisk, but running this script in service.sh is supported

# code after boot completed and before unlocked

until_unlock

# code after unlocked