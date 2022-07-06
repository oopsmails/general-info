
# Node.js Framework: Next, Nuxt, Nest

- Refs:

> https://nodesource.com/blog/next-nuxt-nest/
> https://www.rlogical.com/blog/difference-between-next-js-vs-nuxt-js-vs-nest-js/


The differences between three more very popular frameworks: Next, Nuxt, and Nest. These three frameworks are server-side rendering, and they are closely related to React, Vue, and Angular (the three most widely used front-end frameworks), respectively.


## Nest

A progressive Node.js framework for building efficient, scalable, and enterprise-grade server-side applications on top of TypeScript and JavaScript (ES6, ES7, ES8), Nest is heavily inspired by Angular.

Nest is a framework for building efficient, scalable Node.js server-side applications. It uses modern JavaScript, is built with TypeScript (preserves compatibility with pure JavaScript) and combines elements of OOP (Object Oriented Programming), FP (Functional Programming), and FRP (Functional Reactive Programming).

Under the hood, Nest makes use of *Express*, but also provides compatibility with a wide range of other libraries, like e.g. Fastify, allowing for easy use of the myriad third-party plugins which are available.

### Installation
Install it:

```
$ npm i @nestjs/cli
$ nest new project-name
```

Alternatively, to install the TypeScript starter project with Git:

```
$ git clone https://github.com/nestjs/typescript-starter.git project
$ cd project
$ npm install
$ npm run start
```

#### Basic Hello World app
After installing Nest.js with the npm cli command, and creating a new project with nest new project-name, a src/ directory will be created and populated with several core files, including main.ts. The main.ts includes an async function, which will bootstrap our application:

```
import { NestFactory } from '@nestjs/core';
import { ApplicationModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(ApplicationModule);
  await app.listen(3000);
}
bootstrap();

```

And then to run the app that listens on port 3000, you execute:

```
$ npm run start

```

### Advantages
As a TypeScript-based web framework, strict type definition is possible
The framework is very annotation-driven, with everything from endpoints to Swagger documentation being generated from them. The endpoints are clean and simple, and the annotations make developing simpler all around.
The folder structure in Nest.js is heavily based on Angular. This allows for minimal downtime when first designing a Nest service.
Because Nest.js is a module-based framework, it’s easyto externalize general-purpose modules and reuse code in multiple projects
Components get their own folders, with an application module and main file residing in the root. This simple structure allows more attention to be paid to the design of endpoints and their consumers, instead of application structure.
Nest.js uses the latest version of TypeScript, which helps ensure that it will remain relevant in the rapidly changing JavaScript landscape and gives developers less context switching. The transition from Angular code to Nest is relatively easy.
Similar to Angular, Nest also has a decent command line tool, available through Node Package Manager, nestjs/cli. The command line tool will let you scaffold the project, generate Nest architecture components, and display project information.


### Disadvantages

> The largest risk facing Nest users is the lack of documentation. The framework has great integrations with other frameworks but the documentation is minimal and doesn’t cover any issues that may arise.
> Nest does hold an edge in its use of TypeScript and relation to Angular, but it doesn’t have the backing power of a large enterprise behind it.
Overall, Nest has a smaller community compared to other frameworks


### Performance
nest

This is a basic Hello World app in Nest.js. It handles 928.18 requests per second. The average time spent per request is 10.774 ms. On this metric, Nest.js performed the best out of the three frameworks we compared.




## Next

Next is the most popular framework compared to the other two. It has more npm weekly downloads, GitHub stars and number of contributors.

Next.js is a React framework that lets you build server-side rendering and static web applications using React.


### Advantages

Every component is server-rendered by default
Automatic code splitting for faster page loads
Unnecessary code is not loaded
Simple client-side routing (page-based)
Webpack-based dev environment which supports Hot Module Replacement (HMR)
Fetching data is very simple
Can be implemented with Express or any other Node.js HTTP server
It’s possible to customize with your own Babel and Webpack configurations
Easy to deploy anywhere if Node.js is supported
Built-in handling of search engine optimization (SEO) for pages


### Disadvantages

> **Next.js is not backend**; if you need backend logic, such as a database or an accounts server, you should keep that in a separate server application
> Next is powerful, but If you’re creating a simple app, it can be overkill
> All data needs to be loadable from both the client and server
> Migrating a server-side app to Next.js is not a quick process, and depending on your project it may be too much work


### Performance
To measure the performance, I used Apache Bench for benchmarking, which highlights how many requests per second the app is capable of serving. I also used lighthouse to audit performance, accessibility, best practices, and SEO.

next

This is a basic Hello World app in Next.js. It handles 550.87 requests per second. This value is the result of dividing the number of requests by the total time taken. The average time spent per request is 18.153 ms.

**Compared to the other two frameworks, Next.js scored better overall than Nuxt.js but worse than Nest.js**


## Nuxt

### Advantages
Its main scope is UI rendering, while abstracting away the client/server distribution
Statically render your Vue apps and get all of the benefits of a universal app without a server
Get automatic code splitting (pre-rendered pages)
Setup via the command line with the starter template
Get great project structure by default
Easily set up transitions between your routes and write single file components
Get ES6/ES7 compilation without any extra work
Get set up with an auto-updating server for easy development
Powerful Routing System with Asynchronous Data
Static File Serving
ES6/ES7 Transpilation
Hot module replacement in Development
Pre-processor: Sass, Less, Stylus, etc.


### Disadvantages
> It has a smaller community, which means fewer resources and potentially less extensive documentation
> Lack of some common solid plugins/components. (Google maps, calendar, vector maps). Some components for that exist, but they are generally not very well maintained.
> It is necessary to go deep in more complex components/plugins. If you want to develop something very flexible, you have to get down to render functions/jsx to do that. (e.g render the contents of a slot in another place/component).
> Props have to be specified explicitly. There might be cases when you want to transform some CSS classes to props; you’ll have to specify these props or use $attrs / render functions or jsx.
> Reactivity caveats like setting an item from an array directly this.items[key]=value or adding a new data property.
> High traffic may put strain on your server
> You can only query and manipulate the DOM in certain hooks


### Performance
nuxt

This is a basic Hello World app in Nuxt.js. It handles 190.05 requests per second. The average time spent per request is 52.619 ms. On this metric, Nuxt.js performs the worst compared to the other two frameworks.

