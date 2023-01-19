
### ALWAYS Open folder (including Open Recent) in NEW windows

Set "window.openFilesInNewWindow": "on" in settings.json.

Click on the gear icon on the bottom-left corner of the window, select Settings then enter window.openFilesInNewWindow in the search box that appears on the top of the Settings tab to find the setting quickly. Click on it and select "on" from the dropdown list.

It explains (below or above the setting, depending if you use the new Settings manager or edit the settings.json file):

### Sort order in Open Editors

Settings, search "explorer", 

Explorer > Open Editors: Sort Order

from the drop down, choose alphabetical

"explorer.openEditors.sortOrder": "alphabetical"

### open new windows with same size

Settings, search "New Window Dimensions", change to "inherit"

"window.newWindowDimensions": "inherit"

### Show full path on the title bar

Settings, search "title", Windows: Title, change to "activeEditorLong"

"window.title": "${dirty}${activeEditorLong}${separator}${rootName}${separator}${appName}"

### Crash report

Settings, search "telemetry"

### Terminal: Select Default Shell

Terminal, drop down, "Select Default Shell"

or, Settings, search "default shell", "Edited in settings.json"

```
{
    "workbench.startupEditor": "newUntitledFile",
    "window.openFoldersInNewWindow": "on",
    "extensions.ignoreRecommendations": true,
    "window.newWindowDimensions": "inherit",
    "terminal.integrated.defaultProfile.windows": "Git Bash", <-------------------- use this, 20230110
    "terminal.integrated.shell.windows": "C:\\Program Files\\Git\\bin\\bash.exe", <-------- here, deperated
    "explorer.openEditors.sortOrder": "alphabetical",
    "window.title": "${dirty}${activeEditorLong}${separator}${rootName}${separator}${appName}",
    "terminal.integrated.shell.osx": ""
}

```



