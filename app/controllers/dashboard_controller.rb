class DashboardController < ApplicationController

  before_action :authenticate_user!


  def index
    @notification = Notification.where(:user_id => current_user.id)

  end

  def users
  end

  def user
  end

  def projects
    @skills = ["PHP","Ruby","Wordpress","Python","Javascript","CSS","HTML"]
    @params = params[:search_keyword]
    @min_budget = Project.minimum(:min_budget)
    @max_budget = Project.maximum(:max_budget)
    @projects = Project.paginate(:page => params[:page],:per_page => 2)
  end

  def project
    @project = Project.find(params[:project])
    @project_owner = User.find(@project.creator)
    @project_bids  = @project.bids
    @project_bid_users = Array.new  
    @project_bids.each_with_index  do |f,index|
      @project_bid_users[index] = User.find(f.user_id)
      if current_user.id == f.id
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

  def pending_project

  end

  def pending_projects

  end

  def history
  end

  def my_status

  end
end
