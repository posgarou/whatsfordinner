shared_examples 'a GetUserFromOmniauth' do
  let(:auth) do
    Hashie::Mash.new({
      provider: user.provider,
      uid: user.uid,
      info: {
         name: user.name,
         email: user.email,
         image: user.image_url
      },
      credentials: {
         token: user.oauth_token,
         expires_at: user.oauth_expires_at
      }
    })
  end

  let(:interactor) { GetUserFromOmniauth.new(auth: auth) }

  subject { interactor }

  it 'creates a user where one did not previously exist' do
    expect { subject.call }.to change { User.count }.from(0).to(1)
  end

  it 'returns a user where one did previously exist' do
    user.save!
    expect { subject.call }.not_to change { User.count }
  end

  describe 'in saving user attributes' do

    it 'has all of its attributes defined' do
      user.delete
      interactor.call

      expect_attributes_present(
          interactor.context.user,
          :provider,
          :uid,
          :name,
          :email,
          :image_url,
          :oauth_token,
          :oauth_expires_at
      )
    end
  end
end

describe GetUserFromOmniauth do
  describe 'with a google account' do
    let(:user) { FactoryGirl.build(:user) }

    it_behaves_like "a GetUserFromOmniauth"
  end

  describe 'with a facebook account' do
    let(:user) { FactoryGirl.build(:user, :facebook) }

    it_behaves_like "a GetUserFromOmniauth"
  end
end