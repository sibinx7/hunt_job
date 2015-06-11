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
    # Don't set anything automatically, just send a notification
    @user_info = User.find(params[:user_id])
    @project_info = Project.find(params[:project_id])

    @user_notification = Notification.new
    @user_notification.title = "Congratulations! We have recommend <b>#{@project_info.title}</b> for you."
    @user_notification.not_type = "project"
    @user_notification.user_id  = @user_info.id
    @user_notification.project_id = @project_info.id
    @user_notification.related_task = nil
    @user_notification.content = "<p>Project creator ask our help find a good Freelancer for him. We have selected as Freelancer. Project name is <a href='#{url_for(:controller => 'dashboard',:action => 'project',:project=>@project_info.id)}'>#{@project_info.title}</a>, You can check more details on Project
    Page.</p><p> This is only a recommendation based on your performance, You can either accept or drop Project</p>
    <p> Thanks you <br/> Admin</p>"
    @user_notification.link = "#{url_for(:controller => 'dashboard',:action => 'project',:project=> @project_info.id )}"
    if @user_notification.save
      render :json => {'status' => 'success','message'=>"Successfullt send Notifications"}
    else
      render :json => {'status' => 'failed','message'=>"Unknown error occured."}
    end
  end
  private
  def admin_notification_params
    params.require(:admin_notification).permit(:user_id,:admin_id,:message, :project,:type)
  end
end