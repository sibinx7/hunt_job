class DashboardController < ApplicationController

  before_action :authenticate_user!


  def index
    @notification = Notification.where(:user_id => current_user.id).order('created_at DESC').limit(10)
    @user = User.find(current_user.id)
  end

  def users
  end

  def user
  end

  def projects
    @skills = params[:skills]
    @search_keyword = params[:search_keyword]
    @min_range = params[:min_range]
    @max_range = params[:max_range]
    @min_budget = Project.minimum(:min_budget)
    @max_budget = Project.maximum(:max_budget)
    puts @skills.inspect
    puts @search_keyword.inspect
    puts @max_range.inspect
    puts @min_range.inspect
    if @skills == nil && @search_keyword == nil && @min_budget == nil && @max_budget == nil
      @projects = Project.paginate(:page => params[:page],:per_page => 10).where(:close=>nil, :status => nil).order('created_at DESC')
    else
      @projects = Project.paginate(:page => params[:page],:per_page => 10).where(:close=>nil, :status => nil)
      if @skills != nil && @skills != ""
        @skills_text = @skills
        @skills = @skills.split(',')
        @projects = @projects.includes(:skills).where('skills.name IN (?)',@skills).references(:skills)
      end
      if @search_keyword != nil && @search_keyword != ""
        @projects = @projects.where("title LIKE ?","%#{@search_keyword}%")
      end
      if @min_range != nil
        @projects = @projects.where("min_budget >= ?",@min_range)
      end
      if @max_range != nil
        @projects = @projects.where("max_budget <= ?",@max_range)
      end
      @projects = @projects.order('created_at DESC')
    end
  end

  def project
    @project = Project.find(params[:project])
    @project_owner = User.find(@project.creator)
    @project_bids  = @project.bids
    @project_bid_users = Array.new  
    @project_bids.each_with_index  do |f,index|
      @project_bid_users[index] = User.find(f.user_id)
      if f.user_id == current_user.id
        @i_bid = true
      end
    end
  end

  def user_profile

  end
  def settings
  end


  def bid
    @project = Project.find(params[:project])
    @project_owner = User.find(@project.creator)
    @bid = Bid.new
  end

  def edit_bid
    @project = Project.find(params[:project])
    @project_owner = User.find(@project.creator)
    @bid = Bid.find(params[:bid])
  end

  def payments

  end


  def pending_projects
    @project = Project.where('status' => 0,'assigned_to' => current_user.id).paginate(:per_page=>10,:page=>params[:page])

  end

  def timeline
    @notifications = Notification.where(:user_id => current_user.id.to_i).order('created_at DESC').paginate(:page => params[:page],:per_page => 15)
    puts @notifications.inspect
  end

  def projects_history
    @projects = Project.where(:assigned_to => current_user.id.to_i, :close => true).paginate(:per_page=>10,:page=>params[:page])
  end

  def my_status

  end

  def request_admin
    if current_user.id.to_i == params[:user].to_i
      @admin_notification = AdminNotification.new
      @admin_notification.user_id = current_user.id
      @admin_notification.message = params[:message]
      @admin_notification.category = "request"
      @admin_notification.project = params[:project]
      if @admin_notification.save
        render json: {:message =>"Saved",:status => "success"}
      else
        render json: {:message =>"Message failed",:status => "fail"}
      end
    end
  end
end
