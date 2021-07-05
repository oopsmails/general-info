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


