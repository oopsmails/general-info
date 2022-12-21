# Typescript General

## What's the difference between definite assignment assertion and ambient declaration?

typescript "!:", definite assignment assertion

- Ref:

https://stackoverflow.com/questions/67351411/what-s-the-difference-between-definite-assignment-assertion-and-ambient-declarat

The following code is an error in strict mode since TS doesn't know for sure that the field has been initialized.

class Person {
name: string; // Error: Property 'name' has no initializer and is not definitely assigned in the constructor.
}

I've seen 2 ways of handling this:

- Definite assignment assertion:
  class Person {
  name!: string;
  }

- Ambient declaration:
  class Person {
  declare name: string;
  }

Answer:
Declare is mainly useful for mocking values when playing around with the type system. In production code, it's rarely used.

declare name: string;
This says to the compiler:

"There is a property called name of type string. I shouldn't have to prove to you that name actually exists, but I want to use it anyway."

The declare keyword is typically used in type definition files that provide typings for files that Typescript cannot get type information from (such as plain JS files). So if I was reading your code, I would assume that name is getting monkey patched in from some JS file somewhere, and you are noting that here.

I would be incorrect.

name!: string;
This says to the compiler:

"There is a property called name with a type of string | undefined. It starts with a value of undefined. But every time I get or set that property, I want to treat it as type string."

Using this form it's clear to anyone reading the code that name is undefined at first, but is treated like a string anyway. That means it must be set in this file somewhere, just probably not in the constructor.
