class SessionsController < ApplicationController

  layout 'frontend_notice'

  def create
    response = GetUserFromOmniauth.(auth: request.env["omniauth.auth"])

    if response.success?
      @resource = response.user

      token = @resource.most_recent_token 'wfdinner-app'
      @token = token.value
      @client_id = token.client
      @expiry = token.expiry
      @uid = token.uid

      @auth_origin_url = generate_url('http://localhost:9292/#', {
        token:     @token,
        client_id: @client_id,
        uid:       @uid,
        expiry:    @expiry
      })

      flash[:notice] = 'Successfully logged in.'
      session[:user_id] = response.user.id
    else
      flash[:error] = 'Could not log in successfully.'
      redirect_to action: 'failure'
    end
  end

  def failure
    session[:user_id] = nil
    flash[:error] = 'Failed to authenticate.'
  end

  def destroy
    flash[:notice] = 'Successfully logged out.'
    session[:user_id] = nil
  end

  private

  def generate_url(url, params = {})
    auth_url = url

    # ensure that hash-bang is present BEFORE querystring for angularjs
    unless url.match(/#/)
      auth_url += '#'
    end

    # add query AFTER hash-bang
    auth_url += "?#{params.to_query}"

    return auth_url
  end

end
