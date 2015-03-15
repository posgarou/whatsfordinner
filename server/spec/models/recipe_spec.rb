describe Graph::Recipe do
  subject { FactoryGirl.create(:recipe, :with_tags, :with_ingredients) }

  it 'has tags' do
    expect(subject.tags).not_to be_empty
  end

  it 'has ingredients' do
    expect(subject.ingredients).not_to be_empty
  end
end
