
# CSS and SCSS

## SCSS 

### & usage

You need & to reference to the parent of a selector.

Documentation

#id {
  .class {
    color: red;
  }
  &.class {
    color: blue;
  }
}

### ~ tidle

pseudo class, hover

tidle, ~, looking for the **preceeding** sibling *nav* to the *nav-toggle*, doesn't have to **immidiatly after**.

In here, the location of *<checkbox>*, is right before the *<nav>*, it is clearer.

```
.nav-toggle:checked~nav {
    display: block;
}

```

### :focus :hover

```
.canbeusedmultipleclasses-italic:not(:focus) {
  font-style: italic;
}


li {
        
        a {
            color: white;
            text-decoration: none;
            display: block;
            padding: .5em;
            font-size: 1.3em;
            text-align: right;

            &:hover {
                font-weight: bold;
            }
        }
    }
```

### > div, immidiate div after

```
. left-slide > div {
  height: 100vh;
  ...
}


20.1

*first-child* and *nth-child(2)*

```

.features-main .card > i {
  margin-right: 20px;
}

.features-main .grid {
  padding: 30px;
}

.features-main .grid > *:first-child {
  grid-column: 1 / span 3;
}

.features-main .grid > *:nth-child(2) {
  grid-column: 1 / span 2;
}

```


