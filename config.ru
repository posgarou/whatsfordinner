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

##########################
#         BUNDLER        #
##########################

# Load the default gemset, as well as those particular to the current environment
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

##########################
#       APP LOADING      #
##########################

require_relative 'server/config/environment'

require_relative 'client/app'

##########################
#         CASCADE        #
##########################

# Rack::Cascade sends all routes to the first Rack app, and if it responds with a 404
# Rack passes the request on to the next Rack app.

cascaded_app = Rack::Cascade.new [WFDinnerApp, WFDinnerServer::Application]


##########################
#         STARTUP        #
##########################

# Rack::Cascade sends all routes to the first Rack app, and if it responds with a 404
# Rack passes the request on to the next Rack app.

if ENV['RACK_ENV'] == 'development'
  ##########################
  #    Sidekiq Interface   #
  ##########################

  # We only want the Sidekiq interface to appear in development

  require 'sidekiq/web'

  run Rack::URLMap.new('/' => cascaded_app, '/sidekiq' => Sidekiq::Web)
else
  # In all other environments, just launch the cascaded app
  run cascaded_app
end

