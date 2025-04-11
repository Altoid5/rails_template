class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  private

  def require_admin
    unless current_user&.role == "admin"
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
  end
end