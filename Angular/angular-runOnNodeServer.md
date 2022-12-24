# Angular App Run on Node Server

## Package.json

```
"scripts": {
    "ng": "ng",
    "start": "node server.js", <----------------- adding this
    "build": "ng build",
    "test": "ng test",
    "lint": "ng lint",
    "e2e": "ng e2e",
    "postinstall": "ng build --prod"
  },


  "dependencies": {
    "@angular/animations": "~8.1.1",
    "@angular/common": "~8.1.1",
    "@angular/compiler": "~8.1.1",
    "@angular/cli": "~8.1.1",
    "@angular/compiler-cli": "~8.1.1",
    "@angular/core": "~8.1.1",
    "@angular/forms": "~8.1.1",
    "@angular/platform-browser": "~8.1.1",
    "@angular/platform-browser-dynamic": "~8.1.1",
    "@angular/router": "~8.1.1",
    "express": "^4.17.1", <------------------ adding this
    "ngx-pagination": "^5.0.0",
    "rxjs": "~6.4.0",
    "tslib": "^1.9.0",
    "zone.js": "~0.9.1",
    "typescript": "~3.4.3"
  },

```

## server.js

```
const express = require("express");
const app = express();
const path = require("path");

app.use(express.static(__dirname + "/dist"));
app.listen(process.env.PORT || 8080);

app.get("/*", (req, res)=>{
    res.sendFile(path.join(__dirname + "/dist/index.html"));
});
console.log("Server running");

//change the to "outputPath": "dist/", so it can read the files

```
