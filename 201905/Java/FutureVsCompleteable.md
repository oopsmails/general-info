
https://stackoverflow.com/questions/54359761/future-vs-completablefuture-for-this-use-case-completablefuture-will-make-any  




A CompletableFuture has some functional features that a regular Future does not have, like the ability to chain executions with thenApply or thenAccept that take a function that process the result after it´s available. You also can complete a CompleteableFuture from another Thread by calling the comlete() method of the CompletableFuture.

So in your situation it depends on what you want to do with the result. If you need the result in the further program flow, you have to wait for it like you do with the get() method. Since Futures will be executed as soon as they are created they will run in parallel on a Worker-Thread, and waiting for them sequentially does not mean they will run sequentially.

But if you do not need the results for further processing (Eg. you just want to insert the results in a Database) a CompletableFuture will have the advantage that you can provide a function that takes the result and does something with it. Eg. like this completableFuture.thenAccept(result -> DB::storeInDB); This way you would not have to wait for the result with get().



