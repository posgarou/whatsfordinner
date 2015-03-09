# This config file loads the Rails and Sinatra apps and then cascades them.
# The Rails app includes the Grape API.
# All other Rails assets are under either the admin/ or admin_assets/ routes.

require 'rubygems'
require 'bundler'

Bundler.require(:default)

# Load the Rails app
# Note that the Rails app is allowed to manage its own gems.
require_relative 'server/config/environment'

# Initialize the Rails application.
# Rails.application.initialize!

require_relative 'client/app'


run Rack::Cascade.new [WFDinnerApp, WFDinnerServer::Application]