class AddSiteMaintanceInAdminSettings < ActiveRecord::Migration
  def change
    add_column :admin_settings, :option_name ,:string
    add_column :admin_settings, :option_value, :integer
  end
end
