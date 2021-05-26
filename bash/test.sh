
echo "in test.sh, first arg = $1"
echo "in test.sh, second arg = $2"


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
elif test "$1" = "gitpull"
then
	. test-sub.sh "$2"
##

##
else
	echo "Path Not Defined in /c\sharing\cdto.sh"
fi
##

