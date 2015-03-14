# Testing Mongoid embedded documents (especially with polymorphic containing
# documents) can be difficult.
#
# TokenableStub is a simple container class for Token.
class TokenableStub
  include Mongoid::Document

  embeds_many :tokens, as: :tokenable
end
