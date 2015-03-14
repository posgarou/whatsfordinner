FactoryGirl.define do
  sequence :unique_name do |n|
    "name#{n}"
  end
end
