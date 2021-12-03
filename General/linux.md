
## VM: kubuntu

### Install Java:

https://linuxize.com/post/install-java-on-ubuntu-18-04/#installing-the-default-openjdk-java-11

#### Installing the Default OpenJDK (Java 11)
`sudo apt update`

`sudo apt install default-jdk`

#### Installing OpenJDK 8
`sudo apt update`

`sudo apt install openjdk-8-jdk`

#### Installing Oracle Java

Oracle Java 11 can be installed from the Linux Uprising PPA.

##### Install the dependencies necessary to add a new repository:

`sudo apt install software-properties-common`

##### Enable the Linux Uprising PPA by running the following commands:

`sudo add-apt-repository ppa:linuxuprising/java`


##### Once the repository is added, update the packages list and install the oracle-java11-installer package by typing:

`sudo apt update`
`sudo apt install oracle-java11-installer`

You will be prompted to accept the Oracle license.

java -version

#### Set the Default Java Version

`sudo update-alternatives --config java`

#### Set the JAVA_HOME Environment Variable

To set the JAVA_HOME environment variable, first, you need to find out the Java installation paths using the update-alternatives command

`sudo update-alternatives --config java`

In our case, the installation paths are as follows:

```
  Selection    Path                                            Priority   Status
------------------------------------------------------------
* 0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      auto mode
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      manual mode
  2            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode

```

Copy the installation path of your preferred installation. 

Next, open the /etc/environment file

`sudo nano /etc/environment`

Add the following line, at the end of the file: /etc/environment

`JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"`

You can either log out and log in or run the following source command to apply the changes to your current session:

`source /etc/environment`

`echo $JAVA_HOME`

`/usr/lib/jvm/java-11-openjdk-amd64`

/etc/environment is a system-wide configuration file, which is used by all users. If you want to set the JAVA_HOME variable on a per-user basis, add the line to the .bashrc or any other configuration file which is loaded when the user logs in.

### Uninstall Java
If for any reason you want to uninstall the Java package, you can uninstall it like any other package installed with apt.

For example, if you want to uninstall the openjdk-8-jdk package run:

`sudo apt remove openjdk-8-jdk`



