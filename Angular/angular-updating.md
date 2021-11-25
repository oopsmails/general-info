
# Angular Updating


## 202111: /github/angular-integration

- Ref:

https://medium.com/acute-angular/angular-7-npm-install-error-due-to-node-sass-node-gyp-python2-in-node-v12-88ead561fd88

### Initially using Angular 7

Errors:

Python2 not found
Can't find Python executable
node-gyp requires python2
Some node-gyp dependency unavailable
node-sass build fails
VC++ compiler error for some *.cpp files
Microsoft.Cpp.Default.Props was not found
Cannot convert argument 1 from 'v8::Local<v8::Value>' to 'const v8::String::Utf8Value


#### Using nvm updated npm

```
$ npm -v
8.1.2

$ node -v
v17.1.0
```

####  Problem: Error: Can't find Python executable "python", STOPPED!

if using python 3.x, then continue with error "angular node gyp SyntaxError: Missing parentheses in call to 'print'."

- Make sure you installed python on your machine.

If already installed try:

```
npm config set python <python.exe path>

npm config set python /c/programs/python310/python.exe
```

- Would not use because this will installing Python 2.7

Install all the required tools and configurations using Microsoft's windows-build-tools by running `npm install -g windows-build-tools` from an elevated PowerShell (run as Administrator).


#### angular Error: Cannot find module 'node-sass'

```
------ DO NOT use this with Node 16, use sass instead of node-sass, seee next Error

-- npm install --save-dev node-sass

npm uninstall node-sass
npm install node-sass@4.14.1

see https://stackoverflow.com/questions/67891774/node-sass-version-6-0-0-is-incompatible-with-4-0-0-5-0-0-in-react-js  

```

#### angular Error: Node Sass version 6.0.1 is incompatible with ^4.0.0.

https://stackoverflow.com/questions/67891774/node-sass-version-6-0-0-is-incompatible-with-4-0-0-5-0-0-in-react-js  

You could try uninstalling node-sass and replacing it with sass. That did it for me.

```
npm un node-sass
npm i -D sass
```

#### 
