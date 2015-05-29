class AdminDashboardController < ApplicationController
  layout 'admin_dashboard'
  def index

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

  # User database
  def user_database
    @users_database = User.paginate(:page=>params[:page],:per_page=>2)
  end
end
