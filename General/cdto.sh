#echo $1


#### /c/GitHub

##
if test "$1" = "github"
then
	cd /c/GitHub
##

##
elif test "$1" = "msall"
then
	cd /c/GitHub/spring-cloud-microservices-all
##

##
elif test "$1" = "backendmock"
then
	cd /c/GitHub/springboot2-app-all/springboot2-app-all-backendmock/
##

##
elif test "$1" = "mongofrontend"
then
	cd /c/GitHub/spring-boot-mongodb-security-angular8-frontend/
##

##
elif test "$1" = "springbootms"
then
	cd /c/GitHub/springboot-microservices/
##

##
elif test "$1" = "recipe"
then
	cd /c/GitHub/angular-ionic-recipe/
##

##
elif test "$1" = "mongobackend"
then
	cd /c/GitHub/spring-boot-mongodb-security-angular8-backend/
##

##
elif test "$1" = "generalinfo"
then
	cd /c/GitHub/general-info/
##

##
elif test "$1" = "nodejssimple"
then
	cd /c/GitHub/nodejs-simple-rest/
##

##
elif test "$1" = "angularinte"
then
	cd /c/GitHub/angular-integration
##

##
elif test "$1" = "bootparent"
then
	cd /c/GitHub/bootparent
##

##
elif test "$1" = "skeleton"
then
	cd /c/GitHub/skeleton
##


#### /c/GitHubOthers

##
elif test "$1" = "githubother"
then
	cd /c/GitHubOthers/skeleton
##

##
elif test "$1" = "be3"
then
	cd /c/GitHubOthers/skeleton
##

#### /c/GithubStaging

##
elif test "$1" = "stagingoauthui"
then
	cd /c/GithubStaging/spring-cloud-microservices-all-oauth2-ui
##

##
elif test "$1" = "gitlocal"
then
	cd /c/git-local-repo
##


#### GitHub2

##
elif test "$1" = "github2"
then
	cd /c/GitHub2
##


#### docker-ws

##
elif test "$1" = "dockerws"
then
	cd /c/projects/docker-ws
##
##
elif test "$1" = "dockermsall"
then
	cd /c/Github/general-info/DockerWorkSpace/microservice-all
##

#### Softwares

##
elif test "$1" = "kafka"
then
	cd /c/Software/kafka_2.11-2.1.0/bin/windows
##


##
else
	echo "Path Not Defined in /c\Liu\cdto.sh"
fi
##
