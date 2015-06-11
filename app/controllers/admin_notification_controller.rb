class AdminNotificationController < ApplicationController
  layout 'admin_dashboard'
  def resolve_notification
    @request = AdminNotification.find(params[:request])
    @project = Project.find(@request.project_id)
    user_array = Array.new
    index_array_counter = 0
    @project.skills.each_with_index  do |skill,main|
      get_users = Skill.find_by_name(skill.name).users
      if params[:sort] == "high_rated"
        get_users = get_users.where("users.user_rating IS NOT NULL").order(user_rating: :desc)
      elsif params[:sort] == "new_users"
        get_users = get_users.order(created_at: :desc)
      elsif params[:sort] == "popular_users"
        get_users = get_users.select('*').joins("INNER JOIN user_project_details upd ON upd.user_id = users.id").order("upd.project_completed desc")
      else
      end
      get_users = get_users.limit(12)
      get_users.each_with_index do |user,index|
        user_array[index_array_counter] = user
        index_array_counter = index_array_counter + 1
      end
    end
    @user_array = user_array.uniq
    render 'admin_dashboard/solve_issue'
  end

  def recommend_users
    
  end
  private
  def admin_notification_params
    params.require(:admin_notification).permit(:user_id,:admin_id,:message, :project,:type)
  end
end