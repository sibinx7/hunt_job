class AdminDashboardController < ApplicationController
  layout 'admin_dashboard'
  def index

  end

  def projects
    @projects = Project.paginate(:page=>params[:page],:per_page=>2)
  end
end
