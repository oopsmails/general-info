#!/bin/bash

## Usage
# chmod +x loopall.sh
# ./loopall.sh /path/to/folder
# if put in PATH folder, then just run, loopall.sh /path/to/folder, i.e, no need to use "."

folder=$1

for file in "$folder"/*
do
  if [ -f "$file" ]
  then
    echo "$file"
  elif [ -d "$file" ]
  then
    bash $0 "$file"
  fi
done

