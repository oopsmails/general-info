#!/bin/bash

declare -a arr=(

"====== aaa API ======"
"https://aaa.com/actuator/health" 

"====== bbb API ======"
"https://bbb.com/actuator/health" 

)

# curl -sk https://aaa.com/actuator/health | grep -c "\"status\": \"UP\""
# curl -s -k --head --request GET --connect-timeout 5 https://aaa.com/actuator/health
# curl -s -k --head --request GET --connect-timeout 5 https://aaa.com/actuator/health

for url in "${arr[@]}"
do
    if [[ "$url" == http* ]]; then
        returnString=$(curl -s -k --head --request GET --connect-timeout 5 "$url")
        # printf 'returnString - %s\n' "$returnString"

        if ( echo "$returnString" | grep -c "200" ) > 0 
        then
            printf '%s - %s\n' "$url" "200"
        
        elif ( echo "$returnString" | grep -c "503" ) > 0 
        then
            printf '%s - %s\n' "$url" "503"

        elif ( echo "$returnString" | grep -c "404" ) > 0 
        then
            printf '%s - %s\n' "$url" "404"

        elif [ -z "$returnString" ];
        then
            printf '%s - %s\n' "$url" "Timeout"

        else
            printf '..... returnString - \n%s\n' "$returnString"
            printf "..... Unknown, run ..... \n%s \n" "curl -s -k --head --request GET --connect-timeout 5 $url"
        fi
    else 
        printf '\n\n%s\n' "$url"
    fi
done

