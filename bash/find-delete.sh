#!/bin/bash

# for f in *; do
#     if [ -d "$f" ]; then
#         # $f is a directory
#     fi
# done


# find . -name ".git" -o -name "*.json"
# find . -name ".git"

# IFS=$'\n'
# paths=($(find . -name ".git"))
# unset IFS

paths=()
while IFS=  read -r -d $'\0'; do
    paths+=("$REPLY")
done < <(find . -name ".git" -print0)

# printf "%s\n" "${paths[@]}"

for str in "${paths[@]}"
do
    printf "%s\n" "${str}"
    rm -rf "$str"
done

