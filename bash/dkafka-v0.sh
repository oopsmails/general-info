#!/bin/bash

base="/home/albert/Documents"
sharing="$base/sharing"

##
if test "$1" = "up"
then
	cd $sharing
	pwd
	docker-compose -f docker-compose-ckafka.yaml up -d
##

##
elif test "$1" = "down" || test "$1" = "start" || test "$1" = "stop"
then
	cd $sharing
	pwd
	docker-compose -f docker-compose-ckafka.yaml "$1"

##

##
else
	echo "Path Not Defined in /c\sharing\cdto.sh"
fi
##
