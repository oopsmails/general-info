## SSH Setup

`ssh-keygen -t rsa -C "oopsmails@gmail.com"`

will generate .ssh folder,

$ ls
id_rsa id_rsa.pub

$ cat id_rsa.pub
ssh-rsa AAasdfasdfasdfasdfsadf.... oopsmails@gmail.com

Then, copy the line (key) to Git repo user settings ....

git config --global user.email oopsmails@gmail.com

## git exclude local file, but not through .gitignore

From the relevant Git documentation:

Patterns which are specific to a particular repository but which do not need to be shared with other related repositories (e.g., auxiliary files that live inside the repository but are specific to one user's workflow) should go into the $GIT_DIR/info/exclude file.

The **.git/info/exclude** file has the same format as any .gitignore file. Another option is to set core.excludesFile to the name of a file containing global patterns.

Note, if you already have unstaged changes you must run the following after editing your ignore-patterns:

git update-index --assume-unchanged [<file>...]
Note on $GIT_DIR: This is a notation used all over the git manual simply to indicate the path to the git repository. If the environment variable is set, then it will override the location of whichever repo you're in, which probably isn't what you want.

## file name too long 

`git clone -c core.longpaths=true <-your.url.here->`

`$ git config core.longpaths true`

## git undo commit 

!!!!!! undo git commit, this could cause code lost, backup first !!!!!!

`git reset HEAD^`

`git reset filename.txt`

`git reset --hard origin/test/branchname`

## git diff

```
git diff branch_1..branch_2

git diff --name-status master..branchName

git diff --name-only branchName..master

git diff --name-only branchName..develop | grep pom.xml
```

## Git merge

### start from dev's current dev-oopsmails branch

- dev-oopsmails branch
`git status`
... many local changes

- git stash

Saved working directory and index state WIP on

- checkout master branch and pull

git checkout master

git pull

- back to dev-oopsmails branch

git checkout dev-oopsmails

git merge develop

**?? should NOT have any confilct because local changes on dev-oopsmails branch has already been stashed, ??
Could merge conflict, then need to manually merge and commit and then push**

- git push

- Jenkins dev-oopsmails branch will rebuild because of merging ....

- git stash pop

manually merge files if necessary

### start from master branch

- git pull

error: Your local changes to the following files would be overwrittern by merge:

            ..................
Please commit your changes or stash them before you merge.
Aborting
Updating a1e17bc..7fcadd55

- git status

On branch master
Your branch is behind 'origin/master' by 77 commits, and can be fast-forwarded.
..........

- git pull

Updating a1e17bc..7fcadd55  
......  

- git stash list

stash@{0}: WIP on master .......  

- git stash show

...............  
3 files changed, 77 insertions(+)  

- git stash pop

Auto-merging .....
CONFLICT (content): Merge conflict in file1 ....
Auto-merging file2
Auto-merging file3

- git status

On branch master  
Your branch is up-to-date with 'origin/master'  
Changes to be commited:  
    (use "git rest HEAD <-file-> ..." to unstage)  

        modified: file2  
        modified: file3  

Unmerged paths:  
    (use "git rest HEAD <-file-> ..." to unstage)  
    (use "git add <-file-> ..." to mark resolution)  

        both modified: file1 -----------------------------------------> here  

Untracked files:  
    (use "git add <-file-> ..." to include in what will be committed)  

................  

**manually merge the file, also can use vs code to merge**  

- git reset

Unstaged changes after reset:  
M       file1  
M       file2  
M       file3  

- cleaning stash

git stash drop stash@{0}

git stash clear

- unstage:

(use "git rest HEAD <-file-> ..." to unstage)

## Cherry picking

**bugfix** branch is from production repo branch and then fixed a bug

**new-dev** branch is from current master repo and will be merge into master after "merged in" bugfix

- swich to new **new-dev** branch

`git checkout new-dev`

checking out files: 100% (999/999), done.
Switched to a new branch '**new-dev**'

- git cherry-pick, need to provide LONG commit string

`$ git cherry-pick dh56sdf8asdfadsfnidifdfadsfasddfasdfasdf`

error: could not apply dh56sdf8asdfadsfnidifdfadsfasddfasdfasdf new-dev  
hint: after resolving the conflicts, mark the corrected paths  
hint: with 'git add <-path->' or 'git rm <-path->'  
hint: and commit the result with 'git commit'  

showing branch as (new-dev|CHERRY-PICKING) !!!

- git status

to see diff

- resolve the conflicts, vi or intellij

`$ vi com.oopsmails.service/src/main/java/com/oopsmails/aaa/Abc.java`  

- git diff

to vidw the diff after merge

- git add "modified" one by one

e.g

```
git add com.oopsmails.service/src/main/java/com/oopsmails/aaa/Abc1.java  

git add com.oopsmails.service/src/main/java/com/oopsmails/aaa/Abc2.java
```

- git status

should be all green now!

- git cherry-pick --continue

- git push







## git commands

- git branch
- git branch -a : list all branches
- git branch -r : remote branches only
- git stash list
- git stash show -p
- git stash show -p stash@{0}
- git stash show -p stash@{0} --name-only
- git checkout -patch stash@{0} path/to/file
- git checkout stash@{0} -- filename











