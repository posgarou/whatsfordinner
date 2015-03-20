describe UserRecipeHistory, type: :model do
  let(:recipe) { create(:recipe) }

  let(:recipes) { [recipe] }

  let(:user) do
    create(:graph_user,
      :with_interactions,
      :selected_and_rated,
      recipes: recipes
    )
  end

  subject(:history) { UserRecipeHistory.new(user, recipe) }

  describe 'basic methods' do
    it 'returns the recipe id' do
      expect(history.recipe_id).to eq(recipe.id)
    end

    it 'returns the user uuid' do
      expect(history.user_uuid).to eq(user.uuid)
    end
  end

  describe 'recent_interactions' do
    it 'returns results' do
      expect(history.recent_interactions).not_to be_empty
    end

    it 'returns them sorted by event_date' do
      interactions = history.recent_interactions

      expect(interactions).to eq(interactions.sort_by { |rel| rel.event_date }.reverse)
    end

    context 'when there are multiple recipes related to this user' do
      let(:recipes) { [recipe, create(:recipe)] }

      it 'only returns results for this recipe' do
        recipe_ids = history.recent_interactions.map(&:recipe).map(&:neo_id)

        # Ensure we're not getting a false positive because the above setup failed
        expect(Graph::Recipe.count).to eq(2)
        expect(recipe_ids.uniq).to eq([recipe.neo_id])
      end
    end
  end

  describe 'recently_ methods' do
    it 'returns only Rated objects when I call recently_rated' do
      expect(history.recently_rated.map(&:type).uniq).to eq(['rated'])
    end

    it 'returns only Selected objects when I call recently_selected' do
      expect(history.recently_selected.map(&:type).uniq).to eq(['selected'])
    end
  end
end
