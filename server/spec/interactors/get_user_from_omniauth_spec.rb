shared_examples 'a GetUserFromOmniauth' do
  include OmniauthHelper

  let(:interactor) { GetUserFromOmniauth.new(auth: auth_hash) }

  subject { interactor }

  it 'creates a user where one did not previously exist' do
    expect { subject.run }.to change { User.count }.by(1)
  end

  it 'returns a user where one did previously exist' do
    user.save!
    expect { subject.run }.not_to change { User.count }
  end

  describe 'with invalid input' do

    context 'e.g. empty input' do
      let(:auth_hash) { {} }


      it 'fails the context' do
        subject.run
        expect(subject.context.success?).to be_falsey
      end
    end

    context 'e.g. input missing a required field' do

      let(:auth_hash) { {} }

      it 'fails the context' do
        subject.run
        expect(subject.context.success?).to be_falsey
      end
    end
  end

  describe 'in saving user attributes' do

    it 'has all of its attributes defined' do
      user.delete
      interactor.run

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
