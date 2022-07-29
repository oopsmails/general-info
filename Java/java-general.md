
# Java General Knowledge

## instanceof Map

```
if (parameters != null && parameters instandeof Map) {
    Map map = (Map) parameters;
    if (map.containsKye(key)) {
        return (String) map.get(key);
    }
}

return null;

```

## NoClassDefFoundError: javax/annotation/Generated

- maven javax

```
<dependency>
    <groupId>javax.annotation</groupId>
    <artifactId>javax.annotation-api</artifactId>
    <version>1.3.2</version>
</dependency>
```


- maven jakarta

```
<groupId>jakarta.annotation</groupId>
<artifactId>jakarta.annotation-api</artifactId>
```

- gradle

```
implementation 'javax.annotation:javax.annotation-api:1.3.2'
annotationProcessor("javax.annotation:javax.annotation-api:1.3.2")
```


