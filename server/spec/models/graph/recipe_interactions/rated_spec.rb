describe Graph::RecipeInteractions::Rated do

  context 'by default' do
    subject(:rated) { create(:recipe_rated, :with_nodes) }

    it 'has a user' do
      expect(rated.user).not_to be_nil
    end

    it 'has a recipe' do
      expect(rated.recipe).not_to be_nil
    end
  end

  context 'when disliked' do
    subject(:rated) { create(:recipe_rated, :with_nodes, :dislike) }

    it 'has a rating of -1' do
      expect(rated.rating).to eq(-1)
    end
  end

  context 'when meh\'ed' do
    subject(:rated) { create(:recipe_rated, :with_nodes, :meh) }

    it 'has a rating of 0' do
      expect(rated.rating).to eq(0)
    end
  end

  context 'when liked' do
    subject(:rated) { create(:recipe_rated, :with_nodes, :like) }

    it 'has a rating of +1' do
      expect(rated.rating).to eq(1)
    end
  end
end
