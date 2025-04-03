class FoundItemsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @found_items = FoundItem.all
  end

  def show
    @found_item = FoundItem.find(params[:id])
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
    redirect_to found_items_path, alert: "Not authorized" unless @found_item.user == current_user
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
      @found_item.destroy
      redirect_to found_items_path, notice: "Found item removed!"
    else
      redirect_to found_items_path, alert: "Not authorized"
    end
  end

  private

  def found_item_params
    params.require(:found_item).permit(:name, :description, :location, :category, :claimed)
  end
end
