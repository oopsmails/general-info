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

## Error:

### @angular/platform-browser-dynamic@"^14.0.4" from the root project

Sometimes, if the project was build by using yarn before, then there is yarn.lock, similarly, if npm, then there is package-lock.json.
So, we may need to delete those files and do _npm i_ again ...

### routerLink in SharedModule is not working, i.e, not a link

> Solutions

In SharedModule, forgot adding/import *RouterModule*.

### Fixing ERROR TypeError: Cannot read properties of undefined (reading 'onDestroy')

> Solutions
- You did not add a provider to your pipes
- If you specified a new angular pipe, you should add it to declarations, exports AND providers. I got this error when I forgot about the providers.

> Other possible solutions
- Try to remove the .angular directory
- You did a faulty import of a module. e.g, HelloComponent is using SharedModule and async pipe, but it wasn't declared in AppModule.
