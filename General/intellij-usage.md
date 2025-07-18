# intellij

## important settings

Settings
:: Editor
:: General
:: Auto Import
Add unambiguous imports on the fly
:: Code Folding
One-line methods
:: Code Style
Hard wrap at: 160
:: Java
:: Imports tab
Class count to use import with '_': 999999
Names count to use static import with '_': 999999

--

- Editable test console
  Help :::> Edit custom VM options

```
-Deditable.java.test.console=true
```

## Tricks

### When running applications, error: Command line is too long

- Need change Run configuration

_In Intellij, go to "edit configurations" (at the top of the main window), in the configuration tab that comes up in the line "shorten command line" select option "classpath file"/"@argFiles (Java 9+)", last option in the drop down menu. Fixed it for me._

Ref: https://stackoverflow.com/questions/6381213/idea-10-5-command-line-is-too-long

- New version

_In Intellij, go to "edit configurations", select the configuration, the "Modify options", check "Shorten command line"_

- For me, the very last option works, "classpath file -java ......."

### intellij server's certificate is not trusted

To get rid of the pop up message go to below location and click on Accept non-trusted certificates automatically.

File | Settings | Tools | Server Certificates for Windows and Linux
IntelliJ IDEA | Preferences | Tools | Server Certificates for macOS

### intellij keep more files open

Settings | Editor | General | Editor Tabs | Tab limit ...

Sort order, Open most recent when closing current tab ...

### Find usage without Test

Find Usage, Settings (Ctrl+Alt+Shift+F7), Scope, ..., + scope, WithoutTest, Pattern, "!test:_._&&!test:\*"

### How to rename a project in "Recent Projects" list in the startup popup

File > Project Structure > Project > Project Name

### Always show full path in window header

File > Settings > Appearance & Behavior > Appearance > check box, Always show full path in window header

### Import all

Please try to set "Add unambiguous imports on the fly" (jetbrains.com/help/idea/…), then right click on project root and select "Optimize imports

- from jetbrains doc
https://www.jetbrains.com/help/idea/creating-and-optimizing-imports.html#automatically-add-import-statements

```
Automatically add import statements
You can configure the IDE to automatically add import statements if there are no options to choose from.

Press CtrlAlt
0S
 to open settings and then select Editor | General | Auto Import.

Select the Add unambiguous imports on the fly checkbox, and apply the changes.

When you are pasting blocks of code that contain references to classes or static methods and fields that are not yet imported, the IDE automatically inserts the missing import statements. If you want to change that, from the Insert imports on paste list, select Ask to confirm every insertion or Never to insert import statements manually.
```

## intellij shortcuts

- Previous, Next cursor location

File :::> Settings :::> Keymap
Search "Navigate", set key shortcuts to previous cursor location.

Normally, Ctrl + Alt + Left/Right

- Previous, Next change

Search "previous change"

- Last modified file

Ctrl + Shift + Backspace

- Set copy "Path from repository"

File :::> Settings :::> Keymap, search copy, select "Path from repository", Edit, Ctrl + Shift + G


## intellij shortcuts on Mac

Double ⇧
Search Everywhere
Find anything related to IntelliJ IDEA or your project and open it, execute it, or jump to it.
⇧⌘A
Find Action
Find a command and execute it, open a tool window or search for a setting.
⌥⏎
Show intention actions and quick-fixes
Fix highlighted error or warning, improve or optimize a code construct.
F2
⇧F2
Navigate between code issues
Jump to the next or previous highlighted error.
⌘E
View recent files
Select a recently opened file from the list.
⇧⌘⏎
Complete current statement
Insert any necessary trailing symbols and put the caret where you can start typing the next statement.
⌥⌘L
Reformat code
Reformat the whole file or the selected fragment according to the current code style settings.
⌃T
Invoke refactoring
Refactor the element under the caret, for example, safe delete, copy, move, rename, and so on.
⌥↑
⌥↓
Extend or shrink selection
Increase or decrease the scope of selection according to specific code constructs.
⌘/
⌥⌘/
Add/remove line or block comment
Comment out a line or block of code.
⌘B
Go to declaration
Navigate to the initial declaration of the instantiated class, called method, or field.
⌥F7
Find usages
Show all places where a code element is used across your project.
⌘1
Focus the Project tool window
⎋
Focus the editor

## intellij maven dependency analyzer

Maven on side bar, tool bar, Analyze Dependencies ... 

