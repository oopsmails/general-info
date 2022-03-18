
# VS Code Usage

## Extensions

### vscode-live-sass-compiler relative path

- Need to click *Watch Sass* on the Status Bar at the bottom, make it "Watching ...."


- **Parallax**

Notice how my *liveSassCompile.settings.formats* is formatted: I've written the save paths as */Parallax/css/* and */Parallax/dist/css*. This goes to the project root and saves the css files inside the folders called css and dist which are inside the Parallax directory. (image link)

In conclusion each time you want to change the save path all you have to do is modify the settings.json file inside the .vscode folder rather than modifying the user settings which is tedious in my opinion.

```
- Sample:

{
"liveSassCompile.settings.formats": [
    {
        "format": "expanded",
        "extensionName": ".css",
        "savePath": "/Parallax/css"
    },
    {
        "extensionName": ".min.css",
        "format": "compressed",
        "savePath": "/Parallax/dist/css"
    }
],

"liveSassCompile.settings.excludeList": [
    "**/node_modules/**",
    ".vscode/**"
],
"liveSassCompile.settings.generateMap": true,
"liveSassCompile.settings.autoprefix": [
    "> 1%",
    "last 2 versions"
]
}
```

- Using 20211225

```
"liveSassCompile.settings.includeItems": [
        // "~/dev/html-scss-learning/css/*.scss",
        "/Parallax/css/*.scss",
        "/Parallax/css/*/*.scss",
        "~/dev/*.scss",
    ]
```

### Live Server extension

- Need to click *Go Live* on the Status Bar at the bottom, make it *Port: 5500*

### Move TS

- Ref:

Mosh Hamedani, 6 Essential VSCode Extensions for Angular Developers

- right click (can be multiple files, e.g, html, scss, ts), *Move Typescript* option
- then input target path

### Typescript Hero

- ctrl + alt + o, will organize imports and format codes.


