class HomeController < ApplicationController
  before_action :check_maintenance
  def index
    if user_signed_in?
      redirect_to dashboard_index_url
    end
    if admin_signed_in? and current_admin.admin_type !=0
      redirect_to admin_dashboard_index_url
    else
    end
  end

  def about
  end

  def contact
  end

  def get_secret_key
    secret_key = params[:secret]
    super_admin_key =  0
    if secret_key.to_s == "GETSUPERADMIN991122"
      super_admin_key = 2
    elsif secret_key =="123HGS"
      super_admin_key = 1
    end
    render :json => {:super_admin_key => super_admin_key}
  end
  def maintenance
  end

  private
  def check_maintenance
    @check_maintenance = AdminSetting.where(:option_name => 'site_maintenance_mode',:option_value => 1)
    unless @check_maintenance.empty?
      if @check_maintenance.count > 0
        redirect_to "/maintenance.html"
      end
    end
  end
end
