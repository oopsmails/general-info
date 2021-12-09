## SSH Setup

`ssh-keygen -t rsa -C "oopsmails@gmail.com"`

will generate .ssh folder,

$ ls
id_rsa id_rsa.pub

$ cat id_rsa.pub
ssh-rsa AAasdfasdfasdfasdfsadf.... oopsmails@gmail.com

Then, copy the line (key) to Git repo user settings ....

git config --global user.email oopsmails@gmail.com

## Set git to use stored username and password

- For local commits

git config --global user.name myusername
git config --global user.email myemail@gmail.com

- Store credentials forever

WARNING: If you use credential.helper store from the answer, your password is going to be stored completely unencrypted ("as is") at ~/.git-credentials. Please consult the comments section below or the answers from the "Linked" section, especially if your employer has zero tolerance for security issues

Permanently authenticating with Git repositories
Run following command to enable credential caching:

```
$ git config credential.helper store
$ git push https://github.com/repo.git

Username for 'https://github.com': <USERNAME>
Password for 'https://USERNAME@github.com': <PASSWORD>
```

- User should also specify caching expire

git config --global credential.helper "cache --timeout 7200"

After enabling credential caching, it will be cached for 7200 seconds (2 hour).

- https://stackoverflow.com/questions/35942754/how-can-i-save-username-and-password-in-git

~/.git-credentials  

if password changed, then will fail, just delete *~/.git-credentials* and redo *git config credential.helper store*

## git ignore crlf

```
Global approach

Configure Git line endings handling on Linux or OS X:

git config --global core.autocrlf input

Configure Git line endings handling on Windows:

git config --global core.autocrlf true

```

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

- git reset -----------------------------------> to mark as merged !!!!!!!!!!!!!

Unstaged changes after reset:  
M       file1  
M       file2  
M       file3  

- cleaning stash

git stash drop stash@{0}

git stash clear

- unstage:

(use "git rest HEAD <-file-> ..." to unstage)


## git pull, conflict ...

Don't follow other answers
Well, you can follow them :). But I don't think that doing a commit and then resetting the branch to remove that commit and similar workarounds suggested in other answers are the clean way to solve this issue.

Clean solution
The following solution seems to be much cleaner to me and it's also suggested by the Git itself — try to execute git status in the repository with a conflict:

Unmerged paths:
  (use "git reset HEAD <file>..." to unstage)
  (use "git add <file>..." to mark resolution)
So let's do what Git suggests (without doing any useless commits):

Manually (or using some merge tool, see below) resolve the conflict(s).
Use git reset to mark conflict(s) as resolved and unstage the changes. You can execute it without any parameters and Git will remove everything from the index. You don't have to execute git add before.
Finally, remove the stash with git stash drop, because Git doesn't do that on conflict.
Translated to the command-line:

```
$ git stash pop

# ...resolve conflict(s)

$ git reset

$ git stash drop
```


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



### git: change comments of (last) commit


https://stackoverflow.com/questions/14381044/how-do-i-change-a-git-commit-message-in-bitbucket

git rebase -i HEAD~X (X=No of commit messages you want to change)
Above command will open git file in editor. There replace text 'pick' with 'reword' and save the file.
It will open editor for every commit one by one, there you again change the commit message.
At the end: git push -f



git rebase -i HEAD~ c4c08cebf9c


ALERTS-1594: CS to BOS error code mapping


git push origin HEAD:feature/ALERTS-1594-cs-to-bos-error-code-mapping --force


--
If it is the most recent commit, you can simply do this:

git commit --amend -m "ALERTS-1594: CS to BOS error code mapping" (amend message)
git push --progress origin --force (force push)



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











