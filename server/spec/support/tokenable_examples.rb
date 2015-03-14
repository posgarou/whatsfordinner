# An example set for classes that include Tokenable

shared_examples_for 'Tokenable' do
  it 'has an empty set of tokens initially' do
    expect(subject.tokens).to be_empty
  end

  describe 'validate' do
    before do
      FactoryGirl.build(:token, tokenable: subject)
    end

    it 'should say that its token is valid right now' do
      expect(subject.validate(subject.tokens.first.value, 'client')).to be_truthy
    end

    it 'should say that no token is valid if the client is wrong' do
      expect(subject.validate(subject.tokens.first.value, 'client+')).to be_falsey
    end

    it 'should validate both tokens when it has two' do
      FactoryGirl.build(:token, tokenable: subject)

      expect(subject.validate(subject.tokens.first.value, 'client')).to be_truthy
      expect(subject.validate(subject.tokens.last.value, 'client')).to be_truthy
    end

    it 'should say a non-existent token is invalid' do
      expect(subject.validate(' ', 'client')).to be_falsey
    end
  end
end
