#echo $1


#### define path locally

base="/home/albert/Documents"
github="$base/github"
githubother="$base/github-other"

timestamp="$(date +%F)-$(date +%T)-$(date +%p)"

##############################
# git bash run open new terminal

# https://askubuntu.com/questions/484993/run-command-on-anothernew-terminal-window
# xterm -hold -e 'apropos editor' & 
# Note the -hold. Most terminals will exit after running the command you feed them.

# xterm -e 'apropos editor | less' & 

# gnome-terminal -e "bash -c \"apropos editor; exec bash\""
##############################

# alias newterm='start "" "C:\Program Files\Git\git-bash.exe"' # windows

#alias newterm3='start "" "C:\Program Files\Git\git-bash.exe" && start "" "C:\Program Files\Git\git-bash.exe" && start "" "C:\Program Files\Git\git-bash.exe"'

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

## Linux open in new terminal tab and run command
elif test "$1" = "test"
then
	# gnome-terminal -e "bash -c \"apropos editor; exec bash\""
	gnome-terminal --tab -e "bash -c \"apropos editor; exec bash\""
##

##
elif test "$1" = "test2"
then
	cd /c/sharing/
	LOG_FILE="/c/temp/logs"
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
	cd /home/albert/Documents/programs
	./nosqlbooster4mongo-6.2.8.AppImage &
##



##
else
	echo "Path Not Defined in /c\sharing\cdto.sh"
fi
##
