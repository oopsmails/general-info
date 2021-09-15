# Spring Boot async thread pool size

- Ref:

The default pool size is 1, and you can set the pool size in application.properties science springboot2.1.0 via changing the value of spring.task.scheduling.pool.size.

spring.task.scheduling.pool.size=20

https://www.baeldung.com/spring-async  


https://www.javadevjournal.com/spring-boot/spring-async-annotation/  


## The @Async Annotation

###  Methods With Void Return Type
```
@Async
public void asyncMethodWithVoidReturnType() {
    System.out.println("Execute method asynchronously. " 
      + Thread.currentThread().getName());
}
```

### Methods With Return Type
```
public Future<String> asyncMethodWithReturnType() {
    System.out.println("Execute method asynchronously - " 
      + Thread.currentThread().getName());
    try {
        Thread.sleep(5000);
        return new AsyncResult<String>("hello world !!!!");
    } catch (InterruptedException e) {
        //
    }

    return null;
}
```

- test


```
public void testAsyncAnnotationForMethodsWithReturnType()
  throws InterruptedException, ExecutionException {
    System.out.println("Invoking an asynchronous method. " 
      + Thread.currentThread().getName());
    Future<String> future = asyncAnnotationExample.asyncMethodWithReturnType();

    while (true) {
        if (future.isDone()) {
            System.out.println("Result from asynchronous process - " + future.get());
            break;
        }
        System.out.println("Continue doing something else. ");
        Thread.sleep(1000);
    }
}
```

## The Executor

### Override the Executor at the Method Level

```
@Configuration
@EnableAsync
public class SpringAsyncConfig {
    
    @Bean(name = "threadPoolTaskExecutor")
    public Executor threadPoolTaskExecutor() {
        return new ThreadPoolTaskExecutor();
    }
}
```

### Override the Executor at the Application Level

```
@Configuration
@EnableAsync
public class SpringAsyncConfig implements AsyncConfigurer {
    
    @Override
    public Executor getAsyncExecutor() {
        return new ThreadPoolTaskExecutor();
    }
    
}

```

### Exception Handling

```

public class CustomAsyncExceptionHandler
  implements AsyncUncaughtExceptionHandler {

    @Override
    public void handleUncaughtException(
      Throwable throwable, Method method, Object... obj) {
 
        System.out.println("Exception message - " + throwable.getMessage());
        System.out.println("Method name - " + method.getName());
        for (Object param : obj) {
            System.out.println("Parameter value - " + param);
        }
    }
    
}

public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
    return new CustomAsyncExceptionHandler();
}
```

## Customer pool size

private List getCurrentWeather(Stream cityNames) throws InterruptedException, ExecutionException {
    ForkJoinPool customPool = new ForkJoinPool(4);
    List weatherData;

    weatherData = customPool.submit(() -> cityNames.parallel()
    .map(this::getWeather)
    .collect(toList())).get();
   
    return weatherData;
}

