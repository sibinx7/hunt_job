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
    if @skills =="" && @search_keyword == "" && @min_budget == "" && @max_budget == ""
      @projects = Project.paginate(:page => params[:page],:per_page => 4).where(:close=>nil, :status => nil).order('created_at DESC')
    else
      @projects = Project.paginate(:page => params[:page],:per_page => 4).where(:close=>nil, :status => nil)
      if @skills != nil
        @skills_text = @skills
        @skills = @skills.split(',')
        puts @skills.inspect
        @projects = @projects.includes(:skills).where('skills.name IN (?)',@skills).references(:skills)
      end
      if @search_keyword != nil
        @projects = @projects.where("title LIKE ?","%#{@search_keyword}%")
        puts @project.inspect
      end
      if @min_range != nil
        @projects = @projects.where("min_budget >= ?",@min_range)
        puts @project.inspect
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

  def payment_details

  end

  def pending_project

  end

  def pending_projects

  end

  def history
  end

  def my_status

  end
end
