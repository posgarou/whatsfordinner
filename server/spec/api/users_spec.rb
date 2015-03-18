describe API::Users do
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

  xdescribe 'GET /api/users/:user_id' do
    it 'returns a user and his/her info' do
      get resource_path

      expect_success
    end
  end

  describe 'GET /api/users/:user_id/recipes/history' do
    it 'returns history (with pagination) for all user\'s related recipes' do
      get resource_path + '/recipes/history'

      expect_success

      expect(response.body).to match(/selected/).and match(/rated/)
    end
  end

  describe 'GET /api/users/:user_id/recipes/concierge' do
    before do
      3.times { create(:recipe) }
    end

    it 'returns 3 recommendations (or # of recipes, if fewer)' do
      get resource_path + '/recipes/concierge'

      expect_success

      expect(parse_response.length).to eq(3)
    end
  end
end
