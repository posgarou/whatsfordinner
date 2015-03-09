# Introduction
## What's for dinner?

Goal: to be an easy-to-use tool to help users figure out what to eat.  Users input their preferences (and rate recipes as they go along) and then are shown, based on time- and preference-backed criteria, a short list of recipes to choose from.

# Project Structure

This application mounts side-by-side

1. A Sinatra app that serves an Angular app at the root path, as well as the assets necessary for that app.  It also depends on the Grape-backed API offered via the Rails app (see below).  (client)
2. A Rails app (server), that includes
  * The database-backed models necessary for the front- and back-facing site to function.
  * A simple admin interface for editing recipes, etc.
  * A Grape API

# Setup

* Follow the setup instructions in the client README.
* Follow the setup instructions in the server README.

# Running the App

Note: Client assets need to be compiled via Gulp in some fashion before running the application.  (All compiled assets are excluded from git.)  There are three ways to handle this.

1. The simplest is to use `$ ./serve.sh` to run the app.  This simple shell script runs the gulp precompilation and starts the server.
2. Alternatively, you can manually `$ cd client` and compile the assets.  After the assets have been compiled, you can simply run `$ bundle exec rackup`.
  * `$ gulp` will download prerequisite libraries and compile the assets.
  * `$ gulp watch` will watch for changes in dependencies or libraries and recompile asset files as needed.