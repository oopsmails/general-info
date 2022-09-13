# Java Lamda

## Replace an anonymous class using lamda

To run code with retry handling, we can call the retryTemplate.execute() method:

```
retryTemplate.execute(new RetryCallback<Void, RuntimeException>() {
    @Override
    public Void doWithRetry(RetryContext arg0) {
        myService.templateRetryService();
        ...
    }
});
```

Instead of an anonymous class, we can use a lambda expression:

```
retryTemplate.execute(arg0 -> {
    myService.templateRetryService();
    return null;
});
```

## Wrap logging examples

spring-boot-java-main/src/main/java/com/oopsmails/generaljava/SimplifyTestingService.java

spring-boot-java-main/src/test/java/com/oopsmails/generaljava/functionobj/FunctionParameterTest.java

```
    public static <T, R> R functionApplyWithLogging(T data, Function<T, R> function) {
        log.info("functionApplyWithLogging, function: [{}], before data: [{}]",
                function,
                JsonUtil.objectToJsonString(data, true));

        R result = function.apply(data);

        log.info("functionApplyWithLogging, do processing after function.apply() for:  result: [{}]",
                JsonUtil.objectToJsonString(result, true));
        return result;
    }

```



