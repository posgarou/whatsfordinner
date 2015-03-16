# Preload all Grape validation classes
require_rel 'validations'

module API
  class Root < Grape::API
    format :json
    prefix :api

    helpers API::TokenAuthentication

    mount API::Recipes

    add_swagger_documentation :format => :json,
      :base_path => "http://#{ENV['ROOT_URL']}/api/",
      :hide_documentation_path => true
  end
end
