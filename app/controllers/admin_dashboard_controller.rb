class AdminDashboardController < ApplicationController
  layout 'admin_dashboard'

  before_action :authenticate_admin!
  def index
    @total_project = Project.all.count
    @total_users   = User.all.count
    @last_five_project = Project.limit(5).order(created_at: :desc)
  end

  def projects
    if params[:sort] == nil || params[:sort] == ""
      @projects = Project.paginate(:page=>params[:page],:per_page=>2)
    else
      @projects = Project.paginate(:page=>params[:page],:per_page=>2)
      if params[:sort] == "all"
        @projects = @projects
      elsif params[:sort] == "completed"
        @projects = @projects.where(:status=> 1)
      elsif params[:sort] == "lost"
        @projects = @projects.where(:status => 2)
      elsif params[:sort] == "pending"
        @projects = @projects.where(:assigned_to => nil , :status => nil)
      elsif params[:sort] == "ongoing"
        @projects = @projects.where(:status => 0)
      end
    end
  end
  # Show project
  # @params = project id
  def project
    @project = Project.find(params[:project_id])
  end
  # User database
  def user_database
    @users_database = User
    if params[:sort] == "high-rated"
      @users_database = @users_database.order(user_rating: :desc)
    elsif params[:sort] == "popular"
      @users_database = @users_database.select('*').joins("INNER JOIN user_project_details upd ON upd.user_id = users.id").order("upd.project_completed desc")
    elsif params[:sort]  == "new"
      @users_database = @users_database.order(created_at: :desc)
    elsif params[:sort] == "all" || params[:sort] == nil
      @users_database = @users_database
    end
    @users_database = @users_database.paginate(:page=>params[:page],:per_page=>2)
  end

  def notifications
    @notifications = AdminNotification.paginate(:page=> params[:page],:per_page=>2)
  end

  def settings

  end


end
