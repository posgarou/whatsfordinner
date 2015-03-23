require_relative '../support/token_headers'
require_relative '../support/authenticated_resource'

describe API::Users do
  include TokenHeaders

  let(:recipe) { create(:recipe) }

  let(:recipes) { [recipe] }

  let(:user) do
    create(
      :graph_user,
      :with_interactions,
      :selected_and_rated,
      recipes: recipes
    )
  end

  let(:resource_path) { "/api/users/#{user.uuid}" }

  describe 'GET /api/users/:user_id' do
    is_and_acts_like 'an authenticated resource', :user, :get, :resource_path, {}

    it 'returns a user and his/her info' do
      get resource_path, nil, valid_headers(user)

      expect_success
    end

    it 'includes required data for the dashboard' do
      get resource_path, nil, valid_headers(user)

      json = parse_response

      expect(json['name']).not_to be_blank
      expect(json['email']).not_to be_blank
      expect(json['provider']).not_to be_blank
      expect(json['image_url']).not_to be_blank
      expect(json['roles']).not_to be_empty
      expect(json['uuid']).not_to be_empty
    end
  end

  describe 'GET /api/users/:user_id/recipes/history' do
    let(:history_resource_path) { resource_path + '/recipes/history' }

    is_and_acts_like 'an authenticated resource', :user, :get, :history_resource_path, {}

    it 'returns history (with pagination) for all user\'s related recipes' do
      get history_resource_path, nil, valid_headers(user)

      expect_success

      expect(response.body).to match(/SELECTED/).and match(/RATED/)
    end
  end

  describe 'GET /api/users/:user_id/recipes/needs_rating' do
    let(:needs_rating_resource_path) { resource_path + '/recipes/needs_rating' }

    is_and_acts_like 'an authenticated resource', :user, :get, :needs_rating_resource_path, {}

    before do
      3.times { create(:recipe_selected, :with_nodes, from_node: user) }
    end

    it 'returns 3 recipes needing rating' do
      get needs_rating_resource_path, nil, valid_headers(user)

      expect_success

      expect(parse_response.length).to eq(3)
    end
  end

  describe 'GET /api/users/:user_id/recipes/concierge' do
    let(:concierge_resource_path) { resource_path + '/recipes/concierge' }

    is_and_acts_like 'an authenticated resource', :user, :get, :concierge_resource_path, {}

    before do
      3.times { create(:recipe) }
    end

    it 'returns 3 recommendations (or # of recipes, if fewer)' do
      get concierge_resource_path, nil, valid_headers(user)

      expect_success

      expect(parse_response.length).to eq(3)
    end
  end
end
