
# General Frontend Knowledge

## Is it possible to force hard application update (Ctrl + F5 browser analogue) from the app code?

- From Angular

We need to use interceptor to detect error and if error is detected then we reload page using the **window.location.reload(true);** it will remove the cache and reload the page.

```
@Injectable()
export class myInterceptor implements HttpInterceptor {

  constructor() { }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return next.handle(request).pipe(
      catchError(error => this.handleError(error))
    );
  }

  private handleError(error: HttpErrorResponse): Observable<any> {
     if (error.status === 404) {
      // Do your thing here      
     window.location.reload(true);
   }         
  }

```

- From Javascript

Try following, FIrst of all in your <head> tag put following two lines

```
<meta http-equiv="Cache-control" content="no-cache">
<meta http-equiv="Expires" content="-1">
```

and then You can use **location.reload(true)**



