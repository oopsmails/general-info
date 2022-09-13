
# Understanding Java 8’s Consumer, Supplier, Predicate and Function

Java has introduced functional programming support in Java release version 8. This specific release has also introduced several new concepts notably lambda expressions, method reference and a plethora of functional interfaces. While discussing functional interfaces, there are few functional interfaces namely Consumer, Supplier, Predicate and Functions are most crucial. In this article, we will talk about these interfaces.

- Quote:
A supplier is any method which takes no arguments and returns a value. Its job is to supply an instance of an expected class. Whereas, a consumer is a method that consumes some value (as in method argument), and does some operations on them. So a Consumer is any method which takes arguments and returns nothing. Also, BiConsumer ...

## Consumer
A Consumer is a functional interface that accepts a single input and returns no output. In layman’s language, as the name suggests the implementation of this interface consumes the input supplied to it. Consumer interface has two methods:

```
void accept(T t);
default Consumer<T> andThen(Consumer<? super T> after);
```

The accept method is the Single Abstract Method (SAM) which accepts a single argument of type T. Whereas, the other one andThen is a default method used for composition.

Following is an example of a consumer interface. We have created a consumer implementation that consumes a String and then prints it. The forEach method accepts consumer interface implementation.

```
@Test
public void whenNamesPresentConsumeAll(){
    Consumer<String> printConsumer = t -> System.out.println(t);
    Stream<String> cities = Stream.of("Sydney", "Dhaka", "New York", "London");
    cities.forEach(printConsumer);
}
```

In the following example, we demonstrate the usage of composing multiple consumer implementations to make a chain of consumers. In this specific example, we have created two consumers; one converts a list of items into upper case Strings and the other one prints the uppercased string.

```
@Test
public void whenNamesPresentUseBothConsumer(){
    List<String> cities = Arrays.asList("Sydney", "Dhaka", "New York", "London");

    Consumer<List<String>> upperCaseConsumer = list -> {
        for(int i=0; i< list.size(); i++){
            list.set(i, list.get(i).toUpperCase());
        }
    };
    Consumer<List<String>> printConsumer = list -> list.stream().forEach(System.out::println);

    upperCaseConsumer.andThen(printConsumer).accept(cities);
}

```

Consumer interface has specific implementation types for integer, double and long types with IntConsumer, DoubleConsumer, and LongConsumer as shown below:

```
IntConsumer void accept(int x);
DoubleConsumer void accept(double x);
LongConsumer void accept(long x);
```

## Supplier
A Supplier is a simple interface which indicates that this implementation is a supplier of results. This interface, however, does not enforce any restrictions that supplier implementation needs to return a different result on each invocation.

The supplier has only one method get() and does not have any other default and static methods.

```

@Test
public void supplier(){
    Supplier<Double> doubleSupplier1 = () -> Math.random();
    DoubleSupplier doubleSupplier2 = Math::random;

    System.out.println(doubleSupplier1.get());
    System.out.println(doubleSupplier2.getAsDouble());
}

```
The supplier interface has its primitive variants such as IntSupplier, DoubleSupplier and so on as shown below. Note that the method name is get() for the generic supplier interface. However, for the primitive variants, it is as per the primitive type.

```
IntSupplier int getAsInt();
DoubleSupplier double getAsDouble();
LongSupplier long getAsLong();
BooleanSupplier boolean getAsBoolean();
```

One of the primary usage of this interface to enable deferred execution. This means delaying the execution until it is needed. For example, Optional class has a method named orElseGet. This method is triggered if optional does not have data. This is demonstrated below:

```
@Test
public void supplierWithOptional(){
    Supplier<Double> doubleSupplier = () -> Math.random();
    Optional<Double> optionalDouble = Optional.empty();
    System.out.println(optionalDouble.orElseGet(doubleSupplier));
}

```
## Predicate
A Predicate interface represents a boolean-valued-function of an argument. This is mainly used to filter data from a Java Stream. The filter method of a stream accepts a predicate to filter the data and return a new stream satisfying the predicate. A predicate has a test() method which accepts an argument and returns a boolean value.

```
@Test
public void testPredicate(){
    List<String> names = Arrays.asList("John", "Smith", "Samueal", "Catley", "Sie");
    Predicate<String> nameStartsWithS = str -> str.startsWith("S");
    names.stream().filter(nameStartsWithS).forEach(System.out::println);
}

```
In the above example, we have created a predicate which tests the names that start with S. This predicate is supplied to a stream.

Predicate also provides a few default and static method for composition and other purposes:

```
default Predicate<T> and(Predicate<? super T> other);
default Predicate<T> or(Predicate<? super T> other);
static <T> Predicate<T> isEquals(Object targetRef);
default Predicate<T> negate();
```

Following example demonstrates to use and method to compose predicates with multiple predicates.

```
@Test
public void testPredicateAndComposition(){
    List<String> names = Arrays.asList("John", "Smith", "Samueal", "Catley", "Sie");
    Predicate<String> startPredicate = str -> str.startsWith("S");
    Predicate<String> lengthPredicate = str -> str.length() >= 5;
    names.stream().filter(startPredicate.and(lengthPredicate)).forEach(System.out::println);
}
```

## Function
A Function interface is more of a generic one that takes one argument and produces a result. This has a Single Abstract Method (SAM) apply which accepts an argument of a type T and produces a result of type R. One of the common use cases of this interface is Stream.map method. This is shown as below:

```
@Test
public void testFunctions(){
    List<String> names = Arrays.asList("Smith", "Gourav", "Heather", "John", "Catania");
    Function<String, Integer> nameMappingFunction = String::length;
    List<Integer> nameLength = names.stream().map(nameMappingFunction).collect(Collectors.toList());
    System.out.println(nameLength);
}
```

## Wrapping Up
The introduction of functional programming has introduced a new paradigm in Java language. And, Consumer, Supplier, Predicate and Function interfaces play a critical role in the way Java has enabled it. Mastering these interfaces and related primitive variants certainly help to write better functional code.


## Ref:

https://medium.com/swlh/understanding-java-8s-consumer-supplier-predicate-and-function-c1889b9423d

