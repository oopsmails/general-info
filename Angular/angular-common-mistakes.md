# Common Mistakes in Angular


## Top 5 Angular Mistakes - You Must Know Them

- Ref: https://www.youtube.com/watch?v=ejjln8hI14M

0:10 Subscribe Instead of Streams
4:26 Unsubscribe
5:33 Not Enough TypeScript
6:47 God Object Modules
7:49 Performance: TrackBy

### 0:10 Subscribe Instead of Streams

```
users$: Observable<string[]>

constructor(private usersService: UsersService) {
    this.user$ = this.userService.getUsers()
}

<div *ngFor=""let user of users | async">
{{ user }}}
</div>

```

### 4:26 Unsubscribe


```
users: string[]
userSubscription: Subscription
constructor(private usersService: UsersService) {}

ngOninit(): void {
    this.userSubscription = this.usersService.getUsers().subscribe((users) =>
        this.users = users
    )
}

ngOnDestory(): void {
    this.userSubscription.unsubscribe()
}

```

### 5:33 Not Enough TypeScript

Strong type

### 6:47 God Object Modules

Separate mudules

### 7:49 Performance: trackBy

- Always use trackBy

```
<div *ngFor=""let user of users; trackBy: myTrackByFunc | async">
{{ user }}}
</div>

- in component.ts

changeDetection: ChangeDetectionStrategy.OnPush

// Entity ID is always unique and safe
myTrackByFunc(index, value) {
    return value;
}


```

- changeDetection

This is my bonus mistake regarding change detection. 
Inside angular and obviously angular checks for changes inside our components but by default it is doing it really aggressively which means it will render even a small change when we are scrolling the page and normally for production you don't want this. You want your application to be more performant.

This is why i highly recommend you to use change strategy on push this means that our component will be rendered only when inputs are changing or when we are manually triggering the render and if you want to enable this change detection you need to go inside your component and here on the top right change detection and here you want to use change detection strategy dot on push and I highly recommend you to use it in all your components and then just call change detection if  you need to in this case your application will be much more performant.

