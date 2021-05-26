

echo "in test-sub.sh, first arg = $1"
echo "in test-sub.sh, second arg = $2"

GIT_HUB_HOME="/C/github"

cd $GIT_HUB_HOME
pwd

for f in *; do
    if [ -d "$f" ]; then
        # $f is a directory
        echo "=================== will be working in: $f"
        cd $f
        pwd
        git pull
        wait
        cd ..
    fi
done

