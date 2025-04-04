class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token unless Rails.env.production?

  protected

  def authenticate_user!
    unless user_signed_in?
      redirect_to email_login_path
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    email_login_path
  end
end