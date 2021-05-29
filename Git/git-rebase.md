
# Git Pull with Rebase

- Using rebase to make git tree linear because most of merges are not really necessary.


## Conflict

- commit locally

git commit -m "[jira-222]: your comments"

- prepare to push

git pull --rebase

- if there are conflicts, open those files with conflicts and resolve them all, then

*git branch* to make sure

- then

git add .
git rebase --continue
git branch 
git push


Note: after *git add .*, **DONOT** do another *git commit -m "[jira-222]: your comments"*

- Or can config settings to ALWAYS rebase when pulling.

git config --global pull.rebase true


### pull with rebase

```

$ git status
On branch testb1
Your branch is up to date with 'origin/testb1'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   README.md

$ git pull --rebase <--------------- need to commit before rebase
error: cannot pull with rebase: You have unstaged changes.
error: please commit or stash them.

$ git status
On branch testb1
Your branch is up to date with 'origin/testb1'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")

$ git add .

$ git commit -m "local commit test02"
[testb1 6640bbe] local commit test02
 1 file changed, 1 insertion(+), 1 deletion(-)

$ git push
To https://github.com/oopsmails/angular-03.git
 ! [rejected]        testb1 -> testb1 (fetch first)
error: failed to push some refs to 'https://github.com/oopsmails/angular-03.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

liu@lenovo-small MINGW64 /c/temp/angular-03 (testb1)
$ git pull --rebase
remote: Enumerating objects: 8, done.
remote: Counting objects: 100% (8/8), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 6 (delta 2), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (6/6), 1.25 KiB | 67.00 KiB/s, done.
From https://github.com/oopsmails/angular-03
   11473a6..23403ad  testb1     -> origin/testb1
error: could not apply 6640bbe... local commit test02
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git rebase --abort".
Could not apply 6640bbe... local commit test02
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md

liu@lenovo-small MINGW64 /c/temp/angular-03 (testb1|REBASE 1/1)
$ git status
interactive rebase in progress; onto 23403ad
Last command done (1 command done):
   pick 6640bbe local commit test02
No commands remaining.
You are currently rebasing branch 'testb1' on '23403ad'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Unmerged paths:
  (use "git restore --staged <file>..." to unstage)
  (use "git add <file>..." to mark resolution)
        both modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")

liu@lenovo-small MINGW64 /c/temp/angular-03 (testb1|REBASE 1/1)
$ git branch
* (no branch, rebasing testb1)
  master
  testb1

-------------------------------------------------------------

liu@lenovo-small MINGW64 /c/temp/angular-03 (testb1|REBASE 1/1)
$ git add README.md

liu@lenovo-small MINGW64 /c/temp/angular-03 (testb1|REBASE 1/1)
$ git rebase --continue
[detached HEAD 49e2032] local commit test02
 1 file changed, 3 insertions(+)
Successfully rebased and updated refs/heads/testb1.

liu@lenovo-small MINGW64 /c/temp/angular-03 (testb1)
$ git status
On branch testb1
Your branch is ahead of 'origin/testb1' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean

liu@lenovo-small MINGW64 /c/temp/angular-03 (testb1)
$ git branch
  master
* testb1

liu@lenovo-small MINGW64 /c/temp/angular-03 (testb1)
$ git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 287 bytes | 287.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/oopsmails/angular-03.git
   23403ad..49e2032  testb1 -> testb1


```

