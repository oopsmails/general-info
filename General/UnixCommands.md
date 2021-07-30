
# Unix Commands

- Sed

use sed to replace all CR (\r) from line endings:

```
sed -i.bak 's/\r$//' file.txt
sed $'s/\r$//' ./file.name > ./file.name.01
```

With option -i, the file will be edited in-place, and the original file will be backed up as file.txt.bak.

- grep-work-in-files

grep -Fxq [String] [filePath]

grep -q [String] [filePath] // normally enough


