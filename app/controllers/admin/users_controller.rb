module Admin
  class UsersController < Admin::BaseController
    def ban
      user = User.find(params[:id])
      user.update(disabled: true)

      user.lost_items.update_all(deleted: true)
      user.found_items.update_all(deleted: true)

      redirect_to admin_dashboard_path, notice: "User has been banned and their posts removed."
    end

    def unban
      user = User.find(params[:id])
      user.update(disabled: false)

      redirect_to admin_dashboard_path, notice: "User has been unbanned."
    end
  end
end