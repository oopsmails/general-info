
# Maven and pom.xml

## Design Thinkings

### 20220903:

- If a independent single project, use Spring parent

```
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.5.2</version>
        <relativePath/>
    </parent>
```

- If one layer parent children structure, means sub-projects are supposed to use libs with same versions, then,

> parent, defined as *pom* and define *properties*

```
    <groupId>com.oopsmails.springboot.dev.repo</groupId>
    <artifactId>spring-boot-simples</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>pom</packaging>
    <modules>
        <module>spring-boot-openapi-basic</module>
        <module>spring-boot-exception-handling</module>
        <module>spring-boot-playaround-jpa</module>
        <module>spring-boot-jpa-mongodb</module>
    </modules>

    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <slf4j.version>1.7.26</slf4j.version>
        <junit-jupiter.version>5.8.2</junit-jupiter.version>
        <spring-boot-dependencies.version>2.7.3</spring-boot-dependencies.version>
    </properties>

```

> child, set parent as parent and use *spring-boot-dependencies*

```

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>${spring-boot-dependencies.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
        </dependency>

```

- If two or more layers ... first re-consider the structure and top layer and second layer will be pom, in two cases,

> case 1, all projects are with same Spring Boot version, then define *properties* at top level, second level just working as a *collection*
> case 2, top level working as a *collection* and at second level, define Spring Boot version and *properties*.


## Concepts

## *relativePath* Tag for a Parent POM

To skip the local file search and directly search the parent POM in Maven repositories (NOT directly in IDE), we need to explicitly set the relativePath to an empty value.

This `<relativePath/>` should be a best practice whenever we inherit from external projects like Spring Boot.

- if NOT set

That means, for IDE-internal resolution, the position of the parent POM doesn't matter as long as the parent project is registered as an IntelliJ Maven Project. This might be helpful to simply develop projects without explicitly building them (if they are not in the scope of the same Git repository). But if we try to build the project with an external Maven runtime, it will fail.

- Quote

In order to resolve the parent project, these possible sources are checked:

relativePath
local repository
remote repositories

The relative path, if not given explicitly, defaults to .., i.e. the pom in the parent directory of the current project. 

## Tricks

### Exclude a folder

Can exclude the folder from build into /target in intellij or Eclipse

```
<build>
    <resources>
        <resource>
            <directory>src/main/resources</directory>
            <excludes>
                <exclude>config/**</exclude>
                <exclude>*.properties</exclude>
            </excludes>
            <filtering>false</filtering>
        </resource>
    </resources>
</build>

```

## Trouble Shooting

### Fatal error compiling: invalid target release: 11

- This normally happens when running *mvn clean install* in external Terminal, i.e, in IDE, could be fine.

- Check pom.xml, at least add following for testing

```
    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <java.version>11</java.version>
    </propertie>


    ......


    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>11</source>
                    <target>11</target>
                </configuration>
            </plugin>
        </plugins>
    </build>

```

- Check $JAVA_HOME

```
$ mvn -v
Apache Maven 3.6.3
Maven home: /usr/share/maven
Java version: 1.8.0_292, vendor: Private Build, runtime: /usr/lib/jvm/java-8-openjdk-amd64/jre <---------------- This is the problem
Default locale: en_CA, platform encoding: UTF-8
OS name: "linux", version: "5.4.0-58-generic", arch: "amd64", family: "unix"

```

Fix: change $JAVA_HOME in ~/.bashrc, then run `source ~/.bashrc`

```
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

```










