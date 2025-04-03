class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reports = Report.all.order(created_at: :desc)
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user

    if @report.save
      redirect_to root_path, notice: "Post reported for review!"
    else
      redirect_to root_path, alert: "Could not report post."
    end
  end

  def destroy
    @report = Report.find(params[:id])
    if current_user.admin?
      @report.destroy
      redirect_to reports_path, notice: "Report removed."
    else
      redirect_to reports_path, alert: "Not authorized"
    end
  end

  private

  def report_params
    params.require(:report).permit(:post_id, :post_type, :reason)
  end
end
