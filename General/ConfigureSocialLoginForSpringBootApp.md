
# Configure Google, Facebook, Github and LinkedIn for Social Login in Your Spring Boot App

- Ref:

https://www.javachinna.com/spring-boot-user-registration-and-oauth2-social-login-with-facebook-google-linkedin-and-github-part-1/

## Facebook

- Go to https://developers.facebook.com and register for a developer account, if you haven’t already done so.
- Head over to the Facebook app dashboard: https://developers.facebook.com/apps.
- Create a Facebook app. Instructions for creating a Facebook application can be found here: https://developers.facebook.com/docs/apps/register.
- Once you’ve created your Facebook app, go to the app dashboard, click the Settings link on the left-hand side, and select the Basic submenu.
- Save the App ID and App Secret values. You’ll need them later.
- You’ll also need to add a Facebook Login product. From the left menu, click the + sign next to products and add a Facebook Login product.
- Fill in the Authorized redirect URIs field to include the redirect URI to your app: http://<your-domain>/login/oauth2/code/facebook
- Save changes

## Google

Here are the steps you need to follow to configure Google for social login:

- Go to https://console.developers.google.com/ and register for a developer account.
- Create a Google API Console project.
- Once your Google App is open, click on the Credentials menu and then Create Credentials followed by OAuth client ID.
- Select Web Application as the Application type.
- Give the client a name.
- Fill in the Authorized redirect URIs field to include the redirect URI to your app: http://<your-domain>/login/oauth2/code/google
- Click Create.
- Copy the client ID and client secret, as you’ll need them later.


## Github

Here are the steps you need to follow to configure Github for social login:

- Go to  https://github.com/settings/developers and create a New OAuth app under the OAuth Apps left menu.
- Fill in the Authorization callback URL field to include the redirect URI to your app: http://<your-domain>/login/oauth2/code/github
- Click on Register Application
- Copy the client ID and client secret, as you’ll need them later.


## LinkedIn

Here are the steps you need to follow to configure LinkedIn for social login:

- Go to  https://www.linkedin.com/developers/apps and create a new app.
- Go to My Apps and select the created app.
- Copy the client ID and client secret, as you’ll need them later.
- Click on the Auth tab and Fill in the Redirect URLs under OAuth 2.0 settings to include the redirect URI to your app: http://<your-domain>/login/oauth2/code/linkedin


