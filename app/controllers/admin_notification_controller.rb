class AdminNotificationController < ApplicationController
  layout 'admin_dashboard'
  def resolve_notification
    @request = AdminNotification.find(params[:request])
    @project = Project.find(@request.project_id)
    render 'admin_dashboard/solve_issue'
  end
  private
  def admin_notification_params
    params.require(:admin_notification).permit(:user_id,:admin_id,:message, :project,:type)
  end
end