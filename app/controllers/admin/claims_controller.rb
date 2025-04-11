class Admin::ClaimsController < Admin::BaseController
  before_action :set_claim, only: [:approve, :reject]

  def approve
    @claim.update(status: "approved")
    @claim.found_item.update(deleted: true) if @claim.found_item.present?
    Notification.create(user: @claim.user, message: "Your claim has been approved")
    redirect_to admin_dashboard_path, notice: "Claim approved"
  end

  def reject
    @claim.update(status: "rejected")
    Notification.create(user: @claim.user, message: "Your claim was rejected")
    redirect_to admin_dashboard_path, notice: "Claim rejected"
  end

  
  private

  def set_claim
    @claim = Claim.find(params[:id])
  end
end