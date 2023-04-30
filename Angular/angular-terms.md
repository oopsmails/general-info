# Angular Terms and Common Knowledge

## what about `<input #myInput ...>` vs `<input id="myInput">`?

The main difference between using #myInput and id="myInput" in an `<input> `element is that #myInput creates a local variable in the template which can be referenced by the template code, while id="myInput" assigns an identifier to the input element that can be used for styling or targeting the element with JavaScript.

When you use #myInput in the input element, you can refer to the input element using the local variable myInput in the template code, for example in an event binding or in an ngIf directive. Here's an example:

```
<input #myInput type="text">
<button (click)="onButtonClick(myInput.value)">Click me</button>
```

In the above code, #myInput creates a local variable named myInput that refers to the input element. When the user clicks the button, the onButtonClick method is called with the value of the input element as its argument.

On the other hand, when you use `id="myInput"`, you can target the input element using CSS or JavaScript. For example, you could apply a CSS style to the input element using the` #myInput` selector, or you could select the input element using JavaScript with `document.getElementById('myInput')`.

##
