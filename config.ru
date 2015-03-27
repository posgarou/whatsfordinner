# This config file loads the Rails and Sinatra apps and then cascades them.
# The Rails app includes the Grape API.

require 'rubygems'
require 'bundler'
require 'dotenv'

##########################
#      ENV VARIABLES     #
##########################

Dotenv.load

# We need to set this here so it is not overridden inside server/config/boot.rb
ENV['BUNDLE_GEMFILE'] ||= 'Gemfile'

# Default to the dev environment
ENV['RACK_ENV'] ||= 'development'

ENV['CASCADED'] = 'true'

##########################
#         BUNDLER        #
##########################

# Load the default gemset, as well as those particular to the current environment
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

##########################
#       APP LOADING      #
##########################

require_relative 'server/config/environment'

# Automatically recompiles assets
require_relative 'client/app'

##########################
#         SYMLINK        #
##########################

# To improve performance, enable nginx to serve as many static assets as possible

# Delete current symlinks (if any) and reestablish symlinks to recompiled assets
# Establish a symlink to all files in the client public dir

if ENV['RACK_ENV'] == 'production'
  Process.spawn("find public -type l | xargs rm && cd client && gulp && cd .. && ln -sf client/public/* public")
end

##########################
#         CASCADE        #
##########################

# Rack::Cascade sends all routes to the first Rack app, and if it responds with a 404
# Rack passes the request on to the next Rack app.

cascaded_app = Rack::Cascade.new [WFDinnerApp, WFDinnerServer::Application]


##########################
#    Sidekiq Interface   #
##########################

# In non-development environments, we protect the Sidekiq interface with basic auth

require 'sidekiq/web'

if ENV['RACK_ENV'] == 'development'
  sidekiq = Sidekiq::Web
else
  sidekiq = Rack::Auth::Basic.new(Sidekiq::Web.new) do |username, password|
    username == ENV['SIDEKIQ_USER']
    password == ENV['SIDEKIQ_PW']
  end
end

##########################
#         STARTUP        #
##########################

# Rack::Cascade sends all routes to the first Rack app, and if it responds with a 404
# Rack passes the request on to the next Rack app.
#
# /sidekiq routes to the sidekiq app

run Rack::URLMap.new('/' => cascaded_app, '/sidekiq' => sidekiq)
