describe Graph::User do
  subject { FactoryGirl.create(:graph_user) }

  it 'relates to a standard user' do
    expect(subject.standard_user).not_to be_nil
  end
end
