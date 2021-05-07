#echo $1


#### define path locally

github="/c/sharing/github"
githubother="/c/sharing/github-other"

# git bash run open new terminal
alias newterm='start "" "C:\Program Files\Git\git-bash.exe"'
#alias newterm3='start "" "C:\Program Files\Git\git-bash.exe" && start "" "C:\Program Files\Git\git-bash.exe" && start "" "C:\Program Files\Git\git-bash.exe"'

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
	cd /c/sharing/
##


## ------------------------ special cases ----------------------------

##
elif test "$1" = "usingwait"
then
	cd /c/sharing/
	wait
	pwd
##

##
elif test "$1" = "keeplivepy"
then
	cd /home/albert/Documents/programs
	python3 keepLiveByMouseMoving.py
##

##
elif test "$1" = "keeplive"
then
	# cd /c/sharing/
	java -cp /c/sharing MainMouseEvents
##

## run in new terminal
elif test "$1" = "newterm"
then
	newterm -c another-script.sh
##

##
elif test "$1" = "nosqlbooster"
then
	cd /home/albert/Documents/programs
	./nosqlbooster4mongo-6.2.8.AppImage &
##


##
else
	echo "Path Not Defined in /c\sharing\cdto.sh"
fi
##
