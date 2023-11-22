# Operators

## Spread Operator

The spread operator in JavaScript is a syntax that allows you to expand the elements of an iterable (such as arrays, strings, or objects) into another iterable or function call. It is denoted by three dots ... followed by an expression or an iterable12. Here are some examples of different usages of the spread operator:

### Copying an array:

You can use the spread operator to create a shallow copy of an array, without modifying the original array. For example:
const fruits = ["apple", "banana", "cherry"];
const copy = [...fruits]; // create a copy of fruits
console.log(copy); // ["apple", "banana", "cherry"]
console.log(fruits === copy); // false, they are different arrays

### Concatenating arrays:

You can use the spread operator to combine two or more arrays into a new array. For example:

```
const fruits = ["apple", "banana", "cherry"];
const vegetables = ["carrot", "lettuce", "tomato"];
const salad = [...fruits, ...vegetables]; // combine fruits and vegetables into a new array
console.log(salad); // ["apple", "banana", "cherry", "carrot", "lettuce", "tomato"]
```

### Passing an array as arguments:

You can use the spread operator to pass the elements of an array as arguments to a function. For example:

```
function sum(a, b, c) {
  return a + b + c;
}
const numbers = [1, 2, 3];
console.log(sum(...numbers)); // 6, equivalent to sum(1, 2, 3)
```

### Spreading a string:

You can use the spread operator to convert a string into an array of characters. For example:

```
const name = "Alice";
const chars = [...name]; // spread the string into an array of characters
console.log(chars); // ["A", "l", "i", "c", "e"]
```

### Spreading an object:

You can use the spread operator to copy or merge the properties of an object into another object. For example:

```
const person = { name: "Alice", age: 25 };
const copy = { ...person }; // create a copy of person
console.log(copy); // { name: "Alice", age: 25 }
console.log(person === copy); // false, they are different objects

const update = { age: 26, city: "New York" };
const updatedPerson = { ...person, ...update }; // merge person and update into a new object
console.log(updatedPerson); // { name: "Alice", age: 26, city: "New York" }
```
