# useful code by Sakitin(GitHub@GunRain 酷安@芙洛洛 bilibili@安音咲汀)

# GitHub link: https://github.com/GunRain/Magisk-Module-EG/blob/aaa/mod-root/skt-utils.sh

alias del=rm # for rm check

skt_abort() {
  type abort >/dev/null 2>&1 && abort "$@" || { echo "$@"; exit 1; }
}

get_target_bin() {
  targetDir="$1"
  fileName="$2"
  targetArch="$3"
  mv -f "$targetDir/$fileName.$targetArch" "$targetDir/$fileName" || skt_abort "! Arch \"$targetArch\" is not supported!"
  del -f $targetDir/$fileName.*
  chmod a+x "$targetDir/$fileName"
}

until_key() {
  while :; do
    eventInfo="$(getevent -qlc 1)"
    eventType="$(echo -n "$eventInfo" | awk '{print $2}')"
    [ "$eventType" = EV_KEY ] || continue
    eventValue="$(echo -n "$eventInfo" | awk '{print $4}')"
    [ "$eventValue" = DOWN ] || continue
    eventCode="$(echo -n "$eventInfo" | awk '{print $3}')"
    case "$eventCode" in
      KEY_VOLUMEUP) echo -n up; return;;
      KEY_VOLUMEDOWN) echo -n down; return;;
      KEY_POWER) echo -n power; return;;
    esac
  done
}

until_key_up() {
  until [ `until_key` = up ]; do
    sleep 0.1
  done
}

until_key_down() {
  until [ `until_key` = down ]; do
    sleep 0.1
  done
}

until_key_power() {
  until [ `until_key` = power ]; do
    sleep 0.1
  done
}

get_work_dir() {
  dirname "$(readlink -f "$1")"
}

until_boot() {
  resetprop -w sys.boot_completed 0 >/dev/null 2>&1
  [ -z "$1" ] || sleep "$1"
}

until_unlock() {
  until_boot
  until [ -d /sdcard/Android ]; do sleep 1; done
  [ -z "$1" ] || sleep "$1"
}

run_bin() {
  file="$1"
  [ -f "$file" ] || return 1
  chmod a+x "$file" 2>/dev/null
  shift
  eval "\"$file\" $@"
}

nohup_bin() {
  file="$1"
  [ -f "$file" ] || return 1
  chmod a+x "$file" 2>/dev/null
  shift
  eval "nohup \"$file\" $@ >/dev/null 2>&1 &" &
}

magisk_run_completed() {
  [ "$KSU$APATCH" != true ] && [ -f "$1/boot-completed.sh" ] && { . "$1/boot-completed.sh"; exit; }
}

set_dir_perm() {
  for dir in `find ${@} -type d`; do
    chmod 0755 "$dir"
  done
}

set_system_file() {
  chcon -R u:object_r:system_file:s0 ${@}
}

skt_install_init() {
  [ -z "$MODPATH" ] && skt_abort '! Value "MODPATH" does not exist!'

  # Check files
  hashListFile="$MODPATH/hashList.dat"
  [ -f "$hashListFile" ] || skt_abort '! File "hashList.dat" does not exist!'
  hashList="$(cat "$hashListFile" | zcat | base64 -d)"
  for file in $(find "$MODPATH/" -type f -not -path '*META-INF*' -not -name hashList.dat); do
    [ "$(echo -n "$hashList" | grep -E " ${file#$MODPATH/}$" | awk '{print $1}')" = "$(sha1sum "$file" | awk '{print $1}')" ] || skt_abort "! Failed to verify file \"${file#$MODPATH/}\"!"
  done
  del -f "$hashListFile"

  # For Sakitin
  [ "$1" = official ] && ui_print '- Official website: https://www.mod.latestfile.zip'
}

skt_install_done() {
  [ -z "$MODPATH" ] && skt_abort '! Value "MODPATH" does not exist!'
  [ -z "$ARCH" ] && skt_abort '! Value "ARCH" does not exist!'

  # For overlyfs
  [ -d "$MODPATH/system" ] && {
    set_dir_perm "$MODPATH/system"
    set_system_file "$MODPATH/system"
  }

  # Clean zygisk libs
  case "$ARCH" in
    arm64) del -f $MODPATH/zygisk/x*.so $MODPATH/zygisk/riscv*.so;;
    arm) del -f $MODPATH/zygisk/x*.so $MODPATH/zygisk/riscv*.so $MODPATH/zygisk/*64*.so;;
    x64) del -f $MODPATH/zygisk/riscv*.so;;
    x86) del -f $MODPATH/zygisk/riscv*.so $MODPATH/zygisk/*64*.so;;
    riscv64) del -f $MODPATH/zygisk/arm*.so $MODPATH/zygisk/x*.so;;
  esac
}