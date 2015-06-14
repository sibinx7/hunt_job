class AdminSettingsController < ApplicationController

  def change_maintenance_mode
    maintenance_status = params[:status]
    checkAdminSettings = AdminSetting.where(:option_name => 'site_maintenance_mode')
    unless checkAdminSettings.exists?
      @admin_settings = AdminSetting.new
      @admin_settings.option_name = "site_maintenance_mode"
      @admin_settings.option_value = maintenance_status.to_i == 1? 0 : 1
      status_message(@admin_settings.save,maintenance_status)
    else
      @update_admin_settings = AdminSetting.find_by_option_name("site_maintenance_mode")
      @update_admin_settings.option_value = maintenance_status.to_i == 1? 0 : 1
      status_message(@update_admin_settings.save,maintenance_status)
    end
    puts maintenance_status.inspect
  end

  private
  def status_message(save_status,current_status)
    if save_status
      render :json => {"status"=> "success","message"=> (current_status.to_i == 1? "Maintenance Mode OFF":" Maintenance Mode ON"),"value"=> (current_status.to_i == 1? 0 : 1)}
    else
      render :js => {"status"=>"faile","message"=>"Unknown error occured"}
    end
  end
  def admin_settings_params
    params.require(:admin_settings).permit(:id,:created_at,:updated_at,:site_maintenance)
  end
end