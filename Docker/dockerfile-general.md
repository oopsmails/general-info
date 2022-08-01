
# Dockerfile General

## Build docker image with maven plugins


- jib-maven-plugin

https://github.com/oopsmails/k8s-springboot-app-demo/blob/987bebde44c2aa95f8e0a775ff27137234760990/pom.xml

```
            <plugin>
                <groupId>com.google.cloud.tools</groupId>
                <artifactId>jib-maven-plugin</artifactId>
                <version>0.10.1</version>
                <configuration>
                    <to>
                        <image>configmgmt:${project.version}</image>
                    </to>
                    <container>
                        <mainClass>com.oopsmails.configmgmt.demo.DemoApplication</mainClass>
                        <useCurrentTimestamp>true</useCurrentTimestamp>
                    </container>
                </configuration>
                <executions>
                    <execution>
                        <id>docker-daemon</id>
                        <phase>compile</phase>
                        <goals>
                            <goal>dockerBuild</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
```

- spotify

https://github.com/oopsmails/k8s-springboot-app-demo/blob/987bebde44c2aa95f8e0a775ff27137234760990/pom.xml

```
            <plugin>
                <groupId>com.spotify</groupId>
                <artifactId>docker-maven-plugin</artifactId>
                <version>1.2.0</version>
                <configuration>
                    <imageName>oopsmails/backendmock</imageName>
                    <baseImage>java:11</baseImage>
                    <entryPoint>["java", "-jar", "/${project.build.finalName}.jar"]</entryPoint>
                    <!-- copy the service's jar file from target into the root directory of the image -->
                    <resources>
                        <resource>
                            <targetPath>/</targetPath>
                            <directory>${project.build.directory}</directory>
                            <include>${project.build.finalName}.jar</include>
                        </resource>
                    </resources>
                </configuration>
            </plugin>
```

