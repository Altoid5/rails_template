class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(user: current_user).order(created_at: :desc)
  end

  def destroy
    @notification = Notification.find(params[:id])
    if @notification.user == current_user
      @notification.destroy
      redirect_to notifications_path, notice: "Notification dismissed."
    else
      redirect_to notifications_path, alert: "Not authorized"
    end
  end
end
