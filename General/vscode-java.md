
# VS Code for Jave Developer

## Extensions

- Extension Pack for Java
- Spring Boot Extension Pack
- Lombok Annotations Support for VS Code

## Settings

### JDK: only use this if using diff JDK version in VS Code and outside.
ctrl shift P

Open Settings (JSON)

"java.jdt.ls.java.home": "/usr/lib/jvm/java-1.16.0-openjdk-amd64"


## Trouble Shooting

### Always use 'mvn clean package' in Terminal to test around

mvn -v

Make sure 'sudo apt install maven'

### When run maven package, If multiple dir layers, then open a Terminal in the dir containing the pom.xml file of Spring Boot project.

Otherwise, will get following error, for example,

```
"/home/albert/Documents/dev/githubother/spring-boot-angular-2fa-demo/spring-boot-oauth2-social-login/mvnw" package -f "/home/albert/Documents/dev/githubother/spring-boot-angular-2fa-demo/spring-boot-oauth2-social-login/pom.xml"
albert@albert-mint20:~/Documents/dev/githubother/spring-boot-angular-2fa-demo$ "/home/albert/Documents/dev/githubother/spring-boot-angular-2fa-demo/spring-boot-oauth2-social-login/mvnw" package -f "/home/albert/Documents/dev/githubother/spring-boot-angular-2fa-demo/spring-boot-oauth2-social-login/pom.xml"
bash: /home/albert/Documents/dev/githubother/spring-boot-angular-2fa-demo/spring-boot-oauth2-social-login/mvnw: /bin/sh^M: bad interpreter: No such file or directory


```

### mvnw with bad end of line characters

```
mvnw: /bin/sh^M: bad interpreter: No such file or directory

open mvnw in VS Code, at the right bottom, click on "CRLF", change it to "LF" and save.

```

