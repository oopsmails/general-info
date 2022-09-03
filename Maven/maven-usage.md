
# Maven and pom.xml

## Concepts

## *relativePath* Tag for a Parent POM

To skip the local file search and directly search the parent POM in Maven repositories (NOT directly in IDE), we need to explicitly set the relativePath to an empty value.

This `<relativePath/>` should be a best practice whenever we inherit from external projects like Spring Boot.

- if NOT set

That means, for IDE-internal resolution, the position of the parent POM doesn't matter as long as the parent project is registered as an IntelliJ Maven Project. This might be helpful to simply develop projects without explicitly building them (if they are not in the scope of the same Git repository). But if we try to build the project with an external Maven runtime, it will fail.

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

