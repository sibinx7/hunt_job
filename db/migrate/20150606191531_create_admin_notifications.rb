class CreateAdminNotifications < ActiveRecord::Migration
  def change
    create_table :admin_notifications do |t|
      t.integer :user_id
      t.text :message
      t.integer :project_id
      t.string :category
      t.integer :admin_id 
      t.timestamps
    end
  end
end
