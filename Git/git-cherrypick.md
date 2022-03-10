


https://poanchen.github.io/blog/2017/11/12/How-to-create-a-GitHub-pull-request-with-a-specific-commits

![git-cherrypick-01.png](git-cherrypick-01.png)



The problem that I have here is that I only wanted to create a pull request with only the a51afa6 and 07f39f7. But, it seems like you cannot really do anything on the GitHub UI to remove it. You know why? Because you are not suppose to. You are suppose to create a branch with the latest changes and cherry-pick the ones that you want. And then compare that branch with the repository that you would like to contribute. The differences will only be the ones that you cherry-picked. Then, you are done. This is how you would create a GitHub pull request with a specific commits. Let me show you in action.


First, you need to create a branch with the latest changes (that is the same with the upstream remote branch)

  git fetch --all
  git checkout -b new-branch-name upstream/master

Create a new branch *cherrypick* in github, then run

  git remote add upstream https://github.com/oopsmails/react-sandbox.git
  git checkout -b cherrypick upstream/cherrypick


Note: The above assumes you’ve set up upstream as a remote. If not, do this first:

  git remote add upstream https://github.com/upstream_github_username/upstream_github_repo_name.git

  git remote add upstream https://github.com/oopsmails/react-sandbox.git



Next, you would need to cherry-pick the changes that you would like to include in the pull request.

  git cherry-pick a51afa6
  git cherry-pick 07f39f7

  git cherry-pick 259f2c85b3f89953b420e1b126993652596fba1a


Now, all you need to do is to push your changes to your GitHub repository

  git push -u origin new-branch-name

  git push -u origin cherrypick



Head over to your GitHub repository, and you should see this.

![git-cherrypick-03.png](git-cherrypick-03.png)

Recently pushed branch

Simply click Compare & pull request to create a pull request in the repository that you would like to contribute with only the changes you picked.



Tada. You have done it=)


