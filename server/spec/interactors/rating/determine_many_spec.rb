require_relative '../../support/interactor_helper'

describe Rating::DetermineMany do
  let(:user) { create(:graph_user) }
  let(:recipes) { [create(:recipe)] }

  let(:interactor) { Rating::DetermineMany.new(user: user, recipes: recipes) }
  let(:context) { interactor.context }

  subject(:res) do
    interactor.run
    context
  end

  is_and_acts_like 'a well-behaved interactor', :interactor

  context 'when passed a valid user and recipes' do
    it 'succeeds' do
      expect(res).to be_success
    end

    context 'when passed no recipes' do
      let(:recipes) { [] }

      it 'succeeds' do
        expect(res).to be_success
      end

      it 'returns an empty rating set' do
        expect(res.ratings).to eq({})
      end
    end

    context 'when there is no RATED rel' do
      it 'returns nil for each recipe' do
        expect(res.ratings.values.uniq).to eq([nil])
      end
    end

    context 'when there is a RATED rel' do
      let(:recipe) { recipes.first }
      before do
        Graph::RecipeInteractions::Rated.create(from_node: user, to_node: recipe, rating: 1)
      end
      it 'returns nil' do
        expect(res.ratings[recipe]).to eq(1)
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

  context 'when there is no recipes field' do
    let(:recipes) { nil }

    it 'the context fails' do
      expect(res).not_to be_success
      expect(res.error).to eq 'Recipes is required'
    end
  end
end
