#echo $1

#### define path locally

base="/home/albert/Documents"
sharing="$base/sharing"
programs="$base/programs"

github="$sharing/github"
githubother="$sharing/github-other"

timestamp="$(date +%F)-$(date +%T)-$(date +%p)"

alias newterm='gnome-terminal --tab' # Linux

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
elif test "$1" = "sharing"
then
	cd $sharing
##

##
elif test "$1" = "programs"
then
	cd $programs
##

##
elif test "$1" = "generalinfo"
then
	cd $github/general-info/
##

## ------------------------ special cases ----------------------------

##
elif test "$1" = "kafka"
then
	. kafka.sh "$2"
##

##
elif test "$1" = "usingwait"
then
	cd $sharing
	wait
	pwd
##

##
elif test "$1" = "keeplivepy"
then
	cd $programs
	python3 keepLiveByMouseMoving.py
##

##
elif test "$1" = "keeplive"
then
	cd $sharing
	java -cp $sharing MainMouseEvents
##

## run in new terminal
elif test "$1" = "newterm"
then
	newterm -c another-script.sh
##

## Linux open in new terminal tab and run command
elif test "$1" = "test"
then
	# gnome-terminal -e "bash -c \"apropos editor; exec bash\""
	gnome-terminal --tab -e "bash -c \"apropos editor; exec bash\""
##

##
elif test "$1" = "test2"
then
	cd $sharing
	LOG_FILE="$sharing/logs"
	ls -l 2>$1 | tee "$LOG_FILE/$timestamp testLog.log"
	wait
	pwd
##

##
elif test "$1" = "gitpull"
then
	. gitpull-all.sh "$2"
##


##
elif test "$1" = "nosqlbooster"
then
	cd $programs
	./nosqlbooster4mongo-6.2.8.AppImage &
##

##
else
	echo "Path Not Defined in cdto.sh"
fi
##
