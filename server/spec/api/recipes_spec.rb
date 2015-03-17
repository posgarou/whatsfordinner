describe API::Recipes do
  let(:first_recipe) { Graph::Recipe.all.first }

  describe 'GET /api/recipes', :test_sequence do
    # Use the expensive creation for the whole describe block
    before :all do
      21.times do
        create(:recipe, :with_ingredients, :with_steps, :with_tags)
      end
    end

    it 'returns a list of recipes' do
      get '/api/recipes'

      expect_success
    end

    it 'returns 20 by default on page one' do
      get '/api/recipes', p: 1

      expect_success
      expect(parse_response.length).to eq(20)
    end

    it 'returns 1 by default on page two' do
      get '/api/recipes', p: 2

      expect_success
      expect(parse_response.length).to eq(1)
    end

    it 'returns 0 by default on page three' do
      get '/api/recipes', p: 3

      expect_success
      expect(parse_response).to be_empty
    end

    it 'returns 21 for p 1 if I specify per_page of 30' do
      get '/api/recipes', p: 1, per_page: 30

      expect_success
      expect(parse_response.length).to eq(21)
    end

    it 'returns 0 for p 2 if I specify per_page of 30' do
      get '/api/recipes', p: 2, per_page: 30

      expect_success
      expect(parse_response).to be_empty
    end

    it 'raises an error if I specify per_page outside 1..40' do
      get '/api/recipes', per_page: 0

      expect_400
    end
  end

  describe 'GET /api/recipes/:recipe_id' do
    before do
      5.times do
        create(:recipe, :with_ingredients, :with_steps, :with_tags)
      end
    end

    it 'returns a recipe when visiting the path' do
      get "/api/recipes/#{first_recipe.id}"
      json = parse_response

      expect_success
      expect(json).to have_key('title')
      expect(json).to have_key('description')
      expect(json).to have_key('id')
    end
  end

  describe 'GET /api/recipes/:recipe_id/instructions' do
    before do
      create(:recipe, :with_ingredients, :with_steps, :with_tags)
    end
    it 'returns a JSON representation of the recipe instructions' do
      get "/api/recipes/#{first_recipe.id}/instructions"
      json = parse_response['instructions']

      expect(json).to have_key('title')
      expect(json).to have_key('description')
      expect(json).to have_key('serves')
      expect(json['serves']).to have_key('current_amount')
      expect(json).to have_key('timeframe')
      expect(json['timeframe']).to have_key('displayText')
      expect(json['timeframe']).to have_key('breakdownText')
      expect(json).to have_key('cuisines')
      expect(json).to have_key('mealtimes')
      expect(json).to have_key('difficulty')
      expect(json).to have_key('serveWith')
      expect(json).to have_key('tags')
      expect(json).to have_key('ingredients')
      expect(json).to have_key('steps')
    end

    it 'includes user info when user_id is supplied' do
      get "/api/recipes/#{first_recipe.id}/instructions", { user_id: create(:graph_user).uuid }
      json = parse_response

      expect(json).to have_key('instructions')
      expect(json).to have_key('user')
    end
  end
end
