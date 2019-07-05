- run js file in vs code

node test.js


- remove duplicates
let num = [1, 2, 2, 3]; // to [1, 2, 3]

console.log([...new Set(num)]);

- Spread Operators

let num1 = [1, 2, 2, 3];

let num2 = Object.assign([], num);
let num3 = [...x];

...x = 1,2,3,4
...y = 5,6,7

...x, ...y = 1,2,3,4,5,6,7

[...x, ...y] = [1,2,3,4,5,6,7]


let x = [1,2,3,4]
let y = [5,6,7]

console.log([...x, ...y]);
console.log(x.concat(...y));

let func = function(...arg) {
    console.log(arg);
}

func(...x); // [1,2,3,4]
func(x); // : [Array(4)], array of array, A[0] = [1,2,3,4]
func.apply(null, x);



