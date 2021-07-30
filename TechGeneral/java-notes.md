
# Java Notes

## General

### Collectors.toSet() vs Collectors.toCollection(hashset::new)

- If you want a guaranteed HashSet, use Collectors.toCollection(HashSet::new).

- As of JDK 11, the type of Set returned by Collectors.toSet() is a HashSet. This can, of course, change in future versions of Java, and you should therefore not rely on this. If you wish to use a specific type of Set, you should use Collectors.toCollection instead, and provide a lambda to create a collection of your choosing.

- Use Collectors.toCollection for different Set implementation:

`Set<String> set = people.stream().map(Person::getName).collect(Collectors.toCollection(TreeSet::new));`

### JsonUtils jsonToObject unescapeJson
- Using org.apache.commons.text.StringEscapeUtils

employeeJsonStr = employeeJsonStr.replaceAll("\u200b", ""); // replace all Zero Width Spaces
Employee employee = JsonUtils.jsonToObject(StringEscapeUtils.unescapeJson(employeeJsonStr), Employee.class);

### JsonUtils Paths.get(ClassLoader.getSystemResources(filepath).toURI())

readFileAsString(filepath)

Path path = Paths.get(ClassLoader.getSystemResources(filepath).toURI());
return new String(Files.readAllBytes(path));

### BigDecimal: valueOf is preferred

1. new BigDecimal(d)
2. new BigDecimal("string")
3. BigDecimal.valueOf(d)

- In general, valueOf is preferred, because it can avoid making new objects by reusing "popular" instances
- Constructor with String is creating BigDecimal as is ... because toString is String
- Using constructor with double has to consider scale!

## Optional

### Difference Between orElse and orElseGet(), orElseGet() should be used!

- Ref:

https://www.baeldung.com/java-optional

- there's a subtle but very important difference between the two that can affect the performance of our code drastically if not well understood.

```
public String getMyDefault() {
    System.out.println("Getting Default Value");
    return "Default Value";
}

@Test
public void whenOrElseGetAndOrElseOverlap_thenCorrect() {
    String text = null;

    String defaultText = Optional.ofNullable(text).orElseGet(this::getMyDefault);
    assertEquals("Default Value", defaultText);

    defaultText = Optional.ofNullable(text).orElse(getMyDefault());
    assertEquals("Default Value", defaultText);
}

```

- The getMyDefault() method is called in each case. It so happens that when the wrapped value is not present, then both orElse() and orElseGet() work exactly the same way.

```
@Test
public void whenOrElseGetAndOrElseDiffer_thenCorrect() {
    String text = "Text present";

    System.out.println("Using orElseGet:");
    String defaultText 
      = Optional.ofNullable(text).orElseGet(this::getMyDefault);
    assertEquals("Text present", defaultText);

    System.out.println("Using orElse:");
    defaultText = Optional.ofNullable(text).orElse(getMyDefault());
    assertEquals("Text present", defaultText);
}

Output:

Using orElseGet:
Using orElse:
Getting default value...

```

In the above example, we are no longer wrapping a null value, and the rest of the code remains the same.  

- orElseGet() should be used

Notice that when using orElseGet() to retrieve the wrapped value, the getMyDefault() method is not even invoked since the contained value is present.

However, when using orElse(), whether the wrapped value is present or not, the default object is created. So in this case, we have just created one redundant object that is never used.

In this simple example, there is no significant cost to creating a default object, as the JVM knows how to deal with such. However, when a method such as getMyDefault() has to make a web service call or even query a database, the cost becomes very obvious.





