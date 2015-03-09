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

After installing the above, running `$ gulp` will download all other required libraries and prepare the app to be run.

# Tests

## Dependencies

In addition to the above, you should also run `$ npm install -g karma-cli`.

## Running Tests

`$ karma start` will start a server that will watch for file changes, run tests, and output changes to the console.