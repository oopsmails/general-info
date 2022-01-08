
# Angular and Font Awesome


## Angular 10 

- check version 

https://www.npmjs.com/package/@fortawesome/angular-fontawesome

check, angular 10 is with @fortawesome/angular-fontawesome, 0.7.x

If version mismatch, then will get errors like,

```
node_modules/@fortawesome/angular-fontawesome/fontawesome.module.d.ts:12:21 - error TS2694: Namespace '"C:/sharing/github/angular-ngrx-store/angular-simple/node_modules/@angular/core/core"' has no exported member 'ɵɵInjectorDeclaration'.
```

```
npm install @fortawesome/angular-fontawesome@0.7.* <--------------------- Note Here

npm install @fortawesome/fontawesome-svg-core
npm install @fortawesome/free-brands-svg-icons
npm install @fortawesome/free-regular-svg-icons
npm install @fortawesome/free-solid-svg-icons

```

- Then we need to import this in app.module.ts:

```
imports: [
    BrowserModule,
    FontAwesomeModule
],

```

- src/app/app.component.html:

```
<div style="text-align:center">
  <fa-icon [icon]="faCoffee"></fa-icon>
</div>

```


- src/app/app.component.ts

```
import { Component } from '@angular/core';
import { faCoffee } from '@fortawesome/free-solid-svg-icons';
import { faAngleDown } from '@fortawesome/free-solid-svg-icons';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';
  faCoffee = faCoffee;
}

```


## Icon styling in Font Awesome

- Ref:

https://blog.logrocket.com/how-to-add-font-awesome-angular-project/

Font Awesome has four different styles, and we’ll look at the free icons — minus the Pro light icons, which use the prefix 'fal' and a professional license:

The solid icons use the prefix 'fas' and are imported from @fortawesome/free-regular-svg-icons
The regular icons use the prefix 'far' and are imported from @fortawesome/free-solid-svg-icons
The brand icons use the prefix 'fab' and are imported from @fortawesome/free-brands-svg-icons
Moving forward, let’s look at what mor

