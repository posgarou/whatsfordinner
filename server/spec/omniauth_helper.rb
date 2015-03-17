# Helpers to ease testing of OmniAuth.
module OmniauthHelper
  def auth_hash
    Hashie::Mash.new({
      provider: user.provider,
      uid: user.uid,
      info: {
        name: user.name,
        email: user.email,
        image: user.image_url
      },
      credentials: {
        token: user.oauth_token,
        expires_at: user.oauth_expires_at
      }
    })
  end
end
