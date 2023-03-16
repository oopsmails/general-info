# CSS and SCSS Accumulations

## Avoid line break between html elements

- Ref:

https://stackoverflow.com/questions/2076109/how-to-avoid-a-new-line-with-the-p-tag

- Code:

```
#container p { display: inline }

span, p {white-space: nowrap;}


https://stackoverflow.com/questions/19212188/avoid-line-break-between-html-elements

???

<td>
  <span class="inline-flag">
    <i class="flag-bfh-ES"></i>
    <span>+34 666 66 66 66</span>
  </span>
</td>
css:

.inline-flag {
   position: relative;
   display: inline;
   line-height: 14px; /* play with this */
}

.inline-flag > i {
   position: absolute;
   display: block;
   top: -1px; /* play with this */
}

.inline-flag > span {
   margin-left: 18px; /* play with this */
}

```

## img wrapper

- 013-angular-ngb-ngx-ngxb\src\app\ngb\ngb-table\ngb-table.component.scss

```
.img-wrap {
    display: inline-block;
    margin-right: 6px;
}

.img-wrap img {
    width: auto;
    height: auto;
    max-width: 100%;
    max-height: 100%;
}
```
