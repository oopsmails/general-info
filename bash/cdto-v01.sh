#echo $1


#### define path locally

base="/home/albert/Documents"
sharing="$base/sharing"
programs="$base/programs"
dev="$base/dev"

github="$sharing/github"
githubother="$sharing/github-other"

ckafka="$programs/confluent-6.2.0"

alias newterm='start "" "C:\Program Files\Git\git-bash.exe"'

timestamp="$(date +%F)-$(date +%T)-$(date +%p)"

##
if test "$1" = "github"
then
	cd $github
##

##
elif test "$1" = "programs"
then
	cd $programs
##

##
elif test "$1" = "dev"
then
	cd $dev
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
elif test "$1" = "angulardev"
then
	cd $dev/angular/angular-ngrx-store/angular-ngrx-store-dev
##

##
elif test "$1" = "angularinte"
then
	cd $dev/angular/angular-integration
##

##
elif test "$1" = "reactdev"
then
	cd $github/react-sandbox
##

##
elif test "$1" = "sharing"
then
	cd $sharing
##


##
elif test "$1" = "working"
then
	cd ~/Documents/sharing/github/springboot-dev-repo/spring-boot-mock-backend
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
elif test "$1" = "jenkins"
then
	cd $dev/jenkins
	docker-compose up -d
	wait
	pwd
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
	cd $ckafka
	pwd
	./bin/kafka-storage format --config ./etc/kafka/kraft/server.properties --cluster-id $(./bin/kafka-storage random-uuid)
	wait
	./bin/kafka-server-start ./etc/kafka/kraft/server.properties
##

##
elif test "$1" = "ckafkasr"
then
	cd $ckafka
	pwd
	./bin/schema-registry-start ./etc/schema-registry/schema-registry.properties
##

##
elif test "$1" = "jmeter"
then
	cd $programs/apache-jmeter-5.4.1
	pwd
	sh ./bin/jmeter.sh
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
	java -Dmicronaut.config.files=akhq-application.yml -jar akhq.jar
##

##
elif test "$1" = "java17"
then
	export JAVA_HOME=/opt/jdk-17
	wait
	export PATH=$PATH:$JAVA_HOME/bin 
	wait
	# source ~/.bashrc
	# wait
	java -version
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


function log() {
	current_time=$(date "+%F %T")
	sudo echo "$current_time: $1"
}

