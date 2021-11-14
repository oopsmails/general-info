# Learning React

- Refs:

https://www.youtube.com/watch?v=Dorf8i6lCuk  

https://www.youtube.com/watch?v=LMagNcngvcU  

https://www.youtube.com/watch?v=Tpt9t5IV7Vw&list=PLGRDMO4rOGcNLnW1L2vgsExTBg-VPoZHr&index=8  

## Quick Start
npx create-react-app react-employee

cd react-employee
npm start

if error (e.g, ETXTBSY: text file is busy), then use Windows to run first.

## Bootstrap

### Option 1:
Google ::> bootstrap 4 cdn link ::> copy CSS to index.html, after `<title>`

### Option 2:

npm install bootstrap --save

index.js ::> `import 'bootstrap/dist/css/bootstrap.min.css'`


## Concepts

### JSX vs Typescript

- Ref:

https://stackoverflow.com/questions/40410840/typescript-vs-jsx

JSX is NOT a language. It's NOTHING BUT Javascript but with a different extension. Facebook came up with this new extension so that they can demarcate the XML-like implementation of HTML in JavaScript. In early versions of React, this extension was mandatory for writing HTML inside JavaScript. However, this restriction was removed a few years ago which basically meant that there is no difference at all in JS and JSX. (Using only .js extension is the standard norm nowadays BTW)

Coming to TypeScript, it is a SUPERSET of JavaScript which adds extra functionalities to plain JavaScript making the applications more robust. Watch this video for better understanding of TypeScript: https://channel9.msdn.com/posts/Anders-Hejlsberg-Introducing-TypeScript

To conclude, JSX = JS, typescript is a superset of Javascript, and there is no comparison between JSX and TypeScript.



