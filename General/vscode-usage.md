
# VS Code Usage

## Extensions

## vscode-live-sass-compiler relative path

- **Parallax**

Notice how my *liveSassCompile.settings.formats* is formatted: I've written the save paths as */Parallax/css/* and */Parallax/dist/css*. This goes to the project root and saves the css files inside the folders called css and dist which are inside the Parallax directory. (image link)

In conclusion each time you want to change the save path all you have to do is modify the settings.json file inside the .vscode folder rather than modifying the user settings which is tedious in my opinion.

```
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