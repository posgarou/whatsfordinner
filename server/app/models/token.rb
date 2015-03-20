class Token
  include Mongoid::Document

  field :value, type: String
  field :used_at, type: Time
  field :invalid_at, type: Time
  # == device, e.g.
  field :client, type: String

  embedded_in :tokenable, polymorphic: true

  after_initialize do
    unless persisted?
      self.value = SecureRandom.urlsafe_base64
      self.invalid_at = 2.weeks.from_now
    end
  end

  def expire!
    self.used_at = Time.now
  end

  def uid
    @uid ||= tokenable.uid
  end

  # Convert invalid_at to Unix time (since epoch) for easy JS consumption
  def expiry
    invalid_at.to_f.to_s
  end

  # A putative token is valid if
  #   - it matches the value and
  #   - the current token is not stale
  # Moreover, if putative is valid, we also expire the token for future use.
  def validate putative, putative_client
    is_valid = (value == putative && client == putative_client && !stale?)

    expire! if is_valid

    is_valid
  end

  # A token is stale
  #   - if it has been used and the used_at time was more than 5 seconds ago
  #   - if it has not been used but the invalid_at date is in the past
  def stale?
    used_too_long_ago? || past_date?
  end

  def past_date?
    invalid_at < Time.now
  end

  def used_too_long_ago?
    used_at.present? && Time.now - used_at > 5
  end
end
