
# Unix Commands

## Sed

use sed to replace all CR (\r) from line endings:

```
sed -i.bak 's/\r$//' file.txt
sed $'s/\r$//' ./file.name > ./file.name.01
```

With option -i, the file will be edited in-place, and the original file will be backed up as file.txt.bak.

## grep-work-in-files

grep -Fxq [String] [filePath]

grep -q [String] [filePath] // normally enough

### Bonus: Use grep to search in file content with terminal

grep -rnw '/home/albert/Documents/dev/gitlab' -e 'angular'

Here is the flags used for this example:

```
-r / -R - recursive search
-n - show line number
-w - match the whole word
-e - pattern. Several regex patterns can be provided

-i - case insensitive search. It will slow down the process a lot
-l (lower-case L) show only the file name of matching files
--exclude-dir={dir1,dir2} - exclude directories from the search
--include=\*.{py,ipynb} - search only files ending with py and ipynb
--exclude=\*.xls - search all files except those which end with xls
```

## Using && and ||

```
</dev/tcp/192.11.11.11/8081 && echo Port open. || echo Port Closed.
```

## Rename files with pattern

```
for f in *.jpg; do mv "$f" "$(echo "$f" | sed s/IMG/VACATION/)"; done
for f in *.mp4; do mv "$f" "$(echo "$f" | sed s/IMG/VACATION/)"; done

for f in *.mp4; do mv "$f" "$(echo "$f" | sed s/_1080p//)"; done
for f in *.mp4; do mv "$f" "$(echo "$f" | sed s/'- '/-/)"; done


rename 's/^/MyVacation2011_/g' *.jpg
or

rename <pattern> <replacement> <file-list>
```





## 
