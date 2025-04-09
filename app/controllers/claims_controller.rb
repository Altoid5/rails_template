class ClaimsController < ApplicationController
  before_action :authenticate_user!

  def index
    @claims = Claim.where(user: current_user)
  end

  def create
    @found_item = FoundItem.find(params[:found_item_id])
    existing_claim = Claim.find_by(user: current_user, found_item: @found_item)

    if existing_claim
      redirect_to found_items_path, alert: "You have already claimed this item."
      return
    end

    @claim = @found_item.claims.build(
      user: current_user,
      answer: params[:answer],
      proof_provided: true, # or false if not using it
      status: "pending"
    )

    if @claim.save
      redirect_to found_items_path, notice: "Claim submitted for review!"
    else
      redirect_to found_items_path, alert: "Could not submit claim."
    end
  end

  def destroy
    @claim = Claim.find(params[:id])
    if @claim.user == current_user
      @claim.destroy
      redirect_to claims_path, notice: "Claim removed."
    else
      redirect_to claims_path, alert: "Not authorized"
    end
  end
end