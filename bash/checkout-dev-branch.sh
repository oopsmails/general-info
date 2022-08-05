#!/bin/bash

# for f in *; do
#     if [[ "$f" = "*" ]]; then continue; fi
#     if [[ -d "$f" && ! -L "$f" ]]; then
#         # $f is a directory
#     fi
# done

dirArray=()

for d in */ ; do
    [ -L "${d%/}" ] && continue
    dirArray+=("$d")
done

for d in "${dirArray[@]}"
do
    echo "==========================================="
    echo "$d"
    cd $d
    wait
    git checkout feature/development
    wait
    ls
    wait
    echo "==========================================="
    cd ..
done

# function checkOutDevelopmentBranch() {
#     git checkout feature/development
# }

