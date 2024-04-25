#!/bin/bash

## Usage
# . playArgs.sh


# List 

repos=(
    "https://github.com/oopsmails/111-springboot-dev-repo.git"
    "https://github.com/oopsmails/140-springboot-fts.git"
)

# user=$1
# if [ -z "$user" ]; then
#     echo "username is mandatory!"
#     exit 1;
# else
#     echo "username: $user"
# fi

# password=$2
# if [ -z "$password" ]; then
#     echo "password is mandatory!"
#     exit 1;
# else
#     echo "password: $password"
# fi

# branchName=$3
# if [ -z "$branchName" ]; then
#     echo "branchName is mandatory!"
#     exit 1;
# else
#     echo "branchName: $branchName"
# fi

# cloneDir=$4
# if [ -z "$cloneDir" ]; then
#     echo "cloneDir is mandatory!"
#     exit 1;
# else
#     echo "cloneDir: $cloneDir"
# fi

for repo in "${repos[@]}"; 
do
    # calc repo name from url
    repoName=$(basename "$repo" .git)
    echo "repoName: $repoName"

    if [[ ($(echo ${BASH_ARGV[@]} | fgrep -w "bDevRepo") && $repoName == "111-springboot-dev-repo")
            || ($(echo ${BASH_ARGV[@]} | fgrep -w "bFts") && $repoName == "140-springboot-fts")
    ]]
    then
        if [ -d "$cloneDir/$repoName" ]; then
            printf '%s\n' "Removing $cloneDir/$repoName"
            rm -rf "$cloneDir/$repoName"
        fi
    
        # git clone
        git clone "$repo" "$cloneDir/$repoName"

        if [ $? -eq 0 ]; then
            echo -e "\nCloning $repoName was successful. \n";
        else
            echo -e "\nError: url invalid or already cloned. \n";
        fi

        # Navigate the repo dir
        cd "$cloneDir/$repoName"
        git fetch --all && git checkout --force $branchName
        git pull
        git status

        # mvn clean install
        mvn clean install -Dmaven.test.skip=true

        if [ $? -eq 0 ]; then
            echo -e "\nMaven clean install was successful for $repoName. \n";
            # return to then original folder
            cd -
        else
            echo -e "\nMaven clean install failed for $repoName. \n";
            exit 1;
        fi
    fi
done

