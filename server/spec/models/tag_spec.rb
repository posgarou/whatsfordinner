describe Graph::Tag do
  it 'saves successfully' do
    expect{ FactoryGirl.create(:tag) }
      .to change{ Graph::Tag.count }.by(1)
  end

  it 'sets up relationships correctly' do
    tag = FactoryGirl.create(:tag, associated_recipes: 2)

    expect(tag.recipes.length).to eq(2)
  end
end
