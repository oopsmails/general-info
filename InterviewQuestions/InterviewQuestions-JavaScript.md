
- Add to start and end of an Array

```
var myArr = ['a', 'a', 'a', 'a', 'a'];

myArr.push('end');
myArr.unshift('start');
console.log(myArr);
```
-- spread operator  
`myArr = ['start', ...myArr, 'end']`

- .bind  
```
var hero = {
    _name: 'John Doe',
    getPrivateField: function () {
        return this._name;
    }
};

var printPrivateField = hero.getPrivateField.bind(hero);

console.log(printPrivateField());
console.log(hero.getPrivateField());

```



