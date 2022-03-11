
# Continuous Deploying from Github to Firebase

- Ref:

https://www.sipios.com/blog-tech/build-a-real-time-todo-app-in-30-minutes-with-reactjs-typescript-and-firebase



## Deploy your application

If you had not done it yet, please install the Firebase CLI with *npm install -g firebase-tools*. You can now run *firebase login* and authenticate to your Firebase account. 

To continue, you may now run *firebase init*. You will be able to manage different features: choose *Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys*.


Once you have selected hosting, you will be asked to chose your project to host: we will use an existing project.

Select your app in the list.


You will now be prompted about Hosting setup. Choose build as the public directory, then agree y to configure single-page app. You can choose to setup automatic builds and deploys with Github but this is not mandatory. If you want to see how to implement it, see you on “To go further” part. 


You can now create your production build with *npm run build*. Deploy your app with *firebase deploy* ! 🤩


You now can access your app from your hosting URL, and get more information on your app use on the project console, like check the analytics or chose a custom domain.

To go further : Continuous Deployment (CD)
If you are using a Github repository, you can chose to configure automatic deployment every time new commits are merged on your main branch: this is what we call Continuous Deployment.

To do so, you need to run firebase init and select Hosting: Set up GitHub Actions deploys.

As you already logged in to your Firebase account (if not, run firebase login), you won't have to do anything for project setup. 

For the GitHub setup, agree to run a build before every deploy. The script to run before every deploy will be npm ci & npm run build. Now you can agree to start a deployment each time a PR is merged. Your GitHub branch associated with your app is usually main.


Once your setup is done, two Yaml files have been created: firebase-hosting-merge.yml and firebase-hosting-pull-request.yml. Commit and push them on your main branch. From your GitHub repository, you can see that a new Actions workflow has been launched!


CD is ready-to-go!





firebase login

firebase init


oopsmails/firebase-todolist

## Deploy Example Log


### Config Firebase and Setup

```
albert@albert-mint20:~/Documents/dev/react/firebase-todolist/react-todo-list$ firebase init

     ######## #### ########  ######## ########     ###     ######  ########
     ##        ##  ##     ## ##       ##     ##  ##   ##  ##       ##
     ######    ##  ########  ######   ########  #########  ######  ######
     ##        ##  ##    ##  ##       ##     ## ##     ##       ## ##
     ##       #### ##     ## ######## ########  ##     ##  ######  ########

You're about to initialize a Firebase project in this directory:

  /home/albert/Documents/dev/react/firebase-todolist/react-todo-list

? Which Firebase features do you want to set up for this directory? Press Space to select features, then Enter to confirm your choices. Hosting: Configure f
iles for Firebase Hosting and (optionally) set up GitHub Action deploys

=== Project Setup

First, let's associate this project directory with a Firebase project.
You can create multiple project aliases by running firebase use --add, 
but for now we'll just set up a default project.

? Please select an option: Use an existing project
? Select a default Firebase project for this directory: react-todo-list-9a62b (react-todo-list)
i  Using project react-todo-list-9a62b (react-todo-list)

=== Hosting Setup

Your public directory is the folder (relative to your project directory) that
will contain Hosting assets to be uploaded with firebase deploy. If you
have a build process for your assets, use your build's output directory.

? What do you want to use as your public directory? y <----------------------------- !!! should not y, enter to use default, public. BUT, in this case, we use *build* folder, because *npm run build* is updating build folder.
? Configure as a single-page app (rewrite all urls to /index.html)? Yes
? Set up automatic builds and deploys with GitHub? Yes
✔  Wrote y/index.html

i  Detected a .git folder at /home/albert/Documents/dev/react/firebase-todolist
i  Authorizing with GitHub to upload your service account to a GitHub repository's secrets store.

Visit this URL on this device to log in:
https://github.com/login/oauth/authorize?client_id=89cf50f02ac6aaed3484&state=237070972&redirect_uri=http%3A%2F%2Flocalhost%3A9005&scope=read%3Auser%20repo%20public_repo

Waiting for authentication...

✔  Success! Logged into GitHub as oopsmails

? For which GitHub repository would you like to set up a GitHub workflow? (format: user/repository) oopsmails/firebase-todolist

✔  Created service account github-action-468459144 with Firebase Hosting admin permissions.
✔  Uploaded service account JSON to GitHub as secret FIREBASE_SERVICE_ACCOUNT_REACT_TODO_LIST_9A62B.
i  You can manage your secrets at https://github.com/oopsmails/firebase-todolist/settings/secrets.

? Set up the workflow to run a build script before every deploy? Yes
? What script should be run before every deploy? npm ci && npm run build

✔  Created workflow file /home/albert/Documents/dev/react/firebase-todolist/.github/workflows/firebase-hosting-pull-request.yml
? Set up automatic deployment to your site's live channel when a PR is merged? Yes
? What is the name of the GitHub branch associated with your site's live channel? main

✔  Created workflow file /home/albert/Documents/dev/react/firebase-todolist/.github/workflows/firebase-hosting-merge.yml

i  Action required: Visit this URL to revoke authorization for the Firebase CLI GitHub OAuth App:
https://github.com/settings/connections/applications/89cf50f02ac6aaed3484
i  Action required: Push any new workflow file(s) to your repo

i  Writing configuration info to firebase.json...
i  Writing project information to .firebaserc...

✔  Firebase initialization complete!
albert@albert-mint20:~/Documents/dev/react/firebase-todolist/react-todo-list$ 
```

### New Deploy

- Should deploy from *build* folder, because *npm run build* is updating *build* folder
- If using other folder, this can be configured in *firebase.json*

```
albert@albert-mint20:~/Documents/dev/react/firebase-todolist/react-todo-list$ firebase deploy

=== Deploying to 'react-todo-list-9a62b'...

i  deploying hosting
i  hosting[react-todo-list-9a62b]: beginning deploy...
i  hosting[react-todo-list-9a62b]: found 14 files in build <-------------------------- from build folder
✔  hosting[react-todo-list-9a62b]: file upload complete
i  hosting[react-todo-list-9a62b]: finalizing version...
✔  hosting[react-todo-list-9a62b]: version finalized
i  hosting[react-todo-list-9a62b]: releasing new version...
✔  hosting[react-todo-list-9a62b]: release complete

✔  Deploy complete!

Project Console: https://console.firebase.google.com/project/react-todo-list-9a62b/overview
Hosting URL: https://react-todo-list-9a62b.web.app
```

## Github CD Error

### Error with *npm ci*, *The `npm ci` command can only install with an existing package-lock*

```
0s
Run npm ci && npm run build
npm ERR! The `npm ci` command can only install with an existing package-lock.json or
npm ERR! npm-shrinkwrap.json with lockfileVersion >= 1. Run an install with npm@5 or
npm ERR! later to generate a package-lock.json file, then try again.

npm ERR! A complete log of this run can be found in:
npm ERR!     /home/runner/.npm/_logs/2022-03-11T18_15_53_388Z-debug-0.log
Error: Process completed with exit code 1.
```

GithubCD-Error.png

- The reason is NOT in *react-todo-list* folder, fixed in *firebase-todolist/.github/workflows/firebase-hosting-merge.yml*


```
Essentially, npm install reads package.json to create a list of dependencies and uses package-lock.json to inform which versions of these dependencies to install. If a dependency is not in package-lock.json it will be added by npm install.

npm ci (also known as Clean Install) is mean to be used in automated environments such as test platforms, continuous integration, and deployment -- or any situation where you want to make sure you're doing a clean install of your dependencies. It installs dependencies directly from package-lock.json and uses package.json only to validate that there are no mismatched versions. If any dependencies are missing or have incompatible versions, it will throw an error.

Use npm install to add new dependencies, and to update dependencies on a project. Usually, you would use it during development after pulling changes that update the list of dependencies but it may be a good idea to use npm ci in this case.

Use npm ci if you need a deterministic, repeatable build. For example during continuous integratio
```

### Error: try to find *index.html* in *public* folder, instead of *build* folder

```
> react-todo-list@0.1.0 build
> react-scripts build

Could not find a required file.
  Name: index.html
  Searched in: /home/runner/work/firebase-todolist/firebase-todolist/react-todo-list/public <-------------------- need copy ./build/* to ./public
Error: Process completed with exit code 1.
```


At this point we have all the information needed to set up the workflow YAML file. GitHub Actions require that workflow files live in a specific folder structure: *.github/workflow*. The CLI looks to write a file in the workflow folder called *firebase-hosting-pull-request.yml*. If you want to deploy to live on a merge to your main branch you'll also have a file called *firebase-hosting-merge.yml*.

- fix: *Could not find a required file. Name: index.html*

```
cd react-todo-list && npm ci && npm run build && cp -rf ./build/* ./public

or

in package.json, <---------------------- need to change the folder in firebase.json back to public !!!

"build": "react-scripts build && cp -rf ./build/* ./public/",

```

- if even getting error, *Could not find a required file.  Name: index.html*, when run *npm run build*
, then we need to create *public* folder, with an *index.html* (even empty file ok) there!!! So, check it in github, but ignore it later.


### Error: Verifying firebase.json exists

Error: firebase.json file not found. If your firebase.json file is not in the root of your repo, edit the entryPoint option of this GitHub action.

- from: https://github.com/FirebaseExtended/action-hosting-deploy


entryPoint {string}
The directory containing your firebase.json file relative to the root of your repository. Defaults to . (the root of your repo).

```

.github/workflows/firebase-hosting-merge.yml
.github/workflows/firebase-hosting-pull-request.yml

entryPoint: ./react-todo-list

```

- if we set *entryPoint*, then we can try to use *build* folder.




