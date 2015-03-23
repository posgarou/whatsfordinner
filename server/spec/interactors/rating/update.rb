require_relative '../../support/interactor_helper'

describe Rating::Update do
  let(:user) { create(:graph_user) }
  let(:recipe) { create(:recipe) }
  let(:rating) { 0 }
  let(:resultant_rating) { user.rated_recipes.first_rel_to(recipe) }

  let(:interactor) { Rating::Update.new(user: user, recipe: recipe, rating: rating) }
  let(:context) { interactor.context }

  subject(:res) do
    interactor.run
    context
  end

  is_and_acts_like 'a well-behaved interactor', :interactor

  context 'when passed a valid user, recipe, and rating' do
    it 'succeeds' do
      expect(res).to be_success
    end

    it 'modifies the rating' do
      res

      expect(resultant_rating.rating).to eq(rating)
    end
  end

  context 'when there is already a rating' do
    before do
      create(:recipe_rated, :like, from_node: user, to_node: recipe)
    end

    it 'changes the current recipe rating' do
      expect { res }.to change { user.rated_recipes.first_rel_to(recipe).rating }.from(1).to(0)
    end
  end

  context 'when there is no user' do
    let(:user) { nil }

    it 'the context fails' do
      expect(res).not_to be_success
      expect(res.error).to eq 'User is required'
    end
  end

  context 'when there is no recipe' do
    let(:recipe) { nil }

    it 'the context fails' do
      expect(res).not_to be_success
      expect(res.error).to eq 'Recipe is required'
    end
  end

  context 'when there is no rating' do
    let(:rating) { nil }

    it 'the context fails' do
      expect(res).not_to be_success
      expect(res.error).to eq 'Rating is required'
    end
  end

  context 'when there is a non-numeric rating' do
    let(:rating) { 'five stars' }

    it 'the context fails' do
      expect(res).not_to be_success
      expect(res.error).to eq 'Rating must be 0, 1, or -1'
    end
  end

  context 'when there is a rating outside of bounds' do
    let(:rating) { 2 }

    it 'the context fails' do
      expect(res).not_to be_success
      expect(res.error).to eq 'Rating must be 0, 1, or -1'
    end
  end
end
