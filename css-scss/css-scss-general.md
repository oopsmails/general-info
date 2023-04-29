# CSS and SCSS

## SCSS

### & usage

You need & to reference to the parent of a selector.

```
#id {
  .class {
    color: red;
  }

  &.class {
    color: blue;
  }
}

```

In CSS, the "&" (ampersand) symbol is used as a reference to the current selector. In the example you provided, "&.class" is used to add a modifier class to the parent selector, and apply styles to that modified class.

For example, if you have a button element with the class "btn", and you want to apply blue color to it when it has the class "active", you can use the following code:

```
.btn {
  /* styles for the button */
}

.btn.active {
  color: blue;
}

```

In Sass or SCSS, you can use the "&" symbol to reference the parent selector, like this:

```
.btn {
  /* styles for the button */

  &.active {
    color: blue;
  }
}

```

This will compile to the same CSS code as the previous example. The "&" symbol is replaced with the parent selector, so the resulting CSS will be ".btn.active" for the modified class.

### ~ tidle

tidle, ~, looking for the **preceeding** sibling _nav_ to the _nav-toggle_, doesn't have to **immidiatly after**.

In here, the location of _<checkbox>_, is right before the _<nav>_, it is clearer.

```
.nav-toggle:checked~nav {
    display: block;
}

```

The tilde symbol ~ in CSS is a sibling combinator. It selects all the siblings that come after the first element, but not the element itself.

For example, consider the following code:

```
<div>
  <p>Paragraph 1</p>
  <p>Paragraph 2</p>
  <p>Paragraph 3</p>
</div>

<p>Another paragraph</p>
```

If you want to select all the paragraphs that come after the first paragraph in the `<div>` element, you can use the ~ combinator as follows:

```
div p:first-child ~ p {
  color: red;
}
```

This will select the second and third paragraphs in the `<div>` element, and not the first paragraph, and apply the `color: red;` style to them.

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

### child conbinator vs descendant combinator

The > is called the "child combinator" and selects only the direct child element, while the space is called the "descendant combinator" and selects any descendant element that matches the selector.

```
.the-class > fieldset {
  ...
}

.the-class input {
  ...
}

"Class input" will select all elements with the class name "input", regardless of their parent elements. For example, it would select <input class="input"> and <div class="input"></div>.

"Class > fieldset" will select all fieldset elements that are direct children of elements with the class name "class". In other words, it will select only fieldset elements that are direct children of an element with the class "class". For example, it would select <div class="class"><fieldset></fieldset></div>, but not <div class="class"><span><fieldset></fieldset></span></div>.

```

## CSS

### font

```
@import url('https://fonts.googleapis.com/css?family=Open+Sans');

body {
  font-family: 'Open Sans', sans-serif;
  height: 100vh;
}

font-family: inherit;

```

### font-awesome

```
in html:

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />


<div class="action-buttons">
  <button class="down-button">
    <i class="fas fa-arrow-down"></i>
  </button>
  <button class="up-button">
    <i class="fas fa-arrow-up"></i>
  </button>
</div>

```

## Temp

### Question with &

for ".btn {
/_ styles for the button _/

&.active {
color: blue;
}
}" , is it the same as ".btn {
/_ styles for the button _/

.active {
color: blue;
}
}" ? I mean, the & is not necessary?

- Answer:

No, it is not the same. The & symbol in Sass is a reference to the parent selector, and is used to concatenate selectors. In the first example you provided, the .active class will only apply to elements that have both the .btn class and the .active class. However, in the second example, the .active class will apply to all nested elements that have the .active class, regardless of whether they have the .btn class.

So in summary, the & is necessary if you want to concatenate the parent selector with the child selector. If you don't use the &, then you're simply nesting one selector inside another, which is not the same thing.
