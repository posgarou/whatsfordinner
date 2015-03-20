module API
  class Root < Grape::API
    format :json
    prefix :api

    helpers do
      def logger
        Rails.logger
      end
    end

    helpers API::TokenAuthentication

    use API::Logger

    mount API::Recipes
    mount API::Users
    mount API::Auth

    add_swagger_documentation :format => :json,
      :base_path => "http://#{ENV['ROOT_URL']}/api/",
      :hide_documentation_path => true
  end
end
