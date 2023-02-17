# Git Commands

## git branch

```
git branch -a
git branch -r // remote only

- delete remote, using github

git branch -d <branch-name> // local

git remote prune origin // if still showing in local

or:
git branch -d -r origin/coolbranch
(The -r is easy to forget...)

-r in this case will "List or delete (if used with -d) the remote-tracking branches." according to the Git documentation found here: https://git-scm.com/docs/git-branch

```
