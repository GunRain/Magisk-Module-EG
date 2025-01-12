baseDir="$(get_work_dir "$0")"
[ -f "$baseDir/skt-utils.sh" ] && . "$baseDir/skt-utils.sh"

# code in boot completed, just supported by KernelSU and APatch, not Magisk, but running this script in service.sh is supported

# code after boot completed and before unlocked

until_unlock

# code after unlocked