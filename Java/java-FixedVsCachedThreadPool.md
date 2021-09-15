
# Executors newCachedThreadPool() vs newFixedThreadPool()

- Ref:
https://www.baeldung.com/java-executors-cached-fixed-threadpool

## Cached Thread Pool

Cached thread pools are using “synchronous handoff” to queue new tasks. The basic idea of synchronous handoff is simple and yet counter-intuitive: One can queue an item if and only if another thread takes that item at the same time. In other words, the SynchronousQueue can not hold any tasks whatsoever.

Suppose a new task comes in. **If there is an idle thread waiting on the queue, then the task producer hands off the task to that thread. Otherwise, since the queue is always full, the executor creates a new thread to handle that task.**

The cached pool starts with zero threads and can potentially grow to have Integer.MAX_VALUE threads. Practically, the only limitation for a cached thread pool is the available system resources.

To better manage system resources, cached thread pools will remove threads that remain idle for one minute.

- As a result, it works best when we're dealing with a reasonable number of short-lived tasks. 

## Fixed Thread Pool

As opposed to the cached thread pool, this one is using an unbounded queue with a fixed number of never-expiring threads. **Therefore, instead of an ever-increasing number of threads, the fixed thread pool tries to execute incoming tasks with a fixed amount of threads.** When all threads are busy, then the executor will queue new tasks.  This way, we have more control over our program's resource consumption.

As a result, fixed thread pools are better suited for tasks with unpredictable execution times.

## Conclusion

All those differences aside, they're both use *AbortPolicy* as their *saturation policy*. Therefore, we expect these executors to throw an exception when they can't accept and even queue any more tasks.

Let's see what happens in the real world.

Cached thread pools will continue to create more and more threads in extreme circumstances, so, practically, they will never reach a saturation point. Similarly, fixed thread pools will continue to add more and more tasks in their queue. Therefore, the fixed pools also will never reach a saturation point.

**As both pools won't be saturated, when the load is exceptionally high, they will consume a lot of memory for creating threads or queuing tasks. Adding insult to the injury, cached thread pools will also incur a lot of processor context switches.**

Anyway, to have more control over resource consumption, it's highly recommended to create a custom ThreadPoolExecutor:

```
var boundedQueue = new ArrayBlockingQueue<Runnable>(1000);
new ThreadPoolExecutor(10, 20, 60, SECONDS, boundedQueue, new AbortPolicy());
```

Here, our thread pool can have up to 20 threads and can only queue up to 1000 tasks. Also, when it can't accept any more load, it will simply throw an exception.




