
# State Management: NgStore

- Refs:

https://ngrx.io/guide/store

https://ngrx.io/guide/store/why

## Why use NgRx Store for State Management?
NgRx Store provides state management for creating maintainable, explicit applications through the use of single state and actions in order to express state changes. In cases where you don't need a global, application-wide solution to manage state, consider using NgRx ComponentStore which provides a solution for local state management.

### When Should I Use NgRx Store for State Management?
In particular, you might use NgRx when you build an application with a lot of user interactions and multiple data sources, or when managing state in services are no longer sufficient.

A good guideline that might help answer the question, "Do I need NgRx Store?" is the **SHARI** principle:

- Shared: state that is accessed by many components and services.

- Hydrated: state that is persisted and rehydrated from external storage.

- Available: state that needs to be available when re-entering routes.

- Retrieved: state that must be retrieved with a side-effect.

- Impacted: state that is impacted by actions from other sources.

However, realizing that using NgRx Store comes with some tradeoffs is also crucial. It is not meant to be the shortest or quickest way to write code. It also encourages the usage of many files.

It's also important to consider the patterns implemented with NgRx Store. A solid understanding of RxJS and Redux will be very beneficial before learning to use NgRx Store and the other state management libraries.

### Key Concepts

- Type Safety
Type safety is promoted throughout the architecture with reliance on the TypeScript compiler for program correctness. In addition to this, NgRx's strictness of type safety and the use of patterns lends itself well to the creation of higher quality code.

- Immutability and Performance
Store is built on a single, immutable data structure which makes change detection a relatively straightforward task using the OnPush strategy. NgRx Store also provides APIs for creating memoized selector functions that optimize retrieving data from your state.

- Encapsulation
Using NgRx Effects and Store, any interaction with external resources side effects such as network requests or web sockets, as well as any business logic, can be isolated from the UI. This isolation allows for more pure and simple components and upholds the single responsibility principle.

- Serializability
By normalizing state changes and passing them through observables, NgRx provides serializability and ensures the state is predictably stored. This allows the state to be saved to external storage such as localStorage.

This also allows the inspection, download, upload, and the dispatch of actions all from the Store Devtools.

- Testable
Because Store uses pure functions for changing and selecting data from state, as well as the ability to isolate side effects from the UI, testing becomes very straightforward. NgRx also provides test resources such as provideMockStore and provideMockActions for isolated tests and an overall better test experience.


## Real Steps

### Define States

```
export interface AppState {
    loading: LoadingState;
    login: LoginState;
    register: RegisterState;
}

export const AppInitialState: AppState = { ... }

export interface LoadingState {
    show: boolean;
}

export interface LoginState {
    error: any;
    isRecoveredPassword: boolean;
    isRecoveringPassword: boolean;
    isLoggedIn: boolean;
    isLoggingIn: boolean;
}

export class RegisterState {
    error: any;
    isRegistered: boolean;
    isRegistering: boolean;
}

```

## Actions

```
- src\store\register\register.actions.ts
import { createAction, props } from "@ngrx/store";
import { UserRegister } from "src/app/model/user/UserRegister";

export const register = createAction('[Register]', props<{userRegister: UserRegister}>());
export const registerSuccess = createAction('[Register] success');
export const registerFail = createAction('[Register] fail', props<{error: any}>());


- src\store\loading\loading.actions.ts
export const show = createAction("[Loading] show");
export const hide = createAction("[Loading] hide");

- src\store\login\login.actions.ts
export const recoverPassword = createAction("[Recover password]", props<{email: string}>());
export const recoverPasswordSuccess = createAction("[Recover password] success");
export const recoverPasswordFail = createAction("[Recover password] fail", props<{error: any}>());

export const login = createAction("[Login]", props<{email: string, password: string}>());
export const loginSuccess = createAction("[Login] success", props<{user: User}>());
export const loginFail = createAction("[Login] fail", props<{error: any}>());

```

## Reducers

```
- src\store\register\register.reducers.ts

const initialState = AppInitialState.register;

const reducer = createReducer(initialState,
    on(register, state => {
        return {
            ...state,
            error: null,
            isRegistered: false,
            isRegistering: true
        }
    }),
    on(registerSuccess, state => {
        return {
            ...state,
            isRegistered: true,
            isRegistering: false
        }
    }),
    on(registerFail, (state, action) => {
        return {
            ...state,
            error: action.error,
            isRegistered: false,
            isRegistering: false
        }
    })
);

export function registerReducer(state: RegisterState, action){
    return reducer(state, action);
}

- src\store\loading\loading.reducers.ts

const initialState: LoadingState = {
    show: false
}

const reducer = createReducer(
    initialState,
    on(show, () => {
        return {show: true};
    }),
    on(hide, () => {
        return {show: false};
    })
);

export function loadingReducer(state: LoadingState, action){
    return reducer(state, action);
}

```

## AppStoreModule, adding reducers one by one and do TDD 

- TDD see, src\store\register\register.store.spec.ts

- src\store\AppStoreModule.ts
```
export const AppStoreModule = [
    StoreModule.forRoot([]),
    StoreModule.forFeature("loading", loadingReducer),
    StoreModule.forFeature("login", loginReducer),
    StoreModule.forFeature("register", registerReducer),
    EffectsModule.forRoot([]),
    EffectsModule.forFeature([
        LoginEffects,
        RegisterEffects
    ])
]
```

## Services: between Effect and Service, dev Service first

```
- src\app\services\auth\auth.service.ts, could mock it first

  register(userRegister: UserRegister) : Observable<void> {
    return new Observable<void>(observer => {
      setTimeout(() => {
        if (userRegister.email == "error@email.com") {
          observer.error({message: "email already registered"});
        } else {
          observer.next();
        }
        observer.complete();
      }, 3000)
    })
  }

```


## Effects: Using TDD to dev!

- TDD, see src\store\register\register.effects.spec.ts

```
- src\store\register\register.effects.ts

@Injectable()
export class RegisterEffects {

    constructor(private actions$: Actions, private authService: AuthService){

    }

    register$ = createEffect(() => this.actions$.pipe(
        ofType(register),
        switchMap((payload: {userRegister: UserRegister}) => 
            this.authService.register(payload.userRegister).pipe(
                map(() => registerSuccess()),
                catchError(error => of(registerFail({error})))
            )
        )
    ))

}

- src\store\AppStoreModule.ts

EffectsModule.forFeature([
        LoginEffects,
        RegisterEffects
    ])

```


## On pages, dispatch Action to change AppState

- TDD, src\app\pages\register\register.page.spec.ts

```

- src\app\pages\register\register.page.ts

  register(){
    this.registerForm.getForm().markAllAsTouched();

    if (this.registerForm.getForm().valid){
      this.store.dispatch(register({userRegister: this.registerForm.getForm().value})); <---- firing *register Action* to register!!!
    }
  }


  private watchRegisterState() {
    this.registerStateSubscription = this.store.select('register').subscribe(state => { <---- watching if *register Action* is complete!!! Need unsubscript !!!!!
      this.toggleLoading(state);

      this.onRegistered(state);
      this.onError(state);
    })
  }

registerStateSubscription: Subscription;

ngOnDestroy() { <------------------- unsubscript!!!!!!
    this.registerStateSubscription.unsubscribe();
  }

private onRegistered(state: RegisterState){ <------- if *register Action* complete successfully, to home page through *login Action*
    if (state.isRegistered){
      this.store.dispatch(login({
        email: this.registerForm.getForm().value.email,
        password: this.registerForm.getForm().value.password
      }))
    }
  }

  private onError(state: RegisterState){ <------- if *register Action* complete with Error
    if (state.error){
      this.toastController.create({
        message: state.error.message,
        duration: 5000,
        header: 'Registration not done'
      }).then(toast => toast.present());
    }
  }

  private toggleLoading(state: RegisterState) { <------- show *Spinner* when waiting for *register Action* complete
    if (state.isRegistering){
      this.store.dispatch(show());
    } else {
      this.store.dispatch(hide());
    }
  }

- src\app\pages\register\register.page.spec.ts


```


