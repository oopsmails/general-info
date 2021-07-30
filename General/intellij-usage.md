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
                Class count to use import with '*': 999999
                Names count to use static import with '*': 999999


--

## Tricks

### When running applications, error: Command line is too long

- Need change Run configuration

*In Intellij, go to "edit configurations" (at the top of the main window), in the configuration tab that comes up in the line "shorten command line" select option "classpath file"/"@argFiles (Java 9+)", last option in the drop down menu. Fixed it for me.*

Ref: https://stackoverflow.com/questions/6381213/idea-10-5-command-line-is-too-long

- For me, the very last option works, "classpath file -java ......."


### intellij server's certificate is not trusted


To get rid of the pop up message go to below location and click on Accept non-trusted certificates automatically.

File | Settings | Tools | Server Certificates for Windows and Linux
IntelliJ IDEA | Preferences | Tools | Server Certificates for macOS           


### intellij keep more files open

Settings | Editor | General | Editor Tabs | Tab limit ...

### Find usage without Test

Find Usage, Settings (Ctrl+Alt+Shift+F7), Scope, ..., + scope, WithoutTest, Pattern, "!test:*.*&&!test:*"


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






