describe Concierge do
  subject(:result) { Concierge.(user: create(:user) )}

  describe 'when there are two recipes' do
    before do
      2.times { create(:recipe) }
    end

    it 'returns two recipes' do
      expect(result.suggestions.length).to eq(2)
    end
  end

  describe 'when there are three recipes' do
    before do
      3.times { create(:recipe) }
    end

    it 'returns three recipes' do
      expect(result.suggestions.length).to eq(3)
    end
  end

  describe 'when there are four recipes' do
    before do
      4.times { create(:recipe) }
    end

    it 'returns three recipes' do
      expect(result.suggestions.length).to eq(3)
    end
  end
end
