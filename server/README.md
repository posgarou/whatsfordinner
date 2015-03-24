# Dependencies

## Redis

On OSX, simply `$ brew install redis`.  On other systems, consult the instructions at the [Redis Readme](https://github.com/antirez/redis).

## MongoDB

Installation of MongoDB should be fairly straightforward.  Assuming you have npm installed, just run `$ npm install mongodb`

## Neo4j

There is a gotcha for Neo4j installation for users using zshell: all Rake commands with arguments must be run with noglob.

Thus, to install a (named) instance of neo4j, run `$ noglob bundle exec rake neo4j:install[community-2.2.0-M02,wfd-dev]`.

### Starting Neo4j

Run `$ noglob bundle exec rake neo4j:start['wfd-dev']`.

# Starting the App

* Ensure MongoDB is running
* Ensure Neo4j is running in the appropriate environment
* Ensure Redis is running
* Ensure Sidekiq is running

# Test Env Setup

## Neo4j

Run the following to setup a neo4j test server that will run on 7475:

`$ noglob bundle exec rake neo4j:install[community-2.2.0-M02,wfd-test]`
`$ noglob rake neo4j:config[wfd-test,7475]`
`$ noglob rake neo4j:start[wfd-test]`

This installs a separate instance called test, sets it to run on port 7475, and starts it.

# Exploring the API

One of the great features about Grape is its easy compatibility with Swagger (an API documentation standard/tool).

To view the Swagger documentation for the API, visit the relevant host at the route `/api/swagger`.  (You can also access the raw Swagger JSON at `/api/swagger_doc.json`.)

# Troubleshooting

If you have problems accessing the database, visit localhost:7474 for development and localhost:7475 for testing.  If you do not see some sort of html response (a broken app is to be expected if installed via rake), then you need to start the neo4j server at that port using the commands above.
