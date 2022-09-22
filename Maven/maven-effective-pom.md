# Is there a way to trace origin of a property in maven pom?

google: "how to know original of effective pom"

ref: https://stackoverflow.com/questions/43124917/is-there-a-way-to-trace-origin-of-a-property-in-maven-pom


You could give *help:effective-pom* a go. Just make sure that you use the 3.2.0 version (or later) together with the *-Dverbose=true* flag set. This will print out the source of the POM value.

To force the right version of the plugin:

```
<build>
    <pluginManagement>
      <plugins>
        <plugin>
          <artifactId>maven-help-plugin</artifactId>
          <version>3.2.0</version>
        </plugin>
      </plugins>
    </pluginManagement>
</build>

```

To use it:

```
%> mvn help:effective-pom -Dverbose=true 

mvn help:effective-pom -Dverbose=true > /c/temp/effective-pom.txt

```

