# This Gemfile includes gems necessary for joining the two applications

source 'https://rubygems.org' do
  gem 'rack'
  gem 'rack-mount'

# rails c like rack interface
  gem 'racksh'

  gem 'dotenv'

  group :test do
    gem 'rack-test'
    gem 'test-unit'
    # gem 'capybara', require: ['capybara', 'capybara/dsl']
    # gem 'rspec'
    gem 'selenium-webdriver'
  end
end

CURRENT_PATH = File.expand_path(File.dirname(__FILE__))

# Paths to both client and server Gemfile
CLIENT_GEMFILE_PATH = File.join(CURRENT_PATH, 'client', 'Gemfile')
SERVER_GEMFILE_PATH = File.join(CURRENT_PATH, 'server', 'Gemfile')

# Include client and server Gemfile
eval_gemfile CLIENT_GEMFILE_PATH
eval_gemfile SERVER_GEMFILE_PATH
