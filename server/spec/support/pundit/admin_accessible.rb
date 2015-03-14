shared_examples_for 'admin accessible resource' do |policy_class|
  describe 'with an admin user' do
    let(:user) { FactoryGirl.build(:admin_user) }

    let(:policy) { policy_class.new(user, subject) }

    it 'can access the index' do
      expect(policy.index?).to be_truthy
    end

    it 'can access show' do
      subject.save
      expect(policy.show?).to be_truthy
    end

    it 'can access create' do
      expect(policy.create?).to be_truthy
    end

    it 'can access new' do
      expect(policy.new?).to be_truthy
    end

    it 'can access update' do
      expect(policy.update?).to be_truthy
    end

    it 'can access edit' do
      expect(policy.edit?).to be_truthy
    end

    it 'can access destroy' do
      expect(policy.destroy?).to be_truthy
    end
  end
end
