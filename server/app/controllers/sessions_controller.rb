class SessionsController < ApplicationController

  layout 'frontend_notice'

  def create
    response = GetUserFromOmniauth.(auth: request.env["omniauth.auth"])

    if response.success?
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

end