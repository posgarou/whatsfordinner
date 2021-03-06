require_relative '../support/tokenable_examples'

describe User, type: :model do
  subject { FactoryGirl.build(:user) }

  is_and_acts_like 'Tokenable'

  it 'responds to its attribute methods' do
    is_expected.to respond_to(:name)
    is_expected.to respond_to(:email)
    is_expected.to respond_to(:provider)
    is_expected.to respond_to(:uid)
    is_expected.to respond_to(:oauth_token)
    is_expected.to respond_to(:oauth_expires_at)
  end

  describe 'token validity' do
    it 'expires tokens successfully' do
      expect { subject.expire_oauth_token! }
        .to change { subject.oauth_token }.to(nil)
    end

    describe 'with a valid token' do
      it 'denies the oauth token is expired when the date is in the present' do
        expect(subject.oauth_token_expired?).to be_falsey
        expect(subject.oauth_token_valid?).to be_truthy
      end
    end

    describe 'with no token' do
      subject { FactoryGirl.build(:user, :no_token) }

      it 'says that the oauth token is expired' do
        expect(subject.oauth_token_expired?).to be_truthy
        expect(subject.oauth_token_valid?).to be_falsey
      end
    end

    describe 'with an expired token' do
      subject { FactoryGirl.build(:user, :expired_token) }

      it 'says that the oauth token is expired' do
        expect(subject.oauth_token_expired?).to be_truthy
        expect(subject.oauth_token_valid?).to be_falsey
      end
    end
  end

  describe 'in interacting with Graph::User' do
    it 'creates a graph user when there is not one already' do
      expect { subject.graph_user }.to change { Graph::User.count }.from(0).to(1)
    end

    it 'returns the existing graph user when there is one already' do
      subject.graph_user

      expect { subject.graph_user }.not_to change { Graph::User.count }
    end
  end

  describe 'with roles' do
    it 'defaults to registered' do
      is_expected.not_to be_admin
      is_expected.to be_registered
      is_expected.not_to be_visitor
    end

    it 'can be both admin and registered' do
      subject.admin!

      is_expected.to be_admin
      is_expected.to be_registered
      is_expected.not_to be_visitor
    end
  end
end
