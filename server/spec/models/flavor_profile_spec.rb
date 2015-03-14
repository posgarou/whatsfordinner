describe Graph::FlavorProfile do
  it 'saves successfully' do
    expect{ FactoryGirl.create(:flavor) }
      .to change{ Graph::FlavorProfile.count }.from(0).to(1)
  end

  it 'sets up relationships correctly' do
    flavor = FactoryGirl.create(:flavor, associated_ingredients: 2)

    expect(flavor.ingredients.length).to eq(2)
  end
end
