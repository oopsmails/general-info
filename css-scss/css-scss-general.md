
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

### :focus

.canbeusedmultipleclasses-italic:not(:focus) {
  font-style: italic;
}


