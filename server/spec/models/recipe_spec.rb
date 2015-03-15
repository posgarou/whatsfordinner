describe Graph::Recipe do
  subject { FactoryGirl.create(:recipe, :with_tags, :with_ingredients) }

  it 'has tags' do
    expect(subject.tags).not_to be_empty
  end

  it 'has ingredients' do
    expect(subject.ingredients).not_to be_empty
  end

  describe 'render ingredients' do
    it 'renders a list containing string representations' do
      rendered_ingredients = subject.render_ingredients

      expect(rendered_ingredients).not_to be_empty
      expect(rendered_ingredients).to all(match(/One/))
    end
  end
end
