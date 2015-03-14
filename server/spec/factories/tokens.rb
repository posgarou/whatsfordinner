require_relative '../stubs/tokenable_stub'

FactoryGirl.define do
  factory :token, class: Token do
    tokenable { TokenableStub.new }
    client 'client'
  end
end
