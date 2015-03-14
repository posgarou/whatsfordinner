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

  describe 'prune_tokens' do
    before do
      Timecop.freeze(Time.now)
      FactoryGirl.build(:token, tokenable: subject)
    end

    after do
      Timecop.return
    end

    it 'does not prune still valid tokens' do
      expect { subject.prune_tokens }.not_to change { subject.tokens.length }
    end

    it 'prunes stale tokens' do
      Timecop.travel 1.month.from_now
      FactoryGirl.build(:token, tokenable: subject)

      expect { subject.prune_tokens }.to change { subject.tokens.length }.from(2).to(1)
    end
  end

  describe 'new_token_for' do
    before do
      # If we don't save the subject, we can't save the embedded child
      
      subject.save
    end

    let(:client) { 'fooClient' }

    it 'adds a new token' do
      expect { subject.new_token_for(client) }.to change { subject.tokens.count }.from(0).to(1)
    end
  end
end
