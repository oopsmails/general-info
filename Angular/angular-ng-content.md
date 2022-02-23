
# Difference between ng-template, ng-container and ng-content

- Ref:

https://vibhas1892.medium.com/difference-between-ng-template-ng-container-and-ng-content-a1d264619655


##  *<ng-template></ng-template>*

As the name suggests the *<ng-template>* is a template element that Angular uses with structural directives ( *ngIf , *ngFor , *[ngSwitch]* and custom directives). These template elements only work in the presence of structural directives, which help us to define a template that doesn’t render anything by itself, but conditionally renders them to the DOM. It helps us create dynamic templates that can be customized and configured.

```
<div> 
   Ng-template Content 
   <div *ngIf=”false else showNgTemplateContent”> 
      Shouldn't be displayed 
   </div>
</div>
 
<ng-template #showNgTemplateContent> Should be displayed
</ng-template>

```

In the above example, If the condition is false then we will show the text as “Shouldn't be displayed” else will show ng-template content as “Should be displayed”


## *<ng-container></ng-container>*
ng-container is an extremely simple directive that allows you to group elements in a template that doesn’t interfere with styles or layout because Angular doesn’t put it in the DOM

This is helpful if you don’t want any extra div on DOM, you can simply use
*ng-container*. For eg: If there are two structural directives are being called on one div as below:

```
<div *ngIf="details" *ngFor="let info of details">
  {{ info.content }}
</div>
```

Attempting to compile this code will result in the following error:

```
Can't have multiple template bindings on one element. Use only one attribute prefixed with *
```

One workaround would be to separate the bindings as below:

```
<div *ngIf="details">
  <div *ngFor="let info of details">
    {{ info.content }}
  </div>
</div>
```

Or we can use *<ng-container>* without adding any extra element to the DOM at runtime:

```
<ng-container *ngIf="details">
  <div *ngFor="let info of details">
    {{ info.content }}
  </div>
</ng-container>
```

## *<ng-content></ng-content>*
ng-content is used to project content into Angular components. You use the *<ng-content></ng-content>* tag as a placeholder for that dynamic content, then when the template is parsed Angular will replace that placeholder tag with your content.

For example, you have two components as parent and child component
and want to show some data in the child component from the parent component

In parent.component.html *<app-child>* selector is used to show data of child component

```
<app-child>
  <div> Child Component Details </div>
</app-child>
```

If you check on your browser *<div>Child Component Details</div>* inside
*<app-child></app-child>* would not be visible. What if we want to show this content? So this is where the ng-content directive comes into the picture. What we need to do is, just add “ng-content” inside the component template and it will find the content inside the directive tag and add it to that template at that particular place where we added the “ng-content” tag.

So instead of div, you do something similar with Angular components except if you tell Angular where to display it in the parent template using ng-content.

In child.component.html:

```
<h1>Child Info</h1>
<ng-content></ng-content>
```

Now go to your browser again, you are able to see this: *<div>Child Component Details</div>*

*<ng-content>* accepts a select attribute, which allows us to sort of name our slot, to be more specific, it allows us to define the selector of our slot. It means “Replace me only if the element has card-body attribute”. Then, we change our app component view to include the card-body attribute.

For example: In child.component.html:
```
<h1>Child Info</h1>
<ng-content select="[input], [form-field]"></ng-content>
```

In parent.component.html:

```
<app-child>
  <h1 input>Content1!</h3>
  <h2 form-field>Content2!</h2>
  <h3 input form-field>Content1 & Content2!</h1>
</app-child>
```

If you check your browser, **all the heading tags will be visible** from child component with the help of *<ng-content>*.


To sum up, *ng-content* is used to display children in a template, *ng-container* is used as a non-rendered container to avoid having to add a span or a div, and *ng-template* allows you to group some content that is not rendered directly but can be used in other places of your template or you code.


## Example of ng-content in my GitHub


```
- ionic-plugins\src\app\components\pickup-call-card\pickup-call-card.component.html

define where to put *ng-content*

<ng-content select="[header]"></ng-content>
... ... other contents ... ...
<ng-content select="[footer]"></ng-content>


- ionic-plugins\src\app\pages\home\home.page.html, using ng-content

<app-pickup-call-card status="hold" updatedAt="25/04/2021 16:29" createdAt="24/04/2021"
notes="we have two bags that are full, one with plastic and the other with glasses">
    <ion-card-header header> <----------------------------------- Here, pass in *header* content into component page
        <ion-card-subtitle>Last pickup call</ion-card-subtitle>
    </ion-card-header>
    <ion-button color="success" fill="clear" size="full" footer (click)="goToPickupCalls()">See all...</ion-button> <----------------------------------- Here, pass in *footer* content into component page
</app-pickup-call-card>

- ionic-plugins\src\app\pages\pickup-calls\pickup-calls.page.html, using *pickup-call-card.component*, but NOT using ng-content

<ion-content>
    <app-pickup-call-card status="hold" updatedAt="25/04/2021 16:29" createdAt="24/04/2021"
    notes="we have two bags that are full, one with plastic and the other with glasses"></app-pickup-call-card>

    <app-pickup-call-card status="processing" updatedAt="24/04/2021 10:00" createdAt="23/04/2021"
    notes="we have two bags that are full"></app-pickup-call-card>

    <app-pickup-call-card status="finished" updatedAt="23/04/2021 18:00" createdAt="22/04/2021" value="$ 10,00"></app-pickup-call-card>
</ion-content>

```

