

echo "in test-sub.sh, first arg = $1"
echo "in test-sub.sh, second arg = $2"

LOG_FILE="/C/"
THE_WORD_FAILURE="FAILURE"
THE_WORD_ABORTING="Aborting"

echo echo "=================== Checking $1 $LOGFILE ===================================="

cd $GIT_HUB_HOME
pwd

for f in *; do
    if [ -f "$f" ]; then
        # $f is a file
        echo "=================== will be working on: $f =========================="
        if grep -q "$THE_WORD_FAILURE" $f
            then
                echo "String $THE_WORD_FAILURE found in $f"
            # else
            #     echo "String $THE_WORD_FAILURE not found in $f"
        fi

        if grep -q "$THE_WORD_ABORTING" $f
            then
                echo "String $THE_WORD_ABORTING found in $f"
        fi
    fi
done

