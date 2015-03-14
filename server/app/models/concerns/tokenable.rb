module Tokenable
  extend ActiveSupport::Concern

  included do
    embeds_many :tokens, as: :tokenable
  end

  # Check whether +putative+ matches any of the model's tokens.
  def validate putative, putative_client
    tokens.any? &:validate.with(putative, putative_client)
  end

  # Generate a new token for the given client device.
  def new_token_for client
    self.tokens.create(client: client)
  end

  # Delete all stale tokens
  def prune_tokens

  end
end
