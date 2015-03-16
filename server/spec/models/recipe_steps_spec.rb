describe Graph::RecipeStep do
  subject { build(:recipe_step) }

  it 'is required by default' do
    is_expected.not_to be_optional
  end

  it 'can be made optional' do
    subject.optional = true

    is_expected.to be_optional
  end

  it 'responds to #recipe' do
    is_expected.to respond_to(:recipe)
  end
end
