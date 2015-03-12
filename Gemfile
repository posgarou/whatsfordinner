# This Gemfile includes gems necessary for joining the two applications

gem 'rack'
gem 'rack-mount'

# rails c like rack interface
gem 'racksh'

gem 'pry'
gem 'awesome_print'

gem 'dotenv'

group :test do
  gem 'rack-test'
  gem 'test-unit'
  # gem 'capybara', require: ['capybara', 'capybara/dsl']
  # gem 'rspec'
  gem 'selenium-webdriver'
end

CURRENT_PATH = File.expand_path(File.dirname(__FILE__))

# Include the client and server gemfiles
CLIENT_GEMFILE_PATH = File.join(CURRENT_PATH, 'client', 'Gemfile')
SERVER_GEMFILE_PATH = File.join(CURRENT_PATH, 'server', 'Gemfile')

eval(IO.read(CLIENT_GEMFILE_PATH), binding)
eval(IO.read(SERVER_GEMFILE_PATH), binding)