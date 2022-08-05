#!/bin/bash

DIR_NUM=""
SKIP_TEST="true"

if test "$1" = "1"
then
	DIR_NUM=""
else
	DIR_NUM="$1"
fi

if test "$2" = "false"
then
	SKIP_TEST="false"
fi

DEV_HOME="/c/dev"
DEV_HOME_WIN="C:/dev"
WORKING_DIR_GIT="$DEV_HOME/workspace$DIR_NUM"


echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Will mvn install mvn -DskipTest=$SKIP_TEST !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

. build-common.sh "$DIR_NUM" "$SKIP_TEST"
wait

. build-api.sh "$DIR_NUM" "$SKIP_TEST"
wait

. build-ui.sh "$DIR_NUM" "$SKIP_TEST"
wait

echo "build-all DONE!"

