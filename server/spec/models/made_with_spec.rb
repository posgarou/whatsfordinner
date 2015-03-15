describe Graph::MadeWith do
  shared_examples_for 'required or optional' do |string|
    it 'does not add (optional) when required' do
      expect(subject.render).to eq(string)
    end
    it 'adds (optional) when optional' do
      subject.required = false

      expect(subject.render).to eq("#{string} (optional)")
    end
  end

  describe 'with a quantity but no unit' do
    context 'of one' do
      subject { build(:made_with, :one)}

      is_and_acts_like 'required or optional', 'One sugar'
    end

    context 'of two' do
      subject { build(:made_with, :two)}

      is_and_acts_like 'required or optional', '2 sugar'
    end

    context 'of 2.5' do
      subject { build(:made_with, quantity: 2.5)}

      is_and_acts_like 'required or optional', '2.5 sugar'
    end
  end

  describe 'with a unit but no quantity' do
    context 'of 3 mg' do
      subject { build(:made_with, unit_quantity: 3, unit_type:'mg')}

      is_and_acts_like 'required or optional', '3 mg sugar'
    end
  end

  describe 'with a quantity and a unit' do
    context 'of 2 15 oz sugar' do
      subject { build(:made_with, :two, unit_quantity: 15, unit_type:'oz')}

      is_and_acts_like 'required or optional', '2 15 oz sugar'
    end
  end
end
