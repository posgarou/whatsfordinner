describe Graph::Ingredient do
  it 'saves successfully' do
    expect { FactoryGirl.create(:ingredient) }
      .to change { Graph::Ingredient.count }.from(0).to(1)
  end

  it 'sets up relationships correctly' do
    relationed_group = FactoryGirl.create(:ingredient, associated_ingredient_groups: 2)
    expect(relationed_group.groups.length).to eq(2)
  end
end
