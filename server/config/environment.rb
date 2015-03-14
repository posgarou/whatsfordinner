# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Default to RACK_ENV or, if this is not set, 'development'
ENV['RAILS_ENV'] ||= ENV['RACK_ENV'] || 'development'

ENV['ROOT_URL'] ||= 'http://localhost:3000'
