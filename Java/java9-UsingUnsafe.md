
# Java 9: using Unsafe

## Example 1

- Ref

https://dzone.com/articles/using-sunmiscunsafe-in-java-9-1


- Code

```

module jdk.unsupported {

public class Java9Unsafe {

    public static void main(String[] args) throws NoSuchFieldException, IllegalAccessException {
        System.out.println("The address size is: " + getUnsafe().addressSize());
    }

    @SuppressWarnings("restriction")
    private static Unsafe getUnsafe() throws NoSuchFieldException, IllegalAccessException {
        Field singleoneInstanceField = Unsafe.class.getDeclaredField("theUnsafe");
        singleoneInstanceField.setAccessible(true);
        return (Unsafe) singleoneInstanceField.get(null);
    }

}

```

## Good Article

- Ref

https://blogs.oracle.com/javamagazine/the-unsafe-class-unsafe-at-any-speed  


- e.g

```
public final class SynchronizedCounter implements Counter {
    private int i = 0;

    @Override
    public synchronized int increment() {
        return i = i + 1;
    }

    @Override
    public synchronized int get() {
        return i;
    }
}


public final class AtomicCounter implements Counter {
    private static final Unsafe unsafe;
    private static final long valueOffset;

    private volatile int value = 0;

    static {
        try {
            Field f = Unsafe.class.getDeclaredField("theUnsafe");
            f.setAccessible(true);
            unsafe = (Unsafe) f.get(null);
            valueOffset = unsafe.objectFieldOffset
                (AtomicCounter.class.getDeclaredField("value"));
        } catch (Exception ex) { throw new Error(ex); }
    }

    @Override
    public int increment() {
        return unsafe.getAndAddInt(this, valueOffset, 1) + 1;
    }

    @Override
    public int get() {
        return value;
    }
}

```

