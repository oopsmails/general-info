#!/bin/bash

folder=$1

for file in $folder/*
do
  if [ -f "$file" ]
  then
    echo "$file"
  elif [ -d "$file" ]
  then
    bash $0 "$file"
  fi
done
