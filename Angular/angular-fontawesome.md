
# Angular and Font Awesome


## Angular 10 

- check version 

https://www.npmjs.com/package/@fortawesome/angular-fontawesome

check, angular 10 is with @fortawesome/angular-fontawesome, 0.7.x

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


