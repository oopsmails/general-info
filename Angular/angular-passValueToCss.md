
# Passing Value to CSS


## angular pass progress percentage to css

- Ref:
https://stackoverflow.com/questions/59386685/how-can-i-get-progress-bar-dynamically-in-angular


### Easy and Simple way:

You can try using [ngStyle] You can take two variables (or more depending on your colors).

Let's say x and y, assign values to them

Then you can do:

```
getStyle() {
return {background: `linear-gradient(to right, green ${this.x}%, orange 
${this.y}% 100%)`};
}     

[ngStyle]="getStyle()"
```

or you can do inline:

```
[ngStyle]="{'background': 'linear-gradient(to right, green '+ x + '%' + ', orange ' + y + '% ' + '100%)'}"
```




