sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
export JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME
java -version
