# tdt4240-project
*Puck-U* - A local Air Hockey game with power-ups using SpriteKit.

# Setup
`cd` into your desired directory and clone the repository:

```
git clone git@github.com:larseen/tdt4240-project.git
```

# Workflow
After a picking an issue and assigning yourself, a typical GitHub workflow is as follows:

### Pull the latest changes from GitHub
Go to the master branch on your computer by running `git checkout master`. You can pull from the remote `master` branch like this:
```
git pull origin master
```
### Create a new branch from the master branch
While currently in the `master` branch, you can create a new branch out of it and change to the new branch like this:
```
git branch name-of-your-branch
git checkout name-of-your-branch
```
A shorthand version of the commands above:
```
git checkout -b name-of-your-branch
```

### Do your changes, add files, commit files
Do your changes. To get an overview of staged and unstaged files, run `git status`. 
`git diff` shows all changes line by line. 

#### Add files
Add the files you wish to stage for your commit
```
git add path-to-file
```
#### Commit files
When all files are staged/added, you can commit your changes by running `git commit`.
If the commit message is short, you can run `git commit -m "Your short message"`.

[A guide on writing good commit messages](http://chris.beams.io/posts/git-commit/)

### Push your branch to GitHub
```
git push origin name-of-your-branch
```

### Open a pull request to the master branch
On GitHub, go to *Pull Requests > New Pull Request*. Choose `master` as base, and compare it to your branch. Create the pull request.

### Review and comment on the pull request, make changes as necessary.
The group will look through your changes and comment if necessary. 
If changes are required, make them. Then, you can edit the latest commit on your branch by:
```
git commit --amend
```
Or, to reuse the commit message:
```
git commit --amend --reuse-message=HEAD
```

Force-push the changes to your existing branch on GitHub. **Never force-push to the master branch.**
```
git push -f origin name-of-your-branch
```

[More on rewriting Git history](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase)

### Merge the pull request to the master branch
When everything looks right and the code has been reviewed, it will be merged into the `master` branch by someone.
