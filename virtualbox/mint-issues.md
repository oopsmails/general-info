
# Knowledges and Issues When Learning Linus Mint


## linux mint intellij cannot find jdk

- Reason:

When you installing IDE using the software center you installing a flatpack version of IDE.

flatpack has own restrictions to use the file system.

These directories are blacklisted: /lib, /lib32, /lib64, /bin, /sbin, /usr, /boot, /root, /tmp, /etc, /app, /run, /proc, /sys, /dev, /var
Exceptions from the blacklist: /run/media
These directories are mounted under /var/run/host: /etc, /usr
So you have to use path something like /var/run/host/usr/lib/jvm/java-1.8.0-openjdk-amd64


- Solution:

You can try installing IntelliJ IDEA from here and see if it works better. .tar.gz distribution can be launched using ./idea.sh. Note that you can also create a launcher script using Tools>Create Command-line Launcher. This should work with any version.

unzip to /programs, start intellij, go, Tools -> Create Desktop Entry

- More: still need to install OpenJDK

```
sudo apt update

sudo apt install default-jdk # This will install OpenJDK 11

```


## Docker user

albert@albert-mint:~/Documents/github/springboot-dev-repo/spring-boot-kafka-ms-email-files$ docker-compose up
ERROR: Couldn't connect to Docker daemon at http+docker://localhost - is it running?

If it's at a non-standard location, specify the URL with the DOCKER_HOST environment variable.


To create the docker group and add your user:
Create the docker group.

$ sudo groupadd docker

Add your user to the docker group.

$ sudo usermod -aG docker $USER

Log out and log back in so that your group membership is re-evaluated.



