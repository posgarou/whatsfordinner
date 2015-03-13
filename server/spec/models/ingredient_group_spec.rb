describe Graph::IngredientGroup do
  it 'saves successfully' do
    expect{ FactoryGirl.create(:ingredient_group) }
      .to change{ Graph::IngredientGroup.count }.from(0).to(1)
  end

  it 'sets up relationships correctly' do
    group = FactoryGirl.create(:ingredient_group, associated_ingredient_groups: 2, associated_ingredients: 2)

    expect(group.groups.length).to eq(2)
    expect(group.ingredients.length).to eq(2)
  end
end
