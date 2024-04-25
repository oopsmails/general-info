#!/bin/bash

## Usage
# . playArgs.sh

repos=(
    "https://github.com/oopsmails/111-springboot-dev-repo.git"
    "https://github.com/oopsmails/140-springboot-fts.git"
)

springServerIpDev="192.168.0.1"
springServerIpQa="192.168.0.2"

springServerUserDev="deployUserDev"
springServerUserQa="deployUserQa"

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

if [[ ($(echo ${BASH_ARGV[@]} | fgrep -w "dDevRepo") ]]
then
    repoDir=$cloneDir/"111-springboot-dev-repo"
    echo "repoDir: $repoDir"

    # define different deploy env
    if [[ ($(echo ${BASH_ARGV[@]} | fgrep -w "toDev") ]]
    then
        serverIp=$springServerIpDev
        env="DEV"
        serverUser=$springServerUserDev
    elif [[ ($(echo ${BASH_ARGV[@]} | fgrep -w "toQa") ]]
    then
        serverIp=$springServerIpQa
        env="DEV"
        serverUser=$springServerUserQa
    else
        echo "Error: Deployment environment not provided!"
        exit 1
    fi

    serverJarDir="/opt/111-springboot-dev-repo"
    serverJarFile=$serverJarDir"/111-springboot-dev-repo.jar"
    serverConfigDir="/usr/share/111-springboot-dev-repo/conf"

    execFiles=($repoDir/111-springboot-dev-repo/target/111-springboot-dev-repo-*-exec.jar)
    configFiles=($repoDir/111-springboot-dev-repo/target/111-springboot-dev-repo-*-config.zip)

    if [ -e "${execFiles[0]}" ] && [ -e "${configFiles[0]}" ]
    then 
        echo "Info: Found jar and config files."

        plink -pw $password -ssh -batch $user@$serverIp "rm -r tmp"
        plink -pw $password -ssh -batch $user@$serverIp "mkdir tmp"

        pscp -pw $password $repoDir/target/111-springboot-dev-repo-*-exec.jar $user@$serverIp:/home/$user/tmp/111-springboot-dev-repo.jar
        pscp -pw $password $repoDir/target/111-springboot-dev-repo-*-config.jar $user@$serverIp:/home/$user/tmp/111-springboot-dev-repo-config.zip

        plink -pw $password -ssh -batch $user@$serverIp "unzip -o ./tmp/111-springboot-dev-repo-config.zip ./tmp"
        plink -pw $password -ssh -batch $user@$serverIp "echo $password | sudo -S cp ./tmp/111-springboot-dev-repo.jar $serverJarDir"
        # in git repo, config/dev or config/qa
        plink -pw $password -ssh -batch $user@$serverIp "echo $password | sudo -S cp ./tmp/conf/$evn/. $serverConfigDir"

        plink -pw $password -ssh -batch $user@$serverIp "echo $password | sudo -S chmod -R 755 $serverJarFile && sudo -S chown -R $serverUser $serverJarDir && sudo -S chgrp -R $serverUserGroup $serverJarDir"
        plink -pw $password -ssh -batch $user@$serverIp "echo $password | sudo -S chmod -R 755 $serverConfigDir && sudo -S chown -R $serverUser $serverConfigDir && sudo -S chgrp -R $serverUserGroup $serverConfigDir"

        plink -pw $password -ssh -batch $user@$serverIp "echo $password | sudo -S service 111-springboot-dev-repo restart"
    else
        echo "Error: jar or config file NOT found!"
    fi
fi


if [[ ($(echo ${BASH_ARGV[@]} | fgrep -w "dFts") ]]
then
    repoDir=$cloneDir/"140-springboot-fts"
    echo "repoDir: $repoDir"

    # similiar to above .................................................
fi

