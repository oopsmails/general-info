
# Maven and pom.xml

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

