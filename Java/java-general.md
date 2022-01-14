
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

