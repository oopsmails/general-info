sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME
java -version
