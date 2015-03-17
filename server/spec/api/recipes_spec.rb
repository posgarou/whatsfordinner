describe API::Recipes do
  describe 'GET /api/recipes', :test_sequence do
    # Neo4j creation is very expensive, so we cache it in before :all
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
  #
  describe 'GET /api/recipes/:recipe_id', :test_sequence do
    before :all do
      5.times do
        create(:recipe, :with_ingredients, :with_steps, :with_tags)
      end
    end

    subject(:first_recipe) { Graph::Recipe.all.first }

    it 'returns a recipe when visiting the path' do
      get "/api/recipes/#{first_recipe.id}"

      expect_success
    end
  end
end
