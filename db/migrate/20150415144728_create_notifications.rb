class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :content
      t.string :not_type
      t.integer :user_id
      t.integer :project_id
      t.integer :related_task
      t.string :link
      t.timestamps
    end
  end
end
