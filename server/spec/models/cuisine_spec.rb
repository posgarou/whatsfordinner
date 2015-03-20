describe Graph::Cuisine do
  let(:number_of_recipes) { 3 }
  subject(:cuisine) { create(:cuisine, number_of_recipes: number_of_recipes) }

  it 'has a name' do
    expect(cuisine.name).to be_present
  end

  context 'when there are 0 recipes' do
    let(:number_of_recipes) { 0 }

    it 'returns 0 recipes' do
      expect(cuisine.recipes.length).to eq(0)
    end
  end

  context 'when there are 3 recipes' do
    let(:number_of_recipes) { 3 }

    it 'returns 3 recipes' do
      expect(cuisine.recipes.length).to eq(3)
    end
  end
end
