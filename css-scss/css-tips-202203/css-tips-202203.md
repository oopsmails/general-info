
# CSS Tips 202104

- The video is css-tips-202104

css-tips-202203

https://www.youtube.com/watch?v=Qhaz36TZG5Y

10 CSS Pro Tips - Code this, NOT that!

## 00:00 CSS is too hard (myth)


-webkit-transition: all 0.5s ease;
-moz-transition: all 0.5s ease;
-ms-transition: all 0.5s ease;
-o-transition: all 0.5s ease;
transition: all 0.5s ease;


## 00:56 1. Learn the box model

- 01:25
My web development career was to learn the css box model because when you understand it everything else in the language starts to make more sense!

- 01:36 
think of every html element as a boxinside that box you have the content which can have a width and height you can add padding  around that box to squeeze the content then you can add a border around the outside

## 02:00 2. Firefox is Amazeballs

Using Firebox to debug css is better than Chrome

## 02:31 3. Flexbox is Fantastic

02:35
How do i center a div both horizontally and vertically one option is to give the child absolute positioning then move it to the bottom right corner by using the top and left properties then translate it back 50 to put it in the center that can work but it's incredibly unintuitive a much better approach with modern css is flexbox which allows you to create a flexible column or row anywhere in the ui when an element has display flex it also has an x and y axis on which you can align its children the children flow one way which is known as the main axis and can be aligned in the center with the justify content property perpendicular to that is the cross axis and we can move our element to the center with the align items property flexbox is usually the first tool i reach for when it comes to layout


## 03:34 4. Grid is Great

- 03:18
but it does have one major drawback if you have a big complex ui with many intersecting rows and columns you may end up with a lot of container or wrapper elements in your html these elements have no semantic meaning and are just there so your css code has something to attach itself to

- 03:32
luckily there's a modern css feature called a **grid** that can obliterate much of your code unlike **flexbox which only deals with individual columns and rows** and grid allows you to think about the big picture layout if you've been a web developer for a long time it may look familiar because it's very similar to table layout way back in the day it's just much more developer friendly when you set an element to display **grid you can then define its children as a bunch of columns and rows columns have a width which can be defined with the grid template columns property** we have three values here separated by spaces which means our grid has three columns notice the fr value or fractional unit which will responsibly share the available space with other columns in the grid we can also define some rows and now every element inside the grid will be positioned automatically but the important thing to notice is the amount of html and css that we've eliminated compared to flexbox layout or god forbid table layout

## 04:23 5. Clamp it Down

css-tips-202203-07.png


## 05:09 Bonus: Impress your Boss

Might be discuss-able!

## 05:30 6. Aspect Ratio One-Liner

css-tips-202203-09.png

## 06:01 7. Variables for variables

css-tips-202203-11.png

## 06:46 8. Fancy Calculations

- Using calc()

css-tips-202203-12.png

## 07:38 9. State Management Counter

- The problem, css-tips-202203-13.png
- The solution, css-tips-202203-14.png

## 08:18 10. Finding focus-within

css-tips-202203-15.png

## 09:01 Bonus: Treat an Incurable Disease

css-tips-202203-16.png

