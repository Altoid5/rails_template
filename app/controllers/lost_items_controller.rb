class LostItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_user_disabled, only: [:new, :create]

  def index
    @lost_items = LostItem
      .includes(:user)
      .where(deleted: false)
      .where(users: { disabled: [false, nil] })  # Only show items from non-disabled users
      .references(:users)
  end

  def show
    @lost_item = LostItem.find(params[:id])
    redirect_to lost_items_path, alert: "This post is no longer available." if @lost_item.deleted || @lost_item.user.disabled?
  end

  def new
    @lost_item = LostItem.new
    @lost_item.location = params[:location] if params[:location].present?
  end

  def create
    @lost_item = LostItem.new(lost_item_params)
    @lost_item.user = current_user
    if @lost_item.save
      redirect_to @lost_item, notice: "Lost item reported successfully!"
    else
      render :new
    end
  end

  def edit
    @lost_item = LostItem.find(params[:id])
    redirect_to lost_items_path, alert: "Not authorized" unless @lost_item.user == current_user || @lost_item.user.disabled?
  end

  def update
    @lost_item = LostItem.find(params[:id])
    if @lost_item.user == current_user && @lost_item.update(lost_item_params)
      redirect_to @lost_item, notice: "Lost item updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @lost_item = LostItem.find(params[:id])
    if @lost_item.user == current_user
      @lost_item.update(deleted: true)  # Instead of destroying, mark as deleted
      redirect_to lost_items_path, notice: "Lost item removed!"
    else
      redirect_to lost_items_path, alert: "Not authorized"
    end
  end

  private

  def lost_item_params
    params.require(:lost_item).permit(:name, :description, :location, :category, :lost_date, :image)
  end  

  def check_user_disabled
    if current_user.disabled?
      redirect_to root_path, alert: "Your account has been disabled."
    end
  end
end
