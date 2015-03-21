require_relative '../../support/interactor_helper'

describe Rating::Determine do
  let(:user) { create(:graph_user) }
  let(:recipe) { create(:recipe) }

  let(:interactor) { Rating::Determine.new(user: user, recipe: recipe) }
  let(:context) { interactor.context }

  subject(:res) do
    interactor.run
    context
  end

  is_and_acts_like 'a well-behaved interactor', :interactor

  context 'when passed a valid user and recipe' do
    it 'succeeds' do
      expect(res).to be_success
    end

    context 'when there is no RATED rel' do
      it 'returns nil' do
        expect(res.rating).to be_nil
      end
    end

    context 'when there is a RATED rel' do
      before do
        Graph::RecipeInteractions::Rated.create(from_node: user, to_node: recipe, rating: 1)
      end
      it 'returns nil' do
        expect(res.rating).to eq(1)
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

  context 'when there is no recipe' do
    let(:recipe) { nil }

    it 'the context fails' do
      expect(res).not_to be_success
      expect(res.error).to eq 'Recipe is required'
    end
  end
end
