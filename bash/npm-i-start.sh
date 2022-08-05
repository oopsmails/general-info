#!/bin/bash

DEV_HOME="/c/dev"
DEV_HOME_WIN="C:/dev"

DEV_HOME_API="$DEV_HOME/workspace$1"

# boot-api
BOOT_API_UI="$DEV_HOME_API/boot_api_ui"

cd ${BOOT_API_UI}
pwd

npm i

wait

npm start
