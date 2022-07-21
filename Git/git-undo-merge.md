
# Git Undo Merge – How to Revert the Last Merge Commit in Git

- Ref:

https://www.freecodecamp.org/news/git-undo-merge-how-to-revert-the-last-merge-commit-in-git/


## How to Undo a Merge Commit in Git
You can use the Git reset command to undo a merge.

Firstly, you need to check for the commit hash (or id) so you can use it to go back to the previous commit.

To check for the hash, run *git log* or *git reflog*. *git reflog* is a better option because things are more readable with it.

You can use the Git reset command to undo a merge.

Firstly, you need to check for the commit hash (or id) so you can use it to go back to the previous commit.

To check for the hash, run *git log* or *git reflog*. *git reflog* is a better option because things are more readable with it.

When you get the hash of the commit you want to get back to, run *git reset --hard commit-before-the-merge*


You should see some things get removed from your code editor when you run the command.

If you are not sure of the hash of the last commit, you can run *git reset --hard HEAD~1* to go back to the commit before the merge:

Note that when you use the --hard flag to undo a merge, any uncommitted change will be reverted.

## A Better Way to Undo a Merge in Git
Since the methods discussed above will revert uncommitted changes, Git provides a safer flag which is *--merge*.

To undo a merge with the --merge flag, run git reflog to see the hashes of commits, then run **git reset --merge previous-merge-commit-number**


You can also use the HEAD keyword with the --merge flag by running **git reset --merge HEAD~1**


N.B.: If you don’t get a response from this command when you use the --merge flag, don’t worry, it works.

## Conclusion
In this article, you learned how to undo a merge in Git, so you can undo a mistaken or unwanted merge and work more efficiently with Git.

Here is the take-away with the --hard and --merge flags while using them to undo a merge: the --hard flag removes uncommitted changes, while the --merge flag keeps uncommitted changes.

