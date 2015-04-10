class DashboardController < ApplicationController

  before_action :authenticate_user!


  def index
    puts "I am on Dashobard"
  end

  def users
  end

  def user
  end

  def projects
    @skills = ["PHP","Ruby","Wordpress","Python","Javascript","CSS","HTML"]
    @params = params[:search_keyword]
    respond_to do |format|
      format.html { }
      format.js {}
    end
  end

  def project
  end

  def settings
  end

  def bids
  end

  def bid
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
