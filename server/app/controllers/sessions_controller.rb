class SessionsController < ApplicationController

  layout :frontend_notice

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    flash[:notice] = 'Successfully logged in.'
    session[:user_id] = user.id
  end

  def failure
    session[:user_id] = nil
    flash[:error] = 'Failed to authenticate.'
  end

  def destory
    flash[:notice] = 'Successfully logged out.'
    session[:user_id] = nil
  end

end