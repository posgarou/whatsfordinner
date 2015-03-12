# Assets

Once you have installed the dependencies (see below), you will need to compile the Gulp assets.

To do so in a development environment, just run `$ gulp`.

To simulate the production environment, you can:

1. Run `$ gulp --env=production` (or, equivalently, run `$ NODE_ENV=production gulp`.)
2. `$ rackup` either the client app or the cascaded app (`(cd ../ && rackup)`) in the production environment.  Assets are automatically recompiled each time the app racks up when `RACK_ENV=production`.

# Dependencies

## Package Managers and Task Runners

* npm
* bower
* gulp

To install these, run:

* `$ brew install npm`
* `$ npm install -g bower`
* `$ npm install -g gulp-cli`

## Library Dependencies

After installing the above (from within the client directory):

1. Run `$ npm install` to install all npm module dependencies.
2. `$ gulp` will download all other required libraries and prepare the app to be run.

# Tests

## Dependencies

In addition to the above, you should also run `$ npm install -g karma-cli`.

## Running Tests

`$ karma start` will start a server that will watch for file changes, run tests, and output changes to the console.