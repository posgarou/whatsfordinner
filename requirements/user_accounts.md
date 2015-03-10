# User Accounts

## Setup

As a client user, I should be able to setup an account to keep track of my preferences, recipe queue, and recipe history.

**DETAILS**: Angular will communicate with the Rails backend, which will use OmniAuth to setup an account.

**Time**: (Epic.  See stories.)

**STATUS**: **INCOMPLETE**

### Server Setup

#### NGINX SSL MODULE

Download and install the nginx ssl module.

**Time**: 1.5 hrs

**STATUS**: **INCOMPLETE**

#### NGINX SSL SETUP

Enable SSL access to the cascaded Rack app.  Set a parameter if SSL is used.

**Time**: 20 min

**STATUS**: **INCOMPLETE**

#### AMAZON SSL

Enable SSL port on ec2.

**Time**: 10 min

**STATUS**: **INCOMPLETE**

### Rails Setup

#### User Account

##### MODEL

There should be a user model. It should require a user's name and email address.  It should be tied to one or more OmniAuth accounts.

**Time**: 30 min

**STATUS**: **INCOMPLETE**

##### ROUTES

There should be restful routes provided in Grape for handling the current user.

**Time**: 1 hr

**STATUS**: **INCOMPLETE**

##### INTERACTORS

There should be interactors for handling user resource requests.

**Time**: 5 hr

**STATUS**: **INCOMPLETE**

#### Omniauth Configuration

##### Keys

###### FACEBOOK

Need a Facebook app API key.

**Time**: 30 min

**STATUS**: **COMPLETE**

###### GOOGLE

Need a Google app API key.

**Time**: 30 min

**STATUS**: **COMPLETE**

##### RAILS CONFIG

There should be configuration for Facebook and Google Omniauth.

**DETAILS**: Add and configure: omniauth, omniauth-facebook, omniauth-google-oauth2. Use keys from previous step.

**STATUS**: **COMPLETE**

##### RAILS ROUTES

There should be `session/` routes.

**Time**: 30 min

**STATUS**: **COMPLETE**

##### RAILS CONTROLLER

There should be a SessionsController with associated Interactors.

**Time**: 2 hrs

**STATUS**: **INCOMPLETE**

### FRONTEND SETUP

#### UI

##### Root path

###### LOGGED IN

As a logged in client user, I should be redirected to `/#dashboard` and a DashboardCtrl on reaching the root path.

**Time**: 1 hr

**STATUS**: **INCOMPLETE**

###### NOT LOGGED IN

As a guest or non-authenticated client user, I should see the splash page on reaching the root path. The splash page should include a "Login with Facebook" and a "Login with Google" button.

**Time**: 45 min

**STATUS**: **INCOMPLETE**

##### Login Action

###### Popup

As a client user logging into the site, when I click on either the Login with Facebook or Login with Google buttons, I should see a popup that lasts until I have completed the login process.  The client page should instruct the user to allow popups and to complete the authorization before continuing.

**DETAILS**: Follow basic strategy given here: http://jbavari.github.io/blog/2014/06/04/handling-angularjs-popups-for-oauth/

**Time**: 1.5 hrs

**STATUS**: **INCOMPLETE**

###### NEW ACCOUNT REDIRECT

As a newly registered user (or an already registered user who has not completed the registration process), I should be redirected to a CompleteRegistrationCtrl.

**Details**: For now, this should only get the user's name and email. These should be prepopulated with the information provided via Omniauth.

**Time**: 20 min

**STATUS**: **INCOMPLETE**

###### EXISTING ACCOUNT REDIRECT

As a client user who has finished the registration process, I should be redirected to `/#dashboard` and the DashboardCtrl.

**Time**: 20 min

**STATUS**: **INCOMPLETE**