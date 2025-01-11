baseDir="$(dirname "$(readlink -f "$0")")"
[ -f "$baseDir/skt-utils.sh" ] && . "$baseDir/skt-utils.sh"

# code before boot completed

resetprop -w sys.boot_completed 0

# code after boot completed and before unlocked

# run boot-completed.sh if it exists and root is not supported by KernelSU or APatch, then other code in this script will not run
[ "$KSU$APATCH" != true ] && [ -f "$baseDir/boot-completed.sh" ] && { . "$baseDir/boot-completed.sh"; exit; }

until [ -d /sdcard/Android ]; do sleep 1; done

# code after unlocked