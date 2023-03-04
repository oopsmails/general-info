

#!/bin/bash

dev=/c/dev

# bk_folder=/c/dev/bk_${date + "%Y%m%d"}
bk_folder=/c/dev/bk/bk_$(date +%Y%m%d)

##
if test "$1" = "workspace"
then
	cd $dev/workspace$2
    pwd
else
	echo "Path Not Defined ...."
    exit 1
fi

echo "String backup ...................."

# bk-files-list.log, Notepad ++ replace, using "Extended" Search Mode, replace "M aaa to \nM aaa", "?? to \n??""

mkdir -p $bk_folder

for f in *; do
    if [ -d "$f" ]; then
        # Will not run if no directories are available
        echo "============================ Will be working in: $f ======================================="
        cd $f
        pwd

        if ! git rev-parse --git-dir >/dev/null 2>&1; then
            echo "Not a git repo"
            # cd ..
        else
            # COMMAND_LIST=$(git diff --name-only HEAD) # only changed files
            COMMAND_LIST=$(git status --porcelain | awk '{print $2}') # including NEW files
            # COMMAND_LIST_LOG="$(git status --porcelain | awk '{print $2}')" # double quotes to keep line break
            COMMAND_LIST_LOG="$(git status --porcelain)" # no awk to keep as is

            bk_folder_sub=$bk_folder"/"$f

            echo $bk_folder_sub

            mkdir -p $bk_folder_sub

            echo "Copying to ............. $bk_folder_sub"
            echo $COMMAND_LIST_LOG 2>&1 | tee -a "$bk_folder_sub/bk-files-list.log"
            for FILE in $COMMAND_LIST
            do 
                echo ./$FILE
                echo $bk_folder_sub
                # cp $FILE $bk_folder_sub
                if [ -d "$FILE" ]; then
                    cp -r $FILE $bk_folder_sub
                else
                    cp $FILE $bk_folder_sub
                fi
            done
        fi
        
        wait
        cd ..
    fi
done


echo "done!"