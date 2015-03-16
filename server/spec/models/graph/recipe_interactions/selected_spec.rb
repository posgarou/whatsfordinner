describe Graph::RecipeInteractions::Selected do

  context 'by default' do
    subject(:selected) { create(:recipe_selected, :with_nodes) }

    it 'has a user' do
      expect(selected.user).not_to be_nil
    end

    it 'has a recipe' do
      expect(selected.recipe).not_to be_nil
    end

    it 'is not confirmed' do
      expect(selected).not_to be_confirmed
    end
  end

  context 'a recipe with a confirmation date' do
    subject(:selected) { create(:recipe_selected, :with_nodes, :confirmed) }

    it 'is confirmed' do
      expect(selected).to be_confirmed
    end
  end
end
