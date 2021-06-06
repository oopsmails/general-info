
# Install Softwares in RHEL 8

## Chrome

- Download and run

google-chrome-stable_current_x86_64.rpm

- keyring problem, resolved same as in other linux

rm ~/.local/share/keyrings/login.keyring

Now open Chrome, if it asks you for your password, do not enter one choose Continue each time and ignore any warning.


## Java

### Knowledge

openjdk-headless < openjdk < openjdk-devel

Role

openjdk-headless package
The 'openjdk-headless' package is a base package that includes JRE(Java Runtime Environment).
So, this rpm is often all that is needed on a server but does not include the 'local display' or 'audio hardware' feature.

openjdk
The 'openjdk' package provides a JRE which supports APIs that allow applications to drive local video and audio hardware. This rpm depends on the openjdk-headless, supplementing it with the necessary extra libraries and resources for GUI and sound.

openjdk-devel package
This rpm installs the Java Software Development Kit(SDK) which is a supplement for the JRE with some extra developer tools. It extends 'openjdk' package and is usually installed at the developer's server for the development or debugging process.

### install
- Ref:

https://developers.redhat.com/blog/2018/12/10/install-java-rhel8#switching_java_versions

```
yum provides \*/bin/java

yum list available \*openjdk\*

sudo yum install java-1.8.0-openjdk-devel java-11-openjdk-devel maven <--------------------- here

alternatives --list

sudo alternatives --config java

```

### Switching Java Versions

- Selecting Java Versions with Alternatives

alternatives --list

sudo alternatives --config java
sudo alternatives --config javac

- Switching alternatives non-interactively

JAVA_11=$(alternatives --display java | grep 'family java-11-openjdk' | cut -d' ' -f1)
sudo alternatives --set java $JAVA_11

JAVA_8=$(alternatives --display java | grep 'family java-1.8.0-openjdk' | cut -d' ' -f1)
sudo alternatives --set java $JAVA_8

- Selecting Java Versions by Setting JAVA_HOME

JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk mvn --version
JAVA_HOME=/usr/lib/jvm/java-11-openjdk mvn --version

- Use $HOME/.profile or $HOME/.bashrc

## VS Code
- download and install

code-1.56.2-1620838566.el8.x86_64.rpm


