require_relative '../stubs/tokenable_stub'

describe Token do
  before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  # We need to setup the subject before we Timecop#travel
  subject! { FactoryGirl.build(:token) }

  it 'grabs the embedding document\'s uid' do
    expect(subject.uid).to eq(subject.tokenable.uid)
  end

  describe 'past_date?' do
    it 'is false for today' do
      is_expected.not_to be_past_date
    end

    it 'is false for a week from now' do
      Timecop.travel(1.week.from_now)
      is_expected.not_to be_past_date
    end

    it 'is true for two weeks from now' do
      Timecop.travel(2.weeks.from_now + 1.second)
      is_expected.to be_past_date
    end
  end

  describe 'being used' do
    context 'with a correct token match' do
      let!(:validation) { subject.validate(subject.value, 'client') }

      it 'returns true' do
        expect(validation).to be_truthy
      end

      it 'sets invalid_at when validated' do
        expect(subject.used_at).to eq(Time.now)
      end

      it 'allows the same token to be used within five seconds' do
        Timecop.travel(4.seconds.from_now)
        is_expected.not_to be_stale
      end

      it 'rejects the token after 5 or more seconds' do
        Timecop.travel(5.seconds.from_now)
        is_expected.to be_stale
      end
    end

    context 'with an incorrect token match' do
      let!(:validation) { subject.validate "#{subject.value}+", 'client' }

      it 'returns false' do
        expect(validation).to be_falsey
      end

      it 'does not set used_at' do
        expect(subject.used_at).to be_nil
      end
    end

    context 'with an correct token match but wrong client' do
      let!(:validation) { subject.validate(subject.value, 'client+') }

      it 'returns false' do
        expect(validation).to be_falsey
      end

      it 'does not set used_at' do
        expect(subject.used_at).to be_nil
      end
    end
  end
end
