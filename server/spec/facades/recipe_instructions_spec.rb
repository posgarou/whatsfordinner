describe RecipeInstructions do
  let(:recipe) { create(:recipe) }

  let(:recipes) { [recipe] }

  let(:user) do
    create(:graph_user,
      :with_interactions,
      :selected_and_rated,
      recipes: recipes
    )
  end

  subject(:facade) { RecipeInstructions.new(recipe, user) }

  describe 'timeframe_breakdown_text' do
    it 'displays a breakdown of cooking and prep time' do
      expect(facade.timeframe_breakdown_text)
        .to eq('10m prep and 1h 40m cooking')
    end

    it 'only displays the cooking time when only it is present' do
      recipe.update_attribute(:prep_time, nil)

      expect(facade.timeframe_breakdown_text)
        .to eq('1h 40m cooking')
    end
  end

  describe 'timeframe_display_text' do
    it 'displays the total time' do
      expect(facade.timeframe_display_text)
        .to eq('1h 50m')
    end
  end
end
