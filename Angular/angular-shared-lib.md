# Create your Standalone Angular Library in 10 minutes


## Create your library

> Commands

```
npm install --global @angular/cli

-- ng new angular-oops-lib --create-application=false

ng new 001-angular-oops-lib --create-application=false

-- ng new <app name> --skip-install --directory <directory you need the app to generate>

cd 001-angular-oops-lib/

ng generate library angular-oops-shared-components

- if error, then open VS Code and run it
liu@lenovo-small MINGW64 /c/oopsmails/001-angular-oops-lib (master)
$ ng generate library angular-oops-shared-components
bash: $'\302\203ng': command not found

ng build

------------------

cd ./projects/angular-oops-shared-components
npm install lodash.concat


- error with Angular 15: npm install lodash.concat --save-dev

npm i --save-dev @types/lodash

- open ./projects/angular-oops-shared-components/package.json, copy `"@types/lodash": "^4.14.191"`, to "peerDependencies" section


ng build
ng test

npm pack or npm publish

angular-oops-shared-components-0.0.1.tgz is generated



```






## Refs:

https://indepth.dev/posts/1193/create-your-standalone-angular-library-in-10-minutes






