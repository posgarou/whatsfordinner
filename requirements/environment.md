# Environment

## Development

### Common

Basic environment setup:

* GitHub repo
* rvm

**Time**: 15 min

### Client

#### SINATRA SERVER

Setup a Sinatra server to serve static assets for the front-facing Angular app.  Asset compilation handled via Gulp (see GULP WORKFLOW).

**Details**: Using .coffee, .scss, and .jade.

**Time**: 1 hour

#### GULP WORKFLOW

Setup a series of Gulp tasks for asset management.

**Details:** It should:

* download Bower packages
* combine vendor files into a single minified file
* compile .scss into a single .css file
* compile the Angular .coffee files into a single minified .js file
* compile all Jade templates into .html
* optimize image assets for the web
* pipe the result of the above into `public/`

**Time**: 3 hours

### Server

#### RAILS INITIALIZATION

Initialize a new Rails app.

**Details**:
* Skip activerecord and use Mongoid

**TIME**: 10 min

#### GRAPE SETUP

Install Grape, setup the asset path, and mount it at Rails root.

**TIME**: 30 min

### Cascade

#### CREATE A COMMON GEMFILE

Combine `client/Gemfile` and `server/Gemfile` with a couple Cascade app-specific gems, so `$ bundle install` in the root dir installs the gems for both and generates a single `Gemfile.lock`.

**Time**: 45 min

#### Cascade the Apps

Create a custom `config.ru` that will run the Sinatra and Rails servers side by side.

**Time**: 2 hours

## Testing

### FRONTEND TESTING

Setup frontend testing environment with Karma and Jasmine.

**DETAILS**: There are a couple complexities with directory routing, Angular templates, etc.

**Time**: 2 hours

### BACKEND TESTING

Simple setup with RSpec.

**DETAILS**: Also go in and set it up to generate RSpec tests rather than Test::Unit.  Use fixtures rather than FactoryGirl.

**Time**: 30 min

### E2E TESTING

Setup E2E testing at the Cascade level using RSpec/Capybara and Rack::Test.

**Time**: 45 min

## Production

### SETUP AMAZON BOX

Set it up on Amazon and set local environment up with key to SSH in.

**Time**: 1 hour

### INSTALL DEPENDENCIES ON AMAZON BOX

Need:

* git
* rvm
* npm
* npm/bower
* npm/gulp
* bundler

**Details**: A lot of new stuff here.  Will take extra time.

**Time**: 2 hours

### PRODUCTION SHELL SCRIPT

Write a simple .sh script to

* pull from Github,
* set RACK_ENV to production, and
* compile assets and start the Rack server via `serve.sh`.

**Time**: 15 min