sudo update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java
export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME
java -version
