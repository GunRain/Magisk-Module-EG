targetRoot=mod-root

for file in $(find "$targetRoot/"); do
  touch -c -t 000001010000 "$file"
done