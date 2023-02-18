# finalize / finally

## finally was renamed to finalize

The finally operator was renamed to finalize in RxJS version 6.0.0 and later versions. This was done to align with the naming conventions of the ECMAScript finally statement.

```
import { of } from 'rxjs';
import { finalize } from 'rxjs/operators';

const source$ = of('Hello', 'World');

source$.pipe(
  finalize(() => console.log('Observable completed or errored out.'))
).subscribe(
  value => console.log(value),
  error => console.error(error),
  () => console.log('Observable completed successfully.')
);

// Output:
// Hello
// World
// Observable completed successfully.
// Observable completed or errored out.

```

## Angular and async pipe

but in angular, if I am going to use async pipe in html, i,e, not using subscribe in component ts, then how can I do the error handling?

When using the async pipe in an Angular template, you can handle errors using the catchError operator along with the of function from RxJS.

Here's an example of how you can use the async pipe to subscribe to an observable in an Angular template and handle errors using the catchError operator:

```
import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { of } from 'rxjs';

@Component({
  selector: 'app-example',
  template: `
    <div *ngIf="data$ | async as data; else loading">
      <p>{{ data }}</p>
    </div>

    <ng-template #loading>
      <p>Loading data...</p>
    </ng-template>
  `
})
export class ExampleComponent {
  data$ = this.http.get('/api/data').pipe(
    catchError(error => {
      console.error(error);
      return of('An error occurred while loading data.');
    })
  );

  constructor(private http: HttpClient) {}
}

```

In this example, the data$ observable emits data from an HTTP request to an API. The catchError operator is used to catch any errors thrown by the observable and log them to the console, as well as return a new observable that emits a default error message.

In the template, the data$ observable is subscribed to using the async pipe, and the emitted data is displayed in a paragraph element. If an error occurs while loading the data, the default error message is displayed instead.

Note that it's important to handle errors in observables that are used with the async pipe, as any unhandled errors could cause the template to stop rendering and potentially crash the application.

> ok, so, with catchError, I don't need finally or finalize anymore, am I understanding it correctly?

That's correct! The catchError operator can be used to catch errors thrown by an observable and handle them, so you don't need to use finally or finalize to handle errors in the same way.

The catchError operator allows you to provide a callback function that handles errors thrown by the observable. This function can return a new observable or throw a new error to propagate the error downstream. You can also use the tap operator to perform any side effects you need to do before the error is handled by catchError.

Here's an example of using catchError to handle errors and perform a side effect before handling the error:

```
import { of } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';

const source$ = of(1, 2, 3, 4, 5);

source$.pipe(
  tap(value => {
    if (value === 3) {
      throw new Error('Value is 3!');
    }
  }),
  catchError(error => {
    console.error(error);
    return of('Error occurred!');
  })
).subscribe(
  value => console.log(value),
  error => console.error(error),
  () => console.log('Observable completed.')
);

// Output:
// 1
// 2
// Error occurred!
// Observable completed.

```

In this example, the tap operator is used to throw an error when the value emitted by the sequence is 3. The catchError operator is then used to catch the error and log it to the console, as well as return a new observable that emits a default error message. Finally, the subscribe method is used to subscribe to the modified sequence and log each value emitted by the sequence to the console, as well as log any errors thrown by the sequence to the console.
