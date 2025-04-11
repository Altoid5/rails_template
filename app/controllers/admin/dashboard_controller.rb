module Admin
  class DashboardController < Admin::BaseController
    def index
      # Fetch reported lost and found items (with non-deleted status)
      @reported_lost_items = LostItem.where(deleted: false)
      @reported_found_items = FoundItem.where(deleted: false)

      # Combine the lost and found items and remove duplicates based on user_id
      @reported_items = (@reported_lost_items + @reported_found_items).group_by(&:user_id).map { |user_id, items| items.first }

      # Fetch pending claims
      @pending_claims = Claim.where(status: "pending")
      @banned_users = User.where(disabled: true)
    end
  end 
end