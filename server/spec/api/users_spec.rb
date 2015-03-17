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

  describe 'GET /api/users/:user_id' do
    it 'returns a user and his/her info' do
      get resource_path

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/users/:user_id/history' do
    it 'returns history (with pagination) for all user\'s related recipes' do
      get resource_path + '/history'

      expect(response.status).to eq(200)
    end
  end
end
