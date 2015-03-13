# General purpose test helpers.
module Helpers
  def expect_attribute_present(subject, attribute)
    expect(subject.send(attribute.to_sym)).to be_present
  end

  def expect_attributes_present(subject, *attributes)
    attributes.each do |attribute|
      expect_attribute_present(subject, attribute)
    end
  end
end
