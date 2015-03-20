describe Graph::Recipe do
  subject(:recipe) { FactoryGirl.create(:recipe, :with_tags, :with_ingredients, :with_steps, :with_cuisines) }

  describe 'difficulties' do
    it 'can have any of Recipe\'s difficulties' do
      Graph::Recipe::DIFFICULTIES.each do |difficulty|
        recipe.difficulty = difficulty
        expect(recipe).to be_valid
      end
    end

    it 'can take difficulties in lower case' do
      Graph::Recipe::DIFFICULTIES.each do |difficulty|
        recipe.difficulty = difficulty.downcase
        expect(recipe).to be_valid
      end
    end

    it 'can be nil' do
      recipe.difficulty = nil
      expect(recipe).to be_valid
    end

    it 'cannot be a blank string' do
      recipe.difficulty = ''
      expect(recipe).not_to be_valid
    end

    it 'cannot be anything outside the array' do
      recipe.difficulty = 'asdfadsfadsf'
      expect(recipe).not_to be_valid
    end
  end

  it 'has tags' do
    expect(recipe.tags).not_to be_empty
  end

  it 'has ingredients' do
    expect(recipe.ingredients).not_to be_empty
  end

  it 'has steps' do
    expect(recipe.steps).not_to be_empty
  end

  it 'has cuisines' do
    expect(recipe.cuisines).not_to be_empty
  end

  describe 'render_ingredients' do
    it 'renders a list containing string representations' do
      rendered_ingredients = recipe.render_ingredients

      expect(rendered_ingredients).not_to be_empty
      expect(rendered_ingredients).to all(match(/One/))
    end
  end

  describe 'steps_in_order' do
    subject(:ordered_ingredients) { recipe.steps_in_order }
    it 'returns a list of steps from first to last' do
      expect(ordered_ingredients.to_a.first.number).to eq(1)
      expect(ordered_ingredients.to_a.last.number).to eq(ordered_ingredients.length)
    end
  end
end
