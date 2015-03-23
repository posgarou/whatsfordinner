require_relative '../../support/interactor_helper'

# TODO Expand this test suite

describe Selection::Confirmation do
  let(:rel) { create(:recipe_selected, :with_nodes) }
  let(:user) { rel.from_node }
  let(:recipe) { rel.to_node }
  let(:event_date) { rel.event_date }
  let(:was_made) { true }

  let(:interactor) { Selection::Confirmation.new(user: user, recipe: recipe, event_date: event_date, was_made: was_made) }
  let(:context) { interactor.context }

  subject(:res) do
    interactor.run
    context
  end

  is_and_acts_like 'a well-behaved interactor', :interactor

  context 'when passed all valid args' do
    it 'succeeds' do
      expect(res).to be_success
    end

    it 'sets was_made' do
      res

      expect(recipe.rels.count).to eq(1)
      expect(recipe.rels.first.was_made).to eq('y')
    end

    it 'sets event_date' do
      res

      expect(recipe.rels.count).to eq(1)
      expect(recipe.rels.first.date_confirmed).to_not be_nil
    end
  end
  #
  #   context 'when there is no RATED rel' do
  #     it 'returns nil' do
  #       expect(res.rating).to be_nil
  #     end
  #   end
  #
  #   context 'when there is a RATED rel' do
  #     before do
  #       Graph::RecipeInteractions::Rated.create(from_node: user, to_node: recipe, rating: 1)
  #     end
  #     it 'returns nil' do
  #       expect(res.rating).to eq(1)
  #     end
  #   end
  # end
  #
  # context 'when there is no user' do
  #   let(:user) { nil }
  #
  #   it 'the context fails' do
  #     expect(res).not_to be_success
  #     expect(res.error).to eq 'User is required'
  #   end
  # end
  #
  # context 'when there is no recipe' do
  #   let(:recipe) { nil }
  #
  #   it 'the context fails' do
  #     expect(res).not_to be_success
  #     expect(res.error).to eq 'Recipe is required'
  #   end
  # end
end
