# Angular General Infos

## Generals

### angular alias import not working

- angular alias, _@app_, import
- vs code not recognizing angular aliases
- seems not supported well in augular 14 and vs code as of 20221107.

### Different versions

You should always be able to run local for your current directory version of ANGULAR CLI by running:

```
node_modules/.bin/ng <ANY NG COMMAND>
```

instead of just

```
ng <ANY NG COMMAND>
```

- example

```
npm install @angular/cli //NOTE: no -g

node_modules/.bin/ng version

nvm install 18.12.1

nvm use 18.12.1 <------------ 20221219: not stable to be used

$ npm -v
8.19.2

$ node -v
v18.12.1

node_modules/.bin/ng new angular-marterial-test <--------------- will error, file dir hierarchy messed up!

SHOULD do,

```

### Create new app with different Angular version other than global

#### New Way: very simple, 20230202

```
npx -p @angular/cli@14 ng new 002-oopsmails-angular-lib-a14 --skip-install
```

This will also generate with git repo, i.e, .git folder will also be generated, which means, can generate Angular application first, then create remote github repository after.

#### Old Way

```
create a new folder, e.g, /c/oopsmails/999-workspace

npm install @angular/cli@14

liu@lenovo-small MINGW64 /c/oopsmails/999-workspace
$ ng new 002-oopsmails-angular-lib-a14 --skip-install


Note: following NOT working, with error "Error: Unknown command. Did you mean g?"

npx @angular/cli@14 ng 002-oopsmails-angular-lib-a14 --skip-install

npx @angular/cli/bin ng new 002-oopsmails-angular-lib-a14 --skip-install

```

## Install, uninstall and upgrade

Try the Following steps to uninstall angular cli completely

```
npm uninstall -g angular-cli // Use sudo before to give administrator permission, older version
npm uninstall -g @angular/cli // Use sudo before to give administrator permission
npm cache clean or npm cache clean --force
```

To reinstall the latest version try this

```
npm install -g @angular/cli@latest

$ npm install @angular/cli
npm ERR! Unexpected token '.'


```

## From Angular 11, ng serve - Option "sourceMap" is deprecated

That means, when debugging, there is NO source can debug ...

- Solution, ref, https://stackoverflow.com/questions/66919289/angular-11-ng-serve-option-sourcemap-is-deprecated

In angular.json, add this configuration to `projects.[NAME_OF_YOUR_PROJECT].architect.serve.configurations` :

```
"dev": {
  "browserTarget": "[NAME_OF_YOUR_PROJECT]:build:dev"
}

```

Like that :

```
"architect": {
  "serve": {
    ...
    "configurations": {
      "production": {
        ...
      },
      "dev": {
        "browserTarget": "[NAME_OF_YOUR_PROJECT]:build:dev"
      }
    }
  },
  ...

```

Then, add the corresponding "dev" configuration in `projects.[NAME_OF_YOUR_PROJECT].architect.build.configurations` :

```
"dev": {
  "optimization": false,
  "sourceMap": true
}
```

like this example :

```
...
"architect": {
  "build": {
    ...
    "configurations": {
      "production": {
        ...
      },
      "dev": {
        "optimization": false,
        "sourceMap": true
      }
    }
  },
...

```

Now you just have to edit the "start" script command in package.json :

```
...
"scripts": {
  "start": "ng serve --configuration=dev",
...

```

and you should retrieve sources map files in your favorite browser !

## Error:

### @angular/platform-browser-dynamic@"^14.0.4" from the root project

Sometimes, if the project was build by using yarn before, then there is yarn.lock, similarly, if npm, then there is package-lock.json.
So, we may need to delete those files and do _npm i_ again ...

### routerLink in SharedModule is not working, i.e, not a link

> Solutions

In SharedModule, forgot adding/import _RouterModule_.

### Fixing ERROR TypeError: Cannot read properties of undefined (reading 'onDestroy')

> Solutions

- You did not add a provider to your pipes
- If you specified a new angular pipe, you should add it to declarations, exports AND providers. I got this error when I forgot about the providers.

> Other possible solutions

- Try to remove the .angular directory
- You did a faulty import of a module. e.g, HelloComponent is using SharedModule and async pipe, but it wasn't declared in AppModule.
