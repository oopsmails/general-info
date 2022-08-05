#!/bin/bash

_user="$(id -u -n)"

echo "Staring Spring Boot Application using user id [${_user}]..."

/usr/bin/java -Dcom.oopsmails.api.config.dir=/usr/share/oopsmails/app/conf/api_core -Dspring.config.location=file:/usr/share/oopsmails/app/conf/ -Dnetworkaddress.cache.ttl=900 -Dfile.encoding=ISO-8859-1 -Dspring.config.name=jasyptconf,application -Xloggc:/logs/oopsmails/API/gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintTenuringDistribution -XX:+PrintGCCause -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=10M -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/logs/oopsmails/API -jar oopsmails-api-boot.jar