class AddColumnUserLostMoneyInUserProjectDetails < ActiveRecord::Migration
  def change
    add_column :user_project_details, :user_lost_money ,:integer
  end
end
