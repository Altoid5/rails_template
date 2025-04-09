class SessionsController < ApplicationController
  def guest
    session[:guest] = true
    redirect_to root_path, notice: 'Logged in as guest.'
  end
end