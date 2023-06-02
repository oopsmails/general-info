# VS Code Usage

## Shortcuts

- Shift + Alt + down arrow: duplicate current line
- Ctrl + d: multi-select same word
- Alt + click: multi locations to modify
- Ctrl + +: change font size bigger, -, smaller
- Ctrl + Alt + up (or down), Add cursor above or below
- Undo last cursor operation Ctrl+U
- Insert cursor at end of each line selected Shift+Alt+I
- Select all occurrences of current selection Ctrl+Shift+L
- Select all occurrences of current word Ctrl+F2

- wheel click + drag, to select
- ctrl + g, go to line

- Settings, search zoom, put -0.3 for smaller, try around -0.5 or -0.2....

## Extensions

### vscode-live-sass-compiler relative path

- Need to click _Watch Sass_ on the Status Bar at the bottom, make it "Watching ...."

- **Parallax**

Notice how my _liveSassCompile.settings.formats_ is formatted: I've written the save paths as _/Parallax/css/_ and _/Parallax/dist/css_. This goes to the project root and saves the css files inside the folders called css and dist which are inside the Parallax directory. (image link)

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

- Need to click _Go Live_ on the Status Bar at the bottom, make it _Port: 5500_

### Move TS

- Ref:

Mosh Hamedani, 6 Essential VSCode Extensions for Angular Developers

- right click (can be multiple files, e.g, html, scss, ts), _Move Typescript_ option
- then input target path

### Typescript Hero

- ctrl + alt + o, will organize imports and format codes.

### Prettier

- install

vs code, install extension

On VScode go to Settings > Text Editor > Formatting

Then check the Format On Save checkbox.

another, Select Configure Default Formatter...
Select Prettier - Code formatter

- How to configure code formatters Beautify, Prettier, per project in VS Code

Just use workspace settings, in VS Code you have User settings that are used for every project, and Workspace settings (saved in .vscode/settings.json in the project folder) that are specific to that project.

If you want to share workspace settings with others you can commit .vscode/settings.json.

You can edit both settings directly on the .json files, or through the VS Code settings editor (Files->Preferences->Settings).

> How to ignore?

- see https://prettier.io/docs/en/ignore.html
- Single line:

```
// prettier-ignore

/* prettier-ignore */


<!-- prettier-ignore -->
<div         class="x"       >hello world</div            >

<!-- prettier-ignore-attribute -->
<div
  (mousedown)="       onStart    (    )         "
  (mouseup)="         onEnd      (    )         "
></div>

<!-- prettier-ignore-attribute (mouseup) -->
<div
  (mousedown)="onStart()"
  (mouseup)="         onEnd      (    )         "
></div>

```

- Files: .prettierignore
-
