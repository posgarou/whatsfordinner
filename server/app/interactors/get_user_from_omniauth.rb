class GetUserFromOmniauth
  include Interactor

  def call
    auth = context.auth

    if auth.respond_to?(:slice)
      begin
        context.user = User.where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.name ||= auth.info.name
          user.email ||= auth.info.email
          user.image_url ||= auth.info.image
          user.oauth_token = auth.credentials.token
          user.oauth_expires_at = Time.at(auth.credentials.expires_at)
          user.save!
        end
      rescue NoMethodError
        context.fail!(error: 'Not all required OmniAuth fields were present.')
      end
    else
      context.fail!(error: 'No valid OmniAuth response was received.')
    end
  end

end
