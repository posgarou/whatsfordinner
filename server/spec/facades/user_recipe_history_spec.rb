describe UserRecipeHistory, type: :model do
  let(:recipe) { create(:recipe) }
  let(:recipes) { [recipe] }
  let(:user) { create(:graph_user) }

  subject(:history) { UserRecipeHistory.new(user, recipe) }

  describe 'basic methods' do
    it 'returns the recipe id' do
      expect(history.recipe_id).to eq(recipe.id)
    end

    it 'returns the user id' do
      expect(history.user_id).to eq(user.id)
    end
  end

  describe 'recent_interactions' do
    let(:user) do
      create(:graph_user,
        :with_interactions,
        :selected_and_rated,
        recipes: recipes
      )
    end

    it 'returns five by default' do
      expect(history.recent_interactions.length).to eq(5)
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
    let(:user) do
      create(:graph_user,
        :with_interactions,
        :selected_and_rated,
        recipes: recipes
      )
    end

    it 'returns 2 Rated objects when there are only 2' do
      expect(history.recently_rated.length).to eq(2)
    end

    it 'returns 4 Selected objects when there are only 4' do
      expect(history.recently_selected.length).to eq(4)
    end

    it 'returns 2 Selected objects when I specify limit:2' do
      expect(history.recently_selected(limit:2).length).to eq(2)
    end

    it 'returns 2 different Selected objects when I specify offset:2' do
      expect(history.recently_selected(limit:2)).not_to eq(history.recently_selected(limit:2, offset:2))
    end
  end
end
