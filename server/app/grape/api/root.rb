module API
  class Root < Grape::API
    format :json
    prefix :api

    helpers API::TokenAuthentication

    resource :recipes do
      desc 'A test route' do
        named 'recipes_test'
      end
      get :test do
        { name: 'Ryan' }
      end
    end

    add_swagger_documentation :format => :json,
      :base_path => "http://#{ENV['ROOT_URL']}/api/",
      :hide_documentation_path => true
  end
end
