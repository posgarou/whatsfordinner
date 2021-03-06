require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require 'neo4j/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups, :authorization)

module WFDinnerServer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.paths.add File.join('app', 'grape'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'grape', '*')]
    config.autoload_paths += Dir[Rails.root.join('app', 'facades', 'concerns')]

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :facebook, ENV['FB_APP_ID'], ENV['FB_SECRET']
      provider :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_SECRET']
    end

    # For explanation, see https://github.com/neo4jrb/neo4j/issues/724#issuecomment-84990610
    ENV['NEO4J_RETRY_COUNT'] ||= '25'
  end
end
