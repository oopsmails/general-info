# Linux Script Tips

## Passing input into script

### echo

echo -e "line 1\nline 2\nline 3" | program

echo 2 | sudo alternatives --config java

echo 2 | ssh -p "35903" -i $HOME/sshids/idrsa-1.old ${1} " alternatives --config java"

### Alter between java versions

You can run the alternatives command non-interactively too. Instead of --config, use the --set option to specify the path of the alternative directly.

```

sudo alternatives --set java /location/of/jdk1.6/bin/java

#!/bin/bash
echo "Removing old java 8 symlink.."
sudo unlink /usr/lib/jvm/java
echo "Linking new java.."
sudo ln -s /usr/lib/jvm/new_java /usr/lib/jvm/java

echo "Updating alternatives for java and java compiler"
sudo update-alternatives --set java /usr/lib/jvm/new_java/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/new_java/bin/javac

```

