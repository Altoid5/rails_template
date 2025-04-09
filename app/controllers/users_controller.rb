class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @lost_item = LostItem.new
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(@user), alert: "Not authorized" unless @user == current_user
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user && @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      @user.destroy
      redirect_to root_path, notice: "Account deactivated."
    else
      redirect_to root_path, alert: "Not authorized"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :profile_image)
  end
end
