module WhatsForDinner
  class API < Grape::API
    version 'v1', using: :header, vendor: 'WFDinner'
    format :json
    prefix :api

    resource :recipes do
      desc 'A test route' do
        named 'recipes_test'
      end
      get :test do
        { name: 'Ryan' }
      end
    end
  end
end