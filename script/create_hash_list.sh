workDir="$(pwd)"
targetRoot="$workDir/mod-root"

rm -f "$targetRoot/hashList.dat"
for file in $(find "$targetRoot/" -type f -not -path "*META-INF*"); do
  echo "$(sha1sum "${file}" | awk '{print $1}') ${file#$targetRoot/}" >> "$targetRoot/hashList.txt"
done
truncate -s $(($(stat -c %s "$targetRoot/hashList.txt") - 1)) "$targetRoot/hashList.txt"
cat "$targetRoot/hashList.txt" | base64 -w 0 | gzip -c9 > "$targetRoot/hashList.dat"
rm -f "$targetRoot/hashList.txt"