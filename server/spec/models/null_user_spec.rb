describe User::NullUser do
  subject { User::NullUser.new }

  it 'defaults to the visitor role' do
    is_expected.not_to be_admin
    is_expected.not_to be_registered
    is_expected.to be_visitor
  end
end
