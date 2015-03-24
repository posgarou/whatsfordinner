require_relative '../../support/interactor_helper'

describe MetaAnalysis::DetermineCentrality do
  let(:node) { create(:tag) }
  let(:interactor) { MetaAnalysis::DetermineCentrality.new(node: node) }
  let(:context) { interactor.context }

  subject(:res) do
    interactor.run
    context
  end

  is_and_acts_like 'a well-behaved interactor', :interactor

  describe 'determination of context' do
    describe 'when node has 0 attached nodes' do
      let(:node) { create(:tag) }

      it 'returns 0' do
        expect(res).to be_success
        expect(res.centrality_query.first[:centrality]).to eq(0)
      end
    end

    describe 'when node has 2 attached nodes' do
      let(:node) { create(:tag, associated_recipes: 2) }

      it 'returns 2 when node has 2 attached nodes' do
        expect(res).to be_success
        expect(res.centrality_query.first[:centrality]).to eq(2)
      end
    end
  end

  context 'when there is no node' do
    let(:node) { nil }

    it 'fails' do
      expect(res).not_to be_success
      expect(res.error).to eq 'Node is required'
    end
  end
end
