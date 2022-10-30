# do (tap) vs subscribe

- Ref:

https://stackoverflow.com/questions/45321516/do-tap-vs-subscribe

## Good example for "caching!!!"

Edit: For RxJS 6 or above, Read do as tap.

do is used for side-effects. subscribe is used to invoke an observable. Replacing do with subscribe creates undesired results. Replacing subscribe with do will not even invoke the stream.

Consider these examples :

### Using **subscribe** :

```
const testObservable = Rx.Observable.create(function(observer){
   console.log('some heavy task, may be network call ');
   observer.next('success');
});

testObservable.subscribe(function(res){
    console.log('action 1');
});

testObservable.subscribe(function(res){
   console.log('action 2');
});

```

The output of the above code is

```
"some heavy task, may be network call "
"action 1"
"some heavy task, may be network call "
"action 2"
```

You can see the Rx.Observable.create got executed **twice**. Our goal is do it only once but along with action 2, do action 1 also.

### Using do:

```
const testObservable = Rx.Observable.create(function(observer){
   console.log('some heavy task, may be network call ');
   observer.next('success');
});

testObservable
    .do(function(res){ <---------------------------------- this could be used as "caching", also, see AngularAndRxjs\Rxjs-Subjects.md, using do for caching ...
        console.log('action 1');
    })  
    .subscribe(function(res){
        console.log('action 2');
    });
```

The output would be

```
"some heavy task, may be network call "
"action 1"
"action 2"
```

This is what we actually wanted. We need 'action 2' but before that do 'action 1' also.

### Why is it called side effect:

Because it will not affect the flow of stream unlike other operators. It takes the response , does something and even if it modifies the response the stream is going to ignore it . For ex:

```
testObservable
    .do(function(res){
        console.log('action 1');
        return res+'some other text';
    })  
    .subscribe(function(res){
        console.log('action 1');
    });
```

The above code will still give the same output as before. So no matter what you execute in do the stream is going to ignore it and proceed with its execution.

> If we are doing pure 'functional reactive programming' we don't want any side effects in the stream. So, do is discouraged and mostly used only for debugging purposes .

