

# Typescript Syntax

## typescript two exclamation marks

### The !! ensures the resulting type is a boolean (true or false).

var myThemeKey = (!!$('row') && $('row').hasClassName('green-theme')) ? 'green' : 'white';

javascript:alert("foo") --> foo

javascript:alert(!"foo") --> false

javascript:alert(!!"foo") --> true

javascript:alert(!!null) --> false

They do this to make sure $('row') isn't null.

**It's shorter to type than $('row') != null ? true : false.**

## it's short way to cast a variable to be a boolean

- Ref:

https://brianflove.com/2014-09-02/whats-the-double-exclamation-mark-for-in-javascript

If you have ever noticed a double exclamation mark (!!) in someone's JavaScript code you may be curious what it's for and what it does. It's really simple: it's short way to cast a variable to be a boolean (true or false) value.

### True versus Truthy

When the function above is executed we will get the alert Huh? because the value of the variable nothing is being evaluated to be false. This is what is commonly referred to as truthy versus falsey.

- The following values are considered by JavaScript to be **falsey**s:

Empty string: ""
0
null
undefined
NaN

- The following values are considered by JavaScript to be **truthy**s:

Object: {}
Array: []
Not empty string: "anything"
Number other than zero: 3.14
Date: new Date();


### The type safe comparison operators are:

Strictly equal: ===
Strictly unequal: !==







