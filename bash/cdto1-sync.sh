#echo $1


#### define path locally

base="/home/albert/Documents"
sharing="$base/sharing"
programs="$base/programs"

github="$sharing/github"
githubother="$sharing/github-other"

alias newterm='start "" "C:\Program Files\Git\git-bash.exe"'

timestamp="$(date +%F)-$(date +%T)-$(date +%p)"

##
if test "$1" = "github"
then
	cd $github
##

##
elif test "$1" = "githubother"
then
	cd $githubother
##

##
elif test "$1" = "generalinfo"
then
	cd $github/general-info/
##

##
elif test "$1" = "sharing"
then
	cd $sharing
##


##
elif test "$1" = "working"
then
	cd $programs/confluent-6.2.1
	pwd
##


## ----------------------------------------------------

##
elif test "$1" = "here"
then
	# cd /c/sharing/
	java -cp $sharing MainMouseEvents
##

##
elif test "$1" = "dockerkafka"
then
	if test "$2" = "up"
	then
		docker-compose -f /home/albert/Documents/sharing/github/springboot-dev-repo/spring-boot-kafka-docker/docker-compose-confluentinc-20210920-withSchemaRegistry.yaml up -d
	else
		docker-compose -f /home/albert/Documents/sharing/github/springboot-dev-repo/spring-boot-kafka-docker/docker-compose-confluentinc-20210920-withSchemaRegistry.yaml "$2"
	fi
##

##
elif test "$1" = "ckafka"
then
	cd $programs/confluent-6.2.1
	pwd
	./bin/kafka-storage format --config ./etc/kafka/kraft/server.properties --cluster-id $(./bin/kafka-storage random-uuid)
	wait
	./bin/kafka-server-start ./etc/kafka/kraft/server.properties
##


##
elif test "$1" = "kafdrop"
then
	cd $sharing/jars
	java -jar kafdrop.jar --schemaregistry.connect=http://localhost:8081
##

##
elif test "$1" = "akhq"
then
	cd $sharing/jars/akhq
	java -Dmicronaut.config.files=application.yml -jar akhq.jar
##

##
elif test "$1" = "newterm"
then
	newterm
##

##
else
	echo "Path Not Defined in /c\sharing\cdto.sh"
fi
##
