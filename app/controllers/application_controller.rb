class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token unless Rails.env.production?

  protected

  # Redirect to custom login page if not signed in
  def authenticate_user!
    unless user_signed_in?
      redirect_to email_login_path
    end
  end

  # After sign in, send to homepage
  def after_sign_in_path_for(resource)
    root_path
  end

  # After logout, send back to login
  def after_sign_out_path_for(resource_or_scope)
    email_login_path
  end
end