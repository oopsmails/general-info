#!/bin/bash

hostArray=(

"dev1api:1.1.1.1"
"ist1api:1.1.1.1"
"uat1api:1.1.1.1"

)

targetHost=""
for toHost in "${hostArray[@]}" ; do
    key="${toHost%%:*}"
    value="${toHost##*:}"
    # printf "%s - %s.\n" "$key" "$value"

    if test "$1" = "$key"
    then
        targetHost="$value"
        printf "Going to ssh %s - %s.\n" "$key" "$value"
        break
    fi
done

ssh userid@$targetHost
