# What is the difference between Observable and a Subject in rxjs?

## Answer 1

In stream programming there are two main interfaces: **Observable** and **Observer**.

Observable is for the consumer, it can be transformed and subscribed:

```
observable.map(x => ...).filter(x => ...).subscribe(x => ...)
```

Observer is the interface which is used to feed an observable source:

```
observer.next(newItem)
```

We can create new Observable with an Observer:

```
var observable = Observable.create(observer => { 
    observer.next('first'); 
    observer.next('second'); 
    ... 
});
observable.map(x => ...).filter(x => ...).subscribe(x => ...)
```

Or, we can use a **Subject** which implements both the **Observable** and the **Observer** interfaces:

```
var source = new Subject();
source.map(x => ...).filter(x => ...).subscribe(x => ...)
source.next('first')
source.next('second')
```

## Answer 2:

### Observables

- They are cold: Code gets executed when they have at least a single observer.

- Creates copy of data: Observable creates copy of data for each observer.

- Uni-directional: Observer can not assign value to observable(origin/master).

- The code will run for each observer . If its a HTTP call, it gets called for each observer.

- if its a service we want to share among all the components, it wont have latest result all new subscribers will still subscribe to same observable and get value from scratch

- Unicast means can emit values from the observable not from any other component.

### Subject

- They are hot: code gets executed and value gets broadcast even if there is no observer.

- Shares data: Same data get shared between all observers.

- bi-directional: Observer can assign value to observable(origin/master).

- If are using using subject then you miss all the values that are broadcast before creation of observer. So here comes Replay Subject

- multicast, can cast values to multiple subscribers and can act as both *subscribers* and *emmitter*


### Answer 3:

**Observables** are *unicast* by design and **Subjects** are *multicast* by design.

> if you look at the below example - each subscription receives the different values as observables developed as unicast by design.

```
import {Observable} from 'rxjs';

let obs = Observable.create(observer=>{
   observer.next(Math.random());
})

obs.subscribe(res=>{
  console.log('subscription a :', res); //subscription a :0.2859800202682865
});

obs.subscribe(res=>{
  console.log('subscription b :', res); //subscription b :0.694302021731573
});

```

this could be weird if you are expecting the same values on both the subscription.

> we can overcome this issue using Subjects. Subjects is similar to event-emitter and it does not invoke for each subscription. consider the below example.

```
import {Subject} from 'rxjs';

let obs = new Subject();

obs.subscribe(res=>{
  console.log('subscription a :', res); // subscription a : 0.91767565496093
});

obs.subscribe(res=>{
  console.log('subscription b :', res);// subscription b : 0.91767565496093
});

obs.next(Math.random());
```
both the subscription are got the same output value!.


## Ref:

https://stackoverflow.com/questions/47537934/what-is-the-difference-between-observable-and-a-subject-in-rxjs

