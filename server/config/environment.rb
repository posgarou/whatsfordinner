# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ENV['ROOT_URL'] ||= 'http://localhost:3000'
