baseDir="$(dirname "$(readlink -f "$0")")"
[ -f "$baseDir/skt-utils.sh" ] && . "$baseDir/skt-utils.sh"

# code in boot completed, just supported by KernelSU and APatch, not Magisk, but running this script in service.sh is supported

# code after boot completed and before unlocked

until [ -d /sdcard/Android ]; do sleep 1; done

# code after unlocked