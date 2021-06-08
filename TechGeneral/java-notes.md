
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




