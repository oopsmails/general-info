#echo $1


#### /c/GitHub

##
if test "$1" = "github"
then
	cd /c/GitHub
##

##
elif test "$1" = "generalinfo"
then
	cd /c/github/general-info/
##


##
elif test "$1" = "githubother"
then
	cd /c/githubother/skeleton
##



##
else
	echo "Path Not Defined in /c\Liu\cdto.sh"
fi
##
