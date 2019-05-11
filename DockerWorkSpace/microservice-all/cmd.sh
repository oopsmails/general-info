#echo $1


#### /c/GitHub

##
if test "$1" = "ps"
then
	docker ps -a
##

##
elif test "$1" = "image"
then
	docker images
##

##
elif test "$1" = "backendmock"
then
	cd /c/GitHub/springboot2-app-all/springboot2-app-all-backendmock/
##

##
else
	echo "Path Not Defined in /c\Liu\cdto.sh"
fi
##
