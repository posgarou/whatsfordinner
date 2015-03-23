require_relative '../../support/interactor_helper'

describe Rating::NeedsRating do
  let(:user) { create(:graph_user) }
  let(:recipe) { create(:recipe) }

  let(:interactor) { Rating::NeedsRating.new(user: user) }
  let(:context) { interactor.context }

  subject(:res) do
    interactor.run
    context
  end

  is_and_acts_like 'a well-behaved interactor', :interactor

  context 'when passed a valid user' do
    it 'succeeds' do
      expect(res).to be_success
    end
  end

  context 'when the user has no SELECTED recipes' do
    before do
      1.times { create(:recipe) }
    end

    it 'succeeds' do
      expect(res).to be_success
    end

    it 'returns an empty array for recipes_needing_rating' do
      expect(res.recipes_needing_rating).to be_empty
    end
  end

  context 'when the user has 2 SELECTED recipes' do
    before do
      2.times { create(:recipe_selected, from_node: user, to_node: create(:recipe)) }
    end

    it 'succeeds' do
      expect(res).to be_success
    end

    it 'returns two recipes_needing_rating' do
      expect(res.recipes_needing_rating.length).to eq(2)
    end

    context 'when 1 of the is RATED' do
      before do
        create(:recipe_rated, :meh, from_node: user, to_node: Graph::Recipe.first)
      end

      it 'returns 1 recipes_needing_rating' do
        expect(Graph::Recipe.count).to eq(2)
        expect(res.recipes_needing_rating.length).to eq(1)
      end
    end
  end

  context 'when there is no user' do
    let(:user) { nil }

    it 'the context fails' do
      expect(res).not_to be_success
      expect(res.error).to eq 'User is required'
    end
  end

end
