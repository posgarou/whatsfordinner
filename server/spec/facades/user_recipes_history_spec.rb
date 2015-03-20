describe UserRecipesHistory, type: :model do
  let(:recipe) { create(:recipe) }

  let(:recipes) { [recipe, create(:recipe)] }

  # Each recipe generates six relationships, so 12 total
  let(:user) do
    create(:graph_user,
      :with_interactions,
      :selected_and_rated,
      recipes: recipes
    )
  end

  subject(:history) { UserRecipesHistory.new(user) }

  describe 'basic methods' do
    it 'returns the user uuid' do
      expect(history.user_uuid).to eq(user.uuid)
    end
  end

  describe 'recent_interactions' do
    it 'returns a non-empty result set' do
      expect(history.recent_interactions).not_to be_empty
    end

    it 'returns them sorted by event_date' do
      interactions = history.recent_interactions
      dates = interactions.map(&:event_date)

      expect(dates).to eq(dates.sort.reverse)
    end

    it 'returns results for two recipe' do
      recipe_ids = history.recent_interactions.map(&:recipe).map(&:neo_id)

      # Ensure we're not getting a false positive because the above setup failed
      expect(Graph::Recipe.count).to eq(2)
      expect(recipe_ids.uniq).to match_array(recipes.map(&:neo_id))
    end
  end

  describe 'recently_ methods' do
    it 'returns only Rated objects when I call recently_rated' do
      expect(history.recently_rated.map(&:type).uniq).to eq(['RATED'])
    end

    it 'returns only Selected objects when I call recently_selected' do
      expect(history.recently_selected.map(&:type).uniq).to eq(['SELECTED'])
    end
  end
end
