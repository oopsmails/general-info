

# Typescript Syntax

## typescript two exclamation marks

### The !! ensures the resulting type is a boolean (true or false).

var myThemeKey = (!!$('row') && $('row').hasClassName('green-theme')) ? 'green' : 'white';

javascript:alert("foo") --> foo

javascript:alert(!"foo") --> false

javascript:alert(!!"foo") --> true

javascript:alert(!!null) --> false

They do this to make sure $('row') isn't null.

- Guarentee a boolean ... 

- It converts Object to boolean. If it was falsey (e.g., 0, null, undefined, etc.), it would be false, otherwise, true.


- ! is the logical negation or "not" operator. !! is ! twice. **It's a way of casting a "truthy" or "falsy" value to true or false, respectively.** Given a boolean, ! will negate the value, i.e. !true yields false and vice versa. Given something other than a boolean, the value will first be converted to a boolean and then negated. For example, !undefined will first convert undefined to false and then negate it, yielding true. Applying a second ! operator (!!undefined) yields false, so in effect !!undefined converts undefined to false.

In JavaScript, the values false, null, undefined, 0, -0, NaN, and '' (empty string) are "falsy" values. All other values are "truthy."(1):7.1.2 Here's a truth table of ! and !! applied to various values:

```

 value     │  !value  │  !!value
━━━━━━━━━━━┿━━━━━━━━━━┿━━━━━━━━━━━
 false     │ ✔ true   │   false
 true      │   false  │ ✔ true
 null      │ ✔ true   │   false
 undefined │ ✔ true   │   false
 0         │ ✔ true   │   false
 -0        │ ✔ true   │   false
 1         │   false  │ ✔ true
 -5        │   false  │ ✔ true
 NaN       │ ✔ true   │   false
 ''        │ ✔ true   │   false
 'hello'   │   false  │ ✔ true

```


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







