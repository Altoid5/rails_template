class LostItemsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @lost_items = LostItem.all
  end

  def show
    @lost_item = LostItem.find(params[:id])
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
    redirect_to lost_items_path, alert: "Not authorized" unless @lost_item.user == current_user
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
      @lost_item.destroy
      redirect_to lost_items_path, notice: "Lost item removed!"
    else
      redirect_to lost_items_path, alert: "Not authorized"
    end
  end

  private

  def lost_item_params
    params.require(:lost_item).permit(:name, :description, :location, :category, :lost_date, :image)
  end  
end
