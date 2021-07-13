- [JUnit Examples](#junit-examples)
  - [mockito mock test consumer method](#mockito-mock-test-consumer-method)
    - [Using ArgumentCaptor](#using-argumentcaptor)
    - [Using mock](#using-mock)
  - [Setting private field value during Unit Test](#setting-private-field-value-during-unit-test)
    - [Using org.springframework.test.util.ReflectionTestUtils](#using-orgspringframeworktestutilreflectiontestutils)
    - [Using Java reflection, Java 8 and before](#using-java-reflection-java-8-and-before)
    - [Java 8, sun.misc.Unsafe](#java-8-sunmiscunsafe)
    - [Java 9, using Unsafe](#java-9-using-unsafe)
  - [@ConditionalOnProperty and Testing](#conditionalonproperty-and-testing)

# JUnit Examples

## mockito mock test consumer method

### Using ArgumentCaptor

- Ref:

https://stackoverflow.com/questions/50199260/mockito-test-java-8-lambda-consumer-api

- Example:

```
@RunWith(MockitoJUnitRunner.class)
public class SomeClassTest {
  @InjectMocks
  private SomeClass someClass;
  @Mock
  private SomeInteface toBeMockedDependency;
  @Captor
  private ArgumentCaptor<Consumer<Message>> messageConsumerCaptor;

  @Test
  public void testMethod() {
    someClass.method();
    verify(toBeMockedDependency).doSomething(messageConsumerCaptor.capture());
    Consumer<Message> messageConsumer = messageConsumerCaptor.getValue();

    // Now you have your message consumer, so you can test it all you want.
    messageConsumer.accept(new Message(...));
    assertEquals(...);
  }
}
```

### Using mock

- Ref:

https://stackoverflow.com/questions/54815602/how-to-mock-the-lamda-expression-using-mockito

- Example:

```

Your main class (let it be called "TestApp"):
public class TestApp {

    public void someRealMethod() {
        List<String> items = new ArrayList<>();
        items.add("A");
        items.add("B");
        items.add("C");
        items.add("D");
        items.add("E");

        items.forEach(lambdaForMocking());
        items.forEach(anotherLambdaForMocking());
    }

    Consumer<String> lambdaForMocking() {
        return item -> System.out.println(item);
    }

    Consumer<String> anotherLambdaForMocking() {
        return item -> {
            if ("C".equals(item)) {
                System.out.println(item);
            }
        };
    }
}


Your test class:
public class TestAppTest {

    @Test
    public void lambdaMockingTest() {
        TestApp testApp = new TestApp();
        TestApp spy = Mockito.spy(testApp);

        Mockito.when(spy.lambdaForMocking()).thenReturn(item -> {});
        Mockito.when(spy.anotherLambdaForMocking()).thenReturn(item -> {});

        spy.someRealMethod();

        //Asserts...
    }
}

```








## Setting private field value during Unit Test

- Powermock is not a choice because additional lib needed.

### Using org.springframework.test.util.ReflectionTestUtils

- e.g

`ReflectionTestUtils.setField(SomeClass.class, "CONST", "newValue");`

- This CANNOT set static field

### Using Java reflection, Java 8 and before

- Ref:

https://blog.sebastian-daschner.com/entries/changing_private_static_final_field  

https://stackoverflow.com/questions/51521837/spring-reflectiontestutils-does-not-set-static-final-field

- Note: 
  
  - Cannot change a compile-period constant. Such as below, because it will be inline when compile.
  - Only for Java 8 and before.

`public static final String HW = "Hello World"`

- e.g, can even change *private static final* field

```

public class Knowledge {

    private static final Integer ANSWER = 42;

    public String askQuestion(String question) {
        return "The answer to '" + question + "' is: " + ANSWER;
    }

}
We now want to change the answer for testing purposes:

public class KnowledgeTest {

    @Test
    public void testAskQuestion() throws Exception {
        Knowledge knowledge = new Knowledge();

        String answer = knowledge.askQuestion("question?");
        assertThat(answer, is("The answer to 'question?' is: 42"));

        setFinalStaticField(Knowledge.class, "ANSWER", 41);

        answer = knowledge.askQuestion("question?");
        assertThat(answer, is("The answer to 'question?' is: 41"));
    }

    private static void setFinalStaticField(Class<?> clazz, String fieldName, Object value)
            throws ReflectiveOperationException {

        Field field = clazz.getDeclaredField(fieldName);
        field.setAccessible(true);

        Field modifiers = Field.class.getDeclaredField("modifiers");
        modifiers.setAccessible(true);
        modifiers.setInt(field, field.getModifiers() & ~Modifier.FINAL);

        field.set(null, value);
    }

    private static void setStaticField(Class<?> clazz, String fieldName, Object value)
            throws ReflectiveOperationException {

        Field field = clazz.getDeclaredField(fieldName);
        field.setAccessible(true);

        Field modifiers = Field.class.getDeclaredField("modifiers");
        modifiers.setAccessible(true);
        // modifiers.setInt(field, field.getModifiers() & ~Modifier.FINAL);

        field.set(null, value);
    }

}
```

```

static void setFinalStatic(Field field, Object newValue) throws IllegalArgumentException, IllegalAccessException, NoSuchFieldException, SecurityException {
    field.setAccessible(true);

    Field modifiersField = Field.class.getDeclaredField("modifiers");
    modifiersField.setAccessible(true);
    modifiersField.setInt(field, field.getModifiers() & ~Modifier.FINAL);

    field.set(null, newValue);
  }

```

### Java 8, sun.misc.Unsafe

```
import java.lang.reflect.Field;

import sun.misc.Unsafe;

public class Test {

  public static void main(String[] args) throws NoSuchFieldException, IllegalAccessException {
    System.out.println("before");
    Field theUnsafeField = Unsafe.class.getDeclaredField("theUnsafe");
    theUnsafeField.setAccessible(true);

    Unsafe unsafe = (Unsafe) theUnsafeField.get(null);
    unsafe.getByte(new Object(), 4);
    System.out.println("after");
  }
}
```

### Java 9, using Unsafe

See, java9-UsingUnsafe.md


## @ConditionalOnProperty and Testing

- Ref:

https://www.baeldung.com/spring-conditionalonproperty

In short, the @ConditionalOnProperty enables bean registration only if an environment property is present and has a specific value. By default, the specified property must be defined and not equal to false.  

- Example, note the *withPropertyValues* and *withUserConfiguration*

```
@Bean(name = "emailNotification")
@ConditionalOnProperty(prefix = "notification", name = "service")
public NotificationSender notificationSender() {
    return new EmailNotification();
}

public class EmailNotification implements NotificationSender {
    @Override
    public String send(String message) {
        return "Email Notification: " + message;
    }
}

@Bean(name = "smsNotification")
@ConditionalOnProperty(prefix = "notification", name = "service", havingValue = "sms")
public NotificationSender notificationSender2() {
    return new SmsNotification();
}

package com.baeldung.conditionalonproperty;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;

import com.baeldung.conditionalonproperty.config.NotificationConfig;
import com.baeldung.conditionalonproperty.service.EmailNotification;
import com.baeldung.conditionalonproperty.service.NotificationSender;

public class NotificationUnitTest {

    private final ApplicationContextRunner contextRunner = new ApplicationContextRunner();

    @Test
    public void whenValueSetToEmail_thenCreateEmailNotification() {
        this.contextRunner.withPropertyValues("notification.service=email")
            .withUserConfiguration(NotificationConfig.class)
            .run(context -> {
                assertThat(context).hasBean("emailNotification");
                NotificationSender notificationSender = context.getBean(EmailNotification.class);
                assertThat(notificationSender.send("Hello From Baeldung!")).isEqualTo("Email Notification: Hello From Baeldung!");
                assertThat(context).doesNotHaveBean("smsNotification");
            });
    }
}

```
