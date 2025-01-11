targetRoot=mod-root
targetName=instpkg.zip

exe_7za="$(command -v 7za || command -v 7za.exe || exit 1)"
cd "$targetRoot/"
"$exe_7za" a -tzip instpkg.zip -mmt24 -mx9 -r *
mv -f "$targetName" "../$targetName"
cd ..