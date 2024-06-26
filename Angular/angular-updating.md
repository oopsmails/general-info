
# Angular Updating

## 20220117: Maintaining different versions of Node and Angular

- Ref:

https://dev.to/patricepeartree/how-to-run-multiple-node-and-angular-versions-simultaneously-3lfj

- Using nvm control node
- Maintain different Angular version in each individual project
- Using following for Angular CLI

```
- Use package.json scripts

The npm run-script command adds the node_modules/.bin binaries to the pre-existing shell's PATH that is then provided to the scripts. This means that scripts in package.json which execute ng will be running the locally-installed Angular CLI. If you also want to directly execute ng in the shell using this approach, you can add "ng": "ng" as a script in package.json.

# serve your application with nvm and local Angular CLI
$ nvm exec npm start

# create an Angular component using local Angular CLI
$ nvm exec npm run ng g component my-cool-component

- Use node_modules/.bin/ng

Run the local Angular CLI by directly executing the binaries present in the node_modules/.bin folder in a shell.

# create an Angular component using local Angular CLI
$ nvm exec ./node_modules/.bin/ng g component my-cool-component

```



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


 #### Error message "error:0308010C:digital envelope routines::unsupported"

- Solution 1:

Always use LTS for real applications, it fixed the issue

```
nvm install 16.13.0
nvm use 16.13.0
```

- Solution 2: didn't try

I found the commands below on GitHub:

For Windows, use the below command in cmd:

`set NODE_OPTIONS=--openssl-legacy-provider`

For Unix, use:

`export NODE_OPTIONS=--openssl-legacy-provider`

I faced this issue in Docker build, and I have added this line in the Docker file:

`RUN export NODE_OPTIONS=--openssl-legacy-provider && yarn build && yarn install --production --ignore-scripts --prefer-offline`

for local development add the switch in package.json

#### package.json scripts windows???

"postinstall": "echo this is example for windows && (cd api && npm install); (cd web && npm install); (cd shared && npm install)",


#### Could not resolve dependency: npm ERR! peer @angular/compiler@"11.2.8"

In addition to using the npm install --save --legacy-peer-deps command line option, this can also be set more permanently as a config option: `npm config set legacy-peer-deps true`.

If above approach does not work try removing the node_modules folder and package-lock.json file and run command npm install.

e.g,

npm install @ngrx/store @ngrx/effects @ngrx/entity @ngrx/store-devtools --save --legacy-peer-deps

#### Data path "" must NOT have additional properties(es5BrowserSupport).

es5BrowserSupport add additional polyfill

Solution 1

For option es5BrowserSupport your @angular/cli required minimum version 7.3 and @angular-devkit/build-angular required minimum version 0.13 .

Check your @angular/cli version. if is less than 7.3 then run following command

ng update @angular/cli

Check your @angular-devkit/build-angular version. if is less than 0.13 then run following command

ng update @angular-devkit/build-angular

Solution 2

Also you can edit angular.json file and find "es5BrowserSupport": true and comment it. It will also work without updating dependency

#### Property 'addAll' does not exist on type 'EntityAdapter ...

fix(angular): replace addAll with setAll #3699

#### error TS2305: Module '"@angular/platform-browser"' has no exported member 'DOCUMENT'.

import {DOCUMENT} from '@angular/common';


#### error TS2339: Property 'URL' does not exist on type 'Window'.

- temp solution for now, will fix later

```
@Inject(WINDOW) private window: Window
change to:
@Inject(WINDOW) private window: any) {
```

#### error TS2339: Property 'throw' does not exist on type 'typeof Observable'.

```
return Observable.throw(new NotFoundError());
change to:
return  throwError(() => new AppError(error));
```

#### error TS2339: Property 'forRoot' does not exist on type 'typeof NgbModule'.

```
NgbModule.forRoot().ngModule
NgbModule.forRoot()

all change to:

NgbModule

```


