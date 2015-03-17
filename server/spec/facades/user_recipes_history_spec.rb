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
    it 'returns the user id' do
      expect(history.user_id).to eq(user.id)
    end
  end

  describe 'recent_interactions' do
    it 'returns five by default' do
      expect(history.recent_interactions.length).to eq(5)
    end

    it 'returns them sorted by event_date' do
      interactions = history.recent_interactions

      expect(interactions).to eq(interactions.sort_by { |rel| rel.event_date }.reverse)
    end

    it 'returns results for two recipe' do
      recipe_ids = history.recent_interactions.map(&:recipe).map(&:neo_id)

      # Ensure we're not getting a false positive because the above setup failed
      expect(Graph::Recipe.count).to eq(2)
      expect(recipe_ids.uniq).to match_array(recipes.map(&:neo_id))
    end
  end

  describe 'recently_ methods' do
    it 'returns 4 Rated objects when there are only 4' do
      expect(history.recently_rated.length).to eq(4)
    end

    it 'returns 5 Selected objects when there are more than 5' do
      expect(history.recently_selected.length).to eq(5)
    end

    it 'returns 2 Selected objects when I specify limit:2' do
      expect(history.recently_selected(limit:2).length).to eq(2)
    end

    it 'returns 2 different Selected objects when I specify offset:2' do
      expect(history.recently_selected(limit:2)).not_to eq(history.recently_selected(limit:2, offset:2))
    end
  end
end
