describe Graph::Ingredient do
  it 'saves successfully' do
    expect { FactoryGirl.create(:ingredient) }
      .to change { Graph::Ingredient.count }.by(1)
  end

  it 'sets up relationships correctly' do
    ingredient = FactoryGirl.create(:ingredient, associated_ingredient_groups: 2, associated_flavors: 2)
    expect(ingredient.groups.length).to eq(2)
    expect(ingredient.flavors.length).to eq(2)
  end
end
