# AngularJS + Angular (v6) hybrid (finally!)

https://medium.com/p/97ac37087de1/responses/show

It's finally time to make this happen! I've been running and maintaining a website for about 2.5 years now. This website is built with AngularJS (v1.6.9). This works reasonably well, but nothing compared to the newer versions of Angular. So I finally took the first steps to migrating everything to a newer version, incrementally. Here's how I did it:

- Create a new Angular CLI project
- Copy & convert all JavaScript files to TypeScript
- Replacing the absolute template URL's in with relative URL's
- Tweaking the Angular CLI settings to accommodate for AngularJS
- Including AngularJS in your Angular app

## Create a new Angular CLI project

Because nobody wants to reinvent the wheel, follow this “official” guide to create a new project: https://angular.io/guide/quickstart

## Copy & convert all JavaScript files to TypeScript

This may seem like it's fairly easy, which it was…in the beginning, but there is more than just changing a file extension. To rename all files from “.js” to “.ts”, you can do whatever you'd like. You can do this manually, with an NPM extension, or through your Terminal. I chose to use an NPM extension: Renamer. If you want to use the same, follow the next commands:

`npm i -g renamer`

and to actually rename the files:

`renamer --find '.js' --replace '.ts' 'root/folder/of/app/**/*.js'`

This will have renamed all your JavaScript files to TypeScript files. Next up, if you don't already work with ES6/ES2015, you'll want to convert your Javascript to this format. TypeScript doesn't work with non-arrow functions. Also, you'll want to start using JavaScript's “import” and “export” directives instead of “require”. This will help Webpack (built-in with Angular CLI) build your application later on.

Once you've renamed and rewritten your code, you can copy this into the Angular CLI project you created earlier. Follow the following guide, from “Create an import chain” until you reach “Configure Angular CLI”: Making the hybrid. At this point, you should have all your files in the TypeScript format and integrated into your “new” Angular CLI project.

## Replacing the absolute template URL's in with relative URL's

At this point, you could already start to compile your app, but you'll run into errors if you've been using absolute template URL's like I was. Angular CLI uses Webpack to compile it's TypeScript files into Javascript and then into a bundle. Webpack requires you to use relative paths. So now replace all your absolute template paths with relative ones. These could be located in directives (or components), your router, or any controllers.

## Tweaking the Angular CLI settings to accommodate for AngularJS

At this point, you will be able to fully compile your hybrid app, but only for development purposes. Once you try to compile your app with production flags:
ng build --prod
You will not be able to load the app in your browser. This is because Webpack will try to resolve any and all functions to compile them into basic Javascript. This works for Angular (v6), but not for AngularJS. To fix this, edit the following settings in your “angular.json” file:

```
/*This is the old situation*/
"configurations": {
  "production": {
    "fileReplacements": [
      {
        "replace": "src/environments/environment.ts",
        "with": "src/environments/environment.prod.ts"
      }
    ],
    "optimization": true,
    "outputHashing": "all",
    "sourceMap": false,
    "extractCss": true,
    "namedChunks": false,
    "aot": true,
    "extractLicenses": true,
    "vendorChunk": false,
    "buildOptimizer": true,
    "serviceWorker": true
  }
}

/*And this is the new situation*/
"configurations": {
  "production": {
    "fileReplacements": [
      {
        "replace": "src/environments/environment.ts",
        "with": "src/environments/environment.prod.ts"
      }
    ],
    "optimization": true,
    "outputHashing": "all",
    "sourceMap": false,
    "extractCss": true,
    "namedChunks": false,
    "aot": false, //Updated, remove this comment if you copy/paste
    "extractLicenses": true,
    "vendorChunk": false,
    "buildOptimizer": false, //Updated, remove if copy/paste
    "serviceWorker": true
  }
}
```

## Including AngularJS in your Angular app

You're almost done! The last step is to include your AngularJS app in your new, shiny Angular app. You can do this by following “Bootstrap the hybrid” for the guide I've pointed you to earlier: Make the hybrid. If you want to be able to use new Angular components in your AngularJS app, follow the following steps: Angular upgrade. This guide will also show you how you can use AngularJS components in Angular, but I would recommend trying to upgrade as many of these components to Angular (v6) as you go. They'll have to be upgraded at some point anyway, so this is the perfect opportunity for it!
Now you can finally build your app for production purposes! Once you've completely converted everything to Angular (v6), you will be able to use AOT and Build optimizer again, making your app even more efficient. It could be I made a mistake in my own process and that's why AOT is currently not working, but this will need to wait on a revision.

Notes
This guide will not work for everyone, I've personally used 3 or 4 different guides and even more Google searches to get to the right place. This upgrade is not the easiest thing you'll ever do, but it will be very worth it. It will improve the stability and reliability of your app a lot. It will also solve any SEO problems you may have had with AngularJS because Angular is actually able to render on a (node) server!

If you have any questions, or better, suggestions on how I can make this process easier for you and me, please leave a comment. I'd love to help you out or learn from your experiences undertaking this hellish upgrade! If you'd like to read more about my struggles with Angular and SEO, have a look at: How to index a single page application built in AngularJS.
