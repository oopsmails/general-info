
# Singleton in Java

## double-checked-locking

http://www.cs.umd.edu/~pugh/java/memoryModel/jsr-133-faq.html#dcl


The (infamous) double-checked locking idiom (also called the multithreaded singleton pattern) is a trick 
designed to support lazy initialization while avoiding the overhead of synchronization. In very early 
JVMs, synchronization was slow, and developers were eager to remove it -- perhaps too eager. The double-checked 
locking idiom looks like this:
// double-checked-locking - don't do this!

private static Something instance = null;

public Something getInstance() {
  if (instance == null) {
    synchronized (this) {
      if (instance == null)
        instance = new Something();
    }
  }
  return instance;
}
This looks awfully clever -- the synchronization is avoided on the common code path. There's only one 
problem with it -- it doesn't work. Why not? The most obvious reason is that the writes which initialize 
instance and the write to the instance field can be reordered by the compiler or the cache, which would 
have the effect of returning what appears to be a partially constructed Something. The result would be 
that we read an uninitialized object. There are lots of other reasons why this is wrong, and why algorithmic 
corrections to it are wrong. There is no way to fix it using the old Java memory model. More in-depth 
information can be found at Double-checked locking: Clever, but broken and The "Double Checked Locking 
is broken" declaration
Many people assumed that the use of the volatile keyword would eliminate the problems that arise when 
trying to use the double-checked-locking pattern. In JVMs prior to 1.5, volatile would not ensure that 
it worked (your mileage may vary). Under the new memory model, making the instance field volatile will 
"fix" the problems with double-checked locking, because then there will be a happens-before relationship 
between the initialization of the Something by the constructing thread and the return of its value by 
the thread that read



Instead, use the Initialization On Demand Holder idiom, which is thread-safe and a lot easier to understand:

private static class LazySomethingHolder {
  public static Something something = new Something();
}

public static Something getInstance() {
  return LazySomethingHolder.something;
}
This code is guaranteed to be correct because of the initialization guarantees for static fields; if 
a field is set in a static initializer, it is guaranteed to be made visible, correctly, to any thread 
that accesses that class.

-------------------------------------------------------------

## Enum Singleton

https://www.baeldung.com/java-singleton


```
public enum EnumSingleton {
    
    INSTANCE("Initial class info"); 
 
    private String info;
 
    private EnumSingleton(String info) {
        this.info = info;
    }
 
    public EnumSingleton getInstance() {
        return INSTANCE;
    }
    
    // getters and setters
}

```


## More Examples

https://www.journaldev.com/1377/java-singleton-design-pattern-best-practices-examples#enum-singleton


> SerializedSingleton 

The problem with serialized singleton class is that whenever we deserialize it, it will create a new instance of the class. Let’s see it with a simple program.

```
protected Object readResolve() {
    return getInstance();
}
```




