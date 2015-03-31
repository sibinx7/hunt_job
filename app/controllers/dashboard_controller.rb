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
end
