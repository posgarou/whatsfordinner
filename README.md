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

# Setting the App Up on Production

Setup an Amazon ec2 instance.  Remember, while setting it up, to open up port 80 to HTTP.

1. `$ sudo yum install git`
2. `$ gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3` (to get the rvm key)
3. `$ curl -L get.rvm.io | bash -s stable`
4. Run `$ source /home/ec2-user/.rvm/scripts/rvm`
5. Finally, run `$ export rvmsudo_secure_path=1`

Next, install the prerequisites for getting and setting up node.js:

1. `$ sudo yum install gcc-c++ make openssl-devel libcurl-devel`
2. `$ git clone git://github.com/joyent/node.git`
3. `$ cd node`
4. `$ git checkout v0.12.0`
5. `$ ./configure`
6. `$ make`.  This will take about 30 min.
7. `$ sudo make install`
8. `$ echo 'export PATH=$PATH:/usr/local/bin' >> $HOME/.bashrc`

Now enter the sudo terminal (`$ sudo su`), open `/etc/sudoers`, and add `/usr/local/bin` to the end of the default `secure_path`.  :wq! and exit su.

To install npm:

1. `$ git clone https://github.com/isaacs/npm.git`
2. `$ cd npm`
3. `$ sudo make install`

To setup the Ruby environment further:


1. Clone the repo: `$ git clone https://github.com/posgarou/whatsfordinner.git`
2. Go into `~/whatsfordinner`.  RVM will prompt the installation of the correct Ruby version.  Follow the command it gives.  (Remember to `$ cd .` afterwards.)
3. `$ gem install bundler`

To setup the frontend:
1. `$ cd client`
2. `$ npm install`
3. `$ sudo npm install -g gulp-cli karma-cli`

Next, you need to setup Passenger and nginx.  Passenger should be included via the Gemfile.

In the terminal run: `$ rvmsudo passenger-install-nginx-module`

To finish this installation, you need to set up a swap file.

1. `$ sudo dd if=/dev/zero of=/swap bs=1M count=1024`
2. `$ sudo mkswap /swap`
3. `$ sudo swapon /swap`

To run nginx, run `$ /opt/nginx/sbin/nginx`.