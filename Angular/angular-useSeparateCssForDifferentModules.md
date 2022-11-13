# Using Separate CSS for Different Modules

- The problem

In my angular-all project, using normal scss everywhere except, Login and article feeds part ...

## The following is globally though in one of the components ...

- Ref: https://stackoverflow.com/questions/51360813/separate-styles-for-separate-module-in-angular-5

I found the solution. We can disable or enable css files in component.

document.styleSheets[2].disabled = false;
or

document.styleSheets[2].disabled = true;

## Will try

write a re-component to enable or disable it ...

https://stackoverflow.com/questions/58553876/angular-2-how-to-dynamically-change-an-entire-css-stylesheet-based-on-url-quer

## other

- What are the ways to add conditional css file in Angular

You can use ngClass directive:

```
<div id="mydiv" [ngClass]="{'myCSSclass' : condition}"></div>
```

- toggle

https://stackoverflow.com/questions/41531846/conditionally-loading-stylesheet-angular-2

## Temp codes

```
    // const cssUrls = ['../../../../shared/scss/ionicons.min.scss', '../../../../shared/scss/productionready.main.scss'];
    const cssUrls = ['//demo.productionready.io/main.css', '//code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css'];
    this.setDynamicStyle(cssUrls);


setDynamicStyle(cssUrls: string[]) {
    const head = document.getElementsByTagName('head')[0];

    cssUrls.forEach((cssUrl: string) => {
      const style = document.createElement('link');
      // style.id = 'css-styling';
      style.rel = 'stylesheet';
      // style.href = `${cssURL}`;
      // style.href = cssUrl;
      style.href = 'data:text/css,' + escape(cssUrl);
      head.appendChild(style);
    });

  }

```
