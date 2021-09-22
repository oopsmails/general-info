#!/bin/bash

base="/home/albert/Documents"
programs="$base/programs"

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Kafka to $1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"


##
if test "$1" = "start"
then
	sudo systemctl start zookeeper.service
    wait
    sudo systemctl start kafka.service
##

##
elif test "$1" = "stop"
then
	sudo systemctl stop zookeeper.service
    wait
    sudo systemctl stop kafka.service
##

##
elif test "$1" = "status"
then
	systemctl status kafka zookeeper
##

##
elif test "$1" = "ui"
then
	cd $programs/cmk-3.0.0.5/bin
    wait
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    wait
    pwd
    # . cmak
##

##
else
	echo "Path Not Defined in kafka.sh"
fi
##
