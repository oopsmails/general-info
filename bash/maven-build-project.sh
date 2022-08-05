#!/bin/bash

# echo "========> passed in first arg = $1"
# echo "========> passed in second arg = $2"

DEV_HOME="/c/dev"
DEV_HOME_WIN="C:/dev"

DEV_HOME_API="$DEV_HOME/workspace$1"

# boot-api
BOOT_API_COMMON="$DEV_HOME_API/boot_api_common"

# boot_api_common/api-bom
BOOT_API_COMMON_BOM="$BOOT_API_COMMON/api-bom"

cd ${BOOT_API_COMMON_BOM}
pwd

timestamp="$(date +%F)-$(date +%T)-$(date +%p)"
LOG_FILE="/c/temp/logs"

# mvn -DskipTests=true install 2>&1 | tee "$LOG_FILE/$timestamp api-build-common-bom.log"

##
if [ -z ${1+x} ] # where ${var+x} is a parameter expansion which evaluates to nothing if var is unset, and substitutes the string x otherwise.
then
    echo '-DskipTests is not set, default to true'
	mvn -DskipTest=true install 2>&1 | tee "$LOG_FILE/$timestamp api-build-bom.log"
    # ls -l
    
##
##
else
    echo "-DskipTests is set, -DskipTests=$2"
    mvn -DskipTests=$2 install 2>&1 | tee "$LOG_FILE/$timestamp api-build-bom.log"
    # ls -ltr
fi
##

wait
pwd

# boot_api_common/api-parent
BOOT_API_COMMON_PARENT="$BOOT_API_COMMON/api-parent"

cd ${BOOT_API_COMMON_PARENT}
pwd

# mvn -DskipTests=true install 2>&1 | tee "$LOG_FILE/$timestamp api-build-common-parent.log"

##
if [ -z ${1+x} ] # where ${var+x} is a parameter expansion which evaluates to nothing if var is unset, and substitutes the string x otherwise.
then
    echo '-DskipTests is not set, default to true'
	mvn -DskipTest=true install 2>&1 | tee "$LOG_FILE/$timestamp api-build-parent.log"
    # ls -l
    
##
##
else
    echo "-DskipTests is set, -DskipTests=$2"
    mvn -DskipTests=$2 install 2>&1 | tee "$LOG_FILE/$timestamp api-build-parent.log"
    # ls -ltr
fi
##

wait
pwd

# boot_api_common
cd ${BOOT_API_COMMON}
pwd

# mvn -DskipTests=true install 2>&1 | tee "$LOG_FILE/$timestamp api-build-common.log"

##
if [ -z ${1+x} ] # where ${var+x} is a parameter expansion which evaluates to nothing if var is unset, and substitutes the string x otherwise.
then
    echo '-DskipTests is not set, default to true'
	mvn -DskipTest=true install 2>&1 | tee "$LOG_FILE/$timestamp api-build-common.log"
    # ls -l
    
##
##
else
    echo "-DskipTests is set, -DskipTests=$2"
    mvn -DskipTests=$2 install 2>&1 | tee "$LOG_FILE/$timestamp api-build-common.log"
    # ls -ltr
fi
##

wait
pwd

