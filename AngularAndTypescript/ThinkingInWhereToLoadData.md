
# Thinking in Where to Load Data

## Notes:

### NgRx 7 brings us some new Effect lifecycle hooks.

One of them, OnInitEffects, might be useful to initiate a data load when an effect gets registered - see docs.

```
class OrdersEffects implements OnInitEffects {
  ngrxOnInitEffects(): Action {
    return { type: '[Orders Effect]: Load' };
  }
}

```

## Readings

### https://dev.to/jonrimmer/where-to-initiate-data-load-in-ngrx-358l




Where to initiate data load in NgRx
#angular #ngrx #javascript
jonrimmer profile image
Jon Rimmer
Jan 22, 2019 ・Updated on Jan 24, 2019 ・6 min read
In NgRx, loading data from a data source, such as a REST API or a DB, is done using an effect. However, something has to dispatch the action that triggers the effect in the first place. I've seen a few different suggestions / approaches to doing this.

In our example, we'll be loading a collection of Order entities from a service. We'll introduce two actions: LoadOrdersRequested and LoadOrders. The first of these will initiate the data load, then an effect will perform the load and dispatch a LoadOrders action, which will put the loaded data into the store.

The effect to handle LoadOrdersRequested will look like this:

```
@Effect()
loadOrdersRequested$ = this.actions$.pipe(
  ofType<LoadOrdersRequested>(ActionTypes.LoadOrdersRequested),
  // Don't load if we've already loaded.
  withLatestFrom(this.store.select(getAllOrdersLoaded)),
  filter(([_, loaded]) => !loaded),
  // Don't handle more than one load request at a time.
  exhaustMap(() => this.ordersService.fetchAllOrders().pipe(
    map(result => new LoadOrders(result))
  ))
);

```

Now, in order to initiate the data load, we need to dispatch the LoadOrdersRequested action from somewhere. There are four main options:

When the app starts.
When a container component is initialised.
When the app navigates to a route.
When the user performs an action.
The fourth of these might be when the user clicks a button to explicitly load or reload some data. For this article we'll concentrate on the first three.

When the app starts
Pros:

The data is guaranteed to load.
Cons:

Memory / performance concerns if there's a lot of data to load.
In your AppComponent
The simplest way is to dispatch the LoadOrdersRequested action from your AppComponent's init lifecycle method:
export class AppComponent implements OnInit  {
  constructor(private store: Store<AppState>) {}

  ngOnInit() {
    this.store.dispatch(new LoadOrdersRequested());
  }
}
https://stackblitz.com/edit/angular-ngrx-initiate-load-at-app-start-app-component

In an effect
NgRx provides an INIT action that is dispatched when the app starts. This seems like a good place to initiate our data load, but there's a problem. The INIT action is dispatched before the effects are subscribed to, so this won't work:
@Effect()
init$ = this.actions$.pipe(
  ofType(INIT),
  map(() => new LoadOrdersRequested())
);
Instead, the NgRx team has recommended using the defer RxJS operator instead:
@Effect()
init$ = defer(() => new LoadOrdersRequested());
However, if we want to have our effect potentially trigger other effects, this approach will not work. This is because, while defer delays the creation of the LoadOrdersRequested action until the init$ observable is subscribed to (during the effects module initialisation), the action will then be dispatched before the initialisation is complete. As such, our effect that is looking for LoadOrdersRequested may not be registered yet, depending on the order in which the effects system has subscribed to the different effects.

We can perhaps mitigate this problem by re-ordering out effects, but a better solution is to use the asyncScheduler to delay to dispatch of the LoadOrdersRequested action:

import { asyncScheduler, of } from 'rxjs';

...

@Effect()
$init = of(new LoadOrdersRequested, asyncScheduler);

Although INIT does not work, there is also a built-in action we can use: ROOT_EFFECTS_INIT:
@Effect()
$init = this.actions$.pipe(
  ofType(ROOT_EFFECTS_INIT),
  map(() => new LoadOrdersRequested())
);
https://stackblitz.com/edit/angular-ngrx-initiate-load-at-app-start-init

APP_INITIALIZER
Angular provides APP_INITIALIZER as a way to run code at app startup, and you can dispatch actions from there:
@NgModule({
  ...
  providers: [
    {
      provide: APP_INITIALIZER,
      useFactory: (store: Store<AppState>) => {
        return () => {
          store.dispatch(new LoadOrdersRequested());
        };
      },
      multi: true,
      deps: [Store]
    }
  ]
})
https://stackblitz.com/edit/angular-ngrx-initiate-load-at-app-start-app-initializer

When a container component is initialised
Pros:

You only load data as and when it's needed.
It's clear from looking at the component what data it's relying on.
Cons:

You either need lots of actions, or to dispatch the same action in several places.
The component is less pure, as it has the side effect of loading data.
You might forget to dispatch the action from a component that needs the data. This bug could be obscured if you normally reach the component through another component that does initiate the data load. E.g. you normally open a list page before opening a details page. Then, one day, you navigate directly to the details page and it breaks.
@Component({ ... })
export class OrdersComponent implements OnInit {
  order$: Observable<Order>;

  constructor(private store: Store<AppState>) {
    this.order$ = this.store.select(getOrder);
  }

  ngOnInit() {
    this.store.dispatch(new LoadOrdersRequested());
  }
}
https://stackblitz.com/edit/angular-ngrx-initiate-load-in-component

When the app navigates to a route
Pros:

Less duplication. A single guard at the root of a route hierarchy can load the data for all child routes, even if they're navigated to directly.
Components are more pure, as they only map from selected state to their template output.
Cons:

Quite blunt: A guard will trigger data load for any child route, even if its component doesn't need it.
Less obvious from looking at a component what data it needs to work. If it gets moved somewhere else in the router hierarchy, it'll break.
Less useful if routes requiring some particular data are spread out throughout the router hierarchy, as you'll need to include the guard in different places.
Router Guard
@Injectable()
export class OrdersGuard implements CanActivate {
  constructor(private store: Store<AppState>) {}

  canActivate(): Observable<boolean> {
    return this.store.pipe(
      select(getAllOrdersLoaded),
      tap(loaded => {
        if (!loaded) {
          this.store.dispatch(new LoadOrdersRequested());
        }
      }),
      filter(loaded => loaded),
      first()
    );
  }
}


const ROUTES: Route[] = [
  {
    path: 'orders',
    component: OrdersList,
    canActivate: [OrdersGuard],
    children: [
      ...
    ]
  }
]
https://stackblitz.com/edit/angular-ngrx-initiate-load-router-guard

A basic guard could just dispatch the LoadOrdersRequested action, relying on the effect to filter out unnecessary load requests. However, by checking the condition of allOrdersLoaded, the guard can delay the navigation until the load is completed.

Router Resolver
@Injectable()
export class OrdersResolver implements Resolve<boolean> {
  constructor(private store: Store<DatasetsState>) { }

  resolve(): Observable<boolean> {
    return this.store.pipe(
      select(allDatasetsLoaded),
      tap(loaded => {
        if (!loaded) {
          this.store.dispatch(new AllDatasetsRequested());
        }
      }),
      filter(loaded => loaded),
      first()
    );
  }
}
https://stackblitz.com/edit/angular-ngrx-initiate-load-router-resolve

Using a resolver works very similarly to a guard. The main difference is that a resolve is run under somewhat different circumstances to a guard, and is supposed to return an object to be merged into the activated route's data. However, we should not do this, as components should be retrieving the data from the store, not from the activated route. As such, the resolve should simply return a boolean.

Router Action Effect
@Effect()
loadOrders$ = this.actions$.pipe(
  ofType<RouterNavigationAction>(ROUTER_NAVIGATION),
  withLatestFrom(this.store.select(allOrdersLoaded)),
  filter(([action, loaded]) => 
    action.payload.routerState.url.includes('/orders') && !loaded
  ),
  map(() => new LoadOrdersRequested())
);
Pros:

Keeps things within NgRx, so feels more idiomatic.
Cons:

Requires you check if the new route matches, rather than relying on the router itself to do this as the guard approach does. This could cause loading bugs if someone changes a path in your router config, but forgets to do so in your effects.
Dispatch an action from a check inside a selector
export function getAllOrders(store: Store<AppState>) { 
  return createSelector(
    getOrders,
    state => {
      if (!state.allOrdersLoaded) {
        store.dispatch(new LoadOrdersRequested());
      }

      return state.orders;
    }
  );
}
I've not actually seen this done in the wild, but it's an approach that occurred to me.

Pros:

Guarantees to load the data if and only if it's been queried for use.
Cons:

Violates principle that selectors should be pure functions.
If you're not rigorous about reusing and combining your selectors, you could end up with some that trigger the load and some that don't because they defer to the selector that triggers the load.
Future possibilities
It sounds as if Angular Ivy may open up the possibility of using meta-programming on components to configure things like store dependencies in a more declarative way.

Conclusion
I'm not sure any one of these approaches obviously wins over all the others in all situations. You are probably best choosing an approach based on the number of data sources you need to load, the volume of data, and the complexity and layout of your router tree.

E.g. if you have a small, simple app, with a low data volume, eagerly loading everything at INIT is probably the best idea.

However, if you have a large app, split into different features, with each feature needing to load data from a separate source, it might be best to use a guard at the root of each feature's route hierarchy to dispatch the load action for its requirements.

If you have a complex app, with various containers having partially overlapping data requirements, it might be best to have each container dispatch the actions to load what they need.




