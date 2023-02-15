# git rollback last commit

- Refs:

https://stackoverflow.com/questions/4114095/how-do-i-revert-a-git-repository-to-a-previous-commit

https://stackoverflow.com/questions/22682870/how-can-i-undo-pushed-commits-using-git

## git log

list all commits

```
git log
git log --pretty=oneline
```

## Temporarily switch to a different commit

If you want to temporarily go back to it, fool around, then come back to where you are, all you have to do is check out the desired commit:

```
# This will detach your HEAD, that is, leave you with no branch checked out:
git checkout 0d1d7fc32
Or if you want to make commits while you're there, go ahead and make a new branch while you're at it:

git checkout -b old-state 0d1d7fc32

```

To go back to where you were, just check out the branch you were on again. (If you've made changes, as always when switching branches, you'll have to deal with them as appropriate. You could reset to throw them away; you could stash, checkout, stash pop to take them with you; you could commit them to a branch there if you want a branch there.)

## Hard delete unpublished commits

If, on the other hand, you want to really get rid of everything you've done since then, there are two possibilities. One, if you haven't published any of these commits, simply reset:

```
# This will destroy any local modifications.
# Don't do it if you have uncommitted work you want to keep.
git reset --hard 0d1d7fc32

# Alternatively, if there's work to keep:
git stash
git reset --hard 0d1d7fc32
git stash pop
# This saves the modifications, then reapplies that patch after resetting.
# You could get merge conflicts, if you've modified things which were
# changed since the commit you reset to.

```

If you mess up, you've already thrown away your local changes, but you can at least get back to where you were before by resetting again.

## Undo published commits with new commits

On the other hand, if you've published the work, you probably don't want to reset the branch, since that's effectively rewriting history. In that case, you could indeed revert the commits. With Git, revert has a very specific meaning: create a commit with the reverse patch to cancel it out. This way you don't rewrite any history.

```
# This will create three separate revert commits: You can revert individual commits with:

git revert <commit_hash>
git revert a867b4af 25eee4ca 0766c053

# It also takes ranges. This will revert the last two commits:
git revert HEAD~2..HEAD

#Similarly, you can revert a range of commits using commit hashes (non inclusive of first hash):
git revert 0d1d7fc..a867b4a

# Reverting a merge commit
git revert -m 1 <merge_commit_sha> <-------------------------- This is very useful

# To get just one, you could use `rebase -i` to squash them afterwards
# Or, you could do it manually (be sure to do this at top level of the repo)
# get your index and work tree into the desired state, without changing HEAD:
git checkout 0d1d7fc32 .

# Then commit. Be sure and write a good message describing what you just did
git commit

```

## Important

You know how to revert a merge commit, but it's **very important** you realize that in doing so

"...declares that you will never want the tree changes brought in by the merge. As a result, later merges will only bring in tree changes introduced by commits that are not ancestors of the previously reverted merge. This may or may not be what you want." (git-merge man page).

An article/mailing list message linked from the man page details the mechanisms and considerations that are involved. Just make sure you understand that **if you revert the merge commit, you can't just merge the branch again later and expect the same changes to come back.**

## Summary

The git-revert manpage actually covers a lot of this in its description. Another useful link is this git-scm.com section discussing git-revert.

If you decide you didn't want to revert after all, you can revert the revert (as described here) or reset back to before the revert (see the previous section).

You may also find this answer helpful in this case:
How can I move HEAD back to a previous location? (Detached head) & Undo commits

### comments

> @Rod's comment on _git revert HEAD~3_ as the best wat to revert back 3 commits is am important convention. –

> You can use git revert --no-commit hash1 hash2 ... and after this just commit every single revert in one commit git commit -m "Message" –

> `git revert -m <number> <full SHA1>` worked fine for me! I prefer this over `git revert <commit SHA1>` –

### Other

#### other 01

Revert back without keeping the changes:

```
git reset --hard <commit>
```

Revert back with keeping the changes: good for git undo commit

```
git reset --soft <commit>

```

#### other 02

The best way is:

```
git reset --hard <commidId> && git push --force

```

This will reset the branch to the specific commit and then will upload the remote server with the same commits as you have in local.

Be careful with the _--force_ flag as it removes all the subsequent commits after the selected commit without the option to recover them.

#### other 03

For rollback (or to revert):

1. git revert --no-commit "commit-code-to-remove" HEAD
   (e.g. git revert --no-commit d57a39d HEAD)
2. git commit
3. git push
   Try the above two steps, and if you find this is what you want then git push.

If you find something wrong, do:

git revert --abort

## After all the changes, when you push all these commands, you might have to use:

git push -f ...
And not only git push

## Undo commit on local

```
git log
git reset --soft <commit-id>
git status // got "Your branch and ... have diverged"
git pull // may need merge ...
git status
git push
```

- reset --soft, git pull, git puth

If you use `git reset --soft` to "uncommit" a specific commit, and then do a git pull that results in a "diverged branches" error, this means that there are conflicting changes between your local branch and the remote branch. You can resolve the conflict by merging the changes from the remote branch into your local branch, resolving any conflicts that arise, and then committing and pushing the changes.

Here are the steps to resolve the conflict:

Open a terminal or command prompt and navigate to your local repository.

Run the following command to merge the changes from the remote branch into your local branch:

`git merge origin/<remote-branch-name>`

This will merge the changes from the remote branch into your local branch. If there are any conflicts, you will need to resolve them manually.

Resolve any conflicts that arise. Use git status to see which files have conflicts, and then edit the files to resolve the conflicts.

After resolving the conflicts, use git add to stage the changes, and then use git commit to create a new commit with the merged changes.

```
git add .
git commit -m "Merge changes from remote branch"
```

Finally, use `git push` to push the changes to the remote branch:

`git push`
This should resolve the conflict and allow you to push the changes to the remote branch. Note that if you do not want to preserve the changes from the undone commit, you can use git reset --hard instead of git reset --soft to remove the changes from the working directory before doing the git pull.
