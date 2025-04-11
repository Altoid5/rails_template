class FoundItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_user_disabled, only: [:new, :create]

  def index
    @found_items = FoundItem
      .includes(:user)
      .where(deleted: false)  # Only show non-deleted items
      .where(users: { disabled: [false, nil] })  # Only show items from non-disabled users
      .references(:users)
  end

  def show
    @found_item = FoundItem.find(params[:id])
    # Redirect if the item is deleted or the user is banned
    redirect_to found_items_path, alert: "This post is no longer available." if @found_item.deleted || @found_item.user.disabled?
  end

  def new
    @found_item = FoundItem.new
  end

  def create
    @found_item = FoundItem.new(found_item_params)
    @found_item.user = current_user
    if @found_item.save
      redirect_to @found_item, notice: "Found item reported successfully!"
    else
      render :new
    end
  end

  def edit
    @found_item = FoundItem.find(params[:id])
    redirect_to found_items_path, alert: "Not authorized" unless @found_item.user == current_user || @found_item.user.disabled?
  end

  def update
    @found_item = FoundItem.find(params[:id])
    if @found_item.user == current_user && @found_item.update(found_item_params)
      redirect_to @found_item, notice: "Found item updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @found_item = FoundItem.find(params[:id])
    if @found_item.user == current_user
      @found_item.update(deleted: true)  # Soft delete instead of destroying
      redirect_to found_items_path, notice: "Found item removed!"
    else
      redirect_to found_items_path, alert: "Not authorized"
    end
  end

  private

  def found_item_params
    params.require(:found_item).permit(:name, :description, :location, :category, :claimed)
  end  

  def check_user_disabled
    if current_user.disabled?
      redirect_to root_path, alert: "Your account has been disabled."
    end
  end
end