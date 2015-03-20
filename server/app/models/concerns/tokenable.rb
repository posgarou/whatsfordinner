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

  # Return the last-created token for a given client
  def most_recent_token client
    self.tokens.where(client: client).desc(:invalid_at).limit(1).first \
      || new_token_for(client)
  end

  # Delete all stale tokens
  def prune_tokens
    tokens.select(&:stale?).map(&:delete)
  end

  def token_validation_response
    self.as_json(except: [
        :tokens, :created_at, :updated_at
      ])
  end
end
